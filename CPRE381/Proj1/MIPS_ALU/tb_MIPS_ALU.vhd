library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_MIPS_ALU is
end tb_MIPS_ALU;

architecture Behavioral of tb_MIPS_ALU is

    component MIPS_ALU
        Port (
            A         : in  std_logic_vector(31 downto 0);
            B         : in  std_logic_vector(31 downto 0);
            ALUCtrl   : in  std_logic_vector(3 downto 0);
            F         : out std_logic_vector(31 downto 0);
            CarryOut  : out std_logic;
            Overflow  : out std_logic;
            Zero      : out std_logic
        );
    end component;

    signal A, B, F : std_logic_vector(31 downto 0);
    signal ALUCtrl : std_logic_vector(3 downto 0);
    signal CarryOut, Overflow, Zero : std_logic;

begin

    uut: MIPS_ALU port map (
        A => A,
        B => B,
        ALUCtrl => ALUCtrl,
        F => F,
        CarryOut => CarryOut,
        Overflow => Overflow,
        Zero => Zero
    );

    process
    begin
        -- AND
        A <= x"FFFFFFFF"; B <= x"0F0F0F0F"; ALUCtrl <= "0000";
        wait for 10 ns;

        -- OR
        A <= x"00000000"; B <= x"12345678"; ALUCtrl <= "0001";
        wait for 10 ns;

        -- ADD
        A <= x"00000001"; B <= x"00000001"; ALUCtrl <= "0010";
        wait for 10 ns;

        -- SUB
        A <= x"00000002"; B <= x"00000001"; ALUCtrl <= "0110";
        wait for 10 ns;

        -- SLT
        A <= x"00000001"; B <= x"00000002"; ALUCtrl <= "0011";
        wait for 10 ns;

        -- XOR
        A <= x"AAAAAAAA"; B <= x"55555555"; ALUCtrl <= "0100";
        wait for 10 ns;

        -- NOR
        A <= x"FFFFFFFF"; B <= x"00000000"; ALUCtrl <= "0101";
        wait for 10 ns;

        -- SLL
        A <= x"00000002"; B <= x"00000001"; ALUCtrl <= "1000";
        wait for 10 ns;

        -- SRL
        A <= x"00000002"; B <= x"00000004"; ALUCtrl <= "1001";
        wait for 10 ns;

        -- SRA
        A <= x"00000001"; B <= x"F0000000"; ALUCtrl <= "1010";
        wait for 10 ns;

        -- SLLV
        A <= x"00000004"; B <= x"00000001"; ALUCtrl <= "1011";
        wait for 10 ns;

        -- SRLV
        A <= x"00000004"; B <= x"00000010"; ALUCtrl <= "1100";
        wait for 10 ns;

        -- SRAV
        A <= x"00000004"; B <= x"F0000000"; ALUCtrl <= "1101";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;

