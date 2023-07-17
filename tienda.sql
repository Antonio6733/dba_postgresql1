CREATE TABLE product (
	id INT,
	product_name VARCHAR (50),
	price FLOAT
)PARTITION BY RANGE (price);

CREATE TABLE product_partition_1 PARTITION OF 
product
FOR VALUES FROM ( '1.00' ) TO ( '3000.00' );

CREATE TABLE product_partition_2 PARTITION OF 
product
FOR VALUES FROM ( '3001.00' ) TO ( '6000.00' );

CREATE TABLE product_partition_3 PARTITION OF 
product
FOR VALUES FROM ( '6001.00' ) TO ( '10000.00' );

ALTER TABLE product_partition_1 
ADD CONSTRAINT partition_1_check 
CHECK (price>= '1.00' AND price<= '3000.00' );

ALTER TABLE product_partition_2 
ADD CONSTRAINT partition_1_check 
CHECK (price>= '3001.00' AND price<= '6000.00' );

ALTER TABLE product_partition_3 
ADD CONSTRAINT partition_1_check 
CHECK (price>= '6001.00' AND price<= '10000.00' );


CREATE TABLE client(
	id_client INT,
	first_name VARCHAR (50),
	last_name VARCHAR (50),
	adreess VARCHAR (50),
	country VARCHAR (50),
	email VARCHAR (50),
	cellphone VARCHAR (30),
	telephone VARCHAR (30),
	job_title VARCHAR (50),
	gender VARCHAR (15),
	college VARCHAR (50)
);

CREATE TABLE client_partition_1(CHECK (gender in ('Female'))) INHERITS (client);
CREATE TABLE client_partition_2(CHECK (gender in ('Male'))) INHERITS (client);

CREATE OR REPLACE RULE insert_client_p1
AS ON INSERT TO client
WHERE (gender = 'Female')
DO INSTEAD 
INSERT INTO client_partition_1 VALUES (NEW.id_client, NEW.first_name, NEW.last_name, NEW.adreess, NEW.country, NEW.email, NEW.cellphone, NEW.telephone, NEW.job_title, NEW.gender, NEW.college);

CREATE OR REPLACE RULE insert_client_p2
AS ON INSERT TO client
WHERE (gender = 'Male')
DO INSTEAD 
INSERT INTO client_partition_2 VALUES (NEW.id_client, NEW.first_name, NEW.last_name, NEW.adreess, NEW.country, NEW.email, NEW.cellphone, NEW.telephone, NEW.job_title, NEW.gender, NEW.college);