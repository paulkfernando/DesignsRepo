library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity PWMLed is 
port
(
	clk: in std_logic;
	led0: out std_logic
);
end entity;

architecture rtl of PWMLed is
	signal counter : unsigned(25 downto 0) := (others => '0');
	constant delay_val : unsigned(25 downto 0) := to_unsigned(50000000, 26);
begin
	proc : process(clk)
	begin
		if rising_edge(clk) then
			if counter = delay_val then
				counter <= (others => '0');
			else
				counter <= counter + 1;
			end if;
			if counter < 25000000 then
				led0 <= '0';
			else
				led0 <= '1';
			end if;
		end if;
	end process;
end architecture;