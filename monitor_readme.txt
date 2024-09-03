# System Monitoring Dashboard Script

This Bash script monitors various system resources and presents them in a dashboard format. The script refreshes the data every few seconds, providing real-time insights. Additionally, it allows users to call specific parts of the dashboard individually using command-line switches.

## Features

1. **Top 10 Most Used Applications**
   - Displays the top 10 applications consuming the most CPU and memory.

2. **Network Monitoring**
   - Number of concurrent connections to the server.
   - Packet drops.
   - Number of MB in and out.

3. **Disk Usage**
   - Displays the disk space usage by mounted partitions.
   - Highlights partitions using more than 80% of the space.

4. **System Load**
   - Shows the current load average for the system.
   - Includes a breakdown of CPU usage (user, system, idle, etc.).

5. **Memory Usage**
   - Displays total, used, and free memory.
   - Swap memory usage.

6. **Process Monitoring**
   - Displays the number of active processes.
   - Shows top 5 processes in terms of CPU and memory usage.

7. **Service Monitoring**
   - Monitors the status of essential services like sshd, nginx/apache, iptables, etc.

8. **Custom Dashboard**
   - Provides command-line switches to view specific parts of the dashboard, e.g., `-cpu`, `-memory`, `-network`, etc.

## Usage

### Running the Full Dashboard

To run the full dashboard, simply execute the script:

```bash
./monitoring_dashboard.sh


The dashboard will refresh every 5 seconds, providing real-time insights.

Viewing Specific Parts of the Dashboard
You can use command-line switches to view specific parts of the dashboard. Here are the available switches:

-cpu: View the top 10 most used applications.
-network: View network monitoring details.
-disk: View disk usage information.
-load: View system load and CPU usage breakdown.
-memory: View memory usage details.
-process: View process monitoring details.
-service: View the status of essential services.

Examples
To view the top 10 most used applications:
./monitoring_dashboard.sh -cpu

To view network monitoring details:
./monitoring_dashboard.sh -network

To view disk usage information:
./monitoring_dashboard.sh -disk

To view system load and CPU usage breakdown:
./monitoring_dashboard.sh -load

To view memory usage details:
./monitoring_dashboard.sh -memory

To view process monitoring details:
./monitoring_dashboard.sh -process

To view the status of essential services:
./monitoring_dashboard.sh -service

