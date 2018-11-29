*** Settings ***
Library				Selenium2Library
Suite Setup			Open And Maximize Browser
Suite Teardown		Close All Browsers

*** Variables ***
${STARTPAGE}		https://www.suomi.fi/
${BROWSER}			chrome

${START}			Aloita yrityksen perustamispolku

*** Test Cases ***
Open Wizard
	Open Link
	Verify Page		${START}

*** Keywords ***
Open And Maximize Browser
	Open Browser		${STARTPAGE}	${BROWSER}
	Maximize Browser Window
	
Open Link
	Click Button		xpath=//button[@class='dropdown-button' and @aria-label='Sisällöt yrityksille ja yhteisöille']
	Click Element		xpath=//*[@id="dropdown-4"]/ul/li[1]/a
	Wait Until Page Contains		Yrityksen perustamispolku
	Click Element		xpath=//*[@id="main"]/div[2]/div[1]/div/div[2]/div[3]/div/div[5]/a

Verify Page
	[Arguments]		${string}
	Wait Until Page Contains	${string}