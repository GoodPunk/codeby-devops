#!/bin/bash

# folder and file
TARGET_DIR="$HOME/myfolder"
FILE2="$TARGET_DIR/file2.txt"

# sum files
count_files() {
    if [ ! -d "$TARGET_DIR" ]; then
        echo "Папка $TARGET_DIR не существует."
        return 1
    fi

    FILE_COUNT=$(find "$TARGET_DIR" -type f | wc -l)
    echo "В папке $TARGET_DIR находится $FILE_COUNT файлов."
    return 0
}

# change chmod file2
fix_file_permissions() {
    if [ -f "$FILE2" ]; then
        chmod 664 "$FILE2" || {
            echo "Не удалось изменить права $FILE2."
            return 1
        }
        echo "Права $FILE2 изменены на 664."
    else
        echo "Файл $FILE2 не найден."
    fi
    return 0
}

# find empty files and delete
remove_empty_files() {
    EMPTY_FILES=$(find "$TARGET_DIR" -type f -empty)
    if [ -n "$EMPTY_FILES" ]; then
        echo "$EMPTY_FILES" | xargs rm -f || {
            echo "Не удалось удалить пустые файлы."
            return 1
        }
        echo "Пустые файлы удалены."
    else
        echo "Пустые файлы не найдены."
    fi
    return 0
}

# delete line,except first line
trim_files_to_first_line() {
    for FILE in "$TARGET_DIR"/*; do
        if [ -f "$FILE" ]; then
            sed -i '2,$d' "$FILE" || {
                echo "Не удалось удалить строки в $FILE."
                return 1
            }
            echo "Все строки кроме первой удалены."
        fi
    done
    return 0
}

# main
main() {
    count_files || exit 1
    fix_file_permissions || exit 1
    remove_empty_files || exit 1
    trim_files_to_first_line || exit 1
    echo "Complited!"
}

main