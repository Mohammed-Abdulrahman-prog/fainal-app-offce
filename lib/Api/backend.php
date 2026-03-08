<?php
// اذا ارت ان تعدل علي شي في هذة الصفحة اثنا فحص الطلب والرد عدل على الصفحة التي في السيرفير xampp
error_reporting(E_ALL);
ini_set('display_errors', 1); 
// Database connection settings
$host = 'localhost'; // Change if your database is on a different host
$dbname = 'my_api';
$username = 'root'; // Your MySQL username
$password = ''; // Your MySQL password

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "Database connection failed: " . $e->getMessage()]);
    exit();
}

// Registration Function
function register($username, $password) {
    global $pdo;
   
    $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
    $stmt->execute([$username]);
   
    if ($stmt->rowCount() > 0) {
        return json_encode(["status" => "error", "message" => "User already exists."]);
    }
    //print("test");
    $stmt = $pdo->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
    $stmt->execute([$username, $password]); // Store password in plain text (not recommended)
   
    return json_encode(["status" => "success", "message" => "User registered successfully."]);
}

// Login Function
function login($username, $password) {
    global $pdo;
    $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ? AND password = ?");
    $stmt->execute([$username, $password]);

    if ($stmt->rowCount() === 0) {
        return json_encode(["status" => "error", "message" => "Invalid username or password."]);
    }

    return json_encode(["status" => "success", "message" => "Login successful."]);
}

// Fetch Products Function
function fetchProducts() {
    global $pdo;
    $stmt = $pdo->query("SELECT * FROM products");
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return json_encode(["status" => "success", "products" => $products]);
}

// Handling API requests
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $action = $_GET['action'] ?? '';

    switch ($action) {
        case 'register':
            $username = $_POST['username'] ?? '';
            $password = $_POST['password'] ?? '';
            echo register($username, $password);
            break;

        case 'login':
            $username = $_POST['username'] ?? '';
            $password = $_POST['password'] ?? '';
            echo login($username, $password);
            break;

        case 'fetchProducts':
            echo fetchProducts();
            break;

        default:
            echo json_encode(["status" => "error", "message" => "Invalid action."]);
            break;
    }
} else {
    echo json_encode(["status" => "error", "message" => "Only POST requests are allowed."]);
}
?>