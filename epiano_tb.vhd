----------------------------------------------------------------------------------
-- 
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity epiano_tb is
   -- Port ();
end epiano_tb;

architecture arch of epiano_tb is
constant clk_period : time := 10 ns;

Component epiano
Port ( clk, rst: in std_logic;
       mute: in std_logic;
       mcnt_in: in std_logic_vector(17 downto 0);
       sqwave: out std_logic
      );
end Component;

signal clk, rst: std_logic;
signal mute, sqwave: std_logic;
signal mcnt_in: std_logic_vector(17 downto 0);

begin

    uut: epiano
    Port Map(clk => clk, rst => rst, 
             mute => mute, mcnt_in => mcnt_in, sqwave => sqwave);
    
    clk_process: process 
            begin
               clk <= '0';
               wait for clk_period/2;
               clk <= '1';
               wait for clk_period/2;
            end process; 
        
     stim: process
        begin
        rst <= '1';
        mute <= '0';
        mcnt_in <= "000001011101110000";
        wait for clk_period;        
        rst <= '0';
        wait;
       
        end process;

end arch;
