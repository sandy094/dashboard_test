*** Settings ***
Force Tags    Login
Suite Setup    SuiteSetup
Suite Teardown    SuiteTeardown
Resource    ../../lib/resource.robot
Resource    ../../keyword/keyword_common.robot
Resource    ../../keyword/keyword_sitelist.robot

*** Test Cases ***
Check login
    Login Page    ${VALID_USER}    ${VALID_PASSWORD}
    
Check sidebar link Operational navigation is correct
    Close Announcement
    Sleep    10s
    Click Sidebar Link    运营看板
    Check Operational Information Link    站台列表

Click Search
    Sleep    10s
    @{days}  Set Variable   昨日  
    :FOR  ${day}  IN  @{days}
    \  Quick Search botton    ${day}
    \  Check Sitelist Values
    
# Check Trend 
#     # 趨勢
#     Wait Until Element Is Visible   //div[@class="baDateform btn-group hidden_991"]/a[contains(.,'昨日')]  
#     Click Link    //div[@class="baDateform btn-group hidden_991"]/a[contains(.,'昨日')] 
#     @{trs}  Set Variable  1  2  3  
#     :FOR  ${tr}  IN  @{trs}
#     \  trend  ${tr}

Check Table
    Reload Page
    Sleep    10s
    ${chickWallet}=  Run Keyword And Return Status   Page Should Contain Element   //div[@id="data-table"]//table/thead/tr[1]/th[contains(.,'錢包轉換次數')]
    Run Keyword If    '${chickWallet}'== True   Return Keyword
    @{number}  Set variable  3  4  5  6  7 
    :FOR  ${num}  IN  @{number}
    \  Set Browser Implicit Wait    10s
    \  Wait Until Page Contains Element  //div[@id="data-table"]//table/thead/tr[1]/th[${num}]//a
    \  Click Element  //div[@id="data-table"]//table/thead/tr[1]/th[${num}]//a
    




    # 判斷是否有更新頁面
    ${newValue}=  Get Text  //div[@id="data-table"]//table/tbody/tr[1]/td[3]
    ${matchRequest}=  Run Keyword And Return Status    Should Not Match  ${orignalValue}  ${newValue}
    Run Keyword If    '${matchRequest}'=='False'    Capture Page Screenshot    ELSE   No Operation
    
    # 檢查趨勢圖是否顯示正常
    trend  1


Check In Group
    Wait Until Page Contains Element  //a[@class='nor_tabs mt-0'][contains(.,'分群')]
    Click Element  //a[@class='nor_tabs mt-0'][contains(.,'分群')]
    Sleep    10s
    Wait Until Page Contains Element  //input[@placeholder='分群快搜...']
    Click Element  //input[@placeholder='分群快搜...']
    Input Text  //input[@placeholder='分群快搜...']   alpha
    ${Keywords}=  Get Text  //div[@id="data-table"]//tbody/tr[1]/td[2]//span[1]
    Should Match  ${Keywords}    Alpha*
    Capture Page Screenshot

    Click Element  //div[@id="data-table"]//table/tbody/tr[1]/td[2]//div[@class="text-right"]/span
    Wait Until Page Contains Element  //div[@id="data-table"]//table/tbody/tr[2]/td[3]
    ${searchValue}=  Get Text  //div[@id="data-table"]//table/tbody/tr[2]/td[3]
    Should Not Be Empty  ${searchValue}  
    Capture Page Screenshot

    trend  2


*** Keywords ***
SuiteSetup
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Login Page    ${VALID_USER}    ${VALID_PASSWORD}
    Set Browser Implicit Wait    10s
    
SuiteTeardown
    Run Keyword If Any Tests Failed    Capture Page Screenshot   
    Close Browser
