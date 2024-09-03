# Linux Server Security Audit and Hardening Script

## Description
This Bash script automates the security audit and hardening process for Linux servers. It includes checks for common security vulnerabilities and implements hardening measures to ensure servers meet stringent security standards.

## Features
- User and Group Audits
- File and Directory Permissions Checks
- Service Audits
- Firewall and Network Security Checks
- IP and Network Configuration Checks
- Security Updates and Patching
- Log Monitoring
- Server Hardening Steps
- Custom Security Checks
- Reporting and Alerting

## Usage
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/security-audit-script.git
   cd security-audit-script

Customize the configuration files:
custom_checks.conf
hardening_measures.conf
Run the script:
./security_audit.sh

Configuration
custom_checks.conf: Define custom security checks.
hardening_measures.conf: Define hardening measures.

###################################################################################


Script to Read and Apply Configuration
You can modify your main script to read these configuration files and apply the settings. Here’s an example of how to do this:

#!/bin/bash

# Load custom checks configuration
source custom_checks.conf

# Load hardening measures configuration
source hardening_measures.conf

# Apply custom checks
echo "Applying custom security checks:"
IFS=',' read -r -a users <<< "${CustomChecks[check_users]}"
for user in "${users[@]}"; do
    id "$user" &>/dev/null || echo "User $user does not exist"
done

IFS=',' read -r -a services <<< "${CustomChecks[check_services]}"
for service in "${services[@]}"; do
    systemctl is-active --quiet "$service" || echo "Service $service is not running"
done

IFS=',' read -r -a ports <<< "${CustomChecks[check_ports]}"
for port in "${ports[@]}"; do
    netstat -tuln | grep ":$port" || echo "Port $port is not open"
done

# Apply hardening measures
echo "Applying hardening measures:"

# SSH Configuration
sed -i "s/^PermitRootLogin.*/PermitRootLogin ${SSH[PermitRootLogin]}/" /etc/ssh/sshd_config
sed -i "s/^PasswordAuthentication.*/PasswordAuthentication ${SSH[PasswordAuthentication]}/" /etc/ssh/sshd_config
echo "AllowUsers ${SSH[AllowUsers]}" >> /etc/ssh/sshd_config
systemctl restart sshd

# Firewall Configuration
ufw default "${Firewall[DefaultPolicyIncoming]}" incoming
ufw default "${Firewall[DefaultPolicyOutgoing]}" outgoing
IFS=',' read -r -a allowed_ports <<< "${Firewall[AllowedPorts]}"
for port in "${allowed_ports[@]}"; do
    ufw allow "$port"
done
ufw enable

# IPv6 Configuration
if [ "${IPv6[DisableIPv6]}" == "yes" ]; then
    echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
    sysctl -p
fi

# Automatic Updates
if [ "${AutoUpdates[EnableUnattendedUpgrades]}" == "yes" ]; then
    apt-get install unattended-upgrades
    dpkg-reconfigure --priority=low unattended-upgrades
fi
if [ "${AutoUpdates[RemoveUnusedPackages]}" == "yes" ]; then
    apt-get autoremove -y
fi

echo "Security audit and hardening completed."
