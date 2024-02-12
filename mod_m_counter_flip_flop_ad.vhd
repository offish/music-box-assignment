-- Listing 4.11
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mod_m_counter_flip_flop is
   generic(
      N: integer := 18;     -- after code converted from ascii
  );
   port(
      clock, reset: in std_logic;
      --the musical note is the var below
   mod_counter_input: in std_logic_vector(N-1 downto 0); 
      zero_tick: out std_logic;
      q: out std_logic_vector(N-1 downto 0) -- current count value
   );
end mod_m_counter_flip_flop;

architecture arch of mod_m_counter_flip_flop is
   signal r_reg: unsigned(N-1 downto 0);
   signal r_next: unsigned(N-1 downto 0);
begin
   -- register
   process(clock,reset)
   begin
      if (reset='1') then
         r_reg <= (others=>'0');
      elsif rising_edge(clock) then --rising edge
         r_reg <= r_next;
      end if;
   end process;
   -- next-state logic
   r_next <= unsigned(mod_counter_input) when r_reg=0 else
             r_reg - 1;
   -- output logic
   q <= std_logic_vector(r_reg);
  zero_tick <= '1' when r_reg=0 else '0';
end arch;