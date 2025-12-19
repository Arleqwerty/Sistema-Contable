--
-- PostgreSQL database dump
-- quitar el '-copia' o simplemente hacer correr el scriptsql

\restrict Jq0bHTWFPYmoHv8jfSkYyBfTF2RckCrCQJJfZ3UY1gMvubA8T2IgOzgsGTMvA24

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-12-18 21:10:28

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
-- TOC entry 225 (class 1259 OID 25645)
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25655)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 41274)
-- Name: detalle_ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_ventas (
    id integer NOT NULL,
    venta_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    subtotal numeric(12,2) GENERATED ALWAYS AS (((cantidad)::numeric * precio_unitario)) STORED,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.detalle_ventas OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 41273)
-- Name: detalle_ventas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_ventas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_ventas_id_seq OWNER TO postgres;

--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 240
-- Name: detalle_ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_ventas_id_seq OWNED BY public.detalle_ventas.id;


--
-- TOC entry 231 (class 1259 OID 25696)
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
-- TOC entry 230 (class 1259 OID 25695)
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
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 230
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 229 (class 1259 OID 25681)
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
-- TOC entry 228 (class 1259 OID 25666)
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
-- TOC entry 227 (class 1259 OID 25665)
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
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 235 (class 1259 OID 25745)
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
-- TOC entry 234 (class 1259 OID 25744)
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
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 234
-- Name: libro_diarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.libro_diarios_id_seq OWNED BY public.libro_diarios.id;


--
-- TOC entry 233 (class 1259 OID 25715)
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
-- TOC entry 232 (class 1259 OID 25714)
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
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 232
-- Name: libros_diarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.libros_diarios_id_seq OWNED BY public.libros_diarios.id;


--
-- TOC entry 220 (class 1259 OID 25600)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25599)
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
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 219
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 223 (class 1259 OID 25624)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 49664)
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
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN plan_de_cuentas.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plan_de_cuentas.tipo IS 'Tipo de cuenta';


--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN plan_de_cuentas.es_imputable; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plan_de_cuentas.es_imputable IS 'Si se pueden registrar asientos en esta cuenta';


--
-- TOC entry 242 (class 1259 OID 49663)
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
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 242
-- Name: plan_de_cuentas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plan_de_cuentas_id_seq OWNED BY public.plan_de_cuentas.id;


--
-- TOC entry 237 (class 1259 OID 41245)
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    descripcion text,
    precio numeric(10,2) NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 41244)
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_id_seq OWNER TO postgres;

--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 236
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- TOC entry 224 (class 1259 OID 25633)
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
-- TOC entry 222 (class 1259 OID 25610)
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
-- TOC entry 221 (class 1259 OID 25609)
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
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 239 (class 1259 OID 41261)
-- Name: ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventas (
    id integer NOT NULL,
    fecha_venta date NOT NULL,
    total numeric(12,2) DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ventas OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 41260)
-- Name: ventas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ventas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ventas_id_seq OWNER TO postgres;

--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 238
-- Name: ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ventas_id_seq OWNED BY public.ventas.id;


--
-- TOC entry 4842 (class 2604 OID 41277)
-- Name: detalle_ventas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas ALTER COLUMN id SET DEFAULT nextval('public.detalle_ventas_id_seq'::regclass);


--
-- TOC entry 4824 (class 2604 OID 25699)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 4823 (class 2604 OID 25669)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 4830 (class 2604 OID 25748)
-- Name: libro_diarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro_diarios ALTER COLUMN id SET DEFAULT nextval('public.libro_diarios_id_seq'::regclass);


--
-- TOC entry 4826 (class 2604 OID 25718)
-- Name: libros_diarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libros_diarios ALTER COLUMN id SET DEFAULT nextval('public.libros_diarios_id_seq'::regclass);


--
-- TOC entry 4820 (class 2604 OID 25603)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4846 (class 2604 OID 49667)
-- Name: plan_de_cuentas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan_de_cuentas ALTER COLUMN id SET DEFAULT nextval('public.plan_de_cuentas_id_seq'::regclass);


--
-- TOC entry 4834 (class 2604 OID 41248)
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- TOC entry 4821 (class 2604 OID 25613)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4838 (class 2604 OID 41264)
-- Name: ventas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas ALTER COLUMN id SET DEFAULT nextval('public.ventas_id_seq'::regclass);


--
-- TOC entry 5054 (class 0 OID 25645)
-- Dependencies: 225
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6:timer	i:1766086150;	1766086150
laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6	i:1;	1766086150
\.


