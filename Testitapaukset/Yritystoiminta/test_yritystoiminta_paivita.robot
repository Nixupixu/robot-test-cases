*** Settings ***
Library				Selenium2Library
Suite Setup			Open And Maximize Browser
Suite Teardown		Close All Browsers

*** Variables ***
${STARTPAGE}		https://www.suomi.fi/yritykselle/yritystoiminnan-suunnittelupolku
${BROWSER}			chrome

*** Test Cases ***
Go Forward and Refresh
	[Documentation]			Menee wizardia neljä sivua eteenpäin, jonka jälkeen päivittää sivun. Sen jälkeen tarkistaa ollaanko takaisin aloitussivulla
	Business Idea			true
	Products and Services	true
	Customers and Markets	true
	Marketing and Sales		true
	Refresh Page
	Verify Page				Aloita yritystoiminnan suunnittelupolku
	
*** Keywords ***
Open And Maximize Browser
	[Documentation]		Avaa muuttujassa BROWSER määritetyn selaimen sivulle STARTPAGE, suurentaa ikkunan koko ruudun kokoiseksi,
	...					tarkistaa avatun sivun, sulkee alareunan popupin, ja siirtyy lopulta wizardin ensimmäiselle sivulle
	Open Browser		${STARTPAGE}	${BROWSER}
	Maximize Browser Window
	Verify Page			Aloita yritystoiminnan suunnittelupolku
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
	
Focus And Click On Radio Button
	[Documentation]		Klikkaa hiirtä sen elementin kohdalla, jolla on argumenttina annettu name ja value
	[Arguments] 	${name}		${value}
	Focus	xpath=//input[@name='${name}' and @value='${value}']
	Click Element At Coordinates	xpath=//input[@name='${name}' and @value='${value}']	0	0
	
Business Idea
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	[Arguments]			${value}
	Verify Page			Aloita yritystoiminnan suunnittelupolku
	Radiobuttons		ideaOwnIdea  ideaLowerCosts  ideaBetterQuality  ideaSalesPriceStudied	${value}
	Move To Next Page
	
Products and Services
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	[Arguments]			${value}
	Verify Page			Suunnittele jo liikeideaa miettiessäsi, mitä tavaroita tai palveluja yrityksesi myy
	Radiobuttons		productPermissionsStudied  productPriceStudied  productCostsAndIncomesStudied  productPriceFormationStudied		${value}
	Move To Next Page

Customers and Markets
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	[Arguments]			${value}
	Verify Page			Jokainen uusi yritys joutuu kilpailutilanteeseen
	Radiobuttons		marketsCompetitorsStudied  marketsAcquintanceWillingToBuyStudied  marketsCustomersStudied  marketsInternationalStudied		${value}
	Move To Next Page
	
Marketing and Sales
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	[Arguments]			${value}
	Verify Page			Yritystoiminnan keskeisin asia on, miten asiakkaat löytävät tuotteesi tai palvelusi
	Radiobuttons		salesCareForSalesSelf  salesExperienceInSales  salesAccessToInformationStudied  salesInternetStudied	${value}
	Move To Next Page
	
Radiobuttons
	[Documentation]		Kutsuu argumenttina annettujen nappien painamista
	[Arguments]		${class1}	${class2}	${class3}	${class4}	${value}
	Focus And Click On Radio Button		${class1}	${value}
	Focus And Click On Radio Button		${class2}	${value}
	Focus And Click On Radio Button		${class3}	${value}
	Focus And Click On Radio Button		${class4}	${value}

Refresh Page
	[Documentation]		Lataa sivun uudestaan
	Reload Page
	