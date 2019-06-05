-------------------------------------------------------------------------------
-- Title      : vhpi test
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_math.vhd
-- Author     : Christoph Viehboeck  <christophv071@gmail.com>
-- Company    : 
-- Created    : 2019-05-14
-- Last update: 2019-06-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: testing vhpi interface in ghdl
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-14  1.0      christoph       Created
-------------------------------------------------------------------------------

library work;
use work.math.all;

library std;
use std.textio.all;

entity tb_math is

end entity tb_math;

architecture bhv of tb_math is

  constant pi        : real := 3.1415;
  constant increment : real := 0.01;
  signal input       : real := 0.0;
  signal result      : real := 0.0;

begin  -- architecture bhv

  test : process is
    variable l : line;

  begin  -- process test

    wait for 10 ns;
    while input < (pi + pi) loop
      input  <= input + increment;
      wait for 1 ns;
      -- write (l, string'("Calling C-Function!"));
      -- writeline (output, l);
      result <= sin(input);
      write (l, input);
      write(l, string'(" = "));
      write(l, result);
      writeline (output, l);
      wait for 10 ns;
    end loop;  -- i
    wait;
  end process test;

end architecture bhv;
