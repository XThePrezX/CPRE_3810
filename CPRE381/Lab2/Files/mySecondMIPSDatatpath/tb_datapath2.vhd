library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_FirstDatapath to reflect the new testbench.
entity tb_datapath2 is
  generic(gCLK_HPER   : time := 10 ns;
          N  : integer := 32);   -- Generic for half of the clock cycle period
end tb_datapath2;

architecture mixed of tb_datapath2 is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component datapath2 is

	Port (iClk     : in std_logic;
        iRst        : in std_logic;
        iRs      : in std_logic_vector(4 downto 0);
        iRt     : in std_logic_vector(4 downto 0);
        iRd     : in std_logic_vector(4 downto 0);
        iImm        : in std_logic_vector(15 downto 0);
        iMemRead     : in std_logic;
        iMemWrite     : in std_logic;
        iRegWrite     : in std_logic;
        iALUSrc     : in std_logic;
        iALUOp     : in std_logic;
        oALUResult     : out std_logic_vector(31 downto 0);
        oMemData     : out std_logic_vector(31 downto 0);
        oRead1      : out std_logic_vector(31 downto 0);
        oRead2      : out std_logic_vector(31 downto 0));

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.

	signal s_iRst        :  std_logic:= '0';
        signal s_iRs      :  std_logic_vector(4 downto 0):= "00000";
        signal s_iRt     :  std_logic_vector(4 downto 0):= "00000";
        signal s_iRd     :  std_logic_vector(4 downto 0):= "00000";
        signal s_iImm        :  std_logic_vector(15 downto 0):= x"0000";
        signal s_iMemRead     :  std_logic:= '0';
        signal s_iMemWrite     :  std_logic:= '0';
        signal s_iRegWrite     :  std_logic:= '0';
        signal s_iALUSrc     :  std_logic:= '0';
        signal s_iALUOp     :  std_logic:= '0';
        signal s_oALUResult     :  std_logic_vector(31 downto 0):= x"00000000";
        signal s_oMemData     :  std_logic_vector(31 downto 0):= x"00000000";
        signal s_oRead1      :  std_logic_vector(31 downto 0):= x"00000000";
        signal s_oRead2      :  std_logic_vector(31 downto 0):= x"00000000";

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: datapath2
  
  port map (iClk     => CLK,
        iRst        => s_iRst,
        iRs      => s_iRs,
        iRt     => s_iRt,
        iRd     => s_iRd,
        iImm        => s_iImm,
        iMemRead     => s_iMemRead,
        iMemWrite     => s_iMemWrite,
        iRegWrite     => s_iRegWrite,
        iALUSrc     => s_iALUSrc,
        iALUOp     => s_iALUOp,
        oALUResult     => s_oALUResult,
        oMemData     => s_oMemData,
        oRead1      => s_oRead1,
        oRead2      => s_oRead2);
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

   

	-- Test case 1: addi $25, $0, 0   => $25 = 0
s_iRegWrite  <= '1';
s_iMemRead   <= '0';
s_iMemWrite  <= '0';

s_iRs   <= "00000"; -- $0
s_iRd   <= "11001"; -- $25
s_iImm  <= x"0000"; -- immediate = 0

s_iALUSrc  <= '1';  -- use immediate
s_iALUOp   <= '0';  -- add

wait for gCLK_HPER * 2;
-- Expect: $25 = 0

-- Test case 2: addi $1, $0, 3    => $1 = 3
s_iRegWrite  <= '1';
s_iMemRead   <= '0';
s_iMemWrite  <= '0';

s_iRs   <= "00000"; -- $0
s_iRd   <= "00001"; -- $1
s_iImm  <= x"0003"; -- immediate = 3

s_iALUSrc  <= '1';  -- use immediate
s_iALUOp   <= '0';  -- add

wait for gCLK_HPER * 2;
-- Expect: $1 = 3

-- Test case 3: add $2, $1, $25   => $2 = $1 + $25
s_iRegWrite  <= '1';
s_iMemRead   <= '0';
s_iMemWrite  <= '0';

s_iRs   <= "00001"; -- $1 = 3
s_iRt   <= "11001"; -- $25 = 0
s_iRd   <= "00010"; -- $2

s_iImm  <= x"0000"; -- irrelevant
s_iALUSrc  <= '0';  -- use register
s_iALUOp   <= '0';  -- add

wait for gCLK_HPER * 2;
-- Expect: $2 = 3 + 0 = 3

-- Test case 4: sub $3, $2, $1   => $3 = $2 - $1 = 3 - 3 = 0
s_iRegWrite  <= '1';
s_iMemRead   <= '0';
s_iMemWrite  <= '0';

s_iRs   <= "00010"; -- $2
s_iRt   <= "00001"; -- $1
s_iRd   <= "00011"; -- $3

s_iImm  <= x"0000"; -- irrelevant
s_iALUSrc  <= '0';  -- use register
s_iALUOp   <= '1';  -- subtract

wait for gCLK_HPER * 2;
-- Expect: $3 = 0

-- Test case 5: lw $1, 0($25) => load A[0] into $1
s_iRegWrite  <= '1';  -- Enable register write
s_iMemRead   <= '1';  -- Enable memory read
s_iMemWrite  <= '0';  -- No write
s_iALUSrc    <= '1';  -- Use immediate
s_iALUOp     <= '0';  -- Addition (for address calc)

s_iRs   <= "11001";   -- $25
s_iRt   <= "00000";   -- Not used for lw
s_iRd   <= "00001";   -- $1 (destination)
s_iImm  <= x"0000";   -- Offset = 0

wait for gCLK_HPER * 2;
-- Expect: $1 loaded with A[0] from memory[0x0000]

-- Test case 6: sw $1, 4($26) => store $1 into B[1]
s_iRegWrite  <= '0';  -- No register write
s_iMemRead   <= '0';  -- No read
s_iMemWrite  <= '1';  -- Enable memory write
s_iALUSrc    <= '1';  -- Use immediate
s_iALUOp     <= '0';  -- Addition (for address calc)

s_iRs   <= "11010";   -- $26 (base address of B)
s_iRt   <= "00001";   -- $1 (value to store)
s_iRd   <= "00000";   -- Not used for sw
s_iImm  <= x"0004";   -- Offset = 4

wait for gCLK_HPER * 2;
-- Expect: memory[0x0104] written with value of $1


    wait;
  end process;

end mixed;
