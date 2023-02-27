library ieee; 
library std;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
use work.all;
use std.env.stop;

entity ALU_tb is end ALU_tb;

architecture behavioural of ALU_tb is
component ALU port(
    clk: in std_logic;
    rst : in std_logic;  
    in1,in2: in std_logic_vector(15 downto 0);
    alu_mode: in std_logic_vector(15 downto 9); 
    result: out std_logic_vector(15 downto 0); 
    z_flag,n_flag: out std_logic);
end component; 

signal clk_s,rst_s : std_logic; 
signal in1_data_s,in2_data_s: std_logic_vector(15 downto 0); 
signal alu_mode_in_s: std_logic_vector(15 downto 9); 
signal result_out_s: std_logic_vector(15 downto 0); 
signal z_flag_out_s,n_flag_out_s: std_logic;
      
begin
    u0: ALU port map(
    clk=>clk_s,
    rst=>rst_s,
    in1=>in1_data_s,
    in2=>in2_data_s,
    alu_mode=>alu_mode_in_s,
    result=>result_out_s,
    z_flag=>z_flag_out_s,
    n_flag=>n_flag_out_s );

SEQUENCER_PROC : process
begin
    for i in 0 to 10 loop
        clk_s <= '0'; 
        wait for 10 us;
        clk_s <= '1'; 
        wait for 10 us; 
    end loop;
    report "Simulation done - Calling 'stop'";
    stop;
    --severity failure;
end process;

process  begin
    rst_s <= '1'; 
    in1_data_s <= x"0000"; 
    in2_data_s <= x"0000"; 
    alu_mode_in_s <= "0000000";
    wait until (clk_s='0' and clk_s'event); wait until (clk_s='1' and clk_s'event); wait until (clk_s='1' and clk_s'event);
    rst_s <= '0';
    in1_data_s <= x"0008"; in2_data_s <= x"0003";
    wait until (clk_s='0' and clk_s'event); alu_mode_in_s<= "0000000";
    wait until (clk_s='0' and clk_s'event); alu_mode_in_s<= "0000001";
    wait until (clk_s='0' and clk_s'event); alu_mode_in_s<= "0000010";
    wait until (clk_s='0' and clk_s'event); alu_mode_in_s<= "0000011";
    wait until (clk_s='0' and clk_s'event); alu_mode_in_s<= "0000100";
    wait until (clk_s='0' and clk_s'event); alu_mode_in_s<= "0000101";
    wait until (clk_s='0' and clk_s'event); alu_mode_in_s<= "0000110";
    wait until (clk_s='0' and clk_s'event); alu_mode_in_s<= "0000111";
    wait until (clk_s='0' and clk_s'event); alu_mode_in_s<= "0000000";
    end process;
end behavioural;