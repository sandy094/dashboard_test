*** Keyword ***
Check Account Page 
    [Documentation]    Check Account Page
    [Arguments]    ${account}    ${password}
    Input Account    ${account}
    Input Password    ${password}

Check Chart In Four card
    Page Should Contain Element    //ba-card[@id='firstDepositAmountContent']//canvas
    Page Should Contain Element    //ba-card[@id='depositAmountContent']//canvas
    Page Should Contain Element    //ba-card[@id='withdrawAmountContent']//canvas
    Page Should Contain Element    //ba-card[@id='differenceAmountContent']//canvas
    
Check Dashboard Link
    [Documentation]    Check dashboard link is correct
    [Arguments]    ${title}
    Check Topbar Link    ${title}

Count In A Day For Today
    @{cards}    Set Variable    firstDepositAmountContent    depositAmountContent    withdrawAmountContent    differenceAmountContent    
    :FOR    ${card}    IN    @{cards}
    \    Click Element    //ba-card[@id='${card}']//button[@id='sortMenu']
    \    Click Element    //ba-card[@id='${card}']//li/a[contains(.,'以日合计')]
    \    Sleep    3s
    \    Page Should Contain Element    //ba-card[@id='${card}']//canvas
    \    Capture Page Screenshot

Count In Seven Days For yesterday
    @{cards}    Set Variable    differenceAmountContent    withdrawAmountContent    depositAmountContent    firstDepositAmountContent                
    :FOR    ${card}    IN    @{cards}
    \    Sleep    5s
    \    Wait Until Page Contains Element    //ba-card[@id='${card}']//button[@id='sortMenu']
    \    Click Element    //ba-card[@id='${card}']//button[@id='sortMenu']
    \    Wait Until Page Contains Element    //ba-card[@id='${card}']//a[contains(.,"以时合计")]
    \    Click Element    //ba-card[@id='${card}']//a[contains(.,"以时合计")]
    \    Sleep    5s
    \    Page Should Contain Element    //ba-card[@id='${card}']//canvas
    \    Capture Page Screenshot
    \    Click Element    //ba-card[@id='${card}']//button[@id='sortMenu']
    \    Click Element    //ba-card[@id='${card}']//a[contains(.,"以日合计")]
    \    Sleep    5s
    \    Page Should Contain Element    //ba-card[@id='${card}']//canvas
    \    Capture Page Screenshot

Count In A Day For week
    @{cards}    Set Variable    firstDepositAmountContent    depositAmountContent    withdrawAmountContent    differenceAmountContent    
    :FOR    ${card}    IN    @{cards}
    \    Click Element    //ba-card[@id='${card}']//button[@id='sortMenu']
    \    Click Element    //ba-card[@id='${card}']//a[contains(.,"以周合计")]
    \    Sleep    5s
    \    Page Should Contain Element    //ba-card[@id='${card}']//canvas
    \    Capture Page Screenshot

Count In A Day For months
     @{cards}    Set Variable    firstDepositAmountContent    depositAmountContent    withdrawAmountContent    differenceAmountContent    
    :FOR    ${card}    IN    @{cards}
    \    Click Element    //ba-card[@id='${card}']//button[@id='sortMenu']
    \    Wait Until Page Contains Element  //ba-card[@id='${card}']//a[contains(.,"以周合计")]
    \    Click Element    //ba-card[@id='${card}']//a[contains(.,"以周合计")]
    \    Sleep    5s
    \    Page Should Contain Element    //ba-card[@id='${card}']//canvas
    \    Capture Page Screenshot
    \    Click Element    //ba-card[@id='${card}']//button[@id='sortMenu']
    \    Wait Until Page Contains Element  //ba-card[@id='${card}']//a[contains(.,"以月合计")]
    \    Click Element    //ba-card[@id='${card}']//a[contains(.,"以月合计")]
    \    Sleep    5s
    \    Page Should Contain Element    //ba-card[@id='${card}']//canvas
    \    Capture Page Screenshot

    