--
-- TOC entry 5055 (class 0 OID 25655)
-- Dependencies: 226
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 5070 (class 0 OID 41274)
-- Dependencies: 241
-- Data for Name: detalle_ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_ventas (id, venta_id, producto_id, cantidad, precio_unitario, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5060 (class 0 OID 25696)
-- Dependencies: 231
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 5058 (class 0 OID 25681)
-- Dependencies: 229
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 5057 (class 0 OID 25666)
-- Dependencies: 228
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- TOC entry 5064 (class 0 OID 25745)
-- Dependencies: 235
-- Data for Name: libro_diarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.libro_diarios (id, fecha, descripcion, numero_asiento, codigo_cuenta, nombre_cuenta, debe, haber, estado, created_at, updated_at) FROM stdin;
3	2025-10-09	Venta de mercaderías al contado	2	1	Caja	400.00	0.00	t	2025-10-10 00:00:32	2025-10-10 00:00:32
4	2025-10-09	Venta de mercaderías al contado	2	2	FinanciamientoSocios	0.00	400.00	t	2025-10-10 00:00:32	2025-10-10 00:00:32
7	2025-12-18	Por obtención de préstamo en efectivo s/doc adjunto.	4	5.1.1.01	Gastos Generales	2000.00	0.00	t	2025-12-18 16:10:40	2025-12-18 18:26:50
8	2025-12-18	Por obtención de préstamo en efectivo s/doc adjunto.	4	3.1.1.01	Capital Social	0.00	2000.00	t	2025-12-18 16:10:40	2025-12-18 18:26:50
5	2025-12-18	Por obtención de préstamo en efectivo s/doc adjunto.	3	1.1.1.01	Caja Moneda Nacional	2000.00	0.00	t	2025-12-18 15:06:12	2025-12-18 20:05:53
6	2025-12-18	Por obtención de préstamo en efectivo s/doc adjunto.	3	2.1.1.01	Cuentas por Pagar	0.00	2000.00	t	2025-12-18 15:06:12	2025-12-18 20:05:53
2	2025-10-09	Venta de mercaderías al contado	1	2	cuentas por pagar	0.00	20.00	t	2025-10-09 22:40:36	2025-12-18 20:06:22
1	2025-10-09	Venta de mercaderías al contado	1	1	caja	20.00	0.00	t	2025-10-09 22:40:36	2025-12-18 20:06:22
\.


--
-- TOC entry 5062 (class 0 OID 25715)
-- Dependencies: 233
-- Data for Name: libros_diarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.libros_diarios (id, asiento, fecha, definicion, cuenta, debe, haber, user_id, created_at, updated_at, activo) FROM stdin;
\.


--
-- TOC entry 5049 (class 0 OID 25600)
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
7	2025_12_18_144816_add_role_to_users_table	2
8	2025_12_18_144818_create_plan_de_cuentas_table	2
\.


--
-- TOC entry 5052 (class 0 OID 25624)
-- Dependencies: 223
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 5072 (class 0 OID 49664)
-- Dependencies: 243
-- Data for Name: plan_de_cuentas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plan_de_cuentas (id, codigo, nombre, tipo, nivel, parent_id, es_imputable, created_at, updated_at) FROM stdin;
1	1	ACTIVO	activo	1	\N	f	2025-12-18 14:57:27	2025-12-18 14:57:27
2	1.1	ACTIVO CORRIENTE	activo	2	1	f	2025-12-18 14:57:27	2025-12-18 14:57:27
3	1.1.1	DISPONIBILIDADES	activo	3	2	f	2025-12-18 14:57:27	2025-12-18 14:57:27
4	1.1.1.01	Caja Moneda Nacional	activo	4	3	t	2025-12-18 14:57:27	2025-12-18 14:57:27
5	1.1.1.02	Banco Moneda Nacional	activo	4	3	t	2025-12-18 14:57:27	2025-12-18 14:57:27
6	2	PASIVO	pasivo	1	\N	f	2025-12-18 14:57:27	2025-12-18 14:57:27
7	2.1	PASIVO CORRIENTE	pasivo	2	6	f	2025-12-18 14:57:27	2025-12-18 14:57:27
8	2.1.1.01	Cuentas por Pagar	pasivo	4	7	t	2025-12-18 14:57:27	2025-12-18 14:57:27
9	3	PATRIMONIO	patrimonio	1	\N	f	2025-12-18 14:57:27	2025-12-18 14:57:27
10	3.1.1.01	Capital Social	patrimonio	4	9	t	2025-12-18 14:57:27	2025-12-18 14:57:27
11	4	INGRESOS	ingreso	1	\N	f	2025-12-18 14:57:27	2025-12-18 14:57:27
12	4.1.1.01	Venta de Servicios	ingreso	4	11	t	2025-12-18 14:57:27	2025-12-18 14:57:27
13	5	GASTOS	gasto	1	\N	f	2025-12-18 14:57:27	2025-12-18 14:57:27
14	5.1.1.01	Gastos Generales	gasto	4	13	t	2025-12-18 14:57:27	2025-12-18 14:57:27
\.


--
-- TOC entry 5066 (class 0 OID 41245)
-- Dependencies: 237
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, nombre, descripcion, precio, stock, created_at, updated_at) FROM stdin;
1	Laptop Lenovo	Laptop gama media	3500.00	10	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
2	Mouse Gamer	RGB 7200 DPI	120.00	50	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
3	Teclado Mecánico	Switch Blue	250.00	40	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
4	Monitor LG 27"	144Hz IPS	2100.00	15	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
5	USB 32GB	Kingston	35.00	100	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
6	Impresora HP DeskJet	Impresora doméstica	650.00	20	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
7	Mouse Inalámbrico	Óptico 1600 DPI	90.00	60	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
8	Router TP-Link	300 Mbps	180.00	35	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
9	Silla Gamer	Ergonómica	1200.00	10	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
10	Parlantes Logitech	2.1 Sonido envolvente	350.00	25	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
11	Webcam Full HD	1080p	150.00	40	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
12	Disco Duro 1TB	Western Digital	420.00	30	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
13	SSD 512GB	NVMe Kingston	580.00	50	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
14	Memoria RAM 8GB	DDR4 2666MHz	220.00	70	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
15	Tarjeta de Video GTX 1650	4GB GDDR6	1900.00	8	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
16	Audífonos JBL	Sonido profesional	260.00	45	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
17	Parlantes Bluetooth	Portátil	110.00	50	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
18	Tablet Samsung 10"	32GB Storage	1300.00	12	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
19	Smartwatch Amazfit	Sensor cardíaco	700.00	25	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
20	Cable HDMI	2 metros 4K	30.00	200	2025-12-04 20:06:39.049726	2025-12-04 20:06:39.049726
\.


