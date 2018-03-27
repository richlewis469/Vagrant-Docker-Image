<html>
<body>

<center><h1>Welcome to the IPv6 Test Target</h1></center>

<center><h2><?php if (strpos($_SERVER[REMOTE_ADDR], ":") === false)
    echo '<div style="color:red">Sorry, this web page was accessed using IPv4.</div>';
  else
    echo '<div style="color:green">Success, you are running IPv6!</div>'; ?></h2></center>

<br>

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
  <td>
    This IPv6 test target is a docker container.
    <br>
    <br><?php echo "Hostname: <b>$_SERVER[HOSTNAME]</b>"; ?>
    <br>IPv4 Address: <b>MyIPv4AddrVar/24</b>
    <br>IPv6 Address: <b>MyIPv6AddrVar/64</b>
    <br><?php echo "Local Time: <b>"; print strftime('%c'); echo "</b>"; ?>
    <br>
    <br><?php echo "Container IP Address: <b>$_SERVER[SERVER_ADDR]</b>"; ?>
    <br><?php echo "Client IP Address: <b>$_SERVER[REMOTE_ADDR]</b>"; ?>
  </td>
</table></center>

<?php if (strpos($_SERVER[REMOTE_ADDR], ":") === false)
    echo '<center><h3><div style="color:red">If you were running IPv6 your cup of Java would be hot. </div></h3></center>'; ?>
<center><h3>Learn more about Oracle's IPv6 Program at <a href="http://ipv6.oraclecorp.com">http://ipv6.oraclecorp.com</a></center>

</body>
</html>
