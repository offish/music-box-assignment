library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram_address_counter is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           increment: in  STD_LOGIC;
           address : out  integer
           );
end ram_address_counter;

architecture Behaviour of ram_address_counter is
     signal ram_address :integer;
     

begin
    process(clk)
    begin
        if (clr='1' and increment='0') then
            ram_address <=0;
        end if;
        if (clr='0' and increment='1') then
            ram_address <= ram_address+1;
        end if;
    end process;

        
end Behaviour;