--
-- TOC entry 5053 (class 0 OID 25633)
-- Dependencies: 224
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- TOC entry 5051 (class 0 OID 25610)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, role) FROM stdin;
2	zaira	zaira@gmail.com	\N	$2y$12$pQ8NFieG0ZzV1G0zevFUNOMw8ORLBKQ8/x06KioqOHaUA01tIBYcq	5IoJPGTMSFH2DTW9isOrnAgdnv9QYGY2VR81zRfpehVVQ2LghH2kDLjoWH3Y	2025-12-18 16:04:14	2025-12-18 16:04:14	user
3	Administrador	admin@admin.com	\N	$2y$12$ambsJ4YLc5hVVOxchVOEpO9r.WpjnaysN1oQeya357Y8GABAkT9rC	\N	2025-12-18 17:27:49	2025-12-18 17:27:49	admin
1	israel	pamurii357@gmail.com	\N	$2y$12$MSuexv5myxe5O5tkvUdMb.9oAK0YtbkMZ3WinRks3H6i/Kin3BUpy	k7zshiCPc0PjTGuwQkoAMVqdXE7FZtDkZGMdZzp7mfOCkJyT4wYAOezQu5w7	2025-10-09 22:32:53	2025-10-09 22:32:53	user
\.


--
-- TOC entry 5068 (class 0 OID 41261)
-- Dependencies: 239
-- Data for Name: ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventas (id, fecha_venta, total, created_at, updated_at) FROM stdin;
1	2025-01-01	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
2	2025-01-02	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
3	2025-01-03	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
4	2025-01-04	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
5	2025-01-05	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
6	2025-01-06	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
7	2025-01-10	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
8	2025-01-12	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
9	2025-01-15	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
10	2025-01-17	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
11	2025-01-20	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
12	2025-01-22	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
13	2025-01-25	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
14	2025-01-27	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
15	2025-01-30	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
16	2025-02-01	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
17	2025-02-03	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
18	2025-02-05	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
19	2025-02-07	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
20	2025-02-10	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
21	2025-02-12	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
22	2025-02-14	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
23	2025-02-16	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
24	2025-02-18	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
25	2025-02-20	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
26	2025-02-22	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
27	2025-02-24	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
28	2025-03-01	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
29	2025-03-04	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
30	2025-03-06	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
31	2025-03-08	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
32	2025-03-10	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
33	2025-03-14	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
34	2025-03-16	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
35	2025-03-18	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
36	2025-03-20	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
37	2025-03-22	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
38	2025-03-25	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
39	2025-03-28	0.00	2025-12-04 20:06:39.059132	2025-12-04 20:06:39.059132
\.


