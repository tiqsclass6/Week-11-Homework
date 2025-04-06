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
<<<<<<< HEAD
  <head>
    <title>Details for EC2 instance</title>
  <body background=https://japan-2025.s3.us-east-1.amazonaws.com/japan-bg.jpg>
    </head>
    <div>
      <font color="ffffff">
        <h1>
          <center>Class 6 is Secure</center>
        </h1>
        <h1>
          <center>In Japan with these Beauties</center>
        </h1>
      </font><br>
      <table width=100%>
        <tr>
          <td width=33% align="center"><img src="https://japan-2025.s3.us-east-1.amazonaws.com/japan1.jpg" alt="Japanese Models" width="500" height="720"></td>
          <td width=34% align="left"><img src="https://japan-2025.s3.us-east-1.amazonaws.com/japan2.jpg" alt="Japanese Models" width="500" height="720"></td>
          <td width=33% align="left"><img src="https://japan-2025.s3.us-east-1.amazonaws.com/japan3.jpg" alt="Japanese Models" width="500" height="720"></td>
        </tr>
        <tr>
          <td width=33% align="center"></td>
          <td width=34% align="left">
            <font color="ffffff" size="5">
              <p><b>Instance Name:</b> $(hostname -f)</p>
              <p><b>Instance Private Ip Address:</b> ${local_ipv4}</p>
              <p><b>Availability Zone:</b> ${az}</p>
              <p><b>Virtual Private Cloud (VPC):</b> ${vpc}</p>
            </font>
          </td>
          <td width=33% align="center"></td>
        </tr>
      </table>
    </div>
  </body>
=======
<head>
<title>Details for EC2 instance</title>
<body background=https://images.unsplash.com/photo-1478436127897-769e1b3f0f36?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D>
</head>
<div>
<font color="ffffff">
<h1>Class 6 is Secure</h1>
<h1>In Southeast Asia with these Beauties</h1>
</font>
<br>
<table width=100%>
<tr>
<td width=100% align="left">
<img src="https://cdn.coconuts.co/coconuts/wp-content/uploads/2019/09/24879744_10208828270738785_4906269658246515610_o.jpg" alt="Thai Models" width="50%" height="50%">
</td>
</tr>
<tr>
<td width=100% align="left">
<img src="https://i.imgur.com/vhpjPDr.jpeg" alt="Sexy Japanese Ladies" width="50%" height="50%">
</td>
</tr>
</table>
<br>
<font color="ffffff" size="5">
<p><b>Instance Name:</b> $(hostname -f)</p>
<p><b>Instance Private Ip Address:</b> ${local_ipv4}</p>
<p><b>Availability Zone:</b> ${az}</p>
<p><b>Virtual Private Cloud (VPC):</b> ${vpc}</p>
</font>
</div>
</body>
>>>>>>> 4ae95e575b63e006cd5f63029937a2ccd5901860
</html>
" > /var/www/html/index.html

# Clean up the temp files
rm -f /tmp/local_ipv4 /tmp/az /tmp/macid