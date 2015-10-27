<?xml version="1.0" encoding="iso-8859-1" ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns = "http://www.w3.org/1999/xhtml" >

<!-- an example of using PHP to store data from a form in a Mysql database -->

  <head>
    <title>Using PHP to save form data to a database</title>
  </head>

  <body>
     <h1>Using PHP to save form data to a database
        <br />A simple on-line experiment</h1>
  
     <p>In this example, we implement a (trivally) simple between-subjects
     experiment as an XHTML form, using a Mysql database to store the data.
     The following Mysql commands were used to create the table on the 
     server:</p>
     
  <hr />
    
  <pre>
     use orval;
     show tables;
     CREATE TABLE expdata1 (
       subNum INT(10) UNSIGNED DEFAULT '0' NOT NULL AUTO_INCREMENT,
       PRIMARY KEY (subNum),
       name VARCHAR(40),
       id VARCHAR(20),
       condition VARCHAR(2),
       answer1 TEXT,
       answer2 TEXT
     );
     show tables;
     quit;                  
  </pre>
  <hr />
  
  <p>The following Mysql commands were used to create the database 
     <em>experiment1_stimuli</em> which contains the stimuli for the
     experiment - 2 versions of each of the two items.</p>
  <pre>
CREATE TABLE experiment1_stimuli
   (condition VARCHAR(2), item VARCHAR(2), question TEXT);
INSERT INTO experiment1_stimuli VALUES
   ("1", "1", "Do you like short questions?");
INSERT INTO experiment1_stimuli VALUES
   ("2", "1", "Do you like long questions?");
INSERT INTO experiment1_stimuli VALUES
   ("2", "2", "Do you like long answers?");
INSERT INTO experiment1_stimuli VALUES
   ("1", "2", "Do you like short answers?");
SELECT * FROM experiment1_stimuli ;  </pre>

  <hr />  
  
  <p>The following piece of PHP code accesses the database to get the most recent
     subject number, and then assigns 
     a value to the variable <em>$condition</em> based on that number:</p>
  
  <pre>
  &lt;?php 
     $db = mysql_connect("localhost", "orval");
     mysql_select_db("orval",$db);
     $result = mysql_query ('SELECT MAX(subNum) FROM expdata1', $db); 
     $previousSubNum = 0;
     if ($result) $previousSubNum = mysql_result($result,0,"MAX(subNum)");
     $condition = ($previousSubNum % 2) + 1;
  ?&gt;</pre>
  
  <?php 
     // This connects to the mysql server on the course server:
     $db = mysql_connect("localhost", "orval");
     // This opens the database "orval" - you should change it to your database
     mysql_select_db("orval",$db);
     // This runs a mysql query and saves the result in $result.
     // It returns the maximum value of the "subNum" field:
     $result = mysql_query ('SELECT MAX(subNum) FROM expdata1', $db); 
     
     // The next few lines assign a condition based on the subject number
     // of the previous one in the database - if an even number of subjects
     // have previously been run, condition = 1; if odd, 2.  This will result
     // in an equal number in each condition under some circumstances, but
     // not if several subjects start at the same time.  Would simple random 
     // assignment be preferable?  Some other method?
     
     // First, initialize the previous subject number in case there were none
     $previousSubNum = 0;
     // Next, get the previous subject number, if it exists, from the
     // result of the query that was run above.  The mysql_result function
     // in the following line gets the first (subscript 0) value for
     // "MAX(subNum)" from the query result stored in $result:
     if ($result) $previousSubNum = mysql_result($result,0,"MAX(subNum)");
     // The % arithmetic operator returns the remainder from division
     $condition = ($previousSubNum % 2) + 1;
  ?>
  
  <p>The previous subject number was <?php print($previousSubNum) ?>, 
     therefore the condition is <?php print($condition) ?>. </p>
     
  <hr />
  
  <p>The next section of PHP code gets the stimuli from the database
     <em>experiment1_stimuli</em> based on the condition:
  <pre>   
  &lt;?php
     $sql = 'SELECT question FROM experiment1_stimuli WHERE condition = ' . $condition;
     $stimuli = mysql_query ($sql, $db);
     $item1 = mysql_result($stimuli,0,"question");
     $item2 = mysql_result($stimuli,1,"question");
  &gt;></pre>
      
  <?php
     $sql = 'SELECT question FROM experiment1_stimuli WHERE condition = ' . $condition;
     $stimuli = mysql_query ($sql, $db);
     $item1 = mysql_result($stimuli,0,"question");
     $item2 = mysql_result($stimuli,1,"question");
  ?>
  
  <hr />
  
  <p>The form in the next section collects the data, and uses another php
     script (experiment1-storeData.php) to store the data to the database.</p>
  
  <hr />
  
  <h1>Experiment 1</h1>
  
  <form id = "exp1Form" action="experiment1-storeData.php" method = "post">
  
     <p><?php print ($item1) ?> <br />
        <input name = "condition" type = "hidden" value = 
           <?php print($condition) ?> />
        <label>Yes
           <input name = "question_1" type = "radio" value = "Yes" />
        </label>
        <label>No
           <input name = "question_1" type = "radio" value = "No" />
        </label>
     </p>

     <p><?php print ($item2) ?> <br />
        <label>Yes
           <input name = "question_2" type = "radio" value = "Yes" />
        </label>
        <label>No
           <input name = "question_2" type = "radio" value = "No" />
        </label>
     </p>
     
     <p>
        <input type = "submit" value = "Submit Answers" />
     </p>
			
  </form>
  
  </body>
</html>
