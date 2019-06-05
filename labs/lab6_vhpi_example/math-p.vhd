-------------------------------------------------------------------------------
-- Title      : vhpi test
-- Project    : 
-------------------------------------------------------------------------------
-- File       : math-p.vhd
-- Author     : Christoph Viehboeck  <christophv071@gmail.com>
-- Company    : 
-- Created    : 2019-05-14
-- Last update: 2019-05-14
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: package for vhpi test
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-14  1.0      christoph       Created
-------------------------------------------------------------------------------

package math is
  function sin (v          : real) return real;
  attribute foreign of sin : function is "VHPIDIRECT sin";
end math;

package body math is
  function sin (v : real) return real is
  begin
    assert false severity failure;
  end sin;
end math;

