module string_tb();

string sentence = "This is a orginal string";
string statement;

initial begin
  $display ("Sentence = %s",sentence);

  // Assign new string of different size
  sentence = "This is new string of different length";
  $display ("Sentence = %s",sentence);

  // Change to uppercase and assign to new string
  // <insert code here>
  $display ("Statement = %s",statement);

  // Get the length of string
  // <insert code here>

  //try other string methods here...

  #1 $finish;
end

endmodule
