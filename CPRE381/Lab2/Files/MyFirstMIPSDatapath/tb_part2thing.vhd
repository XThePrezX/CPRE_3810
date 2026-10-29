library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_FirstDatapath to reflect the new testbench.
entity tb_part2thing is
  generic(gCLK_HPER   : time := 10 ns;
          N  : integer := 32);   -- Generic for half of the clock cycle period
end tb_part2thing;

architecture mixed of tb_part2thing is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component part2thing is
  
  generic (N : integer := 32);
    Port ( i_A_nBIT : in std_logic_vector(N-1 downto 0);
           i_B_nBIT : in std_logic_vector(N-1 downto 0);
           nAdd_Sub : in std_logic;
	   i_Im : in std_logic_vector(N-1 downto 0);
	   ALUSrc : in std_logic;
           o_Sum_nBit : out std_logic_vector(N-1 downto 0);
           o_Cout : out std_logic);

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.

signal s_i_A_nBIT : std_logic_vector(N-1 downto 0) := x"00000000";
signal s_i_B_nBIT : std_logic_vector(N-1 downto 0) := x"00000000";
signal s_nAdd_Sub : std_logic := '0';
signal s_i_Im : std_logic_vector(N-1 downto 0);
signal s_ALUSrc : std_logic := '0';

signal s_o_Sum_nBit : std_logic_vector(N-1 downto 0);
signal s_Cout : std_logic;

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: part2thing
  
  port map(i_A_nBIT     => s_i_A_nBIT,
	i_B_nBIT => s_i_B_nBIT,
	nAdd_Sub => s_nAdd_Sub,
	i_Im => s_i_Im,
	ALUSrc => s_ALUSrc,
	o_Sum_nBit => s_o_Sum_nBit,
	o_Cout => s_Cout);
  --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html

  
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  -- This process resets the sequential components of the design.
  -- It is held to be 1 across both the negative and positive edges of the clock
  -- so it works regardless of whether the design uses synchronous (pos or neg edge)
  -- or asynchronous resets.
  P_RST: process
  begin
  	reset <= '0';   
    wait for gCLK_HPER/2;
	reset <= '1';
    wait for gCLK_HPER*2;
	reset <= '0';
	wait;
  end process;  
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- Test case 1: C,= A + B
    s_nAdd_Sub   <= '0';  
    s_ALUSrc   <= '0';

    s_i_A_nBIT <= x"00000006";
    s_i_B_nBIT <= x"00000003";
    wait for gCLK_HPER*2;
    -- Expect: Sum should be x"00000009"

    -- Test case 2: C,= A + Immi
    s_nAdd_Sub   <= '0';  
    s_ALUSrc   <= '1';

    s_i_A_nBIT <= x"00000004";
    s_i_Im <= x"00000006";
    wait for gCLK_HPER*2;
    -- Expect: Sum should be x"0000000A"

    -- Test case 3: C,= A - B
    s_nAdd_Sub   <= '1';  
    s_ALUSrc   <= '0';

    s_i_A_nBIT <= x"00000007";
    s_i_B_nBIT <= x"00000005";
    wait for gCLK_HPER*2;
    -- Expect: Sum should be x"00000001"

    -- Test case 4: C,= A - Immi
    s_nAdd_Sub   <= '1';  
    s_ALUSrc   <= '1';

    s_i_A_nBIT <= x"00000006";
    s_i_Im <= x"00000002";
    wait for gCLK_HPER*2;
    -- Expect: Sum should be x"00000004"

    wait;
  end process;

end mixed;
