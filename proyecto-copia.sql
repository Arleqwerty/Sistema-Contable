--
-- PostgreSQL database dump
--

\restrict y3Dui6E15VFBPwNxBg1wlr4OvMOHF5MKSs5lCeAqs3Dr9CFksOGAgZKaUG4Y3rU

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-12-19 00:02:11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 225 (class 1259 OID 49734)
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 49744)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 49785)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 49784)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 230
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 229 (class 1259 OID 49770)
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 49755)
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 49754)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 235 (class 1259 OID 49834)
-- Name: libro_diarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.libro_diarios (
    id bigint NOT NULL,
    fecha date NOT NULL,
    descripcion character varying(255) NOT NULL,
    numero_asiento integer NOT NULL,
    codigo_cuenta character varying(20) NOT NULL,
    nombre_cuenta character varying(100) NOT NULL,
    debe numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    haber numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    estado boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.libro_diarios OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 49833)
-- Name: libro_diarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.libro_diarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.libro_diarios_id_seq OWNER TO postgres;

--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 234
-- Name: libro_diarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.libro_diarios_id_seq OWNED BY public.libro_diarios.id;


--
-- TOC entry 233 (class 1259 OID 49804)
-- Name: libros_diarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.libros_diarios (
    id bigint NOT NULL,
    asiento character varying(255) NOT NULL,
    fecha date NOT NULL,
    definicion character varying(255) NOT NULL,
    cuenta character varying(255) NOT NULL,
    debe numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    haber numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT libros_diarios_definicion_check CHECK (((definicion)::text = ANY ((ARRAY['Activo'::character varying, 'Pasivo'::character varying, 'Patrimonio'::character varying])::text[])))
);


ALTER TABLE public.libros_diarios OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 49803)
-- Name: libros_diarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.libros_diarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.libros_diarios_id_seq OWNER TO postgres;

--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 232
-- Name: libros_diarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.libros_diarios_id_seq OWNED BY public.libros_diarios.id;


--
-- TOC entry 220 (class 1259 OID 49689)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 49688)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 219
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 223 (class 1259 OID 49713)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 49859)
-- Name: plan_de_cuentas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plan_de_cuentas (
    id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    nombre character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    nivel integer DEFAULT 1 NOT NULL,
    parent_id bigint,
    es_imputable boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT plan_de_cuentas_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['activo'::character varying, 'pasivo'::character varying, 'patrimonio'::character varying, 'ingreso'::character varying, 'gasto'::character varying, 'costo'::character varying])::text[])))
);


ALTER TABLE public.plan_de_cuentas OWNER TO postgres;

--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN plan_de_cuentas.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plan_de_cuentas.tipo IS 'Tipo de cuenta';


--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN plan_de_cuentas.es_imputable; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plan_de_cuentas.es_imputable IS 'Si se pueden registrar asientos en esta cuenta';


--
-- TOC entry 236 (class 1259 OID 49858)
-- Name: plan_de_cuentas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plan_de_cuentas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plan_de_cuentas_id_seq OWNER TO postgres;

--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 236
-- Name: plan_de_cuentas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plan_de_cuentas_id_seq OWNED BY public.plan_de_cuentas.id;


--
-- TOC entry 224 (class 1259 OID 49722)
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 49699)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    role character varying(255) DEFAULT 'user'::character varying NOT NULL,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'user'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 49698)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4809 (class 2604 OID 49788)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 4808 (class 2604 OID 49758)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 4815 (class 2604 OID 49837)
-- Name: libro_diarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro_diarios ALTER COLUMN id SET DEFAULT nextval('public.libro_diarios_id_seq'::regclass);


--
-- TOC entry 4811 (class 2604 OID 49807)
-- Name: libros_diarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libros_diarios ALTER COLUMN id SET DEFAULT nextval('public.libros_diarios_id_seq'::regclass);


--
-- TOC entry 4805 (class 2604 OID 49692)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4819 (class 2604 OID 49862)
-- Name: plan_de_cuentas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan_de_cuentas ALTER COLUMN id SET DEFAULT nextval('public.plan_de_cuentas_id_seq'::regclass);


--
-- TOC entry 4806 (class 2604 OID 49702)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5019 (class 0 OID 49734)
-- Dependencies: 225
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6:timer	i:1766116400;	1766116400
laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6	i:2;	1766116400
\.


