

--This works similar to the ShiftRegister (that I named SwitchRegister by mistake), however,
--where the ShiftRegister was essentially SISO, the Serialiser is basically PISO, din is an array
--of switch inputs, when the ld button is pressed dataReg is given the values of din (parallel in),
--then when the shift enable (en) button is held down, data from dataReg is shifted right (serially) 
--into dout, which lights or offs and led representing dout. 


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Serialiser is
	port(
		clk: in std_logic;                -- Main clock input
		rst: in std_logic;                -- Reset input, B[0]
		en: in std_logic;                 -- Enable input, B[2]
		ld: in std_logic;                 -- Load input, B[1]
		din: in std_logic_vector(7 downto 0); -- Data input (parallel)
		dout: out std_logic               -- Data output (serial)
	);
end entity;

architecture rtl of Serialiser is
	constant CYCLES : unsigned(25 downto 0) := to_unsigned(25000000, 26); -- Divider for 1 Hz clock
	signal dataReg: std_logic_vector(7 downto 0); -- Register to hold the data
	signal counter : unsigned(25 downto 0) := (others => '0'); -- Counter for clock division
	signal clk_1hz : std_logic := '0'; -- 1 Hz clock signal
begin

	-- Clock divider process
	clkProc : process(clk, rst)
	begin
		if rst = '0' then
			counter <= (others => '0');
		elsif rising_edge(clk) then
			if counter = CYCLES then
				counter <= (others => '0'); 
				clk_1hz <= not clk_1hz; 
			else
				counter <= counter + 1; 
			end if;
		end if;
	end process clkProc;
	
	-- Serialisation process
	SerialProc : process(clk_1hz, rst)
	begin
		if rst = '0' then
			dataReg <= (others => '0'); 
		elsif rising_edge(clk_1hz) then
			if ld = '0' then
				dataReg <= din; 
			elsif en = '0' then
				dataReg <= '0' & dataReg(7 downto 1); -- Shift right
			end if;
		end if;
	end process SerialProc;
	
	-- Output the LSB of the data register
	dout <= dataReg(0);

end architecture rtl;
