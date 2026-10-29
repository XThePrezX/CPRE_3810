-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- dffg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an edge-triggered
-- flip-flop with parallel access and reset.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 11/25/19 by H3:Changed name to avoid name conflict with Quartus
--          primitives.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity dffg_N is
  generic(
    N : integer := 32
  );
  port(i_CLK        : in std_logic; --Clock input
       i_RST        : in std_logic; --Reset input
       i_WE         : in std_logic; --Write enable input (Stall)
       i_Flush         : in std_logic; --Write enable input (Flush)
       i_D          : in std_logic_vector(N-1 downto 0); --Data value input
       o_Q          : out std_logic_vector(N-1 downto 0)); --Data value output

end dffg_N;


architecture mixed of dffg_N is
  signal s_Q : std_logic_vector(N-1 downto 0);--register storage
begin

  --Output is always the stored value
  o_Q <= s_Q;

  process(i_CLK, i_RST)

    begin
        if i_RST = '1' then

            s_Q <= (others => '0');

        elsif rising_edge(i_CLK) then

            if i_Flush = '1' then

                s_Q <= (others => '0');

            elsif i_WE = '0' then

                s_Q <= i_D;

            end if;
        end if;
    end process;

end mixed;
