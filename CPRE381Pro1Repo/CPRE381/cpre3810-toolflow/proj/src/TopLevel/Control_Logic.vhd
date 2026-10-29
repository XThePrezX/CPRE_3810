--Behavior describes the functionality of a system without specifying the exact hardware --structure or data flow. It focuses on what the design does rather than how it does it

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Logic is
    Port ( Opcode : in std_logic_vector(6 downto 0);
 	   funct7 : in std_logic_vector(6 downto 0);
 	   funct3 : in std_logic_vector(2 downto 0);
           Branch : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           ALUControl : out std_logic_vector(3 downto 0);
           ImmType : out std_logic_vector(2 downto 0);
           ResultSrc : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           PCSrc : out STD_LOGIC; -- if 0 do normal, if 1 branch
           RegDst : out STD_LOGIC;
           Halt : out STD_LOGIC;
           WritePCORResultSrc : out STD_LOGIC;
           ALUOutORPC : out STD_LOGIC;
           PCAddress : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           zeroInputForAlu : out STD_LOGIC);
end Control_Logic;

architecture Behavioral of Control_Logic is
begin
    process (Opcode, funct7, funct3)
    begin

	   ALUSrc <= '0';
           ALUControl <= "0000";
           ImmType <= "000"; 
           ResultSrc <= '0';
           MemWrite <= '0';
           PCSrc <= '0';
           RegWrite <= '0';
           RegDst <= '0';
           Branch <= '0';
           PCAddress <= '0';
           WritePCORResultSrc <= '0';
           ALUOutORPC <= '0';
           RegDst <= '0';
           WritePCORResultSrc <= '0';
           PCSrc <= '0';
           RegWrite <= '0';
	   ALUOutORPC <= '0';
	   ALUSrc <= '0';
	   zeroInputForAlu <= '0';

        if Opcode = "1110011" then --wfi and ecall

	     --ecall is the same as no-op, so just make sure everything is set to 0 I think
	     if funct7 = "0001000" then --wfi instruction, or END/HALT
	       Halt <= '1';
             end if;

	end if;

        if Opcode = "0110011" then --R-type

	   ALUSrc <= '0';
           ALUControl <= "0000";
           ResultSrc <= '0';
           MemWrite <= '0';
           PCSrc <= '0';
           RegDst <= '1';
           RegWrite <= '1';


        	if funct7 = "0000000" then --add/and/xor/or/sll/slt/srl

			if funct3 = "111" then --and

		    	    ALUControl <= "0010";
			elsif funct3 = "000" then --add

		    	    ALUControl <= "0000";
			elsif funct3 = "100" then --xor

		    	    ALUControl <= "1010";
			elsif funct3 = "110" then --or

		    	    ALUControl <= "0011";
			elsif funct3 = "001" then --sll

		    	    ALUControl <= "0110";
			elsif funct3 = "010" then --slt

		    	    ALUControl <= "1001";
			elsif funct3 = "101" then --srl

		    	    ALUControl <= "0111";
			end if;

		elsif funct7 = "0100000" then --sub/sra

		      if funct3 = "000" then --sub

		    	    ALUControl <= "0001";
		      elsif funct3 = "101" then --sra

		    	    ALUControl <= "1111";
		      end if;
	end if;
	end if;

        if Opcode = "0010011" then --addi/ori/andi/slli

		if funct3 = "000" then --addi

	   	ALUSrc <= '1';
           	ALUControl <= "0000"; --add/addi
           	ImmType <= "000"; --I-Type
           	ResultSrc <= '0';
           	MemWrite <= '0';
           	PCSrc <= '0';
           	RegDst <= '1';
           	RegWrite <= '1';

		elsif funct3 = "001" then --slli

	   	ALUSrc <= '1';
           	ALUControl <= "0110"; --slli/sll
           	ImmType <= "000"; --I-Type
           	ResultSrc <= '0';
           	MemWrite <= '0';
           	PCSrc <= '0';
           	RegDst <= '1';
           	RegWrite <= '1';

		elsif funct3 = "010" then --slti

	   	ALUSrc <= '1';
           	ALUControl <= "1001"; --slt
           	ImmType <= "000"; --I-Type
           	ResultSrc <= '0';
           	MemWrite <= '0';
           	PCSrc <= '0';
           	RegDst <= '1';
           	RegWrite <= '1';

		elsif funct3 = "011" then --sltiu

	   	ALUSrc <= '1';
           	ALUControl <= "1001"; --slt
           	ImmType <= "000"; --I-Type
           	ResultSrc <= '0';
           	MemWrite <= '0';
           	PCSrc <= '0';
           	RegDst <= '1';
           	RegWrite <= '1';


		elsif funct7 = "0100000" then --srai

	   	ALUSrc <= '1';
           	ALUControl <= "1111"; --srai
           	ImmType <= "000"; --I-Type
           	ResultSrc <= '0';
           	MemWrite <= '0';
           	PCSrc <= '0';
           	RegDst <= '1';
           	RegWrite <= '1';


		elsif funct3 = "101" then --srli

	   	ALUSrc <= '1';
           	ALUControl <= "0111"; --srl
           	ImmType <= "000"; --I-Type
           	ResultSrc <= '0';
           	MemWrite <= '0';
           	PCSrc <= '0';
           	RegDst <= '1';
           	RegWrite <= '1';

		elsif funct3 = "110" then --ori

	   	ALUSrc <= '1';
           	ALUControl <= "0011"; --or/ori
           	ImmType <= "000"; --I-Type
           	ResultSrc <= '0';
           	MemWrite <= '0';
           	PCSrc <= '0';
           	RegDst <= '1';
           	RegWrite <= '1';

		elsif funct3 = "111" then --andi

	   	ALUSrc <= '1';
           	ALUControl <= "0010"; --andi
           	ResultSrc <= '0';
           	MemWrite <= '0';
           	PCSrc <= '0';
           	RegDst <= '1';
           	RegWrite <= '1';

		elsif funct3 = "100" then --xori

	   	ALUSrc <= '1';
           	ALUControl <= "1010"; --xor
           	ResultSrc <= '0';
           	MemWrite <= '0';
           	PCSrc <= '0';
           	RegDst <= '1';
           	RegWrite <= '1';
		end if;
	end if;

        if Opcode = "1101111" then --jal instruction

           RegDst <= '1';
           WritePCORResultSrc <= '1';
           PCSrc <= '1';
           RegWrite <= '1';
	end if;

        if Opcode = "1100111" then --jalr instruction

           RegDst <= '1';
           WritePCORResultSrc <= '1';
           PCSrc <= '1';
           RegWrite <= '1';
	   ALUOutORPC <= '1';
           ALUControl <= "0000"; --add
	   ALUSrc <= '1';
	end if;

        if Opcode = "1100011" then --Branch instructions

           RegDst <= '1';
           Branch <= '1';
           ALUControl <= "0001"; --sub
	end if;

        if Opcode = "0110111" then --LUI instruction

           RegDst <= '1';
	   ALUSrc <= '1';
	   zeroInputForAlu <= '1';
           RegWrite <= '1';
           ALUControl <= "0000"; --or
	end if;

        if Opcode = "0010111" then --AUIPC instruction

           PCAddress <= '1';
           RegWrite <= '1';
           RegDst <= '1';
	   ALUSrc <= '1';
           ALUControl <= "0000"; --add
	end if;

        if Opcode = "0100011" then --SW instruction

	   ALUSrc <= '1';
           ALUControl <= "0000"; --add
           ResultSrc <= '1';
           MemWrite <= '1';
           RegDst <= '1';
	end if;

        if Opcode = "0000011" then --LW instruction

	   ALUSrc <= '1';
           ALUControl <= "0000"; --add
           ResultSrc <= '1';
           MemWrite <= '0'; --if 0 then read
           RegWrite <= '1';
           RegDst <= '1';
	end if;

    end process;
end Behavioral;

