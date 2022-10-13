CREATE DATABASE city;

USE city;

CREATE TABLE comuni_italiani(
CR nvarchar(10),
CUTS nvarchar(10),
codice_provincia nvarchar(10),
progressivo_comune nvarchar(10),
CC_alfanumerico nvarchar(10),
denominazione_ita_straniera nvarchar(80),
denominazione_ita nvarchar(50),
denominazione_altra_lingua nvarchar(50),
codice_ripartizione_geografica nvarchar(5),
ripartizione_geografica nvarchar(20),
denominazione_regione nvarchar(50),
DUTS nvarchar(40),
TUTS nvarchar(5),
FCC nvarchar(5),
sigla_automobilistica nvarchar(5),
CCFN nvarchar(10),
CCN110P nvarchar(10),
CCN107P nvarchar(10),
CCN103P nvarchar(10),
codice_catastale nvarchar(7),
codice_NUTS1_2010 nvarchar(7),
codice_NUTS2_2010 nvarchar(7),
codice_NUTS3_2010 nvarchar(7),
codice_NUTS1_2021 nvarchar(7),
codice_NUTS2_2021 nvarchar(7),
codice_NUTS3_2021 nvarchar(7),
);

SELECT * FROM comuni_italiani ci;