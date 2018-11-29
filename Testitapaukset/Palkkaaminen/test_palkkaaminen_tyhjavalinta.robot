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
First page bug
	[Documentation]		Tarkistaa onko yhä olemassa bugi, jolla ensimmäiseltä sivulta pääsee eteenpäin valinnan poistamalla
	Button Disabled
	Make And Delete Selection
	Verify Page		${SUMMARY}

*** Keywords ***
Open And Maximize Browser
	[Documentation]		Avaa muuttujassa BROWSER määritetyn selaimen sivulle STARTPAGE, suurentaa ikkunan koko ruudun kokoiseksi,
	...					tarkistaa avatun sivun, sulkee alareunan popupin, ja siirtyy lopulta wizardin ensimmäiselle sivulle
	Open Browser		${STARTPAGE}	${BROWSER}
	Maximize Browser Window
	Close Popup
	Verify Page			Aloita palkkaamispolku	
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
	Click Button		xpath=//button[@label = 'Seuraava']
	
Button Disabled
	[Documentation]		Tarkistaa, onko "Seuraava"-nappi ei-aktiivisena
	Wait Until Page Contains Element		xpath=//button[@label = 'Seuraava']
	Element Should Be Disabled				xpath=//button[@label = 'Seuraava']

Make And Delete Selection
	[Documentation]		Tekee valinnan, sitten tarkistaa onko "Seuraava"-nappi aktiivinen. Sen jälkeen poistaa valinnan ja tarkistaa uudelleen.
	...					Jos testi menee läpi, on yhä olemassa bugi PAL-6766
	Click Element At Coordinates			xpath=//input[@name = 'labourMethodHiring']	0	0
	Element Should Be Enabled				xpath=//button[@label = 'Seuraava']
	Click Element At Coordinates			xpath=//input[@name = 'labourMethodHiring']	0	0
	Element Should Be Enabled				xpath=//button[@label = 'Seuraava']
	Click Button							xpath=//button[@label = 'Seuraava']