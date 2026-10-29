library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_DF_5to32_Decoder is
  generic(gCLK_HPER   : time := 10 ns;
          N  : integer := 32); 
end tb_DF_5to32_Decoder;

architecture mixed of tb_DF_5to32_Decoder is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- TODO: change component declaration as needed.
component DF_5to32_Decoder  is

	Port ( D_IN : in STD_LOGIC_VECTOR(4 downto 0);
           F_OUT : out STD_LOGIC_VECTOR(31 downto 0);
	   enable : in std_logic);

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.
signal s_D_IN        :  std_logic_vector(4 downto 0) := "00000";
signal s_enable        :  std_logic := '0';
signal s_F_OUT          :  std_logic_vector(31 downto 0);

begin

  DUT0: DF_5to32_Decoder

  port map(
            D_IN     => s_D_IN,
            F_OUT       => s_F_OUT,
	    enable    => s_enable);
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

    	-- Test case 1: Set register
	s_enable <= '1';
	s_D_IN   <= "00001";
	wait for gCLK_HPER*2;
	-- Expect: s_F_OUT = "00000000000000000000000000000001"

	-- Test case 2: Set register
	s_D_IN   <= "00010";
	wait for gCLK_HPER*2;
	-- Expect: s_F_OUT = x"00000000000000000000000000000010"

	-- Test case 3: Set register
	s_D_IN   <= "00011";
	wait for gCLK_HPER*2;
	-- Expect: s_F_OUT = x"00000000000000000000000000000100"

	-- Test case 4: Set register
	s_D_IN   <= "11111";
	wait for gCLK_HPER*2;
	-- Expect: s_F_OUT = x"10000000000000000000000000000000"

	-- Test case 4: Turn enable off
	s_enable <= '0';
	wait for gCLK_HPER*2;
	-- Expect: s_F_OUT = x"10000000000000000000000000000000"

    wait;
  end process;

end mixed;
