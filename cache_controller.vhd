library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity cacheController is
  port
  (
    clk  : in std_logic;
    rst  : in std_logic;
    trig : in std_logic;
	 osdramAddr : out std_logic_vector(15 downto 0);
	 osramAddr :  out std_logic_vector(7 downto 0);
	 osramWEN : out std_logic;
	 osdramWrRd : out std_logic;
	 oRDY			: out std_logic;
    MSTRB    : out std_logic;
    currentVbit        : out std_logic;
    currentDbit        : out std_logic
  );
end cacheController;

architecture Behavioural of cacheController is
  -- CPU signals
  signal cpuDOUT, cpuDIN : std_logic_vector(7 downto 0);
  signal cpuAddr       : std_logic_vector(15 downto 0);
  signal cpuWrRd, cpuCS   : std_logic;
  signal cpuRDY           : std_logic := '1';
  signal tag               : std_logic_vector(7 downto 0);
  signal index             : std_logic_vector(2 downto 0);
  signal offset            : std_logic_vector(4 downto 0);
  
  -- Cache/SRAM signals
  type cacheMemoryArr is array (7 downto 0, 9 downto 0) of std_logic;
  signal cacheMemory                        : cacheMemoryArr := (others => (others => '0'));
  signal sramDIN   : std_logic_vector(7 downto 0);
  signal sramDOUT  : std_logic_vector(7 downto 0);
  signal cacheAddr : std_logic_vector(7 downto 0);
  signal cacheWrRd                            : std_logic;
  signal addressTag                             : std_logic_vector(7 downto 0);
  signal hitMiss                             : std_logic;
  
  -- SDRAM signals
  signal sdramDIN : std_logic_vector(7 downto 0);
  signal sdramDOUT : std_logic_vector(7 downto 0);
  signal sdramAddr         : std_logic_vector(15 downto 0);
  signal sdramWrRd           : std_logic;
  signal sdramMSTRB           : std_logic;
  signal sdramCounter         : integer := 0;
  signal wIncrement         : integer := 0;
  
  -- State signals
  signal state      : std_logic_vector(2 downto 0) := "000";
  
  component cpu_gen is
    port
    (
      clk  : in std_logic;
      rst  : in std_logic;
      trig : in std_logic;
      address : out std_logic_vector(15 downto 0);
      dout    : out std_logic_vector(7 downto 0);
      wr_rd     : out std_logic;
      cs      : out std_logic
    );
  end component;
  
  component sram is
    port
    (
      clk  : in std_logic;
      din  : in std_logic_vector(7 downto 0);
      dout : out std_logic_vector(7 downto 0);
      addr : in std_logic_vector(7 downto 0);
      wen  : in std_logic
    );
  end component;
  
  component sdram is
    port
    (
      clk   : in std_logic;
      din   : in std_logic_vector(7 downto 0);
      dout  : out std_logic_vector(7 downto 0);
      addr  : in std_logic_vector(15 downto 0);
      wr_rd : in std_logic;
      mstrb : in std_logic
    );
  end component;
  
