
CREATE TABLE sales_data(
	std_date timestamp NOT NULL,
	pvn_nm varchar NOT null,
	bor_nm varchar NOT null,
	gen_cd varchar NOT null,
	agegr_20 numeric(1) NOT NULL,
	age_cd varchar NOT null,
	cat varchar NOT null,
	channel varchar NOT null,
	qty  numeric(20,4) NOT NULL
);
