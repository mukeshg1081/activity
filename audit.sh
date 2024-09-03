#!/bin/bash

# List all users and groups
echo "Listing all users and groups:"
cut -d: -f1 /etc/passwd
cut -d: -f1 /etc/group

# Check for users with UID 0
echo "Checking for users with UID 0:"
awk -F: '($3 == "0") {print}' /etc/passwd

# Identify users without passwords or with weak passwords
echo "Checking for users without passwords or with weak passwords:"
awk -F: '($2 == "" || length($2) < 8) {print $1}' /etc/shadow

# Scan for world-writable files and directories
echo "Scanning for world-writable files and directories:"
find / -type f -perm -o+w -exec ls -l {} \;
find / -type d -perm -o+w -exec ls -ld {} \;

# Check .ssh directories for secure permissions
echo "Checking .ssh directories for secure permissions:"
find /home -type d -name ".ssh" -exec chmod 700 {} \;

# Report files with SUID or SGID bits set
echo "Reporting files with SUID or SGID bits set:"
find / -perm /6000 -exec ls -l {} \;

# List all running services
echo "Listing all running services:"
systemctl list-units --type=service --state=running

# Check for unnecessary or unauthorized services
echo "Checking for unnecessary or unauthorized services:"
# Define a list of critical services
critical_services=("sshd" "iptables")
for service in "${critical_services[@]}"; do
    systemctl is-active --quiet $service || echo "$service is not running"
done

# Check for services listening on non-standard or insecure ports
echo "Checking for services listening on non-standard or insecure ports:"
netstat -tuln

# Verify firewall status
echo "Verifying firewall status:"
ufw status || iptables -L

# Report open ports and associated services
echo "Reporting open ports and associated services:"
netstat -tuln

# Check for IP forwarding
echo "Checking for IP forwarding:"
sysctl net.ipv4.ip_forward

# Identify public vs. private IPs
echo "Identifying public vs. private IPs:"
ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}'

# Check for available security updates
echo "Checking for available security updates:"
apt-get update && apt-get upgrade -s | grep -i security

# Check for suspicious log entries
echo "Checking for suspicious log entries:"
grep "Failed password" /var/log/auth.log

# SSH Configuration
echo "Configuring SSH:"
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

# Disable IPv6
echo "Disabling IPv6:"
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

# Secure the bootloader
echo "Securing the bootloader:"
grub-mkpasswd-pbkdf2
# Add the generated password hash to /etc/grub.d/40_custom

# Configure firewall rules
echo "Configuring firewall rules:"
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

# Configure automatic updates
echo "Configuring automatic updates:"
apt-get install unattended-upgrades
dpkg-reconfigure --priority=low unattended-upgrades

# Placeholder for custom security checks
echo "Running custom security checks:"
# Add custom checks here

# Generate summary report
echo "Generating summary report:"
# Collect and summarize the results of the above checks

# Optionally send email alerts
echo "Sending email alerts:"
# Configure email alerts if needed

