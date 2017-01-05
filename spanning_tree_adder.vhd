library ieee;
    use ieee.std_logic_1164.all;
    
    entity spanning_tree_adder is
        PORT (A, B: in std_logic_vector(31 downto 0);
              Sum: out std_logic_vector(31 downto 0));
    end spanning_tree_adder;
    
    architecture my_arch of spanning_tree_adder is
        component adder_8_bit is
           PORT (A, B: in std_logic_vector(7 downto 0);
                Cin: in std_logic;
                S: out std_logic_vector(7 downto 0));
        end component;
        
        component look_ahead_8_bit is
        PORT (X,Y: in std_logic_vector(7 downto 0);
              C : in std_logic;
              Sum: out std_logic_vector(7 downto 0));
        end component;
        
        component Carries is
        PORT (A, B: in std_logic_vector(23 downto 0);
              Cout: out std_logic_vector(2 downto 0));
        end component;
        
        component MUX_2to1 is
          PORT (In0,In1: in std_logic_vector(7 downto 0);
                sel: in std_logic;
                Outp: out std_logic_vector(7 downto 0));
        end component;
        
        signal Cin: std_logic_vector(2 downto 0);
        
        begin
            sum_7_0: adder_8_bit port map ( A(7 downto 0), B(7 downto 0),'0', Sum(7 downto 0));
            
            -- generated carries
            
            carries_gen: Carries port map ( A(23 downto 0), B(23 downto 0), Cin(2 downto 0));
            
            -- look ahead 
            
            first_group: look_ahead_8_bit port map ( A(15 downto 8), B(15 downto 8), Cin(0), Sum(15 downto 8));
            sec_group: look_ahead_8_bit port map ( A(23 downto 16), B(23 downto 16), Cin(1), Sum(23 downto 16));
            third_group: look_ahead_8_bit port map ( A(31 downto 24), B(31 downto 24), Cin(2), Sum(31 downto 24));
            
        end my_arch;
