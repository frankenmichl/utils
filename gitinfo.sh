#!/usr/bin/env bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
RESULTS="Repository:Branch:Status"
for i in `find . -name ".git"`;
do
	pushd . > /dev/null
	REPO=${i%/.git}
	cd $REPO
	BRANCH=`git branch | grep "^*" | cut -d " " -f 2`
	STATUS=""
	if [[ -z $(git status -s) ]]; then
		STATUS="${GREEN}clean${NC}"
	else
		STATUS="${RED}dirty${NC}"
	fi
	RESULTS="$RESULTS\n$REPO:$BRANCH:$STATUS"
	popd > /dev/null
done
echo -e $RESULTS | column -t -s ':'
