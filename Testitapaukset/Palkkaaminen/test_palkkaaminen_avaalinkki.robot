*** Settings ***
Library				Selenium2Library
Suite Setup			Open And Maximize Browser
Suite Teardown		Close All Browsers

*** Variables ***
${STARTPAGE}		https://www.suomi.fi/
${BROWSER}			chrome

${START}			Aloita palkkaamispolku

*** Test Cases ***
Open wizard
	[Documentation]		Avaa wizardin navigoimalla Suomi.fi etusivulta
	Open Link
	Check Page

*** Keywords ***
Open And Maximize Browser
	[Documentation]		Avaa muuttujassa BROWSER määritetyn selaimen sivulle STARTPAGE ja suurentaa ikkunan koko ruudun kokoiseksi
	Open Browser		${STARTPAGE}	${BROWSER}
	Maximize Browser Window
	
Open Link
	[Documentation]		Painaa annettuja xpatheja vastaavia elementtejä
	Click Button		xpath=//button[@class='dropdown-button' and @aria-label='Sisällöt yrityksille ja yhteisöille']
	Click Element		xpath=//*[@id="dropdown-4"]/ul/li[1]/a
	Wait Until Page Contains		Yritystoiminnan suunnittelupolku
	Click Element		xpath=//*[@id="main"]/div[2]/div[1]/div/div[2]/div[3]/div/div[6]/a
	
Check Page
	[Documentation]		Sulkee popupin ja tarkistaa, että ollaan oikealla sivulla
	Close Popup
	Verify Page		${START}
	
Close Popup
	[Documentation]		Odottaa, kunnes popup on näkyvissä, sen jälkeen paina "Sulje"-nappia
	Wait Until Element is Visible		xpath=//*[@title='Sulje']
	Click Button						xpath=//*[@title='Sulje']

Verify Page
	[Documentation]		Odottaa, kunnes sivulla näkyy argumenttina saatu merkkijono
	[Arguments]		${string}
	Wait Until Page Contains	${string}