#!/bin/zsh
switch_version=$1
flutter_path=`which flutter`
flutter_home_path=${flutter_path%/bin/*}
flutter_saved_path=${flutter_path%/flutter/bin/*}

flutter_version_path=${flutter_home_path}/version
flutter_version=`cat $flutter_version_path`

echo "Current flutter version is $flutter_version"

echo "Current flutter path is $flutter_home_path"

echo "Current flutter saved path is $flutter_saved_path"

if [ $switch_version == $flutter_version ]
then
    echo "The current version is $switch_version there's nothing to do!"
    exit 0
else
    echo "Will swith flutter version to $switch_version"

    flutter_switch_path=${flutter_saved_path}/flutter_${switch_version//./_}
    flutter_backup_path=${flutter_saved_path}/flutter_${flutter_version//./_}

    echo "Backup current version $flutter_home_path to $flutter_backup_path"
    rm -rf $flutter_backup_path
    cp -rf $flutter_home_path $flutter_backup_path
    if [ -d $flutter_switch_path ]; then
        echo "Recover version $flutter_switch_path to $flutter_home_path"
        rm -rf $flutter_home_path
        cp -rf $flutter_switch_path $flutter_home_path
    else
        flutter version $switch_version
        flutter doctor
    fi
    echo "Flutter version is switch from $flutter_version to $switch_version"
fi





