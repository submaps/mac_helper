set -euo pipefail
IFS=$'\n\t'

hdfs_disk_id=$(diskutil list | grep Windows_NTFS | tr " " "\n" | tail -1)
echo "found hdfs disk: $hdfs_disk_id"
if [[ $hdfs_disk_id == disk* ]];then
	echo "mounting..."
	sudo umount "/dev/$hdfs_disk_id"
	sudo mkdir "/Volumes/$hdfs_disk_id"
	sudo /usr/local/bin/ntfs-3g "/dev/$hdfs_disk_id" "/Volumes/$hdfs_disk_id/" -olocal -oallow_other -o auto_xattr
	echo "mounted at"
	echo "/Volumes/$hdfs_disk_id/"
else
	echo "not found drive"
fi
