CREATE DATABASE spasso;

USE spasso;

CREATE TABLE report_sale(
nome_locale nvarchar(80),
capienza int,
provincia nvarchar(50),
comune nvarchar(50),
genere_locale nvarchar(50),
CAP nvarchar(5),
numero_civico nvarchar(20),
toponimo nvarchar(15),
ingressi int,
giornate_solari int,
indirizzo nvarchar(50)
);

CREATE TABLE report_comuni(
codice_regione nvarchar(2), -- Codice di due caratteri alfanumerici, con validità nel range 01-20
codice_unita_territoriale nvarchar(3), /*Codice di tre caratteri alfanumerici, con validità nei range 001-111 per le province e 081-089 per i liberi consorzi subentrati alle omonime ex province. Il codice delle città metropolitane è, invece, creato
sommando &#39;200&#39; al codice della provincia corrispondente. Ai soli fini statistici,
permangono i codici delle soppresse province del Friuli-Venezia Giulia, cessate secondo
le modalità espresse con Legge regionale 20 dicembre 2016, n. 20 (Suppl. ord. n. 55 al
B.U.R n. 50 del 14 dicembre 2016).*/
codice_provincia nvarchar(3), /* Codice di tre caratteri alfanumerici, con validità nel
range 001-111. A partire dal 1/1/2015 con l&#39;entrata in vigore delle città metropolitane
i codici delle province corrispondenti permangono al solo scopo di costituire il codice
del comune, che non subisce variazioni. Allo stesso scopo, e ai soli fini statistici,
permangono i codici delle soppresse province del Friuli-Venezia Giulia, cessate secondo
le modalità espresse con Legge regionale 20 dicembre 2016, n. 20 (Suppl. ord. n. 55 al
B.U.R n. 50 del 14 dicembre 2016).*/
progressivo_comune nvarchar(3), /* E&#39; un numero progressivo che parte da &#39;001&#39;
all&#39;interno di ogni provincia*/
codice_comune_formato_alfanumerico nvarchar(6), -- Si ottiene dalla concatenazione del Codice Provincia con il Progressivo del comune
denominazione_comune_italana_straniera nvarchar(80), /*Denominazione del Comune in
lingua italiana e straniera. Per le denominazioni bilingue è previsto l&#39;uso del simbolo
separatore: &quot;/&quot; per i comuni della provincia di Bolzano/Bozen, e &quot;-&quot; per tutti gli
altri.*/
denominazione_comune_italiano nvarchar(50), -- Denominazione solo in lingua italiana del Comune
denominazione_comune_altra_lingua nvarchar(50), -- Denominazione del Comune in lingua diversa dall&#39;italiano
codice_ripartizione_geografica nvarchar(1), /*Codice Istat della Ripartizione
geografica secondo la suddivisione del territorio nazionale in: 1) Nord-ovest, 2) Nord-
est, 3) Centro, 4) Sud e 5) Isole.*/
ripartizione_geografica nvarchar(30), /* Codice Istat della Ripartizione geografica
secondo la suddivisione del territorio nazionale in: 1) Nord-ovest, 2) Nord-est, 3)
Centro, 4) Sud e 5) Isole.*/
denominazione_regione nvarchar(50),
denominazione_unita_territoriale_sovracomunale nvarchar(50), -- nome del capoluogo di regione
tipologia_unita_territoriale_sovracomunale nvarchar(1), /* 1=Provincia; 2=Provincia
autonoma; 3=Città metropolitana; 4=Libero consorzio di comuni; 5=Unità non
amministrativa (ex- province del Friuli-Venezia Giulia)*/
flag_comune_capoluogo_di_provincia_metropolitana_consorzio nvarchar(1), /* 1=Comune
capoluogo; 0=Comune non è capoluogo.*/
sigla_automobilistica nvarchar(2),
codice_comune_formato_numerico int, /*Si ottiene dalla concatenazione del Codice
Provincia (110 province) con Progressivo del comune.*/
codice_comune_numerico_con_110_province_2010_2016 int,
codice_comune_numerico_con_107_province_2006_2009 int,
codice_comune_numerico_con_103_province_1995_2005 int,
codice_catastale_comune nvarchar(4), /* E&#39; un codice composto da quattro caratteri, il
primo dei quali alfabetico e gli altri tre numerici. Il codice è stato assegnato
inizialmente seguendo l&#39;ordinamento alfabetico crescente dell&#39;elenco di tutti i comuni
di Italia, indipedentemente dalla Provincia di appartenenza. Per i comuni di nuova
istituzione viene assegnato il primo codice alfanumerico disponibile.*/
codice_NUTS1_2010 nvarchar(5),
codice_NUTS2_2010 nvarchar(5),
codice_NUTS3_2010 nvarchar(5),
codice_NUTS1_2021 nvarchar(5),
codice_NUTS2_2021 nvarchar(5),
codice_NUTS3_2021 nvarchar(5)
);

CREATE TABLE regione(
id_regione nvarchar(2) PRIMARY KEY, 
nome_regione nvarchar(30) NOT NULL, 
ripartizione_geografica nvarchar(20) NOT NULL
);

CREATE TABLE provincia(
id_provincia nvarchar(3) PRIMARY KEY, 
nome_provincia nvarchar(30) NOT NULL, 
sigla nvarchar(2) NOT NULL
);

CREATE TABLE comune(
id_comune nvarchar(6) PRIMARY KEY, 
nome_comune nvarchar(40) NOT NULL, 
cod_catastale nvarchar(4) NOT NULL
);

CREATE TABLE reg_pro_com(
id_regione nvarchar(2) FOREIGN KEY REFERENCES regione(id_regione),
id_provincia nvarchar(3) FOREIGN KEY REFERENCES provincia(id_provincia),
id_comune nvarchar(6) FOREIGN KEY REFERENCES comune(id_comune),
CONSTRAINT pk_reg_pro_com PRIMARY KEY (id_regione, id_provincia, id_comune)
);

INSERT INTO regione(id_regione, nome_regione, ripartizione_geografica)
SELECT DISTINCT report_comuni.codice_regione, report_comuni.denominazione_regione ,report_comuni.codice_ripartizione_geografica 
FROM report_comuni 
WHERE 1=1;

INSERT INTO provincia(id_provincia, nome_provincia, sigla)
SELECT DISTINCT report_comuni.codice_provincia, report_comuni.denominazione_unita_territoriale_sovracomunale, report_comuni.sigla_automobilistica  
FROM report_comuni 
WHERE 1=1;

INSERT INTO comune(id_comune, nome_comune, cod_catastale)
SELECT DISTINCT report_comuni.codice_comune_formato_alfanumerico, report_comuni.denominazione_comune_italiano, report_comuni.codice_catastale_comune
FROM  report_comuni
WHERE 1=1;

INSERT INTO reg_pro_com(id_regione, id_provincia, id_comune)
SELECT DISTINCT report_comuni.codice_regione, report_comuni.codice_provincia, report_comuni.codice_comune_formato_alfanumerico 
FROM report_comuni 
WHERE 1=1;

SELECT regione.nome_regione, provincia.nome_provincia, comune.nome_comune, report_sale.nome_locale, report_sale.indirizzo  
FROM reg_pro_com
INNER JOIN regione ON reg_pro_com.id_regione = regione.id_regione
INNER JOIN provincia ON reg_pro_com.id_provincia = provincia.id_provincia
INNER JOIN comune ON reg_pro_com.id_comune = comune.id_comune
INNER JOIN report_sale ON report_sale.provincia = provincia.nome_provincia  AND report_sale.comune = comune.nome_comune;

