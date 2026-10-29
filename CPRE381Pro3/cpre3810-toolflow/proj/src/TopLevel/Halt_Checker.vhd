library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Halt_Detector is
    port (
        opcode : in  std_logic_vector(6 downto 0);
        funct7 : in  std_logic_vector(6 downto 0);
        halt   : out std_logic
    );
end entity Halt_Detector;


architecture structural of Halt_Detector is
begin

    --Halt when opcode = 1110011 AND funct7 = 0001000
    halt <= '1' when (opcode = "1110011" and funct7 = "0001000") else
            '0';

end architecture structural;