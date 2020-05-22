-------------------------------------------------------------------------------
--
-- Title       : Spi_tx_shifter
-- Design      : Spi_tx_rc
-- Author      : Morphy Yeboah
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\Users\Morphy\Desktop\ESE Backup\Lab_9\Spi_tx_rc\src\Spi_tx_shifter.vhd
-- Generated   : Sun May 10 23:32:04 2020
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
--{entity {Spi_tx_shifter} architecture {Spi_tx_shifter}}



	 library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;
 library work;
 use work.all;


entity spi_tx_shifter is 
	port(
	rst_bar : in std_logic;
	clk : in std_logic;
	cpol, cpha : in std_logic := '0';
	dord : in std_logic := '0'; -- data order
	send_en : in std_logic;
	data_in : in std_logic_vector(7 downto 0);
	txd : out std_logic;
	sck : out std_logic;
	ss_bar : out std_logic;
	spi_rxen : out std_logic -- enable receiver to shift data
	);
	
	
end spi_tx_shifter;

--}} End of automatically maintained section

architecture spi_tx_arch of spi_tx_shifter  is

type state is (idle, ph1, ph2, ph3, ph4, ph5, ph6, ph7, ph8);
signal present_state, next_state : state;
signal bit_addr : unsigned(2 downto 0); 
 

begin 
	
		
		state_reg: process (clk, rst_bar)
		begin 
			if rst_bar = '0' then 
				present_state <= idle;
				
			elsif rising_edge(clk) then 
				present_state <= next_state;
			
		
				end if;
		end process;	
		
		
			
	
	   nxt_state: process (present_state, send_en, bit_addr) 
	   			  
	   begin   

		   case present_state is 
			   when idle =>			   			
			   if send_en = '1' then 
				   next_state <= ph1;
			
			   else 
				   next_state <= idle;		   
			   end if;
			   
			   when ph1 => 
			   
			   next_state <= ph2;
		   when ph2 =>
			  				   
			   next_state <= ph3;

			   when ph3 => 
			  
			   next_state <= ph4;  
			   
			    when ph4 => 
			  
				next_state <= ph5; 
				
				 when ph5 => 
			  
				 next_state <= ph6;
				 
				  when ph6 => 
			  
				  next_state <= ph7; 
				  
				   when ph7 => 
			  
				   next_state <= ph8;
				   
				 
				 
				 when ph8 => 
				 if bit_addr = "000" then
				   next_state <= idle;
				   
				 else
					 next_state <= ph1;
					 end if;
					 
		end case;
		
   
	   end process;
	   
	   
	   output: process (present_state, data_in, bit_addr)
	   	 	
	   begin	 
		   
		   
		   
		   Mode_0: case present_state is 
			   when idle =>
			   	
			   sck <= (cpol and cpha) and dord;
			   ss_bar <= '1';
			   txd <= data_in(to_integer(bit_addr));
			   spi_rxen <= data_in(to_integer(bit_addr + 1));
			   	 
			  
			   when ph1 =>
			   
			   sck <= (cpol and  cpha) and dord;
			   ss_bar <= '0';
			   txd <= data_in(to_integer(bit_addr));
			    spi_rxen <= data_in(to_integer(bit_addr - 1 ));
			   
			   
			   when ph2 =>
			   
			   sck <= (not cpol and  cpha) and not dord;
			   ss_bar <= '0';
			   txd <= data_in(to_integer(bit_addr));
			   spi_rxen <= data_in(to_integer(bit_addr + 1 ));
			   
			   
			   when ph3 => 			  
			   		 sck <= (not cpol and  not cpha) and dord;
			   ss_bar <= '0';
			   txd <= data_in(to_integer(bit_addr)); 
			   spi_rxen <= data_in(to_integer(bit_addr - 1 ));
			   

			   when ph4 =>
			  
				   sck <=  (cpol and  not cpha) and not dord;
				   ss_bar <= '0';
				   txd <= data_in(to_integer(bit_addr));
	   			   spi_rxen <= data_in(to_integer(bit_addr + 1 )); 
					  
				 when ph5 =>
			  
				   sck <=  (cpol and   cpha) and not dord;
				   ss_bar <= '0';
				   txd <= data_in(to_integer(bit_addr));
	   			   spi_rxen <= data_in(to_integer(bit_addr + 1 ));
					  
					   when ph6 =>
			  
				   sck <=  (cpol and  not cpha) and  dord;
				   ss_bar <= '0';
				   txd <= data_in(to_integer(bit_addr));
	   			   spi_rxen <= data_in(to_integer(bit_addr - 1 ));
					  
					  when ph7 =>
			  
				   sck <=  (not cpol and  cpha) and  dord;
				   ss_bar <= '0';
				   txd <= data_in(to_integer(bit_addr));
	   			   spi_rxen <= data_in(to_integer(bit_addr - 1 ));
					  
					   when ph8 =>
			  
				   sck <=  (not cpol and  not cpha) and not dord;
				   ss_bar <= '0';
				   txd <= data_in(to_integer(bit_addr));
	   			   spi_rxen <= data_in(to_integer(bit_addr + 1 ));
				   
				   
		   end case;
		   

	 end process;
	   
	 bit_counter: process (rst_bar, clk, present_state)
	 
	   	  begin
				 
			if rst_bar = '0' or present_state = idle then
				bit_addr <= "111";
				
				 
			elsif rising_edge(clk)  then
				if present_state = ph8 then
					if bit_addr /= "000" then 
						bit_addr <= bit_addr - 1; 
					end if;	
				
				

			end if;

				
			 end if;
			
			
			end process;
			
			
				 
				 
	   
	   
	   
	  	   
end spi_tx_arch;

