*** Settings ***
Documentation		Log In Test Suite
Library			SeleniumLibrary

*** Variables ***
${LOGIN URL}		http://localhost:8069/web/login
${BROWSER}		Chrome

*** Test Cases ***
Valid Login
	Open Browser to Login Page
	Input Username	admin
	Input Password	admin
	Submit Credentials
	Discuss Page Should Be Open
	[Teardown]	Close Browser

*** Keywords ***
Open Browser to Login Page
	Open Browser 		${LOGIN URL}	${BROWSER}
	Title Should Be		Login | My Website

Input Username
	[Arguments]	${username}
	Input Text	login		${username}

Input Password
	[Arguments]	${password}
	Input Text	password		${password}

Submit Credentials
	# This is the submit button element XPath
	Click Element 	//html/body/div[1]/main/div/form/div[3]/button[1]

Discuss Page Should Be Open
	Title Should Be 	Odoo	
	# This is the anchor on the navbar that reads "Discuss" XPath
	Wait Until Element Is Visible	//html/body/header/nav/a	3
	Element Should contain	//html/body/header/nav/a	Discuss
