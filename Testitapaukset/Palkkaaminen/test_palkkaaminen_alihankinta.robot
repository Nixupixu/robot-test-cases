*** Settings ***
Library				Selenium2Library
Suite Setup			Open And Maximize Browser
Suite Teardown		Close All Browsers

*** Variables ***
${STARTPAGE}		https://www.suomi.fi/yritykselle/tyontekijan-palkkaamispolku
${BROWSER}			chrome

${START}			Aloita palkkaamispolku
${SUMMARY}			Muistilista on antamiesi tietojen perusteella koottu lista 

*** Test Cases ***
Go through wizard
	[Documentation]		Testaa, viekö alihankinnan valinta suoraan muistilistaan
	Leased Personnel
	Verify Page		${SUMMARY}

*** Keywords ***
Open And Maximize Browser
	[Documentation]		Avaa muuttujassa BROWSER määritetyn selaimen sivulle STARTPAGE, suurentaa ikkunan koko ruudun kokoiseksi,
	...					tarkistaa avatun sivun, sulkee alareunan popupin, ja siirtyy lopulta wizardin ensimmäiselle sivulle
	Open Browser		${STARTPAGE}	${BROWSER}
	Maximize Browser Window
	Verify Page		${START}
	Close Popup
	Move To Next Page
	
Close Popup
	[Documentation]		Odottaa, kunnes popup on näkyvissä, sen jälkeen paina "Sulje"-nappia
	Wait Until Element is Visible		xpath=//*[@title='Sulje']
	Click Button						xpath=//*[@title='Sulje']

Verify Page
	[Documentation]		Odottaa, kunnes sivulla näkyy argumenttina saatu merkkijono
	[Arguments]		${string}
	Wait Until Page Contains	${string}
	
Move To Next Page
	[Documentation]		Painaa "Seuraava"-nappia
	Wait Until Page Contains Element		xpath=//button[@label = 'Seuraava']
	Click Button							xpath=//button[@label = 'Seuraava']
	
Leased Personnel
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen painaa nimettyä elementtiä. Sen jälkeen siirtyy seuraavalle sivulle
	Wait Until Page Contains 		Teetän työn alihankintana.
	Click Element At Coordinates	xpath=//*[@name = 'labourMethodSubcontracting']	0	0
	Click Button					xpath=//button[@label = 'Seuraava']