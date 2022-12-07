use sandwiches;

/*Classe che ha ordinato di più*/
select c.`year`, c.`section`, count(o.id)
from `user` u 
inner join user_class uc on uc.`user` = u.id 
inner join class c on c.id = uc.class 
inner join `order` o on o.`user` = u.id 
group by c.id 
order by count(o.id) desc;

/*Classe che ha ordinato di più l'anno scorso*/
select c.`year`, c.`section`, count(o.id)
from `user` u 
inner join user_class uc on uc.`user` = u.id 
inner join class c on c.id = uc.class 
inner join `order` o on o.`user` = u.id 
where uc.`year` = '2021'
group by c.id 
order by count(o.id) desc;

/*Stampa tutti i prodotti favoriti della classe 5 F*/
select c.`year`, c.`section`, p.name, count(f.product)
from `user` u 
inner join user_class uc on uc.`user` = u.id 
inner join class c on c.id = uc.class 
inner join favourite f ON f.`user` =  u.id 
inner join product p on p.id = f.product 
where c.`year` = 5 and c.`section` = 'F'
group by p.id 
order by p.name;

/*Stampa tutti i prodotti aventi come allergeni glutine*/
select p.name, a.name  
from product_allergen pa 
inner join allergen a on a.id = pa.allergen 
inner join product p ON p.id = pa.product 
where a.name = 'Glutine';

/*Stampa tutti gli account che hanno una nuova password*/
select distinct u.name, u.surname, r.password 
from `user` u 
inner join reset r ON r.`user` = u.id 
order by u.name;

/*Conta gli account che hanno campiato password*/
select  count(r.id)
from `user` u 
inner join reset r ON r.`user` = u.id;