--
-- TOC entry 5020 (class 0 OID 49744)
-- Dependencies: 226
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 5025 (class 0 OID 49785)
-- Dependencies: 231
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 5023 (class 0 OID 49770)
-- Dependencies: 229
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 5022 (class 0 OID 49755)
-- Dependencies: 228
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- TOC entry 5029 (class 0 OID 49834)
-- Dependencies: 235
-- Data for Name: libro_diarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.libro_diarios (id, fecha, descripcion, numero_asiento, codigo_cuenta, nombre_cuenta, debe, haber, estado, created_at, updated_at) FROM stdin;
1	2025-10-19	Pago luz y agua Fact. 441	1	5.1.1.04	Servicios Básicos (Luz, Agua)	498.54	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
2	2025-10-19	Pago luz y agua Fact. 441	1	1.1.2.02	Crédito Fiscal IVA	74.49	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
3	2025-10-19	Pago luz y agua Fact. 441	1	1.1.1.01	Caja Moneda Nacional	0.00	573.03	t	2025-12-19 03:40:05	2025-12-19 03:40:05
4	2025-09-27	Por venta de servicios Fact. Nro 1514	2	1.1.1.01	Caja Moneda Nacional	11605.67	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
5	2025-09-27	Por venta de servicios Fact. Nro 1514	2	5.1.1.02	Impuesto a las Transacciones (IT)	348.17	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
6	2025-09-27	Por venta de servicios Fact. Nro 1514	2	4.1.1.01	Venta de Servicios	0.00	10096.93	t	2025-12-19 03:40:05	2025-12-19 03:40:05
7	2025-09-27	Por venta de servicios Fact. Nro 1514	2	2.1.2.01	Débito Fiscal IVA	0.00	1508.74	t	2025-12-19 03:40:05	2025-12-19 03:40:05
8	2025-09-27	Por venta de servicios Fact. Nro 1514	2	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	348.17	t	2025-12-19 03:40:05	2025-12-19 03:40:05
9	2025-11-22	Por venta de servicios Fact. Nro 3254	3	1.1.1.01	Caja Moneda Nacional	9455.74	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
10	2025-11-22	Por venta de servicios Fact. Nro 3254	3	5.1.1.02	Impuesto a las Transacciones (IT)	283.67	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
11	2025-11-22	Por venta de servicios Fact. Nro 3254	3	4.1.1.01	Venta de Servicios	0.00	8226.49	t	2025-12-19 03:40:05	2025-12-19 03:40:05
12	2025-11-22	Por venta de servicios Fact. Nro 3254	3	2.1.2.01	Débito Fiscal IVA	0.00	1229.25	t	2025-12-19 03:40:05	2025-12-19 03:40:05
13	2025-11-22	Por venta de servicios Fact. Nro 3254	3	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	283.67	t	2025-12-19 03:40:05	2025-12-19 03:40:05
14	2025-09-20	Por venta de servicios Fact. Nro 4404	4	1.1.1.01	Caja Moneda Nacional	8494.07	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
15	2025-09-20	Por venta de servicios Fact. Nro 4404	4	5.1.1.02	Impuesto a las Transacciones (IT)	254.82	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
16	2025-09-20	Por venta de servicios Fact. Nro 4404	4	4.1.1.01	Venta de Servicios	0.00	7389.84	t	2025-12-19 03:40:05	2025-12-19 03:40:05
17	2025-09-20	Por venta de servicios Fact. Nro 4404	4	2.1.2.01	Débito Fiscal IVA	0.00	1104.23	t	2025-12-19 03:40:05	2025-12-19 03:40:05
18	2025-09-20	Por venta de servicios Fact. Nro 4404	4	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	254.82	t	2025-12-19 03:40:05	2025-12-19 03:40:05
19	2025-10-01	Por venta de servicios Fact. Nro 2781	5	1.1.1.01	Caja Moneda Nacional	13827.07	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
20	2025-10-01	Por venta de servicios Fact. Nro 2781	5	5.1.1.02	Impuesto a las Transacciones (IT)	414.81	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
21	2025-10-01	Por venta de servicios Fact. Nro 2781	5	4.1.1.01	Venta de Servicios	0.00	12029.55	t	2025-12-19 03:40:05	2025-12-19 03:40:05
22	2025-10-01	Por venta de servicios Fact. Nro 2781	5	2.1.2.01	Débito Fiscal IVA	0.00	1797.52	t	2025-12-19 03:40:05	2025-12-19 03:40:05
23	2025-10-01	Por venta de servicios Fact. Nro 2781	5	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	414.81	t	2025-12-19 03:40:05	2025-12-19 03:40:05
24	2025-09-27	Por venta de servicios Fact. Nro 7204	6	1.1.1.01	Caja Moneda Nacional	7315.99	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
25	2025-09-27	Por venta de servicios Fact. Nro 7204	6	5.1.1.02	Impuesto a las Transacciones (IT)	219.48	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
26	2025-09-27	Por venta de servicios Fact. Nro 7204	6	4.1.1.01	Venta de Servicios	0.00	6364.91	t	2025-12-19 03:40:05	2025-12-19 03:40:05
27	2025-09-27	Por venta de servicios Fact. Nro 7204	6	2.1.2.01	Débito Fiscal IVA	0.00	951.08	t	2025-12-19 03:40:05	2025-12-19 03:40:05
28	2025-09-27	Por venta de servicios Fact. Nro 7204	6	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	219.48	t	2025-12-19 03:40:05	2025-12-19 03:40:05
29	2025-10-05	Por venta de servicios Fact. Nro 6780	7	1.1.1.01	Caja Moneda Nacional	12823.90	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
30	2025-10-05	Por venta de servicios Fact. Nro 6780	7	5.1.1.02	Impuesto a las Transacciones (IT)	384.72	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
31	2025-10-05	Por venta de servicios Fact. Nro 6780	7	4.1.1.01	Venta de Servicios	0.00	11156.79	t	2025-12-19 03:40:05	2025-12-19 03:40:05
32	2025-10-05	Por venta de servicios Fact. Nro 6780	7	2.1.2.01	Débito Fiscal IVA	0.00	1667.11	t	2025-12-19 03:40:05	2025-12-19 03:40:05
33	2025-10-05	Por venta de servicios Fact. Nro 6780	7	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	384.72	t	2025-12-19 03:40:05	2025-12-19 03:40:05
34	2025-11-10	Compra de activo fijo según factura	8	1.2.1.02	Equipos de Computación	4697.14	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
35	2025-11-10	Compra de activo fijo según factura	8	1.1.2.02	Crédito Fiscal IVA	701.87	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
36	2025-11-10	Compra de activo fijo según factura	8	1.1.1.02	Banco Moneda Nacional	0.00	5399.01	t	2025-12-19 03:40:05	2025-12-19 03:40:05
37	2025-09-25	Por venta de servicios Fact. Nro 1739	9	1.1.1.01	Caja Moneda Nacional	14623.45	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
38	2025-09-25	Por venta de servicios Fact. Nro 1739	9	5.1.1.02	Impuesto a las Transacciones (IT)	438.70	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
39	2025-09-25	Por venta de servicios Fact. Nro 1739	9	4.1.1.01	Venta de Servicios	0.00	12722.40	t	2025-12-19 03:40:05	2025-12-19 03:40:05
40	2025-09-25	Por venta de servicios Fact. Nro 1739	9	2.1.2.01	Débito Fiscal IVA	0.00	1901.05	t	2025-12-19 03:40:05	2025-12-19 03:40:05
41	2025-09-25	Por venta de servicios Fact. Nro 1739	9	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	438.70	t	2025-12-19 03:40:05	2025-12-19 03:40:05
42	2025-12-04	Compra material escritorio Fact. 498	10	5.1.1.05	Material de Escritorio	611.51	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
43	2025-12-04	Compra material escritorio Fact. 498	10	1.1.2.02	Crédito Fiscal IVA	91.37	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
44	2025-12-04	Compra material escritorio Fact. 498	10	1.1.1.01	Caja Moneda Nacional	0.00	702.88	t	2025-12-19 03:40:05	2025-12-19 03:40:05
45	2025-11-28	Por venta de servicios Fact. Nro 7356	11	1.1.1.01	Caja Moneda Nacional	3836.68	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
46	2025-11-28	Por venta de servicios Fact. Nro 7356	11	5.1.1.02	Impuesto a las Transacciones (IT)	115.10	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
47	2025-11-28	Por venta de servicios Fact. Nro 7356	11	4.1.1.01	Venta de Servicios	0.00	3337.91	t	2025-12-19 03:40:05	2025-12-19 03:40:05
48	2025-11-28	Por venta de servicios Fact. Nro 7356	11	2.1.2.01	Débito Fiscal IVA	0.00	498.77	t	2025-12-19 03:40:05	2025-12-19 03:40:05
49	2025-11-28	Por venta de servicios Fact. Nro 7356	11	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	115.10	t	2025-12-19 03:40:05	2025-12-19 03:40:05
50	2025-10-31	Por venta de servicios Fact. Nro 7918	12	1.1.1.01	Caja Moneda Nacional	11840.13	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
51	2025-10-31	Por venta de servicios Fact. Nro 7918	12	5.1.1.02	Impuesto a las Transacciones (IT)	355.20	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
52	2025-10-31	Por venta de servicios Fact. Nro 7918	12	4.1.1.01	Venta de Servicios	0.00	10300.91	t	2025-12-19 03:40:05	2025-12-19 03:40:05
53	2025-10-31	Por venta de servicios Fact. Nro 7918	12	2.1.2.01	Débito Fiscal IVA	0.00	1539.22	t	2025-12-19 03:40:05	2025-12-19 03:40:05
54	2025-10-31	Por venta de servicios Fact. Nro 7918	12	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	355.20	t	2025-12-19 03:40:05	2025-12-19 03:40:05
55	2025-10-23	Por venta de servicios Fact. Nro 5413	13	1.1.1.01	Caja Moneda Nacional	11457.65	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
56	2025-10-23	Por venta de servicios Fact. Nro 5413	13	5.1.1.02	Impuesto a las Transacciones (IT)	343.73	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
57	2025-10-23	Por venta de servicios Fact. Nro 5413	13	4.1.1.01	Venta de Servicios	0.00	9968.16	t	2025-12-19 03:40:05	2025-12-19 03:40:05
58	2025-10-23	Por venta de servicios Fact. Nro 5413	13	2.1.2.01	Débito Fiscal IVA	0.00	1489.49	t	2025-12-19 03:40:05	2025-12-19 03:40:05
59	2025-10-23	Por venta de servicios Fact. Nro 5413	13	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	343.73	t	2025-12-19 03:40:05	2025-12-19 03:40:05
60	2025-11-07	Compra de activo fijo según factura	14	1.2.1.02	Equipos de Computación	7324.50	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
61	2025-11-07	Compra de activo fijo según factura	14	1.1.2.02	Crédito Fiscal IVA	1094.46	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
62	2025-11-07	Compra de activo fijo según factura	14	1.1.1.02	Banco Moneda Nacional	0.00	8418.96	t	2025-12-19 03:40:05	2025-12-19 03:40:05
63	2025-10-04	Por venta de servicios Fact. Nro 4420	15	1.1.1.01	Caja Moneda Nacional	4287.90	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
64	2025-10-04	Por venta de servicios Fact. Nro 4420	15	5.1.1.02	Impuesto a las Transacciones (IT)	128.64	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
65	2025-10-04	Por venta de servicios Fact. Nro 4420	15	4.1.1.01	Venta de Servicios	0.00	3730.47	t	2025-12-19 03:40:05	2025-12-19 03:40:05
66	2025-10-04	Por venta de servicios Fact. Nro 4420	15	2.1.2.01	Débito Fiscal IVA	0.00	557.43	t	2025-12-19 03:40:05	2025-12-19 03:40:05
67	2025-10-04	Por venta de servicios Fact. Nro 4420	15	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	128.64	t	2025-12-19 03:40:05	2025-12-19 03:40:05
68	2025-11-12	Por venta de servicios Fact. Nro 4060	16	1.1.1.01	Caja Moneda Nacional	9079.02	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
69	2025-11-12	Por venta de servicios Fact. Nro 4060	16	5.1.1.02	Impuesto a las Transacciones (IT)	272.37	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
70	2025-11-12	Por venta de servicios Fact. Nro 4060	16	4.1.1.01	Venta de Servicios	0.00	7898.75	t	2025-12-19 03:40:05	2025-12-19 03:40:05
71	2025-11-12	Por venta de servicios Fact. Nro 4060	16	2.1.2.01	Débito Fiscal IVA	0.00	1180.27	t	2025-12-19 03:40:05	2025-12-19 03:40:05
72	2025-11-12	Por venta de servicios Fact. Nro 4060	16	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	272.37	t	2025-12-19 03:40:05	2025-12-19 03:40:05
73	2025-12-18	Por venta de servicios Fact. Nro 9206	17	1.1.1.01	Caja Moneda Nacional	13241.78	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
74	2025-12-18	Por venta de servicios Fact. Nro 9206	17	5.1.1.02	Impuesto a las Transacciones (IT)	397.25	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
75	2025-12-18	Por venta de servicios Fact. Nro 9206	17	4.1.1.01	Venta de Servicios	0.00	11520.35	t	2025-12-19 03:40:05	2025-12-19 03:40:05
76	2025-12-18	Por venta de servicios Fact. Nro 9206	17	2.1.2.01	Débito Fiscal IVA	0.00	1721.43	t	2025-12-19 03:40:05	2025-12-19 03:40:05
77	2025-12-18	Por venta de servicios Fact. Nro 9206	17	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	397.25	t	2025-12-19 03:40:05	2025-12-19 03:40:05
78	2025-10-01	Compra de activo fijo según factura	18	1.2.1.02	Equipos de Computación	2656.65	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
79	2025-10-01	Compra de activo fijo según factura	18	1.1.2.02	Crédito Fiscal IVA	396.97	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
80	2025-10-01	Compra de activo fijo según factura	18	1.1.1.02	Banco Moneda Nacional	0.00	3053.62	t	2025-12-19 03:40:05	2025-12-19 03:40:05
81	2025-11-26	Compra material escritorio Fact. 110	19	5.1.1.05	Material de Escritorio	1536.93	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
82	2025-11-26	Compra material escritorio Fact. 110	19	1.1.2.02	Crédito Fiscal IVA	229.66	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
83	2025-11-26	Compra material escritorio Fact. 110	19	1.1.1.01	Caja Moneda Nacional	0.00	1766.59	t	2025-12-19 03:40:05	2025-12-19 03:40:05
84	2025-11-13	Compra de activo fijo según factura	20	1.2.1.02	Equipos de Computación	5264.69	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
85	2025-11-13	Compra de activo fijo según factura	20	1.1.2.02	Crédito Fiscal IVA	786.68	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
86	2025-11-13	Compra de activo fijo según factura	20	1.1.1.02	Banco Moneda Nacional	0.00	6051.37	t	2025-12-19 03:40:05	2025-12-19 03:40:05
87	2025-11-16	Compra de activo fijo según factura	21	1.2.1.02	Equipos de Computación	6477.61	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
88	2025-11-16	Compra de activo fijo según factura	21	1.1.2.02	Crédito Fiscal IVA	967.92	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
89	2025-11-16	Compra de activo fijo según factura	21	1.1.1.02	Banco Moneda Nacional	0.00	7445.53	t	2025-12-19 03:40:05	2025-12-19 03:40:05
90	2025-12-15	Por venta de servicios Fact. Nro 5390	22	1.1.1.01	Caja Moneda Nacional	9636.32	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
91	2025-12-15	Por venta de servicios Fact. Nro 5390	22	5.1.1.02	Impuesto a las Transacciones (IT)	289.09	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
92	2025-12-15	Por venta de servicios Fact. Nro 5390	22	4.1.1.01	Venta de Servicios	0.00	8383.60	t	2025-12-19 03:40:05	2025-12-19 03:40:05
93	2025-12-15	Por venta de servicios Fact. Nro 5390	22	2.1.2.01	Débito Fiscal IVA	0.00	1252.72	t	2025-12-19 03:40:05	2025-12-19 03:40:05
94	2025-12-15	Por venta de servicios Fact. Nro 5390	22	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	289.09	t	2025-12-19 03:40:05	2025-12-19 03:40:05
95	2025-12-17	Pago luz y agua Fact. 223	23	5.1.1.04	Servicios Básicos (Luz, Agua)	576.49	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
96	2025-12-17	Pago luz y agua Fact. 223	23	1.1.2.02	Crédito Fiscal IVA	86.14	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
97	2025-12-17	Pago luz y agua Fact. 223	23	1.1.1.01	Caja Moneda Nacional	0.00	662.63	t	2025-12-19 03:40:05	2025-12-19 03:40:05
98	2025-09-19	Por venta de servicios Fact. Nro 8380	24	1.1.1.01	Caja Moneda Nacional	11187.48	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
99	2025-09-19	Por venta de servicios Fact. Nro 8380	24	5.1.1.02	Impuesto a las Transacciones (IT)	335.62	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
100	2025-09-19	Por venta de servicios Fact. Nro 8380	24	4.1.1.01	Venta de Servicios	0.00	9733.11	t	2025-12-19 03:40:05	2025-12-19 03:40:05
101	2025-09-19	Por venta de servicios Fact. Nro 8380	24	2.1.2.01	Débito Fiscal IVA	0.00	1454.37	t	2025-12-19 03:40:05	2025-12-19 03:40:05
102	2025-09-19	Por venta de servicios Fact. Nro 8380	24	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	335.62	t	2025-12-19 03:40:05	2025-12-19 03:40:05
103	2025-10-12	Por venta de servicios Fact. Nro 2081	25	1.1.1.01	Caja Moneda Nacional	9502.59	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
104	2025-10-12	Por venta de servicios Fact. Nro 2081	25	5.1.1.02	Impuesto a las Transacciones (IT)	285.08	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
105	2025-10-12	Por venta de servicios Fact. Nro 2081	25	4.1.1.01	Venta de Servicios	0.00	8267.25	t	2025-12-19 03:40:05	2025-12-19 03:40:05
106	2025-10-12	Por venta de servicios Fact. Nro 2081	25	2.1.2.01	Débito Fiscal IVA	0.00	1235.34	t	2025-12-19 03:40:05	2025-12-19 03:40:05
107	2025-10-12	Por venta de servicios Fact. Nro 2081	25	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	285.08	t	2025-12-19 03:40:05	2025-12-19 03:40:05
108	2025-12-02	Por venta de servicios Fact. Nro 7458	26	1.1.1.01	Caja Moneda Nacional	1251.28	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
109	2025-12-02	Por venta de servicios Fact. Nro 7458	26	5.1.1.02	Impuesto a las Transacciones (IT)	37.54	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
110	2025-12-02	Por venta de servicios Fact. Nro 7458	26	4.1.1.01	Venta de Servicios	0.00	1088.61	t	2025-12-19 03:40:05	2025-12-19 03:40:05
111	2025-12-02	Por venta de servicios Fact. Nro 7458	26	2.1.2.01	Débito Fiscal IVA	0.00	162.67	t	2025-12-19 03:40:05	2025-12-19 03:40:05
112	2025-12-02	Por venta de servicios Fact. Nro 7458	26	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	37.54	t	2025-12-19 03:40:05	2025-12-19 03:40:05
113	2025-10-28	Compra material escritorio Fact. 127	27	5.1.1.05	Material de Escritorio	949.93	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
114	2025-10-28	Compra material escritorio Fact. 127	27	1.1.2.02	Crédito Fiscal IVA	141.94	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
115	2025-10-28	Compra material escritorio Fact. 127	27	1.1.1.01	Caja Moneda Nacional	0.00	1091.87	t	2025-12-19 03:40:05	2025-12-19 03:40:05
116	2025-11-26	Por venta de servicios Fact. Nro 8588	28	1.1.1.01	Caja Moneda Nacional	6528.99	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
117	2025-11-26	Por venta de servicios Fact. Nro 8588	28	5.1.1.02	Impuesto a las Transacciones (IT)	195.87	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
118	2025-11-26	Por venta de servicios Fact. Nro 8588	28	4.1.1.01	Venta de Servicios	0.00	5680.22	t	2025-12-19 03:40:05	2025-12-19 03:40:05
119	2025-11-26	Por venta de servicios Fact. Nro 8588	28	2.1.2.01	Débito Fiscal IVA	0.00	848.77	t	2025-12-19 03:40:05	2025-12-19 03:40:05
120	2025-11-26	Por venta de servicios Fact. Nro 8588	28	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	195.87	t	2025-12-19 03:40:05	2025-12-19 03:40:05
121	2025-11-17	Por venta de servicios Fact. Nro 2207	29	1.1.1.01	Caja Moneda Nacional	4018.83	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
122	2025-11-17	Por venta de servicios Fact. Nro 2207	29	5.1.1.02	Impuesto a las Transacciones (IT)	120.56	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
123	2025-11-17	Por venta de servicios Fact. Nro 2207	29	4.1.1.01	Venta de Servicios	0.00	3496.38	t	2025-12-19 03:40:05	2025-12-19 03:40:05
124	2025-11-17	Por venta de servicios Fact. Nro 2207	29	2.1.2.01	Débito Fiscal IVA	0.00	522.45	t	2025-12-19 03:40:05	2025-12-19 03:40:05
125	2025-11-17	Por venta de servicios Fact. Nro 2207	29	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	120.56	t	2025-12-19 03:40:05	2025-12-19 03:40:05
126	2025-09-26	Por venta de servicios Fact. Nro 9036	30	1.1.1.01	Caja Moneda Nacional	6015.48	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
127	2025-09-26	Por venta de servicios Fact. Nro 9036	30	5.1.1.02	Impuesto a las Transacciones (IT)	180.46	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
128	2025-09-26	Por venta de servicios Fact. Nro 9036	30	4.1.1.01	Venta de Servicios	0.00	5233.47	t	2025-12-19 03:40:05	2025-12-19 03:40:05
129	2025-09-26	Por venta de servicios Fact. Nro 9036	30	2.1.2.01	Débito Fiscal IVA	0.00	782.01	t	2025-12-19 03:40:05	2025-12-19 03:40:05
130	2025-09-26	Por venta de servicios Fact. Nro 9036	30	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	180.46	t	2025-12-19 03:40:05	2025-12-19 03:40:05
131	2025-11-18	Compra de activo fijo según factura	31	1.2.1.01	Muebles y Enseres	5090.69	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
132	2025-11-18	Compra de activo fijo según factura	31	1.1.2.02	Crédito Fiscal IVA	760.68	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
133	2025-11-18	Compra de activo fijo según factura	31	1.1.1.02	Banco Moneda Nacional	0.00	5851.37	t	2025-12-19 03:40:05	2025-12-19 03:40:05
134	2025-11-22	Compra material escritorio Fact. 187	32	5.1.1.05	Material de Escritorio	234.21	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
135	2025-11-22	Compra material escritorio Fact. 187	32	1.1.2.02	Crédito Fiscal IVA	35.00	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
136	2025-11-22	Compra material escritorio Fact. 187	32	1.1.1.01	Caja Moneda Nacional	0.00	269.21	t	2025-12-19 03:40:05	2025-12-19 03:40:05
137	2025-11-14	Por venta de servicios Fact. Nro 6321	33	1.1.1.01	Caja Moneda Nacional	14834.50	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
138	2025-11-14	Por venta de servicios Fact. Nro 6321	33	5.1.1.02	Impuesto a las Transacciones (IT)	445.04	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
139	2025-11-14	Por venta de servicios Fact. Nro 6321	33	4.1.1.01	Venta de Servicios	0.00	12906.01	t	2025-12-19 03:40:05	2025-12-19 03:40:05
140	2025-11-14	Por venta de servicios Fact. Nro 6321	33	2.1.2.01	Débito Fiscal IVA	0.00	1928.49	t	2025-12-19 03:40:05	2025-12-19 03:40:05
141	2025-11-14	Por venta de servicios Fact. Nro 6321	33	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	445.04	t	2025-12-19 03:40:05	2025-12-19 03:40:05
142	2025-11-07	Pago luz y agua Fact. 191	34	5.1.1.04	Servicios Básicos (Luz, Agua)	1053.94	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
143	2025-11-07	Pago luz y agua Fact. 191	34	1.1.2.02	Crédito Fiscal IVA	157.48	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
144	2025-11-07	Pago luz y agua Fact. 191	34	1.1.1.01	Caja Moneda Nacional	0.00	1211.42	t	2025-12-19 03:40:05	2025-12-19 03:40:05
145	2025-12-03	Por venta de servicios Fact. Nro 1925	35	1.1.1.01	Caja Moneda Nacional	12745.68	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
146	2025-12-03	Por venta de servicios Fact. Nro 1925	35	5.1.1.02	Impuesto a las Transacciones (IT)	382.37	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
147	2025-12-03	Por venta de servicios Fact. Nro 1925	35	4.1.1.01	Venta de Servicios	0.00	11088.74	t	2025-12-19 03:40:05	2025-12-19 03:40:05
148	2025-12-03	Por venta de servicios Fact. Nro 1925	35	2.1.2.01	Débito Fiscal IVA	0.00	1656.94	t	2025-12-19 03:40:05	2025-12-19 03:40:05
149	2025-12-03	Por venta de servicios Fact. Nro 1925	35	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	382.37	t	2025-12-19 03:40:05	2025-12-19 03:40:05
150	2025-11-19	Compra material escritorio Fact. 164	36	5.1.1.05	Material de Escritorio	726.52	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
151	2025-11-19	Compra material escritorio Fact. 164	36	1.1.2.02	Crédito Fiscal IVA	108.56	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
152	2025-11-19	Compra material escritorio Fact. 164	36	1.1.1.01	Caja Moneda Nacional	0.00	835.08	t	2025-12-19 03:40:05	2025-12-19 03:40:05
153	2025-10-23	Por venta de servicios Fact. Nro 8689	37	1.1.1.01	Caja Moneda Nacional	12362.94	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
154	2025-10-23	Por venta de servicios Fact. Nro 8689	37	5.1.1.02	Impuesto a las Transacciones (IT)	370.89	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
155	2025-10-23	Por venta de servicios Fact. Nro 8689	37	4.1.1.01	Venta de Servicios	0.00	10755.76	t	2025-12-19 03:40:05	2025-12-19 03:40:05
156	2025-10-23	Por venta de servicios Fact. Nro 8689	37	2.1.2.01	Débito Fiscal IVA	0.00	1607.18	t	2025-12-19 03:40:05	2025-12-19 03:40:05
157	2025-10-23	Por venta de servicios Fact. Nro 8689	37	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	370.89	t	2025-12-19 03:40:05	2025-12-19 03:40:05
158	2025-11-23	Por venta de servicios Fact. Nro 9379	38	1.1.1.01	Caja Moneda Nacional	7102.09	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
159	2025-11-23	Por venta de servicios Fact. Nro 9379	38	5.1.1.02	Impuesto a las Transacciones (IT)	213.06	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
160	2025-11-23	Por venta de servicios Fact. Nro 9379	38	4.1.1.01	Venta de Servicios	0.00	6178.82	t	2025-12-19 03:40:05	2025-12-19 03:40:05
161	2025-11-23	Por venta de servicios Fact. Nro 9379	38	2.1.2.01	Débito Fiscal IVA	0.00	923.27	t	2025-12-19 03:40:05	2025-12-19 03:40:05
162	2025-11-23	Por venta de servicios Fact. Nro 9379	38	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	213.06	t	2025-12-19 03:40:05	2025-12-19 03:40:05
163	2025-11-17	Por venta de servicios Fact. Nro 3870	39	1.1.1.01	Caja Moneda Nacional	11671.63	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
164	2025-11-17	Por venta de servicios Fact. Nro 3870	39	5.1.1.02	Impuesto a las Transacciones (IT)	350.15	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
165	2025-11-17	Por venta de servicios Fact. Nro 3870	39	4.1.1.01	Venta de Servicios	0.00	10154.32	t	2025-12-19 03:40:05	2025-12-19 03:40:05
166	2025-11-17	Por venta de servicios Fact. Nro 3870	39	2.1.2.01	Débito Fiscal IVA	0.00	1517.31	t	2025-12-19 03:40:05	2025-12-19 03:40:05
167	2025-11-17	Por venta de servicios Fact. Nro 3870	39	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	350.15	t	2025-12-19 03:40:05	2025-12-19 03:40:05
168	2025-10-15	Por venta de servicios Fact. Nro 7410	40	1.1.1.01	Caja Moneda Nacional	7380.80	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
169	2025-10-15	Por venta de servicios Fact. Nro 7410	40	5.1.1.02	Impuesto a las Transacciones (IT)	221.42	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
170	2025-10-15	Por venta de servicios Fact. Nro 7410	40	4.1.1.01	Venta de Servicios	0.00	6421.30	t	2025-12-19 03:40:05	2025-12-19 03:40:05
171	2025-10-15	Por venta de servicios Fact. Nro 7410	40	2.1.2.01	Débito Fiscal IVA	0.00	959.50	t	2025-12-19 03:40:05	2025-12-19 03:40:05
172	2025-10-15	Por venta de servicios Fact. Nro 7410	40	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	221.42	t	2025-12-19 03:40:05	2025-12-19 03:40:05
173	2025-12-07	Pago luz y agua Fact. 346	41	5.1.1.04	Servicios Básicos (Luz, Agua)	418.20	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
174	2025-12-07	Pago luz y agua Fact. 346	41	1.1.2.02	Crédito Fiscal IVA	62.49	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
175	2025-12-07	Pago luz y agua Fact. 346	41	1.1.1.01	Caja Moneda Nacional	0.00	480.69	t	2025-12-19 03:40:05	2025-12-19 03:40:05
176	2025-11-17	Por venta de servicios Fact. Nro 9619	42	1.1.1.01	Caja Moneda Nacional	11299.76	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
177	2025-11-17	Por venta de servicios Fact. Nro 9619	42	5.1.1.02	Impuesto a las Transacciones (IT)	338.99	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
178	2025-11-17	Por venta de servicios Fact. Nro 9619	42	4.1.1.01	Venta de Servicios	0.00	9830.79	t	2025-12-19 03:40:05	2025-12-19 03:40:05
179	2025-11-17	Por venta de servicios Fact. Nro 9619	42	2.1.2.01	Débito Fiscal IVA	0.00	1468.97	t	2025-12-19 03:40:05	2025-12-19 03:40:05
180	2025-11-17	Por venta de servicios Fact. Nro 9619	42	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	338.99	t	2025-12-19 03:40:05	2025-12-19 03:40:05
181	2025-12-17	Compra material escritorio Fact. 450	43	5.1.1.05	Material de Escritorio	123.22	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
182	2025-12-17	Compra material escritorio Fact. 450	43	1.1.2.02	Crédito Fiscal IVA	18.41	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
183	2025-12-17	Compra material escritorio Fact. 450	43	1.1.1.01	Caja Moneda Nacional	0.00	141.63	t	2025-12-19 03:40:05	2025-12-19 03:40:05
184	2025-10-03	Por venta de servicios Fact. Nro 4273	44	1.1.1.01	Caja Moneda Nacional	11749.04	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
185	2025-10-03	Por venta de servicios Fact. Nro 4273	44	5.1.1.02	Impuesto a las Transacciones (IT)	352.47	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
186	2025-10-03	Por venta de servicios Fact. Nro 4273	44	4.1.1.01	Venta de Servicios	0.00	10221.66	t	2025-12-19 03:40:05	2025-12-19 03:40:05
187	2025-10-03	Por venta de servicios Fact. Nro 4273	44	2.1.2.01	Débito Fiscal IVA	0.00	1527.38	t	2025-12-19 03:40:05	2025-12-19 03:40:05
188	2025-10-03	Por venta de servicios Fact. Nro 4273	44	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	352.47	t	2025-12-19 03:40:05	2025-12-19 03:40:05
189	2025-12-08	Por venta de servicios Fact. Nro 3276	45	1.1.1.01	Caja Moneda Nacional	8863.40	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
190	2025-12-08	Por venta de servicios Fact. Nro 3276	45	5.1.1.02	Impuesto a las Transacciones (IT)	265.90	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
191	2025-12-08	Por venta de servicios Fact. Nro 3276	45	4.1.1.01	Venta de Servicios	0.00	7711.16	t	2025-12-19 03:40:05	2025-12-19 03:40:05
192	2025-12-08	Por venta de servicios Fact. Nro 3276	45	2.1.2.01	Débito Fiscal IVA	0.00	1152.24	t	2025-12-19 03:40:05	2025-12-19 03:40:05
193	2025-12-08	Por venta de servicios Fact. Nro 3276	45	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	265.90	t	2025-12-19 03:40:05	2025-12-19 03:40:05
194	2025-10-26	Pago luz y agua Fact. 470	46	5.1.1.04	Servicios Básicos (Luz, Agua)	1596.07	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
195	2025-10-26	Pago luz y agua Fact. 470	46	1.1.2.02	Crédito Fiscal IVA	238.49	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
196	2025-10-26	Pago luz y agua Fact. 470	46	1.1.1.01	Caja Moneda Nacional	0.00	1834.56	t	2025-12-19 03:40:05	2025-12-19 03:40:05
197	2025-10-06	Por venta de servicios Fact. Nro 7061	47	1.1.1.01	Caja Moneda Nacional	7836.42	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
198	2025-10-06	Por venta de servicios Fact. Nro 7061	47	5.1.1.02	Impuesto a las Transacciones (IT)	235.09	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
199	2025-10-06	Por venta de servicios Fact. Nro 7061	47	4.1.1.01	Venta de Servicios	0.00	6817.69	t	2025-12-19 03:40:05	2025-12-19 03:40:05
200	2025-10-06	Por venta de servicios Fact. Nro 7061	47	2.1.2.01	Débito Fiscal IVA	0.00	1018.73	t	2025-12-19 03:40:05	2025-12-19 03:40:05
201	2025-10-06	Por venta de servicios Fact. Nro 7061	47	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	235.09	t	2025-12-19 03:40:05	2025-12-19 03:40:05
202	2025-12-18	Por venta de servicios Fact. Nro 1725	48	1.1.1.01	Caja Moneda Nacional	5631.26	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
203	2025-12-18	Por venta de servicios Fact. Nro 1725	48	5.1.1.02	Impuesto a las Transacciones (IT)	168.94	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
204	2025-12-18	Por venta de servicios Fact. Nro 1725	48	4.1.1.01	Venta de Servicios	0.00	4899.20	t	2025-12-19 03:40:05	2025-12-19 03:40:05
205	2025-12-18	Por venta de servicios Fact. Nro 1725	48	2.1.2.01	Débito Fiscal IVA	0.00	732.06	t	2025-12-19 03:40:05	2025-12-19 03:40:05
206	2025-12-18	Por venta de servicios Fact. Nro 1725	48	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	168.94	t	2025-12-19 03:40:05	2025-12-19 03:40:05
207	2025-11-14	Pago luz y agua Fact. 104	49	5.1.1.04	Servicios Básicos (Luz, Agua)	1195.68	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
208	2025-11-14	Pago luz y agua Fact. 104	49	1.1.2.02	Crédito Fiscal IVA	178.67	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
209	2025-11-14	Pago luz y agua Fact. 104	49	1.1.1.01	Caja Moneda Nacional	0.00	1374.35	t	2025-12-19 03:40:05	2025-12-19 03:40:05
210	2025-12-02	Pago luz y agua Fact. 499	50	5.1.1.04	Servicios Básicos (Luz, Agua)	1104.40	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
211	2025-12-02	Pago luz y agua Fact. 499	50	1.1.2.02	Crédito Fiscal IVA	165.02	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
212	2025-12-02	Pago luz y agua Fact. 499	50	1.1.1.01	Caja Moneda Nacional	0.00	1269.42	t	2025-12-19 03:40:05	2025-12-19 03:40:05
213	2025-11-20	Por venta de servicios Fact. Nro 6860	51	1.1.1.01	Caja Moneda Nacional	11052.33	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
214	2025-11-20	Por venta de servicios Fact. Nro 6860	51	5.1.1.02	Impuesto a las Transacciones (IT)	331.57	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
215	2025-11-20	Por venta de servicios Fact. Nro 6860	51	4.1.1.01	Venta de Servicios	0.00	9615.53	t	2025-12-19 03:40:05	2025-12-19 03:40:05
216	2025-11-20	Por venta de servicios Fact. Nro 6860	51	2.1.2.01	Débito Fiscal IVA	0.00	1436.80	t	2025-12-19 03:40:05	2025-12-19 03:40:05
217	2025-11-20	Por venta de servicios Fact. Nro 6860	51	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	331.57	t	2025-12-19 03:40:05	2025-12-19 03:40:05
218	2025-12-01	Compra material escritorio Fact. 399	52	5.1.1.05	Material de Escritorio	462.46	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
219	2025-12-01	Compra material escritorio Fact. 399	52	1.1.2.02	Crédito Fiscal IVA	69.10	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
328	2025-10-15	Pago luz y agua Fact. 423	77	1.1.2.02	Crédito Fiscal IVA	126.85	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
220	2025-12-01	Compra material escritorio Fact. 399	52	1.1.1.01	Caja Moneda Nacional	0.00	531.56	t	2025-12-19 03:40:05	2025-12-19 03:40:05
221	2025-10-24	Compra material escritorio Fact. 273	53	5.1.1.05	Material de Escritorio	1324.51	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
222	2025-10-24	Compra material escritorio Fact. 273	53	1.1.2.02	Crédito Fiscal IVA	197.91	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
223	2025-10-24	Compra material escritorio Fact. 273	53	1.1.1.01	Caja Moneda Nacional	0.00	1522.42	t	2025-12-19 03:40:05	2025-12-19 03:40:05
224	2025-10-24	Por venta de servicios Fact. Nro 9833	54	1.1.1.01	Caja Moneda Nacional	11906.88	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
225	2025-10-24	Por venta de servicios Fact. Nro 9833	54	5.1.1.02	Impuesto a las Transacciones (IT)	357.21	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
226	2025-10-24	Por venta de servicios Fact. Nro 9833	54	4.1.1.01	Venta de Servicios	0.00	10358.99	t	2025-12-19 03:40:05	2025-12-19 03:40:05
227	2025-10-24	Por venta de servicios Fact. Nro 9833	54	2.1.2.01	Débito Fiscal IVA	0.00	1547.89	t	2025-12-19 03:40:05	2025-12-19 03:40:05
228	2025-10-24	Por venta de servicios Fact. Nro 9833	54	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	357.21	t	2025-12-19 03:40:05	2025-12-19 03:40:05
229	2025-11-22	Por venta de servicios Fact. Nro 8132	55	1.1.1.01	Caja Moneda Nacional	12062.49	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
230	2025-11-22	Por venta de servicios Fact. Nro 8132	55	5.1.1.02	Impuesto a las Transacciones (IT)	361.87	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
231	2025-11-22	Por venta de servicios Fact. Nro 8132	55	4.1.1.01	Venta de Servicios	0.00	10494.37	t	2025-12-19 03:40:05	2025-12-19 03:40:05
232	2025-11-22	Por venta de servicios Fact. Nro 8132	55	2.1.2.01	Débito Fiscal IVA	0.00	1568.12	t	2025-12-19 03:40:05	2025-12-19 03:40:05
233	2025-11-22	Por venta de servicios Fact. Nro 8132	55	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	361.87	t	2025-12-19 03:40:05	2025-12-19 03:40:05
234	2025-11-21	Por venta de servicios Fact. Nro 5104	56	1.1.1.01	Caja Moneda Nacional	12221.79	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
235	2025-11-21	Por venta de servicios Fact. Nro 5104	56	5.1.1.02	Impuesto a las Transacciones (IT)	366.65	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
236	2025-11-21	Por venta de servicios Fact. Nro 5104	56	4.1.1.01	Venta de Servicios	0.00	10632.96	t	2025-12-19 03:40:05	2025-12-19 03:40:05
237	2025-11-21	Por venta de servicios Fact. Nro 5104	56	2.1.2.01	Débito Fiscal IVA	0.00	1588.83	t	2025-12-19 03:40:05	2025-12-19 03:40:05
238	2025-11-21	Por venta de servicios Fact. Nro 5104	56	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	366.65	t	2025-12-19 03:40:05	2025-12-19 03:40:05
239	2025-10-01	Pago luz y agua Fact. 467	57	5.1.1.04	Servicios Básicos (Luz, Agua)	1204.03	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
240	2025-10-01	Pago luz y agua Fact. 467	57	1.1.2.02	Crédito Fiscal IVA	179.91	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
241	2025-10-01	Pago luz y agua Fact. 467	57	1.1.1.01	Caja Moneda Nacional	0.00	1383.94	t	2025-12-19 03:40:05	2025-12-19 03:40:05
242	2025-09-26	Por venta de servicios Fact. Nro 2298	58	1.1.1.01	Caja Moneda Nacional	6695.12	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
243	2025-09-26	Por venta de servicios Fact. Nro 2298	58	5.1.1.02	Impuesto a las Transacciones (IT)	200.85	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
244	2025-09-26	Por venta de servicios Fact. Nro 2298	58	4.1.1.01	Venta de Servicios	0.00	5824.75	t	2025-12-19 03:40:05	2025-12-19 03:40:05
245	2025-09-26	Por venta de servicios Fact. Nro 2298	58	2.1.2.01	Débito Fiscal IVA	0.00	870.37	t	2025-12-19 03:40:05	2025-12-19 03:40:05
246	2025-09-26	Por venta de servicios Fact. Nro 2298	58	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	200.85	t	2025-12-19 03:40:05	2025-12-19 03:40:05
247	2025-11-22	Por venta de servicios Fact. Nro 7577	59	1.1.1.01	Caja Moneda Nacional	2883.02	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
248	2025-11-22	Por venta de servicios Fact. Nro 7577	59	5.1.1.02	Impuesto a las Transacciones (IT)	86.49	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
249	2025-11-22	Por venta de servicios Fact. Nro 7577	59	4.1.1.01	Venta de Servicios	0.00	2508.23	t	2025-12-19 03:40:05	2025-12-19 03:40:05
250	2025-11-22	Por venta de servicios Fact. Nro 7577	59	2.1.2.01	Débito Fiscal IVA	0.00	374.79	t	2025-12-19 03:40:05	2025-12-19 03:40:05
251	2025-11-22	Por venta de servicios Fact. Nro 7577	59	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	86.49	t	2025-12-19 03:40:05	2025-12-19 03:40:05
252	2025-12-09	Compra de activo fijo según factura	60	1.2.1.02	Equipos de Computación	5895.68	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
253	2025-12-09	Compra de activo fijo según factura	60	1.1.2.02	Crédito Fiscal IVA	880.96	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
254	2025-12-09	Compra de activo fijo según factura	60	1.1.1.02	Banco Moneda Nacional	0.00	6776.64	t	2025-12-19 03:40:05	2025-12-19 03:40:05
255	2025-12-16	Por venta de servicios Fact. Nro 6951	61	1.1.1.01	Caja Moneda Nacional	2721.99	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
256	2025-12-16	Por venta de servicios Fact. Nro 6951	61	5.1.1.02	Impuesto a las Transacciones (IT)	81.66	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
257	2025-12-16	Por venta de servicios Fact. Nro 6951	61	4.1.1.01	Venta de Servicios	0.00	2368.13	t	2025-12-19 03:40:05	2025-12-19 03:40:05
258	2025-12-16	Por venta de servicios Fact. Nro 6951	61	2.1.2.01	Débito Fiscal IVA	0.00	353.86	t	2025-12-19 03:40:05	2025-12-19 03:40:05
259	2025-12-16	Por venta de servicios Fact. Nro 6951	61	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	81.66	t	2025-12-19 03:40:05	2025-12-19 03:40:05
260	2025-09-19	Por venta de servicios Fact. Nro 7177	62	1.1.1.01	Caja Moneda Nacional	5494.34	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
261	2025-09-19	Por venta de servicios Fact. Nro 7177	62	5.1.1.02	Impuesto a las Transacciones (IT)	164.83	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
262	2025-09-19	Por venta de servicios Fact. Nro 7177	62	4.1.1.01	Venta de Servicios	0.00	4780.08	t	2025-12-19 03:40:05	2025-12-19 03:40:05
263	2025-09-19	Por venta de servicios Fact. Nro 7177	62	2.1.2.01	Débito Fiscal IVA	0.00	714.26	t	2025-12-19 03:40:05	2025-12-19 03:40:05
264	2025-09-19	Por venta de servicios Fact. Nro 7177	62	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	164.83	t	2025-12-19 03:40:05	2025-12-19 03:40:05
265	2025-12-01	Por venta de servicios Fact. Nro 2313	63	1.1.1.01	Caja Moneda Nacional	7910.74	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
266	2025-12-01	Por venta de servicios Fact. Nro 2313	63	5.1.1.02	Impuesto a las Transacciones (IT)	237.32	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
267	2025-12-01	Por venta de servicios Fact. Nro 2313	63	4.1.1.01	Venta de Servicios	0.00	6882.34	t	2025-12-19 03:40:05	2025-12-19 03:40:05
268	2025-12-01	Por venta de servicios Fact. Nro 2313	63	2.1.2.01	Débito Fiscal IVA	0.00	1028.40	t	2025-12-19 03:40:05	2025-12-19 03:40:05
269	2025-12-01	Por venta de servicios Fact. Nro 2313	63	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	237.32	t	2025-12-19 03:40:05	2025-12-19 03:40:05
270	2025-12-18	Por venta de servicios Fact. Nro 1785	64	1.1.1.01	Caja Moneda Nacional	10803.97	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
271	2025-12-18	Por venta de servicios Fact. Nro 1785	64	5.1.1.02	Impuesto a las Transacciones (IT)	324.12	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
272	2025-12-18	Por venta de servicios Fact. Nro 1785	64	4.1.1.01	Venta de Servicios	0.00	9399.45	t	2025-12-19 03:40:05	2025-12-19 03:40:05
273	2025-12-18	Por venta de servicios Fact. Nro 1785	64	2.1.2.01	Débito Fiscal IVA	0.00	1404.52	t	2025-12-19 03:40:05	2025-12-19 03:40:05
329	2025-10-15	Pago luz y agua Fact. 423	77	1.1.1.01	Caja Moneda Nacional	0.00	975.80	t	2025-12-19 03:40:05	2025-12-19 03:40:05
274	2025-12-18	Por venta de servicios Fact. Nro 1785	64	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	324.12	t	2025-12-19 03:40:05	2025-12-19 03:40:05
275	2025-10-26	Compra material escritorio Fact. 255	65	5.1.1.05	Material de Escritorio	1062.37	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
276	2025-10-26	Compra material escritorio Fact. 255	65	1.1.2.02	Crédito Fiscal IVA	158.74	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
277	2025-10-26	Compra material escritorio Fact. 255	65	1.1.1.01	Caja Moneda Nacional	0.00	1221.11	t	2025-12-19 03:40:05	2025-12-19 03:40:05
278	2025-10-08	Por venta de servicios Fact. Nro 9804	66	1.1.1.01	Caja Moneda Nacional	8098.61	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
279	2025-10-08	Por venta de servicios Fact. Nro 9804	66	5.1.1.02	Impuesto a las Transacciones (IT)	242.96	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
280	2025-10-08	Por venta de servicios Fact. Nro 9804	66	4.1.1.01	Venta de Servicios	0.00	7045.79	t	2025-12-19 03:40:05	2025-12-19 03:40:05
281	2025-10-08	Por venta de servicios Fact. Nro 9804	66	2.1.2.01	Débito Fiscal IVA	0.00	1052.82	t	2025-12-19 03:40:05	2025-12-19 03:40:05
282	2025-10-08	Por venta de servicios Fact. Nro 9804	66	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	242.96	t	2025-12-19 03:40:05	2025-12-19 03:40:05
283	2025-12-10	Compra material escritorio Fact. 184	67	5.1.1.05	Material de Escritorio	890.93	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
284	2025-12-10	Compra material escritorio Fact. 184	67	1.1.2.02	Crédito Fiscal IVA	133.13	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
285	2025-12-10	Compra material escritorio Fact. 184	67	1.1.1.01	Caja Moneda Nacional	0.00	1024.06	t	2025-12-19 03:40:05	2025-12-19 03:40:05
286	2025-10-17	Compra de activo fijo según factura	68	1.2.1.01	Muebles y Enseres	7761.36	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
287	2025-10-17	Compra de activo fijo según factura	68	1.1.2.02	Crédito Fiscal IVA	1159.74	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
288	2025-10-17	Compra de activo fijo según factura	68	1.1.1.02	Banco Moneda Nacional	0.00	8921.10	t	2025-12-19 03:40:05	2025-12-19 03:40:05
289	2025-09-20	Compra material escritorio Fact. 233	69	5.1.1.05	Material de Escritorio	74.64	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
290	2025-09-20	Compra material escritorio Fact. 233	69	1.1.2.02	Crédito Fiscal IVA	11.15	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
291	2025-09-20	Compra material escritorio Fact. 233	69	1.1.1.01	Caja Moneda Nacional	0.00	85.79	t	2025-12-19 03:40:05	2025-12-19 03:40:05
292	2025-12-04	Por venta de servicios Fact. Nro 3943	70	1.1.1.01	Caja Moneda Nacional	4789.39	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
293	2025-12-04	Por venta de servicios Fact. Nro 3943	70	5.1.1.02	Impuesto a las Transacciones (IT)	143.68	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
294	2025-12-04	Por venta de servicios Fact. Nro 3943	70	4.1.1.01	Venta de Servicios	0.00	4166.77	t	2025-12-19 03:40:05	2025-12-19 03:40:05
295	2025-12-04	Por venta de servicios Fact. Nro 3943	70	2.1.2.01	Débito Fiscal IVA	0.00	622.62	t	2025-12-19 03:40:05	2025-12-19 03:40:05
296	2025-12-04	Por venta de servicios Fact. Nro 3943	70	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	143.68	t	2025-12-19 03:40:05	2025-12-19 03:40:05
297	2025-12-04	Por venta de servicios Fact. Nro 6715	71	1.1.1.01	Caja Moneda Nacional	11109.07	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
298	2025-12-04	Por venta de servicios Fact. Nro 6715	71	5.1.1.02	Impuesto a las Transacciones (IT)	333.27	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
299	2025-12-04	Por venta de servicios Fact. Nro 6715	71	4.1.1.01	Venta de Servicios	0.00	9664.89	t	2025-12-19 03:40:05	2025-12-19 03:40:05
300	2025-12-04	Por venta de servicios Fact. Nro 6715	71	2.1.2.01	Débito Fiscal IVA	0.00	1444.18	t	2025-12-19 03:40:05	2025-12-19 03:40:05
301	2025-12-04	Por venta de servicios Fact. Nro 6715	71	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	333.27	t	2025-12-19 03:40:05	2025-12-19 03:40:05
302	2025-10-18	Por venta de servicios Fact. Nro 4469	72	1.1.1.01	Caja Moneda Nacional	13125.77	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
303	2025-10-18	Por venta de servicios Fact. Nro 4469	72	5.1.1.02	Impuesto a las Transacciones (IT)	393.77	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
304	2025-10-18	Por venta de servicios Fact. Nro 4469	72	4.1.1.01	Venta de Servicios	0.00	11419.42	t	2025-12-19 03:40:05	2025-12-19 03:40:05
305	2025-10-18	Por venta de servicios Fact. Nro 4469	72	2.1.2.01	Débito Fiscal IVA	0.00	1706.35	t	2025-12-19 03:40:05	2025-12-19 03:40:05
306	2025-10-18	Por venta de servicios Fact. Nro 4469	72	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	393.77	t	2025-12-19 03:40:05	2025-12-19 03:40:05
307	2025-11-08	Por venta de servicios Fact. Nro 8342	73	1.1.1.01	Caja Moneda Nacional	14062.60	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
308	2025-11-08	Por venta de servicios Fact. Nro 8342	73	5.1.1.02	Impuesto a las Transacciones (IT)	421.88	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
309	2025-11-08	Por venta de servicios Fact. Nro 8342	73	4.1.1.01	Venta de Servicios	0.00	12234.46	t	2025-12-19 03:40:05	2025-12-19 03:40:05
310	2025-11-08	Por venta de servicios Fact. Nro 8342	73	2.1.2.01	Débito Fiscal IVA	0.00	1828.14	t	2025-12-19 03:40:05	2025-12-19 03:40:05
311	2025-11-08	Por venta de servicios Fact. Nro 8342	73	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	421.88	t	2025-12-19 03:40:05	2025-12-19 03:40:05
312	2025-11-22	Por venta de servicios Fact. Nro 6484	74	1.1.1.01	Caja Moneda Nacional	1662.99	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
313	2025-11-22	Por venta de servicios Fact. Nro 6484	74	5.1.1.02	Impuesto a las Transacciones (IT)	49.89	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
314	2025-11-22	Por venta de servicios Fact. Nro 6484	74	4.1.1.01	Venta de Servicios	0.00	1446.80	t	2025-12-19 03:40:05	2025-12-19 03:40:05
315	2025-11-22	Por venta de servicios Fact. Nro 6484	74	2.1.2.01	Débito Fiscal IVA	0.00	216.19	t	2025-12-19 03:40:05	2025-12-19 03:40:05
316	2025-11-22	Por venta de servicios Fact. Nro 6484	74	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	49.89	t	2025-12-19 03:40:05	2025-12-19 03:40:05
317	2025-11-22	Por venta de servicios Fact. Nro 6675	75	1.1.1.01	Caja Moneda Nacional	12738.54	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
318	2025-11-22	Por venta de servicios Fact. Nro 6675	75	5.1.1.02	Impuesto a las Transacciones (IT)	382.16	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
319	2025-11-22	Por venta de servicios Fact. Nro 6675	75	4.1.1.01	Venta de Servicios	0.00	11082.53	t	2025-12-19 03:40:05	2025-12-19 03:40:05
320	2025-11-22	Por venta de servicios Fact. Nro 6675	75	2.1.2.01	Débito Fiscal IVA	0.00	1656.01	t	2025-12-19 03:40:05	2025-12-19 03:40:05
321	2025-11-22	Por venta de servicios Fact. Nro 6675	75	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	382.16	t	2025-12-19 03:40:05	2025-12-19 03:40:05
322	2025-10-02	Por venta de servicios Fact. Nro 9270	76	1.1.1.01	Caja Moneda Nacional	2689.17	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
323	2025-10-02	Por venta de servicios Fact. Nro 9270	76	5.1.1.02	Impuesto a las Transacciones (IT)	80.68	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
324	2025-10-02	Por venta de servicios Fact. Nro 9270	76	4.1.1.01	Venta de Servicios	0.00	2339.58	t	2025-12-19 03:40:05	2025-12-19 03:40:05
325	2025-10-02	Por venta de servicios Fact. Nro 9270	76	2.1.2.01	Débito Fiscal IVA	0.00	349.59	t	2025-12-19 03:40:05	2025-12-19 03:40:05
326	2025-10-02	Por venta de servicios Fact. Nro 9270	76	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	80.68	t	2025-12-19 03:40:05	2025-12-19 03:40:05
327	2025-10-15	Pago luz y agua Fact. 423	77	5.1.1.04	Servicios Básicos (Luz, Agua)	848.95	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
330	2025-10-28	Por venta de servicios Fact. Nro 3039	78	1.1.1.01	Caja Moneda Nacional	6781.50	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
331	2025-10-28	Por venta de servicios Fact. Nro 3039	78	5.1.1.02	Impuesto a las Transacciones (IT)	203.45	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
332	2025-10-28	Por venta de servicios Fact. Nro 3039	78	4.1.1.01	Venta de Servicios	0.00	5899.90	t	2025-12-19 03:40:05	2025-12-19 03:40:05
333	2025-10-28	Por venta de servicios Fact. Nro 3039	78	2.1.2.01	Débito Fiscal IVA	0.00	881.60	t	2025-12-19 03:40:05	2025-12-19 03:40:05
334	2025-10-28	Por venta de servicios Fact. Nro 3039	78	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	203.45	t	2025-12-19 03:40:05	2025-12-19 03:40:05
335	2025-09-26	Por venta de servicios Fact. Nro 6856	79	1.1.1.01	Caja Moneda Nacional	8167.38	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
336	2025-09-26	Por venta de servicios Fact. Nro 6856	79	5.1.1.02	Impuesto a las Transacciones (IT)	245.02	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
337	2025-09-26	Por venta de servicios Fact. Nro 6856	79	4.1.1.01	Venta de Servicios	0.00	7105.62	t	2025-12-19 03:40:05	2025-12-19 03:40:05
338	2025-09-26	Por venta de servicios Fact. Nro 6856	79	2.1.2.01	Débito Fiscal IVA	0.00	1061.76	t	2025-12-19 03:40:05	2025-12-19 03:40:05
339	2025-09-26	Por venta de servicios Fact. Nro 6856	79	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	245.02	t	2025-12-19 03:40:05	2025-12-19 03:40:05
340	2025-11-07	Por venta de servicios Fact. Nro 8238	80	1.1.1.01	Caja Moneda Nacional	7109.90	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
341	2025-11-07	Por venta de servicios Fact. Nro 8238	80	5.1.1.02	Impuesto a las Transacciones (IT)	213.30	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
342	2025-11-07	Por venta de servicios Fact. Nro 8238	80	4.1.1.01	Venta de Servicios	0.00	6185.61	t	2025-12-19 03:40:05	2025-12-19 03:40:05
343	2025-11-07	Por venta de servicios Fact. Nro 8238	80	2.1.2.01	Débito Fiscal IVA	0.00	924.29	t	2025-12-19 03:40:05	2025-12-19 03:40:05
344	2025-11-07	Por venta de servicios Fact. Nro 8238	80	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	213.30	t	2025-12-19 03:40:05	2025-12-19 03:40:05
345	2025-12-12	Por venta de servicios Fact. Nro 2098	81	1.1.1.01	Caja Moneda Nacional	11730.00	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
346	2025-12-12	Por venta de servicios Fact. Nro 2098	81	5.1.1.02	Impuesto a las Transacciones (IT)	351.90	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
347	2025-12-12	Por venta de servicios Fact. Nro 2098	81	4.1.1.01	Venta de Servicios	0.00	10205.10	t	2025-12-19 03:40:05	2025-12-19 03:40:05
348	2025-12-12	Por venta de servicios Fact. Nro 2098	81	2.1.2.01	Débito Fiscal IVA	0.00	1524.90	t	2025-12-19 03:40:05	2025-12-19 03:40:05
349	2025-12-12	Por venta de servicios Fact. Nro 2098	81	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	351.90	t	2025-12-19 03:40:05	2025-12-19 03:40:05
350	2025-10-10	Compra material escritorio Fact. 376	82	5.1.1.05	Material de Escritorio	54.95	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
351	2025-10-10	Compra material escritorio Fact. 376	82	1.1.2.02	Crédito Fiscal IVA	8.21	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
352	2025-10-10	Compra material escritorio Fact. 376	82	1.1.1.01	Caja Moneda Nacional	0.00	63.16	t	2025-12-19 03:40:05	2025-12-19 03:40:05
353	2025-11-30	Compra de activo fijo según factura	83	1.2.1.02	Equipos de Computación	5676.25	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
354	2025-11-30	Compra de activo fijo según factura	83	1.1.2.02	Crédito Fiscal IVA	848.17	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
355	2025-11-30	Compra de activo fijo según factura	83	1.1.1.02	Banco Moneda Nacional	0.00	6524.42	t	2025-12-19 03:40:05	2025-12-19 03:40:05
356	2025-10-06	Por venta de servicios Fact. Nro 4622	84	1.1.1.01	Caja Moneda Nacional	12973.94	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
357	2025-10-06	Por venta de servicios Fact. Nro 4622	84	5.1.1.02	Impuesto a las Transacciones (IT)	389.22	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
358	2025-10-06	Por venta de servicios Fact. Nro 4622	84	4.1.1.01	Venta de Servicios	0.00	11287.33	t	2025-12-19 03:40:05	2025-12-19 03:40:05
359	2025-10-06	Por venta de servicios Fact. Nro 4622	84	2.1.2.01	Débito Fiscal IVA	0.00	1686.61	t	2025-12-19 03:40:05	2025-12-19 03:40:05
360	2025-10-06	Por venta de servicios Fact. Nro 4622	84	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	389.22	t	2025-12-19 03:40:05	2025-12-19 03:40:05
361	2025-11-28	Por venta de servicios Fact. Nro 4460	85	1.1.1.01	Caja Moneda Nacional	10021.66	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
362	2025-11-28	Por venta de servicios Fact. Nro 4460	85	5.1.1.02	Impuesto a las Transacciones (IT)	300.65	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
363	2025-11-28	Por venta de servicios Fact. Nro 4460	85	4.1.1.01	Venta de Servicios	0.00	8718.84	t	2025-12-19 03:40:05	2025-12-19 03:40:05
364	2025-11-28	Por venta de servicios Fact. Nro 4460	85	2.1.2.01	Débito Fiscal IVA	0.00	1302.82	t	2025-12-19 03:40:05	2025-12-19 03:40:05
365	2025-11-28	Por venta de servicios Fact. Nro 4460	85	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	300.65	t	2025-12-19 03:40:05	2025-12-19 03:40:05
366	2025-11-11	Por venta de servicios Fact. Nro 4321	86	1.1.1.01	Caja Moneda Nacional	12434.39	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
367	2025-11-11	Por venta de servicios Fact. Nro 4321	86	5.1.1.02	Impuesto a las Transacciones (IT)	373.03	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
368	2025-11-11	Por venta de servicios Fact. Nro 4321	86	4.1.1.01	Venta de Servicios	0.00	10817.92	t	2025-12-19 03:40:05	2025-12-19 03:40:05
369	2025-11-11	Por venta de servicios Fact. Nro 4321	86	2.1.2.01	Débito Fiscal IVA	0.00	1616.47	t	2025-12-19 03:40:05	2025-12-19 03:40:05
370	2025-11-11	Por venta de servicios Fact. Nro 4321	86	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	373.03	t	2025-12-19 03:40:05	2025-12-19 03:40:05
371	2025-10-24	Por venta de servicios Fact. Nro 2870	87	1.1.1.01	Caja Moneda Nacional	4105.07	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
372	2025-10-24	Por venta de servicios Fact. Nro 2870	87	5.1.1.02	Impuesto a las Transacciones (IT)	123.15	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
373	2025-10-24	Por venta de servicios Fact. Nro 2870	87	4.1.1.01	Venta de Servicios	0.00	3571.41	t	2025-12-19 03:40:05	2025-12-19 03:40:05
374	2025-10-24	Por venta de servicios Fact. Nro 2870	87	2.1.2.01	Débito Fiscal IVA	0.00	533.66	t	2025-12-19 03:40:05	2025-12-19 03:40:05
375	2025-10-24	Por venta de servicios Fact. Nro 2870	87	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	123.15	t	2025-12-19 03:40:05	2025-12-19 03:40:05
376	2025-12-11	Por venta de servicios Fact. Nro 7616	88	1.1.1.01	Caja Moneda Nacional	4912.21	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
377	2025-12-11	Por venta de servicios Fact. Nro 7616	88	5.1.1.02	Impuesto a las Transacciones (IT)	147.37	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
378	2025-12-11	Por venta de servicios Fact. Nro 7616	88	4.1.1.01	Venta de Servicios	0.00	4273.62	t	2025-12-19 03:40:05	2025-12-19 03:40:05
379	2025-12-11	Por venta de servicios Fact. Nro 7616	88	2.1.2.01	Débito Fiscal IVA	0.00	638.59	t	2025-12-19 03:40:05	2025-12-19 03:40:05
380	2025-12-11	Por venta de servicios Fact. Nro 7616	88	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	147.37	t	2025-12-19 03:40:05	2025-12-19 03:40:05
381	2025-12-01	Por venta de servicios Fact. Nro 1013	89	1.1.1.01	Caja Moneda Nacional	10443.79	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
382	2025-12-01	Por venta de servicios Fact. Nro 1013	89	5.1.1.02	Impuesto a las Transacciones (IT)	313.31	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
383	2025-12-01	Por venta de servicios Fact. Nro 1013	89	4.1.1.01	Venta de Servicios	0.00	9086.10	t	2025-12-19 03:40:05	2025-12-19 03:40:05
384	2025-12-01	Por venta de servicios Fact. Nro 1013	89	2.1.2.01	Débito Fiscal IVA	0.00	1357.69	t	2025-12-19 03:40:05	2025-12-19 03:40:05
385	2025-12-01	Por venta de servicios Fact. Nro 1013	89	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	313.31	t	2025-12-19 03:40:05	2025-12-19 03:40:05
386	2025-11-08	Por venta de servicios Fact. Nro 7623	90	1.1.1.01	Caja Moneda Nacional	1919.47	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
387	2025-11-08	Por venta de servicios Fact. Nro 7623	90	5.1.1.02	Impuesto a las Transacciones (IT)	57.58	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
388	2025-11-08	Por venta de servicios Fact. Nro 7623	90	4.1.1.01	Venta de Servicios	0.00	1669.94	t	2025-12-19 03:40:05	2025-12-19 03:40:05
389	2025-11-08	Por venta de servicios Fact. Nro 7623	90	2.1.2.01	Débito Fiscal IVA	0.00	249.53	t	2025-12-19 03:40:05	2025-12-19 03:40:05
390	2025-11-08	Por venta de servicios Fact. Nro 7623	90	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	57.58	t	2025-12-19 03:40:05	2025-12-19 03:40:05
391	2025-10-28	Por venta de servicios Fact. Nro 5422	91	1.1.1.01	Caja Moneda Nacional	2999.47	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
392	2025-10-28	Por venta de servicios Fact. Nro 5422	91	5.1.1.02	Impuesto a las Transacciones (IT)	89.98	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
393	2025-10-28	Por venta de servicios Fact. Nro 5422	91	4.1.1.01	Venta de Servicios	0.00	2609.54	t	2025-12-19 03:40:05	2025-12-19 03:40:05
394	2025-10-28	Por venta de servicios Fact. Nro 5422	91	2.1.2.01	Débito Fiscal IVA	0.00	389.93	t	2025-12-19 03:40:05	2025-12-19 03:40:05
395	2025-10-28	Por venta de servicios Fact. Nro 5422	91	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	89.98	t	2025-12-19 03:40:05	2025-12-19 03:40:05
396	2025-11-26	Por venta de servicios Fact. Nro 8344	92	1.1.1.01	Caja Moneda Nacional	10611.02	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
397	2025-11-26	Por venta de servicios Fact. Nro 8344	92	5.1.1.02	Impuesto a las Transacciones (IT)	318.33	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
398	2025-11-26	Por venta de servicios Fact. Nro 8344	92	4.1.1.01	Venta de Servicios	0.00	9231.59	t	2025-12-19 03:40:05	2025-12-19 03:40:05
399	2025-11-26	Por venta de servicios Fact. Nro 8344	92	2.1.2.01	Débito Fiscal IVA	0.00	1379.43	t	2025-12-19 03:40:05	2025-12-19 03:40:05
400	2025-11-26	Por venta de servicios Fact. Nro 8344	92	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	318.33	t	2025-12-19 03:40:05	2025-12-19 03:40:05
401	2025-12-04	Por venta de servicios Fact. Nro 1297	93	1.1.1.01	Caja Moneda Nacional	7204.87	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
402	2025-12-04	Por venta de servicios Fact. Nro 1297	93	5.1.1.02	Impuesto a las Transacciones (IT)	216.15	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
403	2025-12-04	Por venta de servicios Fact. Nro 1297	93	4.1.1.01	Venta de Servicios	0.00	6268.24	t	2025-12-19 03:40:05	2025-12-19 03:40:05
404	2025-12-04	Por venta de servicios Fact. Nro 1297	93	2.1.2.01	Débito Fiscal IVA	0.00	936.63	t	2025-12-19 03:40:05	2025-12-19 03:40:05
405	2025-12-04	Por venta de servicios Fact. Nro 1297	93	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	216.15	t	2025-12-19 03:40:05	2025-12-19 03:40:05
406	2025-09-27	Por venta de servicios Fact. Nro 1833	94	1.1.1.01	Caja Moneda Nacional	7564.96	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
407	2025-09-27	Por venta de servicios Fact. Nro 1833	94	5.1.1.02	Impuesto a las Transacciones (IT)	226.95	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
408	2025-09-27	Por venta de servicios Fact. Nro 1833	94	4.1.1.01	Venta de Servicios	0.00	6581.52	t	2025-12-19 03:40:05	2025-12-19 03:40:05
409	2025-09-27	Por venta de servicios Fact. Nro 1833	94	2.1.2.01	Débito Fiscal IVA	0.00	983.44	t	2025-12-19 03:40:05	2025-12-19 03:40:05
410	2025-09-27	Por venta de servicios Fact. Nro 1833	94	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	226.95	t	2025-12-19 03:40:05	2025-12-19 03:40:05
411	2025-12-06	Por venta de servicios Fact. Nro 7839	95	1.1.1.01	Caja Moneda Nacional	10779.25	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
412	2025-12-06	Por venta de servicios Fact. Nro 7839	95	5.1.1.02	Impuesto a las Transacciones (IT)	323.38	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
413	2025-12-06	Por venta de servicios Fact. Nro 7839	95	4.1.1.01	Venta de Servicios	0.00	9377.95	t	2025-12-19 03:40:05	2025-12-19 03:40:05
414	2025-12-06	Por venta de servicios Fact. Nro 7839	95	2.1.2.01	Débito Fiscal IVA	0.00	1401.30	t	2025-12-19 03:40:05	2025-12-19 03:40:05
415	2025-12-06	Por venta de servicios Fact. Nro 7839	95	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	323.38	t	2025-12-19 03:40:05	2025-12-19 03:40:05
416	2025-10-13	Por venta de servicios Fact. Nro 7960	96	1.1.1.01	Caja Moneda Nacional	10664.49	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
417	2025-10-13	Por venta de servicios Fact. Nro 7960	96	5.1.1.02	Impuesto a las Transacciones (IT)	319.93	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
418	2025-10-13	Por venta de servicios Fact. Nro 7960	96	4.1.1.01	Venta de Servicios	0.00	9278.11	t	2025-12-19 03:40:05	2025-12-19 03:40:05
419	2025-10-13	Por venta de servicios Fact. Nro 7960	96	2.1.2.01	Débito Fiscal IVA	0.00	1386.38	t	2025-12-19 03:40:05	2025-12-19 03:40:05
420	2025-10-13	Por venta de servicios Fact. Nro 7960	96	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	319.93	t	2025-12-19 03:40:05	2025-12-19 03:40:05
421	2025-10-21	Pago luz y agua Fact. 435	97	5.1.1.04	Servicios Básicos (Luz, Agua)	853.17	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
422	2025-10-21	Pago luz y agua Fact. 435	97	1.1.2.02	Crédito Fiscal IVA	127.48	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
423	2025-10-21	Pago luz y agua Fact. 435	97	1.1.1.01	Caja Moneda Nacional	0.00	980.65	t	2025-12-19 03:40:05	2025-12-19 03:40:05
424	2025-10-28	Por venta de servicios Fact. Nro 4853	98	1.1.1.01	Caja Moneda Nacional	5043.78	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
425	2025-10-28	Por venta de servicios Fact. Nro 4853	98	5.1.1.02	Impuesto a las Transacciones (IT)	151.31	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
426	2025-10-28	Por venta de servicios Fact. Nro 4853	98	4.1.1.01	Venta de Servicios	0.00	4388.09	t	2025-12-19 03:40:05	2025-12-19 03:40:05
427	2025-10-28	Por venta de servicios Fact. Nro 4853	98	2.1.2.01	Débito Fiscal IVA	0.00	655.69	t	2025-12-19 03:40:05	2025-12-19 03:40:05
428	2025-10-28	Por venta de servicios Fact. Nro 4853	98	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	151.31	t	2025-12-19 03:40:05	2025-12-19 03:40:05
429	2025-11-19	Por venta de servicios Fact. Nro 5905	99	1.1.1.01	Caja Moneda Nacional	8401.99	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
430	2025-11-19	Por venta de servicios Fact. Nro 5905	99	5.1.1.02	Impuesto a las Transacciones (IT)	252.06	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
431	2025-11-19	Por venta de servicios Fact. Nro 5905	99	4.1.1.01	Venta de Servicios	0.00	7309.73	t	2025-12-19 03:40:05	2025-12-19 03:40:05
432	2025-11-19	Por venta de servicios Fact. Nro 5905	99	2.1.2.01	Débito Fiscal IVA	0.00	1092.26	t	2025-12-19 03:40:05	2025-12-19 03:40:05
433	2025-11-19	Por venta de servicios Fact. Nro 5905	99	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	252.06	t	2025-12-19 03:40:05	2025-12-19 03:40:05
434	2025-09-23	Por venta de servicios Fact. Nro 5205	100	1.1.1.01	Caja Moneda Nacional	9334.34	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
435	2025-09-23	Por venta de servicios Fact. Nro 5205	100	5.1.1.02	Impuesto a las Transacciones (IT)	280.03	0.00	t	2025-12-19 03:40:05	2025-12-19 03:40:05
436	2025-09-23	Por venta de servicios Fact. Nro 5205	100	4.1.1.01	Venta de Servicios	0.00	8120.88	t	2025-12-19 03:40:05	2025-12-19 03:40:05
437	2025-09-23	Por venta de servicios Fact. Nro 5205	100	2.1.2.01	Débito Fiscal IVA	0.00	1213.46	t	2025-12-19 03:40:05	2025-12-19 03:40:05
438	2025-09-23	Por venta de servicios Fact. Nro 5205	100	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	0.00	280.03	t	2025-12-19 03:40:05	2025-12-19 03:40:05
\.


