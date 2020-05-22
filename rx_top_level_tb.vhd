-------------------------------------------------------------------------------
--
-- Title       : rx_top_level_tb
-- Design      : Spi_tx_rc
-- Author      : Morphy Yeboah
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\Users\Morphy\Desktop\ESE Backup\Lab_9\Spi_tx_rc\src\rx_top_level_tb.vhd
-- Generated   : Mon May 11 02:00:37 2020
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
--{entity {rx_top_level_tb} architecture {rx_top_level_tb}}
 
	
	library ieee;
use ieee.std_logic_1164.all;
library work;
use work.all;
use ieee.numeric_std.all;
--library mesmerize;	-- Specifying library containing mesmerize
--use mesmerize.all;	-- explicitly


entity rx_top_level_tb is
end rx_top_level_tb;


 

--}} End of automatically maintained section

 

architecture spi_tb_arch of rx_top_level_tb is 

signal rst_bar: std_logic;
signal clk: std_logic;
signal send: std_logic;                      
signal cpol, cpha :  std_logic;
signal dord : std_logic;
signal	miso :  std_logic;

signal data_out : std_logic_vector(7 downto 0);
signal mosi: std_logic;
signal	sck :  std_logic;
signal	ss_bar :  std_logic;


signal data_in :  std_logic_vector(7 downto 0) := x"ca";
constant period : time := 40ns;
signal end_sim: boolean := false;
signal loopback : std_logic;


begin
UUT: entity SPI_test_system_II
 port map(rst_bar=>rst_bar, clk=>clk,  
 send => send, 
 cpol => cpol, 
 cpha=> cpha,
 dord => dord,	
 miso => miso,
 
 data_in => data_in, 
 data_out => data_out, 
 mosi => mosi,
 sck => sck, 
 ss_bar => ss_bar
 );                         
 
 
 
 loopback <= mosi;
 miso <= loopback;
 
 
 
 clock: process   --System clock
	   begin
		  clk <= '0';                                                   
			loop      
			wait for period/2;
			 clk <= not clk;                
			 exit when end_sim = true;
			 end loop;
				wait;        -- stop clock

end process;   

reset: process 
begin 
	rst_bar <= '0';
	for i in 1 to 2 loop
		wait until clk = '1';
	end loop;
	rst_bar <= '1';
	wait;
end process;


Pushbutton: process 
begin
	send <= '0';
	cpol <= '0';
	cpha <= '0';
	dord <= '0';
	wait for 4 * period;
	for i in 0 to 7 loop
		(dord, cpol, cpha) <= to_unsigned(i, 3);
		wait for 2 * period;
		send <= '1';
		wait for 20 * period;
		send <= '0';
		wait for 2 * period;
	end loop;
	end_sim <= true;
end process;


 end spi_tb_arch;