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
	Nationality			NON_EU_OR_ETA
	Residence			false
	Business Type		FULL_TIME
	Business Plan
	Industry Class
	Corporate Form		CORPORATION
	Licenses
	Financing
	Retirement
	Insurances
	Taxes
	Verify Page			Osakeyhtiö
	Verify Page			Hae työntekijän oleskelulupaa

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
	
Residence
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	[Arguments]		${value}
	Verify Page		Suomeen muuttoon ja oleskeluluvan saamiseen vaikuttavat monenlaiset seikat
	Focus And Click On Button		otherCountriesLiveInFinlandOver1Year	${value}
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
	
Industry Class
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page		Toimiala ilmaisee selkeästi, millä alalla yritys toimii
	Input Text		xpath=//*[@name='industry_class_query']		ohjelmisto
	Wait Until Page Contains		Ohjelmistojen suunnittelu ja valmistus
	Focus And Click On Button		industryClasses_4		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/62010	
	Move To Next Page
	
Corporate Form
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	[Arguments]		${value}
	Verify Page		Valitse yrityksellesi sopiva yritysmuoto ja kotipaikka.
	Focus And Click On Button		corporateForm		${value}
	Input Text		xpath=//div[@class='Select-input']//input[@value='']		Helsinki
	Press Key		xpath=//div[@class='Select-input']//input[@value='Helsinki']		\\13
	Move To Next Page
	
Licenses
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page		Tarkista omaa toimintaasi koskevat velvoitteet.
	Wait Until Page Contains		Sosiaali- ja terveydenhuollon tietojärjestelmien rekisteröinti
	Focus And Click On Button		permissions_0		d0aa0881-3cb8-48d6-bf19-44ff70ddde30
	Move To Next Page
	
Financing
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page		Rahoituksen tarve on erilainen yritystoimintasi eri vaiheissa
	Focus And Click On Button		applyForStartupGrant	false
	Move To Next Page
	
Retirement
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page		Yrittäjän on otettava itselleen yrittäjän eläkevakuutus
	Focus And Click On Button		ageBetween18And69		true
	Focus And Click On Button		businessContinuesOver4Months		true
	Focus And Click On Button		earningsOverYELLimit		true
	Focus And Click On Button		joinEntreprenoursUnemploymentFund		true
	Move To Next Page
	
Insurances
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page		Tietyillä toimialoilla on pakollisia vakuutuksia
	Move To Next Page
	
Taxes
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page		Arvonlisävero (alv) on kulutusvero
	Focus And Click On Button		valueOfBusinessOver10k		true
	Focus And Click On Button		joinPrePaymentRegister		true
	Move To Next Page