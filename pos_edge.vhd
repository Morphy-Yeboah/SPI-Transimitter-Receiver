-------------------------------------------------------------------------------
--
-- Title       : pos_edge
-- Design      : Spi_Sys
-- Author      : Morphy Yeboah 
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\Users\Morphy\Desktop\ESE Backup\lab8\Spi_Sys\src\pos_edge.vhd
-- Generated   : Sun Apr 26 14:16:32 2020
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
--{entity {pos_edge} architecture {pos_edge}}

 library ieee;
 use ieee.std_logic_1164.all;
 library work;
 use work.all;

entity send_pos_edge_det is
	
	port (
	rst_bar : in std_logic;	
	clk : in std_logic;
	send : in std_logic;
	send_en : out std_logic
	
	
	);
	
	
end send_pos_edge_det;

architecture pos_edge_det of send_pos_edge_det is 
	type state is (state_a, state_b, state_c);
	signal present_state, next_state : state;

begin
	
	state_reg: process(rst_bar, clk, send)
	begin
		
		if rst_bar = '0' then 
		  present_state <= state_a;
		elsif rising_edge(clk) then 
			present_state <= next_state;
		end if;
			
	end process;  
	
	outputs: process (present_state)
	begin
		case present_state is 
			when state_c => send_en <= '1';
			when others => send_en <= '0';
		end case;
	end process;
	
	nxt_state: process(present_state, send)
	begin
		case present_state is 
			when state_a => 
			if send = '0' then 
				next_state <= state_b;
			else
				next_state <= state_a;
			end if;
			
			when state_b => 
			if send = '1'then 
				next_state <= state_c;
			else
				next_state <= state_a;
			end if;
			
			when others => 
			if send = '0' then 
				next_state <= state_b;
			else
				next_state <= state_a;
			end if;
		end case;
			
	end process;
			
				
end pos_edge_det;

--}} End of automatically maintained section