begin
  cpu : cpu_gen
  port map
  (
    clk  => clk,
    rst  => rst,
    trig => trig,
    address => cpuAddr,
    dout    => cpuDOUT,
    wr_rd     => cpuWrRd,
    cs      => cpuCS
  );
  
  sramM : sram 
  PORT map (
    clk 	  => clk,
    din      => sramDIN,
    dout     => sramDOUT,
    addr     => cacheAddr,
    wen      => cacheWrRd
  );
  
  sdramM : sdram 
  PORT map (
    clk => clk,
    din      => sdramDIN,
    dout     => sdramDOUT,
    addr     => sdramAddr,
    wr_rd    => sdramWrRd,
    mstrb    => sdramMSTRB
  );
  
  process (clk, cpuCS)
  begin
    tag    <= cpuAddr(15 downto 8);
    index  <= cpuAddr(7 downto 5);
    offset <= cpuAddr(4 downto 0);
	 
	 -- TTTTTTTTDV Reading from Right to Left
    for i in 0 to 7 loop
      addressTag(i) <= cacheMemory(to_integer(unsigned(index)), (i+2));
    end loop;
  
    -- Check if tag address table matches tag coming from cpu
    if (addressTag = tag) then
      hitMiss <= '1';
    else
      hitMiss <= '0';
    end if;
  
    -- FSM
    -- S0 - Idle state
    if (state = "000") then
      if (cpuCS = '1') then
        -- Checks if Hit and Valid Bit = 1
        if (hitMiss = '1' and cacheMemory(to_integer(unsigned(index)), 0) = '1') then
          state <= "001"; -- Go to Hit State
        else
          state <= "010"; -- Go to Miss State
        end if;
      else
        state <= "000";
      end if;
    elsif (state = "001") then
      -- S1 - Hit State - Read or Write
      cpuRDY    				 <= '0';
      cacheAddr(7 downto 5) <= index;
      cacheAddr(4 downto 0) <= offset;
      if (cpuWrRd = '0') then
        -- Read from cache if cpuWrRd = 0
        cacheWrRd <= '0'; -- Set cacheWrRd to 0
        cpuDIN <= sramDOUT;
      else
        -- Write to cache if cpuWrRd = 1
		  cacheWrRd                                   <= '1'; -- Set cacheWrRd to 1
        sramDIN                                     <= cpuDOUT; -- Set sramDIN to cpuDOUT
        cacheMemory(to_integer(unsigned(index)), 1) <= '1'; -- Set dirty bit in address table to 1 because modified
      end if;
      cpuRDY    <= '1'; -- Head back to Idle State
      state <= "000";
		
    elsif (state = "010") then
	   -- S2 - Miss State - Check if Dirty Bit = 1
      -- If Dirty Bit = 1 then go to state 3
      if (cacheMemory(to_integer(unsigned(index)), 1) = '1') then -- TTTTTTTTDV
        state <= "011"; -- If Dirty Bit = 1 then go to write back to sdram state
      else
        state <= "100"; -- If Dirty Bit = 0 then go to Block Replacement State
      end if;
		
    elsif (state = "011") then
      -- S3 - Write back to SDRAM
      sdramAddr(15 downto 5) <= cpuAddr(15 downto 5); -- Tag and Index
      cacheAddr(7 downto 5)  <= cpuAddr(7 downto 5); -- Index
      cacheWrRd                  <= '0'; -- Writing to SDRAM
      sdramAddr(4 downto 0)  <= "00000"; -- Clearing the Block Offset
      cacheAddr(4 downto 0)  <= "00000"; -- Clearing the Block Offset
      sdramWrRd                <= '1';   
  
      if (sdramCounter /= 64) then        -- sdramCounter counts up to 64, has to write to SDRAM every other clock cycle.
        if ((sdramCounter mod 2) = 0) then -- And one whole block of SDRAM is 32 bytes. 
          sdramMSTRB <= '0';
        else
          sdramMSTRB <= '1';
        end if;
        cacheWrRd             <= '0';
        sdramDIN              <= sramDOUT; -- Write to SDRAM
        sdramAddr(4 downto 0) <= std_logic_vector(to_unsigned(wIncrement, 5)); -- Increase the block offset of SDRAM
        cacheAddr(4 downto 0) <= std_logic_vector(to_unsigned(wIncrement, 5)); -- Increase the block offset of SDRAM
		  wIncrement            <= wIncrement + 1; 
      else
        sdramCounter <= 0; 
        wIncrement <= 0;
      end if;
      state <= "100"; -- Go to Read from SDRAM State
		
    elsif (state = "100") then
      cpuRDY    						<= '0';
      sdramAddr(15 downto 5) <= cpuAddr(15 downto 5);
      cacheAddr(7 downto 5)  <= cpuAddr(7 downto 5);
      cacheWrRd                  <= '1';
		sdramWrRd                  <= '0'; -- This
      sdramAddr(4 downto 0)  <= "00000";
      cacheAddr(4 downto 0)  <= "00000";
  
      if (sdramCounter /= 64) then     -- Similar to state 3 but we are instead reading from SDRAM
        if ((sdramCounter mod 2) = 0) then -- and writing to SRAM
          sdramMSTRB <= '0';
        else
          sdramMSTRB               <= '1';
          sdramWrRd               <= '0';
          sdramAddr(4 downto 0) <= std_logic_vector(to_unsigned(wIncrement, 5));
          cacheWrRd                 <= '1';
          cacheAddr(4 downto 0) <= std_logic_vector(to_unsigned(wIncrement, 5));
          sramDIN                 <= sdramDOUT;
          cpuDIN 						<= sramDIN;
          wIncrement             <= wIncrement + 1;
        end if;
        sdramCounter <= sdramCounter + 1;
      else
        sdramCounter <= 0;
        wIncrement <= 0;
      end if;
      for i in 0 to 7 loop -- Update the tag in the table
        cacheMemory(to_integer(unsigned(index)), i+2) <= tag(i);
      end loop;
      cacheMemory(to_integer(unsigned(index)), 1) <= '0'; -- Set Dirty Bit to 0
      cacheMemory(to_integer(unsigned(index)), 0) <= '1'; -- Set Valid Bit to 1
      cacheWrRd                                   <= '0';
      state                                       <= "001"; -- Continue to Hit State
    else
      cpuRDY    <= '1';
      state <= "000"; -- Back to Idle
    end if;
  end process;
  
  osdramAddr  <= sdramAddr;
  osramAddr   <= cacheAddr;
  osramWEN    <= cacheWrRd;
  osdramWrRd  <= sdramWrRd;
  oRDY		  <= cpuRDY;
  MSTRB 		  <= sdramMSTRB;
  
  currentVbit   <= cacheMemory(to_integer(unsigned(index)), 0); 
  currentDbit   <= cacheMemory(to_integer(unsigned(index)), 1); 
end Behavioural;
