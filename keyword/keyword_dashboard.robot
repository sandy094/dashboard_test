*** Keyword ***
Check Account Page 
    [Documentation]    Check Account Page
    [Arguments]    ${account}    ${password}
    Input Account    ${account}
    Input Password    ${password}

Check Chart In Four card
    Page Should Contain Element    //ba-card[@class='dashboss_chart payoffSums']//canvas
    Page Should Contain Element    //ba-card[@class='dashboss_chart commissionableSums']//canvas
    Page Should Contain Element    //ba-card[@class='dashboss_chart wagersCounts']//canvas
    Page Should Contain Element    //ba-card[@class='dashboss_chart memberCounts']//canvas

Check Chart When Click list In Right
    [Documentation]    When Click list in Right
    List In Right Way
    Chart Transform
    Check Chart
    List In Right Way
    Chart Transform
    
Check Dashboard Link
    [Documentation]    Check dashboard link is correct
    [Arguments]    ${title}
    Check Topbar Link    ${title}

Check Topbar Link
    [Arguments]    ${title}
    Click Element    //li/a[contains(.,'${title}')]


Count In A Day For Today
    @{cards}    Set Variable    dashboss_chart payoffSums    dashboss_chart commissionableSums    dashboss_chart wagersCounts    dashboss_chart memberCounts    
    :FOR    ${card}    IN    @{cards}
    \    Click Element    //ba-card[@class='${card}']//button[@id='sortMenu']
    \    Click Element    //ba-card[@class='${card}']//li/a[contains(.,'以日合计')]
    \    Sleep    3s
    \    Page Should Contain Element    //ba-card[@class='${card}']//canvas
    \    Capture Page Screenshot

Count In Seven Days For yesterday
    @{cards}    Set Variable    dashboss_chart payoffSums    dashboss_chart commissionableSums    dashboss_chart wagersCounts    dashboss_chart memberCounts    
    :FOR    ${card}    IN    @{cards}
    \    Wait Until Page Contains Element   //ba-card[@class='${card}']//button[@id='sortMenu']
    # \    Click Element    //ba-card[@class='${card}']//button[@id='sortMenu']
    # \    Click Element    //ba-card[@class='${card}']//a[contains(.,"以时合计")]
    # \    Sleep    5s
    # \    Page Should Contain Element    //ba-card[@class='${card}']//canvas
    # \    Capture Page Screenshot
    \    Click Element    //ba-card[@class='${card}']//button[@id='sortMenu']
    \    Click Element    //ba-card[@class='${card}']//a[contains(.,"以日合计")]
    \    Sleep    5s
    \    Page Should Contain Element    //ba-card[@class='${card}']//canvas
    \    Capture Page Screenshot

Count In A Day For week
    @{cards}    Set Variable    dashboss_chart payoffSums    dashboss_chart commissionableSums    dashboss_chart wagersCounts    dashboss_chart memberCounts    
    :FOR    ${card}    IN    @{cards}
    \    Click Element    //ba-card[@class='${card}']//button[@id='sortMenu']
    \    Click Element    //ba-card[@class='${card}']//a[contains(.,"以周合计")]
    \    Sleep    5s
    \    Page Should Contain Element    //ba-card[@class='${card}']//canvas
    \    Capture Page Screenshot

Count In A Day For months
    @{cards}    Set Variable    dashboss_chart payoffSums    dashboss_chart commissionableSums    dashboss_chart wagersCounts    dashboss_chart memberCounts    
    :FOR    ${card}    IN    @{cards}
    \    Click Element    //ba-card[@class='${card}']//button[@id='sortMenu']
    \    Wait Until Page Contains Element  //ba-card[@class='${card}']//a[contains(.,"以周合计")]
    \    Sleep    5s
    \    Click Element    //ba-card[@class='${card}']//a[contains(.,"以周合计")]
    \    Page Should Contain Element    //ba-card[@class='${card}']//canvas
    \    Capture Page Screenshot
    \    Click Element    //ba-card[@class='${card}']//button[@id='sortMenu']
    \    Wait Until Page Contains Element  //ba-card[@class='${card}']//a[contains(.,"以月合计")]
    \    Click Element    //ba-card[@class='${card}']//a[contains(.,"以月合计")]
    \    Sleep    5s
    \    Page Should Contain Element    //ba-card[@class='${card}']//canvas
    \    Capture Page Screenshot

List In Right Way
    @{categorys}    Set Variable    机率    视讯    体育    棋牌    彩票
    :FOR    ${category}    IN    @{categorys}
    \    Wait Until Page Contains Element    //div[@class="table-responsive"]//tr[contains(.,"${category}")]
    \    Sleep    8s
    \    Click Element    //div[@class="table-responsive"]//td[contains(.,"${category}")]
    \    Sleep    5s
    \    Page Should Contain Element    //table[@class='table dataTable']
    \    Chart Transform
    
# 圖表
Check Chart By Station
    ${checkValueA}=    Get Text    //div[@class='chart-panel']/div/div/span
    @{elements}    Set Variable      2    3    4    5
    :FOR    ${i}    IN    @{elements}
    \    Select From List By Value    //select[@class='form-control noborder borderr_1px']    ${i}
    \    Sleep    10s
    \    ${checkValueB}=  Get Text    //div[@class='chart-panel']/div/div/span
    \    Should Not Match    ${checkValueA}  ${checkValueB}
    \    ${checkValueA}=    Set Variable    ${checkValueB}
   

Check Chart In Game Station
    [Documentation]    Check Dashboard Chart in button
    [Arguments]    ${title}
    Click Element    //div[@class='row hidden_991']/div/div/div/button[contains(.,'${title}')]
    Check Chart By Station
    Chart Transform

Check Chart In Game Classification
    [Documentation]    Check Dashboard Chart in button
    [Arguments]    ${title}
    Click Element    //div[@class='row hidden_991']/div/div/div/button[contains(.,'${title}')]
    Check Chart By Classification
    Chart Transform

Check Chart By Classification
    @{elements}    Set Variable    1    2    3    4    5
    :FOR    ${i}    IN    @{elements}
    \    Select From List By Value    //select[@class='form-control noborder borderr_1px']    ${i}
    \    Sleep    10s
    \    List In Right Way


