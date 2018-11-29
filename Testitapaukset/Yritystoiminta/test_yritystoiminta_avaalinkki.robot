*** Settings ***
Library				Selenium2Library
Suite Setup			Open And Maximize Browser
Suite Teardown		Close All Browsers

*** Variables ***
${STARTPAGE}		https://www.suomi.fi/
${BROWSER}			chrome

${START}			Aloita yritystoiminnan suunnittelupolku

*** Test Cases ***
Open wizard
	[Documentation]		Yrittää avata wizardin navigoimalla etusivulta linkkien kautta
	Open Link
	Check Page

*** Keywords ***
Open And Maximize Browser
	[Documentation]		Avaa muuttujassa BROWSER määritetyn selaimen sivulle STARTPAGE, suurentaa ikkunan koko ruudun kokoiseksi,
	...					tarkistaa avatun sivun, sulkee alareunan popupin, ja siirtyy lopulta wizardin ensimmäiselle sivulle
	
	Open Browser		${STARTPAGE}	${BROWSER}
	Maximize Browser Window
	
Open Link
	[Documentation]		Navigoi Suomi.fi-etusivulta wizardiin linkkien avulla
	Click Button		xpath=//button[@class='dropdown-button' and @aria-label='Sisällöt yrityksille ja yhteisöille']
	Click Element		xpath=//*[@id="dropdown-4"]/ul/li[1]/a
	Wait Until Page Contains		Yritystoiminnan suunnittelupolku
	Click Element		xpath=//*[@id="main"]/div[2]/div[1]/div/div[2]/div[3]/div/div[4]/a
	
Check Page
	[Documentation]		Kutsuu popupin sulkemista ja sivun tarkistusta
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