--Structural modeling describes the interconnection of components or entities (like gates, --modules, or other components). 
--Itâs like connecting pieces of hardware together. You --instantiate entities and wire them together to form a larger system.

library IEEE;
use IEEE.std_logic_1164.ALL;

entity part2thing is

	generic (N : integer := 32);
    Port ( i_A_nBIT : in std_logic_vector(N-1 downto 0);
           i_B_nBIT : in std_logic_vector(N-1 downto 0);
           nAdd_Sub : in std_logic;
	   i_Im : in std_logic_vector(N-1 downto 0);
	   ALUSrc : in std_logic;
           o_Sum_nBit : out std_logic_vector(N-1 downto 0);
           o_Cout : out std_logic);

end part2thing;

architecture Structural of part2thing is

    component AdderSubtractor_Nbit is
  
     generic (N : integer := 32);
     Port ( i_A_nBIT : in std_logic_vector(N-1 downto 0);
           i_B_nBIT : in std_logic_vector(N-1 downto 0);
           nAdd_Sub : in std_logic;
           o_Sum_nBit : out std_logic_vector(N-1 downto 0);
           o_Cout : out std_logic);

	end component;


    component mux2t1_N is

     generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
     port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
         end component;


 	signal muxToAdder : std_logic_vector(N-1 downto 0);

begin

	TwoToOne : mux2t1_N port map (i_S => ALUSrc,
		i_D0 => i_B_nBIT,
		i_D1 => i_Im,
		o_O => muxToAdder);	

	AddSub : AdderSubtractor_Nbit port map (i_A_nBIT => i_A_nBIT,
		i_B_nBIT => muxToAdder,
		nAdd_Sub => nAdd_Sub,
		o_Sum_nBit => o_Sum_nBit,
		o_Cout => o_Cout);

end Structural;

