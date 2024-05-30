library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity EightBitMux is
port (
	clk: in std_logic; -- 50MHz built in internal clock
	rst: in std_logic; -- Using 1 button to drive reset signal
	inputVec: in std_logic_vector(2 downto 0); --Using 3 switches to drive "Select" signal
	ledVec: out std_logic_vector(7 downto 0) --Output
);
end entity;

architecture rtl of EightBitMux is
begin
	muxProc: process(rst, clk)
	begin
		if rst = '0' then
			ledVec <= "10101010";
		elsif rising_edge(clk) then
			case to_integer(unsigned(inputVec)) is
				when 0 =>
					ledVec <= "00000001";
				when 1 => 
					ledVec <= "00000010";
				when 2 =>
					ledVec <= "00000100";
				when 3 => 
					ledVec <= "00001000";
				when 4 =>
					ledVec <= "00010000";
				when 5 => 
					ledVec <= "00100000";
				when 6 =>
					ledVec <= "01000000";
				when 7 => 
					ledVec <= "10000000";
				when others =>
					ledVec <= "00000000";
			end case;
		end if;
	end process;
end architecture; 