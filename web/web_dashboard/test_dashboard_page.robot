*** Settings ***
Force Tags    Login
Suite Setup    SuiteSetup
Suite Teardown    SuiteTeardown
Resource    ../../lib/resource.robot
Resource    ../../keyword/keyword_common.robot
Resource    ../../keyword/keyword_dashboard.robot

*** Test Cases ***
Check login
    Login Page    ${VALID_USER}    ${VALID_PASSWORD}
   
Check sidebar link Dashboard navigation is correct
    Close Announcement
    Set Browser Implicit Wait    20s
    Click Sidebar Link    运营看板
    Sleep  2s

Click Search
    Set Browser Implicit Wait    10s
    
    Quick Search botton    昨日
    Check Chart In Four card
    Execute JavaScript  window.document.documentElement.scrollTo = 0;
    Count In Seven Days For yesterday

    Quick Search botton    本周
    Check Chart In Four card
    Execute JavaScript  window.document.documentElement.scrollTo = 0;
    Count In A Day For week

    Quick Search botton    上周
    Check Chart In Four card
    Execute JavaScript  window.document.documentElement.scrollTo = 0;
    Count In A Day For week
    
Click Search In Year
    @{seasons}  Set Variable  本年  去年  本季  上季
    :FOR  ${season}  IN  @{seasons}
    \  Quick Search In year and season    ${season}
    \  Check Chart In Four card
    \  Count In A Day For months

    @{years}  Set Variable  本月  上月
    :FOR  ${year}  IN  @{years}
    \  Quick Search botton    ${year}
    \  Check Chart In Four card
    \  Count In A Day For months

Check Trend Is Active
    Reload Page
    Sleep    10s
    Execute JavaScript  window.document.documentElement.scrollTo = 0;
    # 排行裡單一站台的趨勢圖(昨日的4張卡片)
    Wait Until Element Is Visible   //div[@class="baDateform btn-group hidden_991"]/a[contains(.,'昨日')]  
    Click Link    //div[@class="baDateform btn-group hidden_991"]/a[contains(.,'昨日')] 

    Sleep  20s
    Wait Until Page Contains Element   //ba-card[@class="dashboss_chart payoffSums"]//div/a[contains(.,'排行')]
    Sleep  5s
    Click Element  //ba-card[@class="dashboss_chart payoffSums"]//div/a[contains(.,'排行')]

    @{rows}  Set Variable  2  3  4   
    :FOR  ${row}  IN  @{rows}
    \  Wait Until Page Contains Element    //ba-card[@class="dashboss_chart payoffSums"]//tbody/tr[${row}]/td[3]/div/small
    \  Click Element    //ba-card[@class="dashboss_chart payoffSums"]//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  5s
    \  Wait Until Page Contains Element    //div[@class='container bg-white']//canvas
    \  Mouse Over    //div[@class='container bg-white']//canvas
    \  Capture Page Screenshot

    \  Data Table Check Trend Of List
    \  Click Element    //div[@class='drop-select-panel']/div[2]
    \  Sleep    5s
    \  Click Element    //div[@class='drop-select-panel']/div[1]
    \  Wait Until Page Contains Element  //div[@class='drop-select-panel']/div[1]/ul/li[1]
    \  Click Element     //div[@class='drop-select-panel']/div[1]/ul/li[1]
    \  Sleep    5s
    # \  Data Table Check Time Of List
    
    
    # 切換遊戲頁籤，測試帳號(sandy1234)沒辦法用
    \  Click Element  //div[@id='chart']/div/div/a[2]
    \  Sleep  10s
    \  Wait Until Page Contains Element  //table[@class='table-striped type-table']//tbody/tr[1]/td[2]
    \  ${testValue}=  Get Text  //table[@class='table-striped type-table']//tbody/tr[1]/td[2]
    \  Should Not Be Empty  ${testValue}
    \  Data Table Check Game Of List

    \  Click Element  //div[@class="container bg-white"]/div/i
    \  Sleep  3s

    # 有效投注
    Click Element  //ba-card[@class="dashboss_chart commissionableSums"]//div/a[contains(.,'排行')]
    @{rows}  Set Variable  2  3  4    
    :FOR  ${row}  IN  @{rows}
    \  Click Element  //ba-card[@class="dashboss_chart commissionableSums"]//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  5s
    \  Wait Until Page Contains Element    //div[@class='container bg-white']//canvas
    \  Mouse Over    //div[@class='container bg-white']//canvas
    \  Capture Page Screenshot

    \  Data Table Check Trend Of List
    \  Click Element    //div[@class='drop-select-panel']/div
    # \  Data Table Check Time Of List
    

    # 切換遊戲頁籤，測試帳號(sandy1234)沒辦法用
    \  Click Element  //div[@id='chart']/div/div/a[2]
    \  Sleep  10s
    \  Wait Until Page Contains Element  //table[@class='table-striped type-table']//tbody/tr[1]/td[2]
    \  ${testValue}=  Get Text  //table[@class='table-striped type-table']//tbody/tr[1]/td[2]
    \  Should Not Be Empty  ${testValue}
    \  Data Table Check Game Of List

    \  Click Element  //div[@class="container bg-white"]/div/i
    \  Sleep  3s

    # 投注單量
    Click Element  //ba-card[@class="dashboss_chart wagersCounts"]//div/a[contains(.,'排行')]
    @{rows}  Set Variable  2  3  4   
    :FOR  ${row}  IN  @{rows}
    \  Click Element  //ba-card[@class="dashboss_chart wagersCounts"]//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  5s
    \  Wait Until Page Contains Element  //div[@class='container bg-white']//canvas
    \  Mouse Over  //div[@class='container bg-white']//canvas
    \  Capture Page Screenshot

    \  Data Table Check Trend Of List
    \  Click Element    //div[@class='drop-select-panel']/div
   

    # 切換遊戲頁籤，測試帳號(sandy1234)沒辦法用
    \  Click Element  //div[@id='chart']/div/div/a[2]
    \  Sleep  10s
    \  Wait Until Page Contains Element  //table[@class='table-striped type-table']//tbody/tr[1]/td[2]
    \  ${testValue}=  Get Text  //table[@class='table-striped type-table']//tbody/tr[1]/td[2]
    \  Should Not Be Empty  ${testValue}
    \  Data Table Check Game Of List

    \  Click Element  //div[@class="container bg-white"]/div/i
    \  Sleep  3s

    # 活耀會員
    Click Element  //ba-card[@class="dashboss_chart memberSums"]//div/a[contains(.,'排行')]
    @{rows}  Set Variable  2  3  4    
    :FOR  ${row}  IN  @{rows}
    \  Click Element  //ba-card[@class="dashboss_chart memberSums"]//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  5s
    \  Wait Until Page Contains Element  //div[@class='container bg-white']//canvas
    \  Mouse Over  //div[@class='container bg-white']//canvas
    \  Capture Page Screenshot

    \  Data Table Check Trend Of List
    \  Click Element    //div[@class="container bg-white"]/div/i
    

    # # 切換遊戲頁籤，活耀會員沒有權限
    # \  Click Element  //div[@id='chart']/div/div/a[2]
    # \  Sleep  10s
    # \  Wait Until Page Contains Element  //table[@class='table-striped type-table']//tbody/tr[1]/td[2]
    # \  ${testValue}=  Get Text  //table[@class='table-striped type-table']//tbody/tr[1]/td[2]
    # \  Should Not Be Empty  ${testValue}
    # \  Data Table Check Game Of List

    # \  Click Element  //div[@class="container bg-white"]/div/i
    # \  Sleep  3s

