library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity extender_1to32 is
    port(
        ivalue : in  STD_LOGIC;
        ovalue : out STD_LOGIC_VECTOR(31 downto 0)
    );
end extender_1to32;

architecture structural of extender_1to32 is
begin

    ovalue <= (31 downto 1 => '0') & ivalue;

end structural;
