*** Settings ***
Documentation		Log In Test Suite
Resource		login.resource
Library			SeleniumLibrary

*** Variables ***
${BROWSER}		Chrome

*** Test Cases ***
Valid Login
	Open Browser to Login Page
	Input Username	admin
	Input Password	admin
	Submit Credentials
	Discuss Page Should Be Open
	[Teardown]	Close Browser

Invalid Login
	Open Browser to Login Page
	Input Username 	foo
	Input Password 	bar
	Submit Credentials
	Login Page Should Be Open
	Invalid Login Dialog Should Be Visible
	[Teardown]	Close Browser

*** Keywords ***
Discuss Page Should Be Open
	Title Should Be 	Odoo	
	# This is the anchor on the navbar that reads "Discuss" XPath expression
	Wait Until Element Is Visible	//*[@class="dropdown-item o_menu_brand"]	3
	Element Should contain	//*[@class="dropdown-item o_menu_brand"]	Discuss

Login Page Should Be Open
	Title Should be		Login | My Website

Invalid Login Dialog Should Be Visible
	# XPath expression for finding the alert dialog box
	Wait Until Element Is Visible	//*[@class="alert alert-danger"]	3
	Element Should Contain	//*[@class="alert alert-danger"]	Wrong login/password
