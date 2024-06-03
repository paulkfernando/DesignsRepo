/*
I mispelled ShiftRegister as SwitchRegister and did not notice till to late so I stuck with it.
Anyways the following code was implemented on the FPGA, and results should be viewable by this unlisted
link, https://youtu.be/AJlm0Rntfcs . To see the setup check out the setupPic in the main directory. Din was simulated
using an array of switches. Furthermore, I had trouble implementing dout as "dout: out std_logic_vector (...)", so 
I just implemented it as a buffer, will look into that further.
*/


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SwitchRegister is
	port(
		clk: in std_logic; --Internal 50MHz clk
		rst: in std_logic; --Button 2
		en: in std_logic; --SW9
		din: in std_logic_vector(7 downto 0); --SW7 to SW0 (index 7: MSB 0: LSB)
		dout: buffer std_logic_vector(7 downto 0) --LED7 to LED0 (index 7: MSB 0: LSB)
	);
end entity;

architecture rtl of SwitchRegister is
	constant CYCLES : unsigned(25 downto 0) := to_unsigned(50000000, 26);
	signal counter : unsigned(25 downto 0) :=  (others => '0');
	signal clk_1hz : std_logic := '0';
	signal i : integer := 0;
begin

	clkProc : process(clk, rst)
	begin
		if rst = '0' then
			counter <=(others=>'0');
		elsif rising_edge(clk) then
			if counter = CYCLES then
				counter <= (others => '0');
				clk_1hz <= not clk_1hz;
			else	
				counter <= counter + 1;
			end if;
		end if;
	end process clkProc;
	
	shiftRegProc : process(clk_1hz, rst)
	begin
		if rst = '0' then
		  dout <= (others=>'0');
			i <= 0;
		elsif rising_edge(clk_1hz) then
			if en = '1' then
				if i < 8 then
					dout <= din(i) & dout(dout'left downto 1);
					i <= i + 1;
				end if;
			end if;
		end if;
	end process;
	
	
end architecture;