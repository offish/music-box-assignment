-- top level of the e-piano

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity epiano is
   generic( 
      ADDR_WIDTH: integer:=10;
      DATA_WIDTH: integer:=8
   );
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           mute : in STD_LOGIC;
           mcnt_in : in STD_LOGIC_VECTOR(17 downto 0);
           sqwave : out  STD_LOGIC);
end epiano;

architecture struct_arch of epiano is
signal zero_tick: std_logic;

begin
	-- instantiate mod-m counter (T flip-flop)
	mod_m_t_ff_unit: entity work.mod_m_t_ff(arch)
		port map(clk => clk, rst => rst, mcnt_in => mcnt_in, zero_tick => zero_tick);		
		
	-- instantiate T flip-flop
	t_ff_en_unit: entity work.t_ff_en(arch)
		port map(clk => clk, rst => rst, zero_tick => zero_tick, 
					mute => mute, sqwave => sqwave);	

end struct_arch;

