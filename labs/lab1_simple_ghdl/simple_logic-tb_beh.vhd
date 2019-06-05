-------------------------------------------------------------------------------
-- Title      : Testbench architecture for design "simple_logic"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : simple_logic-tb_beh.vhd
-- Author     : Christoph Viehboeck  <christophv071@gmail.com>
-- Company    : 
-- Created    : 2019-05-06
-- Last update: 2019-06-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-06  1.0      christoph       Created
-------------------------------------------------------------------------------

architecture beh of simple_logic_tb is

  -- component ports
  signal a : std_ulogic := '0';
  signal b : std_ulogic := '0';
  signal c : std_ulogic;

  -- clock
  signal Clk      : std_ulogic := '1';
  signal finished : std_ulogic := '0';

  component simple_logic is
    port (
      a : in  std_ulogic;
      b : in  std_ulogic;
      c : out std_ulogic);
  end component simple_logic;
  
begin  -- architecture beh

  -- component instantiation
  DUT : simple_logic
    port map (
      a => a,
      b => b,
      c => c);

  -- clock generation
  Clk <= not Clk after 10 ns when finished = '0' else '1';

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    a <= not(a) after 1 ns;
    b <= not(b) after 5 ns;

    wait until Clk = '1';
  end process WaveGen_Proc;

  Finish_Sim : process
  begin
    finished <= '1' after 100 ns;
    wait;
  end process Finish_Sim;

end architecture beh;

------------------------------------------------------------------------------------------------------------------------------------------------------
