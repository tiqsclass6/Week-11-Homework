#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Get the IMDSv2 token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Background the curl requests
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
wait

macid=$(cat /tmp/macid)
local_ipv4=$(cat /tmp/local_ipv4)
az=$(cat /tmp/az)
vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${macid}/vpc-id)

echo "
<!doctype html>
<html lang="en" class="h-100">
  <head>
    <title>Details for EC2 Instance</title>
  </head>
  <font color="ffffff">
    <body background=https://brazil-2025.s3.us-east-1.amazonaws.com/brazil-bg.jpg>
      <h1><center>AWS Instance Details</center></h1>
      <h1><center>Theo's Brazilian Blondes</center></h1>
  </font>
  <table width=100%>
    <tr>
      <td width=33% align="center">
        <img src="https://brazil-2025.s3.us-east-1.amazonaws.com/brazil4.jpg" alt="Theo Blonde" width="527" height="791"></td>
      <td width=34% align="center">
        <font color="ffffff" size="5">
          <p><b>Instance Name:</b> $(hostname -f)</p>
          <p><b>Instance Private IP Address:</b> ${local_ipv4}</p>
          <p><b>Availability Zone:</b> ${az}</p>
          <p><b>Virtual Private Cloud (VPC):</b> ${vpc}</p>
        </font>
      </td>
      <td width=33% align="center">
        <img src="https://brazil-2025.s3.us-east-1.amazonaws.com/brazil2.jpg" alt="TIQS Afro-Braziliana" width="577" height="791"></td>
    </tr>
  </table>
  </body>
</html>
" > /var/www/html/index.html

# Clean up the temp files
rm -f /tmp/local_ipv4 /tmp/az /tmp/macid