--
-- TOC entry 5027 (class 0 OID 49804)
-- Dependencies: 233
-- Data for Name: libros_diarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.libros_diarios (id, asiento, fecha, definicion, cuenta, debe, haber, user_id, created_at, updated_at, activo) FROM stdin;
\.


--
-- TOC entry 5014 (class 0 OID 49689)
-- Dependencies: 220
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2025_10_09_190033_create_libros_diarios_table	1
5	2025_10_09_195219_add_activo_to_libros_diarios_table	1
6	2025_10_09_210006_create_libro_diarios_table	1
7	2025_12_18_144816_add_role_to_users_table	1
8	2025_12_18_144818_create_plan_de_cuentas_table	1
\.


--
-- TOC entry 5017 (class 0 OID 49713)
-- Dependencies: 223
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 5031 (class 0 OID 49859)
-- Dependencies: 237
-- Data for Name: plan_de_cuentas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plan_de_cuentas (id, codigo, nombre, tipo, nivel, parent_id, es_imputable, created_at, updated_at) FROM stdin;
1	1	ACTIVO	activo	1	\N	f	2025-12-19 03:40:03	2025-12-19 03:40:03
2	1.1	ACTIVO CORRIENTE	activo	2	1	f	2025-12-19 03:40:03	2025-12-19 03:40:03
3	1.1.1	DISPONIBILIDADES	activo	3	2	f	2025-12-19 03:40:03	2025-12-19 03:40:03
4	1.1.1.01	Caja Moneda Nacional	activo	4	3	t	2025-12-19 03:40:03	2025-12-19 03:40:03
5	1.1.1.02	Banco Moneda Nacional	activo	4	3	t	2025-12-19 03:40:03	2025-12-19 03:40:03
6	2	PASIVO	pasivo	1	\N	f	2025-12-19 03:40:03	2025-12-19 03:40:03
7	2.1	PASIVO CORRIENTE	pasivo	2	6	f	2025-12-19 03:40:03	2025-12-19 03:40:03
8	2.1.1.01	Cuentas por Pagar	pasivo	4	7	t	2025-12-19 03:40:03	2025-12-19 03:40:03
9	3	PATRIMONIO	patrimonio	1	\N	f	2025-12-19 03:40:03	2025-12-19 03:40:03
10	3.1.1.01	Capital Social	patrimonio	4	9	t	2025-12-19 03:40:03	2025-12-19 03:40:03
11	4	INGRESOS	ingreso	1	\N	f	2025-12-19 03:40:03	2025-12-19 03:40:03
12	4.1.1.01	Venta de Servicios	ingreso	4	11	t	2025-12-19 03:40:03	2025-12-19 03:40:03
13	5	GASTOS	gasto	1	\N	f	2025-12-19 03:40:03	2025-12-19 03:40:03
14	5.1.1.01	Gastos Generales	gasto	4	13	t	2025-12-19 03:40:03	2025-12-19 03:40:03
15	1.1.1.03	Banco Bisa M.N.	activo	4	3	t	2025-12-19 03:40:03	2025-12-19 03:40:03
16	1.1.2	EXIGIBLE	activo	3	2	f	2025-12-19 03:40:03	2025-12-19 03:40:03
17	1.1.2.01	Cuentas por Cobrar Clientes	activo	4	16	t	2025-12-19 03:40:03	2025-12-19 03:40:03
18	1.1.2.02	Crédito Fiscal IVA	activo	4	16	t	2025-12-19 03:40:03	2025-12-19 03:40:03
19	1.1.2.03	Anticipo al personal	activo	4	16	t	2025-12-19 03:40:03	2025-12-19 03:40:03
20	1.2	ACTIVO NO CORRIENTE	activo	2	1	f	2025-12-19 03:40:03	2025-12-19 03:40:03
21	1.2.1	BIENES DE USO	activo	3	20	f	2025-12-19 03:40:03	2025-12-19 03:40:03
22	1.2.1.01	Muebles y Enseres	activo	4	21	t	2025-12-19 03:40:03	2025-12-19 03:40:03
23	1.2.1.02	Equipos de Computación	activo	4	21	t	2025-12-19 03:40:03	2025-12-19 03:40:03
24	2.1.2	OBLIGACIONES FISCALES	pasivo	3	7	f	2025-12-19 03:40:03	2025-12-19 03:40:03
25	2.1.2.01	Débito Fiscal IVA	pasivo	4	24	t	2025-12-19 03:40:03	2025-12-19 03:40:03
26	2.1.2.02	Impuesto a las Transacciones (IT) por Pagar	pasivo	4	24	t	2025-12-19 03:40:03	2025-12-19 03:40:03
27	2.1.2.03	IUE por Pagar	pasivo	4	24	t	2025-12-19 03:40:03	2025-12-19 03:40:03
28	2.1.2.04	RC-IVA por Pagar	pasivo	4	24	t	2025-12-19 03:40:03	2025-12-19 03:40:03
29	2.1.3	OBLIGACIONES LABORALES	pasivo	3	7	f	2025-12-19 03:40:03	2025-12-19 03:40:03
30	2.1.3.01	Sueldos y Salarios por Pagar	pasivo	4	29	t	2025-12-19 03:40:03	2025-12-19 03:40:03
31	2.1.3.02	Aportes Laborales por Pagar (AFP)	pasivo	4	29	t	2025-12-19 03:40:03	2025-12-19 03:40:03
32	2.1.3.03	Aportes Patronales por Pagar (CNS)	pasivo	4	29	t	2025-12-19 03:40:03	2025-12-19 03:40:03
33	3.1.1.02	Ajuste de Capital	patrimonio	4	9	t	2025-12-19 03:40:03	2025-12-19 03:40:03
34	3.1.1.03	Resultados Acumulados	patrimonio	4	9	t	2025-12-19 03:40:03	2025-12-19 03:40:03
35	5.1	GASTOS DE OPERACIÓN	gasto	2	13	f	2025-12-19 03:40:03	2025-12-19 03:40:03
36	5.1.1.02	Impuesto a las Transacciones (IT)	gasto	4	35	t	2025-12-19 03:40:03	2025-12-19 03:40:03
37	5.1.1.03	Sueldos y Salarios	gasto	4	35	t	2025-12-19 03:40:03	2025-12-19 03:40:03
38	5.1.1.04	Servicios Básicos (Luz, Agua)	gasto	4	35	t	2025-12-19 03:40:03	2025-12-19 03:40:03
39	5.1.1.05	Material de Escritorio	gasto	4	35	t	2025-12-19 03:40:03	2025-12-19 03:40:03
\.


