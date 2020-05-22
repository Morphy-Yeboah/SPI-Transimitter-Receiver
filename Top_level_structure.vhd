-------------------------------------------------------------------------------
--
-- Title       : Top_level_structure
-- Design      : Spi_Sys
-- Author      : Morphy Yeboah
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Morphy\Desktop\ESE Backup\MMOP\lab8\Spi_Sys\src\Top_level_structure.vhd
-- Generated   : Mon Apr 27 20:00:17 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Top_level_structure} architecture {Top_level_structure}}

	  library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;
 library work;
 use work.all;

entity SPI_test_system_I is
	
	port(
	rst_bar : in std_logic;
	clk : in std_logic;
	send: in std_logic;
	cpol, cpha : in std_logic;
	data_in : in std_logic_vector(7 downto 0);
	mosi : out std_logic;
	sck : out std_logic;
	ss_bar : out std_logic
	
	);
	
	
	
end SPI_test_system_I;

--}} End of automatically maintained section

architecture Top_level_arch of SPI_test_system_I is
	 signal out1: std_logic;
	
begin
	 
	
	 Pos_edge: entity send_pos_edge_det port map( rst_bar => rst_bar, clk => clk, send => send, send_en => out1);
	 Shifter: entity spi_tx_shifter port map( rst_bar => rst_bar, clk => clk, data_in => data_in, send_en => out1, txd => mosi, sck => sck, ss_bar => ss_bar, cpol => cpol, cpha => cpha);
	
	
	

end Top_level_arch;		






		   

















