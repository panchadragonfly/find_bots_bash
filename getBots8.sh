#!/bin/bash
#
exec 3>&1 1>getBots8.log 2>&1
echo "---------------------------------------------" | tee /dev/fd/3
echo " getBots.sh finds bots login in profileLogs " | tee /dev/fd/3     
echo " the bots are the following   "                | tee /dev/fd/3
echo "---------------------------------------------" | tee /dev/fd/3
set -x
userin="user logged in"                                  
userchangepass="user changed password"                  
userout="user logged off"
i=1                             
while read line
do
      if [ $i == 3 ]
      then
       line3=$(echo $line)
       user3=$(echo $line | cut -d"|" -f3,3)
       userout3=$(echo $line | cut -d'|' -f5,5)
       timelog3=$(echo $line | cut -d'|' -f1,1)
       if [ "$user1"  == "$user3" ]
       then 
         if [ "$userout" == "$userout3" ]
         then
            if [ "$timelog2" == "$timelog3" ]
            then
                set +x
                echo $user3  | tee /dev/fd/3
                set -x
                i=1
            else
               i=1
            fi
         else
            i=1
         fi
       else
         i=1
       fi
     fi
   if [ $i == 2 ]
   then
      line2=$(echo $line)
      user2=$(echo $line | cut -d"|" -f3,3)
      userchangepass2=$(echo $line | cut -d'|' -f5,5)
      timelog2=$(echo $line | cut -d'|' -f1,1)
      if [ "$user1"  == "$user2" ]
      then
        if [ "$userchangepass" == "$userchangepass2" ]
        then
           if [ "$timelog2" == "$timelog1" ]
           then
              i=$(($i + 1))
           else
              i=1
           fi
        else
           i=1
        fi
      else
        i=1
      fi
    fi
  if [ $i == 1 ]
  then
    line1=$(echo $line)
    user1=$(echo $line | cut -d"|" -f3,3)
    userin1=$(echo $line | cut -d'|' -f5,5)
    timelog1=$(echo $line | cut -d'|' -f1,1)
    if [ "$userin" == "$userin1" ]
    then
       i=$(($i + 1))
    else
      i=1
    fi
   fi
done < profileLogs.log
set +x
echo "------------------------------------"  | tee /dev/fd/3
echo "          end bot lists             "  | tee /dev/fd/3
echo "------------------------------------"  | tee /dev/fd/3                         
exit 0                                                
