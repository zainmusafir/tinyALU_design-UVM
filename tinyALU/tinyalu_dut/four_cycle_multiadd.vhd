--four cycle multiadd trial

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY four_cycle IS
   PORT( 
      A           : IN     unsigned ( 7 DOWNTO 0 );
      B           : IN     unsigned ( 7 DOWNTO 0 );
      C           : IN     unsigned ( 7 DOWNTO 0 );
      clk         : IN     std_logic;
      reset_n     : IN     std_logic;
      start       : IN     std_logic;
      done_multadd  : OUT    std_logic;
      result_multadd : OUT    unsigned (15 DOWNTO 0)
   );

-- Declarations

END four_cycle ;

--
architecture multy of four_cycle is
  signal a_int,b_int,c_int,temp : unsigned (7 downto 0);  -- start pipeline
  signal mult1,mult2 : unsigned (15 downto 0);  -- pipeline registers
  signal done4,done3,done2,done1,done_mult_int : std_logic;       -- pipeline the done signal
begin
  -- purpose: fourstage stage pipelined multiplier adder
  -- type   : sequential
  -- inputs : clk, reset_n, a,b
  -- outputs: result_mult


  multiplier_adder: process (clk, reset_n)
  --variable tmp: unsigned  



  begin     -- process multiplier
    if reset_n = '0' then               -- asynchronous reset (active low)
      done_mult_int <= '0';
      done3 <= '0';
      done2 <= '0';
      done1 <= '0';
      
      done4 <= '0';
      
	    a_int <= "00000000";
	    b_int <= "00000000";
      c_int <= "00000000";


      mult1 <= "0000000000000000";
      mult2 <= "0000000000000000";
      result_multadd <= "0000000000000000";


    elsif clk'event and clk = '1' then  -- rising clock edge
      a_int <= a;
      b_int <= b;
      c_int <= c;


      temp  <= c_int;  --pipelining the c variable for the next clock,
  
      
      mult1 <= a_int * b_int;
      mult2 <= mult1 + temp;


      result_multadd <= mult2;
       


      --pipelining done signal
      done4 <= start and (not done_mult_int);
      done3 <= done4 and (not done_mult_int);
      done2 <= done3 and (not done_mult_int);
      done1 <= done2 and (not done_mult_int);
      done_mult_int  <= done1 and (not done_mult_int);
    end if;
  end process multiplier_adder;
  done_multadd <= done_mult_int;
end architecture multy;

