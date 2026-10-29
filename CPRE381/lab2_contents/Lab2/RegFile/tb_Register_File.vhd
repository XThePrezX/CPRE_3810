library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_Register_File to reflect the new testbench.
entity tb_Register_File is
  generic(gCLK_HPER   : time := 10 ns;
          DATA_WIDTH  : integer := 8);   -- Generic for half of the clock cycle period
end tb_Register_File;

architecture mixed of tb_Register_File is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component Register_File is

    Port ( rs1 : in STD_LOGIC_VECTOR(4 downto 0); --Register to read
           rs2 : in STD_LOGIC_VECTOR(4 downto 0); --Register to read
           rd : in STD_LOGIC_VECTOR(4 downto 0); --Register to write to
           Clk : in STD_LOGIC;
           Data : in STD_LOGIC_VECTOR(31 downto 0); --Data to be written
           We : in STD_LOGIC; --Enable if writing
           Reset : in STD_LOGIC;
           Data1 : out STD_LOGIC_VECTOR(31 downto 0);
           Data2 : out STD_LOGIC_VECTOR(31 downto 0));
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.
signal s_rs1   : std_logic_vector(4 downto 0) := "00000";
signal s_rs2   : std_logic_vector(4 downto 0) := "00000";
signal s_rd : std_logic_vector(4 downto 0) := "00000";
signal s_Data   : std_logic_vector(31 downto 0) := x"00000000";
signal s_We   : std_logic := '0';
signal s_rst   : std_logic := '0';
signal s_Data1   : std_logic_vector(31 downto 0);
signal s_Data2   : std_logic_vector(31 downto 0);

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: Register_File
  --generic map (WIDTH => DATA_WIDTH)
  port map(
            Clk     => CLK,
            Reset       => s_rst,
            rs1       => s_rs1,
            rs2     => s_rs2,
            rd       => s_rd,
            Data       => s_Data,
            We       => s_We,
            Data1       => s_Data1,
            Data2       => s_Data2);
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

    -- Test case 1: Startup all cases with the value 1
    -- 
    s_rs1   <= "00000";  
    s_rs2   <= "00000";  
    s_rd <= "00000";
    s_Data <= x"00000000";
    reset <= '0';
    s_We   <= '0';  
    wait for gCLK_HPER*2;
    -- Expect: Data1: N/A, Data2: N/A

    -- Test case 2: Write to a register 1 with a value
    -- 
    s_rs1   <= "00001";  
    s_rs2   <= "00001";  
    s_rd <= "00001";
    s_Data <= x"FFFFFFFF";
    s_rst <= '0';
    s_We   <= '1';  
    wait for gCLK_HPER*2;
    -- Expect: Data1: FFFFFFFF, Data2: FFFFFFFF

    -- Test case 2: Write to a register 31 with a value
    -- 
    s_rs1   <= "00001";  
    s_rs2   <= "11111";  
    s_rd <= "11111";
    s_Data <= x"FFFFFFF0";
    s_rst <= '0';
    s_We   <= '1';  
    wait for gCLK_HPER*2;
    -- Expect: Data1: FFFFFFFF, Data2: FFFFFFF0

    -- Test case 3: Read from register 1 again, and try to write to register 1 with We 0
    -- 
    s_rs1   <= "00001";  
    s_rs2   <= "00001";  
    s_rd <= "00001";
    s_Data <= x"FFFFFFF0";
    s_rst <= '0';
    s_We   <= '0';  
    wait for gCLK_HPER*2;
    -- Expect: Data1: FFFFFFFF, Data2: FFFFFFFF

    -- Test case 4: Test your reset
    -- 
    s_rs1   <= "00001";  
    s_rs2   <= "00001";  
    s_rd <= "00001";
    s_Data <= x"FFFFFFF0";
    s_rst <= '1';
    s_We   <= '0';  
    wait for gCLK_HPER*2;
    -- Expect: Data1: 00000000, Data2: 00000000

    -- Test case 5:  Write to one of the register again after reset
    -- 
    s_rs1   <= "00001";  
    s_rs2   <= "00001";  
    s_rd <= "00001";
    s_Data <= x"F0F0F0F0";
    s_rst <= '0';
    s_We   <= '1';  
    wait for gCLK_HPER*2;
    -- Expect: Data1: F0F0F0F0, Data2: F0F0F0F0

    -- Test case 6:  try to write to register 0
    -- 
    s_rs1   <= "00000";  
    s_rs2   <= "00000";  
    s_rd <= "00000";
    s_Data <= x"F0F0F0F0";
    s_rst <= '0';
    s_We   <= '1';  
    wait for gCLK_HPER*2;
    -- Expect: Data1: 00000000, Data2: 00000000


    wait;
  end process;

end mixed;
