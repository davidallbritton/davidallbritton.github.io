
<html>

<body>

<h1>Example of Accessing a Database with PHP
<br /> (Plus some notes on using mysql)</h1>

<p>This page uses php scripting to access the "dogs"
mysql
table in the "test" database.  
To access the database directly using mysql, log into the course server
using telnet and issue the command "mysql".  Then in mysql use these commands:
</p><p>
<br />show databases;
<br />use test;
<br />show tables;
<br />select * from dogs;
<br />select * from dogs where weight=20;
<br />select name, birth, weight from dogs;
<br />select name, birth, weight from dogs order by weight;
</p>
The following command would insert a new record into the database.  Try
inserting a record for your dog if you want.</p>
<p>
insert into dogs values ("balbe", 1985-00-00, "f", 18);
</p>



<h3>This is the information from the database, extracted using php:</h3>
<p>
<?php

$db = mysql_connect("localhost", "orval");

mysql_select_db("test",$db);

$result = mysql_query("SELECT * FROM dogs",$db);

printf("Name: %s<br>\n", mysql_result($result,3,"name"));
printf("birth: %s<br>\n", mysql_result($result,3,"birth"));
printf("sex: %s<br>\n", mysql_result($result,3,"sex"));
printf("weight: %s<br>\n", mysql_result($result,3,"weight"));

?>

</p>
<p>Luna is actually a female, so we need to use the "update" command
in mysql to change that field.  Follow the links in the "resources" page
to the mysql documentation to figure out how to do that.</p>

<p>Other useful things to remember about mysql:</p>
<ul>
  <li>\c will cancel a command</li>
</ul>

</body>

<!--
-->


</html>
