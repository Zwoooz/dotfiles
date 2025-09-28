#!/bin/bash

wine "/mnt/windows/Program Files (x86)/TradeSkillMaster Application/app/TSMApplication.exe" &

sleep 3

wine taskkill /IM explorer.exe /F
