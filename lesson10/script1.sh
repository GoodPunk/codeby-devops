#/bin/bash

if [[ ! -d ~/myfolder ]]; then
    mkdir ~/myfolder
fi

echo -e "Hello world!\n $(date)" > ~/myfolder/file1.txt

touch ~/myfolder/file2.txt
chmod 777 ~/myfolder/file2.txt

tr -dc A-Za-z0-9 </dev/urandom | head -c 20 > ~/myfolder/file3.txt

touch ~/myfolder/file4.txt
touch ~/myfolder/file5.txt