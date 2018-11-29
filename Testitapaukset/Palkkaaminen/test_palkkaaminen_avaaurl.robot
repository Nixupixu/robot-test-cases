*** Settings ***
Library				Selenium2Library
Suite Setup			Open And Maximize Browser
Suite Teardown		Close All Browsers

*** Variables ***
${STARTPAGE}		https://www.suomi.fi/yritykselle/tyontekijan-palkkaamispolku
${BROWSER}			chrome

${START}			Aloita palkkaamispolku

*** Test Cases ***
Open wizard
	[Documentation]		Avaa wizardin suoraan urlista, ja tarkistaa ollaanko oikealla sivulla
	Verify Page			Aloita palkkaamispolku	

*** Keywords ***
Open And Maximize Browser
	[Documentation]		Avaa muuttujassa BROWSER määritetyn selaimen sivulle STARTPAGE, suurentaa ikkunan koko ruudun kokoiseksi,
	...					tarkistaa avatun sivun, sulkee alareunan popupin, ja siirtyy lopulta wizardin ensimmäiselle sivulle
	Open Browser		${STARTPAGE}	${BROWSER}
	Maximize Browser Window
	Close Popup
	
Close Popup
	[Documentation]		Odottaa, kunnes popup on näkyvissä, sen jälkeen paina "Sulje"-nappia
	Wait Until Element is Visible		xpath=//*[@title='Sulje']
	Click Button						xpath=//*[@title='Sulje']

Verify Page
	[Documentation]				Odottaa, kunnes sivulla näkyy argumenttina saatu merkkijono
	[Arguments]					${string}
	Wait Until Page Contains	${string}