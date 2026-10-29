--16 to 32 bit extender

library IEEE;
use IEEE.std_logic_1164.all;

entity extender_16t32 is 
    port (
        ivalue : in std_logic_vector(15 downto 0);
        ovalue : out std_logic_vector(31 downto 0);
        isignExtension : in std_logic 
    );
end extender_16t32;

architecture behavioral of extender_16t32 is
begin
    process(ivalue, isignExtension)
    begin
        if isignExtension = '1' then
            ovalue <= (ivalue(15) & ivalue(15) & ivalue(15) & ivalue(15) & 
                        ivalue(15) & ivalue(15) & ivalue(15) & ivalue(15) &
                        ivalue(15) & ivalue(15) & ivalue(15) & ivalue(15) &
                        ivalue(15) & ivalue(15) & ivalue(15) & ivalue(15)) & ivalue;
        else
            ovalue <= (x"0000" & ivalue); -- Zero extension
        end if;
    end process;
end behavioral;

