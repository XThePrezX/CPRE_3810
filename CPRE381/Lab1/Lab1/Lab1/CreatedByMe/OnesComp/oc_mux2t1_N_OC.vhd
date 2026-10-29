-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- oc_mux2t1_N_OC.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 1/6/20 by H3::Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity oc_mux2t1_N_OC is

  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_D0         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end oc_mux2t1_N_OC;

architecture structural of oc_mux2t1_N_OC is

  component invg is
    port(i_A          : in std_logic;
         o_F          : out std_logic);
  end component;

  begin

  -- Instantiate N mux instances.
  G_NBit_MUX: for i in 0 to N-1 generate

    NOT1: invg port map(
	i_A => i_D0(i), 
	o_F => o_O(i));

  end generate G_NBit_MUX;

  
end structural;
