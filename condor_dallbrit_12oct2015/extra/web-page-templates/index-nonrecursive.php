<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Page title</title>

<?php 
 function dirList ($directory) 
{

    // create an array to hold directory list
    $results = array();

    // create a handler for the directory
    $handler = opendir($directory);

    // keep going until all files in directory have been read
    while ($file = readdir($handler)) {
        // if $file does not start with a period,
        // add it to the results array
        $pmx = preg_match("/^\./" , $file );
        if ( $pmx == 0) {
            $results[] = $file;
            print("<li>");
            print("<a href=\"");
            print($file);
            print("\">");
            print($file);
            print("</a></li>");
        }
    }

    // tidy up: close the handler
    closedir($handler);

    // done!
    return $results;

}

 ?>

</head>
<body>


<h1>Available Files:</h1>

<ul>
<?php   dirList(".");  ?>
</ul>

</body>
</html>
