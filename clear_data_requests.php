<?php

include("../db_ini.php");

$data_string = NULL;
$data_string = strval(getPost('channelrange', '-1;;'));

$data_start = 0;
$data_end = strlen($data_string);
$channel_start = $data_start;
$channels_list = "(";
while ($channel_start < $data_end)
{
  if ($channel_start>0) $channels_list .= ",";
  $channel_end = strpos($data_string, ';', $channel_start);
  $channel_string = mb_substr($data_string, $channel_start, $channel_end-$channel_start);
  $channel = intval($channel_string);
  $points_start = $channel_end+1;
  $points_end = strpos($data_string, ';', $points_start);
  $points_string = mb_substr($data_string, $points_start, $points_end-$points_start);
  while ($points_start < $points_end)
  {
    $timestamp_start = $points_start;
    $timestamp_end = strpos($data_string, ",", $timestamp_start);
    $timestamp_string = mb_substr($data_string, $timestamp_start, $timestamp_end-$timestamp_start);
    $timestamp = intval($timestamp_string);
    $value_start = $timestamp_end+1;
    $value_end = strpos($data_string, ",", $value_start);
    $value_string = mb_substr($data_string, $value_start, $value_end-$value_start);
    $value = doubleval($value_string);
    $subsamples_start = $value_end+1;
    $subsamples_end = strpos($data_string, ",", $subsamples_start);
    $subsamples_string = mb_substr($data_string, $subsamples_start, $subsamples_end-$subsamples_start);
    $base64_start = $subsamples_end+1;
    $base64_end = strpos($data_string, ",", $base64_start);
    $base64_string = mb_substr($data_string, $base64_start, $base64_end-$base64_start);
    $points_start = $base64_end+1;
  }
  $channel_start = $points_end+1;
  $channels_list .= $channel_string;
}
$channels_list .= ")";

$conn = mysqli_init();
if (!$conn) 
{
  die('mysqli_init failed');
}
if (!$conn->options(MYSQLI_OPT_CONNECT_TIMEOUT, 5)) 
{
  die('Setting MYSQLI_OPT_CONNECT_TIMEOUT failed');
}
if (!$conn->real_connect($servername, $username, $password, $dbname)) 
{
  die('Connect Error (' . mysqli_connect_errno() . ') ' . mysqli_connect_error());
}

//$conn = new mysqli($servername, $username, $password, $dbname);
//if (mysqli_connect_errno())
//{
//  printf("Connect failed: %s\n", mysqli_connect_error());
//  exit();
//}

$conn->autocommit(FALSE);
$conn->begin_transaction();
$stmt=$conn->prepare("DELETE FROM " . $acquired_data_table_name . " WHERE CHANNEL_INDEX IN " . $channels_list . " AND STATUS = -1");
if(!$stmt->execute())
{
  $conn->rollback();
  //exit();
}
$stmt=$conn->prepare("OPTIMIZE TABLE " . $acquired_data_table_name);
if(!$stmt->execute())
{
  $conn->rollback();
  //exit();
}

$stmt->close();
$conn->commit();
$conn->close();

$return_string = "";
$return_string = $channels_list;

header("Content-type: application/json");
$json_array = array('returnstring' => $return_string);
echo json_encode($json_array);


function getPost($key, $default) 
{
  if (isset($_POST[$key]))
    return $_POST[$key];
  return $default;
}

?>
