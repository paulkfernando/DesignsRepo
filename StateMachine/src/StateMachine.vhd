library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity StateMachine is
port
(
	clk : in std_logic;	
	sw  : in std_logic_vector(2 downto 0);
	led : out std_logic_vector(2 downto 0)
);

end entity;

architecture rtl of StateMachine is

type StateMachineType is (STATE0, STATE1, STATE2);

signal StateVar : StateMachineType := STATE0;
signal counter : unsigned(25 downto 0) := (others => '0');
constant delay_val : unsigned(25 downto 0) := to_unsigned(50000000, 26);


begin
	proc : process(clk)
	begin
		if rising_edge(clk) then
		
			if counter = delay_val then
				counter <= (others => '0');
				
				case StateVar is
					when STATE0 =>
						led <= "001";
						if sw(0) = '1' then
							StateVar <= STATE1;
						end if;
					when STATE1 =>
						led <= "010";
						if sw(1) = '1' then
							StateVar <= STATE2;
						end if;
					when STATE2 =>
						led <= "100";
						if sw(2) = '1' then
							StateVar <= STATE0;
						end if;
					when others =>
						StateVar <= STATE0;
				end case;
			
			
			else
				counter <= counter + 1;
			end if;
		
		end if;
	end process;
	
end architecture;



-- 50 MHz clk, has a period (T, 1/f) of 1/50MHz = 20ns (20*10^(-9)s)
-- In 1 second there are, (1*10^9)/20, 50 000 000 cycles
-- A 25 bit unsigned binary represents 0 to, (2^25 - 1), 33554431
-- This is too small to represent the number of cycles, so we can use a 26 bit binary
-- Which would represent up to 67108863
-- So we initialize a counter and delay, and count up to 50000000 every cycle
-- Which takes 1 second, hence the one second delay. 