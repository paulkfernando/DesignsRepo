library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity EightBitMux_tb is
end entity;

architecture rtl of EightBitMux_tb is

	component EightBitMux is
		port (
			clk: in std_logic; -- 50MHz built in internal clock
			rst: in std_logic; -- Using 1 button to drive reset signal
			inputVec: in std_logic_vector(2 downto 0); --Using 3 switches to drive "Select" signal
			ledVec: out std_logic_vector(7 downto 0) --Output
		);
	end component;
	
	signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal inputVec: std_logic_vector(2 downto 0) := (others => '0');
    signal ledVec: std_logic_vector(7 downto 0);
	constant clkT: time := 20 ns; -- Period of simulated 50 MegaHertz clk

begin

		clkProc: process
		begin
			while true loop
				clk <= '0';
				wait for clkT/2;
				clk <= '1';
				wait for clkT/2;
			end loop;
		end process clkProc;
	
		UUT: EightBitMux 
		port map (
			clk => clk,
			rst =>  rst,
			inputVec => inputVec,
			ledVec => ledVec
		);
		
		main: process
		begin
			rst <= '0';
			wait for 50 ns;
			rst <= '1';
			wait for 50 ns;
			
			--testing all binary input values from 0 - 7
			for i in 0 to 7 loop
				inputVec <= std_logic_vector(to_unsigned(i, 3));
				wait for 40 ns;
			end loop;
			wait;
		end process;


end rtl;