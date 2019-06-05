library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_and_2 is
end entity;

architecture bhv of tb_and_2 is

  component and_2
    port(a, b : in  std_logic;
         c    : out std_logic);
  end component;

  signal sa, sb, sc : std_logic;

begin

  a : and_2 port map(a => sa, b => sb, c => sc);

  sa <= '0' after 0 ns,
        '1' after 30 ns,
        '0' after 60 ns,
        '1' after 90 ns;

  sb <= '0' after 0 ns,
        '1' after 15 ns,
        '0' after 30 ns,
        '1' after 45 ns,
        '0' after 60 ns,
        '1' after 75 ns,
        '0' after 90 ns;

  finish : process is
  begin  -- process end
    wait for 100 ns;
    assert (false) report "End of simulation, this is not a error!" severity failure;
  end process finish;


end bhv;
