*** Settings ***
Library				Selenium2Library
Suite Setup			Open And Maximize Browser
Suite Teardown		Close All Browsers

*** Variables ***
${STARTPAGE}		https://www.suomi.fi/yritykselle/tyontekijan-palkkaamispolku
${BROWSER}			chrome			

*** Test Cases ***
Go through wizard
	[Documentation]		Käy wizardia läpi muutaman sivun, jonka jälkeen lataa sivun uudestaan
	Labour Method
	Employment
	Recruiting
	Refresh Page
	Verify Page			Aloita palkkaamispolku

*** Keywords ***
Open And Maximize Browser
	[Documentation]		Avaa muuttujassa BROWSER määritetyn selaimen sivulle STARTPAGE, suurentaa ikkunan koko ruudun kokoiseksi,
	...					tarkistaa avatun sivun, sulkee alareunan popupin, ja siirtyy lopulta wizardin ensimmäiselle sivulle
	Open Browser		${STARTPAGE}	${BROWSER}
	Maximize Browser Window
	Verify Page			Aloita palkkaamispolku	
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
	Click Button		xpath=//button[@label = 'Seuraava']
	
Labour Method
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page			Miten haluat hankkia työlle tekijän?
	Click Element At Coordinates		xpath=//input[@name='labourMethodHiring']	0	0
	Move To Next Page

Employment
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page			Millaiseen työsuhteeseen palkkaat työntekijän?
	Click Element At Coordinates		xpath=//input[@name="employmentUntilFurtherNotice" and @value="true"]	0	0
	Click Element At Coordinates		xpath=//input[@name="employmentFullTime" and @value="true"]		0	0
	Move To Next Page
	
Recruiting
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page			Onko sinulla jo valmiiksi tiedossa, kenet aiot palkata?
	Click Element At Coordinates		xpath=//input[@name="recruitmentEmployeeAlreadyFound" and @value="true"]	0	0
	Click Element At Coordinates		xpath=//input[@name="recruitmentEmployeeUnder18" and @value="false"]	0	0
	Click Element At Coordinates		xpath=//input[@name="recruitmentEmployeeOutsideEU" and @value="false"]	0	0
	Click Element At Coordinates		xpath=//input[@name="recruitmentPublicSupport" and @value="false"]	0	0
	Move To Next Page
	
Refresh Page
	[Documentation]		Lataa sivun uudestaan
	Reload Page