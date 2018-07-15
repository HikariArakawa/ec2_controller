#! /bin/bash

start_list=(`ls -lt ./days/*.txt | head -1 | sed -e "s/.* //g"`)
instances=(`cat $start_list | xargs`)

for inst in ${instances[@]}; do
  echo $inst
  #timeout 4 aws ec2 wait instance-status-ok --instance-ids $inst
  timeout 3 aws ec2 wait instance-exists --instance-ids $inst
  
  if [ $? -eq 0 ]; then
    aws ec2 start-instances --instance-ids $inst
  fi
done
