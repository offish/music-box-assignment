----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2024 09:43:51
-- Design Name: 
-- Module Name: abc_player_top - Behavioral
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

entity abc_player_top is
generic(
DATA_width : integer:= 8;
addr_width : integer := 8;
N : integer := 18
);
 Port ( 
    clock : in std_logic;
    reset : in std_logic;
    rx_bitstream : in std_logic;
    loudspeaker : out std_logic);
end abc_player_top;

architecture Behavioral of abc_player_top is
signal mcnt_in: std_logic_vector(N-1 downto 0); --mod counter input
signal rx_done : std_logic;
signal wr: std_logic;
signal increment : std_logic;
signal clear : std_logic;
signal ascii_received :STD_LOGIC_VECTOR(DATA_width -1 downto 0);
signal ascii_transmitted : STD_LOGIC_VECTOR(DATA_width -1 downto 0);
signal mcnt_tick : std_logic;
signal timer_on, timer_done: std_logic;
signal address : integer;
signal clr_flipflop : std_logic; -- mute
begin
      
    
    --uart_unit : entity
    uart_unit : entity work.rs232(arch)
    port map(clk => clock, reset => reset,rx => rx_bitstream, output => ascii_received);
    
    --ram
    ram_unit : entity work.ram(behaviour)
    port map(clk=> clock,data_in => ascii_received,data_out => ascii_transmitted,wrt=>wr,address =>address);
    
    --ram address
    ram_address_counter_unit : entity work.ram_address_counter(Behaviour)
    port map(clk =>clock,increment => increment,clr => clear,address => address);
    
    
    --timer_unit
    timer_unit : entity work.timer(arch)
        port map(clk => clock, rst => reset, timer_on =>timer_on,timer_done => timer_done);
    
    --code converter
    code_converter_unit: entity work.code_converter(arch)
		port map(ram_data => ascii_transmitted, mcnt_in => mcnt_in);
		
	--flip flop
	flip_flop_unit: entity work.ff(arch)
	port map(clock => clock, reset => reset, mute =>clr_flipflop,
	 zero_tick =>mcnt_tick,square_wave_loudspeaker =>loudspeaker );
	 
    --flip flop counter
	flip_flop_mod_unit : entity work.mod_m_counter_flip_flop(arch)
	port map(clock => clock, reset => reset,mod_counter_input => mcnt_in,
	 zero_tick => mcnt_tick);
	
	--control path
	control_path_unit : entity work.cp_fsm_shcd(Behavioral)
    port map(clock => clock, reset => reset,rx_done => rx_done,ascii_received => ascii_received,
   clear => clear, increment => increment, write_to_ram_enable => wr,ascii_transmitted =>ascii_transmitted,
   timer_start => timer_on,timer_done => timer_done,clear_flipflop => clr_flipflop);
end Behavioral;
