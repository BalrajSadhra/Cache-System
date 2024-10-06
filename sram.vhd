library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity sram is
  port
  (
    clk      : in std_logic;
    wen      : in std_logic;
    addr     : in std_logic_vector(7 downto 0);
    din  : in std_logic_vector(7 downto 0);
    dout : out std_logic_vector(7 downto 0)
  );
end sram;

architecture Behavioural of sram is

  type sramMemArr is array (7 downto 0, 31 downto 0) of std_logic_vector(7 downto 0);
  signal sramMemIn : sramMemArr;
  signal index  : integer := to_integer(unsigned(addr(7 downto 5)));
  signal offset : integer := to_integer(unsigned(addr(4 downto 0)));
  signal clean : integer := 0; --

begin
  process (clk)
  begin

    if (clk'event and clk = '1') then
         if (clean = 0) then
        for i in 0 to 7 loop
             for j in 0 to 31 loop
              sramMemIn(i, j) <= "00000000";
            end loop;
          end loop;
        clean <= 1;
      end if;

      if (wen = '1') then
        sramMemIn(index, offset) <= din;
      end if;
        dout <= sramMemIn(index, offset);
    end if;
  end process;
end Behavioural;