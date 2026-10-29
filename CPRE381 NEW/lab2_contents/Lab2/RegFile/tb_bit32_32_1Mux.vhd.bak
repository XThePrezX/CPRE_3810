library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_bit32_32_1Mux is
  generic(gCLK_HPER   : time := 10 ns;
          N  : integer := 32); 
end tb_bit32_32_1Mux;

architecture mixed of tb_bit32_32_1Mux is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- TODO: change component declaration as needed.
component bit32_32_1Mux  is

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

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.
    signal isclt : STD_LOGIC_VECTOR(4 downto 0);
    signal idatainput0 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput1 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput2 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput3 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput4 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput5 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput6 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput7 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput8 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput9 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput10 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput11 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput12 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput13 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput14 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput15 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput16 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput17 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput18 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput19 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput20 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput21 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput22 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput23 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput24 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput25 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput26 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput27 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput28 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput29 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput30 : STD_LOGIC_VECTOR(31 downto 0);
    signal idatainput31 : STD_LOGIC_VECTOR(31 downto 0);
    signal odata_OUT : STD_LOGIC_VECTOR(31 downto 0);

begin

  DUT0: bit32_32_1Mux

  port map(
            sclt => isclt,
            datainput0 => idatainput0,
            datainput1 => idatainput1,
            datainput2 => idatainput2,
            datainput3 => idatainput3,
            datainput4 => idatainput4,
            datainput5 => idatainput5,
            datainput6 => idatainput6,
            datainput7 => idatainput7,
            datainput8 => idatainput8,
            datainput9 => idatainput9,
            datainput10 => idatainput10,
            datainput11 => idatainput11,
            datainput12 => idatainput12,
            datainput13 => idatainput13,
            datainput14 => idatainput14,
            datainput15 => idatainput15,
            datainput16 => idatainput16,
            datainput17 => idatainput17,
            datainput18 => idatainput18,
            datainput19 => idatainput19,
            datainput20 => idatainput20,
            datainput21 => idatainput21,
            datainput22 => idatainput22,
            datainput23 => idatainput23,
            datainput24 => idatainput24,
            datainput25 => idatainput25,
            datainput26 => idatainput26,
            datainput27 => idatainput27,
            datainput28 => idatainput28,
            datainput29 => idatainput29,
            datainput30 => idatainput30,
            datainput31 => idatainput31,
            data_OUT => odata_OUT);

  --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html

  
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

    	-- Test case 1: Set registers and change select
	idatainput0 <= "00000000000000000000000000000001";
	idatainput5 <= "00000000000000000000000000100001";
	idatainput31 <= "00000000000000000000000011110001";

	isclt   <= "00000";
	wait for gCLK_HPER*2;
	-- Expect: odata_OUT = "00000000000000000000000000000001"

	-- Test case 2: change select
	
	isclt   <= "00101";
	wait for gCLK_HPER*2;
	-- Expect: odata_OUT = "00000000000000000000000000100001"

	-- Test case 3: change select
	
	isclt   <= "11111";
	wait for gCLK_HPER*2;
	-- Expect: odata_OUT = "00000000000000000000000011110001"

    wait;
  end process;

end mixed;
