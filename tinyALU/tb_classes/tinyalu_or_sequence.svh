





class tinyalu_or_sequence extends uvm_sequence #(sequence_item);
   `uvm_object_utils(tinyalu_or_sequence);

   sequence_item command;

   function new(string name = "or");
      super.new(name);
   endfunction : new


   task body();
      repeat (10) begin
         command = or_sequence_item::type_id::create("command");
         start_item(command);
         assert(command.randomize());
         finish_item(command);
      end 
   endtask : body
endclass : tinyalu_or_sequence

