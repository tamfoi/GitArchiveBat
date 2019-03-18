# use parameter -> $SHA

old_commit_id=""
new_commit_id=""

if [ -n "$1" ] && [ -n "$2" ] && [ -z "$3" ]; then
  old_commit_id=$2
  new_commit_id=$1
else
  echo "please select two commit" 
  read -p "any key to close"
  exit
fi

repository_absolute_path=`git rev-parse --show-toplevel`
repository_name=`basename $repository_absolute_path`
current_time=`date +%Y%m%d%H%M%S`

git diff --stat --name-status $old_commit_id $new_commit_id > ${HOME}/desktop/${repository_name}-${current_time}.txt
