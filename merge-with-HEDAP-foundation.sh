#!/bin/sh
# assume this will be run inside project
#env -i git pull origin/master
echo check your hedap-fork has only origin for remotes
echo 	
env -i git remote -v

echo
sleep 1 

echo 
echo pull from origin/master
env -i git pull origin master

echo adding remote repo SalesforceFoundation Hedap
env -i git remote add -f b git@github.com:SalesforceFoundation/HEDAP.git

# ssh -vT git@github.com will tell you what is being done by ssh
echo get latest for both origin and b.  You could do one at a time: origin and b
env -i git remote update

echo see difference between our hedap fork with salesforce foundation remote
env -i git diff origin/master remotes/b/master --name-only 
sleep 10

echo merge salesforce foundation with our hedap-fork
echo THIS WILL KEEP OUR HISTORY
env -i git merge remotes/b/master


