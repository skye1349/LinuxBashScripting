#!/bin/bash
#must under root privileges (make sure the script is being executed with superuser privileges)
if [[ ${UID} != 0 ]]
then
  echo 'the script must be executed under root user'
  exit 1
fi
# enter the username
read -p 'enter the username: ' USER_NAME
# enter the realname
read -p 'enter the user of this account: ' COMMENT
#enter the password
read -p 'enter the password set for this user: ' PASSWORD
#create this new user(create the user with the password)
sudo adduser -c "${COMMENT}" -m "${USER_NAME}"
# check to see if the useradd command succeeded
if [[ "$?" != 0 ]]
then
  echo "failed add a user named "${USER_NAME}""
  exit 1
fi
# set the password
echo "${PASSWORD}" | passwd --stdin ${USER_NAME}
# check to see if the passwd command succeeded
if [[ "$?" != 0 ]]
then
  echo "failed set the password for "${USER_NAME}""
  exit 1
fi
# Force passwd change on first login
passwd -e ${USER_NAME}
# check to see if the passwd command succeeded
if [[ "$?" != 0 ]]
then
  echo "failed to force passwd change on first login"
  exit 1
fi
#Displays the username, password, and host
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"