library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SwitchRegister_tb is
end entity;

architecture tb of SwitchRegister_tb is

    component SwitchRegister
        port(
            clk: in std_logic;
            rst: in std_logic;
            en: in std_logic;
            din: in std_logic_vector(7 downto 0);
            dout: buffer std_logic_vector(7 downto 0)
        );
    end component;


    signal clk_tb: std_logic := '0';
    signal rst_tb: std_logic := '0';
    signal en_tb: std_logic := '0';
    signal din_tb: std_logic_vector(7 downto 0) := (others => '0');
    signal dout_tb: std_logic_vector(7 downto 0);

begin


    UUT: SwitchRegister port map (
        clk => clk_tb,
        rst => rst_tb,
        en => en_tb,
        din => din_tb,
        dout => dout_tb
    );


    clk_process: process
    begin
        while now < 2000 ns loop
            clk_tb <= not clk_tb;
            wait for 10 ns;
        end loop;
        wait;
    end process;


    stimulus: process
    begin

        rst_tb <= '1';
        wait for 20 ns;
        rst_tb <= '0';

        en_tb <= '1';

        din_tb <= "10101010";

        wait for 100 ns;

        en_tb <= '0';

        wait for 10 ns;

        wait;
    end process;

end architecture;