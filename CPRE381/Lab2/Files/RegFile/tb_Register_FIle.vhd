library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_Register_File is
  generic(gCLK_HPER   : time := 10 ns;
          N  : integer := 32); 
end tb_Register_File;

architecture mixed of tb_Register_File is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- TODO: change component declaration as needed.
component Register_File is

	Port ( iClock : in STD_LOGIC;
           iReset : in STD_LOGIC;
           iWriteEnable : in STD_LOGIC; --Assign 1 to write to a register
           iData : in STD_LOGIC_VECTOR(31 downto 0); --Value to be written
	   iRs : in STD_LOGIC_VECTOR(4 downto 0); --First register to read from
	   iRt : in STD_LOGIC_VECTOR(4 downto 0); --Second register to read from
	   iRd : in STD_LOGIC_VECTOR(4 downto 0); --Register to be written to
           oRead1 : out STD_LOGIC_VECTOR(31 downto 0);
	   oRead2 : out STD_LOGIC_VECTOR(31 downto 0));

  
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.
	   signal s_iReset :  STD_LOGIC := '0';
           signal s_iWriteEnable :  STD_LOGIC := '0'; --Assign 1 to write to a register
           signal s_iData :  STD_LOGIC_VECTOR(31 downto 0) := x"00000000"; --Value to be written
	   signal s_iRs :  STD_LOGIC_VECTOR(4 downto 0) := "00000"; --First register to read from
	   signal s_iRt :  STD_LOGIC_VECTOR(4 downto 0) := "00000"; --Second register to read from
	   signal s_iRd :  STD_LOGIC_VECTOR(4 downto 0) := "00000"; --Register to be written to
           signal s_oRead1 :  STD_LOGIC_VECTOR(31 downto 0);
	   signal s_oRead2 :  STD_LOGIC_VECTOR(31 downto 0);

begin

  DUT0: Register_File

  port map(
            iClock     => CLK,
            iReset       => s_iReset,
            iWriteEnable       => s_iWriteEnable,
            iData     => s_iData,
	    iRs     => s_iRs,
	    iRt     => s_iRt,
	    iRd     => s_iRd,
	    oRead1     => s_oRead1,
	    oRead2     => s_oRead2);
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

    	-- Test case 1: Assign register1 some values and output
	s_iWriteEnable <= '1';
	s_iRd <= "00001";
	s_iData <= x"00000001";
	wait for gCLK_HPER*2;
	s_iRs <= "00001";
	s_iRt <= "00010";
	wait for gCLK_HPER*2;
	-- Expect: s_oRead1 = "00000001" and s_oRead2 = "XXXXXXXX"

	-- Test case 2: Assign register2 some values and output
	s_iRd <= "00010";
	s_iData <= x"00000002";
	wait for gCLK_HPER*2;
	-- Expect: s_oRead1 = "00000001" and s_oRead2 = "00000002"

	-- Test case 3: Try to change register when write enable is 0
	s_iWriteEnable <= '0';
	s_iRd <= "00010";
	s_iData <= x"00000004";
	wait for gCLK_HPER*2;
	-- Expect: s_oRead1 = "00000001" and s_oRead2 = "00000002"

	-- Test case 4: Assign and read last of last register
	s_iWriteEnable <= '1';
	s_iRt <= "11111";
	s_iRd <= "11111";
	s_iData <= x"FFFFFFFF";
	wait for gCLK_HPER*2;
	-- Expect: s_oRead1 = "00000001" and s_oRead2 = "FFFFFFFF"

	-- Test case 5: Try to assign to register 0
	s_iRs <= "00000";
	s_iRd <= "00000";
	s_iData <= x"FFFFFFFF";
	wait for gCLK_HPER*2;
	-- Expect: s_oRead1 = "00000000" and s_oRead2 = "FFFFFFFF"

	-- Test case 6: Reset
	s_iReset <= '1';
	wait for gCLK_HPER*2;
	-- Expect: s_oRead1 = "00000000" and s_oRead2 = "00000000"
    wait;
  end process;

end mixed;
