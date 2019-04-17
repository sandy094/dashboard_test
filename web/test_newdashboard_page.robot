*** Settings ***
Force Tags    Login
Suite Setup    SuiteSetup
Suite Teardown    SuiteTeardown
Resource    ../lib/resource.robot
Resource    ../keyword/keyword_common.robot
Resource    ../keyword/keyword_newdashboard.robot

*** Test Cases ***
Check login
    Login Page    ${VALID_USER}    ${VALID_PASSWORD}

Check sidebar link Dashboard navigation is correct
    # 關掉公告訊息提示
    # Wait Until Page Contains Element    //div[@class='container bg-white boss-know-panel']//button[1]
    # Click Element  //div[@class='container bg-white boss-know-panel']//button[1]
    Sleep    10s
    # Click Element  //div[@class='modal-content']//div/i
    # 關掉日結計算視窗
    # Click Element  //div[@class='loader-panel load-xs-go p-2']/i
    Check Topbar Link    综合看板
    No Operation

Check Search For Basic
    [Teardown]    Run Keyword If Test Failed    Capture Page Screenshot
    Set Browser Implicit Wait    10s  
    Sleep  10s

    @{days}  Set Variable  上月  昨日  本周  上周  本月  
    :FOR  ${day}  IN  @{days}
    \  Sleep  5s
    \  Click Element  //a[@class='active-bright']
    \  Quick Search botton    ${day}
    \  Verify Basic Table Is Active
    \  Verify Basic Information Table Is Active
    \  Verify SiteRank Value For Basic
    \  Click Element  //div[@class="header-link-bar text-center"]/a[contains(.,'游戏 ')]
    \  Capture Page Screenshot
    \  Reload Page

    @{seasons}  Set Variable  本年  去年  本季  上季
    :FOR  ${season}  IN  @{seasons}
    \  Sleep  5s
    \  Click Element  //a[@class='active-bright']
    \  Quick Search In year and season    ${season}
    \  Verify Basic Table For Years
    \  Verify Basic Information Table For Years
    \  Verify SiteRank Value For Basic  
    \  Reload Page

Check Save Search
    [Teardown]  Run Keyword If Any Tests Failed    Capture Page Screenshot
    Reload Page
    Sleep    10s
    @{days}  Set Variable  昨日  本周  上周  本月  上月  
    :FOR  ${day}  IN  @{days}
    \  Sleep  5s
    \  Quick Search botton  ${day}
    \  Verify Save Page Is Active

    @{seasons}  Set Variable  本年  去年  本季  上季
    :FOR  ${season}  IN  @{seasons}
    \  Sleep  5s
    \  Click Element  //a[@class='active-bright']
    \  Quick Search In year and season    ${season}
    \  Verify Save Page Is Active

Search In Datetime For Basic
    Reload Page
    Set Browser Implicit Wait    10s
    @{mounths}    Set Variable    0: 2019年4月  1: 2019年3月  2: 2019年2月  3: 2019年1月  4: 2018年12月
    :FOR    ${month}  IN  @{mounths}
    \  Sleep  10s
    \  Click Element  //a[@class='active-bright']
    \  Click Element  //div[@class="header-link-bar text-center"]/a[contains(.,' 逐日 ')]
    \  Search In Month    ${month}
    \  Verify Basic Table Is Active
    \  Verify SiteRank Value For Basic  
    \  Reload Page

Search In Datetime For Save
    # 存提
    Reload Page
    Set Browser Implicit Wait    10s
    # Click Element  //div[@class="header-link-bar text-center"]/a[contains(.,' 逐日 ')]
    @{mounths}    Set Variable    0: 2019年4月  1: 2019年3月  2: 2019年2月  3: 2019年1月  4: 2018年12月
    :FOR    ${month}  IN  @{mounths}
    \  Sleep  10s
    \  Wait Until Page Contains Element  //a[@class='active-bright']
    \  Click Element  //a[@class='active-bright']
    \  Click Element  //div[@class="header-link-bar text-center"]/a[contains(.,' 逐日 ')]
    \  Search In Month    ${month}
    \  Verify Save Page Is Active

Check Chart is active
    # 只檢查昨日的圖表
    Reload Page
    Sleep    15s
    Wait Until Page Contains Element  //a[@class='active-bright']
    Click Element  //a[@class='active-bright']
    Click Element  //div[@class="header-link-bar text-center"]/a[contains(.,'游戏 ')]
    Chart Transform
    Capture Page Screenshot
    Check Chart In Game Classification    种类
    Check Chart In Game Station    娱乐城
    Reload Page

Short
    Reload Page
    Sleep  10s
    Click Element  //a[@class='active-bright']
    Click Element  //div[@class="header-link-bar text-center"]/a[contains(.,'站台 ')]
    Wait Until Page Contains Element  //div[@class="kanban-title"]/div/a/a
    Click Element  //div[@class="kanban-title"]/div/a/a
    @{number}  Set variable  4  5  6  7  3
    :FOR  ${num}  IN  @{number}
    \  Click Element  //ng2-smart-table[@id="siteRank"]/table/thead/tr[1]/th[${num}]//span
    \  Sleep  5s
    \  ${ValueA}=  Get Text  //ng2-smart-table[@id="siteRank"]/table/tbody/tr[1]/td[${num}]
    \  ${ValueB}=  Get Text  //ng2-smart-table[@id="siteRank"]/table/tbody/tr[2]/td[${num}]
    \  ${ValueA}=    Remove String    ${ValueA}    ,
    \  ${ValueB}=    Remove String    ${ValueB}    ,
    \  Convert To Integer    ${ValueA}
    \  Convert To Integer    ${ValueB}
    Should Be True  ${ValueA}>=${ValueB}
    Capture Page Screenshot

