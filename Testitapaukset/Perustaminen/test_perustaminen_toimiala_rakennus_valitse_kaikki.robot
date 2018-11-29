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
	Nationality			FINNISH
	Business Type		FULL_TIME
	Business Plan
	Industry Class
	Corporate Form		TRADE_NAME
	Licenses
	Financing
	Retirement
	Insurances
	Taxes
	Verify Page			Yksityinen elinkeinonharjoittaja 
	Verify Page			Rakennuskonevuokraus käyttäjineen
	
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
	Verify Page		Toimiala ilmaisee selkeästi, millä alalla yritys toimii
	Input Text		xpath=//*[@name='industry_class_query']		rakennus
	Wait Until Page Contains		Rakennuskonevuokraus käyttäjineen
	Wait Until Page Contains		Rakennuspaikan valmistelutyöt
	Wait Until Page Contains		Muu rakennustekninen palvelu
	Focus And Click On Button		industryClasses_0		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/43991
	Focus And Click On Button		industryClasses_1		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/08111
	Focus And Click On Button		industryClasses_2		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/41200
	Focus And Click On Button		industryClasses_3		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/46739
	Focus And Click On Button		industryClasses_4		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/16239
	Focus And Click On Button		industryClasses_5		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/23610
	Focus And Click On Button		industryClasses_6		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/47521
	Focus And Click On Button		industryClasses_7		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/43390
	Focus And Click On Button		industryClasses_8		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/43120
	Focus And Click On Button		industryClasses_9		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/43999
	Focus And Click On Button		industryClasses_10		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/23320
	Focus And Click On Button		industryClasses_11		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/46630
	Focus And Click On Button		industryClasses_12		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/81220
	Focus And Click On Button		industryClasses_13		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/47529
	Focus And Click On Button		industryClasses_14		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/91030
	Focus And Click On Button		industryClasses_15		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/22230
	Focus And Click On Button		industryClasses_16		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/77320
	Focus And Click On Button		industryClasses_17		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/23620
	Focus And Click On Button		industryClasses_18		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/43299
	Focus And Click On Button		industryClasses_19		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/43320
	Focus And Click On Button		industryClasses_20		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/42991
	Focus And Click On Button		industryClasses_21		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/46130
	Focus And Click On Button		industryClasses_22		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/71126
	Focus And Click On Button		industryClasses_23		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/28920
	Focus And Click On Button		industryClasses_24		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/41100
	Focus And Click On Button		industryClasses_25		http://www.stat.fi/meta/luokitukset/toimiala/001-2008/43110
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
	Wait Until Page Contains		Asbestipurkutyön ennakkoilmoitus
	Wait Until Page Contains		Ilmoitus pilaantuneen maaperän puhdistamisesta
	Wait Until Page Contains		Poikkeuslupa maantien suoja- tai näkemäalueelle rakentamiseen
	Focus And Click On Button		permissions_0		24a04383-b0ba-4b19-8dec-ce6663d053fa
	Focus And Click On Button		permissions_1		b1d116c0-df37-40d4-bfb4-2cf161c8cd9e
	Focus And Click On Button		permissions_2		5da8956d-4722-4a56-86ab-a2afce4fa6a9
	Focus And Click On Button		permissions_3		e1fa5779-8295-45a8-ab3a-16105726f7b7
	Focus And Click On Button		permissions_4		dd4e933a-c726-4651-a921-b4abfed63664
	Focus And Click On Button		permissions_5		eb37f414-7fbb-4ebd-8843-f532983b6646
	Focus And Click On Button		permissions_6		4d14edf0-b4e0-420e-b0e4-319d84828418
	Focus And Click On Button		permissions_7		3c734b01-abef-49b6-be31-82de09914f71
	Focus And Click On Button		permissions_8		7b440372-7c8b-409e-87e2-81436bfe69fc
	Focus And Click On Button		permissions_9		ab47cbb8-1ba7-42ad-bb51-7d467da47527
	Focus And Click On Button		permissions_10		c1e989a9-0e33-418b-8727-498ba67f639a
	Focus And Click On Button		permissions_11		c50ff29f-05f6-4971-9376-1bd64dd113e9
	Focus And Click On Button		permissions_12		868fee90-8201-4fba-831a-4e42571d3c02
	Focus And Click On Button		permissions_13		52ed10de-f598-42bb-86d0-de9ba77095ac
	Focus And Click On Button		permissions_14		1a8692a8-7502-4656-a567-957a60a6227b
	Focus And Click On Button		qualifications_0	f841b19d-6ccd-42d3-8970-104d788ba610
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