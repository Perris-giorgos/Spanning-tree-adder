library ieee;
    use ieee.std_logic_1164.all;
    
    entity PG_group_2 is
        PORT ( Gi, Gj: in std_logic;
               Pi, Pj: in std_logic;
               Gj_i, Pj_i: out std_logic);
    end entity;

    architecture my_arch of PG_group_2 is      
        begin 
            Gj_i <= Gj OR (Pj AND Gi);
            Pj_i <= Pi AND Pj;
    end my_arch;
