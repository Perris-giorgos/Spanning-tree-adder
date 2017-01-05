library ieee;
    use ieee.std_logic_1164.all;
    
    entity spanning_tree is
        PORT (A, B: in std_logic_vector(31 downto 0);
              Sum: out std_logic_vector(31 downto 0));
    end spanning_tree;
    
    architecture my_arch of spanning_tree is
        component adder_8_bit is
        PORT (A, B: in std_logic_vector(7 downto 0);
              Cin: in std_logic;
              S: out std_logic_vector(7 downto 0));
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
        signal S1, S0: std_logic_vector(23 downto 0);
        
        begin
            sum_7_0: adder_8_bit port map ( A(7 downto 0), B(7 downto 0),'0', Sum(7 downto 0));
            
            -- create sums with carry=1 and carry=0
            
            sum_15_8_1: adder_8_bit port map ( A(15 downto 8), B(15 downto 8),'1', S1(7 downto 0));
            sum_15_8_0: adder_8_bit port map ( A(15 downto 8), B(15 downto 8),'0', S0(7 downto 0));
        
            sum_23_16_1: adder_8_bit port map ( A(23 downto 16), B(23 downto 16),'1', S1(15 downto 8));    
            sum_23_16_0: adder_8_bit port map ( A(23 downto 16), B(23 downto 16),'0', S0(15 downto 8));
            
            sum_31_24_1: adder_8_bit port map ( A(31 downto 24), B(31 downto 24),'1', S1(23 downto 16));
            sum_31_24_0: adder_8_bit port map ( A(31 downto 24), B(31 downto 24),'0', S0(23 downto 16));

            -- generated carries
            
            carries_gen: Carries port map ( A(23 downto 0), B(23 downto 0), Cin(2 downto 0));
            
            -- select carries
            
            Sel0: MUX_2to1 port map ( S0(7 downto 0), S1(7 downto 0), Cin(0), Sum(15 downto 8));
            Sel1: MUX_2to1 port map ( S0(15 downto 8), S1(15 downto 8), Cin(1), Sum(23 downto 16));
            Sel2: MUX_2to1 port map ( S0(23 downto 16), S1(23 downto 16), Cin(2), Sum(31 downto 24));            
        
    end my_arch;
