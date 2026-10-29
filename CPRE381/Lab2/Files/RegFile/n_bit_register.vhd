library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity n_bit_register is

    generic(N : integer := 32);
    Port ( iClk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           We : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR(N - 1 downto 0);
           Q : out STD_LOGIC_VECTOR(N - 1 downto 0));

end n_bit_register;

architecture structural of n_bit_register is


   component dffg is
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic;     -- Data value input
         o_Q          : out std_logic);   -- Data value output
    end component;


begin
    
    NBit_dffg : for i in 0 to N-1 generate

    	FF_i : dffg Port map (

	i_CLK => iClk, 
	i_RST => Rst, 
	i_WE => We,
	i_D => D(i),
	o_Q => Q(i));

    end generate NBit_dffg;

end structural;

