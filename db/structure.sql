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

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: colleges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.colleges (
    id bigint NOT NULL,
    field_of_study character varying NOT NULL,
    faculty character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: colleges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.colleges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: colleges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.colleges_id_seq OWNED BY public.colleges.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employees (
    id bigint NOT NULL,
    academic_degree character varying(50) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    role integer DEFAULT 1 NOT NULL
);


--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- Name: graduation_works; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.graduation_works (
    id bigint NOT NULL,
    title character varying,
    topic character varying NOT NULL,
    date_of_submission timestamp without time zone NOT NULL,
    stage_of_study_id bigint NOT NULL,
    supervisor_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: graduation_works_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.graduation_works_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: graduation_works_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.graduation_works_id_seq OWNED BY public.graduation_works.id;


--
-- Name: key_words; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.key_words (
    id bigint NOT NULL,
    key_word character varying NOT NULL,
    graduation_work_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: key_words_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.key_words_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: key_words_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.key_words_id_seq OWNED BY public.key_words.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    graduation_work_id bigint NOT NULL,
    reviewer_id bigint NOT NULL,
    grade numeric NOT NULL,
    comment text NOT NULL,
    date_of_issue timestamp without time zone DEFAULT '2022-01-22 22:35:53.913043'::timestamp without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: stage_of_studies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stage_of_studies (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: stage_of_studies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stage_of_studies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stage_of_studies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stage_of_studies_id_seq OWNED BY public.stage_of_studies.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.students (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    telephone_number character varying NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    college_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: thesis_defenses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.thesis_defenses (
    id bigint NOT NULL,
    defence_address character varying NOT NULL,
    final_grade numeric,
    date_of_defence timestamp without time zone DEFAULT '2022-01-22 16:22:58.933932'::timestamp without time zone NOT NULL,
    evaluator_id bigint NOT NULL,
    author_id bigint NOT NULL,
    graduation_work_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: thesis_defenses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.thesis_defenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: thesis_defenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.thesis_defenses_id_seq OWNED BY public.thesis_defenses.id;


--
-- Name: colleges id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.colleges ALTER COLUMN id SET DEFAULT nextval('public.colleges_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- Name: graduation_works id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graduation_works ALTER COLUMN id SET DEFAULT nextval('public.graduation_works_id_seq'::regclass);


--
-- Name: key_words id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.key_words ALTER COLUMN id SET DEFAULT nextval('public.key_words_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: stage_of_studies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stage_of_studies ALTER COLUMN id SET DEFAULT nextval('public.stage_of_studies_id_seq'::regclass);


--
-- Name: students id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: thesis_defenses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.thesis_defenses ALTER COLUMN id SET DEFAULT nextval('public.thesis_defenses_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: colleges colleges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.colleges
    ADD CONSTRAINT colleges_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: graduation_works graduation_works_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graduation_works
    ADD CONSTRAINT graduation_works_pkey PRIMARY KEY (id);


--
-- Name: key_words key_words_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.key_words
    ADD CONSTRAINT key_words_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: stage_of_studies stage_of_studies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stage_of_studies
    ADD CONSTRAINT stage_of_studies_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: thesis_defenses thesis_defenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.thesis_defenses
    ADD CONSTRAINT thesis_defenses_pkey PRIMARY KEY (id);


--
-- Name: index_employees_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_employees_on_email ON public.employees USING btree (email);


--
-- Name: index_employees_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_employees_on_reset_password_token ON public.employees USING btree (reset_password_token);


--
-- Name: index_graduation_works_on_stage_of_study_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_graduation_works_on_stage_of_study_id ON public.graduation_works USING btree (stage_of_study_id);


--
-- Name: index_graduation_works_on_supervisor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_graduation_works_on_supervisor_id ON public.graduation_works USING btree (supervisor_id);


--
-- Name: index_key_words_on_graduation_work_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_key_words_on_graduation_work_id ON public.key_words USING btree (graduation_work_id);


--
-- Name: index_reviews_on_graduation_work_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_graduation_work_id ON public.reviews USING btree (graduation_work_id);


--
-- Name: index_reviews_on_reviewer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_reviewer_id ON public.reviews USING btree (reviewer_id);


--
-- Name: index_students_on_college_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_students_on_college_id ON public.students USING btree (college_id);


--
-- Name: index_students_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_students_on_email ON public.students USING btree (email);


--
-- Name: index_students_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_students_on_reset_password_token ON public.students USING btree (reset_password_token);


--
-- Name: index_thesis_defenses_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_thesis_defenses_on_author_id ON public.thesis_defenses USING btree (author_id);


--
-- Name: index_thesis_defenses_on_evaluator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_thesis_defenses_on_evaluator_id ON public.thesis_defenses USING btree (evaluator_id);


--
-- Name: index_thesis_defenses_on_graduation_work_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_thesis_defenses_on_graduation_work_id ON public.thesis_defenses USING btree (graduation_work_id);


--
-- Name: reviews fk_rails_007031d9cb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_007031d9cb FOREIGN KEY (reviewer_id) REFERENCES public.employees(id);


--
-- Name: students fk_rails_1d4ff93d0b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT fk_rails_1d4ff93d0b FOREIGN KEY (college_id) REFERENCES public.colleges(id);


--
-- Name: key_words fk_rails_4135c68f2c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.key_words
    ADD CONSTRAINT fk_rails_4135c68f2c FOREIGN KEY (graduation_work_id) REFERENCES public.graduation_works(id);


--
-- Name: graduation_works fk_rails_72d54ffd71; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graduation_works
    ADD CONSTRAINT fk_rails_72d54ffd71 FOREIGN KEY (stage_of_study_id) REFERENCES public.stage_of_studies(id);


--
-- Name: thesis_defenses fk_rails_8f924c616b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.thesis_defenses
    ADD CONSTRAINT fk_rails_8f924c616b FOREIGN KEY (graduation_work_id) REFERENCES public.graduation_works(id);


--
-- Name: graduation_works fk_rails_97bf20bf5d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graduation_works
    ADD CONSTRAINT fk_rails_97bf20bf5d FOREIGN KEY (supervisor_id) REFERENCES public.employees(id);


--
-- Name: reviews fk_rails_ae87274649; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_ae87274649 FOREIGN KEY (graduation_work_id) REFERENCES public.graduation_works(id);


--
-- Name: thesis_defenses fk_rails_c3a71e7e4b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.thesis_defenses
    ADD CONSTRAINT fk_rails_c3a71e7e4b FOREIGN KEY (evaluator_id) REFERENCES public.employees(id);


--
-- Name: thesis_defenses fk_rails_d2b63b2de5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.thesis_defenses
    ADD CONSTRAINT fk_rails_d2b63b2de5 FOREIGN KEY (author_id) REFERENCES public.students(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20220119183617'),
('20220119183719'),
('20220119221100'),
('20220119223314'),
('20220119224221'),
('20220119230724'),
('20220122155747'),
('20220122223040'),
('20220124153551');


