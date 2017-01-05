library ieee;
    use ieee.std_logic_1164.all;
    
    entity Carries is
        PORT (A, B: in std_logic_vector(23 downto 0);
              Cout: out std_logic_vector(2 downto 0));
    end entity;
    
    architecture my_arch of Carries is
        
        component PG_group_2 is
        PORT ( Gi, Gj: in std_logic;
               Pi, Pj: in std_logic;
               Gj_i, Pj_i: out std_logic);
        end component;
        
        component PG_group_3 is
        PORT (Gi, Gj, Gk: in std_logic;
              Pi, Pj, Pk: in std_logic;
              Gk_i, Pk_i: out std_logic);
        end component;
        
        signal P0, G0: std_logic_vector(23 downto 0);
        signal P1, G1: std_logic_vector(8 downto 0);
        signal P2, G2: std_logic_vector(2 downto 0);
        signal P3, G3: std_logic_vector(1 downto 0);
        
        begin
            PGi:
            for i in 0 to 23 generate
               P0(i) <= A(i) XOR B(i);
               G0(i) <= A(i) AND B(i);
            end generate;
            
            -- first level
        
            PG_1_1: PG_group_2 port map ( G0(0), G0(1), P0(0), P0(1), G1(0), P1(0));            
            PG_1_4: PG_group_3 port map ( G0(2), G0(3), G0(4), P0(2), P0(3), P0(4), G1(1), P1(1));
            PG_1_7: PG_group_3 port map ( G0(5), G0(6), G0(7), P0(5), P0(6), P0(7), G1(2), P1(2));
            PG_1_9: PG_group_2 port map ( G0(8), G0(9), P0(8), P0(9), G1(3), P1(3));
            PG_1_12: PG_group_3 port map ( G0(10), G0(11), G0(12), P0(10), P0(11), P0(12), G1(4), P1(4));
            PG_1_15: PG_group_3 port map ( G0(13), G0(14), G0(15), P0(13), P0(14), P0(15), G1(5), P1(5));
            PG_1_17: PG_group_2 port map ( G0(16), G0(17), P0(16), P0(17), G1(6), P1(6));
            PG_1_20: PG_group_3 port map ( G0(18), G0(19), G0(20), P0(18), P0(19), P0(20), G1(7), P1(7));
            PG_1_23: PG_group_3 port map ( G0(21), G0(22), G0(23), P0(21), P0(22), P0(23), G1(8), P1(8));
            
            --second level
            
            PG_2_7: PG_group_3 port map ( G1(0), G1(1), G1(2), P1(0), P1(1), P1(2), G2(0), P2(0));
            PG_2_15: PG_group_3 port map ( G1(3), G1(4), G1(5), P1(3), P1(4), P1(5), G2(1), P2(1));
            PG_2_23: PG_group_3 port map ( G1(6), G1(7), G1(8), P1(6), P1(7), P1(8), G2(2), P2(2));
            
            -- third level
            
            G3(0) <= G2(1) OR (G2(0) AND P2(1));
            G3(1) <= G2(2) OR (G3(0) AND P2(2));
            
            P3(0) <= P2(0) AND P2(1);
            P3(1) <= P2(0) AND P2(1) AND P2(2);
            
            Cout(0) <= G2(0);
            Cout(1) <= G3(0);
            Cout(2) <= G3(1);
                        
            
    end my_arch;