--Behavior describes the functionality of a system without specifying the exact hardware --structure or data flow. It focuses on what the design does rather than how it does it

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Fetch_Logic is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Opcode : in STD_LOGIC_VECTOR(6 downto 0);
           InputData : in STD_LOGIC_VECTOR(31 downto 0);
           Immi : in STD_LOGIC_VECTOR(31 downto 0);
           PRSrc : in STD_LOGIC;
           ALUOutORPC : in STD_LOGIC;
           ALUOut : in STD_LOGIC_VECTOR(31 downto 0);
           incBy4 : out STD_LOGIC_VECTOR(31 downto 0);
           NextInstAddress : out STD_LOGIC_VECTOR(31 downto 0));
end Fetch_Logic;

architecture Mixed of Fetch_Logic is

    component mux2t1_N
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
    end component;

    component N_bit_Register
    	generic(N : integer := 32);
    	Port ( Clk : in STD_LOGIC;
           	Rst : in STD_LOGIC;
           	WrEnable : in STD_LOGIC;
           	Data : in STD_LOGIC_VECTOR(N-1 downto 0);
           	Q : out STD_LOGIC_VECTOR(N-1 downto 0));
    end component;

    component N_bit_Ripple_Adder_STRUC
	generic(N : integer := 32);
  port(i_A               : in std_logic_vector(N-1 downto 0);
       i_B               : in std_logic_vector(N-1 downto 0);
       i_Cin               : in std_logic;
       o_Cout               : out std_logic;
       o_S               : out std_logic_vector(N-1 downto 0));
    end component;

    signal PCIn : STD_LOGIC_VECTOR(31 downto 0);
    signal PCInNormal : STD_LOGIC_VECTOR(31 downto 0);
    signal PCOut : STD_LOGIC_VECTOR(31 downto 0);

    signal Adder4Out : STD_LOGIC_VECTOR(31 downto 0);
    signal AdderImmOut : STD_LOGIC_VECTOR(31 downto 0);
    signal AddingValue : STD_LOGIC_VECTOR(31 downto 0);

    signal Adder_OVERFLOW : std_logic;

    signal PCPlus4 : STD_LOGIC_VECTOR(31 downto 0);
    signal Branch : STD_LOGIC_VECTOR(31 downto 0);
    signal auipc : STD_LOGIC_VECTOR(31 downto 0);
    signal PCBranch : STD_LOGIC_VECTOR(31 downto 0);

    signal wireMuxtoMux : STD_LOGIC_VECTOR(31 downto 0);
    signal tempWire : STD_LOGIC_VECTOR(31 downto 0);
    signal tempWire2 : STD_LOGIC_VECTOR(31 downto 0);


begin --Must be unsigned so you can add? Error otherwise

    tempWire   <= x"0000000C";
    tempWire2   <= x"00000004";
    PCPlus4   <= std_logic_vector(unsigned(InputData)); --Must be unsigned so you can add? Error otherwise
    Branch <= std_logic_vector(unsigned(InputData) + unsigned(Immi) - unsigned(tempWire));
    auipc <= std_logic_vector(unsigned(InputData) + unsigned(Immi) - unsigned(tempWire2));
PCBranch   <= wireMuxtoMux when ALUOutORPC = '0'
                              else ALUOut;

wireMuxtoMux <= PCPlus4      when PRSrc = '0'
                              else Branch;

PCIn       <= x"00400000"    when Rst = '1'
                              else x"00400000" when PCBranch = x"00000000"
                              else PCBranch;

    incBy4 <= PCPlus4;

    Program_Counter: N_bit_Register Port map (Clk, '0', '1', PCIn, PCOut);

    NextInstAddress <= PCOut;

end Mixed;