--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 240
-- Name: detalle_ventas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_ventas_id_seq', 42, true);


--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 230
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 234
-- Name: libro_diarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.libro_diarios_id_seq', 8, true);


--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 232
-- Name: libros_diarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.libros_diarios_id_seq', 1, false);


--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 219
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 8, true);


--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 242
-- Name: plan_de_cuentas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plan_de_cuentas_id_seq', 14, true);


--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 236
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 20, true);


--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 238
-- Name: ventas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ventas_id_seq', 39, true);


--
-- TOC entry 4867 (class 2606 OID 25664)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 4865 (class 2606 OID 25654)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 4892 (class 2606 OID 41287)
-- Name: detalle_ventas detalle_ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_pkey PRIMARY KEY (id);


--
-- TOC entry 4874 (class 2606 OID 25711)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4876 (class 2606 OID 25713)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 4872 (class 2606 OID 25694)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 4869 (class 2606 OID 25679)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4886 (class 2606 OID 25762)
-- Name: libro_diarios libro_diarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro_diarios
    ADD CONSTRAINT libro_diarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4881 (class 2606 OID 25733)
-- Name: libros_diarios libros_diarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libros_diarios
    ADD CONSTRAINT libros_diarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4853 (class 2606 OID 25608)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4859 (class 2606 OID 25632)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 4894 (class 2606 OID 49687)
-- Name: plan_de_cuentas plan_de_cuentas_codigo_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan_de_cuentas
    ADD CONSTRAINT plan_de_cuentas_codigo_unique UNIQUE (codigo);


--
-- TOC entry 4896 (class 2606 OID 49680)
-- Name: plan_de_cuentas plan_de_cuentas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan_de_cuentas
    ADD CONSTRAINT plan_de_cuentas_pkey PRIMARY KEY (id);


--
-- TOC entry 4888 (class 2606 OID 41259)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4862 (class 2606 OID 25642)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4855 (class 2606 OID 25623)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 4857 (class 2606 OID 25621)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 41272)
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id);


--
-- TOC entry 4870 (class 1259 OID 25680)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 4882 (class 1259 OID 25765)
-- Name: libro_diarios_codigo_cuenta_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libro_diarios_codigo_cuenta_index ON public.libro_diarios USING btree (codigo_cuenta);


--
-- TOC entry 4883 (class 1259 OID 25764)
-- Name: libro_diarios_fecha_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libro_diarios_fecha_index ON public.libro_diarios USING btree (fecha);


--
-- TOC entry 4884 (class 1259 OID 25763)
-- Name: libro_diarios_numero_asiento_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libro_diarios_numero_asiento_index ON public.libro_diarios USING btree (numero_asiento);


--
-- TOC entry 4877 (class 1259 OID 25739)
-- Name: libros_diarios_asiento_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libros_diarios_asiento_index ON public.libros_diarios USING btree (asiento);


--
-- TOC entry 4878 (class 1259 OID 25741)
-- Name: libros_diarios_definicion_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libros_diarios_definicion_index ON public.libros_diarios USING btree (definicion);


--
-- TOC entry 4879 (class 1259 OID 25740)
-- Name: libros_diarios_fecha_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libros_diarios_fecha_index ON public.libros_diarios USING btree (fecha);


--
-- TOC entry 4860 (class 1259 OID 25644)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 4863 (class 1259 OID 25643)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 4898 (class 2606 OID 41293)
-- Name: detalle_ventas fk_det_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT fk_det_producto FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;


--
-- TOC entry 4899 (class 2606 OID 41288)
-- Name: detalle_ventas fk_det_venta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT fk_det_venta FOREIGN KEY (venta_id) REFERENCES public.ventas(id) ON DELETE CASCADE;


--
-- TOC entry 4897 (class 2606 OID 25734)
-- Name: libros_diarios libros_diarios_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libros_diarios
    ADD CONSTRAINT libros_diarios_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4900 (class 2606 OID 49681)
-- Name: plan_de_cuentas plan_de_cuentas_parent_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan_de_cuentas
    ADD CONSTRAINT plan_de_cuentas_parent_id_foreign FOREIGN KEY (parent_id) REFERENCES public.plan_de_cuentas(id) ON DELETE SET NULL;


-- Completed on 2025-12-18 21:10:29

--
-- PostgreSQL database dump complete
--

\unrestrict Jq0bHTWFPYmoHv8jfSkYyBfTF2RckCrCQJJfZ3UY1gMvubA8T2IgOzgsGTMvA24

