<?php
// Simple DB connectivity test for the portfolio project.
// WARNING: This is a test helper — remove or protect it before deploying publicly.

require_once __DIR__ . '/db.php';

header('Content-Type: text/html; charset=utf-8');

echo '<!doctype html><html><head><meta charset="utf-8"><title>DB Test</title></head><body style="font-family:Segoe UI,Arial,sans-serif;padding:1rem">';
echo '<h2>MySQL Test - portfolio_db</h2>';

$conn = get_db_connection();
if(!$conn){
    echo '<p style="color:#b00020">Could not connect to MySQL using settings in <code>php/db.php</code>. Check DB credentials and that MySQL is running.</p>';
    echo '<p><strong>DB_HOST:</strong> ' . htmlspecialchars(defined('DB_HOST')?DB_HOST:'') . '</p>';
    echo '<p><strong>DB_USER:</strong> ' . htmlspecialchars(defined('DB_USER')?DB_USER:'') . '</p>';
    echo '<p><a href="/">Return to site</a></p>';
    echo '</body></html>';
    exit;
}

// Ensure table exists (safe idempotent DDL)
$create = "CREATE TABLE IF NOT EXISTS messages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  created_at DATETIME NOT NULL
);";
$conn->query($create);

// Prepared insert
$name = 'DB Test User';
$email = 'test@example.com';
$message = 'This is a test entry from php/test_db.php on ' . date('c');

$stmt = $conn->prepare('INSERT INTO messages (name,email,message,created_at) VALUES (?,?,?,NOW())');
if($stmt){
    $stmt->bind_param('sss',$name,$email,$message);
    if($stmt->execute()){
        $last = $stmt->insert_id;
        echo '<p style="color:green">Insert successful. Inserted id: ' . intval($last) . '</p>';
    } else {
        echo '<p style="color:#b00020">Insert failed: ' . htmlspecialchars($stmt->error) . '</p>';
    }
    $stmt->close();
} else {
    echo '<p style="color:#b00020">Prepare failed: ' . htmlspecialchars($conn->error) . '</p>';
}

// Show count of rows
$res = $conn->query('SELECT COUNT(*) AS cnt FROM messages');
if($res){
    $row = $res->fetch_assoc();
    echo '<p>Messages table row count: ' . intval($row['cnt']) . '</p>';
}

echo '<p>Note: remove this file before publishing to a public server.</p>';
echo '<p><a href="/">Return to site</a></p>';
echo '</body></html>';

$conn->close();

?>
