--Structural modeling describes the interconnection of components or entities (like gates, --modules, or other components). 
--Itâs like connecting pieces of hardware together. You --instantiate entities and wire them together to form a larger system.

library IEEE;
use IEEE.std_logic_1164.ALL;

entity datapath1 is

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

end datapath1;

architecture Structural of datapath1 is

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


 	signal Regread1TOdatapath : std_logic_vector(32-1 downto 0);
	signal Regread2TOdatapath : std_logic_vector(32-1 downto 0);
	signal DatapathTOregister : std_logic_vector(32-1 downto 0);

begin


Register_File_Inst : Register_File
  port map (
    iClock      => Clockk,
    iReset      => Resett,
    iWriteEnable=> WriteEnable,
    iData       => DatapathTOregister,
    iRs         => oRead1_select,
    iRt         => oRead2_select,
    iRd         => WriteSel,
    oRead1      => Regread1TOdatapath,
    oRead2      => Regread2TOdatapath
  );

part2thing_Inst : part2thing
  generic map (
    N => 32
  )
  port map (
    i_A_nBIT   => Regread1TOdatapath,
    i_B_nBIT   => Regread2TOdatapath,
    nAdd_Sub   => nAdd_Sub,
    i_Im       => Immi,
    ALUSrc     => ALUSrc,
    o_Sum_nBit => DatapathTOregister,
    o_Cout     => oCout
  );


end Structural;

