CREATE DATABASE sandwiches;

CREATE  TABLE sandwiches.allergen ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(64)  NOT NULL     
 );

CREATE  TABLE sandwiches.break ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	`time`               TIME  NOT NULL     
 );

CREATE  TABLE sandwiches.class ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	year                 INT UNSIGNED NOT NULL,
	section              VARCHAR(1)  NOT NULL     
 );

CREATE  TABLE sandwiches.ingredient ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(64)  NOT NULL,
	description          VARCHAR(128),
	price                DECIMAL(4,2) UNSIGNED,
	extra                BOOLEAN NOT NULL DEFAULT (FALSE),
	quantity             INT UNSIGNED NOT NULL
 );

CREATE  TABLE sandwiches.product_allergen ( 
	product              INT UNSIGNED NOT NULL,
	allergen             INT UNSIGNED NOT NULL
 );

CREATE  TABLE sandwiches.pickup ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(128)  NOT NULL     
 );

CREATE  TABLE sandwiches.pickup_break ( 
	pickup               INT UNSIGNED NOT NULL,
	break                INT UNSIGNED NOT NULL     
 );

CREATE  TABLE sandwiches.product ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(64)  NOT NULL,
	price                DECIMAL(4,2) UNSIGNED NOT NULL,
	description          VARCHAR(128),
	quantity             INT  NOT NULL,
	nutritional_value    INT UNSIGNED NOT NULL,
	active               BOOLEAN  NOT NULL DEFAULT (TRUE)   
 );

CREATE  TABLE sandwiches.nutritional_value ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	kcal                 INT NOT NULL,
	fats                 DECIMAL(4,2) NOT NULL,
	saturated_fats       DECIMAL(4,2),
	carbohydrates        DECIMAL(4,2) NOT NULL,
	sugars               DECIMAL(4,2),
	proteins             DECIMAL(4,2) NOT NULL,
	fiber                DECIMAL(4,2),
	salt                 DECIMAL(4,2)
 );

CREATE  TABLE sandwiches.product_ingredient ( 
	product              INT UNSIGNED NOT NULL,
	ingredient           INT UNSIGNED NOT NULL     
 );

CREATE  TABLE sandwiches.`status` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	description          VARCHAR(64)  NOT NULL     
 );

CREATE  TABLE sandwiches.tag ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(32)  NOT NULL     
 );

CREATE  TABLE sandwiches.`user` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(64)  NOT NULL,
	surname              VARCHAR(64)  NOT NULL,
	email                VARCHAR(128)  NOT NULL,
	password             VARCHAR(128)  NOT NULL,
	active               BOOLEAN  NOT NULL DEFAULT (TRUE)    
 );

 CREATE  TABLE sandwiches.user_class (
	user                 INT UNSIGNED NOT NULL,
	class                INT UNSIGNED NOT NULL,
	`year`               YEAR NOT NULL
 );

CREATE  TABLE sandwiches.cart ( 
	`user`               INT UNSIGNED NOT NULL,
	product              INT UNSIGNED NOT NULL,
	quantity             INT UNSIGNED
 );

CREATE  TABLE sandwiches.favourite ( 
	user                 INT UNSIGNED NOT NULL,
	product              INT UNSIGNED NOT NULL,
	created              TIMESTAMP   DEFAULT (CURRENT_TIMESTAMP)    
 );

CREATE  TABLE sandwiches.offer ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	price                DECIMAL(4,2) UNSIGNED NOT NULL,
	`start`              TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP)  NOT NULL,
	expiry               TIMESTAMP  DEFAULT (CURRENT_TIMESTAMP + 604800)  NOT NULL,
	description          VARCHAR(128)       
 );

CREATE  TABLE sandwiches.product_offer ( 
	product              INT UNSIGNED NOT NULL,
	offer                INT UNSIGNED NOT NULL  
 );

CREATE  TABLE sandwiches.`order` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	`user`               INT UNSIGNED NOT NULL,
	created              TIMESTAMP  NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	pickup               INT UNSIGNED NOT NULL,
	break                INT UNSIGNED NOT NULL,
	`status`             INT UNSIGNED NOT NULL,
	json                 LONGTEXT
 );

CREATE  TABLE sandwiches.product_order ( 
	product              INT UNSIGNED NOT NULL,
	`order`              INT UNSIGNED NOT NULL
 );

CREATE  TABLE sandwiches.product_tag ( 
	product              INT UNSIGNED NOT NULL,
	tag                  INT UNSIGNED NOT NULL    
 );

