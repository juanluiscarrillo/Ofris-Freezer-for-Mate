#!/bin/bash

# =============================================
#  Dafturn Ofris Erdana - Locking your System
#  Modified to work with Ubuntu Mate 18.04
# =============================================
# Version       : 1.1 -> Based on ofris.sh Version 1.9.05-en
# Modified vy   : Juan Luis Carrillo Arroyo
# Created by    : Muhammad Faruq Nuruddinsyah (faruq@dafturn.org)
# E-Mail        : jlcarrilloarroyo@gmail.com
# Created date  : October, 15th 2020
# =============================================
# An Open Source from Spain
# =============================================

# =============================================
# Modified by:   Kelompok 4 OSSDev Fasilkom UI
# Modified date: May, 27th 2015
#
# Added features:
#  - Password protection
#  - Set or clear Ofris password
# =============================================

#----- Starting ----
echo 
echo "==================================================="
echo "    Dafturn Ofris Erdana - Locking your System"
echo "         By : Muhammad Faruq Nuruddinsyah"
echo "==================================================="
echo 


#----- Mendeklarasikan variabel -----
is_opt=false
is_success=true
ofris_n=6
ofris_tmp_co=1
is_cho=false
# default user
ofris_user="${HOME:$ofris_n}"


#----- Password protection by Kelompok 4 OSSDev -----
if [ -e .ofris-password ]; then
	ofris_password=$(<.ofris-password)
	echo -n "Type the password: "
	read -s password
	password=$(echo -n "$password" | md5sum | cut -c 1-32)
	
	if [ $password != $ofris_password ]; then
		echo 
		echo 
		echo "Wrong password!"
		echo 
		exit
	fi
	
	echo 
	echo 
fi

echo "Menu:"
echo "  1. Freeze for user $ofris_user"
echo "  2. Freeze for other user"
echo "  3. Unfreeze for use $ofris_user"
echo "  4. Unfreeze for other user"
echo "  5. View status for user $ofris_user"
echo "  6. View status for other users"
echo "  7. Show system users"
echo "  8. Set password"
echo "  9. Exit"
echo 
#-------------------


#------------------------------------


function read_user(){
    echo
    echo -n "Please, type user's name: "
    read ofris_user
    echo 
    echo

    if [ -d /home/$ofris_user ]; then
        echo
        echo "The selected user is: $ofris_user"
        echo
    else
        echo "Error: User not found: $ofris_user"
        echo "The app finish at this moment. Try it again."
        exit
    fi
}



#----- Awal script untuk menentukan pilihan -----
while [ $is_opt = false ]; do
	echo -n "Please type the menu number you want: "
	read ofris_opt

	if [[ $ofris_opt = 1 ]]; then
		is_opt=true
		ofris_tmp_co=1
	elif [[ $ofris_opt = 2 ]]; then
		is_opt=true
		read_user
	elif [[ $ofris_opt = 3 ]]; then
		is_opt=true
	elif [[ $ofris_opt = 4 ]]; then
    	is_opt=true
    	read_user
	elif [[ $ofris_opt = 5 ]]; then
		is_opt=true
	elif [[ $ofris_opt = 6 ]]; then
		is_opt=true
		read_user
	elif [[ $ofris_opt = 7 ]]; then
		is_opt=true
		echo
		echo "This are all users found in the system: "
		ls /home/
		echo
		exit
	elif [[ $ofris_opt = 8 ]]; then
	#----- Password protection by Kelompok 4 OSSDev -----
		is_opt=true
	elif [[ $ofris_opt = 9 ]]; then
		is_opt=true
		echo 
		exit
	else
		echo "Sorry, you choose wrong menu. Please try again..."
		echo
		is_opt=false
	fi
done


script_file="ofris"$ofris_user".sh"
desktop_file="ofris"$ofris_user".desktop"
autostart_file=/etc/xdg/autostart/$desktop_file

ofris_rst=0
if [ -e $autostart_file ]; then
    ofris_rst=1
fi

if ! [ -d /etc/.ofris/ ]; then
    sudo mkdir /etc/.ofris
fi

