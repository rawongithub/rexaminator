--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: answers; Type: TABLE; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE TABLE answers (
    id integer NOT NULL,
    body text NOT NULL,
    correct boolean DEFAULT false NOT NULL,
    question_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.answers OWNER TO rexaminator;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: rexaminator
--

CREATE SEQUENCE answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answers_id_seq OWNER TO rexaminator;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rexaminator
--

ALTER SEQUENCE answers_id_seq OWNED BY answers.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.categories OWNER TO rexaminator;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: rexaminator
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO rexaminator;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rexaminator
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: categories_questions; Type: TABLE; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE TABLE categories_questions (
    question_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.categories_questions OWNER TO rexaminator;

--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0,
    attempts integer DEFAULT 0,
    handler text,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.delayed_jobs OWNER TO rexaminator;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: rexaminator
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delayed_jobs_id_seq OWNER TO rexaminator;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rexaminator
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: exam_questions; Type: TABLE; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE TABLE exam_questions (
    id integer NOT NULL,
    exam_id integer NOT NULL,
    question_id integer NOT NULL,
    answer1 boolean DEFAULT false NOT NULL,
    answer2 boolean DEFAULT false NOT NULL,
    answer3 boolean DEFAULT false NOT NULL,
    answer4 boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    state character varying(255),
    accurate boolean
);


ALTER TABLE public.exam_questions OWNER TO rexaminator;

--
-- Name: exam_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: rexaminator
--

CREATE SEQUENCE exam_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exam_questions_id_seq OWNER TO rexaminator;

--
-- Name: exam_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rexaminator
--

ALTER SEQUENCE exam_questions_id_seq OWNED BY exam_questions.id;


--
-- Name: exams; Type: TABLE; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE TABLE exams (
    id integer NOT NULL,
    sessionid character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    state character varying(255),
    completed_at timestamp without time zone
);


ALTER TABLE public.exams OWNER TO rexaminator;

--
-- Name: exams_id_seq; Type: SEQUENCE; Schema: public; Owner: rexaminator
--

CREATE SEQUENCE exams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exams_id_seq OWNER TO rexaminator;

--
-- Name: exams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rexaminator
--

ALTER SEQUENCE exams_id_seq OWNED BY exams.id;


--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE TABLE feedbacks (
    id integer NOT NULL,
    active boolean DEFAULT true NOT NULL,
    category character varying(255),
    body text,
    author character varying(255),
    question_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.feedbacks OWNER TO rexaminator;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: rexaminator
--

CREATE SEQUENCE feedbacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedbacks_id_seq OWNER TO rexaminator;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rexaminator
--

ALTER SEQUENCE feedbacks_id_seq OWNED BY feedbacks.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE TABLE questions (
    id integer NOT NULL,
    body text NOT NULL,
    active boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    comment text
);


ALTER TABLE public.questions OWNER TO rexaminator;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: rexaminator
--

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO rexaminator;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rexaminator
--

ALTER SEQUENCE questions_id_seq OWNED BY questions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO rexaminator;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE TABLE sessions (
    id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    data text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.sessions OWNER TO rexaminator;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: rexaminator
--

CREATE SEQUENCE sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO rexaminator;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rexaminator
--

ALTER SEQUENCE sessions_id_seq OWNED BY sessions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: rexaminator
--

ALTER TABLE ONLY answers ALTER COLUMN id SET DEFAULT nextval('answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: rexaminator
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: rexaminator
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: rexaminator
--

ALTER TABLE ONLY exam_questions ALTER COLUMN id SET DEFAULT nextval('exam_questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: rexaminator
--

ALTER TABLE ONLY exams ALTER COLUMN id SET DEFAULT nextval('exams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: rexaminator
--

ALTER TABLE ONLY feedbacks ALTER COLUMN id SET DEFAULT nextval('feedbacks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: rexaminator
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: rexaminator
--

ALTER TABLE ONLY sessions ALTER COLUMN id SET DEFAULT nextval('sessions_id_seq'::regclass);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: rexaminator
--

COPY answers (id, body, correct, question_id, created_at, updated_at) FROM stdin;
1	@Fixnum@	f	1	2009-11-15 15:40:30.909641	2009-11-15 15:40:30.909641
2	@Bignum@	f	1	2009-11-15 15:40:30.915522	2009-11-15 15:40:30.915522
3	@Numeric@	t	1	2009-11-15 15:40:30.917575	2009-11-15 15:40:30.917575
4	@BigDecimal@	f	1	2009-11-15 15:40:30.919543	2009-11-15 15:40:30.919543
5	@-123@	t	2	2009-11-15 15:42:48.398246	2009-11-15 15:42:48.398246
6	@0xFF@	t	2	2009-11-15 15:42:48.399654	2009-11-15 15:42:48.399654
7	@123_456_789@	t	2	2009-11-15 15:42:48.401069	2009-11-15 15:42:48.401069
8	@123456789123456789123456789123456789@	t	2	2009-11-15 15:42:48.402534	2009-11-15 15:42:48.402534
9	@.123@	f	3	2009-11-15 15:44:07.310153	2009-11-15 15:44:07.310153
10	@123.45@	t	3	2009-11-15 15:44:07.31159	2009-11-15 15:44:07.31159
11	@2.01e10@	t	3	2009-11-15 15:44:07.313122	2009-11-15 15:44:07.313122
12	@"123.45"@	f	3	2009-11-15 15:44:07.314627	2009-11-15 15:44:07.314627
13	@"0 + 2".to_i@	t	4	2009-11-15 15:45:31.723977	2009-11-15 15:45:31.723977
14	@4**(1/3)@	f	4	2009-11-15 15:45:31.725433	2010-01-05 07:58:58.726783
15	@nil.to_i@	t	4	2009-11-15 15:45:31.726969	2009-11-15 15:45:31.726969
16	@:zero.to_i@	f	4	2009-11-15 15:45:31.728407	2009-11-15 15:45:31.728407
17	@undef@	t	5	2009-11-15 15:46:22.527378	2009-11-15 15:46:22.527378
18	@redo@	t	5	2009-11-15 15:46:22.529361	2009-11-15 15:46:22.529361
19	@abstract@	f	5	2009-11-15 15:46:22.531321	2009-11-15 15:46:22.531321
20	@super@	t	5	2009-11-15 15:46:22.53329	2009-11-15 15:46:22.53329
21	@alias@	f	6	2009-11-15 15:47:07.088577	2009-11-15 15:47:07.088577
22	@yield@	f	6	2009-11-15 15:47:07.090544	2009-11-15 15:47:07.090544
23	@defined?@	f	6	2009-11-15 15:47:07.092483	2009-11-15 15:47:07.092483
24	@include?@	t	6	2009-11-15 15:47:07.094419	2009-11-15 15:47:07.094419
25	@str[0,-3]@	f	7	2009-11-15 15:48:32.709443	2009-11-15 15:48:32.709443
26	@str[-3,3]@	t	7	2009-11-15 15:48:32.711506	2009-11-15 15:48:32.711506
27	@str[4,3]@	f	7	2009-11-15 15:48:32.713343	2009-11-15 15:48:32.713343
28	@str['def']@	t	7	2009-11-15 15:48:32.715236	2009-11-15 15:48:32.715236
29	@str.to_a.size@	f	8	2009-11-15 15:49:47.166156	2009-11-15 15:49:47.166156
30	@str.size@	t	8	2009-11-15 15:49:47.167793	2009-11-15 15:49:47.167793
31	@str.to_i@	f	8	2009-11-15 15:49:47.169192	2009-11-15 15:49:47.169192
32	@str.length@	t	8	2009-11-15 15:49:47.170568	2009-11-15 15:49:47.170568
33	@[1,2,3,4,5]@	t	9	2009-11-15 15:50:31.867344	2009-11-15 15:50:31.867344
34	@Array.new(1,2,3,4,5)@	f	9	2009-11-15 15:50:31.868736	2009-11-15 15:50:31.868736
35	@Array.new(5){|a| a + 1 }@	t	9	2009-11-15 15:50:31.870113	2009-11-15 15:50:31.870113
36	@(1..5).to_a@	t	9	2009-11-15 15:50:31.871461	2009-11-15 15:50:31.871461
37	@Array.new@	t	10	2009-11-15 15:51:19.685177	2009-11-15 15:51:19.685177
38	@nil.to_a@	t	10	2009-11-15 15:51:19.686999	2009-11-15 15:51:19.686999
39	@Array.new(0)@	t	10	2009-11-15 15:51:19.688781	2009-11-15 15:51:19.688781
40	@Array.new(nil)@	f	10	2009-11-15 15:51:19.690615	2009-11-15 15:51:19.690615
41	@"abc".to_a@	f	11	2009-11-15 15:52:03.380879	2009-11-15 15:52:03.380879
42	@%w[a b c]@	t	11	2009-11-15 15:52:03.382325	2009-11-15 15:52:03.382325
43	@["a"] + ["b"] + ["c"]@	t	11	2009-11-15 15:52:03.383635	2009-11-15 15:52:03.383635
44	@["a"] << ["b"] << ["c"]@	f	11	2009-11-15 15:52:03.384998	2009-11-15 15:52:03.384998
45	@[1] << 2 << 3@	t	12	2009-11-15 15:52:48.145018	2009-11-15 15:52:48.145018
46	@[1,2,3,4,5] - [4,5]@	t	12	2009-11-15 15:52:48.146984	2009-11-15 15:52:48.146984
47	@[1,2,3,4] - 4@	f	12	2009-11-15 15:52:48.148795	2009-11-15 15:52:48.148795
48	@"1,2,3".split(',')@	f	12	2009-11-15 15:52:48.150659	2009-11-15 15:52:48.150659
49	@15.member? limit@	f	13	2009-11-15 15:53:30.848668	2009-11-15 15:53:30.848668
50	@limit.member? 10@	t	13	2009-11-15 15:53:30.850658	2009-11-15 15:53:30.850658
51	@limit.include? 20@	f	13	2009-11-15 15:53:30.852594	2009-11-15 15:53:30.852594
52	@limit.size < 100@	f	13	2009-11-15 15:53:30.854468	2009-11-15 15:53:30.854468
53	@5.member? range@	f	14	2009-11-15 15:54:13.7328	2009-11-15 15:54:13.7328
54	@range.member? 9@	f	14	2009-11-15 15:54:13.734957	2009-11-15 15:54:13.734957
55	@range.include? "5"@	t	14	2009-11-15 15:54:13.73685	2009-11-15 15:54:13.73685
56	@range == (0...10)@	t	14	2009-11-15 15:54:13.738763	2009-11-15 15:54:13.738763
57	@(1..5) > (1...5)@	f	15	2009-11-15 15:55:03.729072	2009-11-15 15:55:03.729072
58	@(1..5).to_a.size == (1...5).to_s.length@	t	15	2009-11-15 15:55:03.731027	2009-11-15 15:55:03.731027
59	@(1...5).include? 4.99@	t	15	2009-11-15 15:55:03.733007	2011-01-18 17:38:33.060515
60	@("e".."g").include? "g"@	t	15	2009-11-15 15:55:03.734423	2011-01-18 17:38:12.030789
61	@"thing".intern@	t	16	2009-11-15 15:57:17.519583	2009-11-15 15:57:17.519583
62	@%w[t h i n g].to_sym@	f	16	2009-11-15 15:57:17.521474	2009-11-15 15:57:17.521474
63	@%s[thing]@	t	16	2009-11-15 15:57:17.52336	2009-11-15 15:57:17.52336
64	@Symbol.new("thing")@	f	16	2009-11-15 15:57:17.525234	2009-11-15 15:57:17.525234
65	@:abc == "abc"@	f	17	2009-11-15 15:58:04.409961	2009-11-15 15:58:04.409961
66	@:abc.length == 3@	t	17	2009-11-15 15:58:04.411865	2011-01-18 17:48:59.397073
67	@:abc.object_id == :abc.object_id@	t	17	2009-11-15 15:58:04.413714	2011-01-18 17:48:59.444761
68	@true.to_sym == true@	f	17	2009-11-15 15:58:04.415767	2009-11-15 15:58:04.415767
73	@a == b@	t	19	2009-11-15 15:59:50.437286	2009-11-15 15:59:50.437286
74	@a.eql?(b)@	f	19	2009-11-15 15:59:50.439227	2009-11-15 15:59:50.439227
75	@a.equal?(b)@	f	19	2009-11-15 15:59:50.441134	2009-11-15 15:59:50.441134
76	@a.class == b.class@	f	19	2009-11-15 15:59:50.443025	2009-11-15 15:59:50.443025
77	@123 == 123.0@	f	20	2009-11-15 16:00:51.536698	2009-11-15 16:00:51.536698
78	@(1...5) === 5@	t	20	2009-11-15 16:00:51.53806	2009-11-15 16:00:51.53806
79	@"abc" == :abc@	t	20	2009-11-15 16:00:51.539406	2009-11-15 16:00:51.539406
80	@(1..10) != 1@	f	20	2009-11-15 16:00:51.540803	2009-11-15 16:00:51.540803
81	@true@	f	21	2009-11-15 16:01:36.622669	2009-11-15 16:01:36.622669
82	@1@	t	21	2009-11-15 16:01:36.624806	2009-11-15 16:01:36.624806
83	@-1@	f	21	2009-11-15 16:01:36.626819	2009-11-15 16:01:36.626819
84	@false@	f	21	2009-11-15 16:01:36.628804	2009-11-15 16:01:36.628804
89	No output - it is only class definition and it is not an executable ruby code.	f	23	2009-11-15 16:03:03.997022	2009-11-17 21:57:04.738477
90	@method\r\nvariable\r\nvariable@	f	23	2009-11-15 16:03:03.998517	2009-11-15 16:03:03.998517
91	@nil\r\nnil\r\nvariable@	f	23	2009-11-15 16:03:04.00008	2009-11-15 16:03:04.00008
92	@method\r\nnil\r\nvariable@	t	23	2009-11-15 16:03:04.001499	2009-11-15 16:03:04.001499
93	@method\r\nnil\r\nnil@	f	24	2009-11-15 16:03:51.309304	2009-11-15 16:03:51.309304
94	@uninitialized constant AssignConst::X (NameError)@	t	24	2009-11-15 16:03:51.310689	2009-11-15 16:03:51.310689
95	@nil\r\nnil\r\nnil@	f	24	2009-11-15 16:03:51.312071	2009-11-15 16:03:51.312071
96	@method\r\nnil\r\nmethod@	f	24	2009-11-15 16:03:51.313405	2009-11-15 16:03:51.313405
97	@1\r\n2\r\n3@	f	25	2009-11-15 16:04:38.142799	2009-11-15 16:04:38.142799
98	@1\r\n2\r\n5@	t	25	2009-11-15 16:04:38.144163	2009-11-15 16:04:38.144163
99	@false\r\n2\r\n5@	f	25	2009-11-15 16:04:38.145522	2009-12-28 17:53:45.011708
100	@false\r\nnil\r\n5@	f	25	2009-11-15 16:04:38.146886	2009-11-15 16:04:38.146886
101	@a = 1\r\nb=(1..3)@	f	26	2009-11-15 16:05:18.748382	2009-11-15 16:05:18.748382
102	@a = [1,2,3]\r\nb = 1@	t	26	2009-11-15 16:05:18.750325	2010-10-21 10:39:06.246354
103	@syntax error, unexpected ',', expecting '='@	f	26	2009-11-15 16:05:18.752282	2009-11-15 16:05:18.752282
104	@a = 1\r\nb = 1@	f	26	2009-11-15 16:05:18.865259	2010-10-21 10:39:06.278739
105	@a = 1\r\nb = 2\r\nc = [3, 4]@	f	27	2009-11-15 16:05:55.278435	2009-11-15 16:05:55.278435
106	@a = [1, 2]\r\nb = 3\r\nc = 4@	f	27	2009-11-15 16:05:55.280465	2009-11-15 16:05:55.280465
107	@a = 1\r\nb = 2\r\nc = 3@	t	27	2009-11-15 16:05:55.282452	2009-11-15 16:05:55.282452
108	@syntax error, unexpected 'nil=', expecting 'value='@	f	27	2009-11-15 16:05:55.28445	2009-11-15 16:05:55.28445
109	@a = 1\r\nb = 2\r\nc = [3, 4]@	t	28	2009-11-15 16:06:37.169803	2009-11-15 16:06:37.169803
110	@a = [1]\r\nb = [2]\r\nc = [3, 4]@	f	28	2009-11-15 16:06:37.17198	2009-11-15 16:06:37.17198
111	@a = 1\r\nb = 2\r\nc = 4@	f	28	2009-11-15 16:06:37.173995	2009-11-15 16:06:37.173995
112	@syntax error, unexpected '*', expecting '='@	f	28	2009-11-15 16:06:37.175903	2009-11-15 16:06:37.175903
113	@a = 1\r\nb = 2\r\nc = nil@	f	29	2009-11-15 16:07:41.985065	2009-11-15 16:07:41.985065
114	@a = 1\r\nb = 2\r\nc = []@	t	29	2009-11-15 16:07:41.98725	2009-11-15 16:07:41.98725
115	@a = 1\r\nb = 2\r\nc = [""]@	f	29	2009-11-15 16:07:41.98977	2009-12-28 17:55:37.831017
117	@a = 3\r\nb = 64@	f	30	2009-11-15 16:08:17.066766	2009-11-15 16:08:17.066766
118	@a = 7\r\nb = 256@	f	30	2009-11-15 16:08:17.069164	2009-11-15 16:08:17.069164
119	@a = 3\r\nb = 256@	t	30	2009-11-15 16:08:17.071607	2009-11-15 16:08:17.071607
120	@a = 7\r\nb = 64@	f	30	2009-11-15 16:08:17.073617	2009-11-15 16:08:17.073617
121	1\r\n2	f	31	2009-11-15 16:08:55.511713	2009-11-15 16:08:55.511713
122	nil\r\nnil	f	31	2009-11-15 16:08:55.513078	2009-11-15 16:08:55.513078
123	nil\r\n2	f	31	2009-11-15 16:08:55.514427	2009-11-15 16:08:55.514427
124	1\r\nnil	t	31	2009-11-15 16:08:55.515751	2009-11-15 16:08:55.515751
125	0	f	32	2009-11-15 16:09:32.90321	2009-11-15 16:09:32.90321
126	nil	t	32	2009-11-15 16:09:32.905168	2009-11-15 16:09:32.905168
127	abc	f	32	2009-11-15 16:09:32.907121	2009-11-15 16:09:32.907121
128	false	f	32	2009-11-15 16:09:32.908629	2009-11-15 16:09:32.908629
129	0\r\n1	f	33	2009-11-15 16:10:18.377436	2009-11-15 16:10:18.377436
130	0\r\n0	f	33	2009-11-15 16:10:18.378848	2009-11-15 16:10:18.378848
131	1\r\n0	f	33	2009-11-15 16:10:18.380177	2009-11-15 16:10:18.380177
132	1\r\n1	t	33	2009-11-15 16:10:18.381504	2009-11-15 16:10:18.381504
133	false\r\ntrue\r\ntrue	t	34	2009-11-15 16:11:05.499578	2009-11-15 16:11:05.499578
134	false\r\ntrue\r\n"hmm"	f	34	2009-11-15 16:11:05.501497	2009-11-15 16:11:05.501497
135	false\r\ntrue\r\nfalse	f	34	2009-11-15 16:11:05.503378	2009-11-15 16:11:05.503378
136	syntax error, unexpected ',', expecting kEND	f	34	2009-11-15 16:11:05.505336	2009-11-15 16:11:05.505336
137	[1,2,3]	f	35	2009-11-15 16:11:40.29547	2009-11-15 16:11:40.29547
138	<notextile>[4]</notextile>	t	35	2009-11-15 16:11:40.296872	2009-11-15 16:11:40.296872
139	[1,2,3,4]	f	35	2009-11-15 16:11:40.298222	2009-11-15 16:11:40.298222
140	<notextile>[1]</notextile>	f	35	2009-11-15 16:11:40.299571	2009-11-15 16:11:40.299571
141	a = 16\r\nb = 20	f	36	2011-02-27 18:58:15.531414	2011-02-27 18:58:15.531414
142	a = 4\r\nb = 5	t	36	2011-02-27 18:58:15.541006	2011-02-27 18:58:15.541006
143	a = 4\r\nb = 20	f	36	2011-02-27 18:58:15.54213	2011-02-27 18:58:15.54213
144	a = 16\r\nb = 5	f	36	2011-02-27 18:58:15.543219	2011-02-27 18:58:15.543219
145	true and 'false'	t	37	2011-02-27 19:19:39.270463	2011-02-27 19:19:39.270463
146	'abc' && 123	t	37	2011-02-27 19:19:39.275183	2011-02-27 19:19:39.275183
147	nil and 123	f	37	2011-02-27 19:19:39.276219	2011-02-27 19:19:39.276219
148	false && nil	f	37	2011-02-27 19:19:39.277239	2011-02-27 19:19:39.277239
149	not false	t	38	2011-02-27 19:22:15.754238	2011-02-27 19:22:15.754238
150	!  (1 == 2)	t	38	2011-02-27 19:22:15.755498	2011-02-27 19:22:15.755498
151	! true	f	38	2011-02-27 19:22:15.756547	2011-02-27 19:22:15.756547
152	not  (1 > 2)	t	38	2011-02-27 19:22:15.757564	2011-02-27 19:22:15.757564
153	(1 == 2) or (1 == 1)	t	39	2011-02-27 19:28:23.253094	2011-02-27 19:28:23.253094
154	false || false	f	39	2011-02-27 19:28:23.254385	2011-02-27 19:28:23.254385
155	(1 == 2) || (1 >2)	f	39	2011-02-27 19:28:23.255947	2011-02-27 19:28:23.255947
156	true || false	t	39	2011-02-27 19:28:23.257586	2011-02-27 19:28:23.257586
116	@undefined local variable or method 'c' for main:Object@	f	29	2009-11-15 16:07:41.992036	2011-02-27 22:26:50.069524
161	@true.class == Boolean@	f	41	2011-02-27 23:29:30.481243	2011-02-27 23:29:30.481243
164	@false.class.superclass == Object	t	41	2011-02-27 23:29:30.487177	2011-02-27 23:29:30.487177
165	@nil.class == NilClass@	t	42	2011-02-27 23:33:48.302578	2011-02-27 23:33:48.302578
167	@nil.class == nil@	f	42	2011-02-27 23:33:48.305259	2011-02-27 23:33:48.305259
168	@nil.superclass == BasicObject@	f	42	2011-02-27 23:33:48.306355	2011-02-27 23:33:48.306355
169	a = 'ruby\r\nb = 'ybur'\r\nc = 'ruby'	f	43	2011-02-28 00:25:07.256576	2011-02-28 00:25:07.256576
170	a = 'ruby\r\nb = 'ruby'\r\nc = 'ruby'	t	43	2011-02-28 00:25:07.258151	2011-02-28 00:25:07.258151
171	a = 'ruby\r\nb = 'ybur'\r\nc = 'ybur'	f	43	2011-02-28 00:25:07.259623	2011-02-28 00:25:07.259623
172	a = 'ybur\r\nb = 'ybur'\r\nc = 'ybur'	f	43	2011-02-28 00:25:07.261087	2011-02-28 00:25:07.261087
162	@true.is_a? Boolean@	f	41	2011-02-27 23:29:30.484966	2011-02-28 00:33:46.867491
205	@animals.first@	t	52	2011-03-14 21:15:19.922741	2011-03-14 21:17:02.683632
181	completed\r\ncompleted	f	46	2011-03-01 16:55:39.855472	2011-03-01 16:55:39.855472
166	@nil.is_a? Object@	t	42	2011-02-27 23:33:48.30413	2011-02-28 00:37:39.177006
175	a) cat likes dog\r\nb) cat likes nobody\r\nc) cat likes nobody\r\nd) cat likes dog	f	44	2011-03-01 15:31:59.722403	2011-03-01 15:31:59.722403
177	a) programmer loves ruby\r\nb) programmer loves\r\nc) programmer loves\r\nd) programmer loves ruby	f	45	2011-03-01 16:15:41.216365	2011-03-01 16:15:41.216365
178	a) programmer loves ruby\r\nb) <i>undefined method `reverse!' for nil:NilClass (NoMethodError)</i>\r\nc) <i>undefined method `reverse!' for nil:NilClass (NoMethodError)</i>\r\nd) programmer loves ruby	t	45	2011-03-01 16:15:41.217654	2011-03-01 16:16:50.093186
179	a) programmer loves ruby\r\nb) <i>undefined method `reverse!' for nil:NilClass (NoMethodError)</i>\r\nc) <i>wrong number of arguments (1 for 2) (ArgumentError)</i>\r\nd) <i>wrong number of arguments (3 for 2) (ArgumentError)</i>	f	45	2011-03-01 16:15:41.218816	2011-03-01 16:17:24.182476
180	a) programmer loves ruby\r\nb) programmer loves\r\nc) <i>wrong number of arguments (1 for 2) (ArgumentError)</i>\r\nd) <i>wrong number of arguments (3 for 2) (ArgumentError)</i>	f	45	2011-03-01 16:15:41.21995	2011-03-01 16:17:24.185486
173	a) cat likes dog\r\nb) cat likes nobody\r\nc) <i>wrong number of arguments (1 for 2) (ArgumentError)</i>\r\nd) <i>wrong number of arguments (3 for 2) (ArgumentError)</i>	t	44	2011-03-01 15:31:59.71619	2011-03-01 16:19:30.951452
174	a) cat likes dog\r\nb) <i>wrong number of arguments (1 for 2) (ArgumentError)</i>\r\nc) <i>wrong number of arguments (1 for 2) (ArgumentError)</i>\r\nd) <i>wrong number of arguments (3 for 2) (ArgumentError)</i>	f	44	2011-03-01 15:31:59.721021	2011-03-01 16:19:30.954315
176	a) cat likes dog\r\nb) cat likes nobody\r\nc) <i>wrong number of arguments (1 for 2) (ArgumentError)</i>\r\nd) cat likes dog	f	44	2011-03-01 15:31:59.723776	2011-03-01 16:19:30.958241
182	completed\r\ntaks2	f	46	2011-03-01 16:55:39.856759	2011-03-01 16:55:39.856759
183	task1\r\ntask2	f	46	2011-03-01 16:55:39.857825	2011-03-01 16:55:39.857825
184	task1\r\ncompleted	t	46	2011-03-01 16:55:39.858892	2011-03-01 16:55:39.858892
185	5\r\n5	f	47	2011-03-01 20:35:55.983899	2011-03-01 20:35:55.983899
186	5\r\n1	f	47	2011-03-01 20:35:55.989074	2011-03-01 20:35:55.989074
187	1\r\n5	f	47	2011-03-01 20:35:55.990511	2011-03-01 20:35:55.990511
188	1\r\n1	t	47	2011-03-01 20:35:55.991517	2011-03-01 20:35:55.991517
189	local	f	48	2011-03-01 21:32:56.667174	2011-03-01 21:32:56.667174
190	global	t	48	2011-03-01 21:32:56.673067	2011-03-01 21:32:56.673067
191	class	f	48	2011-03-01 21:32:56.6742	2011-03-01 21:32:56.6742
192	instance	f	48	2011-03-01 21:32:56.675256	2011-03-01 21:32:56.675256
193	global	f	49	2011-03-01 21:37:08.925392	2011-03-01 21:37:08.925392
194	constant	f	49	2011-03-01 21:37:08.926594	2011-03-01 21:37:08.926594
195	class	t	49	2011-03-01 21:37:08.927704	2011-03-01 21:37:08.927704
196	instance	f	49	2011-03-01 21:37:08.928828	2011-03-01 21:37:08.928828
197	local	f	50	2011-03-01 21:38:34.558525	2011-03-01 21:38:34.558525
198	global	f	50	2011-03-01 21:38:34.559712	2011-03-01 21:38:34.559712
199	instance	t	50	2011-03-01 21:38:34.560799	2011-03-01 21:38:34.560799
200	class	f	50	2011-03-01 21:38:34.561872	2011-03-01 21:38:34.561872
201	constant	t	51	2011-03-01 21:42:10.593971	2011-03-01 21:42:10.593971
202	global	f	51	2011-03-01 21:42:10.595514	2011-03-01 21:42:10.595514
203	local	f	51	2011-03-01 21:42:10.596974	2011-03-01 21:42:10.596974
204	class	f	51	2011-03-01 21:42:10.598181	2011-03-01 21:42:10.598181
163	@false.class == FalseClass@	t	41	2011-02-27 23:29:30.486073	2011-03-02 13:14:15.448544
206	@animals[1]@	f	52	2011-03-14 21:15:19.927413	2011-03-14 21:16:41.532531
207	@animals[0]@	t	52	2011-03-14 21:15:19.928339	2011-03-14 21:17:02.684747
208	@animals.zero@	f	52	2011-03-14 21:15:19.929271	2011-03-14 21:17:02.68567
209	@items.reverse[-1]@	f	53	2011-03-14 21:33:46.614067	2011-03-14 21:33:46.614067
210	@items.sort[2]@	t	53	2011-03-14 21:33:46.615214	2011-03-14 21:33:46.615214
212	@items[-2]@	t	53	2011-03-14 21:33:46.617244	2011-03-14 21:35:45.298599
211	@items.pop.last@	f	53	2011-03-14 21:33:46.61626	2011-03-14 21:37:53.421289
213	@['paper', 'gum']@	t	54	2011-03-14 21:51:37.571202	2011-03-14 22:07:14.505054
217	@[22, 43, 12, 7]@	f	55	2011-03-14 22:00:38.008008	2011-03-14 22:11:04.953143
157	@Ruby\r\n15\r\nGeneral\r\n10@	f	40	2011-02-27 20:16:07.990502	2011-03-15 14:00:36.363954
158	@Ruby\r\n10\r\nPython\r\n10@	f	40	2011-02-27 20:16:07.995627	2011-03-15 14:00:36.367241
159	@Ruby\r\n15\r\nGeneral\r\n20@	f	40	2011-02-27 20:16:07.996702	2011-03-15 14:00:36.368553
220	@[63, 8]@	t	55	2011-03-14 22:00:38.031972	2011-03-14 22:00:38.031972
214	@"paper"\r\n"gum"\r\n"metal"@	f	54	2011-03-14 21:51:37.572347	2011-03-14 22:07:14.506036
216	@["paper, "gum", "metal"]@	f	54	2011-03-14 21:51:37.57417	2011-03-14 22:07:14.507949
215	@"paper"\r\n"gum"@	f	54	2011-03-14 21:51:37.573262	2011-03-14 22:08:16.350866
219	@[63, 8, 22, 43]@	f	55	2011-03-14 22:00:38.030814	2011-03-14 22:12:13.3892
218	@index out of range (RuntimeError)@	f	55	2011-03-14 22:00:38.009086	2011-03-14 22:12:30.791579
221	@set[-1]@	f	56	2011-03-14 22:23:24.905869	2011-03-14 22:23:24.905869
222	@set[2, -2]@	t	56	2011-03-14 22:23:24.90693	2011-03-14 22:25:42.748346
223	@set[3, 0]@	f	56	2011-03-14 22:23:24.907822	2011-03-14 22:25:42.749398
224	@set[4, 0]@	t	56	2011-03-14 22:23:24.908743	2011-03-14 22:25:42.750293
225	@100\r\n100@	f	57	2011-03-15 09:15:48.483046	2011-03-15 09:15:48.483046
226	@50\r\n25@	f	57	2011-03-15 09:15:48.484505	2011-03-15 09:15:48.484505
227	@50\r\n100@	f	57	2011-03-15 09:15:48.485777	2011-03-15 09:15:48.485777
228	@50\r\n50@	t	57	2011-03-15 09:15:48.487019	2011-03-15 09:15:48.487019
229	@102\r\n102@	t	58	2011-03-15 10:16:23.288111	2011-03-15 10:16:23.288111
230	@102\r\n101@	f	58	2011-03-15 10:16:23.289202	2011-03-15 10:16:23.289202
231	@101\r\n101@	f	58	2011-03-15 10:16:23.290103	2011-03-15 10:16:23.290103
232	@102\r\nnil@	f	58	2011-03-15 10:16:23.291065	2011-03-15 10:16:23.291065
235	@open\r\n#<RuntimeError: mess!>\r\nclean\r\nclose@	f	59	2011-03-15 12:05:14.685473	2011-03-15 12:05:14.685473
233	@open\r\nnil\r\nclean\r\nclose@	f	59	2011-03-15 12:05:14.679556	2011-03-15 12:05:36.789801
234	@open\r\nclose@	f	59	2011-03-15 12:05:14.68454	2011-03-15 12:05:36.790767
236	@open\r\nmess!\r\nclean\r\nclose@	t	59	2011-03-15 12:05:14.686392	2011-03-15 12:05:36.791697
237	@1\r\nnil@	t	60	2011-03-15 12:24:21.763072	2011-03-15 12:24:21.763072
238	@2\r\n2@	f	60	2011-03-15 12:24:21.764181	2011-03-15 12:24:21.764181
239	@1\r\n2@	f	60	2011-03-15 12:24:21.765084	2011-03-15 12:24:21.765084
240	@2\r\nnil@	f	60	2011-03-15 12:24:21.765985	2011-03-15 12:24:21.765985
160	@Ruby\r\n15\r\nPython\r\n10@	t	40	2011-02-27 20:16:07.9978	2011-03-15 14:00:36.369683
\.


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rexaminator
--

SELECT pg_catalog.setval('answers_id_seq', 141, false);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: rexaminator
--

COPY categories (id, name, description, created_at, updated_at) FROM stdin;
1	Others	Questions that cannot be assign to any defined category.	2009-07-19 21:03:10	2009-07-20 19:50:35
2	Data Types		2009-07-20 19:51:38	2009-07-20 19:51:38
3	Numbers		2009-07-20 19:52:23	2009-07-20 19:52:23
4	Strings		2009-07-20 19:52:36	2009-07-20 19:52:36
5	Arrays		2009-07-20 19:52:46	2011-01-14 00:28:59.641143
6	Hashes		2009-07-20 19:52:56	2009-07-20 19:52:56
7	Ranges		2009-07-20 19:53:05	2009-07-20 19:53:05
8	Symbols		2009-07-20 19:53:15	2009-07-20 19:53:15
9	Keywords		2009-07-20 19:53:29	2009-07-20 19:53:29
10	Objects		2009-07-20 19:53:48	2009-07-20 19:53:48
11	Idioms		2009-07-22 21:21:28	2009-07-22 21:21:28
12	Regexp		2009-07-22 21:21:42	2009-07-22 21:21:42
13	Ruby 1.8	All questions specific for Ruby 1.8	2009-08-08 00:02:08	2009-08-08 00:02:47
14	Ruby 1.9	All questions specific for Ruby 1.9	2009-08-08 00:03:15	2009-08-08 00:03:15
15	Methods		2009-09-06 12:33:26	2009-09-06 12:33:26
16	Variables		2009-09-06 13:24:15	2009-09-06 13:24:15
17	Constants		2009-09-06 14:09:42	2009-09-06 14:10:05
18	Operators		2009-09-06 15:28:21	2009-09-06 15:28:21
19	Control Structures		2009-09-13 17:20:12	2009-09-13 17:20:12
20	Iterators		2009-09-23 19:25:16	2009-09-23 19:25:16
21	Procs		2011-03-01 16:21:17.55352	2011-03-01 16:21:17.55352
22	Exceptions		2011-03-15 12:06:39.053786	2011-03-15 12:06:39.053786
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rexaminator
--

SELECT pg_catalog.setval('categories_id_seq', 21, false);


--
-- Data for Name: categories_questions; Type: TABLE DATA; Schema: public; Owner: rexaminator
--

COPY categories_questions (question_id, category_id) FROM stdin;
1	2
1	3
2	2
2	3
3	2
3	3
4	2
4	3
5	9
6	9
7	4
8	4
9	5
10	5
11	5
12	5
13	2
13	7
14	2
14	7
15	2
15	7
15	13
16	2
16	8
17	2
17	4
17	8
19	10
20	10
21	10
23	16
24	17
25	11
26	16
27	16
28	16
29	16
30	18
31	19
32	19
33	19
34	7
34	19
35	5
35	19
17	14
36	3
37	2
37	18
38	2
38	18
39	2
39	18
40	10
41	2
42	2
43	4
43	16
43	10
45	21
44	21
46	21
47	10
48	16
49	16
50	16
51	16
52	5
53	5
54	5
55	5
56	5
57	17
57	10
58	17
58	10
59	22
60	22
1	2
1	3
2	2
2	3
3	2
3	3
4	2
4	3
5	9
6	9
7	4
8	4
9	5
10	5
11	5
12	5
13	2
13	7
14	2
14	7
15	2
15	7
15	13
16	2
16	8
17	2
17	4
17	8
19	10
20	10
21	10
23	16
24	17
25	11
26	16
27	16
28	16
29	16
30	18
31	19
32	19
33	19
34	7
34	19
35	5
35	19
17	14
\.


--
-- Data for Name: exam_questions; Type: TABLE DATA; Schema: public; Owner: rexaminator
--

COPY exam_questions (id, exam_id, question_id, answer1, answer2, answer3, answer4, created_at, updated_at, state, accurate) FROM stdin;
\.


--
-- Name: exam_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rexaminator
--

SELECT pg_catalog.setval('exam_questions_id_seq', 204, true);


--
-- Data for Name: exams; Type: TABLE DATA; Schema: public; Owner: rexaminator
--

COPY exams (id, sessionid, created_at, updated_at, state, completed_at) FROM stdin;
\.


--
-- Name: exams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rexaminator
--

SELECT pg_catalog.setval('exams_id_seq', 12, true);


--
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: rexaminator
--

COPY feedbacks (id, active, category, body, author, question_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rexaminator
--

SELECT pg_catalog.setval('feedbacks_id_seq', 36, false);


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: rexaminator
--

COPY questions (id, body, active, created_at, updated_at, comment) FROM stdin;
1	All Ruby number objects are instances of class _____.	t	2009-11-15 15:40:30.901625	2009-11-15 15:41:35.204546	\N
2	Which of the following are valid object of class Integer or one of its subclasses?	t	2009-11-15 15:42:48.396815	2009-11-15 15:44:16.100698	\N
3	Which of the following are valid floats?	t	2009-11-15 15:44:07.308543	2009-11-15 15:44:07.308543	\N
4	Which of the following expression will return _0_ (zero)?	t	2009-11-15 15:45:31.722352	2009-11-15 15:45:31.722352	\N
5	Which of the following are Ruby keywords?	t	2009-11-15 15:46:22.525311	2009-11-15 15:46:22.525311	\N
6	Which of the following are NOT Ruby keywords?	t	2009-11-15 15:47:07.086515	2009-11-15 15:47:07.086515	\N
7	We have given:\r\n@str = 'abcdef'@Which of the following will return the string _"def"_?	t	2009-11-15 15:48:32.707327	2009-11-15 15:48:32.707327	\N
8	How can we get the length of string _"str"_?	t	2009-11-15 15:49:47.164739	2009-11-15 15:49:47.164739	\N
9	Which of the following will create this array? @[1,2,3,4,5]@	t	2009-11-15 15:50:31.865901	2009-11-15 15:50:31.865901	\N
10	How can we create a new empty array?	t	2009-11-15 15:51:19.68325	2009-11-15 15:51:19.68325	\N
11	Which of the following will create this array? @[ "a", "b", "c" ]@	t	2009-11-15 15:52:03.379312	2009-11-15 15:52:03.379312	\N
12	Which of the following will create this array of integers? @[1,2,3]@	t	2009-11-15 15:52:48.033927	2009-11-15 15:52:48.033927	\N
13	We have given code @limit = (10...20)@ What of the following will return _true_?	t	2009-11-15 15:53:30.846617	2009-11-15 15:53:30.846617	\N
15	Which of the following will return _true_?	t	2009-11-15 15:55:03.727033	2011-01-18 17:31:16.379941
16	Which of the following creates symbol _:thing_?	t	2009-11-15 15:57:17.517563	2009-11-15 15:57:17.517563	\N
19	We have given code @a = 1\r\nb = 1.0@ Which of the following will return _true_?	t	2009-11-15 15:59:50.435201	2009-11-15 15:59:50.435201	\N
20	Which of the following will return _false_?	t	2009-11-15 16:00:51.535255	2009-11-15 16:00:51.535255	\N
21	What will be the output of the following code? \r\n@a = (1 <=> 2)\r\nb = (1 <=> 1.0)\r\nc = (b <=> a)\r\nputs c@	t	2009-11-15 16:01:36.62047	2009-11-15 16:01:36.62047	\N
23	What will be the output of the following code?\r\n@class Abc\r\n  def x\r\n    "method"\r\n  end\r\n  def getx\r\n    puts x\r\n    x = "variable" if false\r\n    puts x\r\n    x = "variable"\r\n    puts x\r\n  end\r\n  test = Abc.new\r\n  test.getx\r\nend@	t	2009-11-15 16:03:03.99545	2009-11-15 16:03:03.99545	\N
24	What will be the output of the following code?\r\n@class AssignConst\r\n  X = "constant" if false\r\n  def x\r\n    "method"\r\n  end\r\n  def getx\r\n    puts x\r\n    puts X\r\n    x = "variable" if false\r\n    puts x\r\n  end\r\nend\r\ntest = AssignConst.new\r\ntest.getx@	t	2009-11-15 16:03:51.30762	2009-11-15 16:03:51.30762	\N
25	What will be the output of the following code?\r\n@class Result\r\n  def values\r\n    a, b, c = false, nil, 5\r\n    a ||= 1\r\n    b ||= 2\r\n    c ||= 3\r\n    puts a, b, c\r\n  end\r\nend\r\ntest = Result.new\r\ntest.values@	t	2009-11-15 16:04:38.141289	2009-11-15 16:04:38.141289	\N
26	Determine the value of the variable _a_ and _b_ after the execution of the following code.\r\n@a = 1, 2, 3\r\nb, = 1, 2, 3@	t	2009-11-15 16:05:18.746333	2010-10-21 10:39:06.242538
27	Determine the value of the variable _a_, _b_ and _c_ after the execution of the following code.\r\n@a, b, c = 1, 2, 3, 4@	t	2009-11-15 16:05:55.276256	2009-11-15 16:05:55.276256	\N
28	Determine the value of the variable _a_, _b_ and _c_ after the execution of the following code.\r\n@a, b, *c = 1, 2, 3, 4@	t	2009-11-15 16:06:37.167708	2009-11-15 16:06:37.167708	\N
30	Determine the value of the variable _a_ and _b_ after the execution of the following code.\r\n@a = 10 - 5 - 2\r\nb = 2**2**3@	t	2009-11-15 16:08:17.064483	2009-11-15 16:08:17.064483	\N
31	What will be the output of the following code?\r\n@str = 'abc'\r\na = 1\r\nb = 2\r\na = str.reverse if str.size > 3\r\nb = (str.reverse if str.size > 3)\r\nputs a\r\nputs b@	t	2009-11-15 16:08:55.510317	2009-11-15 16:08:55.510317	\N
32	What will be the output of the following code?\r\n@x = 0\r\nstr = 'abc'\r\nstr = case\r\n        when x == 1 then 1\r\n        when x == 2 then 2\r\n        when x == 3 then 3\r\n        end\r\nputs str@	t	2009-11-15 16:09:32.900945	2009-11-15 16:09:32.900945	\N
33	What will be the output of the following code?\r\n@x = 0\r\ny = 0\r\ny = case\r\n    when x = 1 then x\r\n    when x > 0 then x\r\n    when x     then x\r\n    end\r\nputs y\r\nputs x@	t	2009-11-15 16:10:18.375967	2010-02-09 22:06:13.574815	\N
34	What will be the output of the following code?\r\n@def safe?(level)\r\n  case level\r\n  when (0...50), 'low' then false\r\n  when (50..100), 'high' then true\r\n  else 'hmm'\r\n  end\r\nend\r\nputs safe?(10)\r\nputs safe?('high')\r\nputs safe?(50)@	t	2009-11-15 16:11:05.497497	2009-11-15 16:11:05.497497	\N
35	Determine the value of the variable _a_ after the execution of the following code.\r\n@a = [1,2,3]\r\na.pop until a.empty?\r\na.push(4) while a.empty?@	t	2009-11-15 16:11:40.293973	2011-01-14 00:38:08.434705
36	Determine the value of the variable a and b after the execution of the following code.\r\n@a = 15 - 5 - 6\r\nb = 100 / 10 / 2@	t	2011-02-27 18:58:15.489314	2011-02-27 18:58:42.790787
17	Which of the following will return _true_?	t	2009-11-15 15:58:04.408039	2011-02-27 19:09:57.450604
37	Which of the following will return true?	t	2011-02-27 19:19:39.265021	2011-02-27 19:19:39.265021
38	Which of the following will return true?	t	2011-02-27 19:22:15.752722	2011-02-27 19:22:15.752722
39	Which of the following will return true?	t	2011-02-27 19:28:23.251669	2011-02-27 19:28:23.251669
29	Determine the value of the variable _a_, _b_ and _c_ after the execution of the following code.\r\n@a, b, *c = 1, 2@	t	2009-11-15 16:07:41.982785	2011-02-27 22:13:31.157948
40	What will be the output of the following code?\r\n<pre><code>class Exam\r\n  attr_reader :questions_count, :subject\r\n  def initialize(qc = 10)\r\n    @questions_count = qc\r\n    @subject = 'General'\r\n  end\r\nend\r\nclass RubyExam < Exam\r\n  def initialize(qc)\r\n    super\r\n    @subject = 'Ruby'\r\n  end\r\nend\r\nclass OtherExam < Exam\r\n  def initialize(qc, sub)\r\n    super()\r\n    @subject = sub\r\n  end\r\nend\r\ne1 = RubyExam.new(15)\r\ne2 = OtherExam.new(20, 'Python')\r\nputs e1.subject\r\nputs e1.questions_count\r\nputs e2.subject\r\nputs e2.questions_count</code></pre>	t	2011-02-27 20:16:07.985407	2011-02-27 23:09:32.915834
41	Which of the following will return <em>true<em>?	t	2011-02-27 23:29:30.476948	2011-02-27 23:30:07.579589	There is no Boolean class in Ruby.
42	Which of the following will return <em>true</em>	t	2011-02-27 23:33:48.300747	2011-02-27 23:33:48.300747
14	We have given code\r\n@range = (0..9)@Which of the following will return _false_?	t	2009-11-15 15:54:13.730773	2011-02-27 23:38:41.220779	There is no method 'member?' for 5:Fixnum (NoMethodError).
43	Determine the value of the variable a, b and c after the execution of the following code.\r\n@a = 'ruby'\r\nb = a\r\nb.reverse!\r\nc = b\r\nc.reverse!@	t	2011-02-28 00:25:07.254757	2011-02-28 00:26:45.319813
45	What will be the output of the following code in each of given cases <em>a, b, c, d</em>?\r\n\r\n@love = Proc.new do |a,b|\r\n  b.reverse!\r\n  puts "#{a} loves #{b}"\r\nend@\r\n\r\na)\r\n\r\n@love.call('programmer', 'ybur')@\r\n\r\nb)\r\n\r\n@love.call('programmer', nil)@  \r\n\r\nc)\r\n\r\n@love.call('programmer')@\r\n\r\nd)\r\n\r\n@love.call('programmer', 'ybur', 'avaj')@	t	2011-03-01 16:15:41.21483	2011-03-01 16:19:55.638396
44	What will be the output of the following code in each of given cases <em>a, b, c, d</em>?\r\n\r\n@friendship = lambda do |a,b|\r\n  return "#{a} likes nobody" if b.nil?\r\n  "#{a} likes #{b}"\r\nend@\r\n\r\na)\r\n\r\n@puts friendship.call('cat', 'dog')@\r\n\r\nb)\r\n\r\n@puts friendship.call('cat', nil)@  \r\n\r\nc)\r\n\r\n@puts friendship.call('cat')@\r\n\r\nd)\r\n\r\n@puts friendship.call('cat', 'dog', 'mouse')@	t	2011-03-01 15:31:59.711869	2011-03-15 10:28:38.953337
46	What will be the output of the following code?\r\n\r\n@def job1\r\n  describe = Proc.new{ return "task1"}\r\n  describe.call\r\n  return "completed"\r\nend\r\ndef job2\r\n  describe = lambda{ return "task2"}\r\n  describe.call\r\n  return "completed"\r\nend\r\nputs job1\r\nputs job2@	t	2011-03-01 16:55:39.853996	2011-03-01 16:56:06.896452
57	What will be the output of the following code?\r\n@POWER = 100\r\nclass Machine1\r\n  POWER = 50\r\n  def power\r\n    POWER\r\n  end\r\nend\r\nclass Machine2 < Machine1\r\n  POWER = 25\r\nend\r\nm1 = Machine1.new\r\nm2 = Machine2.new\r\nputs m1.power\r\nputs m2.power@	t	2011-03-15 09:15:48.481333	2011-03-15 09:56:06.369263
47	<pre><code>class Calc\r\n  attr_accessor :x\r\n  def initialize(x)\r\n    @x = x\r\n  end\r\n  def set_x(new_x)\r\n    x = new_x\r\n  end\r\n  def get_x\r\n    x\r\n  end\r\nend\r\n\r\nc = Calc.new(1)\r\nc.set_x(5)\r\np c.get_x\r\np c.x</code></pre>	t	2011-03-01 20:35:55.979547	2011-03-01 20:36:56.769688
58	What will be the output of the following code?\r\n@Keys = 101\r\nclass Keyboard\r\n  Keys = 102\r\n  def keys\r\n    Keys\r\n  end\r\n  class Nested\r\n    def keys\r\n      Keys\r\n    end\r\n  end\r\nend\r\nclass External < Keyboard\r\n  def keys\r\n    Keys\r\n  end\r\nend\r\nk1 = Keyboard::Nested.new\r\nk2 = External.new\r\nputs k1.keys\r\nputs k2.keys@	t	2011-03-15 10:16:23.286835	2011-03-15 10:19:08.633807
59	What will be the output of the following code?\r\n@def check\r\n  begin\r\n    puts "open"\r\n    fail "mess!"\r\n  rescue Exception => e\r\n    puts e\r\n    puts "clean"\r\n  ensure\r\n    puts "close"\r\n  end\r\nend\r\ncheck@	t	2011-03-15 12:05:14.675038	2011-03-15 12:08:22.443463
60	What will be the output of the following code?\r\n@begin\r\n  a = 3 / 0\r\n  b = a\r\nrescue Exception => e\r\n  a = 2\r\nensure\r\n  a = 1\r\nend\r\np a\r\np b@	t	2011-03-15 12:24:21.761849	2011-03-15 12:26:50.172641
51	What kind of variable is <em>Author</em> or <em>AUTHOR</em>?	t	2011-03-01 21:42:10.592237	2011-03-01 21:43:52.435471
49	What kind of variable is <em>@@x</em>?	t	2011-03-01 21:37:08.924076	2011-03-01 21:44:06.476295
48	What kind of variable is <em>$counter</em>?	t	2011-03-01 21:32:56.659849	2011-03-01 21:44:13.228133
50	What kind of variable is <em>@client</em>?	t	2011-03-01 21:38:34.557135	2011-03-01 21:45:40.558967
53	We have given code @items = %w(book table lamp)@ Which of the following will return <em>"table"</em>?	t	2011-03-14 21:33:46.612784	2011-03-14 21:43:22.655006
52	We have given code @animals = [:dog, :cat, :mouse]@ Which of the following will return <em>:dog</em>?	t	2011-03-14 21:15:19.918771	2011-03-14 21:43:38.898848
54	What will be the output of the following code? \r\n@materials = ['paper', 'gum', 'metal', 'wood']\r\nputs materials[0,2].inspect@	t	2011-03-14 21:51:37.569923	2011-03-14 22:08:36.692704
55	What will be the output of the following code? \r\n@data = [22, 43, 12, 7, 63, 8]\r\np data[-2, 4]@	t	2011-03-14 22:00:38.006781	2011-03-14 22:09:34.955897
56	We have given code @set = [:a, :b, :c]@ Which of the following will return <em>nil</em>?	t	2011-03-14 22:23:24.9046	2011-03-14 22:26:11.09515
\.


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rexaminator
--

SELECT pg_catalog.setval('questions_id_seq', 36, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: rexaminator
--

COPY schema_migrations (version) FROM stdin;
20080914190456
20080914190554
20080926225307
20080926225838
20081010003033
20081010003821
20081023225446
20081024221926
20081226192127
20090503122319
20090503122409
20090503141929
20090503195032
20090626215417
20090626224956
20090707213130
20090917214555
20110202232631
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: rexaminator
--

COPY sessions (id, session_id, data, created_at, updated_at) FROM stdin;
3675	46e6cee15631833dc4fff78a081c43c3	BAh7B0kiEF9jc3JmX3Rva2VuBjoGRUZJIjFBbkw4dWh1VTZmeXpCTnVickx4\nNUx0aUM3dUE3ZWFrdXN0NTdyWEJ1M0RBPQY7AEZJIglleGFtBjsARmkR\n	2019-01-05 14:40:42.551054	2019-01-05 14:40:58.613135
\.


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rexaminator
--

SELECT pg_catalog.setval('sessions_id_seq', 3675, true);


--
-- Name: answers_pkey; Type: CONSTRAINT; Schema: public; Owner: rexaminator; Tablespace:
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: rexaminator; Tablespace:
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: rexaminator; Tablespace:
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: exam_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: rexaminator; Tablespace:
--

ALTER TABLE ONLY exam_questions
    ADD CONSTRAINT exam_questions_pkey PRIMARY KEY (id);


--
-- Name: exams_pkey; Type: CONSTRAINT; Schema: public; Owner: rexaminator; Tablespace:
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT exams_pkey PRIMARY KEY (id);


--
-- Name: feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: rexaminator; Tablespace:
--

ALTER TABLE ONLY feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: rexaminator; Tablespace:
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: rexaminator; Tablespace:
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: index_answers_on_question_id; Type: INDEX; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE INDEX index_answers_on_question_id ON answers USING btree (question_id);


--
-- Name: index_categories_questions_on_category_id; Type: INDEX; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE INDEX index_categories_questions_on_category_id ON categories_questions USING btree (category_id);


--
-- Name: index_categories_questions_on_question_id; Type: INDEX; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE INDEX index_categories_questions_on_question_id ON categories_questions USING btree (question_id);


--
-- Name: index_exam_questions_on_exam_id; Type: INDEX; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE INDEX index_exam_questions_on_exam_id ON exam_questions USING btree (exam_id);


--
-- Name: index_exam_questions_on_question_id; Type: INDEX; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE INDEX index_exam_questions_on_question_id ON exam_questions USING btree (question_id);


--
-- Name: index_sessions_on_session_id; Type: INDEX; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE INDEX index_sessions_on_session_id ON sessions USING btree (session_id);


--
-- Name: index_sessions_on_updated_at; Type: INDEX; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE INDEX index_sessions_on_updated_at ON sessions USING btree (updated_at);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: rexaminator; Tablespace:
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

