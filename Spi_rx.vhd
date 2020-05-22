library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spi_rx_shifter is
    port(
        rxd: in std_logic;
        rst_bar:in std_logic;
        clk: in std_logic;
        spi_rxen:in std_logic;
        dord: in std_logic;
        data_out: out std_logic_vector(7 downto 0)
        );
end spi_rx_shifter;

--}} End of automatically maintained section

architecture arch of spi_rx_shifter is
begin

    shift: process(clk,rst_bar,spi_rxen,dord)
    variable D: std_logic_vector(7 downto 0);
    begin
        if rst_bar='0' then
            D:="00000000";
        elsif rising_edge(clk) then
            if spi_rxen='1' then
                if dord='0' then             
                    D(7):=D(6);                
                    D(6):=D(5);
                    D(5):=D(4);
                    D(4):=D(3);
                    D(3):=D(2);
                    D(2):=D(1);
                    D(1):=D(0);
                    D(0):=rxd;
                    
                else                           
                    D(0):=D(1);                   
                    D(1):=D(2);
                    D(2):=D(3);
                    D(3):=D(4);
                    D(4):=D(5);
                    D(5):=D(6);
                    D(6):=D(7);
                    D(7):=rxd;
                end if;                 
            end if;
        end if;
        data_out<=D;
    end process;                

end arch;