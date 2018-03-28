<html>
<body>

<center><table>
  <td>
      <center><?php if (strpos($_SERVER[REMOTE_ADDR], ":") === false)
        echo '<img src="JAVA.jpg" \>';
      else
        echo '<img src="JAVA_animated.gif" \>';
      ?></center>
  </td>
  <td> </td>
  <td> </td>
  <td> </td>
  <td> </td>
  <td> </td>
  <td> </td>
  <td>
    <center><h1>Welcome to the IPv6 Test Target</h1></center>
    <center><h2><?php if (strpos($_SERVER[REMOTE_ADDR], ":") === false)
        echo '<div style="color:red">Sorry, this web page was accessed using IPv4.</div>';
      else
        echo '<div style="color:green">Success, you are running IPv6!</div>'; ?></h2></center>
    <center><h4>This IPv6 Test Target is a Docker Container.</h4></center>
    <br><?php echo "Hostname: <b>$_SERVER[HOSTNAME]</b>"; ?>
    <br><?php echo "HTTP Host Address: <b>$_SERVER[HTTP_HOST]</b>"; ?>
    <br><?php echo "Container Address: <b>$_SERVER[SERVER_ADDR]</b>"; ?>
    <br><?php echo "Local Time: <b>"; print strftime('%c'); echo "</b>"; ?>
    <br>
    <br><?php echo "Client Address: <b>$_SERVER[REMOTE_ADDR]</b>"; ?>
    <br><?php if (strpos($_SERVER[REMOTE_ADDR], ":") === false)
        echo '<center><h4><div style="color:red">If you were running IPv6 your cup of Java would be hot. </div></h4></center>'; ?>
  </td>
</table></center>


</body>
</html>
