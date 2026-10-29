--Structural modeling describes the interconnection of components or entities (like gates, --modules, or other components). It’s like connecting pieces of hardware together. You --instantiate entities and wire them together to form a larger system.

library IEEE;
use IEEE.std_logic_1164.ALL;

entity StructuralVHDL_Adder_Nbit is
	generic (N : integer := 32);
    Port ( Al : in std_logic_vector(N-1 downto 0);
           Bl : in std_logic_vector(N-1 downto 0);
           Cinl : in std_logic;
           Suml : out std_logic_vector(N-1 downto 0);
           Coutl : out std_logic);
end StructuralVHDL_Adder_Nbit;

architecture Structural of StructuralVHDL_Adder_Nbit is

    component StructuralVHDL_Adder is
    	Port ( A : in std_logic;
           B : in std_logic;
           Cin : in std_logic;
           Sum : out std_logic;
           Cout : out std_logic);
	end component;

	signal carryl : std_logic_vector(N downto 0);

begin
    
	carryl(0) <= Cinl; -- Initial carry-in
	
   G_RippleCarry: for i in 0 to N-1 generate
    begin
        FA_INST: StructuralVHDL_Adder
            port map (
                A    => Al(i),
                B    => Bl(i),
                Cin  => carryl(i),
                Sum  => Suml(i),
                Cout => carryl(i+1)
            );
    end generate G_RippleCarry;

	Coutl <= carryl(N);

end Structural;

