<?xml version="1.0" encoding="iso-8859-1" ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns = "http://www.w3.org/1999/xhtml" >

<!-- demonstrates the use of PHP to store data in a database -->

 <head>
    <title>experiment1-storeData.php</title>
 </head>

 <body>
  
  <h1>Thank You for Participating!</h1>
  <hr />
  
  <h1>Additional information about what this script does:</h1>
  
  <h2>Storing data to a database with PHP</h2>
  <p>This PHP script receives the user responses from the form, and
     stores the data in the table "expdata1" in the "orval" database.
     In actual practice, the only XHTML content in this page would be
     a thank you message to the user or directions for the next part
     of the experiment.  For purposes of example, a bit more explanation
     of what is going on is included.</p>
     
  <p>PHP automatically creates variables corresponding to the form's input
     elements' "id" or "name" attributes when the form data is "post"ed to
     this script.  The "value" of the input field "answer_1" for example
     is stored in the variable "$answer_1" in this script.</p>

  <p>Here are the PHP commands used to create a new record in the table expdata1
     for this participant's data.  (See the source code on the server for additional
     information in the comments in the code.)</p>
     
  <pre>
  &lt;?php
     $db = mysql_connect("localhost", "orval");
     mysql_select_db("orval",$db);
     $sql = sprintf('INSERT INTO expdata1 (name, id, condition, answer1, answer2) VALUES ("", "", "%s", "%s", "%s")',
        $condition, $question_1, $question_2);
     $resultInput = mysql_query ($sql, $db);
  ?&gt; </pre>
  
  <?php
     $db = mysql_connect("localhost", "orval");
     mysql_select_db("orval",$db);
     // The next line creates the SQL command using the PHP sprintf function
     // This function prints out a string (its first argument) with its other
     // arguments substituted into the string where there is a "%s".  Perl
     // has a similar function.  
     // printf would print to standard output; sprintf returns the printout
     // as a string that can be assigned to a variable.
     $sql = sprintf('INSERT INTO expdata1 (name, id, condition, answer1, answer2) VALUES ("", "", "%s", "%s", "%s")',
        $condition, $question_1, $question_2);
     // The next line actually puts the information into the database:
     $resultInput = mysql_query ($sql, $db);
  ?>
  
  <p>This is the SQL command that was sent to the database:</p>
  <code> <?php print($sql); ?> </code>
  
  <p>Notice that the first field (subNum) was omitted.  This is because that
     field uses the mysql "auto-increment" feature to automatically add one 
     to the previous subNum whenever a new entry is created.  There are also
     two empty fields (name and id) that are not used but could be added to the
     input form if needed (for confidential participant codes for Intro
     Psych participants, for example).</p>
  
   
  <p>Here are the contents of the table <strong>expdata1</strong>.  
     Verify that the data you entered was
     recorded.  You may also want to look at the source code to see how the 
     table was created.</p>
  
  
  <table border = "1">
   
  <?php 
     $Result = mysql_query ('SELECT * FROM expdata1', $db); 
      
   // print header row
   print("<tr>\n");
   
   for($Field=0; $Field < mysql_num_fields ($Result); $Field++)
   {
      print("<td>");
      print("<b>");
      print(mysql_field_name($Result, $Field) . " ");
      print("</b>");
      print("</td>\n");
   }
   print("</tr>\n");

   //loop through rows
   for($Row=0; $Row < mysql_num_rows($Result); $Row++)
   {
      print("<tr>\n");
      // print out each field
      for($Field=0; $Field < mysql_num_fields($Result);
      $Field++)
      {
      print("<td>");
      print(mysql_result($Result, $Row, $Field));
      print("</td>\n");
      }
      print("</tr>\n");
   }

   print("</table>\n");

  ?>

 </body>
</html>
