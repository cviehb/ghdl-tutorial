-------------------------------------------------------------------------------
-- Title      : simple logic
-- Project    : 
-------------------------------------------------------------------------------
-- File       : simple_logic-rtl-a.vhd
-- Author     : Christoph Viehboeck  <christophv071@gmail.com>
-- Company    : 
-- Created    : 2019-05-06
-- Last update: 2019-05-06
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: simple logic demonstrating ghdl
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-06  1.0      christoph	Created
-------------------------------------------------------------------------------

architecture rtl of simple_logic is

begin  -- architecture rtl

  -- wow a nand
  c <= b nand a;

end architecture rtl;
