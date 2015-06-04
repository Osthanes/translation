#!/bin/bash
# Created by Aaron Chen

DIR=${1%%/}

OSTHANES=$(pwd)
USER=$(git config user.name)
MISMATCH=

if [ -z $DIR ]; then
	echo -e "\nUsage: $(basename $0) translation_dir\n"
	exit 1
fi

if [ ! -d "$DIR" ]; then
	echo -e "\nTranslation directory '${DIR}' can not be found.\n"
	exit 1
fi

if [ -z "$USER" ]; then
	echo -e "Please set your user name by running: git config user.name \"your_name\""
	exit 1
fi

echo "### Check if the contents of translation directory matches with the repository ###"
echo -e "Git:\n\t${OSTHANES}"
echo -e "Translation:\n\t${DIR}"
cd "${DIR}"
for i in $(ls -d */); do
	ext_dir=${i%%/}
	echo -e "\n--- ${ext_dir} ---"
	
	if grep "${ext_dir}" ${OSTHANES}/.gitignore >/dev/null; then
		echo " >>> Skipped"
		continue
	fi
	
	git_files=$(ls -1 "${OSTHANES}/$ext_dir" 2>/dev/null)
	translation_files=$(ls -1 "$ext_dir" 2>/dev/null)
	
	if [ "$git_files" == "$translation_files" ]; then
		echo " >>> Matched"
	else
		echo -e "Git								Translation"
		echo $(printf '+%.s' {1..80})
		diff --side-by-side <(echo "$git_files" ) <(echo "$translation_files")
		MISMATCH=1
	fi
done
cd "${OSTHANES}"

if [ $MISMATCH ]; then
	echo -e "\nPlease take a moment to review the mismatched files above!\n"
	read -r -p "Do you want to continue the push? [y/N] " response
	if [[ ! $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
		echo -e "\nExit!\n"
		exit 1
	fi
fi

echo -e "\n### Copy files from translation directory to the repository ###"
cp -R "${DIR}/" ./
	
echo -e "\n### Push to Github ###"
git add *
git commit -m "Updating manually translated files on $(date) by ${USER}"
git push

echo -e "\nDone!\n"
	



