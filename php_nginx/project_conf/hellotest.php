<!DOCTYPE html>
<html>
<body>

<?php
$servername = "mysql";
$username = "root";
$password = "111111";
$dbname = "test";

// 创建连接
$conn = new mysqli($servername, $username, $password,$dbname);

// 检测连接
if ($conn->connect_error) {
    die("连接MySql失败: " . $conn->connect_error);
}
echo "Hello World! 连接MySql成功:" . $conn-> host_info; //query("show databases")->fetch_assoc()["Database"];
$conn->close();
?>

<?php
phpinfo();
?>

</body>
</html>