Search In Datetime 
    Reload Page
    Sleep    10s
    @{mounths}    Set Variable    0: 2019年8月  1: 2019年7月  2: 2019年6月  3: 2019年5月
    :FOR    ${month}  IN  @{mounths}
    \  Search In Month    ${month}
    
Check All Chart Is Active
    Reload Page
    Sleep    20s
    Execute JavaScript    window.scrollTo(200, document.body.scrollHeight)
    Check Chart In Game Classification    种类
    Check Chart In Game Station    娱乐城

Check Single Chart
    # 細項點掉單一圖表
    Sleep    20s
    Click Element    //div[@class='row hidden_991']/div/div/div/button[contains(.,'种类')]
    Execute JavaScript    window.scrollTo(200, document.body.scrollHeight)
    Sleep    10s
    Wait Until Page Contains Element  //table[@class='table dataTable']/tbody/tr[1]/td[1]
    Click element  //table[@class='table dataTable']/tbody/tr[1]/td[1]
    Sleep    20s
    Wait Until Page Contains Element  //table[@class='table table-hover']/tbody/tr[1]/td[1]/div
    Click Element  //table[@class='table table-hover']/tbody/tr[1]/td[1]/div
    Sleep  10s
    Capture Page Screenshot
    
    # 以日合計
    Click Element  //div[@class="text-left mt-4"]//div/div/button
    Wait Until Page Contains Element  //div[@class="text-left mt-4"]//div/div/ul/li/a[contains(.,'以时合计')]
    Click Element  //div[@class="text-left mt-4"]//div/div/ul/li/a[contains(.,'以日合计')]
    Sleep  5s
    Capture Page Screenshot

# 暫時隱藏
# Search In Trend
#     Reload Page
#     Execute JavaScript  window.document.documentElement.scrollTop = 0;
#     Sleep    10s
#     Click Element    //ba-card[@class='dashboss_chart payoffSums']//button[@id='sortMenu']
#     Click Element    //ba-card[@class='dashboss_chart payoffSums']//li/a[contains(.,'趋势统计')]
#     Sleep  10s
#     Wait Until Page Contains Element    //div[@class="col-12 mt-2 pb-4 itrend-chart text-center"]//div/canvas
#     Mouse Over  //div[@class="col-12 mt-2 pb-4 itrend-chart text-center"]//div/canvas
#     Capture Page Screenshot
#     Click Element  //button[@class="borderr_1px"][contains(.,'以时合计')]
#     Sleep  15s
#     Wait Until Page Contains Element    //div[@class="col-12 mt-2 pb-4 itrend-chart text-center"]//div/canvas
#     Mouse Over  //div[@class="col-12 mt-2 pb-4 itrend-chart text-center"]//div/canvas
#     Capture Page Screenshot

*** Keywords ***
SuiteSetup
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    # Login Page    ${VALID_USER}    ${VALID_PASSWORD}
    
SuiteTeardown
    Run Keyword If Any Tests Failed    Capture Page Screenshot 
    Close Browser
