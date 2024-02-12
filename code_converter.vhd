-- modified jose code
library IEEE; 
use IEEE.std_logic_1164.all;

entity code_converter is
    Port ( ram_data : in  STD_LOGIC_VECTOR (7 downto 0);
           mcnt_in : out  STD_LOGIC_VECTOR (17 downto 0));
end code_converter;

architecture arch of code_converter is 
begin 
	process (ram_data) 
		begin 
			case ram_data is 
			    when "01000011" => mcnt_in <= "101110101010001001"; -- C4: 71H (C)
			    when "01000100" => mcnt_in <= "101001100100010110"; -- D4: 77H (D) 
			    when "01000101" => mcnt_in <= "100101000010000110"; -- E4: 65H (E) 
			    when "01000110" => mcnt_in <= "100010111101000101"; -- F4: 72H (F) 
			    when "01000111" => mcnt_in <= "011111001001000001"; -- G4: 74H (G) 
			    when "01000001" => mcnt_in <= "011011101111100100"; -- A4: 79H (A) 
			    when "01000010" => mcnt_in <= "011000101101110111"; -- B4: 75H (B) 
			    
			    when "01100011" => mcnt_in <= "010111010101000100"; -- c5: 61H (c) 
			    when "01100100" => mcnt_in <= "010100110010001011"; -- d5: 73H (d) 
			    when "01100101" => mcnt_in <= "010010100001000011"; -- e5: 64H (e) 
			    when "01100110" => mcnt_in <= "010001011110100010"; -- f5: 66H (f) 
			    when "01100111" => mcnt_in <= "001111100100100000"; -- g5: 67H (g) 
			    when "01100001" => mcnt_in <= "001101110111110010"; -- a5: 68H (a) 
			    when "01100010" => mcnt_in <= "001100010110111011"; -- b5: 6AH (b) 
			    when others 	=> mcnt_in <= "000000000000000001";   
			end case; 
	end process; 
end arch;
