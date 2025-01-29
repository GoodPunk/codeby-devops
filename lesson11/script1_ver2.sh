#!/bin/bash

# main folder
TARGET_DIR="$HOME/myfolder"   

# file name
FILE1="$TARGET_DIR/file1.txt"
FILE2="$TARGET_DIR/file2.txt"
FILE3="$TARGET_DIR/file3.txt"
FILE4="$TARGET_DIR/file4.txt"
FILE5="$TARGET_DIR/file5.txt"

# Create main folder
create_target_dir() {
    if [ ! -d "$TARGET_DIR" ]; then
        mkdir -p "$TARGET_DIR" || {
            echo "Не получилось создать папку $TARGET_DIR."
            return 1
        }
        echo "Папка $TARGET_DIR создана."
    else
        echo "Папка $TARGET_DIR уже существует."
    fi
}

# create files 
create_files() {
    # 1. file hello
    echo -e "Hello world!\n$(date)" > "$FILE1" || {
        echo "Не удалось создать $FILE1."
        return 1
    }
    echo "Файл $FILE1 создан."

    # 2. empty file 777
    touch "$FILE2" && chmod 777 "$FILE2" || {
        echo "Не удалось создать $FILE2."
        return 1
    }
    echo "Файл $FILE2 создан с правами 777."

    # 3. random symbol file
    RANDOM_STRING=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
    echo "$RANDOM_STRING" > "$FILE3" || {
        echo "Не удалось создать $FILE3."
        return 1
    }
    echo "Файл $FILE3 создан."

    # create empty files
    touch "$FILE4" "$FILE5" || {
        echo "Не удалось создать $FILE4 и $FILE5."
        return 1
    }
    echo "Файлы $FILE4 и $FILE5 созданы."
}

# main
main() {
    create_target_dir || exit 1
    create_files || exit 1
    echo "Complited!"
}

main