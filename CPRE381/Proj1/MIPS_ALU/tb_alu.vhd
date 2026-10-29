library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_alu is
end tb_alu;

architecture Behavioral of tb_alu is

    component alu
        Port (
            A        : in  std_logic_vector(31 downto 0);
            B        : in  std_logic_vector(31 downto 0);
            ALUCtrl  : in  std_logic_vector(3 downto 0);
            Result   : out std_logic_vector(31 downto 0);
            CarryOut : out std_logic;
            Overflow : out std_logic
        );
    end component;

    signal A, B, Result : std_logic_vector(31 downto 0);
    signal ALUCtrl : std_logic_vector(3 downto 0);
    signal CarryOut, Overflow : std_logic;

begin

    uut: alu port map (
        A => A,
        B => B,
        ALUCtrl => ALUCtrl,
        Result => Result,
        CarryOut => CarryOut,
        Overflow => Overflow
    );

    process
    begin
        -- AND
        A <= x"F0F0F0F0"; B <= x"0F0F0F0F"; ALUCtrl <= "0000"; wait for 10 ns;

        -- OR
        A <= x"00000000"; B <= x"12345678"; ALUCtrl <= "0001"; wait for 10 ns;

        -- ADD
        A <= x"00000010"; B <= x"00000020"; ALUCtrl <= "0010"; wait for 10 ns;

        -- SUB
        A <= x"00000040"; B <= x"00000020"; ALUCtrl <= "0110"; wait for 10 ns;

        -- SLT (A < B)
        A <= x"00000001"; B <= x"00000002"; ALUCtrl <= "0011"; wait for 10 ns;

        -- SLT (A > B)
        A <= x"00000003"; B <= x"00000002"; ALUCtrl <= "0011"; wait for 10 ns;

        -- XOR
        A <= x"AAAAAAAA"; B <= x"55555555"; ALUCtrl <= "0100"; wait for 10 ns;

        -- NOR
        A <= x"FFFFFFFF"; B <= x"00000000"; ALUCtrl <= "0101"; wait for 10 ns;

        -- Overflow test (ADD)
        A <= x"7FFFFFFF"; B <= x"00000001"; ALUCtrl <= "0010"; wait for 10 ns;

        -- Overflow test (SUB)
        A <= x"80000000"; B <= x"00000001"; ALUCtrl <= "0110"; wait for 10 ns;

        wait;
    end process;

end Behavioral;
