--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6 (Homebrew)
-- Dumped by pg_dump version 14.6 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: grades; Type: TABLE; Schema: public; Owner: beckytarnowski
--

CREATE TABLE public.grades (
    id integer NOT NULL,
    student_github character varying(30),
    project_title character varying(30),
    grade integer
);


ALTER TABLE public.grades OWNER TO beckytarnowski;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: beckytarnowski
--

CREATE SEQUENCE public.grades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_id_seq OWNER TO beckytarnowski;

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: beckytarnowski
--

ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: beckytarnowski
--

CREATE TABLE public.projects (
    title character varying(30) NOT NULL,
    description character varying(1000000),
    max_grade integer
);


ALTER TABLE public.projects OWNER TO beckytarnowski;

--
-- Name: students; Type: TABLE; Schema: public; Owner: beckytarnowski
--

CREATE TABLE public.students (
    github character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL
);


ALTER TABLE public.students OWNER TO beckytarnowski;

--
-- Name: report_card_all; Type: VIEW; Schema: public; Owner: beckytarnowski
--

CREATE VIEW public.report_card_all AS
 SELECT students.first_name,
    students.last_name,
    projects.title,
    projects.max_grade,
    grades.grade
   FROM ((public.students
     LEFT JOIN public.grades ON (((students.github)::text = (grades.student_github)::text)))
     LEFT JOIN public.projects ON (((projects.title)::text = (grades.project_title)::text)));


ALTER TABLE public.report_card_all OWNER TO beckytarnowski;

--
-- Name: report_card_view; Type: VIEW; Schema: public; Owner: beckytarnowski
--

CREATE VIEW public.report_card_view AS
 SELECT students.first_name,
    students.last_name,
    projects.title,
    projects.max_grade,
    grades.grade
   FROM ((public.students
     JOIN public.grades ON (((students.github)::text = (grades.student_github)::text)))
     JOIN public.projects ON (((projects.title)::text = (grades.project_title)::text)));


ALTER TABLE public.report_card_view OWNER TO beckytarnowski;

--
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: beckytarnowski
--

ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: beckytarnowski
--

COPY public.grades (id, student_github, project_title, grade) FROM stdin;
1	jhacks	Markov	10
2	sdevelops	Markov	50
3	sdevelops	Blockly	100
4	jhacks	Blockly	2
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: beckytarnowski
--

COPY public.projects (title, description, max_grade) FROM stdin;
Markov	Tweets generated from Markov chains	50
Blockly	Programmatic Logic Puzzle Game	100
JavaScript Trials	Turn Python into Javascript	100
Sharkwords	Interactive word puzzle	100
React Practice	Practice React	75
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: beckytarnowski
--

COPY public.students (github, first_name, last_name) FROM stdin;
jhacks	Jane	Hacker
sdevelops	Sarah	Developer
rowint	Rowin	Tarnowski
erind	Erin	Dunkley
btarnow	Becky	Tarnowski
\.


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: beckytarnowski
--

SELECT pg_catalog.setval('public.grades_id_seq', 5, true);


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: beckytarnowski
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: beckytarnowski
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (title);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: beckytarnowski
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (github);


--
-- Name: grades grades_project_title_fkey; Type: FK CONSTRAINT; Schema: public; Owner: beckytarnowski
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_project_title_fkey FOREIGN KEY (project_title) REFERENCES public.projects(title);


--
-- Name: grades grades_student_github_fkey; Type: FK CONSTRAINT; Schema: public; Owner: beckytarnowski
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_student_github_fkey FOREIGN KEY (student_github) REFERENCES public.students(github);


--
-- PostgreSQL database dump complete
--

