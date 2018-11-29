*** Settings ***
Library				Selenium2Library
Suite Setup			Open And Maximize Browser
Suite Teardown		Close All Browsers

*** Variables ***
${STARTPAGE}		https://www.suomi.fi/yritykselle/tyontekijan-palkkaamispolku
${BROWSER}			chrome			

*** Test Cases ***
Go through wizard
	[Documentation]		Käy wizardin läpi
	Labour Method
	Employment
	Recruiting
	Contract
	Insurances
	Payroll
	Register
	Verify Page			Palkkaan henkilön yritykseeni työntekijäksi tai harjoittelijaksi. 

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
	
Contract
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page			Miten aiot tehdä työsopimuksen?
	Click Element At Coordinates		xpath=//input[@name="contractWrittenContract" and @value="true" ]	0	0
	Move To Next Page

Insurances
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page			Oletko jo ottanut työntekijän eläkevakuutuksen?
	Click Element At Coordinates		xpath=//input[@name="insurancePensionInsurance" and @value="true"]	0	0
	Click Element At Coordinates		xpath=//input[@name="insuranceOccupationalAccident" and @value="false"]	0	0
	Click Element At Coordinates		xpath=//input[@name="insuranceUnemploymentInsurancePrior" and @value="true"]	0	0
	Move To Next Page
	
Payroll
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page			Maksatko palkan ja työnantajasuoritukset itse vai käytätkö esimerkiksi tilitoimistoa?
	Click Element At Coordinates		xpath=//input[@name="payrollAccountingFirm" and @value="false"]	0	0
	Move To Next Page

Register
	[Documentation]		Tarkistaa, että ollaan oikealla sivulla, jonka jälkeen kutsuu nimettyjen elementtien painamista. Sen jälkeen siirtyy seuraavalle sivulle
	Verify Page			Kuinka monta vakituista työntekijää yrityksessäsi työskentelee kalenterivuoden aikana?
	Click Element At Coordinates		xpath=//input[@name="registerPermanentMoreThanOne" and @value="false"]	0	0
	Click Element At Coordinates		xpath=//input[@name="registerTemporaryMoreThanFive" and @value="false"]	0	0
	Move To Next Page