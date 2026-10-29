library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Halt_Detector is
    port (
        opcode : in  std_logic_vector(6 downto 0);
        funct7 : in  std_logic_vector(6 downto 0);
        halt   : out std_logic
    );
end entity Halt_Detector;


architecture Behavioral of Halt_Detector is
begin

    halt <= '1'
        when (opcode = "1110011" and funct7 = "0001000")
        else '0';

end architecture Behavioral;
