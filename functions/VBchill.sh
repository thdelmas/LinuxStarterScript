#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    VBchill.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thdelmas <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/27 10:26:04 by thdelmas          #+#    #+#              #
#    Updated: 2019/11/27 10:26:04 by thdelmas         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

VBchill() {
	USER='thdelmas'
	VM_NAME='auto_roger'
	VM_FOLDER="/sgoinfre/goinfre/Perso/$USER"
	if [ ! -d "$VM_FOLDER" ]; then
		mkdir -p "$VM_FOLDER" && chmod 755 "$VM_FOLDER"
		if [ "$?" -ne '0' ]; then
			return
		fi
	fi
	ISO_PATH="$VM_FOLDER/$VM_NAME.iso"
	if [ ! -e "$ISO_PATH" ] && [ -w "$VM_FOLDER" ]; then
		curl https://fai-project.org/fai-cd/faicd64-large_5.8.7.iso -o "$ISO_PATH"
		if [ ! -e "$ISO_PATH" ]; then
			if [ $? -eq '23' ]; then
				echo 'Bad permissions'
			fi
			echo "Iso not available"
			return
		fi
	fi
	VM_TYPE='Debian 64'
	VBoxManage createvm --name $VM_NAME --ostype "$VM_TYPE" --register
	VBoxManage modifyvm $VM_NAME --ioapic on
	VBoxManage modifyvm "$VM_NAME" --boot1 disk --boot2 dvd --boot3 none --boot4 none
	VM_RAM_SIZE="$((1 * 1024))"
	VBoxManage modifyvm "$VM_NAME" --memory "$VM_RAM_SIZE" --vram 128
	VM_INTERFACE='en0'
	VM_MAC="$(ifconfig "$VM_INTERFACE" | grep ether | cut -d' ' -f2 | sed 's/://g')"
	VBoxManage modifyvm "$VM_NAME" --nic1 bridged --bridgeadapter1 "$VM_INTERFACE" --macaddress1 "$VM_MAC"
	VM_SDA_OS_SIZE="$((8 * 1024))"
	VM_SDA_OS="${VMFOLDER:-/tmp}/$VM_NAME.vdi"

	VM_MASSSTORAGE_CONTROLLER_NAME="SATA Controller"
	VM_CONTROLLER_DVD_NAME="IDE Controller"
	VM_SDB_SIZE="$((1 * 1024))"

	#create hdd
	VBoxManage createhd --filename "$VM_SDA_OS" --size $VM_SDA_OS_SIZE --format VDI --variant fixed
	VBoxManage storagectl "$VM_NAME" --add sata --controller IntelAHCI --name "$VM_MASSSTORAGE_CONTROLLER_NAME"
	VBoxManage storageattach "$VM_NAME" --storagectl "$VM_MASSSTORAGE_CONTROLLER_NAME" --port 0 --device 0 --type hdd --medium "$VM_SDA_OS"

	#Boot
	VBoxManage storagectl "$VM_NAME" --add ide --controller PIIX3 --name "$VM_CONTROLLER_DVD_NAME"
	VBoxManage storageattach "$VM_NAME" --storagectl "$VM_CONTROLLER_DVD_NAME" --port 0 --device 0 --type dvddrive --medium $ISO_PATH
	#launching OS INSTALL
	VboxManage startvm "$VM_NAME"
}
