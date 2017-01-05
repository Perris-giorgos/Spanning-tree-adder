library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    
    entity adder_8_bit is
        PORT (A, B: in std_logic_vector(7 downto 0);
              Cin: in std_logic;
              S: out std_logic_vector(7 downto 0));
    end adder_8_bit;
    
    architecture ripple_carry of adder_8_bit is
        signal result: unsigned(8 downto 0);
        signal X,Y: unsigned(7 downto 0);
        begin
            X <= unsigned(A);
            Y <= unsigned(B);
            result <= ('0' & X)+('0' & Y)+("0000000" & Cin);
            S <= std_logic_vector(result(7 downto 0));
            --           CARRY <= result(8);
    end ripple_carry;

