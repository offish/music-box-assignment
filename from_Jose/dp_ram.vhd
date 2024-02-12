-- Listing 11.1
-- Single-port 1K x 8 RAM with read always enabled
-- Modified from XST 8.1i rams_07

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ram_block is
   generic(
      ADDR_WIDTH: integer:=10;
      DATA_WIDTH: integer:=8
   );
   port(
      clk: in std_logic;
      wr: in std_logic;
      address: in std_logic_vector(ADDR_WIDTH-1 downto 0);
      data_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
      data_out: out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end ram_block;

architecture arch of ram_block is
   type ram_type is array (2**ADDR_WIDTH-1 downto 0)
        of std_logic_vector (DATA_WIDTH-1 downto 0);
   signal ram: ram_type;

begin
   process (clk)
   begin
      if rising_edge(clk) then
         if (wr='1') then
            ram(to_integer(unsigned(address))) <= data_in;
         end if;
      end if;
   end process;
   data_out <= ram(to_integer(unsigned(address)));

end arch;