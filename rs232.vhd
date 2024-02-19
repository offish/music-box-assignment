library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity rs232 is
    port ( 
        clk, reset, rx : in std_logic;
        output :   out std_logic_vector(7 downto 0)
        );
end rs232;

architecture arch of rs232 is
    signal s_tick, rx_done_tick:    std_logic;
    signal dout:  std_logic_vector(7 downto 0);   

----------------------------------------------------------------------------------
begin

-- Baud generator
    Baud_Generator: entity work.baud_generator(arch)
        port map (  clk=>clk, reset=>reset, to_s_tick=>s_tick );

-- UART 
    UART: entity work.uart_rx(arch)
        port map (  clk=>clk, reset=>reset, rx=>rx, dout=>output,
                    s_tick=>s_tick, rx_done_tick=>rx_done_tick );
    
end arch;