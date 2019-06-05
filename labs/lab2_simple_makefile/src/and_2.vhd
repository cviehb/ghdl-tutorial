library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_2 is
  port (a, b : in  std_logic;
        c    : out std_logic);
end entity;

architecture bhv of and_2 is

begin
  c <= a and b;
end bhv;
