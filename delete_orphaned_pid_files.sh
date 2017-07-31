// SCRIPT  : delete_orphaned_PID_files.sh
// AUTHOR  : Marin Nedea										
// WEBSITE : http://sysadmins.tech								
// HOWTO   : Save the script to a location of your choice, chmod +x delete_orphaned_PID_files.sh,
//		       then run it as root ( #./delete_orphaned_PID_files.sh) 	

#!/bin/bash
processpid=$(ps axf | grep <process name here> | grep -v grep | awk '{print $1}')  #get the running <process name here> PID
dir=/var/run/*<process name here>.pid                                     			   #get all <process name here>.pid files in /var/run/ directory
for f in $dir                                                           			     #for each file in $dir
do
    pid=$(< "$f")                                                       			     #assign to var $pid the value in the file
      if [ "$processpid" -eq "$pid" ]
            then 
                  echo "<process name here> is running on PID $pid. Keeping $f intact."
            else 
                  echo "No process running on PID $pid. Deleting the $f file!"
                  rm -f $f                                              			    #deleting the file corresponding to the value of $f
      fi
done  
