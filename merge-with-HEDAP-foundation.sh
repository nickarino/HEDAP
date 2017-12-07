#!/bin/bash
printf "Script Purpose: Merge with HEDAP master of SalesforceFoundation.\nLocation: at the root of the HEDAP-fork repository. \n\n"

printf "Step 1. Pulling latest from remote master...\n"
env -i git pull --rebase

read -rsp $'\nPress any key to continue...' -n 1 key

printf "\n\nChecking if a remote b has already existed...\n"
env -i git remote -v

printf "\nIf a remote b does not exist, continue with step 2 (adding a new remote b), otherwise skip step 2 and call step 3 directly.\n"
printf "Choose the step that you want to go to, type either 2 or 3, followed by [ENTER]: "  
read step

if [ $step == 2 ]
then
  printf "\nStep 2. Adding HEDAP on SalesforceFoundation as a new remote b...\n"
  # The try catch block takes care of the situation that if user type 2 again while b already exists.
  { # try
      env -i git remote add -f b git@github.com:SalesforceFoundation/HEDAP.git
  } || { # catch
    printf "\nIt seems remote b already exists. We'll continue with step 3.\n\nStep 3. Fetching updates for remotes...\n"
    env -i git remote update
  }
elif [ $step == 3 ] 
then
  printf "\nStep 3. Fetching updates for remotes...\n"
  env -i git remote update
else
  printf "Not a valid choice...exit.\n\n"
  exit
fi

printf "\nStep 4. Showing the difference between origin master and b master by file name(s)...\n" 
# try catch error exit. The try catch block takes care of the situation that if user type 3 while b does not exist.
{ # try
    env -i git diff master remotes/b/master --name-only
} || { # catch
  printf "\nIt seems you do not have a remote b yet. Please run the script again and choose step 2.\n\n"
  exit
}
  
read -rp $'\nAre you sure to merge the changes? [y/N] ' response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    printf "\nStep 5. Merging...\n"
    env -i git merge remotes/b/master

    read -rsp $'\nPress any key to continue...' -n 1 key

    printf "\nStep 6. Committing the changes...\n"
    env -i git commit -a -m "get latest from SalesforceFoundation"

    read -rsp $'\nPress any key to continue...' -n 1 key

    printf "\nStep 7. Removing b...\n"
    env -i git remote rm b

    printf "\nStep 8. Pushing the changes...\n"
    env -i git push origin master
else
    printf "\nOk, we will not merge the change(s) at this time. Bye.\n"
    exit
fi
