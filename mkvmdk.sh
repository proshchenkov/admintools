#/bin/sh

echo Removing old files...

rm *.vmdk

echo Creating VMDKs for existing disks:

for d in $(find /dev/disk/by-id -type l -printf "%f\n")
do
	echo -n "    :: $d ... "
	VBoxManage internalcommands createrawvmdk -filename "$d.vmdk" -rawdisk /dev/disk/by-id/$d > /dev/null && echo "OK" || echo "Fail"
done
