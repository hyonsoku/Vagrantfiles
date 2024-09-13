#!/bin/bash

vagrant halt
vagrant snapshot save $(date +%Y%m%d)
vagrant package --base default --output my-kali.box

# Add Vagrant Box file
base_version =$(date +%Y%m)
existing_versions=$(vagrant box list | grep "my-kali" | awk -F' ' '{print $2}' | grep "^${base_version}\.")
version_number=0

# 既存のバージョンがある場合、末尾の数字を繰り上げる
if [ ! -z "$existing_versions" ]; then
    for version in $existing_versions; do
        # バージョン番号を抽出
        current_version_number=$(echo $version | awk -F'.' '{print $2}')
        if [ $current_version_number -gt $version_number ]; then
            version_number=$current_version_number
        fi
    done
    # バージョン番号を1増やす
    version_number=$((version_number + 1))
fi

# 新しいバージョンを追加
vagrant box add my-kali.box --box-version ${base_version}.${version_number}