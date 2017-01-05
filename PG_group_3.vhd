library ieee;
    use ieee.std_logic_1164.all;
    
    entity PG_group_3 is
        PORT (Gi, Gj, Gk: in std_logic;
              Pi, Pj, Pk: in std_logic;
              Gk_i, Pk_i: out std_logic);
    end entity;

    architecture my_arch of PG_group_3 is        
        signal h: std_logic;     
        begin
            h <= Gj OR (Pj AND Gi);
            Gk_i <= Gk OR (Pk AND h);
            Pk_i <= Pi AND Pj AND Pk;
        
        end my_arch;