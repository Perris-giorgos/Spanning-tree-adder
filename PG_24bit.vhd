library ieee;
    use ieee.std_logic_1164.all;
    
    entity PG_24bit is
        PORT (A, B: in std_logic_vector(23 downto 0);
              P, G: out std_logic_vector(23 downto 0));
    end entity;
    
    architecture my_arch of PG_24bit is 
    
    component PG_1bit is
        PORT (A, B: in std_logic;
              P, G: out std_logic);
    end component;
    
    begin
        PG_24:
        for i in 0 to 23 generate
           PG_i: PG_1bit port map ( A(i), B(i), P(i), G(i));
        end generate;
        
        
    end my_arch;
