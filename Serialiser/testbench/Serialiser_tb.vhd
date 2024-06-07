library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Serialiser is
end tb_Serialiser;

architecture behavior of tb_Serialiser is

    -- Component Declaration for the Unit Under Test (UUT)
    component Serialiser
    port(
        clk   : in std_logic;
        rst   : in std_logic;
        en    : in std_logic;
        ld    : in std_logic;
        din   : in std_logic_vector(7 downto 0);
        dout  : out std_logic
    );
    end component;

    -- Signal declarations
    signal clk   : std_logic := '0';
    signal rst   : std_logic := '1';
    signal en    : std_logic := '0';
    signal ld    : std_logic := '0';
    signal din   : std_logic_vector(7 downto 0) := (others => '0');
    signal dout  : std_logic;

    constant CLK_PERIOD : time := 20 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Serialiser
        port map (
            clk => clk,
            rst => rst,
            en => en,
            ld => ld,
            din => din,
            dout => dout
        );

    -- Clock generation process
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the UUT
        rst <= '0';
        wait for 40 ns;
        rst <= '1';
        wait for 20 ns;

        -- Load data
        ld <= '0';
        din <= "10101010";
        wait for 20 ns;
        ld <= '1';

        -- Enable serialisation
        wait for 20 ns;
        en <= '0';

        -- Wait to observe the serialisation
        wait for 10000 ms;
        en <= '1';

        -- Test different data
        wait for 20 ns;
        ld <= '0';
        din <= "11001100";
        wait for 20 ns;
        ld <= '1';
        wait for 20 ns;
        en <= '0';
        wait for 10000 ms;
        en <= '1';

        -- Stop the simulation
        wait;
    end process;

end behavior;
