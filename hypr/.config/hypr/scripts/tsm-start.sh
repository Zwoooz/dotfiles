#!/bin/bash

wine "/home/zwoooz/Applications/TradeSkillMaster Application/app/TSMApplication.exe" &

sleep 3

wine taskkill /IM explorer.exe /F
