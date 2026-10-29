--Structural modeling describes the interconnection of components or entities (like gates, --modules, or other components). It’s like connecting pieces of hardware together. You --instantiate entities and wire them together to form a larger system.

library IEEE;
use IEEE.std_logic_1164.ALL;

entity AdderSubtractor_Nbit is

	generic (N : integer := 32);
    Port ( i_A_nBIT : in std_logic_vector(N-1 downto 0);
           i_B_nBIT : in std_logic_vector(N-1 downto 0);
           nAdd_Sub : in std_logic;
           o_Sum_nBit : out std_logic_vector(N-1 downto 0);
           o_Cout : out std_logic);

end AdderSubtractor_Nbit;

architecture Structural of AdderSubtractor_Nbit is

    component StructuralVHDL_Adder_Nbit is
	
    	   Port ( Al : in std_logic_vector(N-1 downto 0);
           Bl : in std_logic_vector(N-1 downto 0);
           Cinl : in std_logic;
           Suml : out std_logic_vector(N-1 downto 0);
           Coutl : out std_logic);
	end component;

    component mux2t1_N is
         
  	  port(i_S          : in std_logic;
             i_D0         : in std_logic_vector(N-1 downto 0);
             i_D1         : in std_logic_vector(N-1 downto 0);
             o_O          : out std_logic_vector(N-1 downto 0));
	 end component;

     component oc_mux2t1_N_OC is
  	
	port(i_D0         : in std_logic_vector(N-1 downto 0);
	     o_O          : out std_logic_vector(N-1 downto 0));
	end component;

	signal wire1, wire2: std_logic_vector(N-1 downto 0);

begin

	onesComp1 : oc_mux2t1_N_OC
	port map (i_D0 => i_B_nBIT, 
		o_O => wire1);

	TwoToOne : mux2t1_N
	port map (i_S => nAdd_Sub,
		i_D0 => i_B_nBIT,
		i_D1 => wire1,
		o_O => wire2);	

	FullAdder : StructuralVHDL_Adder_Nbit
	port map (Al => i_A_nBIT,
		Bl => wire2,
		Cinl => nAdd_Sub,
		Suml => o_Sum_nBit,
		Coutl => o_Cout);

end Structural;

