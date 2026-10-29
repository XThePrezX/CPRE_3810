--Behavior describes the functionality of a system without specifying the exact hardware --structure or data flow. It focuses on what the design does rather than how it does it

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HazardDetection_StallsOnly is
    Port ( PC_reg_Enable : out std_logic;
	   checkforBranch : in std_logic;
	   PrSRCInput : in std_logic;
	   mem_write : in std_logic;
	   noOPLoopIn : in std_logic;
	   noOPLoopOut : out std_logic;
	   IF_rs1 : in std_logic_vector(4 downto 0);
 	   IF_rs2 : in std_logic_vector(4 downto 0);
 	   ID_RegWrite : in std_logic;
 	   ID_rd : in std_logic_vector(4 downto 0);
 	   EX_RegWrite : in std_logic;
 	   EX_rd : in std_logic_vector(4 downto 0);
 	   MEM_rd : in std_logic_vector(4 downto 0); --prob not going to be used but just in case
           o_Stall : out std_logic_vector(3 downto 0);
           o_Flush : out std_logic_vector(3 downto 0));
end HazardDetection_StallsOnly;

architecture Structural of HazardDetection_StallsOnly is

  signal i_Stall : std_logic_vector(3 downto 0); --0th bit is IF/ID register, rightmost bit is the MEM/WB registor
  signal i_Flush : std_logic_vector(3 downto 0); --0th bit is IF/ID register, rightmost bit is the MEM/WB registor

begin
    
  	i_Flush <= "0011" when (checkforBranch = '1') else
          "0010" when (((IF_rs1 = ID_rd) or (IF_rs2 = ID_rd)) and (ID_RegWrite = '1')) else
          "0010" when (((IF_rs1 = EX_rd) or (IF_rs2 = EX_rd)) and (EX_RegWrite = '1')) else
          "0010" when (((IF_rs1 = MEM_rd) or (IF_rs2 = MEM_rd)) and (mem_write = '1')) else
          "0000";

  	PC_reg_Enable <= '1' when (checkforBranch = '1') else
          '0' when (((IF_rs1 = ID_rd) or (IF_rs2 = ID_rd)) and (ID_RegWrite = '1')) else
          '0' when (((IF_rs1 = EX_rd) or (IF_rs2 = EX_rd)) and (EX_RegWrite = '1')) else
          '0' when (((IF_rs1 = MEM_rd) or (IF_rs2 = MEM_rd)) and (mem_write = '1')) else
          '1';

  	noOPLoopOut <= '0' when (checkforBranch = '1') else
          '1' when (((IF_rs1 = ID_rd) or (IF_rs2 = ID_rd)) and (ID_RegWrite = '1')) else
          '1' when (((IF_rs1 = EX_rd) or (IF_rs2 = EX_rd)) and (EX_RegWrite = '1')) else
          '1' when (((IF_rs1 = MEM_rd) or (IF_rs2 = MEM_rd)) and (mem_write = '1')) else
          '0';

  	i_Stall <= "0001" when (((IF_rs1 = ID_rd) or (IF_rs2 = ID_rd)) and (ID_RegWrite = '1')) else
          "0001" when (((IF_rs1 = EX_rd) or (IF_rs2 = EX_rd)) and (EX_RegWrite = '1')) else
          "0001" when (((IF_rs1 = MEM_rd) or (IF_rs2 = MEM_rd)) and (mem_write = '1')) else
          "0000";



  --process(IF_rs1, IF_rs2, ID_rd, ID_RegWrite, EX_rd, EX_RegWrite, mem_write, noOPLoopIn, MEM_rd, checkforBranch, PrSRCInput)

    --begin

        --if (checkforBranch = '1') then 

		--i_Flush <= "0011";
		--PC_reg_Enable <= '1';
		--noOPLoopOut <= '0';

	

        --elsif (((IF_rs1 = ID_rd) or (IF_rs2 = ID_rd)) and (ID_RegWrite = '1')) then --IF_rd --and (IF_rs1 /= "00000")

		--i_Stall <= "0001";
		--i_Flush <= "0010";
		--PC_reg_Enable <= '0';
		--noOPLoopOut <= '1';

        --elsif (((IF_rs1 = EX_rd) or (IF_rs2 = EX_rd)) and (EX_RegWrite = '1')) then --EX_rd --and (IF_rs1 /= "00000")

		--i_Stall <= "0001";
		--i_Flush <= "0010";
		--PC_reg_Enable <= '0';
		--noOPLoopOut <= '1';
		
		

       --elsif (((IF_rs1 = MEM_rd) or (IF_rs2 = MEM_rd)) and (mem_write = '1')) then --Memory_RD --and (IF_rs1 /= "00000")

		--i_Stall <= "0001";
		--i_Flush <= "0010";
		--PC_reg_Enable <= '0';
		--noOPLoopOut <= '1';

	

        --else

		--i_Stall <= "0000";
		--i_Flush <= "0000";
		--noOPLoopOut <= '0';
		--PC_reg_Enable <= '1';

	

        --end if;

    --end process;


o_Stall <= i_Stall;
o_Flush <= i_Flush;


end Structural;

