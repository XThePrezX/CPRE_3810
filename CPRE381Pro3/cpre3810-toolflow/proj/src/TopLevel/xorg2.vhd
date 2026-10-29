-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- xorg2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input XOR 
-- gate.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 1/16/19 by H3::Changed name to avoid name conflict with Quartus 
--         primitives.
-------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xorg2 is
    port(
        i_A : in  std_logic;
        i_B : in  std_logic;
        o_F : out std_logic
    );
end xorg2;

architecture structural of xorg2 is
begin

    o_F <= '1' when ( (i_A = '1' and i_B = '0') or
                      (i_A = '0' and i_B = '1') ) else
           '0';

end structural;

