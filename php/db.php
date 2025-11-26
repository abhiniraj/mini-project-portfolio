<?php
// Database connection helper
// Update these constants with your MySQL credentials if different
define('DB_HOST','localhost');
define('DB_USER','root');
define('DB_PASS','');
define('DB_NAME','portfolio_db');

function get_db_connection(){
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    if($conn->connect_error){
        return null;
    }
    $conn->set_charset('utf8mb4');
    return $conn;
}

?>
<?php
// Database connection helper
// Update the constants below with your MySQL credentials when running locally
define('DB_HOST','localhost');
define('DB_USER','root');
define('DB_PASS','');
define('DB_NAME','portfolio_db');

function get_db_connection(){
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    if($conn->connect_error){
        return null;
    }
    $conn->set_charset('utf8mb4');
    return $conn;
}

?>
