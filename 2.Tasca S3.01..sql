
#Nivell 1
-- Exercici 1
use transactions;
create table if not exists credit_card (
id varchar(15) primary key,
iban varchar(34),
pan varchar(20),
pin varchar(6),
cvv varchar(4),
expiring_date varchar(10)
);

alter table transaction
add constraint fk_credit_card
foreign key (credit_card_id) references credit_card(id);

#Nivell 1
-- Exercici 2
update credit_card
set iban = 'R323456312213576817699999'
where id = 'CcU-2938';
-- verification
select * from credit_card where id = 'CcU-2938';

#Nivell 1
-- Exercici 3
select * from company where id = 'b-9999'; # verificacion de existencia 
select * from credit_card where id = 'CcU-9999';  # verificacion de existencia
insert into company (id, company_name, phone, email, country, website)
values ('b-9999', 'Empresa Italo', '0000000000', 'empresaitalo@egmail.com', 'Germany', 'www.empresaitalo.com');
insert into credit_card (id, iban, pan, pin, cvv, expiring_date)
values ('CcU-9999', 'IBANFICTICIO9999', '1234567890123456', '1234', '999', '12/31/30');
insert into transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined)
values ('108B1D1D-5B23-A76C-55EF-C568E49A99DD','CcU-9999','b-9999', 9999, 829.999, -117.999, 111.11, 0);
select * from transaction where id = '108B1D1D-5B23-A76C-55EF-C568E49A99DD'; # verificacion 

#Nivell 1
-- Exercici 4
alter table credit_card
drop column pan;
describe credit_card;

##Nivell 2
-- Exercici 1
select * from transaction where id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';
delete from transaction where id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';
select * from transaction where id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

##Nivell 2
-- Exercici 2
create or replace view VistaMarketing as
select company.company_name, company.phone,company.country, avg(transaction.amount) as avg_transactions
from company
join transaction on company.id = transaction.company_id
group by company.company_name, company.phone,company.country
order by avg_transactions desc;
select * from VistaMarketing;

##Nivell 2
-- Exercici 3
select company_name from VistaMarketing
where country = 'Germany';

###Nivell 3
-- Exercici 1
  -- Creamos la tabla user

CREATE INDEX idx_user_id ON transaction(user_id);

CREATE TABLE IF NOT EXISTS user (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        surname VARCHAR(100),
        phone VARCHAR(150),
        email VARCHAR(150),
        birth_date VARCHAR(100),
        country VARCHAR(150),
        city VARCHAR(150),
        postal_code VARCHAR(100),
        address VARCHAR(255)
        );
select user_id from transaction
where user_id not in ( select id from user);
select * from transaction
where user_id = '9999';
insert into user (id)
VALUES (9999);
alter table transaction
add constraint fk_trasaction_user
foreign key (user_id) references user(id);
alter table company drop column website;
rename table user to data_user;
alter table data_user change email personal_email varchar(150);
alter table credit_card
modify id varchar(20),
modify iban varchar(50),
modify pin varchar(4),
modify cvv int,
modify expiring_date varchar(20);
alter table credit_card
add column fecha_actual date;

###Nivell 3
-- Exercici 2
create or replace view InformeTecnico as
select 
transaction.id as id_transaccion, 
data_user.name as nombre_usuario, 
data_user.surname as apellido_usuario, 
credit_card.iban as iban_tarjeta,
data_user.country as pais_usuario,
 company.company_name as nombre_compania,
company.country as pais_compania,
transaction.amount as monto,
transaction.timestamp as fecha,
transaction.declined as declinada
from transaction
join data_user on transaction.user_id = data_user.id
join credit_card on transaction.credit_card_id = credit_card.id
join company on transaction.company_id = company.id
order by id_transaccion desc;
select * from InformeTecnico;


















