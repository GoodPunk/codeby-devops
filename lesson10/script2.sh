#/bin/bash

if [[ ! -d ~/myfolder ]]; then
    echo "Папка myfolder не создана."
    exit 0
fi


file_count=$(ls -1 myfolder | wc -l)
echo "Количество файлов в папке: $file_count"

chmod 664 ~/myfolder/file2.txt

find ~/myfolder -size 0 -print -delete


for FILE in ~/myfolder/*; do
    if [ -f "$FILE" ]; then
        sed -i '2,$d' "$FILE"
    fi
done