-------------------------------------------------------------------------------
-- Title      : simple logic
-- Project    : 
-------------------------------------------------------------------------------
-- File       : simple_logic-e.vhd
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

library ieee;
use ieee.std_logic_1164.all;

entity simple_logic is
  
  port (
    a : in  std_ulogic;
    b : in  std_ulogic;
    c : out std_ulogic);

end entity simple_logic;
