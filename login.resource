*** Settings ***
Documentation	Keywords and Variables for Logging In
Library		SeleniumLibrary

*** Variables ***
${LOGIN URL}	http://localhost:8069/web/login
${LOGIN SUBMIT BUTTON}	//button[@class="btn btn-primary btn-block" and text()="Log in"]

*** Keywords ***
Open Browser to Login Page
	Open Browser	${LOGIN URL}	${BROWSER}
	Title Should Be		Login | My Website

Input Username
	[Arguments]	${username}
	Input Text	login	${username}

Input Password
	[Arguments]	${password}
	Input Text	password	${password}

Submit Credentials
	Click Button	${LOGIN SUBMIT BUTTON}

