#!/bin/bash
LOC_FILE="Resources/Localizable.strings"
API_KEY="sQ-JAEmqJ6FmaZeNtmwrK-VJTEaeRTDL"
curl -o $LOC_FILE "https://localise.biz/api/export/locale/en.strings?key=$API_KEY"
