library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity BaudClkGen_tb is
end entity;

architecture rtl of BaudClkGen_tb is

    component BaudClkGen is
        generic(
            NUMBER_OF_CLKS : integer;
            SYS_CLK_FREQ : integer;
            BAUD_RATE : integer
        );
        port (
            clk : in std_logic; -- FPGA built-in 50MHz clock
            rst : in std_logic; -- Reset
            start : in std_logic; -- Start signal
            baudClk : out std_logic;
            ready : out std_logic
        );
    end component;

    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal baudClk : std_logic;
    signal ready : std_logic;
    signal start : std_logic := '0';
    
begin
    
    -- Clock generation process
    clk_process: process
    begin
        while True loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process clk_process;
    
    -- Instantiation of BaudClkGen
    UUT: BaudClkGen
        generic map (
            NUMBER_OF_CLKS => 10,
            SYS_CLK_FREQ => 50000000,
            BAUD_RATE => 115200
        )
        port map (
            clk => clk,    -- FPGA built-in 50MHz clock
            rst => rst,    -- Reset
            start => start, -- Start signal
            baudClk => baudClk,
            ready => ready
        );
    
    -- Main test process
    main: process
    begin
        -- Initialize reset and start signals
        rst <= '1';
        start <= '0';
        wait for 100 ns;
        rst <= '0';
        
        -- Simulate start pulse
        wait until rising_edge(clk);
        start <= '1';
        wait until rising_edge(clk);
        start <= '0';
        
        -- Wait indefinitely
        wait;
    end process;

end rtl;
