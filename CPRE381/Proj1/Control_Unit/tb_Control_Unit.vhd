library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.textio.all;

entity tb_Control_Unit is
  generic(gCLK_HPER : time := 10 ns);
end tb_Control_Unit;

architecture mixed of tb_Control_Unit is

  --Define the total clock period
  constant cCLK_PER : time := gCLK_HPER * 2;

  --Component Declaration
  component Control_Unit
    port(
      iOpcode     : in  std_logic_vector(5 downto 0);
      iFunct      : in  std_logic_vector(5 downto 0);
      oRegWrite   : out std_logic;
      oMemtoReg   : out std_logic;
      oMemWrite   : out std_logic;
      oMemRead    : out std_logic;
      oRegDst     : out std_logic;
      oALUSrc     : out std_logic;
      oALUOp      : out std_logic_vector(3 downto 0);
      oBranch     : out std_logic;
      oJump       : out std_logic
    );
  end component;

  --Signals
  signal s_iOpcode   : std_logic_vector(5 downto 0) := (others => '0');
  signal s_iFunct    : std_logic_vector(5 downto 0) := (others => '0');

  signal s_oRegWrite : std_logic;
  signal s_oMemtoReg : std_logic;
  signal s_oMemWrite : std_logic;
  signal s_oMemRead  : std_logic;
  signal s_oRegDst   : std_logic;
  signal s_oALUSrc   : std_logic;
  signal s_oALUOp    : std_logic_vector(3 downto 0);
  signal s_oBranch   : std_logic;
  signal s_oJump     : std_logic;

begin

  --DUT Instantiation
  DUT0: Control_Unit
    port map(
      iOpcode     => s_iOpcode,
      iFunct      => s_iFunct,
      oRegWrite   => s_oRegWrite,
      oMemtoReg   => s_oMemtoReg,
      oMemWrite   => s_oMemWrite,
      oMemRead    => s_oMemRead,
      oRegDst     => s_oRegDst,
      oALUSrc     => s_oALUSrc,
      oALUOp      => s_oALUOp,
      oBranch     => s_oBranch,
      oJump       => s_oJump
    );

  
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER / 2;

    --R-type: ADD
    s_iOpcode <= "000000";
    s_iFunct  <= "100000"; -- ADD
    wait for cCLK_PER;

    --I-type: ADDI
    s_iOpcode <= "001000";
    s_iFunct  <= "000000"; -- when funct is unused do this
    wait for cCLK_PER;

    --I-type: ANDI
    s_iOpcode <= "001100";
    s_iFunct  <= "000000";
    wait for cCLK_PER;

    --Memory: LW
    s_iOpcode <= "100011";
    s_iFunct  <= "000000";
    wait for cCLK_PER;

    --Memory: SW
    s_iOpcode <= "101011";
    s_iFunct  <= "000000";
    wait for cCLK_PER;

    --Branch: BEQ
    s_iOpcode <= "000100";
    s_iFunct  <= "000000";
    wait for cCLK_PER;

    --Branch: BNE (should still output ALUOp = 0110)
    s_iOpcode <= "000101";
    s_iFunct  <= "000000";
    wait for cCLK_PER;

    --Jump: J
    s_iOpcode <= "000010";
    s_iFunct  <= "000000";
    wait for cCLK_PER;

    --Jump: JAL
    s_iOpcode <= "000011";
    s_iFunct  <= "000000";
    wait for cCLK_PER;

    --R-type: SLL
    s_iOpcode <= "000000";
    s_iFunct  <= "000000"; -- SLL
    wait for cCLK_PER;

    --R-type: SRA
    s_iOpcode <= "000000";
    s_iFunct  <= "000011"; -- SRA
    wait for cCLK_PER;

    wait;
  end process;

end mixed;

