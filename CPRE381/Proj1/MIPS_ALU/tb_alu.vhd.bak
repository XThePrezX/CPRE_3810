library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_BarrelShifter32 is
end tb_BarrelShifter32;

architecture Behavioral of tb_BarrelShifter32 is

    component BarrelShifter32
        Port (
            input     : in  std_logic_vector(31 downto 0);
            shamt     : in  std_logic_vector(4 downto 0);
            dir       : in  std_logic;  -- '0' = left, '1' = right
            arith     : in  std_logic;  -- '1' = arithmetic (only for right)
            result    : out std_logic_vector(31 downto 0)
        );
    end component;

    signal input    : std_logic_vector(31 downto 0);
    signal shamt    : std_logic_vector(4 downto 0);
    signal dir      : std_logic;
    signal arith    : std_logic;
    signal result   : std_logic_vector(31 downto 0);

begin

    uut: BarrelShifter32 port map (
        input  => input,
        shamt  => shamt,
        dir    => dir,
        arith  => arith,
        result => result
    );

    process
    begin
        -- Logical shift left by 4
        input <= x"00000001"; shamt <= "00100"; dir <= '0'; arith <= '0'; wait for 10 ns;

        -- Logical shift right by 4
        input <= x"F0000000"; shamt <= "00100"; dir <= '1'; arith <= '0'; wait for 10 ns;

        -- Arithmetic shift right by 4
        input <= x"F0000000"; shamt <= "00100"; dir <= '1'; arith <= '1'; wait for 10 ns;

        -- Logical shift left by 0 (no-op)
        input <= x"12345678"; shamt <= "00000"; dir <= '0'; arith <= '0'; wait for 10 ns;

        -- Logical shift right by 31
        input <= x"80000000"; shamt <= "11111"; dir <= '1'; arith <= '0'; wait for 10 ns;

        -- Arithmetic shift right by 31
        input <= x"80000000"; shamt <= "11111"; dir <= '1'; arith <= '1'; wait for 10 ns;

        -- Logical shift left by 31
        input <= x"00000001"; shamt <= "11111"; dir <= '0'; arith <= '0'; wait for 10 ns;

        wait;
    end process;

end Behavioral;

