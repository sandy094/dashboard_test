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
    Close Announcement
    Sleep    10s
    Click Sidebar Link    运营看板
    Sleep    10s
    Click Element    //a[@class='borderr_1px active'][contains(.,'运营看板')]
    Wait Until Page Contains Element  //a[@class='borderr_1px active acting'][contains(.,'运营看板')]/div/span[contains(.,' 存提资讯 ')]
    Click Element  //a[@class='borderr_1px active acting'][contains(.,'运营看板')]/div/span[contains(.,' 存提资讯 ')]
   
Click Search
    Sleep    10s

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
    \  Quick Search botton    ${season}
    \  Check Chart In Four card
    \  Count In A Day For months

Check Trend
    # 排行裡單一站台的趨勢圖(本周的4張卡片)
    Quick Search botton    上周
    Sleep    10s
    Wait Until Element Is Visible    //ba-card[@id='differenceAmountContent']//div/a[contains(.,'排行')]
    Click Element    //ba-card[@id='differenceAmountContent']//div/a[contains(.,'排行')]

    @{rows}  Set Variable  2  3  4  
    :FOR  ${row}  IN  @{rows}
    \  Wait Until Page Contains Element  //ba-card[@id='differenceAmountContent']//tbody/tr[${row}]/td[3]/div/small
    \  Click Element  //ba-card[@id='differenceAmountContent']//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  2s
    \  Wait Until Page Contains Element  //div[@class='container bg-white']//canvas
    \  Sleep  5s
    \  Mouse Over  //div[@class='container bg-white']//canvas
    \  Capture Page Screenshot
    \  Data Table Check Trend Of List
    \  Click Element  //div[@class='container bg-white']/div/i

    Click Element  //ba-card[@id='withdrawAmountContent']//div/a[contains(.,'排行')]
    @{rows}  Set Variable  2  3  4  
    :FOR  ${row}  IN  @{rows}
    \  Click Element  //ba-card[@id='withdrawAmountContent']//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  2s
    \  Wait Until Page Contains Element  //div[@class='container bg-white']//canvas
    \  Mouse Over  //div[@class='container bg-white']//canvas
    \  Capture Page Screenshot
    \  Data Table Check Trend Of List
    \  Click Element  //div[@class='container bg-white']/div/i

    Click Element  //ba-card[@id='depositAmountContent']//div/a[contains(.,'排行')]
    @{rows}  Set Variable  2  3  4 
    :FOR  ${row}  IN  @{rows}
    \  Click Element  //ba-card[@id='depositAmountContent']//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  2s
    \  Wait Until Page Contains Element  //div[@class='container bg-white']//canvas
    \  Mouse Over  //div[@class='container bg-white']//canvas
    \  Capture Page Screenshot
    \  Data Table Check Trend Of List
    \  Click Element  //div[@class='container bg-white']/div/i

    Click Element  //ba-card[@id='firstDepositAmountContent']//div/a[contains(.,'排行')]
    @{rows}  Set Variable  2  3  4  
    :FOR  ${row}  IN  @{rows}
    \  Click Element  //ba-card[@id='firstDepositAmountContent']//tbody/tr[${row}]/td[3]/div/small
    \  Sleep  2s
    \  Wait Until Page Contains Element  //div[@class='container bg-white']//canvas
    \  Mouse Over  //div[@class='container bg-white']//canvas
    \  Capture Page Screenshot
    \  Click Element  //div[@class='container bg-white']/div/i

Search In Datetime 
    Sleep    10s
    @{mounths}    Set Variable    0: 2019年12月  1: 2019年11月  2: 2019年10月  3: 2019年9月
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
