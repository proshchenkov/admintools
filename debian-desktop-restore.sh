#!/bin/sh

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

tool_not_found=0

function msg() {
	echo -e ${Blue}::${Color_Off} $*
}

function pstatus() {
	status=$?
	echo -n "... "
	if [ $status -eq 0 ]
	then
		echo -e ${Green}OK${Color_Off}
	else
		echo -e ${Red}Failed!${Color_Off}
		exit 1
	fi
}

function cmd_check() {
        if command -v $1 > /dev/null; then echo -en ${Green}; else echo -en ${Red}; tool_not_found=1; fi
	echo -en "${1}${Color_Off} "
}

msg "Checking if all the necessary tools are installed..."
echo -ne '\t'
for t in fdisk mkswap zcat partclone.ext4 resize2fs fsck.ext4 mount grub-install umount; do cmd_check $t; done
echo

if [ $tool_not_found -eq 1 ]; then echo Some tools were not found. Install them and rerun the script.; exit 1; fi

if [ $# -lt 1 ]; then echo -e ${Red}Error:${Color_Off} Device is not specified!; exit 1; fi

msg Creating a new partition table on $1...

(
echo o # Create a new empty DOS partition table

echo n      # Add a new partition
echo p      # Primary partition
echo 1      # Partition number
echo 2048   # First sector 
echo '+2G'  # Size

echo t  # Type
echo 82 # Swap

echo n  # New partition
echo p  # Primary
echo 2  # Number
echo    # First sector (default)
echo    # Last sector (default, all free space available)

# echo p
echo w  # Write changes
) | fdisk -W always $1

pstatus
msg Creating swap on ${1}1...

mkswap -U c6376b07-d328-4137-a617-7d8949727ea0 ${1}1
pstatus

msg Restoring the root partition on ${1}2...
zcat debian-desktop-lcme.ext4.gz | partclone.ext4 -s - -o ${1}2 -r
pstatus

msg Resizing the root partition to its full size...
resize2fs ${1}2
pstatus

msg Running fsck on the root partition...
fsck.ext4 -f -y ${1}2
pstatus

msg Mounting the root partition...
tmp_mp=$(mktemp -d)
mount -o rw ${1}2 ${tmp_mp}
pstatus

msg Installing GRUB2 on $1...
grub-install --target=i386-pc --boot-directory=${tmp_mp}/boot $1
pstatus

msg Unmounting the root partition...
umount ${tmp_mp}
pstatus