CREATE  TABLE sandwiches.reset ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	`user`               INT UNSIGNED NOT NULL,
	password             VARCHAR(128)  NOT NULL,
	requested            TIMESTAMP  NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	expires              TIMESTAMP  NOT NULL DEFAULT (CURRENT_TIMESTAMP + 21600),
	completed            BOOLEAN  NOT NULL DEFAULT (FALSE)
 );

ALTER TABLE sandwiches.cart ADD CONSTRAINT fk_cart_product FOREIGN KEY ( product ) REFERENCES sandwiches.product ( id );

ALTER TABLE sandwiches.cart ADD CONSTRAINT fk_cart_user FOREIGN KEY ( `user` ) REFERENCES sandwiches.`user` ( id );

ALTER TABLE sandwiches.product_allergen ADD CONSTRAINT fk_product_allergen_product FOREIGN KEY ( product ) REFERENCES sandwiches.product ( id );

ALTER TABLE sandwiches.product_allergen ADD CONSTRAINT fk_product_allergen_allergen FOREIGN KEY ( allergen ) REFERENCES sandwiches.allergen ( id );

ALTER TABLE sandwiches.pickup_break ADD CONSTRAINT fk_pickup_break_pickup FOREIGN KEY ( pickup ) REFERENCES sandwiches.pickup ( id );

ALTER TABLE sandwiches.pickup_break ADD CONSTRAINT fk_pickup_break_break FOREIGN KEY ( `break` ) REFERENCES sandwiches.`break` ( id );

ALTER TABLE sandwiches.product_ingredient ADD CONSTRAINT fk_product_ingredient_product FOREIGN KEY ( product ) REFERENCES sandwiches.product ( id );

ALTER TABLE sandwiches.product_ingredient ADD CONSTRAINT fk_product_ingredient_ingredient FOREIGN KEY ( ingredient ) REFERENCES sandwiches.ingredient ( id );

ALTER TABLE sandwiches.favourite ADD CONSTRAINT fk_favourite_user FOREIGN KEY ( `user` ) REFERENCES sandwiches.`user` ( id );

ALTER TABLE sandwiches.favourite ADD CONSTRAINT fk_favourite_product FOREIGN KEY ( product ) REFERENCES sandwiches.product ( id );

ALTER TABLE sandwiches.product_tag  ADD CONSTRAINT fk_product_tag_product FOREIGN KEY ( product ) REFERENCES sandwiches.product ( id );

ALTER TABLE sandwiches.product_tag  ADD CONSTRAINT fk_product_tag_tag FOREIGN KEY ( tag ) REFERENCES sandwiches.tag ( id );

ALTER TABLE sandwiches.product_order  ADD CONSTRAINT fk_product_order_product FOREIGN KEY ( product ) REFERENCES sandwiches.product ( id );

ALTER TABLE sandwiches.product_order  ADD CONSTRAINT fk_product_order_order FOREIGN KEY ( `order` ) REFERENCES sandwiches.`order` ( id );

ALTER TABLE sandwiches.reset  ADD CONSTRAINT fk_reset_user FOREIGN KEY ( `user` ) REFERENCES sandwiches.`user` ( id );

ALTER TABLE sandwiches.`order`  ADD CONSTRAINT fk_order_user FOREIGN KEY ( `user` ) REFERENCES sandwiches.`user` ( id );

ALTER TABLE sandwiches.`order`  ADD CONSTRAINT fk_order_status FOREIGN KEY ( status ) REFERENCES sandwiches.status ( id );

ALTER TABLE sandwiches.`order`  ADD CONSTRAINT fk_order_pickup FOREIGN KEY ( pickup ) REFERENCES sandwiches.pickup ( id );

ALTER TABLE sandwiches.`order`  ADD CONSTRAINT fk_order_break FOREIGN KEY ( break ) REFERENCES sandwiches.break ( id );

ALTER TABLE sandwiches.product  ADD CONSTRAINT fk_product_nutritional_value FOREIGN KEY ( nutritional_value ) REFERENCES sandwiches.nutritional_value ( id );

ALTER TABLE sandwiches.user_class  ADD CONSTRAINT fk_user_class_user FOREIGN KEY ( `user` ) REFERENCES sandwiches.`user` ( id );

ALTER TABLE sandwiches.user_class  ADD CONSTRAINT fk_user_class_class FOREIGN KEY ( class ) REFERENCES sandwiches.class ( id );

ALTER TABLE sandwiches.product_offer ADD CONSTRAINT fk_product_offer_product FOREIGN KEY ( product ) REFERENCES sandwiches.product ( id );