function freeze_user(){
#----- Mengunci sistem -----
	echo 
	echo "===== Freeze ====="
	echo 
    echo "Please wait..."

	if [ $ofris_rst = 1 ]; then 
		echo "Error : The User has been frozen."
		echo 
		is_success=false
	else
	    # To /etc/xdg/autostart/
        echo "#!/bin/bash" > $script_file
	    echo "" >> $script_file
	    echo "session_user=\$(whoami)" >> $script_file
	    echo "if [ \$session_user = $ofris_user ] ; then" >> $script_file
		echo "   rsync -a --delete /etc/.ofris/$ofris_user/ /home/$ofris_user/" >> $script_file
		echo "   dconf reset -f / " >> $script_file
        echo "   mate-panel --reset" >> $script_file
        echo "   dconf load / < /etc/.ofris/$ofris_user-dconf-full-backup" >> $script_file
        echo "fi" >> $script_file
        sudo mv $script_file /etc/.ofris/
        sudo chmod +x /etc/.ofris/$script_file

        echo "#!/usr/bin/env xdg-open" > $desktop_file
        echo "[Desktop Entry]" >> $desktop_file
        echo "Version=1.0" >> $desktop_file
        echo "Type=Application" >> $desktop_file
        echo "Terminal=false" >> $desktop_file
        echo "Icon=bash" >> $desktop_file
        echo "Exec=/bin/bash /etc/.ofris/$script_file" >> $desktop_file        
        echo "Name[es_ES]=ofristecno" >> $desktop_file
        echo "Name=ofristecno" >> $desktop_file  
        
        sudo mv $desktop_file /etc/xdg/autostart/
	fi

	if [ $is_success = true ]; then
        if [ -d /etc/.ofris/$ofris_user/ ]; then
            sudo rm -Rf /etc/.ofris/$ofris_user/
        fi        
        sudo mkdir /etc/.ofris/$ofris_user/
        
        sudo -u $ofris_user dconf dump / > ./dconf-full-backup
        sudo mv ./dconf-full-backup /etc/.ofris/$ofris_user-dconf-full-backup
		sudo rsync -a --delete /home/$ofris_user /etc/.ofris/
	fi
	
	if [ $is_success = true ]; then
		echo "The user   $ofris_user    was successfully frozen."
		echo 
	fi
}

function unfreeze_user(){
   #----- Membuka sistem -----
	echo 
	echo "===== Unfreeze ====="
	echo 
	echo "Please wait..."
#	sudo rm /etc/.ofris/$script_file
    sudo rm $autostart_file
	
	echo 
	echo "The user    $ofris_user    was successfully unfrozen..."
	echo 
}

function show_status(){
#----- Menampilkan status -----
	if [ $ofris_rst = 1 ]; then
		echo 
		echo "===== Status ====="
		echo " The user    $ofris_user    has been locked..."
		echo 
		if [ -e $autostart_file ]; then
		   echo "Exists $autostart_file"
		else
		   echo "Doesnt' exist $autostart_file"
		fi
		echo
	else
		echo 
		echo "===== Status ====="
		echo " The user    $ofris_user    has not locked yet..."
		echo 
	fi
}


if [[ $ofris_opt = '1' ]]; then
    freeze_user;
elif [ $ofris_opt = '2' ]; then
    freeze_user;
elif [ $ofris_opt = '3' ]; then
    unfreeze_user
elif [ $ofris_opt = '4' ]; then
    unfreeze_user
elif [ $ofris_opt = '5' ]; then
    show_status
elif [ $ofris_opt = '6' ]; then
    show_status
elif [ $ofris_opt = '7' ]; then
#----- Password protection by Kelompok 4 OSSDev -----
#----- Set or clear password -----
	echo 
	echo "===== Set Password ====="
	echo 
	echo -n "Type new password or just hit enter to clear the password: "
	
	read -s new_password
	echo -n "$new_password" > .ofris_tmp_pwd
	password_count=$(wc -m .ofris_tmp_pwd)
	rm .ofris_tmp_pwd
	password_count=${password_count:0:1}
	
	if [[ $password_count = 0 ]]; then
		if [ -e .ofris-password ]; then
			rm .ofris-password
		fi
		
		echo 
		echo 
		echo "Password successfully removed."
		echo 
	else
		hash_password=$(echo -n "$new_password" | md5sum | cut -c 1-32)
		echo -n "$hash_password" > .ofris-password
		
		echo 
		echo 
		echo "Password successfully changed."
		echo 
	fi
fi


#========== Selesai ===================================================================

