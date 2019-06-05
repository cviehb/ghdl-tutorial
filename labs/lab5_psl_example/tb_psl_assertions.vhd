-------------------------------------------------------------------------------
-- Title      : PSL Assertion Test
-- Project    : AMV Uebung9
-------------------------------------------------------------------------------
-- File       : tb_psl_assertions.vhd
-- Author     : Christoph Viehboeck  <s18105657023@students.fh-hagenberg.com>
-- Company    : FH Hagenberg
-- Created    : 2019-05-09
-- Last update: 2019-06-03
-- Platform   : -
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Test of the PSL Assertions
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-09  1.0      christoph       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_bus_arbiter is

end entity tb_bus_arbiter;

architecture bhv of tb_bus_arbiter is

  -- used signals needed on the bus spec
  signal clk        : std_ulogic := '0';
  signal request    : std_ulogic := '0';
  signal grant      : std_ulogic := '0';
  signal data_valid : std_ulogic := '0';
  signal done       : std_ulogic := '0';
  signal abrt       : std_ulogic := '0';

  type master_state is (IDLE, START, DATA);
  type arbiter_state is (IDLE, REQ, DATA);
  type bool is (true, false);

  type cycle_delay is array (0 to 2) of natural;

  constant master_data_valid_cycle : cycle_delay := (8, 16, 32);

  signal dbg_master_state  : master_state;
  signal dbg_arbiter_state : arbiter_state;

begin  -- architecture bhv

  -- TODO: PSL Assertions here
  -- set the default clock for all psl statements
  -- psl default clock is (clk'event and clk ='1');
  -- after request has started arbiter has to answer if bus is free
  -- nopsl assert always ((request='1') -> next_e[1 to 5]((abrt = '1' and grant = '0') or (abrt = '0' and grant = '1')));
  -- psl assert always ((request='1') -> {{(abrt='0' and grant='0')[+]}; abrt='1' or grant='1'});
  -- only exact 8, 16 or 32 wait cycles allowed
  -- psl assert always({grant='1'} |=> {{(data_valid='1')[*8]} | {(data_valid='1')[*16]} | {(data_valid='1')[*32]}; done='1'});
  -- after grant is raised for max 1 cycle, done has to be raised before next grant
  -- psl assert always({grant='1'} |=> {grant='0'[+]; done='1'});
  -- request also 1 cycle high till done or abort
  -- psl assert always({request='1'} |=> {request='0'[+]; done='1' or abrt='1'});

  -- generate clock and toggle
  clk <= not(clk) after 10 ns;

  -- purpose: busarbiter impl
  -- type   : sequential
  -- inputs : clk, request, grant, abrt, done, data_valid
  -- outputs: request, grant
  bus_arbiter : process (clk) is
    variable state        : arbiter_state        := IDLE;
    variable bus_free     : bool                 := true;
    variable wait_cycles  : unsigned(1 downto 0) := (others => '0');
    variable local_cycles : unsigned(1 downto 0) := (others => '0');
  begin  -- process bus_master
    if (clk'event and clk = '1') then   -- rising clock edge
      abrt  <= '0';
      grant <= '0';

      -- wait till request comes from a busmaster
      case state is
        when IDLE =>
          if (request = '1') then
            state := REQ;
          end if;

          -- check if bus if free and signal to master
        when REQ =>
          if (bus_free = true) then
            if (wait_cycles = local_cycles) then
              local_cycles := (others => '0');
              grant        <= '1';
              state        := DATA;
              bus_free     := false;
            else
              wait_cycles := wait_cycles + 1;
            end if;
          else
            bus_free := true;
            abrt     <= '1';
            state    := IDLE;
          end if;

          -- wait till data is transmitted
        when DATA =>
          if (done = '1') then
            state := IDLE;
          end if;
      end case;

      dbg_arbiter_state <= state;
    end if;
  end process bus_arbiter;

  -- purpose: busmaster impl
  -- type   : sequential
  -- inputs : clk, grant, data_valid
  -- outputs: request, grant, abrt, done
  bus_master : process (clk) is
    variable state          : master_state := IDLE;
    variable data_clk_count : natural      := 0;
    variable actual_cycle   : integer      := 0;
  begin  -- process bus_master
    if (clk'event and clk = '1') then   -- rising clock edge
      done <= '0';

      case state is
        when IDLE =>
          request    <= '1';
          data_valid <= '0';
          state      := START;

        when START =>
          request    <= '0';
          data_valid <= '0';

          if (grant = '1') then
            state      := DATA;
            data_valid <= '1';
          elsif (abrt = '1') then
            state := IDLE;
          end if;

        when DATA =>
          request    <= '0';
          data_valid <= '1';

          if (data_clk_count = (master_data_valid_cycle(actual_cycle) - 1)) then
            data_clk_count := 0;
            done           <= '1';
            state          := IDLE;
            data_valid     <= '0';

            if actual_cycle = 2 then
              actual_cycle := 0;
            else
              actual_cycle := actual_cycle + 1;
            end if;
          else
            data_clk_count := data_clk_count + 1;
          end if;

      end case;

      dbg_master_state <= state;
    end if;
  end process bus_master;

end architecture bhv;
