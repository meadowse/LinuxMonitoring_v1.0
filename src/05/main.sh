#!/bin/bash
start=$(date +%s%N)
if ! [ $# -eq 1 ]
then
    echo "Incorrect number of parameters. 1 parameter expected and $# given"
	exit 1
fi
if ! [[ $1 == */ ]]
then
    echo "Incorrect parameter: Parameter must endings with \"/\"-symbol. Enter another parameter"     
	exit 1
fi
directory=$1
if ! [ -d $directory ] 
then
    echo "Incorrect parameter: Directory does not exist"     
	exit 1
fi
echo "Total number of folders (including all nested ones) = "$(ls -la $directory | grep ^d | wc -l) 
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
sudo du -Sh $directory | sort -rh | head -5 | awk '{print NR" - "$2", "$1}'
echo "Total number of files = "$(sudo find $directory -type f | wc -l) 
echo "Number of:  "
echo "Configuration files (with the .conf extension) = "$(sudo find $directory -type f | grep "\.conf" | wc -l)
echo "Text files = "$(sudo find $directory -type f | egrep "\.(txt|text)" | wc -l)
echo "Executable files = "$(sudo find $directory -type f | egrep "\.(exe|sh)" | wc -l)
echo "Log files (with the extension .log) = "$(sudo find $directory -type f | grep "\.log" | wc -l)
echo "Archive files = "$(sudo find $directory -type f | egrep "\.(zip|rar|gz|tar|7z)" | wc -l)
echo "Symbolic links = "$(sudo find $directory -type f | grep "\.lnk" | wc -l)
echo "TOP 10 files of maximum size arranged in descending order (size, path  and type):  "
sudo find $directory -type f -exec du -h {} + | sort -hr | head -10 | awk -F. '{print NR" - "$0"\t "$NF}'
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
file_path=($(sudo find $directory -type f -executable -exec du -h {} + | sort -hr | head -10 | awk '{print $2}'))
file_size=($(sudo find $directory -type f -executable -exec du -h {} + | sort -hr | head -10 | awk '{print $1}'))
for (( i = 0; i < 10; i++ )); do
    if ! [[ ${file_path[$i]} == "" ]]; then
    file_md5+=($(md5sum ${file_path[$i]} | awk '{print $1}'))
    fi
done   
for (( i = 0; i < 10; i++ )); do
    printf "%d - %s\t %s\t %s\n" "$(($i + 1))" "${file_path[$i]}" "${file_size[$i]}" "${file_md5[$i]}"
done                                                                
end=$(date +%s%N)
echo "Script execution time (in seconds) = $((($end-$start)/1000000000)).$((($end-$start)/1000000))"