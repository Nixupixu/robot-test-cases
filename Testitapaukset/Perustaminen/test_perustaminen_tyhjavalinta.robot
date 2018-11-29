*** Settings ***
Library				Selenium2Library
Suite Setup			Open And Maximize Browser
Suite Teardown		Close All Browsers

*** Variables ***
${STARTPAGE}		https://www.suomi.fi/yritykselle/yrityksen-perustamispolku
${BROWSER}			chrome
${START}			Aloita yrityksen perustamispolku

*** Test Cases ***
Try To Go Forward
	Button Disabled

*** Keywords ***
Open And Maximize Browser
	[Documentation]		Avaa muuttujassa BROWSER määritetyn selaimen sivulle STARTPAGE, suurentaa ikkunan koko ruudun kokoiseksi,
	...					tarkistaa avatun sivun, sulkee alareunan popupin, ja siirtyy lopulta wizardin ensimmäiselle sivulle
	Open Browser		${STARTPAGE}	${BROWSER}
	Maximize Browser Window
	Verify Page			${START}	
	Close Popup
	Move To Next Page
	
Close Popup
	[Documentation]		Odottaa, kunnes popup on näkyvissä, sen jälkeen paina "Sulje"-nappia
	Wait Until Element is Visible		xpath=//*[@title='Sulje']
	Click Button						xpath=//*[@title='Sulje']
	
Verify Page
	[Documentation]				Odottaa, kunnes sivulla näkyy argumenttina saatu merkkijono
	[Arguments]					${string}
	Wait Until Page Contains	${string}
	
Move To Next Page
	[Documentation]		Painaa "Seuraava"-nappia
	Wait Until Element is Visible	xpath=//button[@label = 'Seuraava']	
	Click Button					xpath=//button[@label = 'Seuraava']
	
Button Disabled
	[Documentation]		Tarkistaa, että "Seuraava"-nappi ei ole käytössä
	Element Should Be Disabled		xPath=//button[@label='Seuraava']