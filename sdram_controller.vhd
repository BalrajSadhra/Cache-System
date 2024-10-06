library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity sdram is
  port
  (
    clk      : in std_logic;
    addr     : in std_logic_vector(15 downto 0);
    wr_rd      : in std_logic;
    mstrb  : in std_logic;
    din  : in std_logic_vector(7 downto 0);
    dout : out std_logic_vector(7 downto 0)
  );
end sdram;

architecture Behavioural of sdram is
  type sdramMemArr is array (7 downto 0, 31 downto 0) of std_logic_vector(7 downto 0);
  signal sdramMemIn      : sdramMemArr;
  signal index       : integer := to_integer(unsigned(addr(7 downto 5)));
  signal offset      : integer := to_integer(unsigned(addr(4 downto 0)));
  signal clean : integer := 0;

begin
  process (clk)
  begin
    if (clk'event and clk = '1') then
		if (clean = 0) then
        for i in 0 to 7 loop
			 for j in 0 to 31 loop
		      sdramMemIn(i, j) <= "00000000";
			end loop;
		  end loop;
        clean <= 1;
      end if;

      if (mstrb = '1') then
        if (wr_rd = '1') then
          sdramMemIn(index, offset) <= din;
        else
          dout <= sdramMemIn(index, offset);
        end if;
      end if;
    end if;
  end process;
end Behavioural;