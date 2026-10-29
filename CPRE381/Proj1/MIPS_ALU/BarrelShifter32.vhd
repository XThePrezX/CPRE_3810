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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity BarrelShifter32 is
    Port (
        input     : in  std_logic_vector(31 downto 0);
        shamt     : in  std_logic_vector(4 downto 0); -- shift amount
        dir       : in  std_logic;  -- '0' for left, '1' for right
        arith     : in  std_logic;  -- '1' for arithmetic (only applies to right shift)
        result    : out std_logic_vector(31 downto 0)
    );
end BarrelShifter32;

architecture Structural of BarrelShifter32 is
    signal stage0, stage1, stage2, stage3, stage4 : std_logic_vector(31 downto 0);
    signal fill_bit : std_logic;
begin
    -- Fill bit logic for arithmetic shift right (MSB replication)
    fill_bit <= input(31) when (dir = '1' and arith = '1') else '0';

    -- Stage 0: shift by 1
    stage0 <= (fill_bit & input(31 downto 1)) when (shamt(0) = '1' and dir = '1') else
              (input(30 downto 0) & '0')         when (shamt(0) = '1' and dir = '0') else
              input;

    -- Stage 1: shift by 2
    stage1 <= (fill_bit & fill_bit & stage0(31 downto 2)) when (shamt(1) = '1' and dir = '1') else
              (stage0(29 downto 0) & "00")             when (shamt(1) = '1' and dir = '0') else
              stage0;

    -- Stage 2: shift by 4
    stage2 <= (fill_bit & fill_bit & fill_bit & fill_bit & stage1(31 downto 4)) when (shamt(2) = '1' and dir = '1') else
              (stage1(27 downto 0) & x"0")                            when (shamt(2) = '1' and dir = '0') else
              stage1;

    -- Stage 3: shift by 8
    stage3 <= (x"FF" & stage2(31 downto 8)) when (shamt(3) = '1' and dir = '1' and arith = '1') else
              (fill_bit & fill_bit & fill_bit & fill_bit & fill_bit & fill_bit & fill_bit & fill_bit & stage2(31 downto 8)) when (shamt(3) = '1' and dir = '1') else
              (stage2(23 downto 0) & x"00") when (shamt(3) = '1' and dir = '0') else
              stage2;

    -- Stage 4: shift by 16
    stage4 <= (x"FFFF" & stage3(31 downto 16)) when (shamt(4) = '1' and dir = '1' and arith = '1') else
              (fill_bit & fill_bit & fill_bit & fill_bit & fill_bit & fill_bit & fill_bit & fill_bit &
               fill_bit & fill_bit & fill_bit & fill_bit & fill_bit & fill_bit & fill_bit & fill_bit &
               stage3(31 downto 16)) when (shamt(4) = '1' and dir = '1') else
              (stage3(15 downto 0) & x"0000") when (shamt(4) = '1' and dir = '0') else
              stage3;

    result <= stage4;
end Structural;
