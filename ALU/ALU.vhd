library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    port(
        clk,rst : IN std_logic;
        in1,in2 : IN std_logic_vector(15 downto 0);
        alu_mode : IN std_logic_vector(15 downto 9);
      
        result : OUT std_logic_vector(15 downto 0);
        z_flag,n_flag : OUT std_logic
    );
        
end ALU;
    
 architecture alu_entity of ALU is 
 --internal signals
 --signal result_internal : std_logic_vector(15 downto 0) := (x"0000");
 signal numN : integer := to_integer(unsigned(in2));
 signal mult_tmp_32 : std_logic_vector(31 downto 0);
 --signal shift_res : std_logic_vector(15 downto 0) := x"0010";
 
 begin
 process(clk,rst, in1, in2, alu_mode)
 --variable shift_res : std_logic_vector(15 downto 0) := in1; 
variable shift_res : std_logic_vector(15 downto 0); 
    begin
        if (rst = '1') then
            result <= (others => '0');
            z_flag <= '0';
            n_flag <= '0';
        else 
            if ( rising_edge( clk )) then
            shift_res := in1;
                case alu_mode is
                    --when '0000000' => NULL; --nop
                    
                    when "0000001" => --add
                        result <= std_logic_vector(in1) + std_logic_vector(in2);
                              
                    when "0000010" => --sub
                        result <= std_logic_vector(in1) - std_logic_vector(in2);
                    
                    when "0000011" => --mul
                        mult_tmp_32 <= std_logic_vector(in1) * std_logic_vector(in2);                
                        result <= mult_tmp_32(15 downto 0);
                                            
                    when "0000100" => --NAND
                        result <= std_logic_vector(in1) NAND std_logic_vector(in2);
                    
                    when "0000101" => --SHL
						shift_res := in1;
						for i in 0 to 15 loop
							if i < to_integer(unsigned(in2)) then
								shift_res := shift_res(14 downto 0) & '0';
							end if;
						end loop;
						
						result <= shift_res;
--                        For loop up to numN and shift once every time
                    when "0000110" => --SHR
						shift_res := in1;
						for i in 0 to 15 loop
							if i < to_integer(unsigned(in2)) then
								shift_res := '0' & shift_res(15 downto 1);
							end if;
						end loop;
						
						result <= shift_res;
                                        
                    when "0000111" => --test
                        if (in1 = x"0000") then
                            z_flag <= '1';
                        end if;
                            
                        if (in1 < x"0000") then
                            n_flag <= '1';
                        end if;
                        
                    --when "0100000" => --OUT
                    --   result_internal <= in1;
                    
    --                when "0100001" => --IN
    --                    in1 <= result_internal;       
                    when others =>
                        result <= in1;             
                end case;
            end if;
        end if;
        
    end process;
end alu_entity;