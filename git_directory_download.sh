# This script downloads all the files within a directory from a git repo. 
# The script does not download directories. 
# It should be used only to download all files from a particular directory.

tree=`echo $1|grep "/tree/"`
echo $tree
if [ -n "$tree" ]; then
	echo "True"
else
	echo "Looks like you are trying to download the entire repo! "
	echo "You could directly download the zip file from github instead!"
	exit
fi

grepvalue=$(echo $1|sed 's/.*tree\///');
for link in `curl -k  $1|grep $grepvalue|grep -oP 'href="\K[^"]+'|sed -e "s/blob\///g"|egrep -v "github.com|tree|commit"|sed -e 's/^/https:\/\/raw.githubusercontent.com/'`; do wget -q  $link; done


#usage ./git_directory_download.sh <URL>
#example: ./git_directory_download.sh https://github.com/0xshyam/exploit-database/tree/master/platforms/cgi/remote
