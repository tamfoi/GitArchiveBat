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

copy_target_absolute_path=${HOME}/desktop/${repository_name}-${current_time}

diff_list=`git diff --name-only --diff-filter=ACMRTUXB $old_commit_id $new_commit_id`
for file_path in $diff_list
do
  directory_path=`dirname $file_path`
  mkdir -p $copy_target_absolute_path/$directory_path
  git show $new_commit_id:$file_path > $copy_target_absolute_path/$file_path
done

#mkdir $copy_target_absolute_path
#git diff --name-only --diff-filter=ACMRTUXB $old_commit_id $new_commit_id | xargs -i cp --parents {} $copy_target_absolute_path
