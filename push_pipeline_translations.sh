#!/bin/bash
# Crated by Aaron Chen

DIR=${1%%/}
MISMATCH=

if [ -z $DIR ]; then
	echo -e "\nUsage: $(basename $0) translation_dir\n"
	exit 1
fi

if [ ! -d "$DIR" ]; then
	echo -e "\nTranslation directory '${DIR}' can not be found.\n"
	exit 1
fi

USER=$(git config user.name)
if [ -z "$USER" ]; then
	echo -e "Please set your user name by running: git config user.name \"your_name\""
	exit 1
fi

echo -e "### Check if the contents of translation directory (${DIR}) matches with the repository ###"
for i in $(ls -d */); do
	ext_dir=${i%%/}
	echo -e "- ${ext_dir}"
	
	if grep "${ext_dir}" .gitignore >/dev/null; then
		echo " >>> Skipped"
		continue
	fi
	
	git_files=$(ls -1 "$ext_dir")
	translation_files=$(ls -1 "${DIR}/$ext_dir")
	
	if [ "$git_files" == "$translation_files" ]; then
		echo " >>> Matched"
	else
		echo -e "Git								Translation"
		echo $(printf '+%.s' {1..80})
		diff --side-by-side <(echo "$git_files" ) <(echo "$translation_files")
		MISMATCH=1
	fi
done

if [ $MISMATCH ]; then
	echo -e "\nPlease correct mismatched files above and run the command again!\n"
	exit 1
else
	echo -e "\n### Copy files from translation directory ($DIR) to the repository ###"
	cp -R "${DIR}/" ./ 
	
	echo -e "\n### Push to the repository ###"
	git add * 
	git commit -m "Updating manually translated files on $(date) by ${USER}"
	git push
	
fi


