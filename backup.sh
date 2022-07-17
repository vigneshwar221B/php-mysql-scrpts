#!/bin/bash

main () {
  echo "db backup started..."

  day="$(date +'%A')"
  db_backup="mydb_backup_${day}.sql"

  username=""
  password=""

  # read from envs
  if [[ -z "${mysql_uname}" ]]; then
   username="default" 
  else
   username="${mysql_uname}"
  fi

  if [[ -z "${password}" ]]; then
   password="default" 
  else
   password="${password}"
  fi

  # read from cmd line args
  if [ "$#" -eq 0 ] ; then 
   echo "no cmd line args are specified. Using the envs" 
  else 
    username=$1
    password=$2
  fi    

  eval "mysqldump --all-databases -u $username -p $password > /opt/backups/${db_backup}"
  echo "db backup complete!"
}

main