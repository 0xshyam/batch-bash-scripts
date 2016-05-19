#To recursively replace strings in a folder
find <OPTIONAL PATH> -type f -print0 | xargs -0 sed -i 's/String_to_be_replaced/Replacing_string/g'

#To remove all the data before a particular text in a file
sed -i '1,/FROM_TEXT/d' filename

#
