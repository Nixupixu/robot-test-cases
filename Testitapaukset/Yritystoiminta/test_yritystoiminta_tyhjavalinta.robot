*** Settings ***
Library				Selenium2Library
Suite Setup			Open And Maximize Browser
Suite Teardown		Close All Browsers

*** Variables ***
${STARTPAGE}		https://www.suomi.fi/yritykselle/yritystoiminnan-suunnittelupolku
${BROWSER}			chrome

${START}			Aloita yritystoiminnan suunnittelupolku

*** Test Cases ***
Try to go forward
	[Documentation]		Testi yrittää siirtyä eteenpäin valitsematta mitään
	Element Disabled
	
*** Keywords ***
Open And Maximize Browser
	[Documentation]		Avaa muuttujassa BROWSER määritetyn selaimen sivulle STARTPAGE, suurentaa ikkunan koko ruudun kokoiseksi,
	...					tarkistaa avatun sivun, sulkee alareunan popupin, ja siirtyy lopulta wizardin ensimmäiselle sivulle
	Open Browser	${STARTPAGE}	${BROWSER}
	Maximize Browser Window
	Verify Page		${START}
	Close Popup
	Move To Next Page
	
Close Popup
	[Documentation]		Odottaa, kunnes popup on näkyvissä, sen jälkeen paina "Sulje"-nappia
	Wait Until Element is Visible	xpath=//*[@title='Sulje']
	Click Button	xpath=//button[@title='Sulje']
	
Verify Page
	[Documentation]		Odottaa, kunnes sivulla näkyy argumenttina saatu merkkijono
	[Arguments]		${string}
	Wait Until Page Contains	${string}
	
Move To Next Page
	[Documentation]		Painaa "Seuraava"-nappia
	Click Button	xpath=//button[@label='Seuraava']
	
Focus On Radio Button
	[Documentation]		Klikkaa hiirtä sen elementin kohdalla, jolla on argumenttina annettu name ja value
	[Arguments] 	${name}
	Wait Until Page Contains Element	xpath=//input[@name='${name}']
	Focus	xpath=//input[@name='${name}']
	
First Page
	[Documentation]		Kutsuu nimettyjen elementtien painamista
	Radiobuttons	ideaOwnIdea  ideaLowerCosts  ideaBetterQuality  ideaSalesPriceStudied
	
Radiobuttons
	[Documentation]		Kutsuu argumenttina annettujen nappien painamista
	[Arguments]		${class1}	${class2}	${class3}	${class4}
	Focus On Radio Button		${class1}
	Focus On Radio Button		${class2}
	Focus On Radio Button		${class3}
	Focus On Radio Button		${class4}
	
Element Disabled
	[Documentation]		Tarkistaa, onko "Seuraava"-nappi poissa käytöstä
	First Page
	Wait Until Page Contains Element	xpath=//button[@label='Seuraava']
	Element Should Be Disabled		xpath=//button[@label='Seuraava']