Advanced Search-category
    # 進階搜尋-種類
    Reload Page
    Sleep  10s
    ${CheckValueA}=  Get Text  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[1]/td[3]
    @{cates}  Set variable    棋牌     彩票    视讯   体育    机率 
    :FOR  ${cate}  IN  @{cates}
    \  Sleep    5s
    \  Wait Until Page Contains Element  //div[@class='mt-2 mb-2']/button[contains(.,'${cate}')]
    \  Click Element  //div[@class='mt-2 mb-2']/button[contains(.,'${cate}')]
    \  Click Element  //div[@class='mt-2 text-right']/button
    \  Page Should Contain Element  //div[@class='kanban-title']/div[contains(.,'${cate}')]
    \  Sleep  3s
    \  Wait Until Page Contains Element  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[1]/td[2]  10s
    \  Wait Until Page Contains Element  //div[@class='kanban-title']/div[@class="eveday_bgcolor"][contains(.,'${cate}')]
    \  ${CheckValueB}=  Get Text  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[1]/td[3]
    \  Should Not Match  ${CheckValueA}  ${CheckValueB}
    \  Reload Page

Advanced Search-station
    # 進階搜尋-娛樂城
    Wait Until Page Contains Element  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[1]/td[2]  10s
    ${CheckValueA}=  Get Text  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[1]/td[2]
    @{cates}  Set variable   AG   BB   FG   
    :FOR  ${cate}  IN  @{cates}
    \  Sleep    10s
    \  Wait Until Page Contains Element  //div[@class='fast-city-select-panel']/button[contains(.,'${cate}')]
    \  Click Element  //div[@class='fast-city-select-panel']/button[contains(.,'${cate}')]
    \  Click Element  //div[@class='mt-2 text-right']/button
    \  Page Should Contain Element  //div[@class='kanban-title']/div[contains(.,'${cate}')]
    \  Sleep  3s
    \  ${CheckValueB}=  Get Text  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[1]/td[2]
    \  Should Not Match  ${CheckValueA}  ${CheckValueB}
    \  Reload Page

Value Verificarion For Basic 
    Reload Page
    Sleep    5s
    Click Element  //a[@class='active-bright']
    Wait Until Page Contains Element  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[2]/td[3]
    # 損益
    ${PayoffValueA}=  Get Text  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[2]/td[3]//div[@class='text-right cell-nowrap']/span[1]
    ${PayoffValueB}=  Get Text  //div[@class='allData-item'][contains(.,'损益')]/div[2]
    Should Match  ${PayoffValueA}  ${PayoffValueB}
    # 有效投注
    ${BettingValueA}=  Get Text  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[2]/td[4]//div[@class='text-right cell-nowrap']/span[1]
    ${BettingValueB}=  Get Text  //div[@class='allData-item'][contains(.,'有效投注')]/div[2]
    Should Match  ${BettingValueA}  ${BettingValueB} 
    # 營收比
    ${BiteValueA}=  Get Text  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[2]/td[5]//div[@class='text-right cell-nowrap']/span[1]
    ${BiteValueB}=  Get Text  //div[@class='allData-item'][contains(.,'营收比')]/div[2]
    Should Match  ${BiteValueA}  ${BiteValueB} 
    # 投注單量
    ${WagersValueA}=  Get Text  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[2]/td[6]//div[@class='text-right cell-nowrap']/span[1]
    ${WagersValueB}=  Get Text  //div[@class='allData-item'][contains(.,'投注单量')]/div[2]
    Should Match  ${WagersValueA}  ${WagersValueB}

Value Verificarion For Save
    Execute JavaScript  window.document.documentElement.scrollTop = 0;
    Click Element  //div[@class="header-link-bar text-center"]/a[contains(.,' 逐日 ')]
    Click Element  //div[@class="header-link-bar text-center"]/a[contains(.,'存提 ')]
    Sleep  5s
    Wait Until Page Contains Element  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[1]/td[3]
    # 首存總額
    ${firstValueA}=  Get Text  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[2]/td[2]//div[@class='text-right cell-nowrap']/span[1]
    ${firstValueB}=  Get Text  //div[@class='allData-item'][contains(.,'首存总额')]/div[2]
    Should Match  ${firstValueA}  ${firstValueB}
    # 存款總額 
    ${saveValueA}=  Get Text   //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[2]/td[3]//div[@class='text-right cell-nowrap']/span[1]
    ${saveValueB}=  Get Text   //div[@class='allData-item'][contains(.,'存款总额')]/div[2]
    Should Match  ${saveValueA}  ${saveValueB}
    # 取款總額
    ${withdrawValueA}=  Get Text  //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[2]/td[4]//div[@class='text-right cell-nowrap']/span[1]
    ${withdrawValueB}=  Get Text  //div[@class='allData-item'][contains(.,'取款总额')]/div[2]
    Should Match  ${WithdrawValueA}  ${WithdrawValueB}  
    # 存提差額
    ${differenceValueA}=  Get Text   //div[@class='kanban-everyDay-panel mt-2 mb-3']//table/tbody/tr[2]/td[5]//div[@class='text-right cell-nowrap']/span[1]
    ${differenceValueB}=  Get Text   //div[@class='allData-item'][contains(.,'存提差额')]/div[2]
    Should Match  ${differenceValueA}  ${differenceValueB}
    


*** Keywords ***
SuiteSetup
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Login Page    ${VALID_USER}    ${VALID_PASSWORD}
    
SuiteTeardown
    Run Keyword If Any Tests Failed    Capture Page Screenshot
    Close Browser
