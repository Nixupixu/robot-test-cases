*** Settings ***
Library				Selenium2Library
Suite Setup			Open And Maximize Browser
Suite Teardown		Close All Browsers

*** Variables ***
${STARTPAGE}		https://www.suomi.fi/yritykselle/yrityksen-perustamispolku
${BROWSER}			chrome
${START}			Aloita yrityksen perustamispolku

*** Test Cases ***
Go through wizard
	[Documentation]		Menee wizardin läpi valiten sivutoimisen yrittäjyyden ja laskutuspalvelun
	Nationality			FINNISH
	Business Type		PART_TIME
	Part Time Mode		BILLING_SERVICE
	Verify Page			Suunnittelet ryhtyväsi ns. kevytyrittäjäksi perustamatta omaa yritystä

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
	
Focus And Click On Radio Button
	[Documentation]		Keskittää argumenttina annettuun elementtiin, ja painaa sitä
	[Arguments] 	${name}		${value}
	Focus	xpath=//input[@name='${name}' and @value='${value}']
	Click Element At Coordinates	xpath=//input[@name='${name}' and @value='${value}']	0	0
	
Nationality
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	[Arguments]		${value}
	Verify Page		Kansalaisuutesi ja pysyvä asuinpaikkasi vaikuttavat yritystoimintaasi Suomessa
	Focus And Click On Radio Button		nationality		${value}
	Focus And Click On Radio Button		isPermanentlyLivingOutsideETA		false
	Move To Next Page
	
Business Type
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	[Arguments]		${value}
	Verify Page		Valitse omaan tilanteesi sopiva tapa toimia yrittäjänä.
	Focus And Click On Radio Button		businessType	${value}
	Move To Next Page
	
Part Time Mode
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	[Arguments]		${value}
	Verify Page		Valitse omaan tilanteesi sopiva tapa toimia.
	Focus And Click On Radio Button		partTimeMode	${value}
	Move To Next Page