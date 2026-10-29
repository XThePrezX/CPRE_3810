library IEEE;
use IEEE.std_logic_1164.all;

--extend type for I "000"


entity extender_12t32 is
  port(
    ivalue : in  std_logic_vector(31 downto 0);  
    immType : in  std_logic_vector(2 downto 0);  
    ovalue : out std_logic_vector(31 downto 0)   --sign-extended
  );
end extender_12t32;

architecture dataflow of extender_12t32 is
begin



    ovalue <= (31 downto 12 => ivalue(31)) & ivalue(31 downto 20) when ivalue(6 downto 0) = "0010011" else --I
             (31 downto 20 => ivalue(31)) & ivalue(19 downto 12) & ivalue(20) & ivalue(30 downto 21) & '0' when ivalue(6 downto 0) = "1101111" else --UJ
	     (31 downto 12 => ivalue(31)) & ivalue(31 downto 20) when ivalue(6 downto 0) = "1100111" else --I (for jalr)
	     (31 downto 12 => ivalue(31)) & ivalue(31 downto 20) when ivalue(6 downto 0) = "0000011" else --I (for LW)
             ivalue(31 downto 12) & x"000" when ivalue(6 downto 0) = "0110111" else --LUI
             ivalue(31 downto 12) & x"000" when ivalue(6 downto 0) = "0010111" else --AUIPC
             (31 downto 13 => ivalue(31)) & ivalue(31) & ivalue(7) & ivalue(30 downto 25) & ivalue(11 downto 8) & '0' when ivalue(6 downto 0) = "1100011" else --Branch 
             (31 downto 12 => ivalue(31)) & ivalue(31 downto 25) & ivalue(11 downto 7) when ivalue(6 downto 0) = "0100011"; --SW (it's split into two fields?)



end dataflow;

