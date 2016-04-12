#!/usr/bin/env bash
RESULTS="Repository:Branch:Status"
for i in `find . -name ".git"`;
do
	pushd . > /dev/null
	REPO=${i%/.git}
	cd $REPO
	BRANCH=`git branch | grep "^*" | cut -d " " -f 2`
	STATUS=""
	if [[ -z $(git status -s) ]]; then
		STATUS="clean"
	else
		STATUS="dirty"
	fi
	RESULTS="$RESULTS\n$REPO:$BRANCH:$STATUS"
	popd > /dev/null
done
echo -e $RESULTS | column -t -s ':'
