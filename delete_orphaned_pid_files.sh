# SCRIPT  : delete_orphaned_PID_files.sh
# AUTHOR  : Marin Nedea
# WEBSITE : http://sysadmins.tech
# HOWTO   : Save the script to a location of your choice, chmod +x delete_orphaned_PID_files.sh,
#           and run it as root
#           Make sure you changed example_process below with your actual process/service.

#!/bin/bash

process_name=example_process
processpid=$(ps axf | grep $process_name | grep -v grep | awk '{print $1}') #get the running service/process name PID
dir=/var/run/*$process_name.pid                                             #get all process .pid files in /var/run/ directory 
for f in $dir                                                               #for each file in $dir
do
    pid=$(< "$f")                                                           #assign to var $pid the value in the file
      if [ "$processpid" -eq "$pid" ]
            then
                  echo "$process_name is running on PID $pid. Keeping $f intact."
            else
                  echo "No process running on PID $pid. Deleting the $f file!"
                  rm -f $f                                                 #deleting the file corresponding to the $f
      fi
done 