--
-- TOC entry 5018 (class 0 OID 49722)
-- Dependencies: 224
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- TOC entry 5016 (class 0 OID 49699)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, role) FROM stdin;
1	Administrador	admin@admin.com	\N	$2y$12$OyPcxtwrkRj9CVm/tsRKVeaZPvbtHUrjWk0aWxrlmhOJkLHcc91xG	\N	2025-12-19 03:40:03	2025-12-19 03:40:03	admin
2	israel	pamurii357@gmail.com	\N	$2y$12$oIxMomcahMFIQRW47XwNC.iBdwLjSm.TonS5c5QUtBsItPQC2lz96	\N	2025-12-19 03:54:26	2025-12-19 03:54:26	user
\.


--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 230
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 234
-- Name: libro_diarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.libro_diarios_id_seq', 438, true);


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 232
-- Name: libros_diarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.libros_diarios_id_seq', 1, false);


--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 219
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 8, true);


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 236
-- Name: plan_de_cuentas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plan_de_cuentas_id_seq', 39, true);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 4840 (class 2606 OID 49753)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 4838 (class 2606 OID 49743)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 4847 (class 2606 OID 49800)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4849 (class 2606 OID 49802)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 4845 (class 2606 OID 49783)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 4842 (class 2606 OID 49768)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4859 (class 2606 OID 49851)
-- Name: libro_diarios libro_diarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro_diarios
    ADD CONSTRAINT libro_diarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4854 (class 2606 OID 49822)
