library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_n_bit_register is
  generic(gCLK_HPER   : time := 10 ns;
          N  : integer := 32); 
end tb_n_bit_register;

architecture mixed of tb_n_bit_register is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- TODO: change component declaration as needed.
component n_bit_register is


	generic(N : integer := 32);
    	Port ( iClk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           We : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR(N - 1 downto 0);
           Q : out STD_LOGIC_VECTOR(N - 1 downto 0));

  
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.
signal s_iWe          :  std_logic := '0';
signal s_iRst          :  std_logic := '0';
signal s_iD         :  std_logic_vector(N-1 downto 0) := x"00000000";
signal s_oQ          :  std_logic_vector(N-1 downto 0);

begin

  DUT0: n_bit_register

  port map(
            iClk     => CLK,
            Rst       => s_iRst,
            We       => s_iWe,
            D     => s_iD,
	    Q     => s_oQ);
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
	s_iWe   <= '1';
	s_iD  <= x"00000600";
	wait for gCLK_HPER*2;
	-- Expect: s_oQ = x"00006000"

	-- Test case 2: Set register
	s_iWe   <= '1';
	s_iD  <= x"00120000";
	wait for gCLK_HPER*2;
	-- Expect: s_oQ = x"00120000"

	-- Test case 3: Set register
	s_iWe   <= '1';
	s_iD  <= x"FFFFFFFF";
	wait for gCLK_HPER*2;
	-- Expect: s_oQ = x"FFFFFFFF"

	-- Test case 4: Reset Register
	s_iRst <= '1';
	wait for gCLK_HPER*2;
	-- Expect: s_oQ = x"00000000"

	-- Test case 5: Try to write to when We disabled
	s_iRst <= '0';
	s_iWe   <= '0';
	s_iD  <= x"FFFFF0FF";
	wait for gCLK_HPER*2;
	-- Expect: s_oQ = x"00000000"


    wait;
  end process;

end mixed;
