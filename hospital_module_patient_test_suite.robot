*** Settings ***
Documentation		Patient Test Suite
Library			SeleniumLibrary
Resource		login.resource
Suite Setup		Log Into Odoo
*** Variables ***
${PATIENT PAGE URL} 	http://localhost:8069/web#cids=1&menu_id=268&action=382&model=hospital.patient&view_type=list
${BROWSER}		Chrome

*** Test Cases ***
Create a Patient Record
	Go To Patient Page
	Click Create
	Input Name	John Smith
	Input Age	30
	Click Save
	Patient Should be Listed	John Smith	30

Newly Created Patient Record Shows Zero Appointments
	Go To Patient Page
	Patient Should Have Zero Appointments	John Smith

Delete a Patient Record
	Go to Patient Page
	Click Patient	John Smith
	Delete Record
	Confirm Deletion
	Go To Patient Page
	Patient Should Not Be Listed	John Smith

*** Keywords ***
Login To Odoo
	Open Browser to Login Page
	Input Username	admin
	Input Password	admin
	Submit Credentials

Open Browser to Patient Page
	Open Browser	${PATIENT PAGE URL}	${BROWSER}
	Title Should Be	Odoo - Patients

Click Create
	${createButton}	Set Variable	//button[@class="btn btn-primary o_list_button_add"]
	Wait Until Element Is Visible	${createButton}
	Click Element	${createButton}

Input Name
	[Arguments]	${patientName}
	${nameInput}	Set Variable	//input[@name="name"]
	Wait Until Element Is Visible	${nameInput}
	Input Text	${nameInput}	${patientName}

Input Age
	[Arguments]	${patientAge}
	${ageInput}	Set Variable	//input[@name="age"]
	Input Text	${ageInput}	${patientAge}

Click Save
	${saveButton}	Set Variable	//button[@title="Save record"]
	Click Element	${saveButton}

Go To Patient Page
	Go To			${PATIENT PAGE URL}

Patient Should be Listed
	[Arguments]	${patientName}	${patientAge}
	Wait Until Page Contains	Hospital Patient created
	${patientReference}		Get Text	//span[@name="reference"]
	Title Should Be			Odoo - [${patientReference}] ${patientName}
	${nameSpan}	Set Variable	//span[@name="name"]
	${ageSpan}	Set Variable	//span[@name="age"]
	Element Should Contain		${nameSpan}	${patientName}
	Element Should Contain		${ageSpan}	${patientAge}

Click Patient
	[Arguments]	${patientName}
	${patientListElement}	Set Variable	//td[@name="name" and @title="${patientName}"]
	Wait Until Element Is Visible		${patientListElement}
	Click Element		${patientListElement}

Delete Record
	${dropdown}	Set Variable	//span[@class="o_dropdown_title" and text()="Action"]
	${deleteItem}	Set Variable	//a[@class="dropdown-item" and text()="Delete"]
	Wait Until Keyword Succeeds	3	1	Click Action Dropdown	${dropdown}
	Wait Until Keyword Succeeds	3	1	Click Delete Item	${deleteItem}
	
Click Action Dropdown
	[Arguments]	${dropdown}
	Wait Until Element Is Visible	${dropdown}
	Click Element	${dropdown}

Click Delete Item
	[Arguments]	${deleteItem}
	Wait Until Element Is Visible	${deleteItem}
	Click Element	${deleteItem}

Confirm Deletion
	Set Browser Implicit Wait	1
	${okButton}	Set Variable	//span[text()="Ok"]
	Wait Until Element Is Visible	${okButton}
	Click Element	${okButton}
	Wait Until Element Is Not Visible	//div[@class="modal-backdrop show"]

Patient Should Not Be Listed
	[Arguments]	${patientName}
	Page Should Not Contain	${patientName}

Patient Should Have Zero Appointments
	[Arguments]	${patientName}
	Page Should Contain	${patientName}
	Element Should Contain	//td[@name="appointment_count"]	0

