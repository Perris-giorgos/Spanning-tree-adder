library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    
    entity look_ahead_8_bit is
        PORT (X,Y: in std_logic_vector(7 downto 0);
              C : in std_logic;
              Sum: out std_logic_vector(7 downto 0));
    end entity;

    architecture my_arch of look_ahead_8_bit is
        component adder_8_bit is
           PORT (A, B: in std_logic_vector(7 downto 0);
                Cin: in std_logic;
                S: out std_logic_vector(7 downto 0));
        end component;
        
        component MUX_2to1 is
            PORT (In0, In1: in std_logic_vector(7 downto 0);
                  sel: in std_logic;
                  Outp: out std_logic_vector(7 downto 0));
        end component;
        
        signal S1, S0: std_logic_vector(7 downto 0);
        signal C0: std_logic := '0';
        signal C1: std_logic := '1';
        
        begin
            Sum_0 : adder_8_bit port map ( X, Y, C0, S0);
            Sum_1 : adder_8_bit port map ( X, Y, C1, S1);
            Sum_final: MUX_2to1 port map ( S0, S1, C, Sum);
                        
        end my_arch;
