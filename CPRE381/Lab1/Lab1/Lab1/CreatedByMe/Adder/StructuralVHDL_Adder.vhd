--Structural modeling describes the interconnection of components or entities (like gates, --modules, or other components). It’s like connecting pieces of hardware together. You --instantiate entities and wire them together to form a larger system.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity StructuralVHDL_Adder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC;
           Cout : out STD_LOGIC);
end StructuralVHDL_Adder;

architecture Structural of StructuralVHDL_Adder is

    component xorg2
	Port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
	end component;

    component org2
	port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
	end component;

    component andg2
	port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
	end component;

    signal wire1, wire2, wire3 : STD_LOGIC;

begin
    
	XOR1: xorg2 Port map (i_A => A,
			i_B => B,
			o_F => wire1);
	XOR2: xorg2 Port map(i_A => wire1,
			i_B => Cin,
			o_F => Sum);
	AND1: andg2 Port map (i_A => Cin,
			i_B => wire1,
			o_F => wire2);
	AND2: andg2 Port map (i_A => A,
			i_B => B,
			o_F => wire3);
	OR1: org2 Port map (i_A => wire2,
			i_B => wire3,
			o_F => Cout);


end Structural;

