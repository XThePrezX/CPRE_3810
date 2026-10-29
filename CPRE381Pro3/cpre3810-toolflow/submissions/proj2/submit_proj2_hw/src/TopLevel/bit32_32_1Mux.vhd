--Dataflow modeling describes the flow of data between components or signals. It defines how 
--values are computed, typically using signal assignments to represent the flow of data directly

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit32_32_1Mux is

    Port (sclt : in STD_LOGIC_VECTOR(4 downto 0);
	datainput0 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput1 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput2 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput3 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput4 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput5 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput6 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput7 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput8 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput9 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput10 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput11 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput12 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput13 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput14 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput15 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput16 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput17 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput18 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput19 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput20 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput21 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput22 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput23 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput24 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput25 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput26 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput27 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput28 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput29 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput30 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput31 : in STD_LOGIC_VECTOR(31 downto 0);
	data_OUT : out STD_LOGIC_VECTOR(31 downto 0));

end bit32_32_1Mux;

architecture Structural of bit32_32_1Mux is
begin

    data_OUT <= datainput0  when sclt = "00000" else
            datainput1  when sclt = "00001" else
            datainput2  when sclt = "00010" else
            datainput3  when sclt = "00011" else
            datainput4  when sclt = "00100" else
            datainput5  when sclt = "00101" else
            datainput6  when sclt = "00110" else
            datainput7  when sclt = "00111" else
            datainput8  when sclt = "01000" else
            datainput9  when sclt = "01001" else
            datainput10 when sclt = "01010" else
            datainput11 when sclt = "01011" else
            datainput12 when sclt = "01100" else
            datainput13 when sclt = "01101" else
            datainput14 when sclt = "01110" else
            datainput15 when sclt = "01111" else
            datainput16 when sclt = "10000" else
            datainput17 when sclt = "10001" else
            datainput18 when sclt = "10010" else
            datainput19 when sclt = "10011" else
            datainput20 when sclt = "10100" else
            datainput21 when sclt = "10101" else
            datainput22 when sclt = "10110" else
            datainput23 when sclt = "10111" else
            datainput24 when sclt = "11000" else
            datainput25 when sclt = "11001" else
            datainput26 when sclt = "11010" else
            datainput27 when sclt = "11011" else
            datainput28 when sclt = "11100" else
            datainput29 when sclt = "11101" else
            datainput30 when sclt = "11110" else
            datainput31 when sclt = "11111" else
            datainput0;  --default

end Structural;

