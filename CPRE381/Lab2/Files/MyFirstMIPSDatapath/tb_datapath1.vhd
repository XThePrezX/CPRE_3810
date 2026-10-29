library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_FirstDatapath to reflect the new testbench.
entity tb_datapath1 is
  generic(gCLK_HPER   : time := 10 ns;
          N  : integer := 32);   -- Generic for half of the clock cycle period
end tb_datapath1;

architecture mixed of tb_datapath1 is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component datapath1 is

	Port ( Clockk : in std_logic;
	   Resett : in std_logic;
	   nAdd_Sub : in std_logic;
	   ALUSrc : in std_logic;
	   WriteEnable : in std_logic;
	   Immi : in std_logic_vector(32-1 downto 0);
	   WriteSel : in std_logic_vector(5-1 downto 0);
	   oRead1_select : in std_logic_vector(5-1 downto 0);
           oRead2_select : in std_logic_vector(5-1 downto 0);
           oCout : out std_logic);

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.

	   signal sResett :  std_logic:= '0';
	   signal snAdd_Sub :  std_logic:= '0';
	   signal sALUSrc :  std_logic:= '0';
	   signal sWriteEnable :  std_logic:= '0';
	   signal sImmi :  std_logic_vector(32-1 downto 0):= x"00000000";
	   signal sWriteSel :  std_logic_vector(5-1 downto 0):= "00000";
	   signal soRead1_select :  std_logic_vector(5-1 downto 0):= "00000";
           signal soRead2_select :  std_logic_vector(5-1 downto 0):= "00000";

           signal soCout :  std_logic;

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: datapath1
  
  port map(Clockk     => CLK,
	Resett => sResett,
	nAdd_Sub => snAdd_Sub,
	ALUSrc => sALUSrc,
	WriteEnable => sWriteEnable,
	Immi => sImmi,
	WriteSel => sWriteSel,
	oRead1_select => soRead1_select,
	oRead2_select => soRead2_select,
	oCout  => soCout);
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

    sResett <= '1';
    wait for gCLK_HPER*2;
    sResett <= '0';

    -- Test case 1: addi
    sWriteEnable   <= '1'; --RegWrite

    soRead1_select   <= "00000"; --rs
    soRead2_select   <= "00001"; --rt (result will be stored here)
    sWriteSel   <= "00001"; --Register to write to
    sImmi <= x"00000001";
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '1';

    wait for gCLK_HPER*2;
    -- Expect: 

    -- Test case 2: addi
    soRead1_select   <= "00000"; --rs
    soRead2_select   <= "00010"; --rt (result will be stored here)
    sWriteSel   <= "00010"; --Register to write to
    sImmi <= x"00000002";
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '1';

    wait for gCLK_HPER*2;
    -- Expect: 

    -- Test case 3: addi
    soRead1_select   <= "00000"; --rs
    soRead2_select   <= "00011"; --rt (result will be stored here)
    sWriteSel   <= "00011"; --Register to write to
    sImmi <= x"00000003";
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '1';

    wait for gCLK_HPER*2;
    -- Expect: 

    -- Test case 4: addi
    soRead1_select   <= "00000"; --rs
    soRead2_select   <= "00100"; --rt (result will be stored here)
    sWriteSel   <= "00100"; --Register to write to
    sImmi <= x"00000004";
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '1';

    wait for gCLK_HPER*2;
    -- Expect:

    -- Test case 5: addi
    soRead1_select   <= "00000"; --rs
    soRead2_select   <= "00101"; --rt (result will be stored here)
    sWriteSel   <= "00101"; --Register to write to
    sImmi <= x"00000005";
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '1';

    wait for gCLK_HPER*2;
    -- Expect:

    -- Test case 6: addi
    soRead1_select   <= "00000"; --rs
    soRead2_select   <= "00110"; --rt (result will be stored here)
    sWriteSel   <= "00110"; --Register to write to
    sImmi <= x"00000006";
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '1';

    wait for gCLK_HPER*2;
    -- Expect:

    -- Test case 7: addi
    soRead1_select   <= "00000"; --rs
    soRead2_select   <= "00111"; --rt (result will be stored here)
    sWriteSel   <= "00111"; --Register to write to
    sImmi <= x"00000007";
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '1';

    wait for gCLK_HPER*2;
    -- Expect:

    -- Test case 8: addi
    soRead1_select   <= "00000"; --rs
    soRead2_select   <= "01000"; --rt (result will be stored here)
    sWriteSel   <= "01000"; --Register to write to
    sImmi <= x"00000008";
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '1';

    wait for gCLK_HPER*2;
    -- Expect:

    -- Test case 9: addi
    soRead1_select   <= "00000"; --rs
    soRead2_select   <= "01001"; --rt (result will be stored here)
    sWriteSel   <= "01001"; --Register to write to
    sImmi <= x"00000009";
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '1';

    wait for gCLK_HPER*2;
    -- Expect:

    -- Test case 10: addi
    soRead1_select   <= "00000"; --rs
    soRead2_select   <= "01010"; --rt (result will be stored here)
    sWriteSel   <= "01010"; --Register to write to
    sImmi <= x"0000000A";
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '1';

    wait for gCLK_HPER*2;
    -- Expect:

    -- Test case 11: add
    soRead1_select   <= "00001"; --rs
    soRead2_select   <= "00010"; --rt (result will be stored here)
    sWriteSel   <= "01011"; --Register to write to
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '0';

    wait for gCLK_HPER*2;
    -- Expect:

     -- Test case 12: sub
    soRead1_select   <= "01011"; --rs
    soRead2_select   <= "00011"; --rt (result will be stored here)
    sWriteSel   <= "01100"; --Register to write to
    snAdd_Sub   <= '1'; 
    sALUSrc   <= '0';

    wait for gCLK_HPER*2;
    -- Expect:

     -- Test case 13: add
    soRead1_select   <= "01100"; --rs
    soRead2_select   <= "00100"; --rt (result will be stored here)
    sWriteSel   <= "01101"; --Register to write to
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '0';

    wait for gCLK_HPER*2;
    -- Expect:

     -- Test case 14: sub
    soRead1_select   <= "01101"; --rs
    soRead2_select   <= "00101"; --rt (result will be stored here)
    sWriteSel   <= "01110"; --Register to write to
    snAdd_Sub   <= '1'; 
    sALUSrc   <= '0';

    wait for gCLK_HPER*2;
    -- Expect:

     -- Test case 15: add
    soRead1_select   <= "01110"; --rs
    soRead2_select   <= "00110"; --rt (result will be stored here)
    sWriteSel   <= "01111"; --Register to write to
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '0';

    wait for gCLK_HPER*2;
    -- Expect:

     -- Test case 16: sub
    soRead1_select   <= "01111"; --rs
    soRead2_select   <= "00111"; --rt (result will be stored here)
    sWriteSel   <= "10000"; --Register to write to
    snAdd_Sub   <= '1'; 
    sALUSrc   <= '0';

    wait for gCLK_HPER*2;
    -- Expect:

     -- Test case 17: add
    soRead1_select   <= "10000"; --rs
    soRead2_select   <= "01000"; --rt (result will be stored here)
    sWriteSel   <= "10001"; --Register to write to
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '0';

    wait for gCLK_HPER*2;
    -- Expect:

     -- Test case 18: sub
    soRead1_select   <= "10001"; --rs
    soRead2_select   <= "01001"; --rt (result will be stored here)
    sWriteSel   <= "10010"; --Register to write to
    snAdd_Sub   <= '1'; 
    sALUSrc   <= '0';

    wait for gCLK_HPER*2;
    -- Expect:

     -- Test case 19: sub
    soRead1_select   <= "10010"; --rs
    soRead2_select   <= "01010"; --rt (result will be stored here)
    sWriteSel   <= "10011"; --Register to write to
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '0';

    wait for gCLK_HPER*2;
    -- Expect:

     -- Test case 20: addi
    soRead1_select   <= "00000"; --rs
    soRead2_select   <= "10100"; --rt (result will be stored here)
    sWriteSel   <= "10100"; --Register to write to
    sImmi <= x"FFFFFFDC";
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '1';

    wait for gCLK_HPER*2;
    -- Expect:

     -- Test case 21: add
    soRead1_select   <= "10011"; --rs
    soRead2_select   <= "10100"; --rt (result will be stored here)
    sWriteSel   <= "10101"; --Register to write to
    snAdd_Sub   <= '0'; 
    sALUSrc   <= '0';

    wait for gCLK_HPER*2;
    -- Expect:


    wait;
  end process;

end mixed;
