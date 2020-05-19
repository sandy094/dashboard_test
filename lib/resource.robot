*** Settings ***
Library    Selenium2Library
Library    OperatingSystem
Library    String



*** Variables ***
${SERVER}    ppap-qa.pmzoe.com/login
${BROWSER}    Chrome
${DELAY}    0
${VALID_USER}    brdemos    
${VALID_PASSWORD}    a111116
${LOGIN URL}    https://${SERVER}/
${WELCOME URL}    https://${SERVER}/welcome.html
${ERROR URL}    https://${SERVER}/error.html





# aaqgg.com
# brdemos
# 111116
# TEST1234
# ppap.losade.info/login
# user1