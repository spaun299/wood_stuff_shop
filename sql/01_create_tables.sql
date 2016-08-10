CREATE TABLE about_us(description VARCHAR(1000), coordinate_x FLOAT, coordinate_y FLOAT, phone1 VARCHAR(13) NOT NULL , phone2 VARCHAR(13), phone3 VARCHAR(13),
skype VARCHAR(50), facebook VARCHAR(300), vkontakte VARCHAR(300), odnoklasniki VARCHAR(300), email VARCHAR(100));
CREATE TABLE admin(name VARCHAR(100) NOT NULL, password VARCHAR(100) NOT NULL );
CREATE SEQUENCE id_division;
CREATE TABLE division(id INT PRIMARY KEY NOT NULL DEFAULT nextval('id_division') UNIQUE, name VARCHAR(300) NOT NULL UNIQUE, position INT DEFAULT 1);
CREATE SEQUENCE id_subdivision;
CREATE TABLE subdivision(id INT PRIMARY KEY NOT NULL DEFAULT nextval('id_subdivision') UNIQUE, division_id INT NOT NULL REFERENCES division(id),
name VARCHAR(300) NOT NULL UNIQUE,position INT DEFAULT 1);
CREATE SEQUENCE id_product;
CREATE TABLE product(id INT NOT NULL DEFAULT nextval('id_product') UNIQUE, subdivision_id INT NOT NULL REFERENCES subdivision(id),
name VARCHAR(300) NOT NULL UNIQUE, price INT NOT NULL, description VARCHAR(1000) NOT NULL, short_description VARCHAR(250) NOT NULL,
bought_count INT DEFAULT 0,viewed INT DEFAULT 0, sale BOOLEAN DEFAULT FALSE, last_bought TIMESTAMP WITHOUT TIME ZONE, cr_rm TIMESTAMP WITHOUT TIME ZONE,
identifier VARCHAR(50) UNIQUE);
CREATE SEQUENCE id_sale;
CREATE TABLE sale(id INT PRIMARY KEY NOT NULL DEFAULT nextval('id_sale') UNIQUE, product_id INT NOT NULL REFERENCES product(id) UNIQUE,
sale_price INT NOT NULL, date_from TIMESTAMP WITHOUT TIME ZONE, date_to TIMESTAMP WITHOUT TIME ZONE, bought_count INT DEFAULT 0);
CREATE SEQUENCE id_faq;
CREATE TABLE faq(id INT NOT NULL DEFAULT nextval('id_faq'), question VARCHAR(400), answer VARCHAR(1000));
CREATE SEQUENCE id_custumer;
CREATE TABLE custumer(id INT NOT NULL DEFAULT nextval('id_custumer') UNIQUE, name VARCHAR(300) NOT NULL UNIQUE ,
  password VARCHAR(300), registred_via VARCHAR(30) DEFAULT 'site', facebook_id VARCHAR(300), vkontakte_id VARCHAR(300),
  google_id VARCHAR(300), confirmed BOOLEAN DEFAULT FALSE, confirmation_token VARCHAR(200), email VARCHAR(200) UNIQUE NOT NULL,
  mobile_phone VARCHAR(13) , phone VARCHAR(30), town VARCHAR(100), street VARCHAR(200), house_number VARCHAR(20), flat_number VARCHAR(10),
cr_tm TIMESTAMP WITHOUT TIME ZONE NOT NULL , last_tm TIMESTAMP WITHOUT TIME ZONE NOT NULL, bought_count INT DEFAULT 0, money_spent INT DEFAULT 0);
CREATE SEQUENCE id_custumer_product;
CREATE TABLE custumer_product(id INT PRIMARY KEY DEFAULT nextval('id_custumer_product'),
custumer_id INT REFERENCES custumer(id) NOT NULL, product_id INT REFERENCES product(id) NOT NULL,
  amount INT NOT NULL, money_cost INT NOT NULL, cr_tm TIMESTAMP WITHOUT TIME ZONE, price_type VARCHAR(30) DEFAULT 'retail');
