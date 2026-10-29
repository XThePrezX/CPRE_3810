library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_File is

    Port ( iClock : in STD_LOGIC;
           iReset : in STD_LOGIC;
           iWriteEnable : in STD_LOGIC; --Assign 1 to write to a register
           iData : in STD_LOGIC_VECTOR(31 downto 0); --Value to be written
	   iRs : in STD_LOGIC_VECTOR(4 downto 0); --First register to read from
	   iRt : in STD_LOGIC_VECTOR(4 downto 0); --Second register to read from
	   iRd : in STD_LOGIC_VECTOR(4 downto 0); --Register to be written to
           oRead1 : out STD_LOGIC_VECTOR(31 downto 0);
	   oRead2 : out STD_LOGIC_VECTOR(31 downto 0));

end Register_File;

architecture structural of Register_File is


 component n_bit_register is


	generic(N : integer := 32);
    	Port ( iClk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           We : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR(N - 1 downto 0);
           Q : out STD_LOGIC_VECTOR(N - 1 downto 0));

    end component;

 component DF_5to32_Decoder  is

	Port ( D_IN : in STD_LOGIC_VECTOR(4 downto 0);
           F_OUT : out STD_LOGIC_VECTOR(31 downto 0);
	   enable : in std_logic);

	end component;

  component bit32_32_1Mux  is

	Port (sclt : in STD_LOGIC_VECTOR(4 downto 0);
	datainput0 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput1 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput2 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput3 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput4 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput5 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput6 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput7 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput8 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput9 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput10 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput11 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput12 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput13 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput14 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput15 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput16 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput17 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput18 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput19 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput20 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput21 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput22 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput23 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput24 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput25 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput26 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput27 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput28 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput29 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput30 : in STD_LOGIC_VECTOR(31 downto 0);
	datainput31 : in STD_LOGIC_VECTOR(31 downto 0);
	data_OUT : out STD_LOGIC_VECTOR(31 downto 0));

  end component;


signal decoderTORegisters : STD_LOGIC_VECTOR(31 downto 0);

type register_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0); --Create an array type
signal registersTOMuxs : register_array := (others => (others => '0')); --Create the signels


begin

	DecoderForRegFile : DF_5to32_Decoder Port Map(
		D_IN => iRd,
        	F_OUT => decoderTORegisters,
		enable => iWriteEnable);

	gen_regis : for i in 0 to 31 generate
    -- Special case for register 0: Always zero
    register0_inst : if i = 0 generate
        registersTOMuxs(0) <= (others => '0');  -- Constant zero
    end generate register0_inst;

    -- All other registers: standard behavior
    register32bit_inst : if i /= 0 generate
        n_bit_register_inst : n_bit_register
            Port map (
                iClk => iClock,
                Rst  => iReset,
                We   => decoderTORegisters(i),
                D    => iData,
                Q    => registersTOMuxs(i)
            );
    end generate register32bit_inst;
	end generate gen_regis;

	Mux1 : bit32_32_1Mux port map(
    	sclt        => iRs,
    	datainput0  => registersTOMuxs(0),
    	datainput1  => registersTOMuxs(1),
    	datainput2  => registersTOMuxs(2),
   	datainput3  => registersTOMuxs(3),
    	datainput4  => registersTOMuxs(4),
    	datainput5  => registersTOMuxs(5),
    	datainput6  => registersTOMuxs(6),
    	datainput7  => registersTOMuxs(7),
    	datainput8  => registersTOMuxs(8),
    	datainput9  => registersTOMuxs(9),
    	datainput10 => registersTOMuxs(10),
    	datainput11 => registersTOMuxs(11),
    	datainput12 => registersTOMuxs(12),
    	datainput13 => registersTOMuxs(13),
    	datainput14 => registersTOMuxs(14),
    	datainput15 => registersTOMuxs(15),
    	datainput16 => registersTOMuxs(16),
    	datainput17 => registersTOMuxs(17),
    	datainput18 => registersTOMuxs(18),
    	datainput19 => registersTOMuxs(19),
    	datainput20 => registersTOMuxs(20),
    	datainput21 => registersTOMuxs(21),
    	datainput22 => registersTOMuxs(22),
    	datainput23 => registersTOMuxs(23),
    	datainput24 => registersTOMuxs(24),
    	datainput25 => registersTOMuxs(25),
    	datainput26 => registersTOMuxs(26),
    	datainput27 => registersTOMuxs(27),
    	datainput28 => registersTOMuxs(28),
    	datainput29 => registersTOMuxs(29),
    	datainput30 => registersTOMuxs(30),
    	datainput31 => registersTOMuxs(31),
    	data_OUT    => oRead1
  	);


	Mux2 : bit32_32_1Mux port map(
    	sclt        => iRt,
    	datainput0  => registersTOMuxs(0),
    	datainput1  => registersTOMuxs(1),
    	datainput2  => registersTOMuxs(2),
   	datainput3  => registersTOMuxs(3),
    	datainput4  => registersTOMuxs(4),
    	datainput5  => registersTOMuxs(5),
    	datainput6  => registersTOMuxs(6),
    	datainput7  => registersTOMuxs(7),
    	datainput8  => registersTOMuxs(8),
    	datainput9  => registersTOMuxs(9),
    	datainput10 => registersTOMuxs(10),
    	datainput11 => registersTOMuxs(11),
    	datainput12 => registersTOMuxs(12),
    	datainput13 => registersTOMuxs(13),
    	datainput14 => registersTOMuxs(14),
    	datainput15 => registersTOMuxs(15),
    	datainput16 => registersTOMuxs(16),
    	datainput17 => registersTOMuxs(17),
    	datainput18 => registersTOMuxs(18),
    	datainput19 => registersTOMuxs(19),
    	datainput20 => registersTOMuxs(20),
    	datainput21 => registersTOMuxs(21),
    	datainput22 => registersTOMuxs(22),
    	datainput23 => registersTOMuxs(23),
    	datainput24 => registersTOMuxs(24),
    	datainput25 => registersTOMuxs(25),
    	datainput26 => registersTOMuxs(26),
    	datainput27 => registersTOMuxs(27),
    	datainput28 => registersTOMuxs(28),
    	datainput29 => registersTOMuxs(29),
    	datainput30 => registersTOMuxs(30),
    	datainput31 => registersTOMuxs(31),
    	data_OUT    => oRead2
  	);

end structural;