-- Name: libros_diarios libros_diarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libros_diarios
    ADD CONSTRAINT libros_diarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4826 (class 2606 OID 49697)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4832 (class 2606 OID 49721)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 4861 (class 2606 OID 49882)
-- Name: plan_de_cuentas plan_de_cuentas_codigo_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan_de_cuentas
    ADD CONSTRAINT plan_de_cuentas_codigo_unique UNIQUE (codigo);


--
-- TOC entry 4863 (class 2606 OID 49875)
-- Name: plan_de_cuentas plan_de_cuentas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan_de_cuentas
    ADD CONSTRAINT plan_de_cuentas_pkey PRIMARY KEY (id);


--
-- TOC entry 4835 (class 2606 OID 49731)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4828 (class 2606 OID 49712)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 4830 (class 2606 OID 49710)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4843 (class 1259 OID 49769)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 4855 (class 1259 OID 49854)
-- Name: libro_diarios_codigo_cuenta_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libro_diarios_codigo_cuenta_index ON public.libro_diarios USING btree (codigo_cuenta);


--
-- TOC entry 4856 (class 1259 OID 49853)
-- Name: libro_diarios_fecha_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libro_diarios_fecha_index ON public.libro_diarios USING btree (fecha);


--
-- TOC entry 4857 (class 1259 OID 49852)
-- Name: libro_diarios_numero_asiento_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libro_diarios_numero_asiento_index ON public.libro_diarios USING btree (numero_asiento);


