<?php
error_reporting(E_ALL);
ini_set('display_errors', 1); 
// Database connection settings
$host = '127.0.0.1'; // Change if your database is on a different host
$dbname = 'library';
$username = 'root'; // Your MySQL username
$password = ''; // Your MySQL password

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "Database connection failed: " . $e->getMessage()]);
    exit();
}

// Fetch bookType Function 
function fetchbookType() {
    global $pdo;
    $stmt = $pdo->query("SELECT DISTINCT bookType FROM book");
    $book = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return json_encode(["status" => "success", "book" => $book]);
}

function AllBooksClass($bookType) {
    global $pdo;
    $stmt = $pdo->prepare("SELECT * FROM book WHERE bookType = ?");
    $stmt->execute([$bookType]);
    $book = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return json_encode(["status" => "success", "book" => $book]);
}

// وظيفة لرفع ملف إلى قاعدة البيانات
function uploadFile($file) {
    global $pdo;

    // التحقق من وجود الملف
    if ($file['error'] === UPLOAD_ERR_OK) {
        $fileTmpPath = $file['tmp_name'];
        $fileName = $file['name'];
        $fileSize = $file['size'];
        $fileType = $file['type'];

        // قراءة محتويات الملف
        $fileContent = file_get_contents($fileTmpPath);
        
        // حفظ المحتوى في قاعدة البيانات
        $stmt = $pdo->prepare("INSERT INTO files (name, size, type, content) VALUES (?, ?, ?, ?)");
        $stmt->execute([$fileName, $fileSize, $fileType, $fileContent]);
        
        return json_encode(["status" => "success", "message" => "تم رفع الملف بنجاح."]);
    } else {
        return json_encode(["status" => "error", "message" => "فشل في رفع الملف."]);
    }
}

// Handling API requests
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    switch ($action) {

        case 'fetchbookType':
            echo fetchbookType();
            break;

        case 'AllBooksClass':
            $bookType = $_POST['bookType'] ?? '';
            echo AllBooksClass($bookType);
            break;

        case 'uploadFile':
            echo uploadFile($_FILES['file']);
            break;

        default:
            echo json_encode(["status" => "error", "message" => "Invalid action."]);
            break;
    }
} else {
    echo json_encode(["status" => "error", "message" => "Only POST requests are allowed."]);
}
?>