<?xml version="1.0" encoding="iso-8859-1" ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns = "http://www.w3.org/1999/xhtml" >

<!-- demonstrates the use of PHP to access a database -->

  <head>
    <title></title>
  </head>

  <body>
  
  <h1>Using PHP to save form data to a database
     <br />A simple on-line experiment</h1>
     
  <p>Now create a new record in the table expdata1</p>
  
  <?php
     $db = mysql_connect("localhost", "orval");
     mysql_select_db("orval",$db);
     $
     $resultInput = mysql_query ('INSERT INTO expdata1 (name) VALUES ("")', $db);
     UPDATE expdata1 SET name = "you" WHERE subNum = 2;
  ?>

  
  <p>Now print out the contents of the table</p>
  
  <?php 
     $result = mysql_query ('SELECT * FROM expdata1', $db); 
  ?>

  <?php
printf("subnum: %s<br>\n", mysql_result($result,1,"subNum"));
printf("name: %s<br>\n", mysql_result($result,1,"name"));
printf("id: %s<br>\n", mysql_result($result,1,"id"));
printf("condition: %s<br>\n", mysql_result($result,1,"condition"));
printf("answer1: %s<br>\n", mysql_result($result,1,"answer1"));
printf("answer2: %s<br>\n", mysql_result($result,1,"answer2"));
  ?>


  </body>
</html>
