#!/bin/bash

date=$(date +%Y%m%d)

vagrant halt
vagrant snapshot save ${date}
vagrant package --output default my-kali_${date}.box