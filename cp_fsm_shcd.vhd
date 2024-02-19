----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Shahin Ostadahmadi and Christopher Daffinrud
-- 
-- Create Date: 12.02.2024 12:56:52
-- Design Name: 
-- Module Name: cp_fsm_shcd - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity cp_fsm_shcd is
    generic(
        --ADDR_WIDTH: integer:=10;
        DATA_WIDTH: integer:=8
        );
    Port ( 
           reset, clock : in STD_LOGIC;
           rx_done : in STD_LOGIC;
           ascii_received : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           clear: out STD_LOGIC;
           increment: out STD_LOGIC;
           write_to_ram_enable : out STD_LOGIC;
           ascii_transmitted : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           timer_start : out STD_LOGIC;
           timer_done : in STD_LOGIC;
           clear_flipflop : out STD_LOGIC);
end cp_fsm_shcd;

architecture Behavioral of cp_fsm_shcd is
type states is (initial, readFromUART, playFromRAM);
signal st_reg, st_nxt : states;

begin

-- State Register
process(clock, reset)
    begin
    if (reset ='1') then
        st_reg <= initial;
    elsif rising_edge(clock) then
        st_reg <= st_nxt;
    end if;
end process; 

process(st_reg, rx_done, ascii_received, ascii_transmitted, timer_done)
    begin
    st_nxt <= st_reg;
    clear_flipflop <= '0';
    timer_start <= '0';
    write_to_ram_enable <= '0';
    clear <= '0';
    increment <= '0';
    
    case st_reg is 
        when initial =>
            clear_flipflop <= '1';
            clear <= '1';
            st_nxt <= readFromUART;
            
        when readFromUART =>
            increment <= '0';
            if (rx_done = '1') then
                if (ascii_received = x"41" or ascii_received = x"61" or -- A or a
                    ascii_received = x"42" or ascii_received = x"62" or -- B or b
                    ascii_received = x"43" or ascii_received = x"63" or -- C or c
                    ascii_received = x"44" or ascii_received = x"64" or -- D or d
                    ascii_received = x"45" or ascii_received = x"65" or -- E or e
                    ascii_received = x"46" or ascii_received = x"66" or -- F or f
                    ascii_received = x"47" or ascii_received = x"67" or -- G or g
                    ascii_received = x"48" or ascii_received = x"68") then -- H or h
                    
                    write_to_ram_enable <= '1';
                    increment <= '1';
                end if;
                if (ascii_received = x"0D") then -- Enter
                    write_to_ram_enable <= '1';
                    clear <= '1';
                    timer_start <= '1';
                    st_nxt <= playFromRAM;
                end if;
            end if;
        when playFromRAM =>
            clear_flipflop <= '0';
            increment <= '0';
            timer_start <= '0';
            if (ascii_transmitted = x"0D") then -- If value in RAM is Enter
                st_nxt <= initial;
            else
                if (timer_done = '1') then
                    increment <= '1';
                    timer_start <= '1';
                end if;
            end if;
    end case;
end process;
end Behavioral;
