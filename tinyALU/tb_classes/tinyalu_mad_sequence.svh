


class tinyalu_mad_sequence extends uvm_sequence #(sequence_item);
   `uvm_object_utils(tinyalu_mad_sequence);

   sequence_item command;

   function new(string name = "mad");
      super.new(name);
   endfunction : new


   task body();
      repeat (10) begin
         command = mad_sequence_item::type_id::create("command");
         start_item(command);
         assert(command.randomize());
         finish_item(command);
      end 
   endtask : body
endclass : tinyalu_mad_sequence