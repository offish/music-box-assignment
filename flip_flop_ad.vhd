library ieee;
use ieee.std_logic_1164.all;
-- libraries for the testbench

entity ff is
    port(
        clock, reset ,zero_tick,mute: in std_logic; --inputs
        square_wave_loudspeaker : out std_logic -- output, all one bit
    );
    end ff;

architecture arch of ff is
    signal r_reg,r_next : std_logic;
    begin
        -- the code for the flip flop
    process(clock,reset) --indicates that everything executes sequentially
    begin
    if(reset = '1') then
        r_reg <='0';
    elsif rising_edge(clock) then --when clock is high then state is copied
        r_next <= r_reg;
    end if;
end process;

--the next state
process(r_reg,mute,zero_tick)
begin
if (mute = '1') then
    r_next <= '0';
elsif (zero_tick = '1') then
    r_next <= not(r_reg);
else
    r_next <= r_reg;
end if;
end process;
-- the speaker is toggled based on the flip-flop's current state
square_wave_loudspeaker <= r_reg;

end arch;
    


                          

    



