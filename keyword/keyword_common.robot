*** Keywords ***
# Check Sidebar Link And Verify Page Title
#     [Arguments]    ${title}
#     Wait Until Page Contains Element    //li[@title='${title}']
#     Click Element    //li[@title='${title}']
#     Wait Until Page Contains    //div[@class='${title}']

Chart Transform
    # 長條圖/趨勢圖轉換
    Page Should Contain Element    //div[@class='CHART-AREA']/echarts-ng2/div/div/canvas    limit=2
    Mouse Over    //div[@class='CHART-AREA']/echarts-ng2/div/div/canvas
    Capture Page Screenshot
    Wait Until Element Is Visible  //div[@ngbtooltip='长条合计']
    Click Element    //div[@ngbtooltip='长条合计']
    Page Should Contain Element    //div[@class='CHART-AREA']/echarts-ng2/div/div/canvas    limit=2
    Sleep    5s
    Capture Page Screenshot
    Click Element    //div[@ngbtooltip='趋势详细']

Click Sidebar Link
    [Arguments]    ${title}
    Sleep    30s
    Wait Until Page Contains Element    //li[@title="${title}"]    
    Click Element    //li[@title="${title}"] 

Click Signin Button
    Wait Until Page Contains Element    //button[@class="btn btn-default btn-auth"]
    Click Element    //button[@class="btn btn-default btn-auth"]

Click Topbar Link 
    [Arguments]    ${title}
    Wait Until Page Contains Element    //a[@class='borderr_1px'][contains(.,'${title}')]
    Click Element    //a[@class='borderr_1px'][contains(.,'${title}')]

Data Table Check Trend Of List
# 趨勢圖裡的損益查詢 
    @{values}    Set Variable  2  3  4  5  
    :FOR  ${value}  IN  @{values} 
    \  Click Element  //div[@class='drop-select']
    \  Wait Until Page Contains Element  //div[@class='drop-select']/ul/li[${value}]
    \  Click Element  //div[@class='drop-select']/ul/li[${value}]
    \  Sleep  5s
    \  Wait Until Page Contains Element  //div[@class='container bg-white test']//canvas
    \  Mouse Over  //div[@class='container bg-white test']//canvas
    \  Capture Page Screenshot

Data Table Check Game Of List
# 遊戲頁籤的損益查詢

    ${testValueA}  Set Variable    0
    @{values}    Set Variable  2  3  4  5  
    :FOR  ${value}  IN  @{values} 
    \  Wait Until Page Contains Element  //div[@class='drop-select']
    \  Click Element  //div[@class='drop-select']
    \  Sleep  2s
    \  ${result}=    Run Keyword And Return Status    Wait Until Page Contains Element  //div[@class='drop-select']/ul/li[${value}]
    \  Run Keyword If    '${result}'=='False'    Capture Page Screenshot    Else    No Operation    
    \  Click Element  //div[@class='drop-select']/ul/li[${value}]
    \  Sleep  7s
    \  Wait Until Page Contains Element  //table[@class='table-striped type-table']//tbody/tr[1]/td[2]
    \  ${testValueB}=  Get Text  //table[@class='table-striped type-table']//tbody/tr[1]/td[2]
    \  Should Not Match  ${testValueA}  ${testValueB}
    
    
Input Account
    [Arguments]    ${account}
    Wait Until Page Contains Element    //input[@id="inputEmail3"]
    Input Text    //input[@id="inputEmail3"]    ${account}

Input Password
    [Arguments]    ${password}
    Wait Until Page Contains Element    //input[@id="inputPassword3"]
    Input Text    //input[@id="inputPassword3"]    ${password}

Login Page
    [Arguments]    ${account}    ${password}
    Log    ${account}
    Input Account    ${account}
    Input Password    ${password}
    Click Signin Button
Quick Search In year and season
    #本年.本季快搜
    [Arguments]    ${title}
    Page Should Contain Element    //div[@class="Interval_type mt-2"]
    Mouse Over    //div[@class="Interval_type mt-2"]
    Wait Until Page Contains Element    //div[@id="pick"]/ul/li[contains(.,'${title}')]
    Click Element    //div[@id="pick"]/ul/li[contains(.,'${title}')]
    Sleep    10s
    Capture Page Screenshot

Quick Search botton
    #今日.昨日..上月快搜
    [Documentation]    Click Time Search In Quick Search To Search
    [Arguments]    ${title}    
    Wait Until Element Is Visible   //div[@class="baDateform btn-group hidden_991"]/a[contains(.,'${title}')]  
    Click Link    //div[@class="baDateform btn-group hidden_991"]/a[contains(.,'${title}')] 
    Sleep    10s
    Capture Page Screenshot
    
Search In Month
    #月份比較
    [Arguments]    ${title}
    Wait Until Page Contains Element  //div[@class='hove_hourset']
    Mouse Over     //div[@class='hove_hourset']
    Wait Until Page Contains Element    //div[@class='select_month']/select
    Select From List By Value    //div[@class='select_month']/select    ${title}
    Sleep    5s
    # Capture Page Screenshot
    Click Element    //div[@class='content-top clearfix']

