-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a behavioral 
-- signed adder operating on std_logic_vector inputs. 
--
--
-- NOTES: For simplicity, we caslibrary IEEE;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
    Port (
        A        : in  std_logic_vector(31 downto 0);
        B        : in  std_logic_vector(31 downto 0);
        ALUCtrl  : in  std_logic_vector(3 downto 0);
        Result   : out std_logic_vector(31 downto 0);
        CarryOut : out std_logic;
        Overflow : out std_logic
    );
end alu;

architecture Behavioral of alu is
    signal res : std_logic_vector(31 downto 0);
    signal signed_A : signed(31 downto 0);
    signal signed_B : signed(31 downto 0);
begin
    signed_A <= signed(A);
    signed_B <= signed(B);

    process(A, B, ALUCtrl)
        variable temp_result : signed(31 downto 0);
    begin
        CarryOut <= '0';
        Overflow <= '0';

        case ALUCtrl is
            when "0000" =>  -- AND
                res <= A and B;

            when "0001" =>  -- OR
                res <= A or B;

            when "0010" =>  -- ADD (signed)
                temp_result := signed_A + signed_B;
                res <= std_logic_vector(temp_result);
                if ((A(31) xor B(31)) = '0') and ((A(31) xor res(31)) = '1') then
                    Overflow <= '1';
                else
                    Overflow <= '0';
                end if;

            when "0110" =>  -- SUB (signed)
                temp_result := signed_A - signed_B;
                res <= std_logic_vector(temp_result);
                if ((A(31) xor B(31)) = '1') and ((A(31) xor res(31)) = '1') then
                    Overflow <= '1';
                else
                    Overflow <= '0';
                end if;

            when "0011" =>  -- SLT (signed)
                if signed_A < signed_B then
                    res <= x"00000001";
                else
                    res <= x"00000000";
                end if;

            when "0100" =>  -- XOR
                res <= A xor B;

            when "0101" =>  -- NOR
                res <= not (A or B);

            when others =>
                res <= (others => '0');
        end case;
    end process;

    Result <= res;
end Behavioral;
