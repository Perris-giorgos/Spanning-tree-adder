library ieee;
    use ieee.std_logic_1164.all;
    
    entity PG_1bit is
        PORT (A, B: in std_logic;
              P, G: out std_logic);
    end PG_1bit;
    
    architecture my_arch of PG_1bit is
        begin
            P <= A XOR B;
            G <= A AND B;
    end my_arch;

