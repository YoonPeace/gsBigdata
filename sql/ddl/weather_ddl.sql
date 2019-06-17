-- Drop table

-- DROP TABLE public.weather

CREATE TABLE public.weather (
	std_date varchar NULL,
	stn_id int4 NULL,
	pvn_nm varchar NULL,
	bor_nm varchar NULL,
	max_temp numeric(20,4) NULL,
	max_ws numeric(20,4) NULL,
	min_temp numeric(20,4) NULL,
	avg_temp numeric(20,4) NULL,
	avg_rhm numeric(20,4) NULL,
	avg_wa numeric(20,4) NULL,
	sum_rm numeric(20,4) NULL
);

-- Permissions

ALTER TABLE public.weather OWNER TO analytics;
GRANT ALL ON TABLE public.weather TO analytics;
