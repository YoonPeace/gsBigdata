-- Drop table

-- DROP TABLE public.social_data

CREATE TABLE public.social_data (
	date_time timestamp NOT NULL,
	blog numeric(20,4) NOT NULL,
	twitter numeric(20,4) NOT NULL,
	news numeric(20,4) NOT NULL,
	total numeric(20,4) NOT NULL,
	cat varchar NOT NULL
);

-- Permissions

ALTER TABLE public.social_data OWNER TO analytics;
GRANT ALL ON TABLE public.social_data TO analytics;
