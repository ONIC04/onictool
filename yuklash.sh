#!/bin/bash

# Ekranni tozalash va chiroyli sarlavha chiqarish
clear
echo "======================================================="
echo "       ONICTOOL'ni GitHub'ga yuklash dasturi           "
echo "======================================================="
echo ""

# 1-QADAM: Barcha yangi va o'zgargan fayllarni git'ga qo'shish
echo "[+] Fayllar yig'ilmoqda (git add .)..."
git add .

# 2-QADAM: O'zgarishlarni muhrlash (commit qilish)
echo "[+] O'zgarishlar saqlanmoqda (git commit)..."
# Agar fayllar o'zgarmagan bo'lsa xato qizil bo'lib chiqmasligi uchun shunday yozamiz:
git commit -m "ONICTOOL yangilandi" || echo "Fayllarda yangi o'zgarish yo'q, davom etamiz..."

# 3-QADAM: GitHub'ga uchirish
echo ""
echo "[+] Fayllar GitHub'ga yuborilmoqda (git push)..."
echo "DIQQAT: Parol so'ralganda GitHub loginingiz parolini EMAS,"
echo "maxsus TOKEN (Personal Access Token) kiriting!"
echo ""

# Push buyrug'ini ishga tushiramiz
git push -u origin main

# 4-QADAM: Natijani tekshirish (Skript o'zi xatoni aniqlaydi)
# $? degani "oldingi buyruq muvaffaqiyatli ishladimi?" degani. 0 bo'lsa - a'lo!
if [ $? -eq 0 ]; then
    echo ""
    echo "======================================================="
    echo "✅ BAJARILDI! Skriptingiz GitHub-ga muvaffaqiyatli joylandi."
    echo "======================================================="
else
    echo ""
    echo "======================================================="
    echo "❌ XATOLIK! GitHub-ga yuklash amalga oshmadi."
    echo "Sabab: Username yoki Token xato kiritildi!"
    echo "======================================================="
fi
