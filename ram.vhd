library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
    generic(
        addr_width : integer := 8;
        data_width : integer := 8;
        block_size : integer := 8
    );
port (
    clk : in std_logic;
    wrt : in std_logic;
    address : in integer;
    data_in : in std_logic_vector(data_width-1 downto 0);
    data_out : out std_logic_vector(data_width-1 downto 0)
);
end RAM;


architecture Behaviour of RAM is
 type ram_block is array (2**block_size-1 downto 0) 
    of std_logic_vector(data_width-1 downto 0);

    signal ram : ram_block;

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if wrt = '1' then
                ram(address) <= data_in;
            end if;
        end if;
    end process;

    data_out <= ram(address);

end Behaviour;


