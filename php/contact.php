<?php
header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/db.php';

$name = trim($_POST['name'] ?? '');
$email = trim($_POST['email'] ?? '');
$message = trim($_POST['message'] ?? '');

if(!$name || !$email || !$message){
    echo json_encode(['status'=>'error','message'=>'All fields are required.']);
    exit;
}

// basic sanitization
$name = strip_tags($name);
$email = filter_var($email, FILTER_SANITIZE_EMAIL);
$message = strip_tags($message);

// Try to store in MySQL first
$conn = get_db_connection();
if($conn){
    $stmt = $conn->prepare('INSERT INTO messages (name,email,message,created_at) VALUES (?,?,?,NOW())');
    if($stmt){
        $stmt->bind_param('sss',$name,$email,$message);
        if($stmt->execute()){
            echo json_encode(['status'=>'ok','stored'=>'db']);
            $stmt->close();
            $conn->close();
            exit;
        }
        $stmt->close();
    }
    $conn->close();
}

// Fallback: append to data/messages.txt (ensure folder is writable)
$dataDir = __DIR__ . '/../data';
if(!is_dir($dataDir)) mkdir($dataDir,0755,true);
$file = $dataDir . '/messages.txt';
$entry = date('c') . "\t" . $name . "\t" . $email . "\t" . str_replace(["\r","\n"],[' ',' '],$message) . "\n";
$ok = file_put_contents($file,$entry,FILE_APPEND | LOCK_EX);

if($ok === false){
    echo json_encode(['status'=>'error','message'=>'Could not write message to storage.']);
    exit;
}

echo json_encode(['status'=>'ok','stored'=>'file']);

?>