--
-- TOC entry 4850 (class 1259 OID 49828)
-- Name: libros_diarios_asiento_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libros_diarios_asiento_index ON public.libros_diarios USING btree (asiento);


--
-- TOC entry 4851 (class 1259 OID 49830)
-- Name: libros_diarios_definicion_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libros_diarios_definicion_index ON public.libros_diarios USING btree (definicion);


--
-- TOC entry 4852 (class 1259 OID 49829)
-- Name: libros_diarios_fecha_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libros_diarios_fecha_index ON public.libros_diarios USING btree (fecha);


--
-- TOC entry 4833 (class 1259 OID 49733)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 4836 (class 1259 OID 49732)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 4864 (class 2606 OID 49823)
-- Name: libros_diarios libros_diarios_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libros_diarios
    ADD CONSTRAINT libros_diarios_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4865 (class 2606 OID 49876)
-- Name: plan_de_cuentas plan_de_cuentas_parent_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan_de_cuentas
    ADD CONSTRAINT plan_de_cuentas_parent_id_foreign FOREIGN KEY (parent_id) REFERENCES public.plan_de_cuentas(id) ON DELETE SET NULL;


-- Completed on 2025-12-19 00:02:12

--
-- PostgreSQL database dump complete
--

\unrestrict y3Dui6E15VFBPwNxBg1wlr4OvMOHF5MKSs5lCeAqs3Dr9CFksOGAgZKaUG4Y3rU

