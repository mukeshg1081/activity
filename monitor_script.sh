#!/bin/bash

# Function to display top 10 most used applications
top_apps() {
    echo "Top 10 Most Used Applications (CPU and Memory):"
    ps aux --sort=-%cpu | head -n 11
    echo ""
}

# Function to monitor network
network_monitor() {
    echo "Network Monitoring:"
    echo "Concurrent connections to the server:"
    netstat -an | grep ESTABLISHED | wc -l
    echo "Packet drops:"
    netstat -s | grep "packet receive errors"
    echo "Number of MB in and out:"
    ifconfig | grep 'RX bytes' | awk '{print "In: " $2 " Out: " $6}'
    echo ""
}

# Function to display disk usage
disk_usage() {
    echo "Disk Usage:"
    df -h | awk '$5 > 80 {print $0}'
    echo ""
}

# Function to show system load
system_load() {
    echo "System Load:"
    uptime
    echo "CPU Usage Breakdown:"
    mpstat
    echo ""
}

# Function to display memory usage
memory_usage() {
    echo "Memory Usage:"
    free -h
    echo "Swap Memory Usage:"
    swapon --show
    echo ""
}

# Function to monitor processes
process_monitor() {
    echo "Process Monitoring:"
    echo "Number of active processes:"
    ps aux | wc -l
    echo "Top 5 Processes (CPU and Memory):"
    ps aux --sort=-%cpu | head -n 6
    echo ""
}

# Function to monitor essential services
service_monitor() {
    echo "Service Monitoring:"
    for service in sshd nginx apache2 iptables; do
        systemctl is-active --quiet $service && echo "$service is running" || echo "$service is not running"
    done
    echo ""
}

# Main dashboard function
dashboard() {
    clear
    top_apps
    network_monitor
    disk_usage
    system_load
    memory_usage
    process_monitor
    service_monitor
}

# Command-line switches
while [[ "$1" != "" ]]; do
    case $1 in
        -cpu ) top_apps
               ;;
        -network ) network_monitor
                   ;;
        -disk ) disk_usage
                ;;
        -load ) system_load
                ;;
        -memory ) memory_usage
                  ;;
        -process ) process_monitor
                   ;;
        -service ) service_monitor
                   ;;
        * ) dashboard
            ;;
    esac
    shift
done

# Refresh the dashboard every few seconds
while true; do
    dashboard
    sleep 5
done
