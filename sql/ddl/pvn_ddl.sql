-- Drop table

-- DROP TABLE public.pvn

CREATE TABLE public.pvn (
	pvn_nm varchar NOT NULL,
	bor_nm varchar NOT NULL,
	area varchar NOT NULL
);

-- Permissions

ALTER TABLE public.pvn OWNER TO analytics;
GRANT ALL ON TABLE public.pvn TO analytics;