ALTER TABLE sandwiches.product_offer  ADD CONSTRAINT fk_product_offer_offer FOREIGN KEY ( offer ) REFERENCES sandwiches.offer ( id );



/*QUERYYYY*/
/*get prodotti nel carrello...*/
use sandwiches;

select p.id, p.name, p.price, c.quantity
from cart c
inner join product p on c.product = p.id 
inner join `user` u on u.id = c.`user`  
where u.id = '1'
order by p.id;

/*Get product aventi allergia glutine*/
select p.name, a.name, p.quantity
from product p 
inner join product_allergen pa on p.id = pa.product 
inner join allergen a on a.id = pa.allergen
order by p.name;

/*Get tabella nutrizionale e allergeni di un prodotto*/
select p.name, nv.kcal , nv.fats, nv.saturated_fats, nv.carbohydrates, nv.sugars, nv.proteins, nv.fiber, nv.salt, a.name
from product p 
inner join product_allergen pa on p.id = pa.product 
inner join allergen a on a.id = pa.allergen
inner join nutritional_value nv on nv.id = p.id
order by p.name;

/*somma tutti i prodotti che hai nel carrello*/
select u.name, u.surname, sum(c.quantity) as 'quantità_prodotti_carrello' 
from cart c 
inner join `user` u ON u.id = c.`user`
group by u.id  
order by sum(c.quantity);

/*somma dei prodotti che il paninaro ha nel magazzino*/
select p.name, sum(p.quantity)
from product p 
group by p.id 
order by sum(p.quantity);

/*Stampa il numero di ordini che ha fatto ogni utente*/
select u.name, u.surname, sum(o.id) as 'numero_ordini_eseguiti' 
from `user` u 
inner join `order` o on o.`user` = u.id
group by o.`user` 
order by u.name, u.surname;

/*Stampa se l'ordine effettuato è stato o meno ritirato*/
select u.email, p.name, b.`time`, s.description 
from `user` u 
inner join `order` o ON o.`user` = u.id 
inner join break b on b.id = o.break 
inner join pickup_break pb on pb.break = b.id 
inner join pickup p on p.id = o.pickup and p.id = pb.pickup
inner join status s on s.id = o.id 
order by u.email; 

/*prodotti ordinati dall'utente + calcolo prezzo totale*/
select u.email, p.name, sum(c.quantity) as 'quantità prodotti', sum(c.quantity * p.price) as 'total_price'
from `user` u
inner join `order` o on o.`user` = u.id 
inner join product_order po on po.`order` = o.id 
inner join product p on p.id = po.product 
inner join cart c on c.product = p.id and c.`user` = u.id
group by o.id 
order by sum(c.quantity*p.price) desc;

/*Seleziona tutti gli ingredienti interni ad un prodotto*/
select p.name, i.name, i.quantity 
from product p 
inner join product_ingredient pi2 on p.id = pi2.product 
inner join ingredient i on i.id = pi2.ingredient  
order by p.name;

/*Somma tutti gli ingredienti che hai nel magazzino*/
select sum(i.quantity) as 'quantità totale di ingredienti nel magazzino'
from ingredient i;

/*Seleziona tutti le offerte*/
select p.name, o.price, o.`start`, o.expiry
from product p 
inner join product_offer po on po.product = p.id 
inner join offer o on o.id = po.offer
order by o.`start`;

/*conta tutti i prodotti appartenenti ad un certo tag*/
select t.name, count(p.id) as 'numero di prodotti di quella categoria' 
from product p 
inner join product_tag pt on pt.product = p.id 
inner join tag t on t.id = pt.tag 
group by t.id 
order by t.name 

/*Seleziona i prodotti preferiti di un utente*/
select u.email, p.name
from `user` u 
inner join favourite f on f.`user` = u.id 
inner join product p on p.id = f.product
order by u.email 

/*conta tutti gli utenti appartenenti ad una determinata classe*/
select c.`year`, c.`section`, count(u.id) as 'numero utenti di quella classe'
from `user` u 
inner join user_class uc on uc.`user` = u.id 
inner join class c on uc.class = c.id 
group by c.id 
order by c.`year`;

/*Prodotto più ordinato*/
select p.id ,p.name, sum(c.quantity) as 'prodotto piu venduto', c.quantity * p.price as 'totale guadagno da prodotto'
from `order` o 
inner join product_order po on po.order = o.id 
inner join product p on p.id = po.product 
inner join cart c on  c.product = p.id 
group by p.id 
order by sum(c.quantity) desc;

