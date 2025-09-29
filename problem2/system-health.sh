
#!/bin/bash

cpu_limit=80
mem_limit=80
disk_limit=90
process_name="nginx"   # change this if you want to watch another service

log_file="$HOME/system_health.log"
now=$(date +"%Y-%m-%d %H:%M:%S")

cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | awk -F. '{print $1}')
mem=$(free | grep Mem | awk '{print $3/$2 * 100}' | awk -F. '{print $1}')
disk=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
proc_count=$(pgrep -c $process_name)

if [ "$cpu" -gt "$cpu_limit" ]; then
  echo "[$now] CPU alert: running hot at ${cpu}% usage." | tee -a $log_file
fi

if [ "$mem" -gt "$mem_limit" ]; then
  echo "[$now] Memory alert: ${mem}% used, getting close to the edge." | tee -a $log_file
fi

if [ "$disk" -gt "$disk_limit" ]; then
  echo "[$now] Disk alert: root partition at ${disk}% capacity." | tee -a $log_file
fi

if [ "$proc_count" -eq 0 ]; then
  echo "[$now] Process alert: '$process_name' is not running." | tee -a $log_file
fi
