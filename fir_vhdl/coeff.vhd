library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity coeffs is
port( b : out std_logic_vector( 383  downto 0));
end entity;
architecture behavioral of coeffs is
begin
b(11 downto 0) <= "000000000101";
b(23 downto 12) <= "000000000110";
b(35 downto 24) <= "000000001001";
b(47 downto 36) <= "000000001110";
b(59 downto 48) <= "000000010101";
b(71 downto 60) <= "000000011101";
b(83 downto 72) <= "000000101000";
b(95 downto 84) <= "000000110100";
b(107 downto 96) <= "000001000001";
b(119 downto 108) <= "000001001111";
b(131 downto 120) <= "000001011100";
b(143 downto 132) <= "000001101001";
b(155 downto 144) <= "000001110100";
b(167 downto 156) <= "000001111101";
b(179 downto 168) <= "000010000011";
b(191 downto 180) <= "000010000110";
b(203 downto 192) <= "000010000110";
b(215 downto 204) <= "000010000011";
b(227 downto 216) <= "000001111101";
b(239 downto 228) <= "000001110100";
b(251 downto 240) <= "000001101001";
b(263 downto 252) <= "000001011100";
b(275 downto 264) <= "000001001111";
b(287 downto 276) <= "000001000001";
b(299 downto 288) <= "000000110100";
b(311 downto 300) <= "000000101000";
b(323 downto 312) <= "000000011101";
b(335 downto 324) <= "000000010101";
b(347 downto 336) <= "000000001110";
b(359 downto 348) <= "000000001001";
b(371 downto 360) <= "000000000110";
b(383 downto 372) <= "000000000101";

end architecture behavioral;
