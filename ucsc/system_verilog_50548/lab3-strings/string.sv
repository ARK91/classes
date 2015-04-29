module string_tb();

string sentence = "This is a orginal string";
string statement;

initial begin
  $display ("Sentence = %s",sentence);

  // Assign new string of different size
  sentence = "This is a new string of different length";
  $display ("Sentence = %s",sentence);

  // Change to uppercase and assign to new string
  statement = sentence.toupper();
  $display ("Statement = %s",statement);

  // Get the length of string
  $display("Length of statement string: %d", statement.len());

  if(statement.tolower() == sentence.toupper()) begin
     $display("Lower case and upper case match (unusual!)");
  end

  if(statement.tolower() == sentence.tolower()) begin
     $display("Case insensitive comparison matches");
  end

  #1 $finish;
end

endmodule
