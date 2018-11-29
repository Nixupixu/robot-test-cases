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
	[Documentation]		Menee wizardia muutaman sivun eteenpäin, jonka jälkeen lataa sivun uudelleen
	Nationality			FINNISH
	Business Type		FULL_TIME
	Business Plan
	Refresh Page
	Verify Page			${START}

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
	
Focus And Click On Button
	[Documentation]		Keskittää argumenttina annettuun elementtiin, ja painaa sitä
	[Arguments] 	${name}		${value}
	Focus	xpath=//input[@name='${name}' and @value='${value}']
	Click Element At Coordinates	xpath=//input[@name='${name}' and @value='${value}']	0	0
	
Nationality
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	[Arguments]		${value}
	Verify Page		Kansalaisuutesi ja pysyvä asuinpaikkasi vaikuttavat yritystoimintaasi Suomessa
	Focus And Click On Button		nationality		${value}
	Focus And Click On Button		isPermanentlyLivingOutsideETA		false
	Move To Next Page
	
Business Type
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	[Arguments]		${value}
	Verify Page		Valitse omaan tilanteesi sopiva tapa toimia yrittäjänä.
	Focus And Click On Button		businessType	${value}
	Move To Next Page
	
Business Plan
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page		Yrityksen perustaminen edellyttää huolellista suunnittelua.
	Focus And Click On Button 	businessPlanDone	false
	Focus And Click On Button		hireEmployees		false
	Move To Next Page
	
Refresh Page
	[Documentation]		Lataa sivun uudelleen
	Reload Page