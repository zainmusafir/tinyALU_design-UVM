



class tinyalu_or_mad_parallel_sequence extends uvm_sequence #(sequence_item);
`uvm_object_utils(tinyalu_or_mad_parallel_sequence);

protected reset_sequence reset;
protected tinyalu_or_sequence orr;
protected tinyalu_mad_sequence madd;




function new(string name = "parallel_sequence");

super.new(name);
orr =  tinyalu_or_sequence::type_id::create("or_seq");
madd=  tinyalu_mad_sequence::type_id::create("mad_seq");
reset = reset_sequence::type_id::create("reset");
endfunction : new



 task body();

    reset.start(m_sequencer);

      fork
       // begin
	      orr.start(m_sequencer);
   	   madd.start(m_sequencer);
       // end
      join

   endtask : body


endclass : tinyalu_or_mad_parallel_sequence 