/*Utente che ha effettuato più ordini*/
select u.name, u.surname, count(o.id) as 'numero_ordini'
from `user` u 
inner join `order` o on o.`user` = u.id
group by u.id 
order by count(o.id) desc; 

/*Utente che ha speso di piu*/
select u.name, u.surname, sum(c.quantity * p.price) as 'totale_spesa'
from `user` u 
inner join cart c ON c.`user` = u.id 
inner join `order` o on o.`user` = u.id 
inner join product p on p.id = c.product  
group by u.id
order by u.surname;

/*conta le classi*/
select count(c.id) as 'Totale delle classi' 
from class c;

/*Visualizzare il tag e gli allergeni di un prodotto*/
select p.name, p.quantity, a.name, t.name
from product p 
inner join product_tag pt on pt.product = p.id 
inner join tag t on t.id = pt.tag 
inner join product_allergen pa on pa.product = p.id 
inner join allergen a on a.id = pa.allergen 
order by p.name 

/*la quantita di ordini effettuati su un prodotto*/
select p.name, p.description, count(u.id) as 'ordinato da quanti utenti?' 
from product p 
left join product_order po on po.product = p.id 
left  join `order` o on o.id = po.`order` 
left join `user` u on u.id = o.`user`
group by p.id 
order by count(u.id); 

/*mostra tutti gli ingredienti che hai in magazzino*/
select * from ingredient i;

/*Contare gli ordini validi effettuati dall'utente*/
select u.name, u.surname, count(o.id) as 'Numero ordini'
from `order` o 
left join `user` u on u.id = o.`user`
left join status s on s.id = o.status 
where o.status = 1
group by u.id
order by u.email;

/*Panini più venduti alla classe 5F*/
select c.`year`, c.`section`,p.id , p.name, sum(c2.quantity)
from class c
left join user_class uc on uc.class = c.id 
left join `user` u on u.id = uc.`user` 
left join `order` o on o.`user` = u.id
left join cart c2 on c2.`user` = u.id
left join product p on p.id = c2.product 
where c.`year` = '5' and c.`section` = 'F'
group by p.id 
order by sum(c2.quantity) desc ;

/*Ingrediente piu usato nei prodotti*/
select i.name, i.description, count(p.id) as 'Numero di prodotti aventi ingrediente esaminato'
from product p 
left join product_ingredient pi2 ON pi2.product = p.id 
inner join ingredient i on i.id = pi2.ingredient 
group by i.id 
order by count(p.id) desc;

/*Prodotto piu venduto in assoluto*/
select p.id, p.name, p.description, sum(c.quantity)
from product p 
inner join cart c on c.product = p.id 
inner join `user` u on u.id = c.`user` 
inner  join `order` o on o.`user` = u.id
group by c.`user` 
order by sum(c.quantity) desc ; 

/*quale è il prodotto preferito da piu utenti*/
select p.name, count(f.product) as 'Numero di utenti che hanno inserito questo prodotto come preferito' 
from product p 
left join favourite f on f.product = p.id 
group by p.id 
order by count(f.product);

/*Seleziona tutti i prodotti che hanno meno di 100calorie*/
select p.name, max(nv.kcal) 
from product p 
left join nutritional_value nv on nv.id = p.id 
where nv.kcal < 100
group by p.id 

/*Conta quanti sono i prodotti in offerta*/
select count(p.id) as 'prodotti in offerta'
from product p
inner join product_offer po ON po.product = p.id 
inner join offer o on o.id = po.offer;

/*conta quante offerte di ogni tipo sono in atto*/
select o.id, count(p.id) as 'prodotti in offerta con questo sconto'
from product p
inner join product_offer po ON po.product = p.id 
inner join offer o on o.id = po.offer
group by o.id ;

/*Lista utenti classe e id ordine che vengono ritirati in settore A*/
select u.name, u.surname, c.`year`, c.`section` , o.id, p.name, b.`time` 
from class c 
inner join user_class uc on uc.class = c.id 
inner join `user` u on u.id = uc.`user` 
inner join `order` o on o.`user` = u.id 
inner join pickup p on p.id = o.pickup
inner join break b on b.id = o.break 
order by b.`time`;

/*quantita di prodotti ordinati da un utente*/
select u.name, u.surname, sum(c.quantity)
from `user` u
left join cart c on c.`user` = u.id 
left join product p on p.id = c.product 
group by u.id 
order by sum(c.quantity) desc;

/*Calcola il prezzo del carrello*/
select distinct c.`user` ,  sum(c.quantity * p.price)
from product p 
inner join cart c on c.product = p.id
group by c.`user` 
order by c.`user`;





