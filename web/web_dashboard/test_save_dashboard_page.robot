*** Settings ***
Force Tags    Login
Suite Setup    SuiteSetup
Suite Teardown    SuiteTeardown
Resource    ../../lib/resource.robot
Resource    ../../keyword/keyword_common.robot
Resource    ../../keyword/keyword_save_dashboard.robot

*** Test Cases ***
Check login
    Login Page    ${VALID_USER}    ${VALID_PASSWORD}

Check sidebar link Dashboard navigation is correct
    # 關掉公告訊息提示
    # Wait Until Page Contains Element    //div[@class='container bg-white boss-know-panel']//button[1]
    # Click Element  //div[@class='container bg-white boss-know-panel']//button[1]
    Sleep    10s
    Click Sidebar Link    运营看板
    Sleep    10s
    Click Element    //div[@class='card-body']/div/div/a[contains(.,'运营看板')]
    Wait Until Page Contains Element  //div[@class='card-body']/div/div/a/div
    Click Element  //div[@class='card-body']/div/div/a/div
   
Click Search
    Set Browser Implicit Wait    10s

    Quick Search botton    昨日
    Check Chart In Four card
    Count In Seven Days For yesterday

    Quick Search botton    本周
    Check Chart In Four card
    Count In A Day For week

    Quick Search botton    上周
    Check Chart In Four card
    Count In A Day For week
    
    @{years}  Set Variable  本月  上月
    :FOR  ${year}  IN  @{years}
    \  Quick Search botton    ${year}
    \  Check Chart In Four card
    \  Count In A Day For months

    @{seasons}  Set Variable  本年  本季  上季
    :FOR  ${season}  IN  @{seasons}
    \  Quick Search In year and season    ${season}
    \  Check Chart In Four card
    \  Count In A Day For months

Check Trend
    # Click Element  //div[@class='modal-content']//div/i
    # 排行裡單一站台的趨勢圖(本周的4張卡片)
    Quick Search botton    本周
    Sleep    10s
    Wait Until Element Is Visible    //ba-card[@id='differenceAmountContent']//div/a[contains(.,'排行')]
    Click Element    //ba-card[@id='differenceAmountContent']//div/a[contains(.,'排行')]
    Capture Page Screenshot

    @{rows}  Set Variable  2  3  4  
    :FOR  ${row}  IN  @{rows}
    \  Wait Until Page Contains Element  //ba-card[@id='differenceAmountContent']//tbody/tr[${row}]/td[3]/div/small
    \  Click Element  //ba-card[@id='differenceAmountContent']//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  2s
    \  Wait Until Page Contains Element  //div[@class='container bg-white test']//canvas
    \  Mouse Over  //div[@class='container bg-white test']//canvas
    \  Capture Page Screenshot
    \  Data Table Check Trend Of List
    \  Click Element  //div[@class="container bg-white test"]/div/i

    Click Element  //ba-card[@id='withdrawAmountContent']//div/a[contains(.,'排行')]
    @{rows}  Set Variable  2  3  4  
    :FOR  ${row}  IN  @{rows}
    \  Click Element  //ba-card[@id='withdrawAmountContent']//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  2s
    \  Wait Until Page Contains Element  //div[@class='container bg-white test']//canvas
    \  Mouse Over  //div[@class='container bg-white test']//canvas
    \  Capture Page Screenshot
    \  Data Table Check Trend Of List
    \  Click Element  //div[@class="container bg-white test"]/div/i

    Click Element  //ba-card[@id='depositAmountContent']//div/a[contains(.,'排行')]
    @{rows}  Set Variable  2  3  4 
    :FOR  ${row}  IN  @{rows}
    \  Click Element  //ba-card[@id='depositAmountContent']//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  2s
    \  Wait Until Page Contains Element  //div[@class='container bg-white test']//canvas
    \  Mouse Over  //div[@class='container bg-white test']//canvas
    \  Capture Page Screenshot
    \  Data Table Check Trend Of List
    \  Click Element  //div[@class="container bg-white test"]/div/i

    Click Element  //ba-card[@id='firstDepositAmountContent']//div/a[contains(.,'排行')]
    @{rows}  Set Variable  2  3  4  
    :FOR  ${row}  IN  @{rows}
    \  Click Element  //ba-card[@id='firstDepositAmountContent']//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  2s
    \  Wait Until Page Contains Element  //div[@class='container bg-white test']//canvas
    \  Mouse Over  //div[@class='container bg-white test']//canvas
    \  Capture Page Screenshot
    \  Click Element  //div[@class="container bg-white test"]/div/i

Search In Datetime 
    Sleep    10s
    @{mounths}    Set Variable    0: 2019年3月  1: 2019年2月  2: 2019年1月  3: 2018年12月  4: 2018年11月  5: 2018年10月  6: 2018年9月  7: 2018年8月  
    :FOR    ${month}  IN  @{mounths}
    \  Search In Month    ${month}

Check Chart  
    Wait Until Element Is Visible   //div[@class="baDateform btn-group hidden_991"]/a[contains(.,'昨日')]  
    Click Link    //div[@class="baDateform btn-group hidden_991"]/a[contains(.,'昨日')] 
    Execute JavaScript    window.scrollTo(200, document.body.scrollHeight)
    Execute JavaScript  window.scrollTo(100, document.body.scrollHeight)
    Wait Until Page Contains Element  //div[@id='deposit-chart']/div//canvas
    Page Should Contain Element  //div[@id='deposit-chart']/div//canvas
    Mouse Over  //div[@id='deposit-chart']/div//canvas
    Capture Page Screenshot

*** Keywords ***
SuiteSetup
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Login Page    ${VALID_USER}    ${VALID_PASSWORD}
    
SuiteTeardown
    Close Browser
