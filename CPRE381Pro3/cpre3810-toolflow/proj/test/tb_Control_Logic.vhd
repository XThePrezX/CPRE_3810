library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_Control_Logic to reflect the new testbench.
entity tb_Control_Logic is
  generic(gCLK_HPER   : time := 10 ns;
          DATA_WIDTH  : integer := 8);   -- Generic for half of the clock cycle period
end tb_Control_Logic;

architecture mixed of tb_Control_Logic is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component Control_Logic is
    Port ( Opcode : in std_logic_vector(6 downto 0);
 	   funct7 : in std_logic_vector(6 downto 0);
 	   funct3 : in std_logic_vector(2 downto 0);
           Branch : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           ALUControl : out std_logic_vector(3 downto 0);
           ImmType : out std_logic_vector(2 downto 0);
           ResultSrc : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           PCSrc : out STD_LOGIC; -- if 0 do normal, if 1 branch
           RegDst : out STD_LOGIC;
           Halt : out STD_LOGIC;
           WritePCORResultSrc : out STD_LOGIC;
           ALUOutORPC : out STD_LOGIC;
           PCAddress : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           zeroInputForAlu : out STD_LOGIC);
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.
signal s_iOpcode   : std_logic_vector(6 downto 0) := "0000000";
signal s_ifunct7 :  std_logic_vector(6 downto 0) := "0000000";
signal s_ifunct3 :  std_logic_vector(2 downto 0) := "000";

signal s_oBranch          : STD_LOGIC;
signal s_oALUSrc      : STD_LOGIC;
signal s_oALUControl    : std_logic_vector(3 downto 0);
signal s_oImmType         : std_logic_vector(2 downto 0);
signal s_oResultSrc    : STD_LOGIC;
signal s_oMemWrite   : STD_LOGIC;
signal s_oPCSrc       : STD_LOGIC;
signal s_oRegDst          : STD_LOGIC;
signal s_oHalt      : STD_LOGIC;
signal s_oWritePCORResultSrc : STD_LOGIC;
signal s_oALUOutORPC      : STD_LOGIC;
signal s_oPCAddress    : STD_LOGIC;
signal s_oRegWrite     : STD_LOGIC;
signal s_oZeroInputForAlu : STD_LOGIC;


begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: Control_Logic
  --generic map (WIDTH => DATA_WIDTH)
  port map(
            Opcode     => s_iOpcode,
            funct7     => s_ifunct7,
            funct3     => s_ifunct3,
            Branch     => s_oBranch,
            ALUSrc       => s_oALUSrc,
            ALUControl       => s_oALUControl,
            ImmType     => s_oImmType,
            ResultSrc       => s_oResultSrc,
            MemWrite       => s_oMemWrite,
            PCSrc            => s_oPCSrc,
            Halt              => s_oHalt,
            WritePCORResultSrc   => s_oWritePCORResultSrc,
            ALUOutORPC         => s_oALUOutORPC,
            PCAddress          => s_oPCAddress,
            RegWrite          => s_oRegWrite,
            zeroInputForAlu     => s_oZeroInputForAlu);

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

    -- Test case: addi
    s_iOpcode   <= "0010011";
    s_ifunct3   <= "000";
    s_ifunct7   <= "0000000";
    wait for gCLK_HPER*4;
    -- Expect: 
           --Branch <= '0';
	   --ALUSrc <= '1';
           --ALUControl <= "0000";
           --ImmType <= "000"; 
           --ResultSrc <= '0';
           --MemWrite <= '0';
           --RegWrite <= '0';
           --RegDst <= '0';
           --PCAddress <= '0';
           --WritePCORResultSrc <= '0';
           --ALUOutORPC <= '0';
           --RegDst <= '0';
           --PCSrc <= '0';
           --RegWrite <= '1';
	   --ALUOutORPC <= '0';
	   --ALUSrc <= '0';
	   --zeroInputForAlu <= '0';

    -- Test case: beq
    s_iOpcode   <= "1100011";
    wait for gCLK_HPER*4;
    -- Expect: 
           --Branch <= '1';
	   --ALUSrc <= '0';
           --ALUControl <= "0001";
           --ImmType <= "000"; 
           --ResultSrc <= '0';
           --MemWrite <= '0';
           --RegWrite <= '0';
           --RegDst <= '0';
           --PCAddress <= '0';
           --WritePCORResultSrc <= '0';
           --ALUOutORPC <= '0';
           --RegDst <= '0';
           --PCSrc <= '0';
           --RegWrite <= '0';
	   --ALUOutORPC <= '0';
	   --ALUSrc <= '0';
	   --zeroInputForAlu <= '0';

    -- Test case: jal
    s_iOpcode   <= "1101111";
    wait for gCLK_HPER*4;
    -- Expect: 
           --Branch <= '0';
	   --ALUSrc <= '0';
           --ALUControl <= "0000";
           --ImmType <= "000"; 
           --ResultSrc <= '0';
           --MemWrite <= '0';
           --RegWrite <= '1';
           --RegDst <= '0';
           --PCAddress <= '0';
           --WritePCORResultSrc <= '1';
           --ALUOutORPC <= '0';
           --RegDst <= '0';
           --PCSrc <= '1';
           --RegWrite <= '1';
	   --ALUOutORPC <= '0';
	   --ALUSrc <= '0';
	   --zeroInputForAlu <= '0';




    wait;
  end process;

end mixed;
