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
-- Name: ability_contents; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE ability_contents (
    id integer NOT NULL,
    pme_ability_id integer,
    nombre character varying,
    descripcion text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ability_contents OWNER TO vagrant;

--
-- Name: ability_contents_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE ability_contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ability_contents_id_seq OWNER TO vagrant;

--
-- Name: ability_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE ability_contents_id_seq OWNED BY ability_contents.id;


--
-- Name: alternatives; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE alternatives (
    id integer NOT NULL,
    texto text,
    correcta boolean,
    question_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.alternatives OWNER TO vagrant;

--
-- Name: alternatives_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE alternatives_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alternatives_id_seq OWNER TO vagrant;

--
-- Name: alternatives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE alternatives_id_seq OWNED BY alternatives.id;


--
-- Name: answers; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE answers (
    id integer NOT NULL,
    question_id integer,
    student_id integer,
    letra character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    proccess_instrument_id integer,
    correct boolean
);


ALTER TABLE public.answers OWNER TO vagrant;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answers_id_seq OWNER TO vagrant;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE answers_id_seq OWNED BY answers.id;


--
-- Name: assignature_abilities; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE assignature_abilities (
    id integer NOT NULL,
    nombre character varying,
    descripcion text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    assignature_id integer
);


ALTER TABLE public.assignature_abilities OWNER TO postgres;

--
-- Name: assignature_abilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE assignature_abilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assignature_abilities_id_seq OWNER TO postgres;

--
-- Name: assignature_abilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE assignature_abilities_id_seq OWNED BY assignature_abilities.id;


--
-- Name: assignatures; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE assignatures (
    id integer NOT NULL,
    nombre character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    short_name character varying
);


ALTER TABLE public.assignatures OWNER TO vagrant;

--
-- Name: assignatures_grades; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE assignatures_grades (
    assignature_id integer NOT NULL,
    grade_id integer NOT NULL
);


ALTER TABLE public.assignatures_grades OWNER TO vagrant;

--
-- Name: assignatures_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE assignatures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assignatures_id_seq OWNER TO vagrant;

--
-- Name: assignatures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE assignatures_id_seq OWNED BY assignatures.id;


--
-- Name: assigned_schools; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE assigned_schools (
    id integer NOT NULL,
    school_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.assigned_schools OWNER TO postgres;

--
-- Name: assigned_schools_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE assigned_schools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assigned_schools_id_seq OWNER TO postgres;

--
-- Name: assigned_schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE assigned_schools_id_seq OWNED BY assigned_schools.id;


--
-- Name: axes; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE axes (
    id integer NOT NULL,
    nombre character varying,
    descripcion text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    assignature_id integer
);


ALTER TABLE public.axes OWNER TO vagrant;

--
-- Name: axes_contents; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE axes_contents (
    id integer NOT NULL,
    axis_id integer,
    nombre character varying,
    descripcion text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.axes_contents OWNER TO vagrant;

--
-- Name: axes_contents_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE axes_contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_contents_id_seq OWNER TO vagrant;

--
-- Name: axes_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE axes_contents_id_seq OWNED BY axes_contents.id;


--
-- Name: axes_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE axes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_id_seq OWNER TO vagrant;

--
-- Name: axes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE axes_id_seq OWNED BY axes.id;


--
-- Name: axis_programs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE axis_programs (
    id integer NOT NULL,
    nombre character varying,
    descripcion text,
    assignature_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.axis_programs OWNER TO postgres;

--
-- Name: axis_programs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE axis_programs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axis_programs_id_seq OWNER TO postgres;

--
-- Name: axis_programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE axis_programs_id_seq OWNED BY axis_programs.id;


--
-- Name: bloom_abilities; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE bloom_abilities (
    id integer NOT NULL,
    nombre character varying,
    descripcion text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.bloom_abilities OWNER TO vagrant;

--
-- Name: bloom_abilities_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE bloom_abilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bloom_abilities_id_seq OWNER TO vagrant;

--
-- Name: bloom_abilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE bloom_abilities_id_seq OWNED BY bloom_abilities.id;


--
-- Name: buy_orders; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE buy_orders (
    id integer NOT NULL,
    order_id integer,
    monto integer,
    fecha date,
    numero character varying,
    comentario character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.buy_orders OWNER TO postgres;

--
-- Name: buy_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE buy_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buy_orders_id_seq OWNER TO postgres;

--
-- Name: buy_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE buy_orders_id_seq OWNED BY buy_orders.id;


--
-- Name: color_ranges; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE color_ranges (
    id integer NOT NULL,
    nombre character varying,
    min integer,
    max integer,
    color character varying,
    evaluation_type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    assignature_id integer,
    level_id integer
);


ALTER TABLE public.color_ranges OWNER TO vagrant;

--
-- Name: color_ranges_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE color_ranges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.color_ranges_id_seq OWNER TO vagrant;

--
-- Name: color_ranges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE color_ranges_id_seq OWNED BY color_ranges.id;


--
-- Name: communes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE communes (
    id integer NOT NULL,
    name character varying,
    region_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.communes OWNER TO postgres;

--
-- Name: communes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE communes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.communes_id_seq OWNER TO postgres;

--
-- Name: communes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE communes_id_seq OWNED BY communes.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    name character varying,
    contact bigint,
    email character varying,
    subject character varying,
    message text,
    school_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contacts_id_seq OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: contents; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE contents (
    id integer NOT NULL,
    nombre character varying,
    descripcion character varying,
    assignature_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.contents OWNER TO vagrant;

--
-- Name: contents_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contents_id_seq OWNER TO vagrant;

--
-- Name: contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE contents_id_seq OWNED BY contents.id;


--
-- Name: difficulty_levels; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE difficulty_levels (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.difficulty_levels OWNER TO vagrant;

--
-- Name: difficulty_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE difficulty_levels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.difficulty_levels_id_seq OWNER TO vagrant;

--
-- Name: difficulty_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE difficulty_levels_id_seq OWNED BY difficulty_levels.id;


--
-- Name: evaluation_types; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE evaluation_types (
    id integer NOT NULL,
    nombre character varying,
    descripcion text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    short_name character varying
);


ALTER TABLE public.evaluation_types OWNER TO vagrant;

--
-- Name: evaluation_types_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE evaluation_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evaluation_types_id_seq OWNER TO vagrant;

--
-- Name: evaluation_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE evaluation_types_id_seq OWNED BY evaluation_types.id;


--
-- Name: evaluations; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE evaluations (
    id integer NOT NULL,
    nombre character varying,
    evaluation_type_id integer,
    assignature_id integer,
    level_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.evaluations OWNER TO vagrant;

--
-- Name: evaluations_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE evaluations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evaluations_id_seq OWNER TO vagrant;

--
-- Name: evaluations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE evaluations_id_seq OWNED BY evaluations.id;


--
-- Name: evaluations_questions; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE evaluations_questions (
    evaluation_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE public.evaluations_questions OWNER TO vagrant;

--
-- Name: fact_status_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fact_status_types (
    id integer NOT NULL,
    nombre character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.fact_status_types OWNER TO postgres;

--
-- Name: fact_status_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE fact_status_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fact_status_types_id_seq OWNER TO postgres;

--
-- Name: fact_status_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE fact_status_types_id_seq OWNED BY fact_status_types.id;


--
-- Name: fact_statuses; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fact_statuses (
    id integer NOT NULL,
    order_id integer,
    fact_status_type_id integer,
    comentario character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.fact_statuses OWNER TO postgres;

--
-- Name: fact_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE fact_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fact_statuses_id_seq OWNER TO postgres;

--
-- Name: fact_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE fact_statuses_id_seq OWNED BY fact_statuses.id;


--
-- Name: feed_forms; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE feed_forms (
    id integer NOT NULL,
    feedback_id integer,
    feed_item_id integer,
    feed_score_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.feed_forms OWNER TO postgres;

--
-- Name: feed_forms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE feed_forms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feed_forms_id_seq OWNER TO postgres;

--
-- Name: feed_forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE feed_forms_id_seq OWNED BY feed_forms.id;


--
-- Name: feed_items; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE feed_items (
    id integer NOT NULL,
    nombre character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.feed_items OWNER TO postgres;

--
-- Name: feed_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE feed_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feed_items_id_seq OWNER TO postgres;

--
-- Name: feed_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE feed_items_id_seq OWNED BY feed_items.id;


--
-- Name: feed_scores; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE feed_scores (
    id integer NOT NULL,
    nombre character varying,
    score integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.feed_scores OWNER TO postgres;

--
-- Name: feed_scores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE feed_scores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feed_scores_id_seq OWNER TO postgres;

--
-- Name: feed_scores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE feed_scores_id_seq OWNED BY feed_scores.id;


--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE feedbacks (
    id integer NOT NULL,
    order_id integer,
    comentario character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    score integer DEFAULT 0
);


ALTER TABLE public.feedbacks OWNER TO postgres;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE feedbacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedbacks_id_seq OWNER TO postgres;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE feedbacks_id_seq OWNED BY feedbacks.id;


--
-- Name: froala_images; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE froala_images (
    id integer NOT NULL,
    key character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.froala_images OWNER TO postgres;

--
-- Name: froala_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE froala_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.froala_images_id_seq OWNER TO postgres;

--
-- Name: froala_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE froala_images_id_seq OWNED BY froala_images.id;


--
-- Name: grades; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE grades (
    id integer NOT NULL,
    school_id integer,
    letra character varying,
    year integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    level_id integer
);


ALTER TABLE public.grades OWNER TO vagrant;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE grades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_id_seq OWNER TO vagrant;

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE grades_id_seq OWNED BY grades.id;


--
-- Name: grades_students; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE grades_students (
    grade_id integer NOT NULL,
    student_id integer NOT NULL
);


ALTER TABLE public.grades_students OWNER TO vagrant;

--
-- Name: group_questions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE group_questions (
    id integer NOT NULL,
    statement text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.group_questions OWNER TO postgres;

--
-- Name: group_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE group_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_questions_id_seq OWNER TO postgres;

--
-- Name: group_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE group_questions_id_seq OWNED BY group_questions.id;


--
-- Name: guides; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE guides (
    id integer NOT NULL,
    instrument_id integer,
    question_id integer,
    alternative_id integer,
    question_index integer,
    alternative_index character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.guides OWNER TO vagrant;

--
-- Name: guides_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE guides_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guides_id_seq OWNER TO vagrant;

--
-- Name: guides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE guides_id_seq OWNED BY guides.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE images (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size integer,
    image_updated_at timestamp without time zone
);


ALTER TABLE public.images OWNER TO vagrant;

--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_id_seq OWNER TO vagrant;

--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: instrument_alternatives_positions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE instrument_alternatives_positions (
    id integer NOT NULL,
    instrument_id integer,
    question_id integer,
    alternative_id integer,
    instrument_questions_position_id integer,
    "position" character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.instrument_alternatives_positions OWNER TO postgres;

--
-- Name: instrument_alternatives_positions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE instrument_alternatives_positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instrument_alternatives_positions_id_seq OWNER TO postgres;

--
-- Name: instrument_alternatives_positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE instrument_alternatives_positions_id_seq OWNED BY instrument_alternatives_positions.id;


--
-- Name: instrument_proccesses; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE instrument_proccesses (
    id integer NOT NULL,
    proccess_id integer,
    instrument_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.instrument_proccesses OWNER TO vagrant;

--
-- Name: instrument_proccesses_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE instrument_proccesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instrument_proccesses_id_seq OWNER TO vagrant;

--
-- Name: instrument_proccesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE instrument_proccesses_id_seq OWNED BY instrument_proccesses.id;


--
-- Name: instrument_questions_positions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE instrument_questions_positions (
    id integer NOT NULL,
    instrument_id integer,
    question_id integer,
    "position" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.instrument_questions_positions OWNER TO postgres;

--
-- Name: instrument_questions_positions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE instrument_questions_positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instrument_questions_positions_id_seq OWNER TO postgres;

--
-- Name: instrument_questions_positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE instrument_questions_positions_id_seq OWNED BY instrument_questions_positions.id;


--
-- Name: instruments; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE instruments (
    id integer NOT NULL,
    nombre character varying,
    evaluation_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.instruments OWNER TO vagrant;

--
-- Name: instruments_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE instruments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instruments_id_seq OWNER TO vagrant;

--
-- Name: instruments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE instruments_id_seq OWNED BY instruments.id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE invoices (
    id integer NOT NULL,
    order_id integer,
    numero integer,
    fecha date,
    monto integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    document_file_name character varying,
    document_content_type character varying,
    document_file_size integer,
    document_updated_at timestamp without time zone,
    comentario character varying
);


ALTER TABLE public.invoices OWNER TO vagrant;

--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoices_id_seq OWNER TO vagrant;

--
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE invoices_id_seq OWNED BY invoices.id;


--
-- Name: learning_goals; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE learning_goals (
    id integer NOT NULL,
    nombre character varying,
    descripcion text,
    assignature_id integer,
    level_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.learning_goals OWNER TO vagrant;

--
-- Name: learning_goals_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE learning_goals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.learning_goals_id_seq OWNER TO vagrant;

--
-- Name: learning_goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE learning_goals_id_seq OWNED BY learning_goals.id;


--
-- Name: learning_goals_units; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE learning_goals_units (
    learning_goal_id integer,
    unit_id integer
);


ALTER TABLE public.learning_goals_units OWNER TO vagrant;

--
-- Name: levels; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE levels (
    id integer NOT NULL,
    nombre character varying,
    short_name character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.levels OWNER TO vagrant;

--
-- Name: levels_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE levels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.levels_id_seq OWNER TO vagrant;

--
-- Name: levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE levels_id_seq OWNED BY levels.id;


--
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE order_statuses (
    id integer NOT NULL,
    order_id integer,
    status_type_id integer,
    comentario character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.order_statuses OWNER TO vagrant;

--
-- Name: order_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE order_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_statuses_id_seq OWNER TO vagrant;

--
-- Name: order_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE order_statuses_id_seq OWNED BY order_statuses.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE orders (
    id integer NOT NULL,
    school_id integer,
    year integer,
    paymethod character varying,
    contract character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    number integer,
    licitacion character varying
);


ALTER TABLE public.orders OWNER TO vagrant;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO vagrant;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE payments (
    id integer NOT NULL,
    order_id integer,
    monto integer,
    comentario character varying,
    fecha date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    paid boolean
);


ALTER TABLE public.payments OWNER TO vagrant;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_id_seq OWNER TO vagrant;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE payments_id_seq OWNED BY payments.id;


--
-- Name: pme_abilities; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE pme_abilities (
    id integer NOT NULL,
    nombre character varying,
    descripcion text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    assignature_id integer
);


ALTER TABLE public.pme_abilities OWNER TO vagrant;

--
-- Name: pme_abilities_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE pme_abilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pme_abilities_id_seq OWNER TO vagrant;

--
-- Name: pme_abilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE pme_abilities_id_seq OWNED BY pme_abilities.id;


--
-- Name: proc_type_fathers; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE proc_type_fathers (
    id integer NOT NULL,
    nombre character varying,
    short_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.proc_type_fathers OWNER TO postgres;

--
-- Name: proc_type_fathers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE proc_type_fathers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proc_type_fathers_id_seq OWNER TO postgres;

--
-- Name: proc_type_fathers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE proc_type_fathers_id_seq OWNED BY proc_type_fathers.id;


--
-- Name: proc_types; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE proc_types (
    id integer NOT NULL,
    nombre character varying,
    descripcion character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    short_name character varying,
    proc_type_father_id integer
);


ALTER TABLE public.proc_types OWNER TO vagrant;

--
-- Name: proc_types_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE proc_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proc_types_id_seq OWNER TO vagrant;

--
-- Name: proc_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE proc_types_id_seq OWNED BY proc_types.id;


--
-- Name: proccess_instruments; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE proccess_instruments (
    id integer NOT NULL,
    proccess_id integer,
    instrument_id integer,
    grade_id integer
);


ALTER TABLE public.proccess_instruments OWNER TO vagrant;

--
-- Name: proccess_instruments_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE proccess_instruments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proccess_instruments_id_seq OWNER TO vagrant;

--
-- Name: proccess_instruments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE proccess_instruments_id_seq OWNED BY proccess_instruments.id;


--
-- Name: proccesses; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE proccesses (
    id integer NOT NULL,
    order_id integer,
    proc_type_id integer,
    monto integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fecha date,
    billed boolean
);


ALTER TABLE public.proccesses OWNER TO vagrant;

--
-- Name: proccesses_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE proccesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proccesses_id_seq OWNER TO vagrant;

--
-- Name: proccesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE proccesses_id_seq OWNED BY proccesses.id;


--
-- Name: program_axis; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE program_axis (
    id integer NOT NULL,
    assignature_id integer,
    ombre character varying,
    descripcion text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.program_axis OWNER TO vagrant;

--
-- Name: program_axis_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE program_axis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_axis_id_seq OWNER TO vagrant;

--
-- Name: program_axis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE program_axis_id_seq OWNED BY program_axis.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE questions (
    id integer NOT NULL,
    texto text,
    assignature_id integer,
    level_id integer,
    bloom_ability_id integer,
    axes_content_id integer,
    ability_content_id integer,
    unit_id integer,
    learning_goal_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    difficulty_level_id integer,
    content_id integer,
    axis_id integer,
    pme_ability_id integer,
    assignature_ability_id integer,
    axis_program_id integer,
    group_question_id integer
);


ALTER TABLE public.questions OWNER TO vagrant;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO vagrant;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE questions_id_seq OWNED BY questions.id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE regions (
    id integer NOT NULL,
    name character varying,
    roman character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_id_seq OWNER TO postgres;

--
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE regions_id_seq OWNED BY regions.id;


--
-- Name: remedials; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE remedials (
    id integer NOT NULL,
    nombre character varying,
    content_id integer,
    level_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.remedials OWNER TO vagrant;

--
-- Name: remedials_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE remedials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.remedials_id_seq OWNER TO vagrant;

--
-- Name: remedials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE remedials_id_seq OWNED BY remedials.id;


--
-- Name: reports_bypasses; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE reports_bypasses (
    id integer NOT NULL,
    nombre character varying,
    report_file_name character varying,
    report_content_type character varying,
    report_file_size integer,
    report_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.reports_bypasses OWNER TO vagrant;

--
-- Name: reports_bypasses_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE reports_bypasses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reports_bypasses_id_seq OWNER TO vagrant;

--
-- Name: reports_bypasses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE reports_bypasses_id_seq OWNED BY reports_bypasses.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying,
    resource_id integer,
    resource_type character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.roles OWNER TO vagrant;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO vagrant;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO vagrant;

--
-- Name: schools; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE schools (
    id integer NOT NULL,
    nombre character varying,
    rut character varying,
    direccion character varying,
    email character varying,
    telefono character varying,
    info_contacto text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    rbd character varying,
    dependencia character varying,
    commune_id integer
);


ALTER TABLE public.schools OWNER TO vagrant;

--
-- Name: schools_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE schools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schools_id_seq OWNER TO vagrant;

--
-- Name: schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE schools_id_seq OWNED BY schools.id;


--
-- Name: status_types; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE status_types (
    id integer NOT NULL,
    nombre character varying,
    descripcion character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.status_types OWNER TO vagrant;

--
-- Name: status_types_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE status_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.status_types_id_seq OWNER TO vagrant;

--
-- Name: status_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE status_types_id_seq OWNED BY status_types.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE students (
    id integer NOT NULL,
    nombre character varying,
    apellido character varying,
    rut character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.students OWNER TO vagrant;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_id_seq OWNER TO vagrant;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE students_id_seq OWNED BY students.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying,
    tagger_id integer,
    tagger_type character varying,
    context character varying(128),
    created_at timestamp without time zone
);


ALTER TABLE public.taggings OWNER TO postgres;

--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggings_id_seq OWNER TO postgres;

--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying,
    taggings_count integer DEFAULT 0
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: units; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE units (
    id integer NOT NULL,
    assignature_id integer,
    level_id integer,
    numero character varying,
    descripcion text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.units OWNER TO vagrant;

--
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.units_id_seq OWNER TO vagrant;

--
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE units_id_seq OWNED BY units.id;


--
-- Name: user_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_types (
    id integer NOT NULL,
    name character varying,
    role character varying,
    code character varying,
    is_active boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_types OWNER TO postgres;

--
-- Name: user_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_types_id_seq OWNER TO postgres;

--
-- Name: user_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_types_id_seq OWNED BY user_types.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    first_name character varying,
    second_name character varying,
    user_type_id integer,
    tel character varying
);


ALTER TABLE public.users OWNER TO vagrant;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO vagrant;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer,
    role_id integer
);


ALTER TABLE public.users_roles OWNER TO vagrant;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY ability_contents ALTER COLUMN id SET DEFAULT nextval('ability_contents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY alternatives ALTER COLUMN id SET DEFAULT nextval('alternatives_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY answers ALTER COLUMN id SET DEFAULT nextval('answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assignature_abilities ALTER COLUMN id SET DEFAULT nextval('assignature_abilities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY assignatures ALTER COLUMN id SET DEFAULT nextval('assignatures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assigned_schools ALTER COLUMN id SET DEFAULT nextval('assigned_schools_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY axes ALTER COLUMN id SET DEFAULT nextval('axes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY axes_contents ALTER COLUMN id SET DEFAULT nextval('axes_contents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY axis_programs ALTER COLUMN id SET DEFAULT nextval('axis_programs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY bloom_abilities ALTER COLUMN id SET DEFAULT nextval('bloom_abilities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY buy_orders ALTER COLUMN id SET DEFAULT nextval('buy_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY color_ranges ALTER COLUMN id SET DEFAULT nextval('color_ranges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communes ALTER COLUMN id SET DEFAULT nextval('communes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY contents ALTER COLUMN id SET DEFAULT nextval('contents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY difficulty_levels ALTER COLUMN id SET DEFAULT nextval('difficulty_levels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY evaluation_types ALTER COLUMN id SET DEFAULT nextval('evaluation_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY evaluations ALTER COLUMN id SET DEFAULT nextval('evaluations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fact_status_types ALTER COLUMN id SET DEFAULT nextval('fact_status_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fact_statuses ALTER COLUMN id SET DEFAULT nextval('fact_statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY feed_forms ALTER COLUMN id SET DEFAULT nextval('feed_forms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY feed_items ALTER COLUMN id SET DEFAULT nextval('feed_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY feed_scores ALTER COLUMN id SET DEFAULT nextval('feed_scores_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY feedbacks ALTER COLUMN id SET DEFAULT nextval('feedbacks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY froala_images ALTER COLUMN id SET DEFAULT nextval('froala_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY grades ALTER COLUMN id SET DEFAULT nextval('grades_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_questions ALTER COLUMN id SET DEFAULT nextval('group_questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY guides ALTER COLUMN id SET DEFAULT nextval('guides_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY instrument_alternatives_positions ALTER COLUMN id SET DEFAULT nextval('instrument_alternatives_positions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY instrument_proccesses ALTER COLUMN id SET DEFAULT nextval('instrument_proccesses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY instrument_questions_positions ALTER COLUMN id SET DEFAULT nextval('instrument_questions_positions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY instruments ALTER COLUMN id SET DEFAULT nextval('instruments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY invoices ALTER COLUMN id SET DEFAULT nextval('invoices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY learning_goals ALTER COLUMN id SET DEFAULT nextval('learning_goals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY levels ALTER COLUMN id SET DEFAULT nextval('levels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY order_statuses ALTER COLUMN id SET DEFAULT nextval('order_statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY payments ALTER COLUMN id SET DEFAULT nextval('payments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY pme_abilities ALTER COLUMN id SET DEFAULT nextval('pme_abilities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proc_type_fathers ALTER COLUMN id SET DEFAULT nextval('proc_type_fathers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY proc_types ALTER COLUMN id SET DEFAULT nextval('proc_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY proccess_instruments ALTER COLUMN id SET DEFAULT nextval('proccess_instruments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY proccesses ALTER COLUMN id SET DEFAULT nextval('proccesses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY program_axis ALTER COLUMN id SET DEFAULT nextval('program_axis_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY regions ALTER COLUMN id SET DEFAULT nextval('regions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY remedials ALTER COLUMN id SET DEFAULT nextval('remedials_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY reports_bypasses ALTER COLUMN id SET DEFAULT nextval('reports_bypasses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY schools ALTER COLUMN id SET DEFAULT nextval('schools_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY status_types ALTER COLUMN id SET DEFAULT nextval('status_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY students ALTER COLUMN id SET DEFAULT nextval('students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY units ALTER COLUMN id SET DEFAULT nextval('units_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_types ALTER COLUMN id SET DEFAULT nextval('user_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: ability_contents; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY ability_contents (id, pme_ability_id, nombre, descripcion, created_at, updated_at) FROM stdin;
1	\N	Contenido Habilidad PME	std	2015-12-02 17:44:02.30412	2015-12-02 17:44:02.30412
2	\N	DTD	std	2015-12-02 17:44:02.314014	2015-12-02 17:44:02.314014
\.


--
-- Name: ability_contents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('ability_contents_id_seq', 2, true);


--
-- Data for Name: alternatives; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY alternatives (id, texto, correcta, question_id, created_at, updated_at) FROM stdin;
100	<p>Alternativa A</p>	t	42	2016-07-23 10:00:40.582117	2016-07-23 10:00:40.582117
101	<p>Alternativa B</p>	f	42	2016-07-23 10:00:40.585658	2016-07-23 10:00:40.585658
102	<p>Alternativa C</p>	f	42	2016-07-23 10:00:40.588125	2016-07-23 10:00:40.588125
103	<p>yes</p>	t	43	2016-07-28 06:15:56.718632	2016-07-28 06:15:56.718632
104	<p>no</p>	f	43	2016-07-28 06:15:56.724948	2016-07-28 06:15:56.724948
105	<p>SIIII</p>	t	44	2016-07-28 06:50:01.293502	2016-07-28 06:50:01.293502
106	<p>xD</p>	f	44	2016-07-28 06:50:01.296263	2016-07-28 06:50:01.296263
\.


--
-- Name: alternatives_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('alternatives_id_seq', 106, true);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY answers (id, question_id, student_id, letra, created_at, updated_at, proccess_instrument_id, correct) FROM stdin;
16573	42	324	A	2016-07-25 05:54:36.802557	2016-07-25 06:03:05.031373	165	t
16574	42	325	B	2016-07-25 05:54:36.82352	2016-07-25 06:03:05.041768	165	f
16575	42	324	A	2016-07-25 06:12:15.114974	2016-07-25 06:15:33.255155	166	t
16576	42	325	A	2016-07-25 06:12:15.121677	2016-07-25 06:15:33.265758	166	t
16619	42	106	A	2016-08-03 17:49:25.568775	2016-08-03 17:49:25.568775	171	t
16620	42	109	A	2016-08-03 17:49:25.577945	2016-08-03 17:49:25.577945	171	t
16621	42	110	A	2016-08-03 17:49:25.585143	2016-08-03 17:49:25.585143	171	t
16622	42	111	A	2016-08-03 17:49:25.592446	2016-08-03 17:49:25.592446	171	t
16583	42	326	A	2016-07-27 18:45:23.721023	2016-07-27 18:45:23.721023	168	\N
16584	42	327	A	2016-07-27 18:45:23.7408	2016-07-27 18:45:23.7408	168	\N
16605	42	344	A	2016-07-28 06:25:47.559192	2016-07-28 06:25:47.559192	170	t
16606	42	345	A	2016-07-28 06:25:47.572315	2016-07-28 06:25:47.572315	170	t
16607	42	346	B	2016-07-28 06:25:47.581066	2016-07-28 06:25:47.581066	170	f
16608	42	347	B	2016-07-28 06:25:47.589308	2016-07-28 06:25:47.589308	170	f
16609	42	348	B	2016-07-28 06:25:47.599312	2016-07-28 06:25:47.599312	170	f
16610	42	338	A	2016-07-28 06:28:04.761094	2016-07-28 06:28:04.761094	169	t
16611	42	340	A	2016-07-28 06:28:04.768114	2016-07-28 06:28:04.768114	169	t
16612	42	341	A	2016-07-28 06:28:04.774802	2016-07-28 06:28:04.774802	169	t
16613	42	342	A	2016-07-28 06:28:04.783553	2016-07-28 06:28:04.783553	169	t
16614	42	343	A	2016-07-28 06:28:04.792042	2016-07-28 06:28:04.792042	169	t
16617	42	326	A	2016-07-28 08:57:48.374893	2016-07-28 08:57:48.374893	167	t
16618	42	327	B	2016-07-28 08:57:48.38352	2016-07-28 08:57:48.38352	167	f
16623	42	112	A	2016-08-03 17:49:25.600744	2016-08-03 17:49:25.600744	171	t
16624	42	113	A	2016-08-03 17:49:25.607397	2016-08-03 17:49:25.607397	171	t
16625	42	114	A	2016-08-03 17:49:25.615294	2016-08-03 17:49:25.615294	171	t
16626	42	115	A	2016-08-03 17:49:25.621358	2016-08-03 17:49:25.621358	171	t
16627	42	116	A	2016-08-03 17:49:25.628646	2016-08-03 17:49:25.628646	171	t
16628	42	117	A	2016-08-03 17:49:25.639198	2016-08-03 17:49:25.639198	171	t
16629	42	118	A	2016-08-03 17:49:25.645935	2016-08-03 17:49:25.645935	171	t
16630	42	119	A	2016-08-03 17:49:25.652613	2016-08-03 17:49:25.652613	171	t
16631	42	120	A	2016-08-03 17:49:25.659102	2016-08-03 17:49:25.659102	171	t
16632	42	121	A	2016-08-03 17:49:25.665558	2016-08-03 17:49:25.665558	171	t
16633	42	123	A	2016-08-03 17:49:25.672657	2016-08-03 17:49:25.672657	171	t
16634	42	124	A	2016-08-03 17:49:25.67898	2016-08-03 17:49:25.67898	171	t
16635	42	125	A	2016-08-03 17:49:25.685788	2016-08-03 17:49:25.685788	171	t
16636	42	126	A	2016-08-03 17:49:25.692543	2016-08-03 17:49:25.692543	171	t
16637	42	127	A	2016-08-03 17:49:25.700988	2016-08-03 17:49:25.700988	171	t
16638	42	128	A	2016-08-03 17:49:25.70805	2016-08-03 17:49:25.70805	171	t
16639	42	129	A	2016-08-03 17:49:25.714014	2016-08-03 17:49:25.714014	171	t
16640	42	131	A	2016-08-03 17:49:25.720933	2016-08-03 17:49:25.720933	171	t
16641	42	132	A	2016-08-03 17:49:25.727257	2016-08-03 17:49:25.727257	171	t
16642	42	133	A	2016-08-03 17:49:25.73319	2016-08-03 17:49:25.73319	171	t
16643	42	134	A	2016-08-03 17:49:25.739975	2016-08-03 17:49:25.739975	171	t
16644	42	135	A	2016-08-03 17:49:25.746031	2016-08-03 17:49:25.746031	171	t
16645	42	136	A	2016-08-03 17:49:25.752574	2016-08-03 17:49:25.752574	171	t
16646	42	137	A	2016-08-03 17:49:25.759525	2016-08-03 17:49:25.759525	171	t
16647	42	138	A	2016-08-03 17:49:25.765938	2016-08-03 17:49:25.765938	171	t
16648	42	254	A	2016-08-03 17:49:25.772577	2016-08-03 17:49:25.772577	171	t
16649	42	863	A	2016-08-03 17:49:25.778212	2016-08-03 17:49:25.778212	171	t
16650	42	864	A	2016-08-03 17:49:25.784762	2016-08-03 17:49:25.784762	171	t
16651	42	865	A	2016-08-03 17:49:25.791297	2016-08-03 17:49:25.791297	171	t
16652	42	866	A	2016-08-03 17:49:25.801178	2016-08-03 17:49:25.801178	171	t
16653	42	867	A	2016-08-03 17:49:25.808392	2016-08-03 17:49:25.808392	171	t
16654	42	868	A	2016-08-03 17:49:25.816085	2016-08-03 17:49:25.816085	171	t
16655	42	869	A	2016-08-03 17:49:25.823124	2016-08-03 17:49:25.823124	171	t
16656	42	870	A	2016-08-03 17:49:25.829037	2016-08-03 17:49:25.829037	171	t
16657	42	871	A	2016-08-03 17:49:25.835526	2016-08-03 17:49:25.835526	171	t
16658	42	872	A	2016-08-03 17:49:25.841956	2016-08-03 17:49:25.841956	171	t
16659	42	873	A	2016-08-03 17:49:25.849168	2016-08-03 17:49:25.849168	171	t
16660	42	874	A	2016-08-03 17:49:25.855283	2016-08-03 17:49:25.855283	171	t
16661	42	875	A	2016-08-03 17:49:25.862104	2016-08-03 17:49:25.862104	171	t
16662	42	876	A	2016-08-03 17:49:25.869003	2016-08-03 17:49:25.869003	171	t
16663	42	877	A	2016-08-03 17:49:25.876066	2016-08-03 17:49:25.876066	171	t
16664	42	73	A	2016-08-03 17:54:56.048096	2016-08-03 17:54:56.048096	173	t
16665	42	75	A	2016-08-03 17:54:56.055256	2016-08-03 17:54:56.055256	173	t
16666	42	88	A	2016-08-03 17:54:56.060996	2016-08-03 17:54:56.060996	173	t
16667	42	61	C	2016-08-03 17:54:56.069142	2016-08-03 17:54:56.069142	173	f
16668	42	64	C	2016-08-03 17:54:56.075614	2016-08-03 17:54:56.075614	173	f
16669	42	86	A	2016-08-03 17:54:56.082796	2016-08-03 17:54:56.082796	173	t
16670	42	94	A	2016-08-03 17:54:56.089228	2016-08-03 17:54:56.089228	173	t
16671	42	80	D	2016-08-03 17:54:56.095538	2016-08-03 17:54:56.095538	173	f
16672	42	85	A	2016-08-03 17:54:56.102063	2016-08-03 17:54:56.102063	173	t
16673	42	68	A	2016-08-03 17:54:56.108435	2016-08-03 17:54:56.108435	173	t
16674	42	82	A	2016-08-03 17:54:56.115176	2016-08-03 17:54:56.115176	173	t
16675	42	62	C	2016-08-03 17:54:56.121741	2016-08-03 17:54:56.121741	173	f
16676	42	77	C	2016-08-03 17:54:56.130384	2016-08-03 17:54:56.130384	173	f
16677	42	60	A	2016-08-03 17:54:56.137711	2016-08-03 17:54:56.137711	173	t
16678	42	79	A	2016-08-03 17:54:56.143956	2016-08-03 17:54:56.143956	173	t
16679	42	90	D	2016-08-03 17:54:56.151486	2016-08-03 17:54:56.151486	173	f
16680	42	93	A	2016-08-03 17:54:56.158888	2016-08-03 17:54:56.158888	173	t
16681	42	91	A	2016-08-03 17:54:56.165949	2016-08-03 17:54:56.165949	173	t
16682	42	76	A	2016-08-03 17:54:56.173435	2016-08-03 17:54:56.173435	173	t
16683	42	72	C	2016-08-03 17:54:56.181006	2016-08-03 17:54:56.181006	173	f
16684	42	59	C	2016-08-03 17:54:56.18813	2016-08-03 17:54:56.18813	173	f
16685	42	84	A	2016-08-03 17:54:56.196092	2016-08-03 17:54:56.196092	173	t
16686	42	65	A	2016-08-03 17:54:56.203145	2016-08-03 17:54:56.203145	173	t
16687	42	63	D	2016-08-03 17:54:56.209664	2016-08-03 17:54:56.209664	173	f
16688	42	83	A	2016-08-03 17:54:56.216608	2016-08-03 17:54:56.216608	173	t
16689	42	74	A	2016-08-03 17:54:56.222997	2016-08-03 17:54:56.222997	173	t
16690	42	87	A	2016-08-03 17:54:56.230168	2016-08-03 17:54:56.230168	173	t
16691	42	69	C	2016-08-03 17:54:56.236982	2016-08-03 17:54:56.236982	173	f
16692	42	89	C	2016-08-03 17:54:56.243482	2016-08-03 17:54:56.243482	173	f
16693	42	78	A	2016-08-03 17:54:56.250384	2016-08-03 17:54:56.250384	173	t
16694	42	67	A	2016-08-03 17:54:56.256822	2016-08-03 17:54:56.256822	173	t
16695	42	70	D	2016-08-03 17:54:56.264027	2016-08-03 17:54:56.264027	173	f
16696	42	71	A	2016-08-03 17:54:56.27011	2016-08-03 17:54:56.27011	173	t
16697	42	81	A	2016-08-03 17:54:56.277157	2016-08-03 17:54:56.277157	173	t
16698	42	66	A	2016-08-03 17:54:56.283309	2016-08-03 17:54:56.283309	173	t
16699	42	92	C	2016-08-03 17:54:56.290004	2016-08-03 17:54:56.290004	173	f
16700	42	106	C	2016-08-03 17:54:56.297408	2016-08-03 17:54:56.297408	173	f
16701	42	118	A	2016-08-03 17:54:56.30425	2016-08-03 17:54:56.30425	173	t
16702	42	119	A	2016-08-03 17:54:56.311823	2016-08-03 17:54:56.311823	173	t
16703	42	120	D	2016-08-03 17:54:56.320068	2016-08-03 17:54:56.320068	173	f
16704	42	121	A	2016-08-03 17:54:56.329097	2016-08-03 17:54:56.329097	173	t
16705	42	123	A	2016-08-03 17:54:56.338345	2016-08-03 17:54:56.338345	173	t
16706	42	124	A	2016-08-03 17:54:56.344738	2016-08-03 17:54:56.344738	173	t
16707	42	125	C	2016-08-03 17:54:56.352929	2016-08-03 17:54:56.352929	173	f
16708	42	126	A	2016-08-03 17:54:56.360668	2016-08-03 17:54:56.360668	173	t
16709	42	127	A	2016-08-03 17:54:56.368683	2016-08-03 17:54:56.368683	173	t
\.


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('answers_id_seq', 16709, true);


--
-- Data for Name: assignature_abilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY assignature_abilities (id, nombre, descripcion, created_at, updated_at, assignature_id) FROM stdin;
5			2016-04-07 05:56:56.704317	2016-04-07 05:56:56.704317	\N
6			2016-04-07 05:59:15.77354	2016-04-07 05:59:15.77354	\N
7			2016-04-10 07:15:54.698545	2016-04-10 07:15:54.698545	\N
8			2016-04-10 21:55:59.213784	2016-04-10 21:55:59.213784	\N
9			2016-04-10 21:56:08.614056	2016-04-10 21:56:08.614056	\N
12	Hab propia leng 1basico		2016-07-23 09:59:18.129644	2016-07-23 09:59:18.129644	1
13	Habilidad propia historia		2016-07-28 06:14:22.823491	2016-07-28 06:14:22.823491	3
14	Habilidad propia ciencas		2016-07-28 06:14:32.456142	2016-07-28 06:14:32.456142	4
15	Habilidad propia matemáticas		2016-07-28 06:14:43.021138	2016-07-28 06:14:43.021138	2
16	Habilidad propia FC		2016-07-28 06:14:52.719748	2016-07-28 06:14:52.719748	5
\.


--
-- Name: assignature_abilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('assignature_abilities_id_seq', 16, true);


--
-- Data for Name: assignatures; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY assignatures (id, nombre, created_at, updated_at, short_name) FROM stdin;
3	Historia y Ciencias Sociales	2016-05-01 05:40:55.357537	2016-05-01 05:40:55.357537	hgcs
4	Ciencias Naturales	2016-05-01 05:41:26.292791	2016-05-01 05:41:26.292791	cn
1	Lenguaje y Comunicacion	2015-12-02 17:44:02.33416	2016-05-01 05:42:04.692899	leng
2	Matemáticas	2015-12-26 18:48:32.469289	2016-05-01 05:42:37.012758	mat
5	Formacion Ciudadana	2016-05-01 05:43:08.788336	2016-05-01 05:43:08.788336	fc
\.


--
-- Data for Name: assignatures_grades; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY assignatures_grades (assignature_id, grade_id) FROM stdin;
\.


--
-- Name: assignatures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('assignatures_id_seq', 5, true);


--
-- Data for Name: assigned_schools; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY assigned_schools (id, school_id, user_id, created_at, updated_at) FROM stdin;
1	1352	8	2016-06-08 17:03:58.780442	2016-06-08 17:03:58.780442
2	1233	\N	2016-06-10 06:51:39.096364	2016-06-10 06:51:39.096364
3	1215	\N	2016-06-13 07:31:32.975857	2016-06-13 07:31:32.975857
4	1215	\N	2016-06-13 07:31:47.139765	2016-06-13 07:31:47.139765
5	1216	\N	2016-06-13 07:31:47.151219	2016-06-13 07:31:47.151219
6	1217	\N	2016-06-13 07:31:47.374495	2016-06-13 07:31:47.374495
11	1215	9	2016-06-16 13:33:15.895227	2016-06-16 13:33:15.895227
12	1216	9	2016-06-16 13:33:15.919195	2016-06-16 13:33:15.919195
13	1217	9	2016-06-16 13:33:15.931665	2016-06-16 13:33:15.931665
14	1307	9	2016-06-16 13:33:15.949018	2016-06-16 13:33:15.949018
7	1307	12	2016-06-13 08:08:10.420785	2016-06-16 13:53:53.281423
8	1215	\N	2016-06-13 08:42:50.805603	2016-06-13 08:42:50.805603
9	1350	\N	2016-06-13 08:42:50.849918	2016-06-13 08:42:50.849918
17	1219	14	2016-06-18 22:31:01.003887	2016-06-18 22:31:01.003887
15	1215	\N	2016-06-18 20:24:50.26963	2016-06-18 20:24:50.26963
16	1350	\N	2016-06-18 20:24:50.305729	2016-06-18 20:24:50.305729
18	1215	13	2016-06-19 20:45:22.083601	2016-06-19 20:45:22.083601
19	1307	13	2016-06-19 20:45:22.11763	2016-06-19 20:45:22.11763
20	1350	13	2016-06-19 20:45:22.134083	2016-06-19 20:45:22.134083
22	1307	16	2016-06-19 21:02:50.463837	2016-06-19 21:02:50.463837
23	1307	17	2016-06-19 21:58:19.251329	2016-06-19 21:58:19.251329
24	1234	18	2016-06-28 08:58:32.260617	2016-06-28 08:58:32.260617
21	1234	15	2016-06-19 20:47:15.386715	2016-07-28 07:54:21.408259
25	1234	23	2016-07-28 08:01:00.06975	2016-07-28 08:01:00.06975
27	1234	25	2016-07-28 08:37:54.616915	2016-07-28 08:37:54.616915
28	1234	26	2016-07-28 08:48:13.043716	2016-07-28 08:48:13.043716
29	1234	27	2016-07-28 08:53:51.757316	2016-07-28 08:53:51.757316
26	1234	\N	2016-07-28 08:04:45.15405	2016-07-28 08:04:45.15405
30	1234	\N	2016-07-28 09:03:57.079696	2016-07-28 09:03:57.079696
31	1313	\N	2016-07-28 09:03:57.089989	2016-07-28 09:03:57.089989
32	1234	24	2016-07-28 09:04:36.856655	2016-07-28 09:04:36.856655
33	1327	24	2016-07-28 09:04:36.863214	2016-07-28 09:04:36.863214
34	1355	28	2016-08-05 04:38:51.237615	2016-08-05 04:38:51.237615
10	1216	11	2016-06-14 07:26:31.532533	2016-08-05 04:42:07.999297
35	1364	29	2016-08-06 23:39:50.254594	2016-08-06 23:39:50.254594
37	1307	32	2016-08-07 00:15:15.713926	2016-08-07 00:15:15.713926
38	1307	33	2016-08-07 00:21:46.145732	2016-08-07 00:21:46.145732
39	1307	34	2016-08-07 00:21:46.170269	2016-08-07 00:21:46.170269
40	1365	35	2016-08-07 05:19:05.247601	2016-08-07 05:19:05.247601
41	1366	36	2016-08-07 06:58:55.011379	2016-08-07 06:58:55.011379
42	1307	\N	2016-08-08 17:21:12.226593	2016-08-08 17:21:12.226593
43	1234	37	2016-08-08 17:21:46.817767	2016-08-08 17:21:46.817767
44	1307	37	2016-08-08 17:21:46.824355	2016-08-08 17:21:46.824355
48	1368	45	2016-08-09 00:10:32.756689	2016-08-09 00:10:32.756689
49	1368	46	2016-08-09 00:10:32.906601	2016-08-09 00:10:32.906601
50	1368	47	2016-08-09 00:10:33.08779	2016-08-09 00:10:33.08779
\.


--
-- Name: assigned_schools_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('assigned_schools_id_seq', 50, true);


--
-- Data for Name: axes; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY axes (id, nombre, descripcion, created_at, updated_at, assignature_id) FROM stdin;
1	Escritura	 La\r\nescritura satisface múltiples necesidades: permite\r\nreunir, preservar y transmitir información de todo\r\ntipo, es una instancia para expresar la interioridad\r\ny desarrollar la creatividad, abre la posibilidad de\r\ncomunicarse sin importar el tiempo y la distancia,\r\nes un instrumento eficaz para convencer a otros,\r\ny es un medio a través del cual las sociedades\r\nconstruyen una memoria y una herencia común	2015-12-02 17:44:02.348384	2015-12-02 17:44:02.348384	1
2	Lectura	Es prioridad de la escuela formar lectores activos\r\ny críticos, que acudan a la lectura como medio de\r\ninformación, aprendizaje y recreación en múltiples\r\námbitos de la vida, para que, al terminar su\r\netapa escolar, sean capaces de disfrutar de esta\r\nactividad, informarse y aprender a partir de ella, y\r\nformarse sus propias opiniones. Esta experiencia\r\nmarca la diferencia en su desarrollo integral, ya\r\nque los lectores entusiastas se dan a sí mismos\r\noportunidades de aprendizaje que son equivalentes\r\na muchos años de enseñanza	2015-12-02 17:44:02.357143	2015-12-02 17:44:02.357143	1
4	Eje mate		2015-12-27 04:10:53.487864	2015-12-27 04:10:53.487864	2
5	Eje historia		2016-05-02 05:06:47.823473	2016-05-02 05:06:47.823473	3
6	Eje geografia		2016-05-02 05:06:57.062932	2016-05-02 05:06:57.062932	3
7	Eje F.C		2016-05-02 05:07:03.99676	2016-05-02 05:07:03.99676	3
\.


--
-- Data for Name: axes_contents; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY axes_contents (id, axis_id, nombre, descripcion, created_at, updated_at) FROM stdin;
1	1	COMPRENSIÓN DE ORACIONES: INTERPRETACIÓN DE IMÁGENES.		2015-12-02 17:44:02.381045	2015-12-02 17:44:02.381045
2	1	COMPRENSIÓN DE ORACIONES: RELACIONAR CON DIBUJO.		2015-12-02 17:44:02.389161	2015-12-02 17:44:02.389161
3	1	TEXTO LITERARIO - IDENTIFICACIÓN  DE CAUSA Y EFECTO.		2015-12-02 17:44:02.397445	2015-12-02 17:44:02.397445
4	1	TEXTO LITERARIO - IDENTIFICAR DETALLES		2015-12-02 17:44:02.406859	2015-12-02 17:44:02.406859
5	1	TEXTO LITERARIO - PREDICCIÓN 		2015-12-02 17:44:02.413964	2015-12-02 17:44:02.413964
6	1	TEXTO NO LITERARIO -  ESTRUCTURA DEL AFICHE		2015-12-02 17:44:02.422298	2015-12-02 17:44:02.422298
7	1	TEXTO NO LITERARIO -  PROPÓSITO DEL AFICHE		2015-12-02 17:44:02.430754	2015-12-02 17:44:02.430754
8	1	TEXTO NO LITERARIO - IDEA PRINCIPAL.		2015-12-02 17:44:02.440285	2015-12-02 17:44:02.440285
9	1	TIPOS DE TEXTO - ESTRUCTURA DE LA CARTA		2015-12-02 17:44:02.448563	2015-12-02 17:44:02.448563
10	2	ESCRIBIR ORACIONES		2015-12-02 17:44:02.455791	2015-12-02 17:44:02.455791
11	2	ESCRIBIR PALABRAS CON SILABAS INDIRECTAS Y COMPLEJAS.		2015-12-02 17:44:02.464267	2015-12-02 17:44:02.464267
12	2	ORDENAR ORACIONES		2015-12-02 17:44:02.473482	2015-12-02 17:44:02.473482
\.


--
-- Name: axes_contents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('axes_contents_id_seq', 12, true);


--
-- Name: axes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('axes_id_seq', 7, true);


--
-- Data for Name: axis_programs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY axis_programs (id, nombre, descripcion, assignature_id, created_at, updated_at) FROM stdin;
2	Eje de programa probando	testttt	1	2015-12-26 18:32:59.970783	2015-12-26 18:32:59.970783
3	Eje mate programa		2	2015-12-27 04:11:07.147619	2015-12-27 04:11:07.147619
4	Eje programa historia		3	2016-05-02 05:07:17.507189	2016-05-02 05:07:17.507189
\.


--
-- Name: axis_programs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('axis_programs_id_seq', 4, true);


--
-- Data for Name: bloom_abilities; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY bloom_abilities (id, nombre, descripcion, created_at, updated_at) FROM stdin;
2	Comprender	Habilidad de construir significado a partir de material educativo, como la lectura o las explicaciones del docente.	2015-12-02 17:44:02.497919	2015-12-02 17:44:02.497919
3	Aplicar	Aplicación de un proceso aprendido, ya sea en una situación familiar o en una nueva.	2015-12-02 17:44:02.505797	2015-12-02 17:44:02.505797
4	Analizar	Descomponer el conocimiento en sus partes y pensar en cómo estas se relacionan con su estructura global.	2015-12-02 17:44:02.514152	2015-12-02 17:44:02.514152
5	Evaluar	Ubicada en la cúspide de la taxonomía original de 1956, evaluar es el quinto proceso en la edición revisada. Consta de comprobación y crítica.	2015-12-02 17:44:02.522525	2015-12-02 17:44:02.522525
6	Crear	Nuevo en esta taxonomía. Involucra reunir cosas y hacer algo nuevo. Para llevar a cabo tareas creadoras, los aprendices generan, planifican y producen.	2015-12-02 17:44:02.530829	2015-12-02 17:44:02.530829
1	Recordar	Reconocer y traer a la memoria información relevante de la memoria de largo plazo	2015-12-02 17:44:02.492714	2016-04-02 20:44:00.253291
\.


--
-- Name: bloom_abilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('bloom_abilities_id_seq', 6, true);


--
-- Data for Name: buy_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY buy_orders (id, order_id, monto, fecha, numero, comentario, created_at, updated_at) FROM stdin;
\.


--
-- Name: buy_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('buy_orders_id_seq', 1, true);


--
-- Data for Name: color_ranges; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY color_ranges (id, nombre, min, max, color, evaluation_type_id, created_at, updated_at, assignature_id, level_id) FROM stdin;
48	Bajo	0	25	#ff0000	2	2016-07-25 05:45:58.838575	2016-07-25 05:45:58.838575	1	1
49	Medio	26	75	#ffee00	2	2016-07-25 05:46:16.549712	2016-07-25 05:46:16.549712	1	1
50	Alto	76	100	#1b8520	2	2016-07-25 05:46:37.2241	2016-07-25 05:46:37.2241	1	1
51	Insuficiente	156	228	#ff0000	1	2016-07-25 06:10:09.059769	2016-07-25 06:10:09.059769	1	1
52	Adecuado	229	279	#f2ff00	1	2016-07-25 06:10:43.514483	2016-07-25 06:10:43.514483	1	1
53	Elemental	280	361	#44ff00	1	2016-07-25 06:11:08.109988	2016-07-25 06:11:08.109988	1	1
\.


--
-- Name: color_ranges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('color_ranges_id_seq', 53, true);


--
-- Data for Name: communes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY communes (id, name, region_id, created_at, updated_at) FROM stdin;
4	Arica	15	2016-07-25 05:51:20.806188	2016-07-25 05:51:20.806188
5	Camarones	15	2016-07-25 05:51:20.823031	2016-07-25 05:51:20.823031
6	Putre	15	2016-07-25 05:51:20.827591	2016-07-25 05:51:20.827591
7	General Lagos	15	2016-07-25 05:51:20.833532	2016-07-25 05:51:20.833532
8	Iquique	1	2016-07-25 05:51:20.839219	2016-07-25 05:51:20.839219
9	Alto Hospicio	1	2016-07-25 05:51:20.845065	2016-07-25 05:51:20.845065
10	Pozo Almonte	1	2016-07-25 05:51:20.851129	2016-07-25 05:51:20.851129
11	Camiña	1	2016-07-25 05:51:20.856712	2016-07-25 05:51:20.856712
12	Colchane	1	2016-07-25 05:51:20.862696	2016-07-25 05:51:20.862696
13	Huara	1	2016-07-25 05:51:20.868499	2016-07-25 05:51:20.868499
14	Pica	1	2016-07-25 05:51:20.874677	2016-07-25 05:51:20.874677
15	Antofagasta	2	2016-07-25 05:51:20.882965	2016-07-25 05:51:20.882965
16	Mejillones	2	2016-07-25 05:51:20.889867	2016-07-25 05:51:20.889867
17	Sierra Gorda	2	2016-07-25 05:51:20.896758	2016-07-25 05:51:20.896758
18	Taltal	2	2016-07-25 05:51:20.901415	2016-07-25 05:51:20.901415
19	Calama	2	2016-07-25 05:51:20.905408	2016-07-25 05:51:20.905408
20	Ollage	2	2016-07-25 05:51:20.911828	2016-07-25 05:51:20.911828
21	San Pedro de Atacama	2	2016-07-25 05:51:20.91697	2016-07-25 05:51:20.91697
22	Tocopilla	2	2016-07-25 05:51:20.921386	2016-07-25 05:51:20.921386
23	Mara Elena	2	2016-07-25 05:51:20.925532	2016-07-25 05:51:20.925532
24	Copiap	3	2016-07-25 05:51:20.929928	2016-07-25 05:51:20.929928
25	Caldera	3	2016-07-25 05:51:20.934124	2016-07-25 05:51:20.934124
26	Tierra Amarilla	3	2016-07-25 05:51:20.938373	2016-07-25 05:51:20.938373
27	Chañaral	3	2016-07-25 05:51:20.942373	2016-07-25 05:51:20.942373
28	Diego de Almagro	3	2016-07-25 05:51:20.946586	2016-07-25 05:51:20.946586
29	Vallenar	3	2016-07-25 05:51:20.950684	2016-07-25 05:51:20.950684
30	Alto del Carmen	3	2016-07-25 05:51:20.955741	2016-07-25 05:51:20.955741
31	Freirina	3	2016-07-25 05:51:20.959658	2016-07-25 05:51:20.959658
32	Huasco	3	2016-07-25 05:51:20.96378	2016-07-25 05:51:20.96378
33	La Serena	4	2016-07-25 05:51:20.967559	2016-07-25 05:51:20.967559
34	Coquimbo	4	2016-07-25 05:51:20.972427	2016-07-25 05:51:20.972427
35	Andacollo	4	2016-07-25 05:51:20.976538	2016-07-25 05:51:20.976538
36	La Higuera	4	2016-07-25 05:51:20.981393	2016-07-25 05:51:20.981393
37	Paiguano	4	2016-07-25 05:51:20.988248	2016-07-25 05:51:20.988248
38	Vicuña	4	2016-07-25 05:51:20.995525	2016-07-25 05:51:20.995525
39	Illapel	4	2016-07-25 05:51:21.002601	2016-07-25 05:51:21.002601
40	Canela	4	2016-07-25 05:51:21.007249	2016-07-25 05:51:21.007249
41	Los Vilos	4	2016-07-25 05:51:21.012162	2016-07-25 05:51:21.012162
42	Salamanca	4	2016-07-25 05:51:21.016543	2016-07-25 05:51:21.016543
43	Ovalle	4	2016-07-25 05:51:21.020965	2016-07-25 05:51:21.020965
44	Combarbal	4	2016-07-25 05:51:21.025451	2016-07-25 05:51:21.025451
45	Monte Patria	4	2016-07-25 05:51:21.029671	2016-07-25 05:51:21.029671
46	Punitaqui	4	2016-07-25 05:51:21.033386	2016-07-25 05:51:21.033386
47	Ro Hurtado	4	2016-07-25 05:51:21.037769	2016-07-25 05:51:21.037769
48	Valparaso	5	2016-07-25 05:51:21.041838	2016-07-25 05:51:21.041838
49	Casablanca	5	2016-07-25 05:51:21.046575	2016-07-25 05:51:21.046575
50	Concn	5	2016-07-25 05:51:21.051859	2016-07-25 05:51:21.051859
51	Juan Fernndez	5	2016-07-25 05:51:21.055948	2016-07-25 05:51:21.055948
52	Puchuncav	5	2016-07-25 05:51:21.060328	2016-07-25 05:51:21.060328
53	Quintero	5	2016-07-25 05:51:21.064486	2016-07-25 05:51:21.064486
54	Viña del Mar	5	2016-07-25 05:51:21.06929	2016-07-25 05:51:21.06929
55	Isla de Pascua	5	2016-07-25 05:51:21.073306	2016-07-25 05:51:21.073306
56	Los Andes	5	2016-07-25 05:51:21.077426	2016-07-25 05:51:21.077426
57	Calle Larga	5	2016-07-25 05:51:21.082427	2016-07-25 05:51:21.082427
58	Riconada	5	2016-07-25 05:51:21.094048	2016-07-25 05:51:21.094048
59	San Esteban	5	2016-07-25 05:51:21.105681	2016-07-25 05:51:21.105681
60	La Ligua	5	2016-07-25 05:51:21.112267	2016-07-25 05:51:21.112267
61	Cabildo	5	2016-07-25 05:51:21.117912	2016-07-25 05:51:21.117912
62	Papudo	5	2016-07-25 05:51:21.123942	2016-07-25 05:51:21.123942
63	Petorca	5	2016-07-25 05:51:21.130265	2016-07-25 05:51:21.130265
64	Zapallar	5	2016-07-25 05:51:21.134544	2016-07-25 05:51:21.134544
65	Quillota	5	2016-07-25 05:51:21.138788	2016-07-25 05:51:21.138788
66	Calera	5	2016-07-25 05:51:21.143019	2016-07-25 05:51:21.143019
67	Hijuelas	5	2016-07-25 05:51:21.14743	2016-07-25 05:51:21.14743
68	La Cruz	5	2016-07-25 05:51:21.15152	2016-07-25 05:51:21.15152
69	Nogales	5	2016-07-25 05:51:21.155275	2016-07-25 05:51:21.155275
70	San Antonio	5	2016-07-25 05:51:21.160397	2016-07-25 05:51:21.160397
71	Algarrobo	5	2016-07-25 05:51:21.164423	2016-07-25 05:51:21.164423
72	Cartagena	5	2016-07-25 05:51:21.168481	2016-07-25 05:51:21.168481
73	El Quisco	5	2016-07-25 05:51:21.172519	2016-07-25 05:51:21.172519
74	El Tabo	5	2016-07-25 05:51:21.176668	2016-07-25 05:51:21.176668
75	Santo Domingo	5	2016-07-25 05:51:21.180905	2016-07-25 05:51:21.180905
76	San Felipe	5	2016-07-25 05:51:21.187205	2016-07-25 05:51:21.187205
77	Catemu	5	2016-07-25 05:51:21.194313	2016-07-25 05:51:21.194313
78	Llaillay	5	2016-07-25 05:51:21.201783	2016-07-25 05:51:21.201783
79	Panquehue	5	2016-07-25 05:51:21.207692	2016-07-25 05:51:21.207692
80	Putaendo	5	2016-07-25 05:51:21.212204	2016-07-25 05:51:21.212204
81	Santa Mara	5	2016-07-25 05:51:21.216411	2016-07-25 05:51:21.216411
83	Limache	5	2016-07-25 05:51:21.225656	2016-07-25 05:51:21.225656
84	Olmu	5	2016-07-25 05:51:21.229878	2016-07-25 05:51:21.229878
85	Villa Alemana	5	2016-07-25 05:51:21.233706	2016-07-25 05:51:21.233706
86	Rancagua	6	2016-07-25 05:51:21.238621	2016-07-25 05:51:21.238621
87	Codegua	6	2016-07-25 05:51:21.242819	2016-07-25 05:51:21.242819
88	Coinco	6	2016-07-25 05:51:21.246965	2016-07-25 05:51:21.246965
89	Coltauco	6	2016-07-25 05:51:21.250708	2016-07-25 05:51:21.250708
90	Doñihue	6	2016-07-25 05:51:21.255661	2016-07-25 05:51:21.255661
91	Graneros	6	2016-07-25 05:51:21.259574	2016-07-25 05:51:21.259574
92	Las Cabras	6	2016-07-25 05:51:21.263795	2016-07-25 05:51:21.263795
93	Machal	6	2016-07-25 05:51:21.268451	2016-07-25 05:51:21.268451
94	Malloa	6	2016-07-25 05:51:21.272553	2016-07-25 05:51:21.272553
95	Mostazal	6	2016-07-25 05:51:21.276632	2016-07-25 05:51:21.276632
96	Olivar	6	2016-07-25 05:51:21.281223	2016-07-25 05:51:21.281223
97	Peumo	6	2016-07-25 05:51:21.286391	2016-07-25 05:51:21.286391
98	Pichidegua	6	2016-07-25 05:51:21.292542	2016-07-25 05:51:21.292542
99	Quinta de Tilcoco	6	2016-07-25 05:51:21.299273	2016-07-25 05:51:21.299273
100	Rengo	6	2016-07-25 05:51:21.30597	2016-07-25 05:51:21.30597
101	Requnoa	6	2016-07-25 05:51:21.310783	2016-07-25 05:51:21.310783
102	San Vicente	6	2016-07-25 05:51:21.314677	2016-07-25 05:51:21.314677
103	Pichilemu	6	2016-07-25 05:51:21.318756	2016-07-25 05:51:21.318756
104	La Estrella	6	2016-07-25 05:51:21.322677	2016-07-25 05:51:21.322677
105	Litueche	6	2016-07-25 05:51:21.32784	2016-07-25 05:51:21.32784
106	Marichihue	6	2016-07-25 05:51:21.332545	2016-07-25 05:51:21.332545
107	Navidad	6	2016-07-25 05:51:21.338348	2016-07-25 05:51:21.338348
108	Paredones	6	2016-07-25 05:51:21.344237	2016-07-25 05:51:21.344237
109	San Fernando	6	2016-07-25 05:51:21.350395	2016-07-25 05:51:21.350395
110	Chpica	6	2016-07-25 05:51:21.356378	2016-07-25 05:51:21.356378
111	Chimbarongo	6	2016-07-25 05:51:21.362207	2016-07-25 05:51:21.362207
112	Lolol	6	2016-07-25 05:51:21.368222	2016-07-25 05:51:21.368222
113	Nancagua	6	2016-07-25 05:51:21.374121	2016-07-25 05:51:21.374121
114	Palmilla	6	2016-07-25 05:51:21.380939	2016-07-25 05:51:21.380939
115	Peralillo	6	2016-07-25 05:51:21.386908	2016-07-25 05:51:21.386908
116	Placilla	6	2016-07-25 05:51:21.3938	2016-07-25 05:51:21.3938
117	Pumanque	6	2016-07-25 05:51:21.400646	2016-07-25 05:51:21.400646
118	Santa Cruz	6	2016-07-25 05:51:21.407494	2016-07-25 05:51:21.407494
119	Talca	7	2016-07-25 05:51:21.412335	2016-07-25 05:51:21.412335
120	Constitucin	7	2016-07-25 05:51:21.41722	2016-07-25 05:51:21.41722
121	Curepto	7	2016-07-25 05:51:21.421481	2016-07-25 05:51:21.421481
122	Empedrado	7	2016-07-25 05:51:21.425565	2016-07-25 05:51:21.425565
123	Maule	7	2016-07-25 05:51:21.429983	2016-07-25 05:51:21.429983
124	Pelarco	7	2016-07-25 05:51:21.434668	2016-07-25 05:51:21.434668
125	Pencahue	7	2016-07-25 05:51:21.438945	2016-07-25 05:51:21.438945
126	Ro Claro	7	2016-07-25 05:51:21.443289	2016-07-25 05:51:21.443289
127	San Clemente	7	2016-07-25 05:51:21.448213	2016-07-25 05:51:21.448213
128	San Rafael	7	2016-07-25 05:51:21.452535	2016-07-25 05:51:21.452535
129	Cauquenes	7	2016-07-25 05:51:21.457037	2016-07-25 05:51:21.457037
130	Chanco	7	2016-07-25 05:51:21.461543	2016-07-25 05:51:21.461543
131	Pelluhue	7	2016-07-25 05:51:21.466354	2016-07-25 05:51:21.466354
132	Curic	7	2016-07-25 05:51:21.471809	2016-07-25 05:51:21.471809
133	Hualañ	7	2016-07-25 05:51:21.476108	2016-07-25 05:51:21.476108
134	Licantn	7	2016-07-25 05:51:21.481732	2016-07-25 05:51:21.481732
135	Molina	7	2016-07-25 05:51:21.486179	2016-07-25 05:51:21.486179
136	Rauco	7	2016-07-25 05:51:21.491603	2016-07-25 05:51:21.491603
137	Romeral	7	2016-07-25 05:51:21.49945	2016-07-25 05:51:21.49945
138	Sagrada Familia	7	2016-07-25 05:51:21.505923	2016-07-25 05:51:21.505923
139	Teno	7	2016-07-25 05:51:21.510975	2016-07-25 05:51:21.510975
140	Vichuqun	7	2016-07-25 05:51:21.515971	2016-07-25 05:51:21.515971
141	Linares	7	2016-07-25 05:51:21.520177	2016-07-25 05:51:21.520177
142	Colbn	7	2016-07-25 05:51:21.524458	2016-07-25 05:51:21.524458
143	Longav	7	2016-07-25 05:51:21.529027	2016-07-25 05:51:21.529027
144	Parral	7	2016-07-25 05:51:21.533522	2016-07-25 05:51:21.533522
145	Retiro	7	2016-07-25 05:51:21.537657	2016-07-25 05:51:21.537657
146	San Javier	7	2016-07-25 05:51:21.541751	2016-07-25 05:51:21.541751
147	Villa Alegre	7	2016-07-25 05:51:21.546241	2016-07-25 05:51:21.546241
148	Yerbas Buenas	7	2016-07-25 05:51:21.550535	2016-07-25 05:51:21.550535
149	Concepcin	8	2016-07-25 05:51:21.554486	2016-07-25 05:51:21.554486
150	Coronel	8	2016-07-25 05:51:21.570367	2016-07-25 05:51:21.570367
151	Chiguayante	8	2016-07-25 05:51:21.574896	2016-07-25 05:51:21.574896
152	Florida	8	2016-07-25 05:51:21.579812	2016-07-25 05:51:21.579812
153	Hualqui	8	2016-07-25 05:51:21.584259	2016-07-25 05:51:21.584259
154	Lota	8	2016-07-25 05:51:21.595173	2016-07-25 05:51:21.595173
155	Penco	8	2016-07-25 05:51:21.605751	2016-07-25 05:51:21.605751
156	San Pedro de la Paz	8	2016-07-25 05:51:21.613553	2016-07-25 05:51:21.613553
157	Santa Juana	8	2016-07-25 05:51:21.620365	2016-07-25 05:51:21.620365
158	Talcahuano	8	2016-07-25 05:51:21.62638	2016-07-25 05:51:21.62638
159	Tom	8	2016-07-25 05:51:21.633567	2016-07-25 05:51:21.633567
160	Hualpn	8	2016-07-25 05:51:21.639442	2016-07-25 05:51:21.639442
161	Lebu	8	2016-07-25 05:51:21.643702	2016-07-25 05:51:21.643702
162	Arauco	8	2016-07-25 05:51:21.648436	2016-07-25 05:51:21.648436
163	Cañete	8	2016-07-25 05:51:21.652557	2016-07-25 05:51:21.652557
164	Contulmo	8	2016-07-25 05:51:21.656857	2016-07-25 05:51:21.656857
165	Curanilahue	8	2016-07-25 05:51:21.661084	2016-07-25 05:51:21.661084
166	Los lamos	8	2016-07-25 05:51:21.665419	2016-07-25 05:51:21.665419
167	Tira	8	2016-07-25 05:51:21.669867	2016-07-25 05:51:21.669867
168	Los ngeles	8	2016-07-25 05:51:21.673814	2016-07-25 05:51:21.673814
169	Antuco	8	2016-07-25 05:51:21.67938	2016-07-25 05:51:21.67938
170	Cabrero	8	2016-07-25 05:51:21.684591	2016-07-25 05:51:21.684591
171	Laja	8	2016-07-25 05:51:21.691114	2016-07-25 05:51:21.691114
172	Mulchn	8	2016-07-25 05:51:21.698412	2016-07-25 05:51:21.698412
173	Nacimiento	8	2016-07-25 05:51:21.705799	2016-07-25 05:51:21.705799
174	Negrete	8	2016-07-25 05:51:21.711498	2016-07-25 05:51:21.711498
175	Quilaco	8	2016-07-25 05:51:21.715998	2016-07-25 05:51:21.715998
176	Quilleco	8	2016-07-25 05:51:21.720251	2016-07-25 05:51:21.720251
177	San Rosendo	8	2016-07-25 05:51:21.724609	2016-07-25 05:51:21.724609
178	Santa Brbara	8	2016-07-25 05:51:21.729631	2016-07-25 05:51:21.729631
179	Tucapel	8	2016-07-25 05:51:21.733855	2016-07-25 05:51:21.733855
180	Yumbel	8	2016-07-25 05:51:21.737955	2016-07-25 05:51:21.737955
181	Alto Biobo	8	2016-07-25 05:51:21.741985	2016-07-25 05:51:21.741985
182	Chilln	8	2016-07-25 05:51:21.746868	2016-07-25 05:51:21.746868
183	Bulnes	8	2016-07-25 05:51:21.75078	2016-07-25 05:51:21.75078
184	Cobquecura	8	2016-07-25 05:51:21.754735	2016-07-25 05:51:21.754735
185	Coelemu	8	2016-07-25 05:51:21.759618	2016-07-25 05:51:21.759618
186	Coihueco	8	2016-07-25 05:51:21.763463	2016-07-25 05:51:21.763463
187	Chilln Viejo	8	2016-07-25 05:51:21.768123	2016-07-25 05:51:21.768123
188	El Carmen	8	2016-07-25 05:51:21.772106	2016-07-25 05:51:21.772106
189	Ninhue	8	2016-07-25 05:51:21.776217	2016-07-25 05:51:21.776217
190	Ñiqun	8	2016-07-25 05:51:21.780422	2016-07-25 05:51:21.780422
191	Pemuco	8	2016-07-25 05:51:21.784685	2016-07-25 05:51:21.784685
192	Pinto	8	2016-07-25 05:51:21.790463	2016-07-25 05:51:21.790463
193	Portezuelo	8	2016-07-25 05:51:21.797205	2016-07-25 05:51:21.797205
194	Quilln	8	2016-07-25 05:51:21.804355	2016-07-25 05:51:21.804355
195	Quirihue	8	2016-07-25 05:51:21.810994	2016-07-25 05:51:21.810994
196	Rnquil	8	2016-07-25 05:51:21.816037	2016-07-25 05:51:21.816037
197	San Carlos	8	2016-07-25 05:51:21.820077	2016-07-25 05:51:21.820077
198	San Fabin	8	2016-07-25 05:51:21.824317	2016-07-25 05:51:21.824317
199	San Ignacio	8	2016-07-25 05:51:21.828859	2016-07-25 05:51:21.828859
200	San Nicols	8	2016-07-25 05:51:21.833295	2016-07-25 05:51:21.833295
201	Treguaco	8	2016-07-25 05:51:21.837517	2016-07-25 05:51:21.837517
202	Yungay	8	2016-07-25 05:51:21.843207	2016-07-25 05:51:21.843207
203	Temuco	9	2016-07-25 05:51:21.849516	2016-07-25 05:51:21.849516
204	Carahu	9	2016-07-25 05:51:21.855032	2016-07-25 05:51:21.855032
205	Cunco	9	2016-07-25 05:51:21.860595	2016-07-25 05:51:21.860595
206	Curarrehue	9	2016-07-25 05:51:21.867157	2016-07-25 05:51:21.867157
207	Freire	9	2016-07-25 05:51:21.872673	2016-07-25 05:51:21.872673
208	Galvarin	9	2016-07-25 05:51:21.878444	2016-07-25 05:51:21.878444
209	Gorbea	9	2016-07-25 05:51:21.88505	2016-07-25 05:51:21.88505
210	Lautaro	9	2016-07-25 05:51:21.891296	2016-07-25 05:51:21.891296
211	Loncoche	9	2016-07-25 05:51:21.897908	2016-07-25 05:51:21.897908
212	Melipeuco	9	2016-07-25 05:51:21.904375	2016-07-25 05:51:21.904375
213	Nueva Imperial	9	2016-07-25 05:51:21.908915	2016-07-25 05:51:21.908915
214	Padre las Casa	9	2016-07-25 05:51:21.913859	2016-07-25 05:51:21.913859
215	Perquenco	9	2016-07-25 05:51:21.919861	2016-07-25 05:51:21.919861
216	Pitrufqun	9	2016-07-25 05:51:21.923587	2016-07-25 05:51:21.923587
217	Puc	9	2016-07-25 05:51:21.928422	2016-07-25 05:51:21.928422
218	Saavedra	9	2016-07-25 05:51:21.932492	2016-07-25 05:51:21.932492
219	Teodoro Schmid	9	2016-07-25 05:51:21.936967	2016-07-25 05:51:21.936967
220	Toltn	9	2016-07-25 05:51:21.941275	2016-07-25 05:51:21.941275
221	Vilcn	9	2016-07-25 05:51:21.945534	2016-07-25 05:51:21.945534
222	Villarrica	9	2016-07-25 05:51:21.949907	2016-07-25 05:51:21.949907
223	Cholchol	9	2016-07-25 05:51:21.954545	2016-07-25 05:51:21.954545
224	Angol	9	2016-07-25 05:51:21.958829	2016-07-25 05:51:21.958829
225	Collipulli	9	2016-07-25 05:51:21.962591	2016-07-25 05:51:21.962591
226	Curacautn	9	2016-07-25 05:51:21.966708	2016-07-25 05:51:21.966708
227	Ercilla	9	2016-07-25 05:51:21.970701	2016-07-25 05:51:21.970701
228	Lonquimay	9	2016-07-25 05:51:21.975606	2016-07-25 05:51:21.975606
229	Los Sauces	9	2016-07-25 05:51:21.979402	2016-07-25 05:51:21.979402
230	Lumaco	9	2016-07-25 05:51:21.984317	2016-07-25 05:51:21.984317
231	Purn	9	2016-07-25 05:51:21.988447	2016-07-25 05:51:21.988447
232	Renaico	9	2016-07-25 05:51:21.995044	2016-07-25 05:51:21.995044
233	Traigun	9	2016-07-25 05:51:22.000879	2016-07-25 05:51:22.000879
234	Victoria	9	2016-07-25 05:51:22.007901	2016-07-25 05:51:22.007901
235	Valdivia	14	2016-07-25 05:51:22.014871	2016-07-25 05:51:22.014871
236	Corral	14	2016-07-25 05:51:22.018958	2016-07-25 05:51:22.018958
237	Lanco	14	2016-07-25 05:51:22.023356	2016-07-25 05:51:22.023356
238	Los Lagos	14	2016-07-25 05:51:22.028364	2016-07-25 05:51:22.028364
239	Mfil	14	2016-07-25 05:51:22.032449	2016-07-25 05:51:22.032449
240	Mariquina	14	2016-07-25 05:51:22.036508	2016-07-25 05:51:22.036508
241	Paillaco	14	2016-07-25 05:51:22.041146	2016-07-25 05:51:22.041146
242	Panguipulli	14	2016-07-25 05:51:22.045508	2016-07-25 05:51:22.045508
243	La Unin	14	2016-07-25 05:51:22.049766	2016-07-25 05:51:22.049766
244	Futrono	14	2016-07-25 05:51:22.053886	2016-07-25 05:51:22.053886
245	Lago Ranco	14	2016-07-25 05:51:22.05809	2016-07-25 05:51:22.05809
246	Ro Bueno	14	2016-07-25 05:51:22.062404	2016-07-25 05:51:22.062404
247	Puerto Montt	10	2016-07-25 05:51:22.066726	2016-07-25 05:51:22.066726
248	Calbuco	10	2016-07-25 05:51:22.070583	2016-07-25 05:51:22.070583
249	Cocham	10	2016-07-25 05:51:22.074743	2016-07-25 05:51:22.074743
250	Fresia	10	2016-07-25 05:51:22.079809	2016-07-25 05:51:22.079809
251	Frutillar	10	2016-07-25 05:51:22.083643	2016-07-25 05:51:22.083643
252	Los Muermos	10	2016-07-25 05:51:22.088471	2016-07-25 05:51:22.088471
253	Llanquihue	10	2016-07-25 05:51:22.098119	2016-07-25 05:51:22.098119
254	Maulln	10	2016-07-25 05:51:22.107414	2016-07-25 05:51:22.107414
255	Puerto Varas	10	2016-07-25 05:51:22.117131	2016-07-25 05:51:22.117131
256	Castro	10	2016-07-25 05:51:22.123662	2016-07-25 05:51:22.123662
257	Ancud	10	2016-07-25 05:51:22.130518	2016-07-25 05:51:22.130518
258	Chonchi	10	2016-07-25 05:51:22.136682	2016-07-25 05:51:22.136682
259	Curaco de Vlez	10	2016-07-25 05:51:22.141795	2016-07-25 05:51:22.141795
260	Dalcahue	10	2016-07-25 05:51:22.145918	2016-07-25 05:51:22.145918
261	Puqueldn	10	2016-07-25 05:51:22.150938	2016-07-25 05:51:22.150938
262	Queiln	10	2016-07-25 05:51:22.154887	2016-07-25 05:51:22.154887
263	Quelln	10	2016-07-25 05:51:22.158862	2016-07-25 05:51:22.158862
264	Quemchi	10	2016-07-25 05:51:22.162954	2016-07-25 05:51:22.162954
265	Quinchao	10	2016-07-25 05:51:22.16778	2016-07-25 05:51:22.16778
266	Osorno	10	2016-07-25 05:51:22.171468	2016-07-25 05:51:22.171468
267	Puerto Octay	10	2016-07-25 05:51:22.176351	2016-07-25 05:51:22.176351
268	Purranque	10	2016-07-25 05:51:22.180497	2016-07-25 05:51:22.180497
269	Puyehue	10	2016-07-25 05:51:22.184562	2016-07-25 05:51:22.184562
270	Ro Negro	10	2016-07-25 05:51:22.189738	2016-07-25 05:51:22.189738
271	San Juan de la Costa	10	2016-07-25 05:51:22.193836	2016-07-25 05:51:22.193836
272	San Pablo	10	2016-07-25 05:51:22.198235	2016-07-25 05:51:22.198235
273	Chaitn	10	2016-07-25 05:51:22.204345	2016-07-25 05:51:22.204345
274	Futaleuf	10	2016-07-25 05:51:22.211549	2016-07-25 05:51:22.211549
275	Hualaihu	10	2016-07-25 05:51:22.218147	2016-07-25 05:51:22.218147
276	Palena	10	2016-07-25 05:51:22.222813	2016-07-25 05:51:22.222813
277	Coihaique	11	2016-07-25 05:51:22.227606	2016-07-25 05:51:22.227606
278	Lago Verde	11	2016-07-25 05:51:22.231564	2016-07-25 05:51:22.231564
279	Aisn	11	2016-07-25 05:51:22.236539	2016-07-25 05:51:22.236539
280	Cisnes	11	2016-07-25 05:51:22.240569	2016-07-25 05:51:22.240569
281	Guaitecas	11	2016-07-25 05:51:22.245262	2016-07-25 05:51:22.245262
282	Cochrane	11	2016-07-25 05:51:22.249503	2016-07-25 05:51:22.249503
283	OHiggins	11	2016-07-25 05:51:22.253322	2016-07-25 05:51:22.253322
284	Tortel	11	2016-07-25 05:51:22.257521	2016-07-25 05:51:22.257521
285	Chile Chico	11	2016-07-25 05:51:22.261716	2016-07-25 05:51:22.261716
286	Ro Ibñez	11	2016-07-25 05:51:22.266675	2016-07-25 05:51:22.266675
287	Punta Arenas	12	2016-07-25 05:51:22.270712	2016-07-25 05:51:22.270712
288	Laguna Blanca	12	2016-07-25 05:51:22.275055	2016-07-25 05:51:22.275055
289	Ro Verde	12	2016-07-25 05:51:22.279535	2016-07-25 05:51:22.279535
290	San Gregorio	12	2016-07-25 05:51:22.283633	2016-07-25 05:51:22.283633
291	Cabo de Hornos (Ex. Navarino)	12	2016-07-25 05:51:22.288322	2016-07-25 05:51:22.288322
292	Antrtica	12	2016-07-25 05:51:22.292486	2016-07-25 05:51:22.292486
293	Porvenir	12	2016-07-25 05:51:22.298791	2016-07-25 05:51:22.298791
294	Primavera	12	2016-07-25 05:51:22.306032	2016-07-25 05:51:22.306032
295	Timaukel	12	2016-07-25 05:51:22.311365	2016-07-25 05:51:22.311365
296	Natales	12	2016-07-25 05:51:22.316434	2016-07-25 05:51:22.316434
297	Torres del Paine	12	2016-07-25 05:51:22.322334	2016-07-25 05:51:22.322334
298	Santiago	13	2016-07-25 05:51:22.327017	2016-07-25 05:51:22.327017
299	Cerrillos	13	2016-07-25 05:51:22.332077	2016-07-25 05:51:22.332077
300	Cerro Navia	13	2016-07-25 05:51:22.336527	2016-07-25 05:51:22.336527
301	Conchal	13	2016-07-25 05:51:22.340487	2016-07-25 05:51:22.340487
302	El Bosque	13	2016-07-25 05:51:22.347618	2016-07-25 05:51:22.347618
303	Estacin Central	13	2016-07-25 05:51:22.353935	2016-07-25 05:51:22.353935
304	Huechuraba	13	2016-07-25 05:51:22.360817	2016-07-25 05:51:22.360817
305	Independencia	13	2016-07-25 05:51:22.367164	2016-07-25 05:51:22.367164
306	La Cisterna	13	2016-07-25 05:51:22.373595	2016-07-25 05:51:22.373595
307	La Florida	13	2016-07-25 05:51:22.380409	2016-07-25 05:51:22.380409
308	La Granja	13	2016-07-25 05:51:22.386412	2016-07-25 05:51:22.386412
309	La Pintana	13	2016-07-25 05:51:22.392652	2016-07-25 05:51:22.392652
310	La Reina	13	2016-07-25 05:51:22.399454	2016-07-25 05:51:22.399454
311	Las Condes	13	2016-07-25 05:51:22.406102	2016-07-25 05:51:22.406102
312	Lo Barnechea	13	2016-07-25 05:51:22.41361	2016-07-25 05:51:22.41361
313	Lo Espejo	13	2016-07-25 05:51:22.419011	2016-07-25 05:51:22.419011
314	Lo Prado	13	2016-07-25 05:51:22.422914	2016-07-25 05:51:22.422914
315	Macul	13	2016-07-25 05:51:22.427827	2016-07-25 05:51:22.427827
316	Maip	13	2016-07-25 05:51:22.431786	2016-07-25 05:51:22.431786
317	Ñuñoa	13	2016-07-25 05:51:22.43647	2016-07-25 05:51:22.43647
318	Pedro Aguirre Cerda	13	2016-07-25 05:51:22.440685	2016-07-25 05:51:22.440685
319	Peñaloln	13	2016-07-25 05:51:22.445762	2016-07-25 05:51:22.445762
320	Providencia	13	2016-07-25 05:51:22.449455	2016-07-25 05:51:22.449455
321	Pudahuel	13	2016-07-25 05:51:22.454344	2016-07-25 05:51:22.454344
322	Quilicura	13	2016-07-25 05:51:22.458648	2016-07-25 05:51:22.458648
323	Quinta Normal	13	2016-07-25 05:51:22.462644	2016-07-25 05:51:22.462644
324	Recoleta	13	2016-07-25 05:51:22.466818	2016-07-25 05:51:22.466818
325	Renca	13	2016-07-25 05:51:22.470759	2016-07-25 05:51:22.470759
326	San Joaqun	13	2016-07-25 05:51:22.475797	2016-07-25 05:51:22.475797
327	San Miguel	13	2016-07-25 05:51:22.479783	2016-07-25 05:51:22.479783
328	San Ramn	13	2016-07-25 05:51:22.483933	2016-07-25 05:51:22.483933
329	Vitacura	13	2016-07-25 05:51:22.488494	2016-07-25 05:51:22.488494
330	Puente Alto	13	2016-07-25 05:51:22.493344	2016-07-25 05:51:22.493344
331	Pirque	13	2016-07-25 05:51:22.499959	2016-07-25 05:51:22.499959
332	San Jos de Maipo	13	2016-07-25 05:51:22.505899	2016-07-25 05:51:22.505899
333	Colina	13	2016-07-25 05:51:22.514478	2016-07-25 05:51:22.514478
334	Lampa	13	2016-07-25 05:51:22.519716	2016-07-25 05:51:22.519716
335	Tiltil	13	2016-07-25 05:51:22.523845	2016-07-25 05:51:22.523845
336	San Bernardo	13	2016-07-25 05:51:22.528616	2016-07-25 05:51:22.528616
337	Buin	13	2016-07-25 05:51:22.533344	2016-07-25 05:51:22.533344
338	Calera de Tango	13	2016-07-25 05:51:22.537415	2016-07-25 05:51:22.537415
339	Paine	13	2016-07-25 05:51:22.541584	2016-07-25 05:51:22.541584
340	Melipilla	13	2016-07-25 05:51:22.545918	2016-07-25 05:51:22.545918
341	Alhu	13	2016-07-25 05:51:22.55103	2016-07-25 05:51:22.55103
342	Curacav	13	2016-07-25 05:51:22.555065	2016-07-25 05:51:22.555065
343	Mara Pinto	13	2016-07-25 05:51:22.559167	2016-07-25 05:51:22.559167
344	San Pedro	13	2016-07-25 05:51:22.563333	2016-07-25 05:51:22.563333
345	Talagante	13	2016-07-25 05:51:22.568274	2016-07-25 05:51:22.568274
346	El Monte	13	2016-07-25 05:51:22.572397	2016-07-25 05:51:22.572397
347	Isla de Maipo	13	2016-07-25 05:51:22.576543	2016-07-25 05:51:22.576543
348	Padre Hurtado	13	2016-07-25 05:51:22.580618	2016-07-25 05:51:22.580618
349	Peñaflor	13	2016-07-25 05:51:22.585387	2016-07-25 05:51:22.585387
350	ERROR	1	2016-07-25 05:51:22.589919	2016-07-25 05:51:22.589919
82	Quilpué	5	2016-07-25 05:51:21.220704	2016-08-07 00:19:26.486904
\.


--
-- Name: communes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('communes_id_seq', 350, true);


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY contacts (id, name, contact, email, subject, message, school_id, user_id, created_at, updated_at) FROM stdin;
1	Gustavo Llermaly	7	a@a.com	asdasdsa	asdsad	1350	12	2016-06-13 08:11:43.357665	2016-06-13 08:11:43.357665
\.


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('contacts_id_seq', 1, true);


--
-- Data for Name: contents; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY contents (id, nombre, descripcion, assignature_id, created_at, updated_at) FROM stdin;
1	Contenido de prueba	Contenido de prueba para lenguaje	1	2015-12-02 19:04:58.43468	2015-12-02 19:04:58.43468
2	Otro contenido de prueba	Probando descripción	1	2015-12-24 18:18:27.839343	2015-12-24 18:18:27.839343
3	Números		2	2015-12-27 04:10:29.929836	2015-12-27 04:10:29.929836
4	Contenido de prueba 3		1	2016-02-22 02:22:22.287465	2016-02-22 02:22:22.287465
5			\N	2016-04-02 22:02:45.092251	2016-04-02 22:02:45.092251
6	Contenido historia y cs		3	2016-05-02 05:05:01.051281	2016-05-02 05:05:01.051281
7	Otro contenido historia y cs		3	2016-05-02 05:05:11.075675	2016-05-02 05:05:11.075675
\.


--
-- Name: contents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('contents_id_seq', 7, true);


--
-- Data for Name: difficulty_levels; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY difficulty_levels (id, name, created_at, updated_at) FROM stdin;
1	Fácil	2015-12-02 19:59:36.965248	2015-12-02 19:59:36.965248
2	Medio	2015-12-19 20:24:23.359594	2015-12-19 20:24:23.359594
3	Difícil	2015-12-19 20:24:39.092168	2015-12-19 20:24:39.092168
\.


--
-- Name: difficulty_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('difficulty_levels_id_seq', 4, true);


--
-- Data for Name: evaluation_types; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY evaluation_types (id, nombre, descripcion, created_at, updated_at, short_name) FROM stdin;
2	NIVEL	\N	2016-02-28 00:33:06.531762	2016-05-01 05:44:14.940388	nivel
1	SIMCE	\N	2015-12-02 17:44:02.629221	2016-05-01 05:44:28.052078	simce
3	PSU	\N	2016-05-01 05:44:47.547733	2016-05-01 05:44:47.547733	psu
4	UNIDAD	\N	2016-05-01 05:45:12.026519	2016-05-01 05:45:12.026519	unidad
\.


--
-- Name: evaluation_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('evaluation_types_id_seq', 4, true);


--
-- Data for Name: evaluations; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY evaluations (id, nombre, evaluation_type_id, assignature_id, level_id, created_at, updated_at) FROM stdin;
62	Evaluacion test	2	1	1	2016-07-23 10:01:09.939679	2016-07-23 10:01:09.939679
63	Prueba simce 1bleng	1	1	1	2016-07-25 06:08:57.727398	2016-07-25 06:08:57.727398
64	TEST ROL	2	3	2	2016-07-28 06:49:25.288307	2016-07-28 06:49:25.288307
65	TEST EVA DE NADIE	2	3	1	2016-07-28 12:01:42.795962	2016-07-28 12:01:42.795962
\.


--
-- Name: evaluations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('evaluations_id_seq', 65, true);


--
-- Data for Name: evaluations_questions; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY evaluations_questions (evaluation_id, question_id) FROM stdin;
2	1
2	2
2	4
3	1
3	2
3	4
35	31
35	24
35	14
2	1
2	2
3	2
35	22
5	5
5	2
6	5
7	5
8	2
9	5
10	5
35	7
35	10
35	12
35	6
35	13
35	9
35	16
35	26
35	8
35	27
35	20
35	15
35	11
35	17
36	7
38	31
38	24
38	7
38	10
38	12
38	34
39	14
39	22
39	7
39	10
39	12
40	14
40	31
40	24
40	22
40	7
40	10
40	12
40	9
40	13
40	6
40	34
40	32
40	16
40	15
40	8
40	35
40	21
40	28
40	11
41	31
41	24
41	14
41	22
41	7
41	10
41	12
41	6
41	13
41	9
42	7
42	10
42	12
42	9
42	13
42	6
42	14
42	22
42	31
42	24
43	7
43	10
43	12
43	6
43	13
43	9
44	7
44	10
44	12
44	9
45	36
46	36
46	7
46	10
46	12
46	9
46	32
46	34
46	20
46	31
46	24
46	26
46	8
46	27
47	31
47	24
47	14
47	22
47	7
47	10
47	12
47	13
47	9
48	10
49	7
49	10
49	9
49	36
50	9
50	7
50	10
50	12
50	13
50	31
50	24
51	9
51	7
51	10
51	12
51	13
51	6
52	31
52	24
52	9
52	7
52	10
52	12
53	9
53	7
53	10
53	12
53	13
53	6
55	31
55	24
55	14
55	22
55	7
55	10
55	12
55	6
55	13
55	9
55	36
55	35
55	17
55	21
55	28
55	11
55	8
55	15
55	16
55	34
55	32
55	20
55	26
55	27
56	31
56	24
57	31
57	24
58	6
58	7
58	10
58	12
58	8
58	9
59	38
36	14
36	15
60	41
60	40
60	39
61	6
61	7
61	10
61	12
61	9
62	42
63	42
64	37
64	42
64	43
65	37
65	42
\.


--
-- Data for Name: fact_status_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY fact_status_types (id, nombre, created_at, updated_at) FROM stdin;
\.


--
-- Name: fact_status_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('fact_status_types_id_seq', 1, false);


--
-- Data for Name: fact_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY fact_statuses (id, order_id, fact_status_type_id, comentario, created_at, updated_at) FROM stdin;
\.


--
-- Name: fact_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('fact_statuses_id_seq', 1, false);


--
-- Data for Name: feed_forms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY feed_forms (id, feedback_id, feed_item_id, feed_score_id, created_at, updated_at) FROM stdin;
28	10	1	1	2016-07-28 09:31:28.267124	2016-07-28 09:31:28.267124
29	10	2	1	2016-07-28 09:31:28.282647	2016-07-28 09:31:28.282647
30	10	3	1	2016-07-28 09:31:28.294098	2016-07-28 09:31:28.294098
31	11	1	1	2016-08-09 00:12:28.653163	2016-08-09 00:12:28.653163
32	11	2	1	2016-08-09 00:12:28.665173	2016-08-09 00:12:28.665173
33	11	3	1	2016-08-09 00:12:28.674555	2016-08-09 00:12:28.674555
\.


--
-- Name: feed_forms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('feed_forms_id_seq', 33, true);


--
-- Data for Name: feed_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY feed_items (id, nombre, created_at, updated_at) FROM stdin;
1	Diseño	2016-01-20 16:44:49.948977	2016-01-20 16:44:49.948977
2	Informes	2016-01-20 16:44:54.524673	2016-01-20 16:44:54.524673
3	Atención	2016-01-20 16:44:58.734483	2016-01-20 16:44:58.734483
\.


--
-- Name: feed_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('feed_items_id_seq', 3, true);


--
-- Data for Name: feed_scores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY feed_scores (id, nombre, score, created_at, updated_at) FROM stdin;
1	Muy satisfecho	100	2016-01-20 16:45:11.77791	2016-01-20 16:45:11.77791
2	Satisfecho	75	2016-01-20 16:45:17.267056	2016-01-20 16:45:17.267056
3	Neutral	50	2016-01-20 16:45:22.735926	2016-01-20 16:45:22.735926
4	Insatisfecho	25	2016-01-20 16:45:27.821843	2016-01-20 16:45:27.821843
5	Muy insatisfecho	0	2016-01-20 16:45:33.90484	2016-01-20 16:45:33.90484
\.


--
-- Name: feed_scores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('feed_scores_id_seq', 5, true);


--
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY feedbacks (id, order_id, comentario, created_at, updated_at, score) FROM stdin;
10	901	100 estrellas	2016-07-28 09:31:28.160056	2016-07-28 09:31:28.160056	0
11	905	Genial	2016-08-09 00:12:28.527976	2016-08-09 00:12:28.527976	0
\.


--
-- Name: feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('feedbacks_id_seq', 11, true);


--
-- Data for Name: froala_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY froala_images (id, key, created_at, updated_at) FROM stdin;
1		2016-04-21 02:25:54.334095	2016-04-21 02:25:54.334095
2	uploads/1461205587035-cuadro.jpg	2016-04-21 02:26:38.199521	2016-04-21 02:26:38.199521
3	uploads/1461205611549-chart.png	2016-04-21 02:26:59.698024	2016-04-21 02:26:59.698024
4	uploads/1461205652682-chart.png	2016-04-21 02:27:37.813779	2016-04-21 02:27:37.813779
5	uploads/1461207067499-DSC_0015.jpg	2016-04-21 02:51:28.701281	2016-04-21 02:51:28.701281
6	uploads/1461207326072-chart.png	2016-04-21 02:55:32.936258	2016-04-21 02:55:32.936258
7	uploads/1461211264388-NUMCfDiSNdfEPAs-u6TEtA.png	2016-04-21 04:01:19.603591	2016-04-21 04:01:19.603591
\.


--
-- Name: froala_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('froala_images_id_seq', 7, true);


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY grades (id, school_id, letra, year, created_at, updated_at, level_id) FROM stdin;
27	1234	A	2016	2016-07-25 05:53:14.014289	2016-07-25 05:53:14.014289	1
28	1234	A	2015	2016-07-25 06:13:22.662145	2016-07-25 06:13:22.662145	1
29	1330	A	2016	2016-07-25 07:49:40.518579	2016-07-25 07:49:40.518579	1
30	1330	C	2017	2016-07-25 07:50:37.546544	2016-07-25 07:50:37.546544	2
31	1327	A	2016	2016-07-26 20:41:05.403334	2016-07-26 20:41:05.403334	1
32	1327	B	2016	2016-07-26 20:52:25.003083	2016-07-26 20:52:25.003083	1
33	1327	A	2016	2016-07-26 20:54:30.856095	2016-07-26 20:54:30.856095	2
34	1327	B	2016	2016-07-26 20:57:03.827353	2016-07-26 20:57:03.827353	2
35	1327	A	2016	2016-07-26 21:00:03.598311	2016-07-26 21:00:03.598311	3
36	1327	B	2016	2016-07-26 21:01:23.907054	2016-07-26 21:01:23.907054	3
37	1327	A	2016	2016-07-26 21:03:16.346466	2016-07-26 21:03:16.346466	4
38	1327	B	2016	2016-07-26 21:05:32.238777	2016-07-26 21:05:32.238777	4
39	1327	A	2016	2016-07-26 21:07:24.948902	2016-07-26 21:07:24.948902	5
40	1327	B	2016	2016-07-26 21:08:39.336367	2016-07-26 21:08:39.336367	5
41	1327	A	2016	2016-07-26 21:10:19.704526	2016-07-26 21:10:19.704526	6
43	1327	B	2016	2016-07-26 21:14:11.191171	2016-07-26 21:14:11.191171	6
44	1327	A	2016	2016-07-26 21:17:04.445107	2016-07-26 21:17:04.445107	7
45	1327	B	2016	2016-07-26 21:30:39.898727	2016-07-26 21:30:39.898727	7
46	1327	A	2016	2016-07-26 21:33:07.124089	2016-07-26 21:33:07.124089	8
47	1327	B	2016	2016-07-26 21:34:43.357337	2016-07-26 21:34:43.357337	8
48	1327	A	2016	2016-07-26 21:52:04.843074	2016-07-26 21:52:04.843074	9
49	1327	B	2016	2016-07-26 21:53:23.716319	2016-07-26 21:53:23.716319	9
50	1327	A	2016	2016-07-26 21:54:59.247286	2016-07-26 21:54:59.247286	10
51	1327	B	2016	2016-07-26 21:58:16.471915	2016-07-26 21:58:16.471915	10
52	1327	A	2016	2016-07-26 22:00:58.585376	2016-07-26 22:00:58.585376	11
53	1327	B	2016	2016-07-26 22:03:47.790557	2016-07-26 22:03:47.790557	11
54	1327	A	2016	2016-07-26 22:05:45.906037	2016-07-26 22:05:45.906037	12
55	1327	B	2016	2016-07-26 22:09:05.369084	2016-07-26 22:09:05.369084	12
56	1327	A	2017	2016-07-26 22:27:33.916759	2016-07-26 22:27:33.916759	1
57	1327	B	2017	2016-07-26 22:28:37.266269	2016-07-26 22:28:37.266269	1
58	1327	A	2017	2016-07-26 22:28:52.795597	2016-07-26 22:28:52.795597	2
59	1327	B	2017	2016-07-26 22:32:30.902517	2016-07-26 22:32:30.902517	2
60	1327	A	2017	2016-07-26 22:32:57.214505	2016-07-26 22:32:57.214505	3
61	1327	B	2017	2016-07-26 22:34:35.735596	2016-07-26 22:34:35.735596	3
62	1327	A	2017	2016-07-26 22:35:02.452168	2016-07-26 22:35:02.452168	4
63	1327	B	2017	2016-07-26 22:35:56.861988	2016-07-26 22:35:56.861988	4
64	1327	A	2017	2016-07-26 22:36:10.719241	2016-07-26 22:36:10.719241	5
65	1327	B	2017	2016-07-26 22:36:23.109805	2016-07-26 22:36:23.109805	5
66	1327	A	2017	2016-07-26 22:36:45.588356	2016-07-26 22:36:45.588356	6
67	1327	B	2017	2016-07-26 22:36:58.864417	2016-07-26 22:36:58.864417	6
68	1327	A	2017	2016-07-26 22:38:12.825816	2016-07-26 22:38:12.825816	7
69	1327	B	2017	2016-07-26 22:41:49.345488	2016-07-26 22:41:49.345488	7
70	1327	A	2017	2016-07-26 22:42:05.549851	2016-07-26 22:42:05.549851	8
71	1327	B	2017	2016-07-26 22:42:18.828406	2016-07-26 22:42:18.828406	8
72	1327	A	2017	2016-07-26 22:42:32.242425	2016-07-26 22:42:32.242425	9
73	1327	B	2017	2016-07-26 22:42:45.220655	2016-07-26 22:42:45.220655	9
74	1327	A	2017	2016-07-26 22:42:58.842952	2016-07-26 22:42:58.842952	10
75	1327	B	2017	2016-07-26 22:43:11.615093	2016-07-26 22:43:11.615093	10
76	1327	A	2017	2016-07-26 22:43:26.226613	2016-07-26 22:43:26.226613	11
77	1327	B	2017	2016-07-26 22:43:39.636354	2016-07-26 22:43:39.636354	11
78	1327	A	2017	2016-07-26 22:43:54.659142	2016-07-26 22:43:54.659142	12
79	1327	B	2017	2016-07-26 22:44:12.638289	2016-07-26 22:44:12.638289	12
80	1270	A	2016	2016-07-27 00:22:00.695556	2016-07-27 00:22:00.695556	1
81	1270	B	2016	2016-07-27 00:22:14.201572	2016-07-27 00:22:14.201572	1
82	1270	A	2017	2016-07-27 00:22:29.831242	2016-07-27 00:22:29.831242	1
83	1270	B	2017	2016-07-27 00:22:44.648434	2016-07-27 00:22:44.648434	1
84	1270	A	2016	2016-07-27 00:23:18.845121	2016-07-27 00:23:18.845121	2
85	1270	B	2016	2016-07-27 00:23:30.199494	2016-07-27 00:23:30.199494	2
86	1270	A	2017	2016-07-27 00:23:48.540303	2016-07-27 00:23:48.540303	2
87	1270	B	2017	2016-07-27 00:24:06.506984	2016-07-27 00:24:06.506984	2
88	1270	A	2016	2016-07-27 00:25:19.926142	2016-07-27 00:25:19.926142	3
89	1270	B	2016	2016-07-27 00:25:32.213543	2016-07-27 00:25:32.213543	3
91	1270	B	2017	2016-07-27 00:26:05.395565	2016-07-27 00:26:05.395565	3
92	1270	A	2016	2016-07-27 00:26:29.866231	2016-07-27 00:26:29.866231	4
93	1270	B	2016	2016-07-27 00:26:44.161739	2016-07-27 00:26:44.161739	4
94	1270	A	2017	2016-07-27 00:26:58.566956	2016-07-27 00:26:58.566956	4
95	1270	B	2017	2016-07-27 00:27:11.061931	2016-07-27 00:27:11.061931	4
99	1270	A	2016	2016-07-27 00:29:13.215605	2016-07-27 00:29:13.215605	5
100	1270	B	2016	2016-07-27 00:29:28.172959	2016-07-27 00:29:28.172959	5
101	1270	A	2017	2016-07-27 00:29:49.665417	2016-07-27 00:29:49.665417	5
102	1270	B	2017	2016-07-27 00:30:02.051899	2016-07-27 00:30:02.051899	5
103	1270	A	2016	2016-07-27 00:31:57.771054	2016-07-27 00:31:57.771054	6
104	1270	B	2016	2016-07-27 00:32:09.497875	2016-07-27 00:32:09.497875	6
105	1270	A	2017	2016-07-27 00:32:20.859644	2016-07-27 00:32:20.859644	6
107	1270	B	2017	2016-07-27 00:32:51.248205	2016-07-27 00:32:51.248205	6
108	1270	A	2016	2016-07-27 00:33:03.944025	2016-07-27 00:33:03.944025	7
109	1270	B	2016	2016-07-27 00:33:16.114593	2016-07-27 00:33:16.114593	7
110	1270	A	2017	2016-07-27 00:33:27.142939	2016-07-27 00:33:27.142939	7
111	1270	B	2017	2016-07-27 00:33:40.385552	2016-07-27 00:33:40.385552	7
112	1270	A	2016	2016-07-27 00:33:55.535562	2016-07-27 00:33:55.535562	8
113	1270	B	2016	2016-07-27 00:34:05.718707	2016-07-27 00:34:05.718707	8
114	1270	A	2017	2016-07-27 00:34:16.331597	2016-07-27 00:34:16.331597	8
115	1270	B	2017	2016-07-27 00:34:28.40268	2016-07-27 00:34:28.40268	8
116	1270	A	2016	2016-07-27 00:34:38.221627	2016-07-27 00:34:38.221627	9
117	1270	B	2016	2016-07-27 00:34:49.012803	2016-07-27 00:34:49.012803	9
118	1270	A	2017	2016-07-27 00:35:00.712213	2016-07-27 00:35:00.712213	9
122	1270	B	2017	2016-07-27 00:35:50.511808	2016-07-27 00:35:50.511808	9
123	1270	A	2016	2016-07-27 00:42:00.931522	2016-07-27 00:42:00.931522	10
124	1270	B	2016	2016-07-27 00:42:11.659342	2016-07-27 00:42:11.659342	10
125	1270	A	2017	2016-07-27 00:42:26.900697	2016-07-27 00:42:26.900697	10
126	1270	B	2017	2016-07-27 00:42:40.053771	2016-07-27 00:42:40.053771	10
127	1270	A	2016	2016-07-27 00:43:12.554122	2016-07-27 00:43:12.554122	11
128	1270	B	2016	2016-07-27 00:43:24.819194	2016-07-27 00:43:24.819194	11
129	1270	A	2017	2016-07-27 00:43:37.36712	2016-07-27 00:43:37.36712	11
130	1270	B	2017	2016-07-27 00:43:50.873284	2016-07-27 00:43:50.873284	11
131	1270	A	2016	2016-07-27 00:44:23.697859	2016-07-27 00:44:23.697859	12
132	1270	B	2016	2016-07-27 00:44:36.713372	2016-07-27 00:44:36.713372	12
133	1270	A	2017	2016-07-27 00:44:47.755367	2016-07-27 00:44:47.755367	12
134	1270	B	2017	2016-07-27 00:45:01.444044	2016-07-27 00:45:24.233646	12
138	1307	A	2016	2016-08-03 17:46:16.635165	2016-08-03 17:46:16.635165	1
139	1307	B	2016	2016-08-03 17:51:18.973644	2016-08-03 17:51:18.973644	1
135	1270	A	2017	2016-07-27 02:03:01.621883	2016-07-27 02:03:01.621883	3
136	1330	A	2016	2016-07-27 18:43:55.758703	2016-07-27 18:43:55.758703	6
137	1253	A	2016	2016-07-27 18:54:00.704276	2016-07-27 18:54:00.704276	1
\.


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('grades_id_seq', 139, true);


--
-- Data for Name: grades_students; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY grades_students (grade_id, student_id) FROM stdin;
15	293
15	294
16	295
16	296
39	44
39	45
39	46
16	297
17	298
17	299
17	300
39	44
39	45
39	46
17	301
17	302
18	303
18	304
18	305
19	306
20	307
20	308
25	319
25	320
26	321
26	322
4	21
4	22
4	23
4	24
4	25
4	26
4	27
4	28
4	29
4	30
4	31
4	32
4	33
4	34
4	35
4	36
4	37
4	38
4	39
4	40
4	41
4	42
4	43
4	44
4	45
4	46
4	47
4	48
4	49
4	50
4	51
4	52
4	53
4	54
4	55
4	56
26	323
4	59
4	60
4	61
4	62
4	63
4	64
4	65
4	66
4	67
4	68
4	69
4	70
4	71
4	72
4	73
4	74
4	75
4	76
4	77
4	78
4	79
4	80
4	81
4	82
4	83
4	84
4	85
4	86
4	87
4	88
4	89
4	90
4	91
4	92
4	93
4	94
5	95
5	96
6	97
6	98
6	99
6	100
6	101
6	102
6	103
6	104
7	105
7	106
7	107
7	108
8	109
8	110
8	111
8	112
8	113
8	114
8	115
8	116
8	117
8	118
8	119
8	120
8	121
8	122
8	123
8	124
8	125
8	126
8	127
8	128
8	129
8	130
8	131
8	132
8	133
8	134
8	135
8	136
8	137
8	138
9	139
9	140
9	141
9	142
9	143
9	144
9	145
9	146
9	147
9	148
9	149
9	150
9	151
9	152
9	153
9	154
9	155
9	156
9	157
9	158
9	159
9	160
9	161
9	162
9	163
9	164
9	165
9	166
9	167
9	168
11	233
11	234
11	235
11	236
11	237
11	238
11	239
11	240
11	241
11	242
11	243
11	244
11	245
11	246
11	247
11	248
11	249
11	250
11	251
11	252
11	253
11	254
11	255
11	256
11	257
11	258
11	259
11	260
11	261
11	262
14	263
14	264
14	265
14	266
14	267
14	268
14	269
14	270
14	271
14	272
14	273
14	274
14	275
14	276
14	277
14	278
14	279
14	280
14	281
14	282
14	283
14	284
14	285
14	286
14	287
14	288
14	289
14	290
14	291
14	292
21	309
21	310
12	311
12	312
22	313
22	314
27	324
27	325
28	326
28	327
29	328
29	329
30	330
30	331
30	332
30	333
30	336
31	339
31	340
31	341
31	342
31	343
32	344
32	345
32	346
32	347
32	348
33	349
33	350
33	351
33	352
33	353
34	354
34	355
34	356
34	357
34	358
35	359
35	360
35	361
35	362
35	363
36	364
36	365
36	366
36	367
36	368
37	369
37	370
37	371
37	372
37	373
38	374
38	375
38	376
38	377
38	378
39	379
39	380
39	381
39	382
39	383
40	384
40	385
40	386
40	387
40	388
41	394
41	395
41	396
41	397
41	398
43	399
43	400
43	401
43	402
43	403
44	404
44	405
44	406
44	407
44	408
45	409
45	410
45	411
45	412
45	413
46	414
46	415
46	416
46	417
46	418
47	419
47	420
47	421
47	422
47	423
48	424
48	425
48	426
48	427
48	428
49	429
49	430
49	431
49	432
49	433
50	434
50	435
50	436
50	437
50	438
51	439
51	440
51	441
51	442
51	443
52	444
52	445
52	446
52	447
52	448
53	449
53	450
53	451
53	452
53	453
54	454
54	455
54	456
54	457
54	458
55	459
55	460
55	461
55	462
55	463
58	464
58	465
58	466
58	467
58	468
59	469
59	470
59	471
59	472
59	473
56	474
56	475
56	476
56	477
56	478
57	479
57	480
57	481
57	482
57	483
60	484
60	485
60	486
60	487
60	488
61	489
61	490
61	491
61	492
61	493
63	494
63	495
63	496
63	497
63	498
62	505
62	506
62	509
62	512
62	513
64	514
64	515
64	516
64	517
64	518
65	519
65	520
65	521
65	522
65	523
66	524
66	525
66	526
66	527
66	528
67	529
67	530
67	531
67	532
67	533
68	534
68	535
68	536
68	537
68	538
69	539
69	540
69	541
69	542
69	543
70	544
70	545
70	546
70	547
70	548
71	549
71	550
71	551
71	552
71	553
72	554
72	555
72	556
72	557
72	558
73	559
73	560
73	561
73	562
73	563
74	564
74	565
74	566
74	567
74	568
75	569
75	570
75	571
75	572
75	573
76	574
76	575
76	576
76	577
76	578
77	579
77	580
77	581
77	582
77	583
78	584
78	585
78	586
78	587
78	588
79	589
79	590
79	591
79	592
79	593
80	594
80	595
80	596
80	597
80	598
81	604
81	605
81	606
81	607
81	608
84	609
84	610
84	611
84	612
84	613
85	614
85	615
85	616
85	617
85	618
89	624
89	625
89	626
89	627
89	628
92	629
92	630
92	631
92	632
92	633
93	634
93	635
93	636
93	637
93	638
99	639
99	640
99	641
99	642
99	643
100	644
100	645
100	646
100	647
100	648
103	649
103	650
103	651
103	652
103	653
104	654
104	655
104	656
104	657
104	658
108	659
108	660
108	661
108	662
108	663
109	664
109	665
109	666
109	667
109	668
112	669
112	670
112	671
112	672
112	673
113	674
113	675
113	676
113	677
113	678
116	679
116	680
116	681
116	682
116	683
117	684
117	685
117	686
117	687
117	688
123	689
123	690
123	691
123	692
123	693
124	694
124	695
124	696
124	697
124	698
127	699
127	700
127	701
127	702
127	703
128	704
128	705
128	706
128	707
128	708
131	709
131	710
131	711
131	712
131	713
132	714
132	715
132	716
132	717
132	718
82	719
82	720
82	721
82	722
82	723
83	724
83	725
83	726
83	727
83	728
86	729
86	730
86	731
86	732
86	733
87	734
87	735
87	736
87	737
87	738
91	739
91	740
91	741
91	742
91	743
135	744
135	745
135	746
135	747
135	748
94	749
94	750
94	751
94	752
94	753
95	754
95	755
95	756
95	757
95	758
101	759
101	760
101	761
101	762
101	763
102	764
102	765
102	766
102	767
102	768
105	769
105	770
105	771
105	772
105	773
107	774
107	775
107	776
107	777
107	778
110	779
110	780
110	781
110	782
110	783
111	784
111	785
111	786
111	787
111	788
114	789
114	790
114	791
114	792
114	793
115	794
115	795
115	796
115	797
115	798
118	799
118	800
118	801
118	802
118	803
122	804
122	805
122	806
122	807
122	808
125	809
125	810
125	811
125	812
125	813
126	814
126	815
126	816
126	817
126	818
129	819
129	820
129	821
129	822
129	823
129	824
129	825
129	826
129	827
129	828
130	829
130	830
130	831
130	832
130	833
133	834
133	835
133	836
133	837
133	838
134	839
134	840
134	841
134	842
134	843
137	320
137	851
137	852
137	853
29	852
29	854
29	855
29	856
29	857
29	858
137	859
137	861
138	254
138	118
138	137
138	131
138	126
138	120
138	111
138	128
138	138
138	136
138	115
138	121
138	114
138	132
138	129
138	127
138	110
138	124
138	125
138	863
138	116
138	106
138	113
138	117
138	135
138	119
138	134
138	123
138	112
138	133
138	109
138	864
138	865
138	866
138	867
138	868
138	869
138	870
138	871
138	872
138	873
138	874
138	875
138	876
138	877
139	59
139	60
139	61
139	62
139	63
139	64
139	65
139	66
139	67
139	68
139	69
139	70
139	71
139	72
139	73
139	74
139	75
139	76
139	77
139	78
139	79
139	80
139	81
139	82
139	83
139	84
139	85
139	86
139	87
139	88
139	89
139	90
139	91
139	92
139	93
139	94
139	118
139	119
139	120
139	121
139	106
139	123
139	124
139	125
139	126
139	127
\.


--
-- Data for Name: group_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY group_questions (id, statement, created_at, updated_at) FROM stdin;
5	<p>Test</p>	2016-03-31 03:21:58.597516	2016-03-31 03:21:58.597516
6	<p>Test</p>	2016-03-31 03:25:35.854809	2016-03-31 03:25:35.854809
9	<p>TEST</p>	2016-03-31 04:06:02.802002	2016-03-31 04:06:02.802002
10	<p>TESTESTSASDSADASD</p>	2016-03-31 04:10:11.160414	2016-03-31 04:10:11.160414
17	<p>En base a la imagen evalue y conteste</p>	2016-04-01 01:45:42.420416	2016-04-01 01:45:42.420416
23	<p>En base a la pregunta conteste&nbsp;</p>	2016-04-06 04:22:48.971847	2016-04-06 04:22:48.971847
20	<p>rara preguntas aca [PREGUNTAS]</p>	2016-04-02 03:28:39.975559	2016-04-07 06:15:22.207984
18	<p>Responda las preguntas [PREGUNTAS] en base a los numeros a continuación</p><p><br></p><p><img class="fr-dib fr-draggable fr-fil" src="https://s3.amazonaws.com/reimagina-develop/uploads%2F1460669474004-cuadro.jpg" style="width: 53px;"></p>	2016-04-01 06:24:09.306993	2016-04-14 21:31:41.467135
11	<p>En base a la siguiente oracion conteste las preguntas [PREGUNTAS]&nbsp;<img class="fr-dib fr-draggable" src="https://s3.amazonaws.com/reimagina-develop/uploads%2F1460669903178-cuadro.jpg" style="width: 29px;"></p>	2016-03-31 04:12:22.826786	2016-04-14 21:38:32.311722
24	<p>TASDasdsa</p>	2016-05-12 07:19:10.596209	2016-05-12 07:19:10.596209
19	<p style="text-align: center;">TSADASDAS <img class="fr-dib fr-draggable" src="https://s3.amazonaws.com/reimagina-develop/uploads/1463079176485-untitled" style="width: 189px;"></p>	2016-04-02 01:41:13.247339	2016-05-17 15:14:25.874672
25	<p>TEST ROLE PREGUNTAS []</p>	2016-07-28 06:51:01.642161	2016-07-28 06:51:01.642161
\.


--
-- Name: group_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('group_questions_id_seq', 25, true);


--
-- Data for Name: guides; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY guides (id, instrument_id, question_id, alternative_id, question_index, alternative_index, created_at, updated_at) FROM stdin;
590	73	42	100	1	A	2016-07-23 10:01:10.069235	2016-07-23 10:01:10.069235
591	74	42	100	1	A	2016-07-25 06:08:57.886638	2016-07-25 06:08:57.886638
592	75	42	100	2	A	2016-07-28 06:49:25.5728	2016-07-28 06:49:25.5728
593	75	43	103	3	A	2016-07-28 06:49:25.601364	2016-07-28 06:49:25.601364
594	76	42	100	2	A	2016-07-28 12:01:42.888209	2016-07-28 12:01:42.888209
\.


--
-- Name: guides_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('guides_id_seq', 594, true);


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY images (id, created_at, updated_at, image_file_name, image_content_type, image_file_size, image_updated_at) FROM stdin;
\.


--
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('images_id_seq', 1, false);


--
-- Data for Name: instrument_alternatives_positions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY instrument_alternatives_positions (id, instrument_id, question_id, alternative_id, instrument_questions_position_id, "position", created_at, updated_at) FROM stdin;
1216	73	42	100	376	A	2016-07-23 10:01:10.032207	2016-07-23 10:01:10.032207
1217	73	42	101	376	B	2016-07-23 10:01:10.074075	2016-07-23 10:01:10.074075
1218	73	42	102	376	C	2016-07-23 10:01:10.076999	2016-07-23 10:01:10.076999
1219	74	42	100	377	A	2016-07-25 06:08:57.876295	2016-07-25 06:08:57.876295
1220	74	42	101	377	B	2016-07-25 06:08:57.890873	2016-07-25 06:08:57.890873
1221	74	42	102	377	C	2016-07-25 06:08:57.894577	2016-07-25 06:08:57.894577
1222	75	42	100	379	A	2016-07-28 06:49:25.524697	2016-07-28 06:49:25.524697
1223	75	42	101	379	B	2016-07-28 06:49:25.579606	2016-07-28 06:49:25.579606
1224	75	42	102	379	C	2016-07-28 06:49:25.585856	2016-07-28 06:49:25.585856
1225	75	43	103	380	A	2016-07-28 06:49:25.595389	2016-07-28 06:49:25.595389
1226	75	43	104	380	B	2016-07-28 06:49:25.604983	2016-07-28 06:49:25.604983
1227	76	42	100	382	A	2016-07-28 12:01:42.869577	2016-07-28 12:01:42.869577
1228	76	42	101	382	B	2016-07-28 12:01:42.893332	2016-07-28 12:01:42.893332
1229	76	42	102	382	C	2016-07-28 12:01:42.89872	2016-07-28 12:01:42.89872
\.


--
-- Name: instrument_alternatives_positions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('instrument_alternatives_positions_id_seq', 1229, true);


--
-- Data for Name: instrument_proccesses; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY instrument_proccesses (id, proccess_id, instrument_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: instrument_proccesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('instrument_proccesses_id_seq', 1, false);


--
-- Data for Name: instrument_questions_positions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY instrument_questions_positions (id, instrument_id, question_id, "position", created_at, updated_at) FROM stdin;
376	73	42	1	2016-07-23 10:01:09.994068	2016-07-23 10:01:09.994068
377	74	42	1	2016-07-25 06:08:57.782672	2016-07-25 06:08:57.782672
378	75	37	1	2016-07-28 06:49:25.447831	2016-07-28 06:49:25.447831
379	75	42	2	2016-07-28 06:49:25.468492	2016-07-28 06:49:25.468492
380	75	43	3	2016-07-28 06:49:25.589869	2016-07-28 06:49:25.589869
381	76	37	1	2016-07-28 12:01:42.820018	2016-07-28 12:01:42.820018
382	76	42	2	2016-07-28 12:01:42.845527	2016-07-28 12:01:42.845527
\.


--
-- Name: instrument_questions_positions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('instrument_questions_positions_id_seq', 382, true);


--
-- Data for Name: instruments; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY instruments (id, nombre, evaluation_id, created_at, updated_at) FROM stdin;
73	Evaluacion test	62	2016-07-23 10:01:09.951663	2016-07-23 10:01:09.951663
74	Prueba simce 1bleng	63	2016-07-25 06:08:57.737783	2016-07-25 06:08:57.737783
75	TEST ROL	64	2016-07-28 06:49:25.34619	2016-07-28 06:49:25.34619
76	TEST EVA DE NADIE	65	2016-07-28 12:01:42.808374	2016-07-28 12:01:42.808374
\.


--
-- Name: instruments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('instruments_id_seq', 76, true);


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY invoices (id, order_id, numero, fecha, monto, created_at, updated_at, document_file_name, document_content_type, document_file_size, document_updated_at, comentario) FROM stdin;
\.


--
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('invoices_id_seq', 8, true);


--
-- Data for Name: learning_goals; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY learning_goals (id, nombre, descripcion, assignature_id, level_id, created_at, updated_at) FROM stdin;
31	25	OA 25 lenguaje primero basico	1	1	2016-07-23 09:58:32.109721	2016-07-23 09:58:32.109721
32	22		3	1	2016-07-28 06:15:25.390398	2016-07-28 06:15:25.390398
\.


--
-- Name: learning_goals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('learning_goals_id_seq', 32, true);


--
-- Data for Name: learning_goals_units; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY learning_goals_units (learning_goal_id, unit_id) FROM stdin;
1	1
2	1
3	1
4	1
27	6
10	7
27	7
28	7
30	8
31	1
\.


--
-- Data for Name: levels; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY levels (id, nombre, short_name, created_at, updated_at) FROM stdin;
1	Primero Basico	primero_b	2015-12-02 17:44:02.673117	2015-12-02 17:44:02.673117
2	Segundo Basico	segundo_b	2015-12-02 17:44:02.681531	2015-12-02 17:44:02.681531
3	Tercero Basico	tercero_b	2015-12-02 17:44:02.697495	2015-12-02 17:44:02.697495
4	Cuarto Basico	cuarto_b	2015-12-02 17:44:02.706961	2015-12-02 17:44:02.706961
5	Quinto Basico	quinto_b	2015-12-02 17:44:02.715568	2015-12-02 17:44:02.715568
6	Sexto Basico	sexto_b	2015-12-02 17:44:02.722536	2015-12-02 17:44:02.722536
7	Septimo Basico	septimo_b	2015-12-02 17:44:02.730877	2015-12-02 17:44:02.730877
8	Octavo Basico	octavo_b	2015-12-02 17:44:02.740231	2015-12-02 17:44:02.740231
9	Primero Medio	primero_m	2015-12-02 17:44:02.748402	2015-12-02 17:44:02.748402
10	Segundo Medio	segundo_m	2015-12-02 17:44:02.765552	2015-12-02 17:44:02.765552
11	Tercero Medio	tercero_m	2015-12-02 17:44:02.773976	2015-12-02 17:44:02.773976
12	Cuarto Medio	cuarto_m	2015-12-02 17:44:02.780903	2015-12-02 17:44:02.780903
\.


--
-- Name: levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('levels_id_seq', 12, true);


--
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY order_statuses (id, order_id, status_type_id, comentario, created_at, updated_at) FROM stdin;
2151	895	1	Orden #1 creada	2016-06-28 08:56:44.768002	2016-06-28 08:56:44.768002
2152	895	2	Proceso #NIVEL DIAGNOSTICO creado	2016-06-28 08:56:59.120979	2016-06-28 08:56:59.120979
2153	896	1	Orden #2 creada	2016-06-28 10:55:32.136378	2016-06-28 10:55:32.136378
2154	896	2	Proceso #NIVEL DIAGNOSTICO creado	2016-06-28 10:55:44.199416	2016-06-28 10:55:44.199416
2155	897	1	Orden #3 creada	2016-06-28 11:05:46.684619	2016-06-28 11:05:46.684619
2156	897	2	Proceso #NIVEL DIAGNOSTICO creado	2016-06-28 11:05:59.53389	2016-06-28 11:05:59.53389
2157	898	1	Orden #4 creada	2016-06-29 15:50:23.648067	2016-06-29 15:50:23.648067
2158	898	2	Proceso #NIVEL DIAGNOSTICO creado	2016-06-29 15:50:36.118329	2016-06-29 15:50:36.118329
2161	900	1	Orden #6 creada	2016-07-01 13:31:49.224069	2016-07-01 13:31:49.224069
2162	900	2	Proceso #NIVEL DIAGNOSTICO creado	2016-07-01 13:32:03.458605	2016-07-01 13:32:03.458605
2163	895	2	Proceso #SIMCE 1 creado	2016-07-25 06:11:43.849179	2016-07-25 06:11:43.849179
2164	901	1	Orden #7 creada	2016-07-25 06:12:57.900658	2016-07-25 06:12:57.900658
2165	901	2	Proceso #SIMCE 1 creado	2016-07-25 06:14:42.809163	2016-07-25 06:14:42.809163
2166	901	2	Proceso #NIVEL DIAGNOSTICO creado	2016-07-25 06:19:50.550707	2016-07-25 06:19:50.550707
2167	902	1	Orden #8 creada	2016-07-28 06:24:12.773266	2016-07-28 06:24:12.773266
2168	902	2	Proceso #NIVEL INTERMEDIO creado	2016-07-28 06:24:37.187867	2016-07-28 06:24:37.187867
2169	895	3	Pago por 0	2016-08-04 07:56:44.782929	2016-08-04 07:56:44.782929
2170	895	3	Pago por 0	2016-08-04 07:56:44.797278	2016-08-04 07:56:44.797278
2171	895	3	Pago por 0	2016-08-04 07:56:44.807891	2016-08-04 07:56:44.807891
2172	903	1	Orden # creada	2016-08-08 22:08:15.880657	2016-08-08 22:08:15.880657
2173	903	2	Proceso #SIMCE creado	2016-08-08 22:08:16.009367	2016-08-08 22:08:16.009367
2174	\N	2	Proceso #procs creado	2016-08-08 22:27:12.358323	2016-08-08 22:27:12.358323
2175	\N	2	Proceso #simcete creado	2016-08-08 22:38:55.630711	2016-08-08 22:38:55.630711
2176	\N	2	Proceso #simcexz creado	2016-08-08 23:05:14.304065	2016-08-08 23:05:14.304065
2177	904	1	Orden # creada	2016-08-08 23:22:30.014859	2016-08-08 23:22:30.014859
2178	904	2	Proceso #simcete creado	2016-08-08 23:22:30.157623	2016-08-08 23:22:30.157623
2179	905	1	Orden # creada	2016-08-09 00:10:32.377699	2016-08-09 00:10:32.377699
2180	905	2	Proceso #simcete creado	2016-08-09 00:10:32.508053	2016-08-09 00:10:32.508053
2181	906	1	Orden # creada	2016-08-09 00:14:36.289019	2016-08-09 00:14:36.289019
2182	906	2	Proceso #PME creado	2016-08-09 00:14:36.317181	2016-08-09 00:14:36.317181
\.


--
-- Name: order_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('order_statuses_id_seq', 2182, true);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY orders (id, school_id, year, paymethod, contract, created_at, updated_at, number, licitacion) FROM stdin;
895	1234	2016	OC Directa	SI	2016-06-28 08:56:44.691585	2016-06-28 08:56:44.691585	1	23123
896	1307	2016	Licitacion	NO	2016-06-28 10:55:32.134323	2016-06-28 10:55:32.134323	2	21321321
897	1299	2016	Licitacion	SI	2016-06-28 11:05:46.682685	2016-06-28 11:05:46.682685	3	123213
898	1270	2016	OC Directa	SI	2016-06-29 15:50:23.566957	2016-06-29 15:50:23.566957	4	13221321
900	1313	2016	OC Directa	NO	2016-07-01 13:31:49.221532	2016-07-01 13:31:49.221532	6	23232
901	1234	2015	Licitacion	SI	2016-07-25 06:12:57.893514	2016-07-25 06:12:57.893514	7	21321321
902	1327	2016	OC Directa	NO	2016-07-28 06:24:12.76592	2016-07-28 06:24:12.76592	8	123213
903	1216	8	Al contado Marzo	no	2016-08-08 22:08:15.80757	2016-08-08 22:08:15.80757	\N	\N
905	1368	2015	cas$	no	2016-08-09 00:10:32.31444	2016-08-09 00:10:32.31444	\N	\N
906	1369	2014	2 Cuotas	no	2016-08-09 00:14:36.27964	2016-08-09 00:14:36.27964	\N	\N
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('orders_id_seq', 906, true);


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY payments (id, order_id, monto, comentario, fecha, created_at, updated_at, paid) FROM stdin;
41	895	0	Cuota 1 de 3 Orden 1	2016-09-01	2016-08-04 07:56:44.747466	2016-08-04 07:56:44.747466	\N
42	895	0	Cuota 2 de 3 Orden 1	2016-10-01	2016-08-04 07:56:44.79395	2016-08-04 07:56:44.79395	\N
43	895	0	Cuota 3 de 3 Orden 1	2016-11-01	2016-08-04 07:56:44.80434	2016-08-04 07:56:44.80434	\N
\.


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('payments_id_seq', 43, true);


--
-- Data for Name: pme_abilities; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY pme_abilities (id, nombre, descripcion, created_at, updated_at, assignature_id) FROM stdin;
1	EXTRACCIÓN DE INFORMACIÓN EXPLÍCITA		2015-12-02 17:44:03.160816	2015-12-02 17:44:03.160816	\N
2	EXTRACCIÓN DE INFORMACIÓN IMPLÍCITA		2015-12-02 17:44:03.173037	2015-12-02 17:44:03.173037	\N
3	DESARROLLO DE DESTREZA DE LA LECTURA INICIAL		2015-12-02 17:44:03.182355	2015-12-02 17:44:03.182355	\N
4	REFLEXIÓN SOBRE EL TEXTO		2015-12-02 17:44:03.189548	2015-12-02 17:44:03.189548	\N
5	Extraer información explícita	Descripción	2015-12-27 03:50:39.422235	2015-12-27 03:50:39.422235	1
6	Resolver probPME		2015-12-27 04:11:17.350225	2015-12-27 04:11:17.350225	2
7	Leer un periódico		2016-02-22 02:22:41.866684	2016-02-22 02:22:41.866684	1
8	Reflexión sobre el texto		2016-02-22 02:22:52.725112	2016-02-22 02:22:52.725112	1
9	Extraer información implícita		2016-02-22 02:23:18.199521	2016-02-22 02:23:18.199521	1
10	Hab Pme Historia		2016-05-02 05:08:23.921576	2016-05-02 05:08:23.921576	3
\.


--
-- Name: pme_abilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('pme_abilities_id_seq', 10, true);


--
-- Data for Name: proc_type_fathers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY proc_type_fathers (id, nombre, short_name, created_at, updated_at) FROM stdin;
1	SIMCE	simce	2016-05-20 03:22:29.533592	2016-05-20 03:22:29.533592
2	NIVEL	nivel	2016-06-16 13:09:45.233064	2016-06-16 13:09:45.233064
\.


--
-- Name: proc_type_fathers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('proc_type_fathers_id_seq', 2, true);


--
-- Data for Name: proc_types; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY proc_types (id, nombre, descripcion, created_at, updated_at, short_name, proc_type_father_id) FROM stdin;
19	PSU	\N	2015-12-13 07:41:28.734284	2015-12-13 07:41:28.734284	\N	\N
26	SIMCE 1		2016-05-20 03:23:43.787591	2016-06-16 13:13:19.327213	simce_1	1
27	NIVEL DIAGNOSTICO		2016-06-16 13:13:34.365849	2016-06-16 13:18:35.219211	\N	2
28	NIVEL INTERMEDIO		2016-06-16 13:13:45.14477	2016-06-16 13:18:50.290644	\N	2
29	NIVEL FINAL		2016-06-16 13:13:55.733015	2016-06-16 13:18:57.149458	\N	2
30	SIMCE 2		2016-06-16 13:14:05.092141	2016-06-16 13:19:07.127968	\N	1
31	SIMCE 3		2016-06-16 13:14:14.741212	2016-06-16 13:19:13.593473	\N	1
32	SIMCE	\N	2016-08-08 22:08:15.673815	2016-08-08 22:08:15.673815	\N	\N
33	\N	\N	2016-08-08 22:08:15.69566	2016-08-08 22:08:15.69566	\N	\N
34	procs	\N	2016-08-08 22:27:12.301227	2016-08-08 22:27:12.301227	\N	\N
35	simcete	\N	2016-08-08 22:38:55.252568	2016-08-08 22:38:55.252568	\N	\N
36	simcexz	\N	2016-08-08 23:05:14.181237	2016-08-08 23:05:14.181237	\N	\N
37	PME	\N	2016-08-09 00:14:36.220495	2016-08-09 00:14:36.220495	\N	\N
\.


--
-- Name: proc_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('proc_types_id_seq', 37, true);


--
-- Data for Name: proccess_instruments; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY proccess_instruments (id, proccess_id, instrument_id, grade_id) FROM stdin;
165	1210	73	27
166	1216	74	27
167	1217	74	28
168	1218	73	28
169	1219	73	31
170	1219	73	32
171	1211	73	138
172	1211	74	138
173	1211	74	139
\.


--
-- Name: proccess_instruments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('proccess_instruments_id_seq', 173, true);


--
-- Data for Name: proccesses; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY proccesses (id, order_id, proc_type_id, monto, created_at, updated_at, fecha, billed) FROM stdin;
1211	896	27	220020	2016-06-28 10:55:44.196272	2016-06-28 10:55:44.196272	2016-06-28	\N
1212	897	27	22222	2016-06-28 11:05:59.531193	2016-06-28 11:05:59.531193	2016-06-28	\N
1215	900	27	100000	2016-07-01 13:32:03.45632	2016-07-01 13:32:03.45632	2016-07-01	\N
1217	901	26	23000	2016-07-25 06:14:42.80282	2016-07-25 06:14:42.80282	2016-07-26	\N
1218	901	27	35000	2016-07-25 06:19:50.546439	2016-07-25 06:19:50.546439	2016-06-30	\N
1219	902	28	220000	2016-07-28 06:24:37.17765	2016-07-28 06:24:37.17765	2016-07-28	\N
1210	895	27	25000	2016-06-28 08:56:59.082455	2016-06-28 08:56:59.082455	2016-06-28	t
1216	895	26	35000	2016-07-25 06:11:43.837925	2016-07-25 06:11:43.837925	2016-07-25	t
1220	903	32	\N	2016-08-08 22:08:15.987822	2016-08-08 22:08:15.987822	\N	\N
1221	\N	34	\N	2016-08-08 22:27:12.344982	2016-08-08 22:27:12.344982	\N	\N
1222	\N	35	\N	2016-08-08 22:38:55.504906	2016-08-08 22:38:55.504906	\N	\N
1223	\N	36	\N	2016-08-08 23:05:14.285808	2016-08-08 23:05:14.285808	\N	\N
1224	904	35	\N	2016-08-08 23:22:30.128112	2016-08-08 23:22:30.128112	\N	\N
1225	905	35	\N	2016-08-09 00:10:32.480382	2016-08-09 00:10:32.480382	\N	\N
1226	906	37	\N	2016-08-09 00:14:36.31121	2016-08-09 00:14:36.31121	\N	\N
\.


--
-- Name: proccesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('proccesses_id_seq', 1226, true);


--
-- Data for Name: program_axis; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY program_axis (id, assignature_id, ombre, descripcion, created_at, updated_at) FROM stdin;
\.


--
-- Name: program_axis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('program_axis_id_seq', 1, false);


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY questions (id, texto, assignature_id, level_id, bloom_ability_id, axes_content_id, ability_content_id, unit_id, learning_goal_id, created_at, updated_at, difficulty_level_id, content_id, axis_id, pme_ability_id, assignature_ability_id, axis_program_id, group_question_id) FROM stdin;
42	<p>Pregunta de test para ver la letra&nbsp;</p>	1	1	2	\N	\N	1	31	2016-07-23 10:00:40.577182	2016-07-23 10:00:40.577182	2	1	1	5	12	2	\N
44	<p>TEST PREGUNTA ROL</p>	1	1	3	\N	\N	1	31	2016-07-28 06:50:01.288125	2016-07-28 06:50:01.288125	2	1	1	5	12	2	\N
37	<p>PREGUNTA CON ESPACIOS</p>	4	3	\N	\N	\N	\N	\N	2016-05-11 21:16:59.470677	2016-07-28 06:51:24.858146	\N	\N	\N	\N	\N	\N	\N
43	<p>Pregunta mate primero basico</p>	2	1	2	\N	\N	8	\N	2016-07-28 06:15:56.702099	2016-07-28 06:51:29.677372	2	3	4	6	15	3	\N
\.


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('questions_id_seq', 44, true);


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY regions (id, name, roman, created_at, updated_at) FROM stdin;
1	Tarapacá	I	2015-12-02 17:44:03.43977	2015-12-02 17:44:03.43977
2	Antofagasta	II	2015-12-02 17:44:03.44792	2015-12-02 17:44:03.44792
3	Atacama	III	2015-12-02 17:44:03.456626	2015-12-02 17:44:03.456626
4	Coquimbo	IV	2015-12-02 17:44:03.464696	2015-12-02 17:44:03.464696
5	Valparaíso	V	2015-12-02 17:44:03.472817	2015-12-02 17:44:03.472817
6	Región del Libertador Gral. Bernardo O'Higgins	VI	2015-12-02 17:44:03.481198	2015-12-02 17:44:03.481198
7	Región del Maule	VII	2015-12-02 17:44:03.489509	2015-12-02 17:44:03.489509
8	Región del Biobío	VIII	2015-12-02 17:44:03.497864	2015-12-02 17:44:03.497864
9	Región de la Araucanía	IX	2015-12-02 17:44:03.507433	2015-12-02 17:44:03.507433
14	Región de los Ríos	XIV	2015-12-02 17:44:03.514564	2015-12-02 17:44:03.514564
11	Región Aisén del Gral. Carlos Ibañez del Campo	XI	2015-12-02 17:44:03.531274	2015-12-02 17:44:03.531274
12	Región de Magallanes y de la Antártica Chilena	XII	2015-12-02 17:44:03.539579	2015-12-02 17:44:03.539579
13	Región Metropolitana de Santiago	XIII	2015-12-02 17:44:03.548291	2015-12-02 17:44:03.548291
10	Región de los Lagos	X 	2015-12-02 17:44:03.523144	2015-12-02 21:37:13.634249
15	Arica y Parinacota	XV	2015-12-02 17:44:03.427412	2015-12-02 21:38:36.201902
\.


--
-- Name: regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('regions_id_seq', 1, false);


--
-- Data for Name: remedials; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY remedials (id, nombre, content_id, level_id, created_at, updated_at) FROM stdin;
2	Remedial de prueba del contenido números para quinto básico	3	5	2016-01-03 02:24:01.376476	2016-01-03 02:24:01.376476
3	Remedial contenido 1	1	1	2016-02-22 02:23:57.532004	2016-02-22 02:23:57.532004
4	Remedial contenido 2	2	1	2016-02-22 02:24:06.672621	2016-02-22 02:24:06.672621
5	Remedial contenido 3	4	1	2016-02-22 02:24:16.039746	2016-02-22 02:24:16.039746
7	Remedial Historia	6	7	2016-05-02 05:07:40.250682	2016-05-02 05:07:40.250682
\.


--
-- Name: remedials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('remedials_id_seq', 7, true);


--
-- Data for Name: reports_bypasses; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY reports_bypasses (id, nombre, report_file_name, report_content_type, report_file_size, report_updated_at, created_at, updated_at) FROM stdin;
\.


--
-- Name: reports_bypasses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('reports_bypasses_id_seq', 1, false);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY roles (id, name, resource_id, resource_type, created_at, updated_at) FROM stdin;
1	super	\N	\N	2016-07-23 09:21:46.40233	2016-07-23 09:21:46.40233
2	sick	\N	\N	2015-12-02 17:44:02.20751	2015-12-02 17:44:02.20751
3	admin	\N	\N	2016-02-12 04:03:44.545936	2016-02-12 04:03:44.545936
4	super	\N	\N	2016-05-06 15:37:25.164399	2016-05-06 15:37:25.164399
5	administrador	\N	\N	2016-05-11 14:01:51.753177	2016-05-11 14:01:51.753177
6	general	\N	\N	2016-05-11 14:02:23.378418	2016-05-11 14:02:23.378418
7	recaudación	\N	\N	2016-05-11 14:04:18.278715	2016-05-11 14:04:18.278715
8	evaluación	\N	\N	2016-05-12 15:13:04.546273	2016-05-12 15:13:04.546273
9	daem	\N	\N	2016-06-10 06:57:03.734018	2016-06-10 06:57:03.734018
10	cobranza	\N	\N	2016-06-10 06:57:03.821808	2016-06-10 06:57:03.821808
11	director	\N	\N	2016-06-10 06:57:03.853266	2016-06-10 06:57:03.853266
12	profesor	\N	\N	2016-06-10 06:57:03.868495	2016-06-10 06:57:03.868495
13	utp	\N	\N	2016-06-10 06:57:03.885084	2016-06-10 06:57:03.885084
14	puterito	\N	\N	2016-07-25 05:49:30.706298	2016-07-25 05:49:30.706298
15	sick	\N	\N	2016-07-25 05:49:30.722605	2016-07-25 05:49:30.722605
16	admin	\N	\N	2016-07-25 05:49:30.727051	2016-07-25 05:49:30.727051
17	pruebas	\N	\N	2016-07-28 06:54:06.104797	2016-07-28 06:54:06.104797
18	retros	\N	\N	2016-07-28 07:18:27.023547	2016-07-28 07:18:27.023547
\.


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('roles_id_seq', 18, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY schema_migrations (version) FROM stdin;
20150609033631
20150609053839
20150609065719
20150609072400
20150609072951
20150609073927
20150609080947
20150609082831
20150615002341
20150619080737
20150619080937
20150619081932
20150619085630
20150619090006
20150619090055
20150619090617
20150619090813
20150619091107
20150619091641
20150619091906
20150619092652
20150619094445
20150619095711
20150620083150
20150620083732
20150704090004
20150705063928
20150705113917
20150706081245
20150706085121
20150706085453
20150706092234
20150706112201
20150706154928
20150707060046
20150707101537
20150707101643
20150720143748
20150720144224
20150720175408
20150720180550
20150720180610
20150725191934
20150804024917
20150928051352
20150928052104
20150928052204
20150928052423
20150928052601
20150928052632
20150928052739
20150928053152
20151006000040
20151006000434
20151007234030
20151022153144
20151022164452
20151022223109
20151023074229
20151030081629
20151106174834
20151106175048
20151106180649
20151106180901
20151108084953
20151108111905
20151108111956
20151108112147
20151108114722
20151109042616
20151109042828
20151126191015
20151202173429
20151202173548
20151219163014
20151219163731
20151224172343
20151226183108
20160207191959
20160207192320
20160207192410
20160209053554
20160211061857
20160212032735
20160212032812
20160325020258
20160328233829
20160328233902
20160328233926
20160329002000
20160329002328
20160330011741
20160330011921
20160330012004
20160403072501
20160403214104
20160411051057
20160411071015
20160420195606
20160420201632
20160420201633
20160420201634
20160420201635
20160420201636
20160506103113
20160506170829
20160508115137
20160509180113
20160520030919
20160520031904
20160520031927
20160608075413
20160610100124
20160610114741
20160627130602
20160804043203
20160804232007
20151106175023
20151106175434
20160804234125
20151219162306
\.


--
-- Data for Name: schools; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY schools (id, nombre, rut, direccion, email, telefono, info_contacto, created_at, updated_at, rbd, dependencia, commune_id) FROM stdin;
1215	Colegio test	77887788	Victor Manuel 2351	mail@bla.com	02943294	colegio s	2015-12-31 16:22:59.49136	2015-12-31 16:22:59.49136	123213	Particular No Subvencionado	7
1216	Grupo Escolar Sor Teresa de los Andes	69.073.400-1	\N	\N	\N	\N	2016-01-01 19:18:21.559062	2016-01-01 19:18:21.559062	2020-6	Municipal	67
1217	Colegio Santa Irene	70.933.700-9	\N	\N	\N	\N	2016-01-01 19:18:21.706806	2016-01-01 19:18:21.706806	9299-1	Municipal	304
1218	Escuela Basica y Especial N° 90 Amanecer	77.723.260-6	\N	\N	\N	\N	2016-01-01 19:18:21.754253	2016-01-01 19:18:21.754253	25188-7	Particular Subvencionado	345
1219	Colegio Nueva Esperanza	76.073.347-4	\N	\N	\N	\N	2016-01-01 19:18:21.80248	2016-01-01 19:18:21.80248	18220-6	Particular Subvencionado	199
1220	The Kingstown School	77.118.950-4	\N	\N	\N	\N	2016-01-01 19:19:32.303095	2016-01-01 19:19:32.303095	14703-6	Particular Subvencionado	51
1221	Colegio Jean Piaget	77.166.930-1	\N	\N	\N	\N	2016-01-01 19:19:32.358341	2016-01-01 19:19:32.358341	1980-1	Particular Subvencionado	82
1222	Colegio San Juan Bautista	65.074.607-4	\N	\N	\N	\N	2016-01-01 19:19:32.398647	2016-01-01 19:19:32.398647	763-3	Particular Subvencionado	40
1223	Colegio Poeta Oscar Castro Zuñiga	69.072.400-6	\N	\N	\N	\N	2016-01-01 19:19:32.44112	2016-01-01 19:19:32.44112	9610-5	Municipal	305
1224	Escuela Nueva Liquiñe	82.733.800-1	\N	\N	\N	\N	2016-01-01 19:19:32.486467	2016-01-01 19:19:32.486467	7115-3	Particular Subvencionado	239
1225	Colegio Alta Cumbre	77.922.820-7	\N	\N	\N	\N	2016-01-01 19:19:32.534551	2016-01-01 19:19:32.534551	16600-6	Particular Subvencionado	129
1226	Colegio Maria Inmaculada	65.044.582-1	\N	\N	\N	\N	2016-01-01 19:20:58.437064	2016-01-01 19:20:58.437064	4663-9	Particular Subvencionado	146
1227	Colegio Sagrada Familia	70.596.800-4	\N	\N	\N	\N	2016-01-01 19:20:58.482141	2016-01-01 19:20:58.482141	208-9	Particular Subvencionado	19
1228	Escuela Particular Nº23 Metodista	65.033.068-4	\N	\N	\N	\N	2016-01-01 19:20:58.563964	2016-01-01 19:20:58.563964	5010-5	Particular Subvencionado	147
1229	Colegio José Arrieta	76.381.930-2	\N	\N	\N	\N	2016-01-01 19:20:58.605296	2016-01-01 19:20:58.605296	9036-0	Particular Subvencionado	307
1230	Escuela Genaro Rios Campos	76.164.592-7	\N	\N	\N	\N	2016-01-01 19:20:58.639566	2016-01-01 19:20:58.639566	5019-9	Particular Subvencionado	147
1231	Colegio Rio Loa	77.380.130-4	\N	\N	\N	\N	2016-01-01 19:20:58.739562	2016-01-01 19:20:58.739562	12836-	Particular Subvencionado	16
1232	Colegio San Alfonso de El Boldo	76.161.995-0	\N	\N	\N	\N	2016-01-01 19:20:58.807468	2016-01-01 19:20:58.807468	16588-3	Particular Subvencionado	129
1233	Escuela Comandante Luis Bravo	69.253.400-5	\N	\N	\N	\N	2016-01-01 19:20:58.872622	2016-01-01 19:20:58.872622	8410-7	Municipal	281
1234	Bernadette College	79.719.780-7	\N	\N	\N	\N	2016-01-01 19:20:58.931373	2016-01-01 19:20:58.931373	9373-4	Particular Subvencionado	304
1235	Colegio Salvador Dali	76.068.489-9	\N	\N	\N	\N	2016-01-01 19:20:59.007103	2016-01-01 19:20:59.007103	25279-4	Particular Subvencionado	313
1236	Escuela Particular Nº20 San Luis	76.164.147-6	\N	\N	\N	\N	2016-01-01 19:20:59.056455	2016-01-01 19:20:59.056455	1597-0	Particular Subvencionado	45
1237	Colegio Parroquial Andacollo	70.422.200-9	\N	\N	\N	\N	2016-01-01 19:20:59.132807	2016-01-01 19:20:59.132807	664-5	Particular Subvencionado	32
1238	Instituto Einstein	70.019.790-5	\N	\N	\N	\N	2016-01-01 19:20:59.239973	2016-01-01 19:20:59.239973	2182-2	Particular Subvencionado	83
1239	Escuela Santa Beatriz	78.925.670-5	\N	\N	\N	\N	2016-01-01 19:20:59.322499	2016-01-01 19:20:59.322499	10167-2	Particular Subvencionado	318
1240	Colegio Manuel José Irarrazaval	82.411.500-1	\N	\N	\N	\N	2016-01-01 19:20:59.364722	2016-01-01 19:20:59.364722	8676-2	Particular Subvencionado	295
1241	Colegio Villa Jesus	79.896.130-6	\N	\N	\N	\N	2016-01-01 19:20:59.44214	2016-01-01 19:20:59.44214	9859-0	Particular Subvencionado	303
1242	Escuela Eulogio Goycolea Garay	69.220.601-0	\N	\N	\N	\N	2016-01-01 19:20:59.491355	2016-01-01 19:20:59.491355	7773-9	Municipal	245
1243	Escuela Particular Nº50 El Bosque	86.750.000-6	\N	\N	\N	\N	2016-01-01 19:20:59.574075	2016-01-01 19:20:59.574075	10629-	Particular Subvencionado	299
1244	Escuela Victor Nicoletti Tamanini	69.081.200-2	\N	\N	\N	\N	2016-01-01 19:20:59.632623	2016-01-01 19:20:59.632623	2302-7	Municipal	97
1245	Colegio San José de Renca	82.411.500-1	\N	\N	\N	\N	2016-01-01 19:20:59.697616	2016-01-01 19:20:59.697616	24812-6	Particular Subvencionado	322
1246	The Antofagasta Baptist College	76.040.730-5	\N	\N	\N	\N	2016-01-01 19:20:59.756208	2016-01-01 19:20:59.756208	12963-1	Particular Subvencionado	12
1247	Colegio Poeta Daniel de la Vega	96.933.590-5	\N	\N	\N	\N	2016-01-01 19:20:59.831714	2016-01-01 19:20:59.831714	14599-8	Particular Subvencionado	79
1248	Escuela Básica Sanitas	69.072.400-6	\N	\N	\N	\N	2016-01-01 19:20:59.881707	2016-01-01 19:20:59.881707	9609-1	Municipal	305
1249	Instituto Santa Marta	65.456.730-1	\N	\N	\N	\N	2016-01-01 19:20:59.931923	2016-01-01 19:20:59.931923	16448-8	Particular Subvencionado	129
1250	Escuela Padre Alberto Hurtado	70.931.900-0	\N	\N	\N	\N	2016-01-01 19:21:00.007321	2016-01-01 19:21:00.007321	24318-3	Municipal	284
1251	Escuela Particular Nº49 Belen	76.160.187-3	\N	\N	\N	\N	2016-01-01 19:21:00.074053	2016-01-01 19:21:00.074053	6647-8	Particular Subvencionado	210
1252	Colegio Integrado de Talca	65.053.120-5	\N	\N	\N	\N	2016-01-01 19:21:00.115403	2016-01-01 19:21:00.115403	2992-	Particular Subvencionado	116
1253	Colegio Católico Beato Federico Ozanam	82.411.500-1	\N	\N	\N	\N	2016-01-01 19:21:00.170208	2016-01-01 19:21:00.170208	22192-9	Particular Subvencionado	244
1254	Colegio Metodista Lagunillas	65.033.068-4	\N	\N	\N	\N	2016-01-01 19:21:00.232397	2016-01-01 19:21:00.232397	11420-0	Particular Subvencionado	147
1255	Colegio Miguel de Unamuno	79.548.230-K	\N	\N	\N	\N	2016-01-01 19:21:00.282564	2016-01-01 19:21:00.282564	1620-9	Particular Subvencionado	45
1256	Colegio San Vicente de Paul	82.411.500-1	\N	\N	\N	\N	2016-01-01 19:21:00.331468	2016-01-01 19:21:00.331468	22234-8	Particular Subvencionado	264
1257	Escuela Básica Santa Catalina de San Miguel	77.104.460-3	\N	\N	\N	\N	2016-01-01 19:21:00.391186	2016-01-01 19:21:00.391186	9539-7	Particular Subvencionado	324
1258	Colegio Santa Sofia	76.046.223-3	\N	\N	\N	\N	2016-01-01 19:21:00.44048	2016-01-01 19:21:00.44048	9165-	Particular Subvencionado	316
1259	Escuela E-765 Colico Sur	69.160.201-k	\N	\N	\N	\N	2016-01-01 19:21:00.533101	2016-01-01 19:21:00.533101	5087-3	Municipal	162
1260	Escuela Rural Epson	96.293.000-k	\N	\N	\N	\N	2016-01-01 19:21:00.573669	2016-01-01 19:21:00.573669	7740-2	Municipal	252
1261	Escuela Rural Artistica Alumno Marcelo Guenteo	71.173.100-8	\N	\N	\N	\N	2016-01-01 19:21:00.615473	2016-01-01 19:21:00.615473	8289-9	Municipal	260
1262	Colegio Los Angeles	87.797.700-5	\N	\N	\N	\N	2016-01-01 19:21:00.656817	2016-01-01 19:21:00.656817	4266-8	Particular Subvencionado	165
1263	Liceo Los Condores	76.165.389-k	\N	\N	\N	\N	2016-01-01 19:21:00.709793	2016-01-01 19:21:00.709793	12603-9	Particular Subvencionado	6
1264	Liceo Experimental UMAG	65.471.020-1	\N	\N	\N	\N	2016-01-01 19:21:00.757062	2016-01-01 19:21:00.757062	24327-2	Particular Subvencionado	284
1265	Escuela Villa Las Playas	69-030.300-0	\N	\N	\N	\N	2016-01-01 19:21:00.815561	2016-01-01 19:21:00.815561	13177-6	Municipal	22
1266	Colegio Sagrado Corazon de Jesus	71.637.200-6	\N	\N	\N	\N	2016-01-01 19:21:00.865173	2016-01-01 19:21:00.865173	1599-7	Particular Subvencionado	45
1267	Colegio Irma de Salas Selva	76.004.740-6	\N	\N	\N	\N	2016-01-01 19:21:00.909011	2016-01-01 19:21:00.909011	13542-9	Particular Subvencionado	43
1268	Colegio Particular BET-EL	78.294.790-7	\N	\N	\N	\N	2016-01-01 19:21:00.986481	2016-01-01 19:21:00.986481	12837-6	Particular Subvencionado	12
1269	Escuela General Sofanor Parra Hermosilla	69.140.501-k	\N	\N	\N	\N	2016-01-01 19:21:01.083989	2016-01-01 19:21:01.083989	3745-1	Municipal	194
1270	Colegio Alma Mater	78.486.220-8	\N	\N	\N	\N	2016-01-01 19:21:01.125006	2016-01-01 19:21:01.125006	15579-9	Particular Subvencionado	97
1271	Mary Anne School	79.884.690-6	\N	\N	\N	\N	2016-01-01 19:21:01.174178	2016-01-01 19:21:01.174178	25593-9	Particular Subvencionado	319
1272	Instituto Parral	89.336.100-6	\N	\N	\N	\N	2016-01-01 19:21:01.224317	2016-01-01 19:21:01.224317	3430-4	Particular Subvencionado	141
1273	Escuela Particular Cuyimpalihue	76.126.968-2	\N	\N	\N	\N	2016-01-01 19:21:01.283843	2016-01-01 19:21:01.283843	17763-6	Particular Subvencionado	160
1274	Colegio Lucila Godoy	3.779.202-0	\N	\N	\N	\N	2016-01-01 19:21:01.383095	2016-01-01 19:21:01.383095	9490-0	Particular Subvencionado	324
1275	Colegio San Marcos	77.439.910-0	\N	\N	\N	\N	2016-01-01 19:21:01.466587	2016-01-01 19:21:01.466587	16535-2	Particular Subvencionado	129
1276	C.E.P.Maria Reina Inmaculada	73.116.300-6	\N	\N	\N	\N	2016-01-01 19:21:01.507408	2016-01-01 19:21:01.507408	10734-4	Particular Subvencionado	344
1277	Colegio Mirador del Lago	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:01.573721	2016-01-01 19:21:01.573721		Municipal	252
1278	Colegio Nueva Braunau	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:01.620426	2016-01-01 19:21:01.620426		Municipal	252
1279	Colegio Rosita Novaro	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:01.665944	2016-01-01 19:21:01.665944		Municipal	252
1280	Escuela Grupo Escolar	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:01.735942	2016-01-01 19:21:01.735942		Municipal	252
1281	Escuela Rio sur	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:01.790828	2016-01-01 19:21:01.790828		Municipal	252
1282	Escuela Rural Cristo Rey	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:01.845015	2016-01-01 19:21:01.845015		Municipal	252
1283	Escuela Rural Ella Minte	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:01.894244	2016-01-01 19:21:01.894244		Municipal	252
1284	Escuela Rural Epson	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:01.941044	2016-01-01 19:21:01.941044		Municipal	252
1285	Escuela Rural Hardy Minte	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:01.999732	2016-01-01 19:21:01.999732		Municipal	252
1286	Escuela Rural Janequeo	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:02.048988	2016-01-01 19:21:02.048988		Municipal	252
1287	Escuela Rural Jose Werner	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:02.130351	2016-01-01 19:21:02.130351		Municipal	252
1288	Escuela rural La Peninsula	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:02.194387	2016-01-01 19:21:02.194387		Municipal	252
1289	Escuela Rural Las Camelias	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:02.253671	2016-01-01 19:21:02.253671		Municipal	252
1290	Escuela Rural Reinaldo Raddatz	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:02.297785	2016-01-01 19:21:02.297785		Municipal	252
1291	Escuela Rural Ricardo Roth	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:02.340609	2016-01-01 19:21:02.340609		Municipal	252
1292	Escuela Rural Rodolfo Luckheide	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:02.391084	2016-01-01 19:21:02.391084		Municipal	252
1293	Escuela Rural Tres Puentes	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:02.44578	2016-01-01 19:21:02.44578		Municipal	252
1294	Escuela Santa Maria	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:02.483869	2016-01-01 19:21:02.483869		Municipal	252
1295	Liceo Pedro Aguirre Cerda	69.220.200-7	\N	\N	\N	\N	2016-01-01 19:21:02.534665	2016-01-01 19:21:02.534665		Municipal	252
1296	Escuela Patagonia	70.931.900-0	\N	\N	\N	\N	2016-01-01 19:21:02.585291	2016-01-01 19:21:02.585291	8444-1	Municipal	284
1297	Colegio San José	76.138.651-4	\N	\N	\N	\N	2016-01-01 19:21:02.634371	2016-01-01 19:21:02.634371	4677-9	Particular Subvencionado	153
1298	Corona School	76.171.677-8	\N	\N	\N	\N	2016-01-01 19:21:02.71742	2016-01-01 19:21:02.71742	12604-7	Particular Subvencionado	5
1299	Centro Educacional Adonay	76.036.018-k	\N	\N	\N	\N	2016-01-01 19:21:02.799132	2016-01-01 19:21:02.799132	16513-1	Particular Subvencionado	129
1300	Harvest Christian School	76.092.002-9	\N	\N	\N	\N	2016-01-01 19:21:02.849201	2016-01-01 19:21:02.849201	12977-1	Particular Subvencionado	12
1301	Colegio Purisimo Corazón de Maria	65.026.321-9	\N	\N	\N	\N	2016-01-01 19:21:02.901051	2016-01-01 19:21:02.901051	7942-1	Particular Subvencionado	247
1302	Escuela Particular Anny School	76.204.304-1	\N	\N	\N	\N	2016-01-01 19:21:02.982581	2016-01-01 19:21:02.982581	14848-	Particular Subvencionado	45
1303	Colegio Patricio Lynch	71.142.500.-4	\N	\N	\N	\N	2016-01-01 19:21:03.033384	2016-01-01 19:21:03.033384	14541-6	Particular Subvencionado	45
1304	Liceo Particular Alberto Magno	87.990.900-7	\N	\N	\N	\N	2016-01-01 19:21:03.084283	2016-01-01 19:21:03.084283	11792-7	Particular Subvencionado	304
1305	Escuela Francia	69.200.600-3	\N	\N	\N	\N	2016-01-01 19:21:03.150067	2016-01-01 19:21:03.150067	6930-2	Municipal	235
1306	Escuela Los Conquistadores	69.150.501-4	\N	\N	\N	\N	2016-01-01 19:21:03.193455	2016-01-01 19:21:03.193455	18014-	Municipal	152
1308	Colegio Domus Mater	96.865.080-7	\N	\N	\N	\N	2016-01-01 19:21:03.570363	2016-01-01 19:21:03.570363	22231-3	Particular Subvencionado	232
1309	Colegio Palencia SC	96.860.610-7	\N	\N	\N	\N	2016-01-01 19:21:03.626879	2016-01-01 19:21:03.626879	16549-2	Particular Subvencionado	129
1310	Escuela Particular Laura Elgueta	76.163.249-2	\N	\N	\N	\N	2016-01-01 19:21:03.767584	2016-01-01 19:21:03.767584	9342-4	Particular Subvencionado	304
1311	Escuela Alegria Catán Dabiké	60.922.125-9	\N	\N	\N	\N	2016-01-01 19:21:03.819602	2016-01-01 19:21:03.819602	1313-7	Municipal	77
1312	Liceo Nobelius	96.547.110-3	\N	\N	\N	\N	2016-01-01 19:21:03.866697	2016-01-01 19:21:03.866697	24303-5	Particular Subvencionado	284
1313	Colegio Centro Educacional Santa Mónica	88.230.400-0	\N	\N	\N	\N	2016-01-01 19:21:03.918124	2016-01-01 19:21:03.918124	9536-2	Particular Subvencionado	323
1314	Liceo Carlos Ibañez del Campo	69.220.401-8	\N	\N	\N	\N	2016-01-01 19:21:03.969189	2016-01-01 19:21:03.969189	7941-	Municipal	247
1315	Escuela Particular Los Confines	76.163.854-8	\N	\N	\N	\N	2016-01-01 19:21:04.016611	2016-01-01 19:21:04.016611	11746-3	Particular Subvencionado	162
1316	Colegio William Booth	70.023.000-7	\N	\N	\N	\N	2016-01-01 19:21:04.066606	2016-01-01 19:21:04.066606	7403-9	Particular Subvencionado	263
1317	Escuela Mexico	69.200.100-1	\N	\N	\N	\N	2016-01-01 19:21:04.123508	2016-01-01 19:21:04.123508	6762-8	Municipal	232
1318	Colegio San Carlos		\N	\N	\N	\N	2016-01-01 19:21:04.17431	2016-01-01 19:21:04.17431	14376-6	Particular Subvencionado	57
1319	Instituto Alemán	Gratis	\N	\N	\N	\N	2016-01-01 19:21:04.232732	2016-01-01 19:21:04.232732	8000-4	Particular No Subvencionado	248
1320	Green Country School	Gratis	\N	\N	\N	\N	2016-01-01 19:21:04.333293	2016-01-01 19:21:04.333293	22265-8	Particular Subvencionado	263
1321	Escuela Basica Ribera Sur	69.240.100-k	\N	\N	\N	\N	2016-01-01 19:21:04.38598	2016-01-01 19:21:04.38598	11612-	Municipal	\N
1322	The Internacional School Arica	76.862.940-4	\N	\N	\N	\N	2016-01-01 19:21:04.432767	2016-01-01 19:21:04.432767	30001-2	Particular Subvencionado	1
1323	Colegio Santa Ana	77.329.020-2	\N	\N	\N	\N	2016-01-01 19:21:04.474506	2016-01-01 19:21:04.474506	22260-7	Particular Subvencionado	261
1324	Escuela Jaime Eyzaguirre	70.868.000-1	\N	\N	\N	\N	2016-01-01 19:21:04.508691	2016-01-01 19:21:04.508691	10363-2	Particular Subvencionado	321
1325	Colegio San Lucas	77.759.110-K	\N	\N	\N	\N	2016-01-01 19:21:04.557714	2016-01-01 19:21:04.557714	13426-0	Particular Subvencionado	30
1326	Liceo San Francisco	81.825.100-9	\N	\N	\N	\N	2016-01-01 19:21:04.650242	2016-01-01 19:21:04.650242	479-0	Particular Subvencionado	26
1327	Colegio Alberto Blest Gana	76.160.133-4	\N	\N	\N	\N	2016-01-01 19:21:04.733585	2016-01-01 19:21:04.733585	11715-3	Particular Subvencionado	153
1328	Colegio Precursor Francisco de Miranda	52.003.741-1	\N	\N	\N	\N	2016-01-01 19:21:04.787722	2016-01-01 19:21:04.787722	14770-2	Particular Subvencionado	62
1329	Liceo Catolico Atacama	70.686.800-3	\N	\N	\N	\N	2016-01-01 19:21:04.884232	2016-01-01 19:21:04.884232	429-4	Particular Subvencionado	21
1330	Colegio Cristiano Belen	65.040.636-2	\N	\N	\N	\N	2016-01-01 19:21:04.958083	2016-01-01 19:21:04.958083	22588-6	Particular Subvencionado	232
1331	Colegio Las Americas	77.794.300-6	\N	\N	\N	\N	2016-01-01 19:21:05.024258	2016-01-01 19:21:05.024258	14717-6	Particular Subvencionado	79
1332	Colegio Santa Juana de Arco	70.746.500-k	\N	\N	\N	\N	2016-01-01 19:21:05.072195	2016-01-01 19:21:05.072195	1290-4	Particular Subvencionado	73
1333	Colegio Ecológico Montessori	77.387.480-8	\N	\N	\N	\N	2016-01-01 19:21:05.120401	2016-01-01 19:21:05.120401	12838-4	Particular Subvencionado	16
1334	Colegio Guardiamarina Ernesto Riquelme	70.933.700-9	\N	\N	\N	\N	2016-01-01 19:21:05.184747	2016-01-01 19:21:05.184747	9282-7	Municipal	304
1335	Saint Charles College	96.706.700-8	\N	\N	\N	\N	2016-01-01 19:21:05.267022	2016-01-01 19:21:05.267022	25382-0	Particular Subvencionado	304
1336	Colegio Marie Poussepin	70.429.200-7	\N	\N	\N	\N	2016-01-01 19:21:05.32518	2016-01-01 19:21:05.32518	1316-1	Particular Subvencionado	77
1337	Escuela Pedro Viveros Ormeño	69.073.400-1	\N	\N	\N	\N	2016-01-01 19:21:05.425176	2016-01-01 19:21:05.425176	2024-9	Municipal	67
1338	Colegio Divino Maestro	69.091.201-5	\N	\N	\N	\N	2016-01-01 19:21:05.500069	2016-01-01 19:21:05.500069	15770-8	Municipal	100
1339	Colegio Santiago Emprendedores	76.036.481-9	\N	\N	\N	\N	2016-01-01 19:21:05.565514	2016-01-01 19:21:05.565514	26454-7	Particular Subvencionado	333
1340	Escuela Arturo Prat Chacón	69.020.100-3	\N	\N	\N	\N	2016-01-01 19:21:05.720477	2016-01-01 19:21:05.720477	205-	Municipal	19
1341	Escuela Basica Arturo Prat	70.014.330-7	\N	\N	\N	\N	2016-01-01 19:21:05.775972	2016-01-01 19:21:05.775972	14330-8	Particular Subvencionado	45
1342	Escuela Millaray	69.190.700-7	\N	\N	\N	\N	2016-01-01 19:21:05.835947	2016-01-01 19:21:05.835947	5589-1	Municipal	200
1343	Escuela Victor Domingo Silva	69.240.300-2	\N	\N	\N	\N	2016-01-01 19:21:05.943492	2016-01-01 19:21:05.943492	8346-1	Municipal	\N
1344	Liceo República Argentina	69.240.300-2	\N	\N	\N	\N	2016-01-01 19:21:05.995735	2016-01-01 19:21:05.995735	8352-6	Municipal	\N
1345	Escuela Nieves del Sur	69.240.300-2	\N	\N	\N	\N	2016-01-01 19:21:06.092298	2016-01-01 19:21:06.092298	8353-4	Municipal	\N
1346	Escuela Basica La Union	76.046.979-3	\N	\N	\N	\N	2016-01-01 19:21:06.139033	2016-01-01 19:21:06.139033	24424-4	Particular Subvencionado	318
1347	Escuela Aurelio Durán	69.050.400-6	\N	\N	\N	\N	2016-01-01 19:21:06.218656	2016-01-01 19:21:06.218656		Municipal	61
1348	Escuela Mercedes Maturana	69.050.400-6	\N	\N	\N	\N	2016-01-01 19:21:06.26709	2016-01-01 19:21:06.26709		Municipal	61
1349	Escuela Balneario de Cachagua	69.050.400-6	\N	\N	\N	\N	2016-01-01 19:21:06.323928	2016-01-01 19:21:06.323928		Municipal	61
1350	Liceo Zapallar	69.050.400-6	\N	\N	\N	\N	2016-01-01 19:21:06.376237	2016-01-01 19:21:06.376237		Municipal	61
1351	Colegio Estela Segura	76.079.573-9	\N	\N	\N	\N	2016-01-01 19:21:06.434368	2016-01-01 19:21:06.434368	10479-5	Particular Subvencionado	327
1352	Daem Chepica	69.090.700-3	\N	\N	\N	\N	2016-01-01 19:21:06.509526	2016-01-01 19:21:06.509526		Municipal	107
1354	RERERERE	2312313	2025 NW 102 AVE #108	correo@prueba.com	7865365575		2016-05-11 21:14:05.38576	2016-05-11 21:14:05.38576	12345	Municipal	25
1361	Colegio cuentas dinamicas	76037806-2	Direccion de prueba	ad@ad.com	213213213	Comentando	2016-08-06 13:29:15.167316	2016-08-06 13:29:15.167316	TEST	Particular Subvencionado	28
1362	Colegio cuentas dinamicas	76037806-2	sadsadsadsa	ad@ad.com	213213213	Comentando	2016-08-06 23:09:02.529031	2016-08-06 23:09:02.529031	TEST	Municipal	11
1363	Colegio 2	21321321332	Direccion de prueba	nuevo@formulario.cl	998877889	Comentando	2016-08-06 23:10:49.390571	2016-08-06 23:10:49.390571	TEST2	Particular Subvencionado	25
1364	Colegiodinami	76037806-2	Direccion de prueba	nuev2o@formulario.cl	213213213	Comentando	2016-08-06 23:39:50.20211	2016-08-06 23:39:50.20211	DE	Municipal	27
1365	Colegio Coyhaique	21321321332	Direccion de prueba	ad23@ad.com	232323	Comentarios	2016-08-07 05:19:05.097336	2016-08-07 05:19:05.097336	21321321321	Particular Subvencionado	277
1307	American College	76.758.030-4	Direccion de prueba	ad@ad.com	213213213	Comentando	2016-01-01 19:21:03.246695	2016-08-07 06:42:21.145455	14211-5	Municipal	54
1366	Colegio RBD std	76037806-2	sadsadsadsa	rebelde@rbd.com	2312321321	Colegio sickero	2016-08-07 06:58:54.95082	2016-08-07 06:59:13.76115	REBELDE	Municipal	16
1368	Escuelita irreal	77575757	ND	evalua@evalua.com	213213213	\N	2016-08-09 00:10:32.20827	2016-08-09 00:10:32.20827	rbd1234	Particular	97
1369	Escuela Particular Nº50 El Bosque	86.750.000-6	ND	e.bosque@ctcinternet.cl; vesp21@hotmail.com	225292558	\N	2016-08-09 00:14:36.257703	2016-08-09 00:14:36.257703	10629	Particular Subvencionado	302
\.


--
-- Name: schools_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('schools_id_seq', 1369, true);


--
-- Data for Name: status_types; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY status_types (id, nombre, descripcion, created_at, updated_at) FROM stdin;
1	Estado creado	\N	2015-12-02 17:58:50.606029	2015-12-02 17:58:50.606029
2	estado 2	\N	2015-12-02 21:11:38.986911	2015-12-02 21:11:38.986911
3	estado 3	\N	2015-12-02 21:11:42.450688	2015-12-02 21:11:42.450688
4	estado 4	\N	2015-12-02 21:11:45.306638	2015-12-02 21:11:45.306638
5	estado 5	\N	2015-12-02 21:11:47.810793	2015-12-02 21:11:47.810793
\.


--
-- Name: status_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('status_types_id_seq', 5, true);


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY students (id, nombre, apellido, rut, created_at, updated_at) FROM stdin;
73	LUIS IGNACIO	MUÑOZ HUERTA	22.500.531-1	2016-03-14 05:19:09.920245	2016-03-14 05:37:55.637973
75	SOLEDAD BELÉN	NORDETTI CARRASCO	22.693.303-4	2016-03-14 05:19:09.936974	2016-03-14 05:38:06.894743
88	SILVA ROA	MATÍAS ALEXIIS	22.711.914-4	2016-03-14 05:19:10.070221	2016-03-14 05:38:15.05982
61	BASTÍAS SANCHEZ	DAMARIS CAROLINA	22.720.414-1	2016-03-14 05:19:09.811795	2016-03-14 05:38:21.879198
64	FUENTES MORALES	NICOLÁS ANTONIO	22.724.181-0	2016-03-14 05:19:09.836774	2016-03-14 05:38:30.518065
86	SANDOVAL LLANQUINAO	 HÉCTOR SEBASTIAN	22.726.953-7	2016-03-14 05:19:10.047139	2016-03-14 05:38:41.319195
94	YAÑEZ SANCHEZ	ALONSO ESTEBAN	22.729.734-4	2016-03-14 05:19:10.12224	2016-03-14 05:38:52.020807
80	PÉREZ CARVAJAL	LUIS ANDREE	22.743.124-5	2016-03-14 05:19:09.987482	2016-03-14 05:39:01.45624
85	CRISTOBAL ANDRÉS	SAGAL MACÍAS 	22.749.796-3	2016-03-14 05:19:10.036977	2016-03-14 05:39:10.970671
68	MAXIMILIANO ANDRÉS	JAÑA CONTRERAS	22.760.093-4	2016-03-14 05:19:09.878537	2016-03-14 05:39:20.967271
82	CONSTANZA AURORA	REYES ROSAS	22.768.475-5	2016-03-14 05:19:10.005793	2016-03-14 05:39:28.915434
62	FRANCO ANTONIO	CABRERA ROJAS 	22.771.416-6	2016-03-14 05:19:09.820133	2016-03-14 05:39:34.495723
77	SCARLET ANTONELLA	OYARZÚN SÁEZ 	22.772.326-2	2016-03-14 05:19:09.9626	2016-03-14 05:39:38.728502
60	SOFÍA ALEJANDRA	AGUILAR ORELLANA 	22.775.736-1	2016-03-14 05:19:09.797602	2016-03-14 05:39:43.07478
79	JOAQUÍN ESTEBAN	PERALTA BUSTAMANTE	22.776.244-6	2016-03-14 05:19:09.978769	2016-03-14 05:39:51.427057
90	CHRISNA FERNANDA	VARGAS RETAMALES 	22.777.164-K	2016-03-14 05:19:10.08716	2016-03-14 05:39:56.541541
93	CAROLINA ANDREA	VILLEGAS AÑASCO 	22.787.832-0	2016-03-14 05:19:10.112035	2016-03-14 05:40:01.527688
91	AGUSTÍN EDUARDO	VARGAS VÁSQUEZ 	22.795.150-8	2016-03-14 05:19:10.095529	2016-03-14 05:40:05.511439
76	VICTOR ALONSO	OLGUÍN TORO 	22.796.497-9	2016-03-14 05:19:09.946697	2016-03-14 05:40:11.138868
72	ALONSO ESTEFAN	MIRANDA LÓPEZ 	22.805.874-2	2016-03-14 05:19:09.912113	2016-03-14 05:40:15.675883
59	PASCAL FLORENCIA	ADASME FIGUEROA 	22.808.233-3	2016-03-14 05:19:09.767789	2016-03-14 05:40:19.960434
84	TOMÁS AGUSTÍN	ROCO MADARIAGA 	22.822.934-2	2016-03-14 05:19:10.028759	2016-03-14 05:40:24.085747
65	MARÍA PAZ	GARCÍA VICENCIO 	22.825.635-8	2016-03-14 05:19:09.845154	2016-03-14 05:40:28.323064
63	KEVIN BRAYAN	CARREÑO CÓRDOVA 	22.834.805-8	2016-03-14 05:19:09.828657	2016-03-14 05:40:32.124798
83	DANIEL IGNACIO	RIQUELME DÍAZ	22.844.705-6	2016-03-14 05:19:10.020145	2016-03-14 05:40:37.394762
74	MARTINA MARGARITA	MUÑOZ MENA 	22.866.217-8	2016-03-14 05:19:09.928745	2016-03-14 05:40:44.488494
87	MARTINA ISIDORA	SANTIBAÑEZ BARRIENTOS	22.876.816-2	2016-03-14 05:19:10.061931	2016-03-14 05:40:52.21383
69	VICTOR MANUEL IGNACIO	LECAROS RAMOS	22.910.578-7	2016-03-14 05:19:09.887075	2016-03-14 05:40:58.070498
89	AGUSTÍN IGNACIO	TORO FUENTES 	22.937.275-0	2016-03-14 05:19:10.080357	2016-03-14 05:41:02.216446
78	YANIS PRISCILA MILLARAY	PEÑA BAEZA	22.944.473-5	2016-03-14 05:19:09.970783	2016-03-14 05:41:09.219814
67	MATIAS IGNACIO	GUZMAN SILVA 	22.946.901-0	2016-03-14 05:19:09.870169	2016-03-14 05:41:13.323242
70	ORNELLA CATALINA	MATUS ORELLANA	22.957.927-4	2016-03-14 05:19:09.895173	2016-03-14 05:41:18.013635
71	AZHLEY ESTEFANÍA	MAULÉN MUÑOZ 	22.962.063-0	2016-03-14 05:19:09.903687	2016-03-14 05:41:21.868964
81	CATALINA ALEJANDRA	PÉREZ VILLANUEVA 	22.976.110-2	2016-03-14 05:19:09.995265	2016-03-14 05:41:26.87242
66	AGUSTIN ALONSO	GUTIERREZ MUÑOZ 	23.000.981-3	2016-03-14 05:19:09.855277	2016-03-14 05:41:30.917634
92	ANALÍA FRANCISCA AMARILIS	VELÁSQUEZ OLIVARES 	23.001.207-5	2016-03-14 05:19:10.10374	2016-03-14 05:41:36.366382
95	Alumno	de prueba 1	112233	2016-04-14 05:03:33.46726	2016-04-14 05:03:33.46726
96	Estudiante	alumno prueba2	233213	2016-04-14 05:03:33.534141	2016-04-14 05:03:33.534141
97	Alumno 1	Apellido 1	231321	2016-05-02 05:16:33.77535	2016-05-02 05:16:33.77535
98	Alumno 2	Apellido 2	42144	2016-05-02 05:16:33.831967	2016-05-02 05:16:33.831967
99	Alumno 3	Apellido 3	24242	2016-05-02 05:16:33.845883	2016-05-02 05:16:33.845883
100	Alumno 4	Apellido 4	2143	2016-05-02 05:16:33.854347	2016-05-02 05:16:33.854347
101	Alumno 5	Apellido 5	44423	2016-05-02 05:16:33.871425	2016-05-02 05:16:33.871425
102	Alumno 6	Apellido 6	4214	2016-05-02 05:16:33.889285	2016-05-02 05:16:33.889285
103	Alumno 7	Apellido 7	124241	2016-05-02 05:16:33.90458	2016-05-02 05:16:33.90458
104	Alumno 8	Apellido 8	3123	2016-05-02 05:16:33.912916	2016-05-02 05:16:33.912916
105	saddsa	asdasd	2131	2016-05-05 22:27:55.103248	2016-05-05 22:27:55.103248
106	asddas	asd	22	2016-05-05 22:27:55.149218	2016-05-05 22:27:55.149218
107	asddas	asddas	323	2016-05-05 22:27:55.165382	2016-05-05 22:27:55.165382
108	sdasad	asdasd	232	2016-05-05 22:27:55.173715	2016-05-05 22:27:55.173715
109	GENESIS FRANCISCA	ARIAS MALDONADO 	31	2016-05-07 21:06:59.789621	2016-05-07 21:06:59.789621
110	JEREMI ANTONIO	SEPULVEDA ROA	17	2016-05-07 21:06:59.845799	2016-05-07 21:06:59.845799
111	STIVEN NICOLAS	MONSALVES LUENGO  	7	2016-05-07 21:06:59.859763	2016-05-07 21:06:59.859763
112	GENESIS JASMIN	SAEZ ZAPATA 	29	2016-05-07 21:06:59.868579	2016-05-07 21:06:59.868579
113	CESAR SEBASTIAN	BALBOA MORALES 	23	2016-05-07 21:06:59.885472	2016-05-07 21:06:59.885472
114	SOFIA FERNANDA	SAEZ VALENZUELA 	13	2016-05-07 21:06:59.902029	2016-05-07 21:06:59.902029
115	AMARO JONATHAN	JORQUERA AGUILERA 	11	2016-05-07 21:06:59.918648	2016-05-07 21:06:59.918648
116	ALEXANDRA YAEL	LAGOS ALVARES 	21	2016-05-07 21:06:59.926745	2016-05-07 21:06:59.926745
117	NAYARET ANAIS	CASTRO SIERRA 	24	2016-05-07 21:06:59.937264	2016-05-07 21:06:59.937264
118	ANA BELEN	VADEBENITO MORALES 	2	2016-05-07 21:06:59.951976	2016-05-07 21:06:59.951976
119	IGNACIO MAXIMILIANO	RIVERA  JURE 	26	2016-05-07 21:06:59.968751	2016-05-07 21:06:59.968751
120	GERALDIE JASMIN S	MUÑOZ BARRIENTOS	6	2016-05-07 21:06:59.98575	2016-05-07 21:06:59.98575
121	VALENTINA ANDREA	REYES ZAPATA 	12	2016-05-07 21:06:59.995063	2016-05-07 21:06:59.995063
122	BRANDON FELIPE	ALVARES CARRILLO	22	2016-05-07 21:07:00.010369	2016-05-07 21:07:00.010369
123	DYLAN PAOLA	ARRIAGADA SAEZ 	28	2016-05-07 21:07:00.019053	2016-05-07 21:07:00.019053
124	KRISHNA CATALINA A	AVENDAÑO LOZANO 	18	2016-05-07 21:07:00.027226	2016-05-07 21:07:00.027226
125	SEBASTIAN ANDRES	GATICA OLIVERO	19	2016-05-07 21:07:00.035813	2016-05-07 21:07:00.035813
126	FERNANDA A	MONTECINOS VALDEBENITO 	5	2016-05-07 21:07:00.043684	2016-05-07 21:07:00.043684
127	SEBASTIAN IGNACIO	MUÑOZ SALGADO 	16	2016-05-07 21:07:00.052114	2016-05-07 21:07:00.052114
128	MARTIN NAHUEL	MORALES VALDEBENITO 	8	2016-05-07 21:07:00.060765	2016-05-07 21:07:00.060765
129	JOSUE ESTEBAN	VALENZUELA CEBALLOS 	15	2016-05-07 21:07:00.077032	2016-05-07 21:07:00.077032
131	ANGELA SARAY	CHAPARRO URRA 	4	2016-05-07 21:07:00.094163	2016-05-07 21:07:00.094163
132	CATALINA ALONDRA	CONTRERAS HERMOSILLA	14	2016-05-07 21:07:00.102221	2016-05-07 21:07:00.102221
133	BENJAMIN MARCELO	GAJARDO  NORA 	30	2016-05-07 21:07:00.110521	2016-05-07 21:07:00.110521
134	DAIRIS SIMONEY	PEREIRA  HUENUPI 	27	2016-05-07 21:07:00.11872	2016-05-07 21:07:00.11872
135	BRANDON MATHIAS	RODRIGUEZ RODRIGUEZ 	25	2016-05-07 21:07:00.127187	2016-05-07 21:07:00.127187
136	VICTORIA ANDREA	AZ0CAR HENRIQUEZ 	10	2016-05-07 21:07:00.135279	2016-05-07 21:07:00.135279
137	ANYELIN NOEMI	PEREZ NAVARRO 	3	2016-05-07 21:07:00.144079	2016-05-07 21:07:00.144079
138	MATEO BENJAMIN	GONZALEZ OLIVARES 	9	2016-05-07 21:07:00.152199	2016-05-07 21:07:00.152199
139	GENESIS FRANCISCA	ARIAS MALDONADO 	31	2016-05-07 21:07:32.648215	2016-05-07 21:07:32.648215
140	JEREMI ANTONIO	SEPULVEDA ROA	17	2016-05-07 21:07:32.778656	2016-05-07 21:07:32.778656
141	STIVEN NICOLAS	MONSALVES LUENGO  	7	2016-05-07 21:07:32.793742	2016-05-07 21:07:32.793742
142	GENESIS JASMIN	SAEZ ZAPATA 	29	2016-05-07 21:07:32.802138	2016-05-07 21:07:32.802138
143	CESAR SEBASTIAN	BALBOA MORALES 	23	2016-05-07 21:07:32.809895	2016-05-07 21:07:32.809895
144	SOFIA FERNANDA	SAEZ VALENZUELA 	13	2016-05-07 21:07:32.818701	2016-05-07 21:07:32.818701
145	AMARO JONATHAN	JORQUERA AGUILERA 	11	2016-05-07 21:07:32.834672	2016-05-07 21:07:32.834672
146	ALEXANDRA YAEL	LAGOS ALVARES 	21	2016-05-07 21:07:32.843613	2016-05-07 21:07:32.843613
147	NAYARET ANAIS	CASTRO SIERRA 	24	2016-05-07 21:07:32.8514	2016-05-07 21:07:32.8514
148	ANA BELEN	VADEBENITO MORALES 	2	2016-05-07 21:07:32.859536	2016-05-07 21:07:32.859536
149	IGNACIO MAXIMILIANO	RIVERA  JURE 	26	2016-05-07 21:07:32.867849	2016-05-07 21:07:32.867849
150	GERALDIE JASMIN S	MUÑOZ BARRIENTOS	6	2016-05-07 21:07:32.876441	2016-05-07 21:07:32.876441
151	VALENTINA ANDREA	REYES ZAPATA 	12	2016-05-07 21:07:32.884541	2016-05-07 21:07:32.884541
152	BRANDON FELIPE	ALVARES CARRILLO	22	2016-05-07 21:07:32.893174	2016-05-07 21:07:32.893174
153	DYLAN PAOLA	ARRIAGADA SAEZ 	28	2016-05-07 21:07:32.901087	2016-05-07 21:07:32.901087
154	KRISHNA CATALINA A	AVENDAÑO LOZANO 	18	2016-05-07 21:07:32.912518	2016-05-07 21:07:32.912518
155	SEBASTIAN ANDRES	GATICA OLIVERO	19	2016-05-07 21:07:32.927248	2016-05-07 21:07:32.927248
156	FERNANDA A	MONTECINOS VALDEBENITO 	5	2016-05-07 21:07:32.942963	2016-05-07 21:07:32.942963
157	SEBASTIAN IGNACIO	MUÑOZ SALGADO 	16	2016-05-07 21:07:32.951942	2016-05-07 21:07:32.951942
158	MARTIN NAHUEL	MORALES VALDEBENITO 	8	2016-05-07 21:07:32.960314	2016-05-07 21:07:32.960314
159	JOSUE ESTEBAN	VALENZUELA CEBALLOS 	15	2016-05-07 21:07:32.968372	2016-05-07 21:07:32.968372
161	ANGELA SARAY	CHAPARRO URRA 	4	2016-05-07 21:07:32.984666	2016-05-07 21:07:32.984666
162	CATALINA ALONDRA	CONTRERAS HERMOSILLA	14	2016-05-07 21:07:33.0017	2016-05-07 21:07:33.0017
163	BENJAMIN MARCELO	GAJARDO  NORA 	30	2016-05-07 21:07:33.009528	2016-05-07 21:07:33.009528
164	DAIRIS SIMONEY	PEREIRA  HUENUPI 	27	2016-05-07 21:07:33.017641	2016-05-07 21:07:33.017641
165	BRANDON MATHIAS	RODRIGUEZ RODRIGUEZ 	25	2016-05-07 21:07:33.026151	2016-05-07 21:07:33.026151
166	VICTORIA ANDREA	AZ0CAR HENRIQUEZ 	10	2016-05-07 21:07:33.034597	2016-05-07 21:07:33.034597
167	ANYELIN NOEMI	PEREZ NAVARRO 	3	2016-05-07 21:07:33.04278	2016-05-07 21:07:33.04278
168	MATEO BENJAMIN	GONZALEZ OLIVARES 	9	2016-05-07 21:07:33.051148	2016-05-07 21:07:33.051148
169	GENESIS FRANCISCA	ARIAS MALDONADO 	31	2016-05-07 21:09:49.055024	2016-05-07 21:09:49.055024
170	JEREMI ANTONIO	SEPULVEDA ROA	17	2016-05-07 21:09:49.07394	2016-05-07 21:09:49.07394
171	STIVEN NICOLAS	MONSALVES LUENGO  	7	2016-05-07 21:09:49.081833	2016-05-07 21:09:49.081833
172	GENESIS JASMIN	SAEZ ZAPATA 	29	2016-05-07 21:09:49.090404	2016-05-07 21:09:49.090404
173	CESAR SEBASTIAN	BALBOA MORALES 	23	2016-05-07 21:09:49.098994	2016-05-07 21:09:49.098994
174	SOFIA FERNANDA	SAEZ VALENZUELA 	13	2016-05-07 21:09:49.107101	2016-05-07 21:09:49.107101
175	AMARO JONATHAN	JORQUERA AGUILERA 	11	2016-05-07 21:09:49.115217	2016-05-07 21:09:49.115217
176	ALEXANDRA YAEL	LAGOS ALVARES 	21	2016-05-07 21:09:49.123612	2016-05-07 21:09:49.123612
177	NAYARET ANAIS	CASTRO SIERRA 	24	2016-05-07 21:09:49.131825	2016-05-07 21:09:49.131825
178	ANA BELEN	VADEBENITO MORALES 	2	2016-05-07 21:09:49.140196	2016-05-07 21:09:49.140196
179	IGNACIO MAXIMILIANO	RIVERA  JURE 	26	2016-05-07 21:09:49.150217	2016-05-07 21:09:49.150217
180	GERALDIE JASMIN S	MUÑOZ BARRIENTOS	6	2016-05-07 21:09:49.165041	2016-05-07 21:09:49.165041
181	VALENTINA ANDREA	REYES ZAPATA 	12	2016-05-07 21:09:49.173471	2016-05-07 21:09:49.173471
182	BRANDON FELIPE	ALVARES CARRILLO	22	2016-05-07 21:09:49.1819	2016-05-07 21:09:49.1819
183	DYLAN PAOLA	ARRIAGADA SAEZ 	28	2016-05-07 21:09:49.190374	2016-05-07 21:09:49.190374
184	KRISHNA CATALINA A	AVENDAÑO LOZANO 	18	2016-05-07 21:09:49.198557	2016-05-07 21:09:49.198557
185	SEBASTIAN ANDRES	GATICA OLIVERO	19	2016-05-07 21:09:49.206927	2016-05-07 21:09:49.206927
186	FERNANDA A	MONTECINOS VALDEBENITO 	5	2016-05-07 21:09:49.215698	2016-05-07 21:09:49.215698
187	SEBASTIAN IGNACIO	MUÑOZ SALGADO 	16	2016-05-07 21:09:49.223813	2016-05-07 21:09:49.223813
188	MARTIN NAHUEL	MORALES VALDEBENITO 	8	2016-05-07 21:09:49.232133	2016-05-07 21:09:49.232133
189	JOSUE ESTEBAN	VALENZUELA CEBALLOS 	15	2016-05-07 21:09:49.240922	2016-05-07 21:09:49.240922
191	ANGELA SARAY	CHAPARRO URRA 	4	2016-05-07 21:09:49.299637	2016-05-07 21:09:49.299637
192	CATALINA ALONDRA	CONTRERAS HERMOSILLA	14	2016-05-07 21:09:49.332381	2016-05-07 21:09:49.332381
193	BENJAMIN MARCELO	GAJARDO  NORA 	30	2016-05-07 21:09:49.348814	2016-05-07 21:09:49.348814
194	DAIRIS SIMONEY	PEREIRA  HUENUPI 	27	2016-05-07 21:09:49.359784	2016-05-07 21:09:49.359784
195	BRANDON MATHIAS	RODRIGUEZ RODRIGUEZ 	25	2016-05-07 21:09:49.374351	2016-05-07 21:09:49.374351
196	VICTORIA ANDREA	AZ0CAR HENRIQUEZ 	10	2016-05-07 21:09:49.390703	2016-05-07 21:09:49.390703
197	ANYELIN NOEMI	PEREZ NAVARRO 	3	2016-05-07 21:09:49.399529	2016-05-07 21:09:49.399529
198	MATEO BENJAMIN	GONZALEZ OLIVARES 	9	2016-05-07 21:09:49.416667	2016-05-07 21:09:49.416667
199	GENESIS FRANCISCA	ARIAS MALDONADO 	31	2016-05-07 21:10:04.930411	2016-05-07 21:10:04.930411
200	JEREMI ANTONIO	SEPULVEDA ROA	17	2016-05-07 21:10:04.948323	2016-05-07 21:10:04.948323
201	STIVEN NICOLAS	MONSALVES LUENGO  	7	2016-05-07 21:10:04.956394	2016-05-07 21:10:04.956394
202	GENESIS JASMIN	SAEZ ZAPATA 	29	2016-05-07 21:10:04.973322	2016-05-07 21:10:04.973322
203	CESAR SEBASTIAN	BALBOA MORALES 	23	2016-05-07 21:10:04.981449	2016-05-07 21:10:04.981449
204	SOFIA FERNANDA	SAEZ VALENZUELA 	13	2016-05-07 21:10:04.990249	2016-05-07 21:10:04.990249
205	AMARO JONATHAN	JORQUERA AGUILERA 	11	2016-05-07 21:10:04.998255	2016-05-07 21:10:04.998255
206	ALEXANDRA YAEL	LAGOS ALVARES 	21	2016-05-07 21:10:05.006505	2016-05-07 21:10:05.006505
207	NAYARET ANAIS	CASTRO SIERRA 	24	2016-05-07 21:10:05.014889	2016-05-07 21:10:05.014889
208	ANA BELEN	VADEBENITO MORALES 	2	2016-05-07 21:10:05.02428	2016-05-07 21:10:05.02428
209	IGNACIO MAXIMILIANO	RIVERA  JURE 	26	2016-05-07 21:10:05.039741	2016-05-07 21:10:05.039741
210	GERALDIE JASMIN S	MUÑOZ BARRIENTOS	6	2016-05-07 21:10:05.048286	2016-05-07 21:10:05.048286
211	VALENTINA ANDREA	REYES ZAPATA 	12	2016-05-07 21:10:05.058481	2016-05-07 21:10:05.058481
212	BRANDON FELIPE	ALVARES CARRILLO	22	2016-05-07 21:10:05.065339	2016-05-07 21:10:05.065339
213	DYLAN PAOLA	ARRIAGADA SAEZ 	28	2016-05-07 21:10:05.073416	2016-05-07 21:10:05.073416
214	KRISHNA CATALINA A	AVENDAÑO LOZANO 	18	2016-05-07 21:10:05.082879	2016-05-07 21:10:05.082879
215	SEBASTIAN ANDRES	GATICA OLIVERO	19	2016-05-07 21:10:05.089969	2016-05-07 21:10:05.089969
216	FERNANDA A	MONTECINOS VALDEBENITO 	5	2016-05-07 21:10:05.098253	2016-05-07 21:10:05.098253
217	SEBASTIAN IGNACIO	MUÑOZ SALGADO 	16	2016-05-07 21:10:05.107074	2016-05-07 21:10:05.107074
218	MARTIN NAHUEL	MORALES VALDEBENITO 	8	2016-05-07 21:10:05.117044	2016-05-07 21:10:05.117044
219	JOSUE ESTEBAN	VALENZUELA CEBALLOS 	15	2016-05-07 21:10:05.133654	2016-05-07 21:10:05.133654
221	ANGELA SARAY	CHAPARRO URRA 	4	2016-05-07 21:10:05.156938	2016-05-07 21:10:05.156938
222	CATALINA ALONDRA	CONTRERAS HERMOSILLA	14	2016-05-07 21:10:05.165281	2016-05-07 21:10:05.165281
223	BENJAMIN MARCELO	GAJARDO  NORA 	30	2016-05-07 21:10:05.173629	2016-05-07 21:10:05.173629
224	DAIRIS SIMONEY	PEREIRA  HUENUPI 	27	2016-05-07 21:10:05.181747	2016-05-07 21:10:05.181747
225	BRANDON MATHIAS	RODRIGUEZ RODRIGUEZ 	25	2016-05-07 21:10:05.190103	2016-05-07 21:10:05.190103
226	VICTORIA ANDREA	AZ0CAR HENRIQUEZ 	10	2016-05-07 21:10:05.198518	2016-05-07 21:10:05.198518
227	ANYELIN NOEMI	PEREZ NAVARRO 	3	2016-05-07 21:10:05.207217	2016-05-07 21:10:05.207217
228	MATEO BENJAMIN	GONZALEZ OLIVARES 	9	2016-05-07 21:10:05.21508	2016-05-07 21:10:05.21508
233	GENESIS FRANCISCA	ARIAS MALDONADO 	31	2016-05-07 22:24:00.675291	2016-05-07 22:24:00.675291
234	JEREMI ANTONIO	SEPULVEDA ROA	17	2016-05-07 22:24:00.698038	2016-05-07 22:24:00.698038
235	STIVEN NICOLAS	MONSALVES LUENGO  	7	2016-05-07 22:24:00.713703	2016-05-07 22:24:00.713703
236	GENESIS JASMIN	SAEZ ZAPATA 	29	2016-05-07 22:24:00.722303	2016-05-07 22:24:00.722303
237	CESAR SEBASTIAN	BALBOA MORALES 	23	2016-05-07 22:24:00.731569	2016-05-07 22:24:00.731569
238	SOFIA FERNANDA	SAEZ VALENZUELA 	13	2016-05-07 22:24:00.738985	2016-05-07 22:24:00.738985
239	AMARO JONATHAN	JORQUERA AGUILERA 	11	2016-05-07 22:24:00.74682	2016-05-07 22:24:00.74682
240	ALEXANDRA YAEL	LAGOS ALVARES 	21	2016-05-07 22:24:00.755387	2016-05-07 22:24:00.755387
241	NAYARET ANAIS	CASTRO SIERRA 	24	2016-05-07 22:24:00.764003	2016-05-07 22:24:00.764003
242	ANA BELEN	VADEBENITO MORALES 	2	2016-05-07 22:24:00.782606	2016-05-07 22:24:00.782606
243	IGNACIO MAXIMILIANO	RIVERA  JURE 	26	2016-05-07 22:24:00.798956	2016-05-07 22:24:00.798956
244	GERALDIE JASMIN S	MUÑOZ BARRIENTOS	6	2016-05-07 22:24:00.814022	2016-05-07 22:24:00.814022
245	VALENTINA ANDREA	REYES ZAPATA 	12	2016-05-07 22:24:00.822281	2016-05-07 22:24:00.822281
246	BRANDON FELIPE	ALVARES CARRILLO	22	2016-05-07 22:24:00.830298	2016-05-07 22:24:00.830298
247	DYLAN PAOLA	ARRIAGADA SAEZ 	28	2016-05-07 22:24:00.840975	2016-05-07 22:24:00.840975
248	KRISHNA CATALINA A	AVENDAÑO LOZANO 	18	2016-05-07 22:24:00.856136	2016-05-07 22:24:00.856136
249	SEBASTIAN ANDRES	GATICA OLIVERO	19	2016-05-07 22:24:00.873177	2016-05-07 22:24:00.873177
250	FERNANDA A	MONTECINOS VALDEBENITO 	5	2016-05-07 22:24:00.891614	2016-05-07 22:24:00.891614
251	SEBASTIAN IGNACIO	MUÑOZ SALGADO 	16	2016-05-07 22:24:00.907238	2016-05-07 22:24:00.907238
252	MARTIN NAHUEL	MORALES VALDEBENITO 	8	2016-05-07 22:24:00.92243	2016-05-07 22:24:00.92243
253	JOSUE ESTEBAN	VALENZUELA CEBALLOS 	15	2016-05-07 22:24:00.933482	2016-05-07 22:24:00.933482
254	BENJAMIN ANDRES	VILLABLANCA FUENTES 	1	2016-05-07 22:24:00.946996	2016-05-07 22:24:00.946996
255	ANGELA SARAY	CHAPARRO URRA 	4	2016-05-07 22:24:00.955531	2016-05-07 22:24:00.955531
256	CATALINA ALONDRA	CONTRERAS HERMOSILLA	14	2016-05-07 22:24:00.964039	2016-05-07 22:24:00.964039
257	BENJAMIN MARCELO	GAJARDO  NORA 	30	2016-05-07 22:24:00.972296	2016-05-07 22:24:00.972296
258	DAIRIS SIMONEY	PEREIRA  HUENUPI 	27	2016-05-07 22:24:00.980497	2016-05-07 22:24:00.980497
259	BRANDON MATHIAS	RODRIGUEZ RODRIGUEZ 	25	2016-05-07 22:24:00.989087	2016-05-07 22:24:00.989087
260	VICTORIA ANDREA	AZ0CAR HENRIQUEZ 	10	2016-05-07 22:24:00.997093	2016-05-07 22:24:00.997093
261	ANYELIN NOEMI	PEREZ NAVARRO 	3	2016-05-07 22:24:01.005611	2016-05-07 22:24:01.005611
262	MATEO BENJAMIN	GONZALEZ OLIVARES 	9	2016-05-07 22:24:01.014222	2016-05-07 22:24:01.014222
263	GENESIS FRANCISCA	ARIAS MALDONADO 	31	2016-05-08 00:00:23.499759	2016-05-08 00:00:23.499759
264	JEREMI ANTONIO	SEPULVEDA ROA	17	2016-05-08 00:00:23.525411	2016-05-08 00:00:23.525411
265	STIVEN NICOLAS	MONSALVES LUENGO  	7	2016-05-08 00:00:23.532954	2016-05-08 00:00:23.532954
266	GENESIS JASMIN	SAEZ ZAPATA 	29	2016-05-08 00:00:23.541086	2016-05-08 00:00:23.541086
267	CESAR SEBASTIAN	BALBOA MORALES 	23	2016-05-08 00:00:23.549396	2016-05-08 00:00:23.549396
268	SOFIA FERNANDA	SAEZ VALENZUELA 	13	2016-05-08 00:00:23.558059	2016-05-08 00:00:23.558059
269	AMARO JONATHAN	JORQUERA AGUILERA 	11	2016-05-08 00:00:23.566232	2016-05-08 00:00:23.566232
270	ALEXANDRA YAEL	LAGOS ALVARES 	21	2016-05-08 00:00:23.576057	2016-05-08 00:00:23.576057
271	NAYARET ANAIS	CASTRO SIERRA 	24	2016-05-08 00:00:23.593354	2016-05-08 00:00:23.593354
272	ANA BELEN	VADEBENITO MORALES 	2	2016-05-08 00:00:23.607963	2016-05-08 00:00:23.607963
273	IGNACIO MAXIMILIANO	RIVERA  JURE 	26	2016-05-08 00:00:23.617992	2016-05-08 00:00:23.617992
274	GERALDIE JASMIN S	MUÑOZ BARRIENTOS	6	2016-05-08 00:00:23.632482	2016-05-08 00:00:23.632482
275	VALENTINA ANDREA	REYES ZAPATA 	12	2016-05-08 00:00:23.641279	2016-05-08 00:00:23.641279
276	BRANDON FELIPE	ALVARES CARRILLO	22	2016-05-08 00:00:23.649608	2016-05-08 00:00:23.649608
277	DYLAN PAOLA	ARRIAGADA SAEZ 	28	2016-05-08 00:00:23.657874	2016-05-08 00:00:23.657874
278	KRISHNA CATALINA A	AVENDAÑO LOZANO 	18	2016-05-08 00:00:23.666441	2016-05-08 00:00:23.666441
279	SEBASTIAN ANDRES	GATICA OLIVERO	19	2016-05-08 00:00:23.674989	2016-05-08 00:00:23.674989
280	FERNANDA A	MONTECINOS VALDEBENITO 	5	2016-05-08 00:00:23.683275	2016-05-08 00:00:23.683275
281	SEBASTIAN IGNACIO	MUÑOZ SALGADO 	16	2016-05-08 00:00:23.701768	2016-05-08 00:00:23.701768
282	MARTIN NAHUEL	MORALES VALDEBENITO 	8	2016-05-08 00:00:23.733888	2016-05-08 00:00:23.733888
283	JOSUE ESTEBAN	VALENZUELA CEBALLOS 	15	2016-05-08 00:00:23.767115	2016-05-08 00:00:23.767115
284	BENJAMIN ANDRES	VILLABLANCA FUENTES 	1	2016-05-08 00:00:23.808536	2016-05-08 00:00:23.808536
285	ANGELA SARAY	CHAPARRO URRA 	4	2016-05-08 00:00:23.841651	2016-05-08 00:00:23.841651
286	CATALINA ALONDRA	CONTRERAS HERMOSILLA	14	2016-05-08 00:00:23.849588	2016-05-08 00:00:23.849588
287	BENJAMIN MARCELO	GAJARDO  NORA 	30	2016-05-08 00:00:23.85791	2016-05-08 00:00:23.85791
288	DAIRIS SIMONEY	PEREIRA  HUENUPI 	27	2016-05-08 00:00:23.866172	2016-05-08 00:00:23.866172
289	BRANDON MATHIAS	RODRIGUEZ RODRIGUEZ 	25	2016-05-08 00:00:23.875023	2016-05-08 00:00:23.875023
290	VICTORIA ANDREA	AZ0CAR HENRIQUEZ 	10	2016-05-08 00:00:23.891982	2016-05-08 00:00:23.891982
291	ANYELIN NOEMI	PEREZ NAVARRO 	3	2016-05-08 00:00:23.907799	2016-05-08 00:00:23.907799
292	MATEO BENJAMIN	GONZALEZ OLIVARES 	9	2016-05-08 00:00:23.918029	2016-05-08 00:00:23.918029
293	Sebastian	Espinosa	1234	2016-05-09 02:42:40.953538	2016-05-09 02:42:40.953538
294	Gustavo	Llermaly	544	2016-05-09 02:42:41.138635	2016-05-09 02:42:41.138635
295	A	D	123123123	2016-05-17 20:12:53.805191	2016-05-17 20:12:53.805191
296	B	E	123214214	2016-05-17 20:12:53.891647	2016-05-17 20:12:53.891647
297	C	A	24143145	2016-05-17 20:12:53.906087	2016-05-17 20:12:53.906087
298	gggg	sadsadas	124314124	2016-05-20 02:08:59.546019	2016-05-20 02:08:59.546019
299	sadsad	asdads	23qasdas	2016-05-20 02:08:59.604346	2016-05-20 02:08:59.604346
300	asdasd	asddsa	21341ra	2016-05-20 02:08:59.618158	2016-05-20 02:08:59.618158
301	asddas	adsasd	21421asdad	2016-05-20 02:08:59.626765	2016-05-20 02:08:59.626765
302	asdads	adsasd	r55	2016-05-20 02:08:59.635121	2016-05-20 02:08:59.635121
303	Pepe pecas	Pica papas	123451234	2016-06-28 08:56:22.485323	2016-06-28 08:56:22.485323
304	Alondra martinez	Buena alumna	51414	2016-06-28 08:56:22.564393	2016-06-28 08:56:22.564393
305	Juan	Moscada	111111	2016-06-28 08:56:22.577919	2016-06-28 08:56:22.577919
306	AAA	VVV	12231	2016-06-28 11:05:30.914097	2016-06-28 11:05:30.914097
307	Peter	Perez	444444	2016-06-29 13:12:30.334283	2016-06-29 13:12:30.334283
308	Pablo	Peralta	3333	2016-06-29 13:12:30.414384	2016-06-29 13:12:30.414384
309	asasdas	asdasd	555555	2016-06-29 15:24:19.755454	2016-06-29 15:24:19.755454
310	asdsa	asd4324	33333	2016-06-29 15:24:19.805613	2016-06-29 15:24:19.805613
311	asdsad	asdasd	99999	2016-06-29 15:50:05.724975	2016-06-29 15:50:05.724975
312	asdsaddas	asddsa	88888	2016-06-29 15:50:05.740437	2016-06-29 15:50:05.740437
313	213213	dsadsa	4124	2016-06-29 15:59:58.635219	2016-06-29 15:59:58.635219
314	421414	fasdfadsa	2314	2016-06-29 15:59:58.655498	2016-06-29 15:59:58.655498
315	asdsadsa	asasd	241245	2016-07-01 12:43:54.656124	2016-07-01 12:43:54.656124
316	asdsad	fafff	555514	2016-07-01 12:43:54.707021	2016-07-01 12:43:54.707021
317	asdsadsad	fcccc	513251	2016-07-01 12:44:21.236221	2016-07-01 12:44:21.236221
318	asdasdsa	ccc	4244	2016-07-01 12:44:21.26656	2016-07-01 12:44:21.26656
319	asdsad	asddsa	44444	2016-07-01 13:20:42.588664	2016-07-01 13:20:42.588664
320	asdsa	asdsdadas	55555	2016-07-01 13:20:42.606535	2016-07-01 13:20:42.606535
321	asdasdas	ffff	1111111	2016-07-01 13:31:25.66763	2016-07-01 13:31:25.66763
322	asdasd	fff	222222	2016-07-01 13:31:25.692114	2016-07-01 13:31:25.692114
323	asdasdsad	fff	333333333	2016-07-01 13:31:25.708776	2016-07-01 13:31:25.708776
324	PEPE ANDRES	PEREZ	BC1B20161	2016-07-25 05:54:10.048188	2016-07-25 05:54:10.048188
325	JUAN MANUEL	PALMA	BC1B20162	2016-07-25 05:54:10.064498	2016-07-25 05:54:10.064498
326	Jose	Palomar	BC1B20151	2016-07-25 06:13:57.607088	2016-07-25 06:13:57.607088
327	Pablo	Prado	BC20152	2016-07-25 06:13:57.61669	2016-07-25 06:13:57.61669
328	Jose	Mata	A12	2016-07-25 07:50:10.729624	2016-07-25 07:50:10.729624
329	Perez	Rosal	A13	2016-07-25 07:50:10.743015	2016-07-25 07:50:10.743015
330	RERE	ddd	A12	2016-07-25 07:50:57.67353	2016-07-25 07:50:57.67353
331	fff	dd	A15	2016-07-25 07:50:57.68368	2016-07-25 07:50:57.68368
332	asdas	asddas	A33	2016-07-25 08:01:54.148014	2016-07-25 08:01:54.148014
333	sad	sad	A12	2016-07-25 08:02:20.515692	2016-07-25 08:02:20.515692
336	fdsd	dsd	A54	2016-07-25 08:03:19.417506	2016-07-25 08:03:19.417506
337	gato	loco	A69	2016-07-25 08:25:06.298832	2016-07-25 08:25:06.298832
338	Joaquin	Perez	1010	2016-07-26 20:46:21.811063	2016-07-26 20:46:21.811063
339	Joaquin	Perez	1010	2016-07-26 20:50:13.636968	2016-07-26 20:50:13.636968
340	Alberto	Lopez	1011	2016-07-26 20:50:13.651538	2016-07-26 20:50:13.651538
341	Nicolas	Gomez	1012	2016-07-26 20:50:13.659921	2016-07-26 20:50:13.659921
342	Jesus	Soto	1013	2016-07-26 20:50:13.668341	2016-07-26 20:50:13.668341
343	Lance	Amstrong	1014	2016-07-26 20:50:13.677251	2016-07-26 20:50:13.677251
344	Alberto	Contador	1015	2016-07-26 20:54:07.882292	2016-07-26 20:54:07.882292
345	Alexis	Sanchez	1016	2016-07-26 20:54:07.89171	2016-07-26 20:54:07.89171
346	Carlos	carmona	1017	2016-07-26 20:54:07.901043	2016-07-26 20:54:07.901043
347	Jairo	Quintana	1018	2016-07-26 20:54:07.909453	2016-07-26 20:54:07.909453
348	Gary	Medel	1019	2016-07-26 20:54:07.922664	2016-07-26 20:54:07.922664
349	Manuel	Iturra	1210	2016-07-26 20:56:41.674507	2016-07-26 20:56:41.674507
350	Gonzalo	Jara	1211	2016-07-26 20:56:41.683542	2016-07-26 20:56:41.683542
351	Jorge	Sampaoli	1213	2016-07-26 20:56:41.691047	2016-07-26 20:56:41.691047
352	Augusto	Ugarte	1214	2016-07-26 20:56:41.699448	2016-07-26 20:56:41.699448
353	Felipe	Castro	1215	2016-07-26 20:56:41.706944	2016-07-26 20:56:41.706944
354	Alberto	Quintana	1216	2016-07-26 20:59:37.188521	2016-07-26 20:59:37.188521
355	Horacio	Gana	1217	2016-07-26 20:59:37.197291	2016-07-26 20:59:37.197291
356	Gustavo	Flores	1218	2016-07-26 20:59:37.20508	2016-07-26 20:59:37.20508
357	Ernesto	Atala	1219	2016-07-26 20:59:37.215529	2016-07-26 20:59:37.215529
358	Matilda	Lopez	1220	2016-07-26 20:59:37.223227	2016-07-26 20:59:37.223227
359	Pablo	Escobar	1301	2016-07-26 21:01:03.191766	2016-07-26 21:01:03.191766
360	Fernando	Marin	1302	2016-07-26 21:01:03.200036	2016-07-26 21:01:03.200036
361	Paula	Almazan	1303	2016-07-26 21:01:03.207915	2016-07-26 21:01:03.207915
362	Francisca	Valenzuela	1304	2016-07-26 21:01:03.215125	2016-07-26 21:01:03.215125
363	Jorge	Gonzalez	1305	2016-07-26 21:01:03.222857	2016-07-26 21:01:03.222857
364	Jesus	Gonzalez	1306	2016-07-26 21:02:23.801498	2016-07-26 21:02:23.801498
365	Esteban	Parada	1307	2016-07-26 21:02:23.81041	2016-07-26 21:02:23.81041
366	Bruno	Miñano	1308	2016-07-26 21:02:23.818054	2016-07-26 21:02:23.818054
367	Estefania	Perez	1309	2016-07-26 21:02:23.826361	2016-07-26 21:02:23.826361
368	Jasmani	Campos	1310	2016-07-26 21:02:23.833951	2016-07-26 21:02:23.833951
369	Jacinta	Perez	1401	2016-07-26 21:05:09.033942	2016-07-26 21:05:09.033942
370	Felipe	Lopez	1402	2016-07-26 21:05:09.042098	2016-07-26 21:05:09.042098
371	Diego	Micheli	1403	2016-07-26 21:05:09.050632	2016-07-26 21:05:09.050632
372	Roberto	Flores	1404	2016-07-26 21:05:09.060414	2016-07-26 21:05:09.060414
373	Matias	Gripe	1405	2016-07-26 21:05:09.068432	2016-07-26 21:05:09.068432
374	Marta	Sanchez	1406	2016-07-26 21:06:41.632608	2016-07-26 21:06:41.632608
375	Andres	Salvo	1407	2016-07-26 21:06:41.641716	2016-07-26 21:06:41.641716
376	Felipe	Soto	1408	2016-07-26 21:06:41.650415	2016-07-26 21:06:41.650415
377	Luke	Skywalker	1409	2016-07-26 21:06:41.658061	2016-07-26 21:06:41.658061
378	Han	Solo	1410	2016-07-26 21:06:41.666511	2016-07-26 21:06:41.666511
379	Constanza	Marchant	1501	2016-07-26 21:08:09.630121	2016-07-26 21:08:09.630121
380	Sofia	Suazo	1502	2016-07-26 21:08:09.6437	2016-07-26 21:08:09.6437
381	Daniela	Plaza	1503	2016-07-26 21:08:09.658553	2016-07-26 21:08:09.658553
382	Paula	Pinochet	1504	2016-07-26 21:08:09.669634	2016-07-26 21:08:09.669634
383	Paloma	Guzman	1505	2016-07-26 21:08:09.678377	2016-07-26 21:08:09.678377
384	Catalina	Casas	1506	2016-07-26 21:09:46.368325	2016-07-26 21:09:46.368325
385	Eric	Lopez	1507	2016-07-26 21:09:46.378549	2016-07-26 21:09:46.378549
386	Pamela	Cortes	1508	2016-07-26 21:09:46.386356	2016-07-26 21:09:46.386356
387	Robin	Lopez	1509	2016-07-26 21:09:46.395043	2016-07-26 21:09:46.395043
388	Alonso	Morning	1510	2016-07-26 21:09:46.402709	2016-07-26 21:09:46.402709
394	Rodrigo	Meriggio	1601	2016-07-26 21:12:01.49292	2016-07-26 21:12:01.49292
395	Felipe	Olivares	1602	2016-07-26 21:12:01.501508	2016-07-26 21:12:01.501508
396	Lebron	James	1603	2016-07-26 21:12:01.510359	2016-07-26 21:12:01.510359
397	Tony	Hawk	1604	2016-07-26 21:12:01.518184	2016-07-26 21:12:01.518184
398	Steve	Caballero	1605	2016-07-26 21:12:01.528029	2016-07-26 21:12:01.528029
399	Justin	Timberlake	1606	2016-07-26 21:16:33.433001	2016-07-26 21:16:33.433001
400	Joaquin	Israel	1607	2016-07-26 21:16:33.444019	2016-07-26 21:16:33.444019
401	Gustavo	Lobo	1608	2016-07-26 21:16:33.452315	2016-07-26 21:16:33.452315
402	Carolina	Toha	1609	2016-07-26 21:16:33.460017	2016-07-26 21:16:33.460017
403	Isabel	Allende	1610	2016-07-26 21:16:33.467431	2016-07-26 21:16:33.467431
404	Martina	Higgins	1701	2016-07-26 21:22:07.331312	2016-07-26 21:22:07.331312
405	Marcelo	Rios	1702	2016-07-26 21:22:07.339843	2016-07-26 21:22:07.339843
406	Nicolas	Massu	1703	2016-07-26 21:22:07.347008	2016-07-26 21:22:07.347008
407	Justin	Bieber	1704	2016-07-26 21:22:07.355495	2016-07-26 21:22:07.355495
408	Rodrigo	Tapia	1705	2016-07-26 21:22:07.363112	2016-07-26 21:22:07.363112
409	Carmela	Ortega	1706	2016-07-26 21:32:35.93839	2016-07-26 21:32:35.93839
410	Carolina	Morales	1707	2016-07-26 21:32:35.947607	2016-07-26 21:32:35.947607
411	Carolina	Chacon	1708	2016-07-26 21:32:35.955659	2016-07-26 21:32:35.955659
412	Rodrigo	Tapia	1709	2016-07-26 21:32:35.963984	2016-07-26 21:32:35.963984
413	Jean	Charlin	1710	2016-07-26 21:32:35.971512	2016-07-26 21:32:35.971512
414	Fidel	Castro	1801	2016-07-26 21:34:21.448617	2016-07-26 21:34:21.448617
415	Benito	Musolini	1802	2016-07-26 21:34:21.458325	2016-07-26 21:34:21.458325
416	Adolf	Hitler	1803	2016-07-26 21:34:21.46627	2016-07-26 21:34:21.46627
417	Francisco	Franco	1804	2016-07-26 21:34:21.477162	2016-07-26 21:34:21.477162
418	Augusto	Pinochet	1805	2016-07-26 21:34:21.485972	2016-07-26 21:34:21.485972
419	Alberto	Lavin	1806	2016-07-26 21:39:58.568634	2016-07-26 21:39:58.568634
420	Joaquin	Estevez	1807	2016-07-26 21:39:58.577649	2016-07-26 21:39:58.577649
421	Sergio	Jadue	1808	2016-07-26 21:39:58.588623	2016-07-26 21:39:58.588623
422	Ian	Bellet	1809	2016-07-26 21:39:58.597008	2016-07-26 21:39:58.597008
423	Pedro	Torres	1810	2016-07-26 21:39:58.60485	2016-07-26 21:39:58.60485
424	Pedro	Morales	1901	2016-07-26 21:53:00.794466	2016-07-26 21:53:00.794466
425	Agustin	Parra	1902	2016-07-26 21:53:00.803749	2016-07-26 21:53:00.803749
426	Juan	Delgado	1903	2016-07-26 21:53:00.81137	2016-07-26 21:53:00.81137
427	Pedro	Jara	1904	2016-07-26 21:53:00.819024	2016-07-26 21:53:00.819024
428	Felipe	Jorquera	1905	2016-07-26 21:53:00.827093	2016-07-26 21:53:00.827093
429	Esteban	Pavez	1906	2016-07-26 21:54:31.203846	2016-07-26 21:54:31.203846
430	Gonzalo	Espinoza	1907	2016-07-26 21:54:31.212358	2016-07-26 21:54:31.212358
431	Esteban	Paredes	1908	2016-07-26 21:54:31.220826	2016-07-26 21:54:31.220826
432	Lucas	Pratto	1909	2016-07-26 21:54:31.228787	2016-07-26 21:54:31.228787
433	Lucas	Vilches	1910	2016-07-26 21:54:31.237498	2016-07-26 21:54:31.237498
434	Roberto	Parra	2001	2016-07-26 21:56:23.485528	2016-07-26 21:56:23.485528
435	Hector	Torres	2002	2016-07-26 21:56:23.494036	2016-07-26 21:56:23.494036
436	Juan	Briceño	2003	2016-07-26 21:56:23.503276	2016-07-26 21:56:23.503276
437	Juan	Morales	2004	2016-07-26 21:56:23.513044	2016-07-26 21:56:23.513044
438	Pedro	Cortes	2005	2016-07-26 21:56:23.52021	2016-07-26 21:56:23.52021
439	Juan	Morales	2006	2016-07-26 22:00:30.20741	2016-07-26 22:00:30.20741
440	Michael	Ortega	2007	2016-07-26 22:00:30.215704	2016-07-26 22:00:30.215704
441	Felipe	Parra	2008	2016-07-26 22:00:30.224066	2016-07-26 22:00:30.224066
442	Ricardo	Lopez	2009	2016-07-26 22:00:30.231991	2016-07-26 22:00:30.231991
443	Daniela	Fuentes	2010	2016-07-26 22:00:30.239841	2016-07-26 22:00:30.239841
444	Francisca	Vargas	2101	2016-07-26 22:03:27.444455	2016-07-26 22:03:27.444455
445	Valentina	Lopez	2102	2016-07-26 22:03:27.454004	2016-07-26 22:03:27.454004
446	Paula	gonzales	2103	2016-07-26 22:03:27.465853	2016-07-26 22:03:27.465853
447	Agustina	Parra	2104	2016-07-26 22:03:27.474484	2016-07-26 22:03:27.474484
448	Juan	Morales	2105	2016-07-26 22:03:27.482971	2016-07-26 22:03:27.482971
449	Pedro	Orpis	2106	2016-07-26 22:05:20.12421	2016-07-26 22:05:20.12421
450	Nicolas	Ostornol	2107	2016-07-26 22:05:20.133603	2016-07-26 22:05:20.133603
451	Nicolas	Tapia	2108	2016-07-26 22:05:20.144235	2016-07-26 22:05:20.144235
452	Gustavo	Orlandi	2109	2016-07-26 22:05:20.15142	2016-07-26 22:05:20.15142
453	John	Stevens	2110	2016-07-26 22:05:20.158829	2016-07-26 22:05:20.158829
454	Marta	Lira	2201	2016-07-26 22:08:29.744927	2016-07-26 22:08:29.744927
455	Franco	Illesca	2202	2016-07-26 22:08:29.757215	2016-07-26 22:08:29.757215
456	Mark	Hoppus	2203	2016-07-26 22:08:29.767235	2016-07-26 22:08:29.767235
457	Tomas	Becerra	2204	2016-07-26 22:08:29.779699	2016-07-26 22:08:29.779699
458	Sebastian	Carvajal	2205	2016-07-26 22:08:29.792308	2016-07-26 22:08:29.792308
459	Juan	Veliz	2206	2016-07-26 22:10:43.874901	2016-07-26 22:10:43.874901
460	Rodrigo	Tella	2207	2016-07-26 22:10:43.883065	2016-07-26 22:10:43.883065
461	Sergio	Gonzales	2208	2016-07-26 22:10:43.891768	2016-07-26 22:10:43.891768
462	Ricardo	Sotelo	2209	2016-07-26 22:10:43.901669	2016-07-26 22:10:43.901669
463	Olga	Camus	2210	2016-07-26 22:10:43.910872	2016-07-26 22:10:43.910872
464	Joaquin	Perez	1010	2016-07-26 22:48:05.186905	2016-07-26 22:48:05.186905
465	Alberto	Lopez	1011	2016-07-26 22:48:05.196664	2016-07-26 22:48:05.196664
466	Nicolas	Gomez	1012	2016-07-26 22:48:05.204876	2016-07-26 22:48:05.204876
467	Jesus	Soto	1013	2016-07-26 22:48:05.212288	2016-07-26 22:48:05.212288
468	Lance	Amstrong	1014	2016-07-26 22:48:05.220641	2016-07-26 22:48:05.220641
469	Alberto	Contador	1015	2016-07-26 23:03:25.67747	2016-07-26 23:03:25.67747
470	Alexis	Sanchez	1016	2016-07-26 23:03:25.694315	2016-07-26 23:03:25.694315
471	Carlos	Carmona	1017	2016-07-26 23:03:25.702846	2016-07-26 23:03:25.702846
472	Jairo	Quintana	1018	2016-07-26 23:03:25.71313	2016-07-26 23:03:25.71313
473	Gary	Medel	1019	2016-07-26 23:03:25.725258	2016-07-26 23:03:25.725258
474	Juan	Carmona	3001	2016-07-26 23:04:34.636442	2016-07-26 23:04:34.636442
475	Alexis	Vidal	3002	2016-07-26 23:04:34.646732	2016-07-26 23:04:34.646732
476	Gary	Soto	3003	2016-07-26 23:04:34.656379	2016-07-26 23:04:34.656379
477	Patrick	Stevens	3004	2016-07-26 23:04:34.688321	2016-07-26 23:04:34.688321
478	Juan	Fuentes	3005	2016-07-26 23:04:34.697223	2016-07-26 23:04:34.697223
479	Pedro	Fernandez	3006	2016-07-26 23:05:36.967435	2016-07-26 23:05:36.967435
480	Pablo	Hernandez	3007	2016-07-26 23:05:36.977885	2016-07-26 23:05:36.977885
481	Julio	Barroso	3008	2016-07-26 23:05:36.986362	2016-07-26 23:05:36.986362
482	Carla	Apablaza	3009	2016-07-26 23:05:36.995141	2016-07-26 23:05:36.995141
483	Blanca	Nebiolo	3010	2016-07-26 23:05:37.003391	2016-07-26 23:05:37.003391
484	Manuel	Iturra	1210	2016-07-26 23:08:00.19597	2016-07-26 23:08:00.19597
485	Gonzalo	Jara	1211	2016-07-26 23:08:00.20502	2016-07-26 23:08:00.20502
486	Jorge	Sampaoli	1213	2016-07-26 23:08:00.213216	2016-07-26 23:08:00.213216
487	Augusto	Ugarte	1214	2016-07-26 23:08:00.221418	2016-07-26 23:08:00.221418
488	Felipe	Castro	1215	2016-07-26 23:08:00.229657	2016-07-26 23:08:00.229657
489	Alberto	Quintana	1216	2016-07-26 23:10:19.919012	2016-07-26 23:10:19.919012
490	Horacio	Gana	1217	2016-07-26 23:10:19.928091	2016-07-26 23:10:19.928091
491	Gustavo	Flores	1218	2016-07-26 23:10:19.935511	2016-07-26 23:10:19.935511
492	Ernesto	Atala	1219	2016-07-26 23:10:19.944317	2016-07-26 23:10:19.944317
493	Matilda	Lopez	1220	2016-07-26 23:10:19.951464	2016-07-26 23:10:19.951464
494	Jesus	Gonzales	1306	2016-07-26 23:18:53.025564	2016-07-26 23:18:53.025564
495	Esteban	Parada	1307	2016-07-26 23:18:53.034454	2016-07-26 23:18:53.034454
496	Bruno	Miñano	1308	2016-07-26 23:18:53.043044	2016-07-26 23:18:53.043044
497	Estefania	Perez	1309	2016-07-26 23:18:53.051046	2016-07-26 23:18:53.051046
498	Jasmani	Campos	1310	2016-07-26 23:18:53.058807	2016-07-26 23:18:53.058807
505	Fernando	Marin	1302	2016-07-26 23:20:43.768394	2016-07-26 23:20:43.768394
506	Paula	Almazan	1303	2016-07-26 23:20:43.776221	2016-07-26 23:20:43.776221
509	Pablo	Escobar	1301	2016-07-26 23:20:44.119476	2016-07-26 23:20:44.119476
512	Francisca	Valenzuela	1304	2016-07-26 23:20:44.14337	2016-07-26 23:20:44.14337
513	Jorge	Gonzalez	1305	2016-07-26 23:20:44.151371	2016-07-26 23:20:44.151371
514	Jacinta	Perez	1401	2016-07-26 23:23:37.440006	2016-07-26 23:23:37.440006
515	Felipe	Lopez	1402	2016-07-26 23:23:37.44805	2016-07-26 23:23:37.44805
516	Diego	Micheli	1403	2016-07-26 23:23:37.456541	2016-07-26 23:23:37.456541
517	Roberto	Flores	1404	2016-07-26 23:23:37.464261	2016-07-26 23:23:37.464261
518	Matias	Gripe	1405	2016-07-26 23:23:37.471562	2016-07-26 23:23:37.471562
519	Marta	Sanchez	1406	2016-07-26 23:27:01.928457	2016-07-26 23:27:01.928457
520	Andres	Salvo	1407	2016-07-26 23:27:01.938777	2016-07-26 23:27:01.938777
521	Felipe	Soto	1408	2016-07-26 23:27:01.953623	2016-07-26 23:27:01.953623
522	Luke	Skywalker	1409	2016-07-26 23:27:01.962723	2016-07-26 23:27:01.962723
523	Han	Solo	1410	2016-07-26 23:27:01.97448	2016-07-26 23:27:01.97448
524	Constanza	Marchant	1501	2016-07-26 23:30:20.124935	2016-07-26 23:30:20.124935
525	Sofia	Suazo	1502	2016-07-26 23:30:20.133447	2016-07-26 23:30:20.133447
526	Daniela	Plaza	1503	2016-07-26 23:30:20.141039	2016-07-26 23:30:20.141039
527	Paula	Pinochet	1504	2016-07-26 23:30:20.14972	2016-07-26 23:30:20.14972
528	Paloma	Guzman	1505	2016-07-26 23:30:20.157334	2016-07-26 23:30:20.157334
529	Catalina	Casas	1506	2016-07-26 23:32:35.18297	2016-07-26 23:32:35.18297
530	Eric	Lopez	1507	2016-07-26 23:32:35.192254	2016-07-26 23:32:35.192254
531	Pamela	Cortes	1508	2016-07-26 23:32:35.20139	2016-07-26 23:32:35.20139
532	Robin	Lopez	1509	2016-07-26 23:32:35.209618	2016-07-26 23:32:35.209618
533	Alonso	Morning	1510	2016-07-26 23:32:35.218636	2016-07-26 23:32:35.218636
534	Rodrigo	Meriggio	1601	2016-07-26 23:35:31.100637	2016-07-26 23:35:31.100637
535	Felipe	Olivares	1602	2016-07-26 23:35:31.115693	2016-07-26 23:35:31.115693
536	Lebron	James	1603	2016-07-26 23:35:31.129186	2016-07-26 23:35:31.129186
537	Tony	Hawk	1604	2016-07-26 23:35:31.141855	2016-07-26 23:35:31.141855
538	Steve	Caballero	1605	2016-07-26 23:35:31.15367	2016-07-26 23:35:31.15367
539	Justin	Timberlake	1606	2016-07-26 23:38:19.129295	2016-07-26 23:38:19.129295
540	Joaquin	Israel	1607	2016-07-26 23:38:19.145663	2016-07-26 23:38:19.145663
541	Gustavo	Lobo	1608	2016-07-26 23:38:19.162924	2016-07-26 23:38:19.162924
542	Carolina	Toha	1609	2016-07-26 23:38:19.176758	2016-07-26 23:38:19.176758
543	Isabel	Allende	1610	2016-07-26 23:38:19.190483	2016-07-26 23:38:19.190483
544	Martina	Higgins	1701	2016-07-26 23:41:07.673375	2016-07-26 23:41:07.673375
545	Marcelo	Rios	1702	2016-07-26 23:41:07.686575	2016-07-26 23:41:07.686575
546	Nicolas	Massu	1703	2016-07-26 23:41:07.698755	2016-07-26 23:41:07.698755
547	Justin	Bieber	1704	2016-07-26 23:41:07.71213	2016-07-26 23:41:07.71213
548	Rodrigo	Tapia	1705	2016-07-26 23:41:07.724611	2016-07-26 23:41:07.724611
549	Carmela	Ortega	1706	2016-07-26 23:43:21.494389	2016-07-26 23:43:21.494389
550	Carolina	Morales	1707	2016-07-26 23:43:21.510851	2016-07-26 23:43:21.510851
551	Carolina	Chacon	1708	2016-07-26 23:43:21.529667	2016-07-26 23:43:21.529667
552	Rodrigo	Tapia	1709	2016-07-26 23:43:21.542101	2016-07-26 23:43:21.542101
553	Jean	Charlin	1710	2016-07-26 23:43:21.55854	2016-07-26 23:43:21.55854
554	Fidel	Castro	1801	2016-07-26 23:46:19.012892	2016-07-26 23:46:19.012892
555	Benito	Musolini	1802	2016-07-26 23:46:19.031307	2016-07-26 23:46:19.031307
556	Adolf	Hitler	1803	2016-07-26 23:46:19.047731	2016-07-26 23:46:19.047731
557	Francisco	Franco	1804	2016-07-26 23:46:19.066715	2016-07-26 23:46:19.066715
558	Augusto	Pinochet	1805	2016-07-26 23:46:19.081767	2016-07-26 23:46:19.081767
559	Alberto	Lavin	1806	2016-07-26 23:48:47.821835	2016-07-26 23:48:47.821835
560	Joaquin	Estevez	1807	2016-07-26 23:48:47.838796	2016-07-26 23:48:47.838796
561	Sergio	Jadue	1808	2016-07-26 23:48:47.858447	2016-07-26 23:48:47.858447
562	Ian	Bellet	1809	2016-07-26 23:48:47.873944	2016-07-26 23:48:47.873944
563	Pedro	Torres	1810	2016-07-26 23:48:47.887346	2016-07-26 23:48:47.887346
564	Pedro	Morales	1901	2016-07-26 23:52:49.838775	2016-07-26 23:52:49.838775
565	Agustin	Parra	1902	2016-07-26 23:52:49.856396	2016-07-26 23:52:49.856396
566	Juan	Delgado	1903	2016-07-26 23:52:49.873085	2016-07-26 23:52:49.873085
567	Pedro	Jara	1904	2016-07-26 23:52:49.888575	2016-07-26 23:52:49.888575
568	Felipe	Jorquera	1905	2016-07-26 23:52:49.900685	2016-07-26 23:52:49.900685
569	Esteban	Pavez	1906	2016-07-26 23:54:44.433337	2016-07-26 23:54:44.433337
570	Gonzalo	Espinoza	1907	2016-07-26 23:54:44.448158	2016-07-26 23:54:44.448158
571	Esteban	Paredes	1908	2016-07-26 23:54:44.45985	2016-07-26 23:54:44.45985
572	Lucas	Pratto	1909	2016-07-26 23:54:44.475863	2016-07-26 23:54:44.475863
573	Lucas	Vilchez	1910	2016-07-26 23:54:44.487949	2016-07-26 23:54:44.487949
574	Roberto	Parra	2001	2016-07-26 23:56:47.436242	2016-07-26 23:56:47.436242
575	Hector	Torres	2002	2016-07-26 23:56:47.453145	2016-07-26 23:56:47.453145
576	Juan	Briceño	2003	2016-07-26 23:56:47.467432	2016-07-26 23:56:47.467432
577	Juan	Morales	2004	2016-07-26 23:56:47.479011	2016-07-26 23:56:47.479011
578	Pedro	Cortes	2005	2016-07-26 23:56:47.492559	2016-07-26 23:56:47.492559
579	Juan	Morales	2006	2016-07-26 23:59:19.398323	2016-07-26 23:59:19.398323
580	Michael	Ortega	2007	2016-07-26 23:59:19.415785	2016-07-26 23:59:19.415785
581	Felipe	Parra	2008	2016-07-26 23:59:19.427737	2016-07-26 23:59:19.427737
582	Ricardo	Lopez	2009	2016-07-26 23:59:19.442813	2016-07-26 23:59:19.442813
583	Daniela	Fuentes	2010	2016-07-26 23:59:19.454548	2016-07-26 23:59:19.454548
584	Francisca	Vargas	2101	2016-07-27 00:01:00.475938	2016-07-27 00:01:00.475938
585	Valentina	Lopez	2102	2016-07-27 00:01:00.488473	2016-07-27 00:01:00.488473
586	Paula	Gonzalez	2103	2016-07-27 00:01:00.502856	2016-07-27 00:01:00.502856
587	Agustina	Parra	2104	2016-07-27 00:01:00.513403	2016-07-27 00:01:00.513403
588	Juan	Morales	2105	2016-07-27 00:01:00.529922	2016-07-27 00:01:00.529922
589	Pedro	Orpis	2106	2016-07-27 00:02:49.283065	2016-07-27 00:02:49.283065
590	Nicolas	Ostornol	2107	2016-07-27 00:02:49.298274	2016-07-27 00:02:49.298274
591	Nicolas	Tapia	2108	2016-07-27 00:02:49.310159	2016-07-27 00:02:49.310159
592	Gustavo	Orlandi	2109	2016-07-27 00:02:49.324093	2016-07-27 00:02:49.324093
593	John	Stevens	2110	2016-07-27 00:02:49.338969	2016-07-27 00:02:49.338969
594	Juan	Castro	1111	2016-07-27 01:32:07.166231	2016-07-27 01:32:07.166231
595	Pedro	Lopez	1112	2016-07-27 01:32:07.175138	2016-07-27 01:32:07.175138
596	Juan	Guarello	1113	2016-07-27 01:32:07.183048	2016-07-27 01:32:07.183048
597	Gustavo	Tapia	1114	2016-07-27 01:32:07.191118	2016-07-27 01:32:07.191118
598	Felipe	Salazar	1115	2016-07-27 01:32:07.199928	2016-07-27 01:32:07.199928
604	Osvaldo	Gonzalez	1116	2016-07-27 01:35:27.461621	2016-07-27 01:35:27.461621
605	Eduardo	Vargas	1117	2016-07-27 01:35:27.470321	2016-07-27 01:35:27.470321
606	Marcelo	Diaz	1118	2016-07-27 01:35:27.478759	2016-07-27 01:35:27.478759
607	Jose	Rojas	1119	2016-07-27 01:35:27.487001	2016-07-27 01:35:27.487001
608	Sebastian	Martinez	1120	2016-07-27 01:35:27.495492	2016-07-27 01:35:27.495492
609	Lorenzo	reyes	1121	2016-07-27 01:36:41.183976	2016-07-27 01:36:41.183976
610	Gaston	Fernandez	1122	2016-07-27 01:36:41.19268	2016-07-27 01:36:41.19268
611	Ramon	Fernandez	1123	2016-07-27 01:36:41.201306	2016-07-27 01:36:41.201306
612	Nelson	Rebolledo	1124	2016-07-27 01:36:41.210755	2016-07-27 01:36:41.210755
613	Juan 	Abarca	1125	2016-07-27 01:36:41.219404	2016-07-27 01:36:41.219404
614	Carolina	Vasquez	1126	2016-07-27 01:37:10.852215	2016-07-27 01:37:10.852215
615	Paula	Pinochet	1127	2016-07-27 01:37:10.860678	2016-07-27 01:37:10.860678
616	Pablo	Gonzalez	1128	2016-07-27 01:37:10.869667	2016-07-27 01:37:10.869667
617	Nicolas	Tapia	1129	2016-07-27 01:37:10.877482	2016-07-27 01:37:10.877482
618	Alejandro 	Gomez	1130	2016-07-27 01:37:10.886548	2016-07-27 01:37:10.886548
619	Diego	Mendez	1131	2016-07-27 01:38:16.263706	2016-07-27 01:38:16.263706
620	Gaston	Arriagada	1132	2016-07-27 01:38:16.27229	2016-07-27 01:38:16.27229
621	Fabian	Piedra	1133	2016-07-27 01:38:16.282079	2016-07-27 01:38:16.282079
622	Sebastian	Zuñiga	1134	2016-07-27 01:38:16.29008	2016-07-27 01:38:16.29008
623	Diego	Prado	1135	2016-07-27 01:38:16.298943	2016-07-27 01:38:16.298943
624	Agustin	Parra	1136	2016-07-27 01:38:53.253376	2016-07-27 01:38:53.253376
625	Pedro 	Morales	1137	2016-07-27 01:38:53.262161	2016-07-27 01:38:53.262161
626	Augusto	Maldonado	1138	2016-07-27 01:38:53.271838	2016-07-27 01:38:53.271838
627	Claudio	Maldonado	1139	2016-07-27 01:38:53.280244	2016-07-27 01:38:53.280244
628	Maria	pardo	1140	2016-07-27 01:38:53.289039	2016-07-27 01:38:53.289039
629	Leonor	Varela	1141	2016-07-27 01:39:23.030215	2016-07-27 01:39:23.030215
630	Sebastian	Lopez	1142	2016-07-27 01:39:23.038804	2016-07-27 01:39:23.038804
631	Alvaro	Salazar	1143	2016-07-27 01:39:23.047618	2016-07-27 01:39:23.047618
632	Juan	Zeiner	1144	2016-07-27 01:39:23.055577	2016-07-27 01:39:23.055577
633	Julio	Irving	1145	2016-07-27 01:39:23.064339	2016-07-27 01:39:23.064339
634	xin	xon	1146	2016-07-27 01:39:54.257304	2016-07-27 01:39:54.257304
635	Alfredo	Fuentes	1147	2016-07-27 01:39:54.265645	2016-07-27 01:39:54.265645
636	Osvaldo	Jimenez	1148	2016-07-27 01:39:54.274845	2016-07-27 01:39:54.274845
637	Diego	Panza	1149	2016-07-27 01:39:54.283436	2016-07-27 01:39:54.283436
638	Cristian	Salamanca	1150	2016-07-27 01:39:54.292242	2016-07-27 01:39:54.292242
639	Martina	Bustos	1151	2016-07-27 01:40:32.142488	2016-07-27 01:40:32.142488
640	Paula	Justiniano	1152	2016-07-27 01:40:32.152514	2016-07-27 01:40:32.152514
641	Carolina	Bolados	1153	2016-07-27 01:40:32.160524	2016-07-27 01:40:32.160524
642	Cristina	Fernandez	1154	2016-07-27 01:40:32.168432	2016-07-27 01:40:32.168432
643	Juana	Rojas	1155	2016-07-27 01:40:32.177953	2016-07-27 01:40:32.177953
644	Ivan	Salas	1156	2016-07-27 01:41:14.915548	2016-07-27 01:41:14.915548
645	Kobe 	Bryant	1157	2016-07-27 01:41:14.923819	2016-07-27 01:41:14.923819
646	Steve 	Jobs	1158	2016-07-27 01:41:14.932738	2016-07-27 01:41:14.932738
647	Pedro	Diaz	1159	2016-07-27 01:41:14.941488	2016-07-27 01:41:14.941488
648	Octavio 	Riquero	1160	2016-07-27 01:41:14.950265	2016-07-27 01:41:14.950265
649	Fernando	Correa	1161	2016-07-27 01:41:51.287243	2016-07-27 01:41:51.287243
650	Valeria	Ferrat	1162	2016-07-27 01:41:51.296259	2016-07-27 01:41:51.296259
651	Michelle	Rojas	1163	2016-07-27 01:41:51.304676	2016-07-27 01:41:51.304676
652	Pamela	Lopez	1164	2016-07-27 01:41:51.312832	2016-07-27 01:41:51.312832
653	Jaime	Fuenzalida	1165	2016-07-27 01:41:51.32134	2016-07-27 01:41:51.32134
654	Rod	Stewart	1166	2016-07-27 01:42:18.070051	2016-07-27 01:42:18.070051
655	Roberto	Piñera	1167	2016-07-27 01:42:18.079748	2016-07-27 01:42:18.079748
656	Bruce	Lee	1168	2016-07-27 01:42:18.088685	2016-07-27 01:42:18.088685
657	Brian	Keith	1169	2016-07-27 01:42:18.097894	2016-07-27 01:42:18.097894
658	Arantza 	Castro	1170	2016-07-27 01:42:18.10637	2016-07-27 01:42:18.10637
659	Juan	Pardo	1171	2016-07-27 01:42:49.571608	2016-07-27 01:42:49.571608
660	Victor	Franklin	1172	2016-07-27 01:42:49.580824	2016-07-27 01:42:49.580824
661	Arturo	Prat	1173	2016-07-27 01:42:49.589785	2016-07-27 01:42:49.589785
662	Diego	Almagro	1174	2016-07-27 01:42:49.597476	2016-07-27 01:42:49.597476
663	Jose	Carrera	1175	2016-07-27 01:42:49.606406	2016-07-27 01:42:49.606406
664	juan	Balmaceda	1176	2016-07-27 01:43:19.066996	2016-07-27 01:43:19.066996
665	Pedro	Montt	1177	2016-07-27 01:43:19.07634	2016-07-27 01:43:19.07634
666	ramiro	franco	1178	2016-07-27 01:43:19.084163	2016-07-27 01:43:19.084163
667	Ernesto	Gomez	1179	2016-07-27 01:43:19.092406	2016-07-27 01:43:19.092406
668	Juan	Bolados	1180	2016-07-27 01:43:19.100862	2016-07-27 01:43:19.100862
669	Felipe	Camiroaga	1181	2016-07-27 01:43:56.490415	2016-07-27 01:43:56.490415
670	Jose	 Viñuela	1182	2016-07-27 01:43:56.501256	2016-07-27 01:43:56.501256
671	Pedro	Henriquez	1183	2016-07-27 01:43:56.509102	2016-07-27 01:43:56.509102
672	Monica	Salinas	1184	2016-07-27 01:43:56.517936	2016-07-27 01:43:56.517936
673	Larry	Chang	1185	2016-07-27 01:43:56.525758	2016-07-27 01:43:56.525758
674	martin	carrizo	1186	2016-07-27 01:44:23.639182	2016-07-27 01:44:23.639182
675	dinesh	morales	1187	2016-07-27 01:44:23.647976	2016-07-27 01:44:23.647976
676	jesus	gripe	1188	2016-07-27 01:44:23.655901	2016-07-27 01:44:23.655901
677	giancarlo	lopez	1189	2016-07-27 01:44:23.66418	2016-07-27 01:44:23.66418
678	placido	domingo	1190	2016-07-27 01:44:23.672718	2016-07-27 01:44:23.672718
679	Thalia	Lopez	1191	2016-07-27 01:44:55.463213	2016-07-27 01:44:55.463213
680	Guillermo	Cuadrado	1192	2016-07-27 01:44:55.472478	2016-07-27 01:44:55.472478
681	Javier	Devia	1193	2016-07-27 01:44:55.481213	2016-07-27 01:44:55.481213
682	Tomas	Puentes	1194	2016-07-27 01:44:55.48909	2016-07-27 01:44:55.48909
683	Cristobal	Soto	1195	2016-07-27 01:44:55.498279	2016-07-27 01:44:55.498279
684	Patricio	Contreras	1196	2016-07-27 01:45:20.876387	2016-07-27 01:45:20.876387
685	Alfonso	Merida	1197	2016-07-27 01:45:20.885201	2016-07-27 01:45:20.885201
686	Matias 	Casas	1198	2016-07-27 01:45:20.894273	2016-07-27 01:45:20.894273
687	Juan	Hart	1199	2016-07-27 01:45:20.903262	2016-07-27 01:45:20.903262
688	John	Frusciante	1200	2016-07-27 01:45:20.911465	2016-07-27 01:45:20.911465
689	Antonio	Varela	1201	2016-07-27 01:45:46.225895	2016-07-27 01:45:46.225895
690	Ignacia	Azcarraga	1202	2016-07-27 01:45:46.234201	2016-07-27 01:45:46.234201
691	Pedro	Alessandri	1203	2016-07-27 01:45:46.242506	2016-07-27 01:45:46.242506
692	Juan 	Labbe	1204	2016-07-27 01:45:46.251618	2016-07-27 01:45:46.251618
693	Benjamin	Button	1205	2016-07-27 01:45:46.259551	2016-07-27 01:45:46.259551
694	Diego	Brown	1206	2016-07-27 01:46:18.338926	2016-07-27 01:46:18.338926
695	Sebastian	Correa	1207	2016-07-27 01:46:18.349046	2016-07-27 01:46:18.349046
696	Camila	Reyes	1208	2016-07-27 01:46:18.357769	2016-07-27 01:46:18.357769
697	Carolina	Sobarzo	1209	2016-07-27 01:46:18.366416	2016-07-27 01:46:18.366416
698	Felipe	morales	1210	2016-07-27 01:46:18.374718	2016-07-27 01:46:18.374718
699	Pedro	Fuentealba	1211	2016-07-27 01:47:33.516162	2016-07-27 01:47:33.516162
700	Catalina	Carvajal	1212	2016-07-27 01:47:33.526815	2016-07-27 01:47:33.526815
701	Catalina	Edwards	1213	2016-07-27 01:47:33.535761	2016-07-27 01:47:33.535761
702	Luis	Correa	1214	2016-07-27 01:47:33.545907	2016-07-27 01:47:33.545907
703	Antonio	Lopez	1215	2016-07-27 01:47:33.555264	2016-07-27 01:47:33.555264
704	Osvaldo	Pearce	1216	2016-07-27 01:48:12.160699	2016-07-27 01:48:12.160699
705	Bruno 	estrella	1217	2016-07-27 01:48:12.170081	2016-07-27 01:48:12.170081
706	Sebastian	piñera	1218	2016-07-27 01:48:12.179331	2016-07-27 01:48:12.179331
707	Juan	Carcamo	1219	2016-07-27 01:48:12.187773	2016-07-27 01:48:12.187773
708	Antonio	Perez	1220	2016-07-27 01:48:12.19653	2016-07-27 01:48:12.19653
709	Macarena	Valdes	1221	2016-07-27 01:48:51.173673	2016-07-27 01:48:51.173673
710	Sebastian	Harry	1222	2016-07-27 01:48:51.182442	2016-07-27 01:48:51.182442
711	Mariano	Valladeras	1223	2016-07-27 01:48:51.191261	2016-07-27 01:48:51.191261
712	Antonio	Banderas	1224	2016-07-27 01:48:51.199812	2016-07-27 01:48:51.199812
713	John	Smith	1225	2016-07-27 01:48:51.20962	2016-07-27 01:48:51.20962
714	Jaime	Melendez	1226	2016-07-27 01:49:33.061202	2016-07-27 01:49:33.061202
715	Diego	Rojas	1227	2016-07-27 01:49:33.070467	2016-07-27 01:49:33.070467
716	Esteban 	Parrestes	1228	2016-07-27 01:49:33.081373	2016-07-27 01:49:33.081373
717	Keith	Moon	1229	2016-07-27 01:49:33.096272	2016-07-27 01:49:33.096272
718	Nano	Stern	1230	2016-07-27 01:49:33.107662	2016-07-27 01:49:33.107662
719	Julio	Pelserner	2001	2016-07-27 01:53:21.738499	2016-07-27 01:53:21.738499
720	Pedro	Lopez	2002	2016-07-27 01:53:21.746951	2016-07-27 01:53:21.746951
721	Juan	Parra	2003	2016-07-27 01:53:21.754335	2016-07-27 01:53:21.754335
722	Pedro	Socias	2004	2016-07-27 01:53:21.762642	2016-07-27 01:53:21.762642
723	Carlos	Campos	2005	2016-07-27 01:53:21.77022	2016-07-27 01:53:21.77022
724	Juanjo	Navia	2006	2016-07-27 01:54:45.520692	2016-07-27 01:54:45.520692
725	reinaldo	Mota	2007	2016-07-27 01:54:45.530564	2016-07-27 01:54:45.530564
726	Arturo	Soto	2008	2016-07-27 01:54:45.540725	2016-07-27 01:54:45.540725
727	Jorge	Vidal	2009	2016-07-27 01:54:45.549142	2016-07-27 01:54:45.549142
728	Jaime	Zamorano	2010	2016-07-27 01:54:45.558322	2016-07-27 01:54:45.558322
729	Juan	Castro	1111	2016-07-27 01:57:33.32906	2016-07-27 01:57:33.32906
730	Pedro	Lopez	1112	2016-07-27 01:57:33.337438	2016-07-27 01:57:33.337438
731	Juan	Guarello	1113	2016-07-27 01:57:33.345413	2016-07-27 01:57:33.345413
732	Gustavo	Tapia	1114	2016-07-27 01:57:33.353356	2016-07-27 01:57:33.353356
733	Felipe	Salazar	1115	2016-07-27 01:57:33.361325	2016-07-27 01:57:33.361325
734	Osvaldo	Gonzalez	1116	2016-07-27 01:58:39.484811	2016-07-27 01:58:39.484811
735	Eduardo	Vargas	1117	2016-07-27 01:58:39.494466	2016-07-27 01:58:39.494466
736	Marcelo	Diaz	1118	2016-07-27 01:58:39.502448	2016-07-27 01:58:39.502448
737	Jose	Rojas	1119	2016-07-27 01:58:39.51029	2016-07-27 01:58:39.51029
738	Sebastian	Martinez	1120	2016-07-27 01:58:39.518917	2016-07-27 01:58:39.518917
739	Carolina	Vasquez	1126	2016-07-27 01:59:05.005508	2016-07-27 01:59:05.005508
740	Paula	Pinochet	1127	2016-07-27 01:59:05.01439	2016-07-27 01:59:05.01439
741	Pablo	Gonzalez	1128	2016-07-27 01:59:05.024433	2016-07-27 01:59:05.024433
742	Nicolas	Tapia	1129	2016-07-27 01:59:05.037001	2016-07-27 01:59:05.037001
743	Alejandro 	Gomez	1130	2016-07-27 01:59:05.047708	2016-07-27 01:59:05.047708
744	Lorenzo	reyes	1121	2016-07-27 02:03:30.263058	2016-07-27 02:03:30.263058
745	Gaston	Fernandez	1122	2016-07-27 02:03:30.271063	2016-07-27 02:03:30.271063
746	Ramon	Fernandez	1123	2016-07-27 02:03:30.278477	2016-07-27 02:03:30.278477
747	Nelson	Rebolledo	1124	2016-07-27 02:03:30.286481	2016-07-27 02:03:30.286481
748	Juan 	Abarca	1125	2016-07-27 02:03:30.294311	2016-07-27 02:03:30.294311
749	Diego	Mendez	1131	2016-07-27 02:04:20.589152	2016-07-27 02:04:20.589152
750	Gaston	Arriagada	1132	2016-07-27 02:04:20.597867	2016-07-27 02:04:20.597867
751	Fabian	Piedra	1133	2016-07-27 02:04:20.606263	2016-07-27 02:04:20.606263
752	Sebastian	Zuñiga	1134	2016-07-27 02:04:20.614267	2016-07-27 02:04:20.614267
753	Diego	Prado	1135	2016-07-27 02:04:20.622588	2016-07-27 02:04:20.622588
754	Agustin	Parra	1136	2016-07-27 02:04:51.841898	2016-07-27 02:04:51.841898
755	Pedro 	Morales	1137	2016-07-27 02:04:51.851083	2016-07-27 02:04:51.851083
756	Augusto	Maldonado	1138	2016-07-27 02:04:51.862573	2016-07-27 02:04:51.862573
757	Claudio	Maldonado	1139	2016-07-27 02:04:51.87122	2016-07-27 02:04:51.87122
758	Maria	pardo	1140	2016-07-27 02:04:51.879603	2016-07-27 02:04:51.879603
759	Leonor	Varela	1141	2016-07-27 02:05:29.389593	2016-07-27 02:05:29.389593
760	Sebastian	Lopez	1142	2016-07-27 02:05:29.398403	2016-07-27 02:05:29.398403
761	Alvaro	Salazar	1143	2016-07-27 02:05:29.406248	2016-07-27 02:05:29.406248
762	Juan	Zeiner	1144	2016-07-27 02:05:29.41512	2016-07-27 02:05:29.41512
763	Julio	Irving	1145	2016-07-27 02:05:29.422582	2016-07-27 02:05:29.422582
764	xin	xon	1146	2016-07-27 02:06:13.740641	2016-07-27 02:06:13.740641
765	Alfredo	Fuentes	1147	2016-07-27 02:06:13.749739	2016-07-27 02:06:13.749739
766	Osvaldo	Jimenez	1148	2016-07-27 02:06:13.759345	2016-07-27 02:06:13.759345
767	Diego	Panza	1149	2016-07-27 02:06:13.768909	2016-07-27 02:06:13.768909
768	Cristian	Salamanca	1150	2016-07-27 02:06:13.780003	2016-07-27 02:06:13.780003
769	Martina	Bustos	1151	2016-07-27 02:06:51.610342	2016-07-27 02:06:51.610342
770	Paula	Justiniano	1152	2016-07-27 02:06:51.619122	2016-07-27 02:06:51.619122
771	Carolina	Bolados	1153	2016-07-27 02:06:51.62687	2016-07-27 02:06:51.62687
772	Cristina	Fernandez	1154	2016-07-27 02:06:51.634378	2016-07-27 02:06:51.634378
773	Juana	Rojas	1155	2016-07-27 02:06:51.641403	2016-07-27 02:06:51.641403
774	Ivan	Salas	1156	2016-07-27 02:07:44.298897	2016-07-27 02:07:44.298897
775	Kobe 	Bryant	1157	2016-07-27 02:07:44.307529	2016-07-27 02:07:44.307529
776	Steve 	Jobs	1158	2016-07-27 02:07:44.315346	2016-07-27 02:07:44.315346
777	Pedro	Diaz	1159	2016-07-27 02:07:44.323107	2016-07-27 02:07:44.323107
778	Octavio 	Riquero	1160	2016-07-27 02:07:44.330105	2016-07-27 02:07:44.330105
779	Fernando	Correa	1161	2016-07-27 02:08:33.104132	2016-07-27 02:08:33.104132
780	Valeria	Ferrat	1162	2016-07-27 02:08:33.113036	2016-07-27 02:08:33.113036
781	Michelle	Rojas	1163	2016-07-27 02:08:33.120927	2016-07-27 02:08:33.120927
782	Pamela	Lopez	1164	2016-07-27 02:08:33.128733	2016-07-27 02:08:33.128733
783	Jaime	Fuenzalida	1165	2016-07-27 02:08:33.136916	2016-07-27 02:08:33.136916
784	Rod	Stewart	1166	2016-07-27 02:09:12.410373	2016-07-27 02:09:12.410373
785	Roberto	Piñera	1167	2016-07-27 02:09:12.419261	2016-07-27 02:09:12.419261
786	Bruce	Lee	1168	2016-07-27 02:09:12.427103	2016-07-27 02:09:12.427103
787	Brian	Keith	1169	2016-07-27 02:09:12.434555	2016-07-27 02:09:12.434555
788	Arantza 	Castro	1170	2016-07-27 02:09:12.44206	2016-07-27 02:09:12.44206
789	Rod	Stewart	1166	2016-07-27 02:10:10.090419	2016-07-27 02:10:10.090419
790	Roberto	Piñera	1167	2016-07-27 02:10:10.098323	2016-07-27 02:10:10.098323
791	Bruce	Lee	1168	2016-07-27 02:10:10.106797	2016-07-27 02:10:10.106797
792	Brian	Keith	1169	2016-07-27 02:10:10.113843	2016-07-27 02:10:10.113843
793	Arantza 	Castro	1170	2016-07-27 02:10:10.121279	2016-07-27 02:10:10.121279
794	juan	Balmaceda	1176	2016-07-27 02:10:48.198735	2016-07-27 02:10:48.198735
795	Pedro	Montt	1177	2016-07-27 02:10:48.207126	2016-07-27 02:10:48.207126
796	ramiro	franco	1178	2016-07-27 02:10:48.214407	2016-07-27 02:10:48.214407
797	Ernesto	Gomez	1179	2016-07-27 02:10:48.222493	2016-07-27 02:10:48.222493
798	Juan	Bolados	1180	2016-07-27 02:10:48.229342	2016-07-27 02:10:48.229342
799	Felipe	Camiroaga	1181	2016-07-27 02:12:41.022429	2016-07-27 02:12:41.022429
800	Jose	 Viñuela	1182	2016-07-27 02:12:41.031342	2016-07-27 02:12:41.031342
801	Pedro	Henriquez	1183	2016-07-27 02:12:41.039123	2016-07-27 02:12:41.039123
802	Monica	Salinas	1184	2016-07-27 02:12:41.0463	2016-07-27 02:12:41.0463
803	Larry	Chang	1185	2016-07-27 02:12:41.053847	2016-07-27 02:12:41.053847
804	martin	carrizo	1186	2016-07-27 02:13:14.030926	2016-07-27 02:13:14.030926
805	dinesh	morales	1187	2016-07-27 02:13:14.039515	2016-07-27 02:13:14.039515
806	jesus	gripe	1188	2016-07-27 02:13:14.047394	2016-07-27 02:13:14.047394
807	giancarlo	lopez	1189	2016-07-27 02:13:14.055118	2016-07-27 02:13:14.055118
808	placido	domingo	1190	2016-07-27 02:13:14.063221	2016-07-27 02:13:14.063221
809	Thalia	Lopez	1191	2016-07-27 02:13:48.262969	2016-07-27 02:13:48.262969
810	Guillermo	Cuadrado	1192	2016-07-27 02:13:48.270926	2016-07-27 02:13:48.270926
811	Javier	Devia	1193	2016-07-27 02:13:48.279493	2016-07-27 02:13:48.279493
812	Tomas	Puentes	1194	2016-07-27 02:13:48.287192	2016-07-27 02:13:48.287192
813	Cristobal	Soto	1195	2016-07-27 02:13:48.295817	2016-07-27 02:13:48.295817
814	Patricio	Contreras	1196	2016-07-27 02:14:41.532325	2016-07-27 02:14:41.532325
815	Alfonso	Merida	1197	2016-07-27 02:14:41.541329	2016-07-27 02:14:41.541329
816	Matias 	Casas	1198	2016-07-27 02:14:41.54954	2016-07-27 02:14:41.54954
817	Juan	Hart	1199	2016-07-27 02:14:41.558543	2016-07-27 02:14:41.558543
818	John	Frusciante	1200	2016-07-27 02:14:41.56631	2016-07-27 02:14:41.56631
819	Antonio	Varela	1201	2016-07-27 02:15:22.235468	2016-07-27 02:15:22.235468
820	Ignacia	Azcarraga	1202	2016-07-27 02:15:22.244632	2016-07-27 02:15:22.244632
821	Pedro	Alessandri	1203	2016-07-27 02:15:22.253237	2016-07-27 02:15:22.253237
822	Juan 	Labbe	1204	2016-07-27 02:15:22.260599	2016-07-27 02:15:22.260599
823	Benjamin	Button	1205	2016-07-27 02:15:22.269173	2016-07-27 02:15:22.269173
824	Antonio	Varela	1201	2016-07-27 02:15:22.60807	2016-07-27 02:15:22.60807
825	Ignacia	Azcarraga	1202	2016-07-27 02:15:22.615829	2016-07-27 02:15:22.615829
826	Pedro	Alessandri	1203	2016-07-27 02:15:22.62437	2016-07-27 02:15:22.62437
827	Juan 	Labbe	1204	2016-07-27 02:15:22.632911	2016-07-27 02:15:22.632911
828	Benjamin	Button	1205	2016-07-27 02:15:22.641041	2016-07-27 02:15:22.641041
829	Diego	Brown	1206	2016-07-27 02:16:01.239538	2016-07-27 02:16:01.239538
830	Sebastian	Correa	1207	2016-07-27 02:16:01.248459	2016-07-27 02:16:01.248459
831	Camila	Reyes	1208	2016-07-27 02:16:01.25649	2016-07-27 02:16:01.25649
832	Carolina	Sobarzo	1209	2016-07-27 02:16:01.264807	2016-07-27 02:16:01.264807
833	Felipe	morales	1210	2016-07-27 02:16:01.272505	2016-07-27 02:16:01.272505
834	Pedro	Fuentealba	1211	2016-07-27 02:16:25.633522	2016-07-27 02:16:25.633522
835	Catalina	Carvajal	1212	2016-07-27 02:16:25.642971	2016-07-27 02:16:25.642971
836	Catalina	Edwards	1213	2016-07-27 02:16:25.650385	2016-07-27 02:16:25.650385
837	Luis	Correa	1214	2016-07-27 02:16:25.658354	2016-07-27 02:16:25.658354
838	Antonio	Lopez	1215	2016-07-27 02:16:25.665891	2016-07-27 02:16:25.665891
839	Osvaldo	Pearce	1216	2016-07-27 02:17:23.107575	2016-07-27 02:17:23.107575
840	Bruno 	estrella	1217	2016-07-27 02:17:23.117547	2016-07-27 02:17:23.117547
841	Sebastian	piñera	1218	2016-07-27 02:17:23.126233	2016-07-27 02:17:23.126233
842	Juan	Carcamo	1219	2016-07-27 02:17:23.134009	2016-07-27 02:17:23.134009
843	Antonio	Perez	1220	2016-07-27 02:17:23.141278	2016-07-27 02:17:23.141278
845	pepe	pecas	123	2016-07-27 18:54:12.439773	2016-07-27 18:54:12.439773
846	ddd	fff	123	2016-07-27 18:54:54.275759	2016-07-27 18:54:54.275759
847	lol	lel	lal	2016-07-27 19:04:01.42238	2016-07-27 19:04:01.42238
848	pepe	flores	12345AS	2016-07-27 19:05:01.549212	2016-07-27 19:05:01.549212
849	pepe	flores	RRRS	2016-07-27 19:09:41.155309	2016-07-27 19:09:41.155309
850	pepe	flores	RUTNEW123	2016-07-27 19:10:20.49458	2016-07-27 19:10:20.49458
851	sadasd	rwerer	rimposible1234	2016-07-27 19:18:15.359062	2016-07-27 19:18:15.359062
852	imposible	lele	rimposi1	2016-07-27 19:19:12.22801	2016-07-27 19:19:12.22801
853	imposisi	lala	rimposi2	2016-07-27 19:19:12.243753	2016-07-27 19:19:12.243753
854	ddddd	dad	eeee	2016-07-27 19:21:03.548226	2016-07-27 19:21:03.548226
855	sadsa	sadsad	231	2016-07-27 19:22:00.103413	2016-07-27 19:22:00.103413
856	sadsa	sadsad	xxxx	2016-07-27 19:25:26.902369	2016-07-27 19:25:26.902369
857	ddd	sss	yyyy	2016-07-27 19:25:56.227078	2016-07-27 19:25:56.227078
858	ddd	sss	sesese	2016-07-27 19:26:22.996811	2016-07-27 19:26:22.996811
859	ewewew	ffff	fasd232	2016-07-27 19:34:10.582221	2016-07-27 19:34:10.582221
861	TESTA	TESTA	122133	2016-07-27 19:35:10.687624	2016-07-27 19:35:10.687624
863	Test	Testin	20	2016-08-03 17:47:51.364875	2016-08-03 17:47:51.364875
865	Test	Testin	33	2016-08-03 17:47:51.519538	2016-08-03 17:47:51.519538
866	Test	Testin	34	2016-08-03 17:47:51.533396	2016-08-03 17:47:51.533396
867	Test	Testin	35	2016-08-03 17:47:51.547228	2016-08-03 17:47:51.547228
868	Test	Testin	36	2016-08-03 17:47:51.560852	2016-08-03 17:47:51.560852
869	Test	Testin	37	2016-08-03 17:47:51.577184	2016-08-03 17:47:51.577184
870	Test	Testin	38	2016-08-03 17:47:51.592898	2016-08-03 17:47:51.592898
871	Test	Testin	39	2016-08-03 17:47:51.60813	2016-08-03 17:47:51.60813
872	Test	Testin	40	2016-08-03 17:47:51.620836	2016-08-03 17:47:51.620836
873	Test	Testin	41	2016-08-03 17:47:51.634845	2016-08-03 17:47:51.634845
874	Test	Testin	42	2016-08-03 17:47:51.64728	2016-08-03 17:47:51.64728
875	Test	Testin	43	2016-08-03 17:47:51.661904	2016-08-03 17:47:51.661904
876	Test	Testin	44	2016-08-03 17:47:51.676116	2016-08-03 17:47:51.676116
877	Test	Testin	45	2016-08-03 17:47:51.689602	2016-08-03 17:47:51.689602
864	Test2	Testin3	32	2016-08-03 17:47:51.505362	2016-08-03 17:50:50.334605
\.


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('students_id_seq', 877, true);


--
-- Data for Name: taggings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY taggings (id, tag_id, taggable_id, taggable_type, tagger_id, tagger_type, context, created_at) FROM stdin;
1	1	1	FroalaImage	\N	\N	tags	2016-04-21 02:25:54.523316
2	2	1	FroalaImage	\N	\N	tags	2016-04-21 02:25:54.533499
3	2	2	FroalaImage	\N	\N	tags	2016-04-21 02:26:38.206839
4	3	3	FroalaImage	\N	\N	tags	2016-04-21 02:26:59.71444
5	4	4	FroalaImage	\N	\N	tags	2016-04-21 02:27:37.82641
6	5	5	FroalaImage	\N	\N	tags	2016-04-21 02:51:28.822265
7	6	6	FroalaImage	\N	\N	tags	2016-04-21 02:55:32.947511
8	2	7	FroalaImage	\N	\N	tags	2016-04-21 04:01:19.613859
9	7	7	FroalaImage	\N	\N	tags	2016-04-21 04:01:19.619377
\.


--
-- Name: taggings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('taggings_id_seq', 9, true);


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tags (id, name, taggings_count) FROM stdin;
1	lapiz	1
3	grafico	1
4	grafico2	1
5	subs	1
6	gg	1
2	lenguaje	3
7	escritura	1
\.


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 7, true);


--
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY units (id, assignature_id, level_id, numero, descripcion, created_at, updated_at) FROM stdin;
1	1	1	1		2015-12-02 17:44:03.367619	2015-12-02 17:44:03.367619
2	1	1	2		2015-12-02 17:44:03.381467	2015-12-02 17:44:03.381467
3	1	1	3		2015-12-02 17:44:03.390876	2015-12-02 17:44:03.390876
4	1	1	4		2015-12-02 17:44:03.399991	2015-12-02 17:44:03.399991
6	2	2	1		2015-12-27 04:12:38.740872	2015-12-27 04:12:38.740872
7	3	7	1		2016-05-02 05:05:47.269177	2016-05-02 05:05:47.269177
8	2	1	m1	UNIDAD 1 MATE PRIMERO	2016-06-29 12:04:45.427234	2016-06-29 12:04:45.427234
\.


--
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('units_id_seq', 8, true);


--
-- Data for Name: user_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_types (id, name, role, code, is_active, created_at, updated_at) FROM stdin;
1	Administrador	admin	ADMINISTRADOR	t	2016-07-23 09:21:46.550405	2016-07-23 09:21:46.550405
2	General	admin	GENERAL	t	2016-07-23 09:21:46.553487	2016-07-23 09:21:46.553487
3	Recaudación	admin	RECAUDACION	t	2016-07-23 09:21:46.55566	2016-07-23 09:21:46.55566
4	Evaluación	admin	EVALUACION	t	2016-07-23 09:21:46.557711	2016-07-23 09:21:46.557711
5	Pruebas	admin	PRUEBAS	t	2016-07-23 09:21:46.559666	2016-07-23 09:21:46.559666
10	Utp	client	UTP	t	2016-06-10 06:57:03.8934	2016-06-13 07:45:05.415573
9	Profesor	client	PROFESOR	t	2016-06-10 06:57:03.876722	2016-06-13 09:01:00.742693
8	Director	client	DIRECTOR	t	2016-06-10 06:57:03.860126	2016-06-13 09:01:10.790449
6	Daem	client	DAEM	t	2016-06-10 06:57:03.789322	2016-06-13 09:01:27.35034
7	Cobranza	client	COBRANZA	t	2016-06-10 06:57:03.837972	2016-06-13 09:01:36.062242
11	Retros	admin	RETROS	t	2016-07-28 07:21:13.958585	2016-07-28 07:21:13.958585
\.


--
-- Name: user_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_types_id_seq', 11, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, first_name, second_name, user_type_id, tel) FROM stdin;
37	daem@prueba.com	$2a$10$CqewLBQp7eIsGeTJNMQJ9OvQtFysK29Zs8.ttY4f6CC96gdoyS20K	\N	\N	\N	0	\N	\N	\N	\N	2016-08-08 17:21:12.180627	2016-08-08 17:21:12.180627	DAEM DE PRUEBA	Apellido daem	6	213421312
40	gllermaly2@walla.com	$2a$10$hL6rC8ktHbJXXKR4acu/cuDWXrUV2Y/t.ED7j0qJOLyOJTaDT3CAK	\N	\N	\N	0	\N	\N	\N	\N	2016-08-08 19:10:29.420739	2016-08-08 19:10:29.420739	Gustavo	Llermaly	\N	\N
41	mail@mailazo.com	$2a$10$Inh8VW5BvsYXTlx4FUGXyOJhBrwsPWFQfrzFmZjKDaU5KMHwm04de	\N	\N	\N	0	\N	\N	\N	\N	2016-08-08 23:13:40.729419	2016-08-08 23:13:40.729419	pepe	pecas	11	\N
46	result@result.com	$2a$10$RBULSR86HtCefoLkiNCpmuBpYH85yvREmIIte47PIqwYII3CDEURG	\N	\N	\N	0	\N	\N	\N	\N	2016-08-09 00:10:32.844251	2016-08-09 00:10:32.844251	resultador	.	10	21312312
47	fact@fact.com	$2a$10$OVRlGwp5/FoMsdVWwd7LlOoD7071xJGeW8UG4EpaZSNa2Foj9ZEdi	\N	\N	\N	0	\N	\N	\N	\N	2016-08-09 00:10:33.036627	2016-08-09 00:10:33.036627	facturador	.	7	21313213
33	director@americano.cl	$2a$10$2f4ov/8B0oSZprSFNeVXw.erGLnIxOF3pXzEcdxAsEUyWPw9r5/9e	\N	\N	\N	0	\N	\N	\N	\N	2016-08-07 00:21:46.09432	2016-08-07 00:21:46.09432	Director	Americano	8	2231514561
45	evalua@evalua.com	$2a$10$in2rwo3//.hKfB7LCkgkVOgDDdBDeEaDJhApYdBt6bEPPC0AmM07O	\N	\N	\N	1	2016-08-09 00:12:01.336937	2016-08-09 00:12:01.336937	10.0.2.2	10.0.2.2	2016-08-09 00:10:32.622405	2016-08-09 00:12:01.339197	Evaluador	.	8	213213213
34	utp@americano.cl	$2a$10$94q9dHzueRTF4JQIWrIrtO5fpLvR89jparHNaogXHAmZ5uch3FRXG	\N	\N	\N	0	\N	\N	\N	\N	2016-08-07 00:21:46.148497	2016-08-07 00:21:46.148497	UTP	Americano	10	65656523
35	directordedirectores@ad.com	$2a$10$6NtiMgBF/kZpbndDL3ivzOnwSLDtGaxrLsVo3aKNPmRjgvOwG4WTu	\N	\N	\N	0	\N	\N	\N	\N	2016-08-07 05:19:05.103165	2016-08-07 05:19:05.103165	Test Director	Directors	8	234213213
31	admin@reimagina.cl	$2a$10$.suxr.R2SFxDHK8yNnhHMe/opizrub042MeD3WMhhecVZr/REA8V6	\N	\N	\N	6	2016-08-09 00:13:51.280823	2016-08-08 18:22:45.232351	10.0.2.2	10.0.2.2	2016-08-07 00:12:18.748121	2016-08-09 00:13:51.283766	administrador	reimagina	1	\N
36	profe@rebelde.com	$2a$10$FesJkvLDpuBE0sRDnOfDAuA5sTRsFi5D2SKWzk4772VighGh6Afza	\N	\N	\N	0	\N	\N	\N	\N	2016-08-07 06:58:54.955677	2016-08-07 06:58:54.955677	Profe rebelde	Apellido rebelde	9	2313213
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_id_seq', 47, true);


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users_roles (user_id, role_id) FROM stdin;
5	4
31	5
33	11
34	13
35	11
36	12
37	9
41	18
45	11
46	13
47	10
\.


--
-- Name: ability_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY ability_contents
    ADD CONSTRAINT ability_contents_pkey PRIMARY KEY (id);


--
-- Name: alternatives_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY alternatives
    ADD CONSTRAINT alternatives_pkey PRIMARY KEY (id);


--
-- Name: answers_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: assignature_abilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY assignature_abilities
    ADD CONSTRAINT assignature_abilities_pkey PRIMARY KEY (id);


--
-- Name: assignatures_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY assignatures
    ADD CONSTRAINT assignatures_pkey PRIMARY KEY (id);


--
-- Name: assigned_schools_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY assigned_schools
    ADD CONSTRAINT assigned_schools_pkey PRIMARY KEY (id);


--
-- Name: axes_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY axes_contents
    ADD CONSTRAINT axes_contents_pkey PRIMARY KEY (id);


--
-- Name: axes_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY axes
    ADD CONSTRAINT axes_pkey PRIMARY KEY (id);


--
-- Name: axis_programs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY axis_programs
    ADD CONSTRAINT axis_programs_pkey PRIMARY KEY (id);


--
-- Name: bloom_abilities_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY bloom_abilities
    ADD CONSTRAINT bloom_abilities_pkey PRIMARY KEY (id);


--
-- Name: buy_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY buy_orders
    ADD CONSTRAINT buy_orders_pkey PRIMARY KEY (id);


--
-- Name: color_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY color_ranges
    ADD CONSTRAINT color_ranges_pkey PRIMARY KEY (id);


--
-- Name: communes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY communes
    ADD CONSTRAINT communes_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: contents_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY contents
    ADD CONSTRAINT contents_pkey PRIMARY KEY (id);


--
-- Name: difficulty_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY difficulty_levels
    ADD CONSTRAINT difficulty_levels_pkey PRIMARY KEY (id);


--
-- Name: evaluation_types_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY evaluation_types
    ADD CONSTRAINT evaluation_types_pkey PRIMARY KEY (id);


--
-- Name: evaluations_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY evaluations
    ADD CONSTRAINT evaluations_pkey PRIMARY KEY (id);


--
-- Name: fact_status_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fact_status_types
    ADD CONSTRAINT fact_status_types_pkey PRIMARY KEY (id);


--
-- Name: fact_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fact_statuses
    ADD CONSTRAINT fact_statuses_pkey PRIMARY KEY (id);


--
-- Name: feed_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY feed_forms
    ADD CONSTRAINT feed_forms_pkey PRIMARY KEY (id);


--
-- Name: feed_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY feed_items
    ADD CONSTRAINT feed_items_pkey PRIMARY KEY (id);


--
-- Name: feed_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY feed_scores
    ADD CONSTRAINT feed_scores_pkey PRIMARY KEY (id);


--
-- Name: feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: froala_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY froala_images
    ADD CONSTRAINT froala_images_pkey PRIMARY KEY (id);


--
-- Name: grades_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: group_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY group_questions
    ADD CONSTRAINT group_questions_pkey PRIMARY KEY (id);


--
-- Name: guides_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY guides
    ADD CONSTRAINT guides_pkey PRIMARY KEY (id);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: instrument_alternatives_positions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY instrument_alternatives_positions
    ADD CONSTRAINT instrument_alternatives_positions_pkey PRIMARY KEY (id);


--
-- Name: instrument_proccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY instrument_proccesses
    ADD CONSTRAINT instrument_proccesses_pkey PRIMARY KEY (id);


--
-- Name: instrument_questions_positions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY instrument_questions_positions
    ADD CONSTRAINT instrument_questions_positions_pkey PRIMARY KEY (id);


--
-- Name: instruments_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY instruments
    ADD CONSTRAINT instruments_pkey PRIMARY KEY (id);


--
-- Name: invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: learning_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY learning_goals
    ADD CONSTRAINT learning_goals_pkey PRIMARY KEY (id);


--
-- Name: levels_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY levels
    ADD CONSTRAINT levels_pkey PRIMARY KEY (id);


--
-- Name: order_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY order_statuses
    ADD CONSTRAINT order_statuses_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payments_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: pme_abilities_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY pme_abilities
    ADD CONSTRAINT pme_abilities_pkey PRIMARY KEY (id);


--
-- Name: proc_type_fathers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proc_type_fathers
    ADD CONSTRAINT proc_type_fathers_pkey PRIMARY KEY (id);


--
-- Name: proc_types_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY proc_types
    ADD CONSTRAINT proc_types_pkey PRIMARY KEY (id);


--
-- Name: proccess_instruments_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY proccess_instruments
    ADD CONSTRAINT proccess_instruments_pkey PRIMARY KEY (id);


--
-- Name: proccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY proccesses
    ADD CONSTRAINT proccesses_pkey PRIMARY KEY (id);


--
-- Name: program_axis_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY program_axis
    ADD CONSTRAINT program_axis_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: remedials_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY remedials
    ADD CONSTRAINT remedials_pkey PRIMARY KEY (id);


--
-- Name: reports_bypasses_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY reports_bypasses
    ADD CONSTRAINT reports_bypasses_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schools_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (id);


--
-- Name: status_types_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY status_types
    ADD CONSTRAINT status_types_pkey PRIMARY KEY (id);


--
-- Name: students_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: units_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: user_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_types
    ADD CONSTRAINT user_types_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_ability_contents_on_pme_ability_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_ability_contents_on_pme_ability_id ON ability_contents USING btree (pme_ability_id);


--
-- Name: index_alternatives_on_question_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_alternatives_on_question_id ON alternatives USING btree (question_id);


--
-- Name: index_answers_on_proccess_instrument_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_answers_on_proccess_instrument_id ON answers USING btree (proccess_instrument_id);


--
-- Name: index_answers_on_question_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_answers_on_question_id ON answers USING btree (question_id);


--
-- Name: index_answers_on_student_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_answers_on_student_id ON answers USING btree (student_id);


--
-- Name: index_assignature_abilities_on_assignature_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_assignature_abilities_on_assignature_id ON assignature_abilities USING btree (assignature_id);


--
-- Name: index_axes_contents_on_axis_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_axes_contents_on_axis_id ON axes_contents USING btree (axis_id);


--
-- Name: index_axes_on_assignature_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_axes_on_assignature_id ON axes USING btree (assignature_id);


--
-- Name: index_axis_programs_on_assignature_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_axis_programs_on_assignature_id ON axis_programs USING btree (assignature_id);


--
-- Name: index_buy_orders_on_order_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_buy_orders_on_order_id ON buy_orders USING btree (order_id);


--
-- Name: index_color_ranges_on_assignature_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_color_ranges_on_assignature_id ON color_ranges USING btree (assignature_id);


--
-- Name: index_color_ranges_on_evaluation_type_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_color_ranges_on_evaluation_type_id ON color_ranges USING btree (evaluation_type_id);


--
-- Name: index_color_ranges_on_level_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_color_ranges_on_level_id ON color_ranges USING btree (level_id);


--
-- Name: index_communes_on_region_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_communes_on_region_id ON communes USING btree (region_id);


--
-- Name: index_contents_on_assignature_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_contents_on_assignature_id ON contents USING btree (assignature_id);


--
-- Name: index_evaluations_on_assignature_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_evaluations_on_assignature_id ON evaluations USING btree (assignature_id);


--
-- Name: index_evaluations_on_evaluation_type_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_evaluations_on_evaluation_type_id ON evaluations USING btree (evaluation_type_id);


--
-- Name: index_evaluations_on_level_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_evaluations_on_level_id ON evaluations USING btree (level_id);


--
-- Name: index_fact_statuses_on_fact_status_type_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_fact_statuses_on_fact_status_type_id ON fact_statuses USING btree (fact_status_type_id);


--
-- Name: index_fact_statuses_on_order_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_fact_statuses_on_order_id ON fact_statuses USING btree (order_id);


--
-- Name: index_feed_forms_on_feed_item_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_feed_forms_on_feed_item_id ON feed_forms USING btree (feed_item_id);


--
-- Name: index_feed_forms_on_feed_score_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_feed_forms_on_feed_score_id ON feed_forms USING btree (feed_score_id);


--
-- Name: index_feed_forms_on_feedback_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_feed_forms_on_feedback_id ON feed_forms USING btree (feedback_id);


--
-- Name: index_feedbacks_on_order_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_feedbacks_on_order_id ON feedbacks USING btree (order_id);


--
-- Name: index_grades_on_level_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_grades_on_level_id ON grades USING btree (level_id);


--
-- Name: index_guides_on_alternative_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_guides_on_alternative_id ON guides USING btree (alternative_id);


--
-- Name: index_guides_on_instrument_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_guides_on_instrument_id ON guides USING btree (instrument_id);


--
-- Name: index_guides_on_question_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_guides_on_question_id ON guides USING btree (question_id);


--
-- Name: index_instrument_alternatives_positions_on_alternative_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_instrument_alternatives_positions_on_alternative_id ON instrument_alternatives_positions USING btree (alternative_id);


--
-- Name: index_instrument_alternatives_positions_on_instrument_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_instrument_alternatives_positions_on_instrument_id ON instrument_alternatives_positions USING btree (instrument_id);


--
-- Name: index_instrument_alternatives_positions_on_question_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_instrument_alternatives_positions_on_question_id ON instrument_alternatives_positions USING btree (question_id);


--
-- Name: index_instrument_proccesses_on_instrument_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_instrument_proccesses_on_instrument_id ON instrument_proccesses USING btree (instrument_id);


--
-- Name: index_instrument_proccesses_on_proccess_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_instrument_proccesses_on_proccess_id ON instrument_proccesses USING btree (proccess_id);


--
-- Name: index_instrument_questions_positions_on_instrument_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_instrument_questions_positions_on_instrument_id ON instrument_questions_positions USING btree (instrument_id);


--
-- Name: index_instrument_questions_positions_on_question_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_instrument_questions_positions_on_question_id ON instrument_questions_positions USING btree (question_id);


--
-- Name: index_instruments_on_evaluation_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_instruments_on_evaluation_id ON instruments USING btree (evaluation_id);


--
-- Name: index_learning_goals_on_assignature_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_learning_goals_on_assignature_id ON learning_goals USING btree (assignature_id);


--
-- Name: index_learning_goals_on_level_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_learning_goals_on_level_id ON learning_goals USING btree (level_id);


--
-- Name: index_learning_goals_units_on_learning_goal_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_learning_goals_units_on_learning_goal_id ON learning_goals_units USING btree (learning_goal_id);


--
-- Name: index_learning_goals_units_on_unit_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_learning_goals_units_on_unit_id ON learning_goals_units USING btree (unit_id);


--
-- Name: index_pme_abilities_on_assignature_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_pme_abilities_on_assignature_id ON pme_abilities USING btree (assignature_id);


--
-- Name: index_proc_types_on_proc_type_father_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_proc_types_on_proc_type_father_id ON proc_types USING btree (proc_type_father_id);


--
-- Name: index_proccess_instruments_on_grade_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_proccess_instruments_on_grade_id ON proccess_instruments USING btree (grade_id);


--
-- Name: index_program_axis_on_assignature_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_program_axis_on_assignature_id ON program_axis USING btree (assignature_id);


--
-- Name: index_questions_on_ability_content_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_ability_content_id ON questions USING btree (ability_content_id);


--
-- Name: index_questions_on_assignature_ability_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_assignature_ability_id ON questions USING btree (assignature_ability_id);


--
-- Name: index_questions_on_assignature_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_assignature_id ON questions USING btree (assignature_id);


--
-- Name: index_questions_on_axes_content_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_axes_content_id ON questions USING btree (axes_content_id);


--
-- Name: index_questions_on_axis_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_axis_id ON questions USING btree (axis_id);


--
-- Name: index_questions_on_axis_program_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_axis_program_id ON questions USING btree (axis_program_id);


--
-- Name: index_questions_on_bloom_ability_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_bloom_ability_id ON questions USING btree (bloom_ability_id);


--
-- Name: index_questions_on_content_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_content_id ON questions USING btree (content_id);


--
-- Name: index_questions_on_difficulty_level_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_difficulty_level_id ON questions USING btree (difficulty_level_id);


--
-- Name: index_questions_on_group_question_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_group_question_id ON questions USING btree (group_question_id);


--
-- Name: index_questions_on_learning_goal_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_learning_goal_id ON questions USING btree (learning_goal_id);


--
-- Name: index_questions_on_level_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_level_id ON questions USING btree (level_id);


--
-- Name: index_questions_on_pme_ability_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_pme_ability_id ON questions USING btree (pme_ability_id);


--
-- Name: index_questions_on_unit_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_questions_on_unit_id ON questions USING btree (unit_id);


--
-- Name: index_remedials_on_content_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_remedials_on_content_id ON remedials USING btree (content_id);


--
-- Name: index_remedials_on_level_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_remedials_on_level_id ON remedials USING btree (level_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_tags_on_name ON tags USING btree (name);


--
-- Name: index_units_on_assignature_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_units_on_assignature_id ON units USING btree (assignature_id);


--
-- Name: index_units_on_level_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_units_on_level_id ON units USING btree (level_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_user_type_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_users_on_user_type_id ON users USING btree (user_type_id);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: instrument_questions_position_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX instrument_questions_position_id ON instrument_alternatives_positions USING btree (instrument_questions_position_id);


--
-- Name: taggings_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX taggings_idx ON taggings USING btree (tag_id, taggable_id, taggable_type, context, tagger_id, tagger_type);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_02c86a38f2; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY color_ranges
    ADD CONSTRAINT fk_rails_02c86a38f2 FOREIGN KEY (level_id) REFERENCES levels(id);


--
-- Name: fk_rails_04efa60102; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY units
    ADD CONSTRAINT fk_rails_04efa60102 FOREIGN KEY (level_id) REFERENCES levels(id);


--
-- Name: fk_rails_0b49ca9d90; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY proccess_instruments
    ADD CONSTRAINT fk_rails_0b49ca9d90 FOREIGN KEY (grade_id) REFERENCES grades(id);


--
-- Name: fk_rails_1ab772ec18; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT fk_rails_1ab772ec18 FOREIGN KEY (level_id) REFERENCES levels(id);


--
-- Name: fk_rails_1d9ad574ed; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY instrument_questions_positions
    ADD CONSTRAINT fk_rails_1d9ad574ed FOREIGN KEY (instrument_id) REFERENCES instruments(id);


--
-- Name: fk_rails_23217941e0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY instrument_alternatives_positions
    ADD CONSTRAINT fk_rails_23217941e0 FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: fk_rails_2335129f4c; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY alternatives
    ADD CONSTRAINT fk_rails_2335129f4c FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: fk_rails_2530ad117a; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_2530ad117a FOREIGN KEY (axes_content_id) REFERENCES axes_contents(id);


--
-- Name: fk_rails_2a96bfa2a5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY buy_orders
    ADD CONSTRAINT fk_rails_2a96bfa2a5 FOREIGN KEY (order_id) REFERENCES orders(id);


--
-- Name: fk_rails_35567641de; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_35567641de FOREIGN KEY (bloom_ability_id) REFERENCES bloom_abilities(id);


--
-- Name: fk_rails_3694c38081; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY instruments
    ADD CONSTRAINT fk_rails_3694c38081 FOREIGN KEY (evaluation_id) REFERENCES evaluations(id);


--
-- Name: fk_rails_384361912b; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_384361912b FOREIGN KEY (axis_id) REFERENCES axes(id);


--
-- Name: fk_rails_3cca231822; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT fk_rails_3cca231822 FOREIGN KEY (student_id) REFERENCES students(id);


--
-- Name: fk_rails_3d5ed4418f; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT fk_rails_3d5ed4418f FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: fk_rails_3e239ef820; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY axes_contents
    ADD CONSTRAINT fk_rails_3e239ef820 FOREIGN KEY (axis_id) REFERENCES axes(id);


--
-- Name: fk_rails_43029f854a; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_43029f854a FOREIGN KEY (pme_ability_id) REFERENCES pme_abilities(id);


--
-- Name: fk_rails_494c3396a5; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY instrument_proccesses
    ADD CONSTRAINT fk_rails_494c3396a5 FOREIGN KEY (instrument_id) REFERENCES instruments(id);


--
-- Name: fk_rails_4d01a82830; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY remedials
    ADD CONSTRAINT fk_rails_4d01a82830 FOREIGN KEY (content_id) REFERENCES contents(id);


--
-- Name: fk_rails_4eca04bf5d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY feed_forms
    ADD CONSTRAINT fk_rails_4eca04bf5d FOREIGN KEY (feed_score_id) REFERENCES feed_scores(id);


--
-- Name: fk_rails_51625eb59c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY feed_forms
    ADD CONSTRAINT fk_rails_51625eb59c FOREIGN KEY (feed_item_id) REFERENCES feed_items(id);


--
-- Name: fk_rails_55632c0588; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY axes
    ADD CONSTRAINT fk_rails_55632c0588 FOREIGN KEY (assignature_id) REFERENCES assignatures(id);


--
-- Name: fk_rails_58c0eb7ada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY instrument_questions_positions
    ADD CONSTRAINT fk_rails_58c0eb7ada FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: fk_rails_5a9a7f536f; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY units
    ADD CONSTRAINT fk_rails_5a9a7f536f FOREIGN KEY (assignature_id) REFERENCES assignatures(id);


--
-- Name: fk_rails_5c62e7e5fb; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY color_ranges
    ADD CONSTRAINT fk_rails_5c62e7e5fb FOREIGN KEY (assignature_id) REFERENCES assignatures(id);


--
-- Name: fk_rails_5d05646094; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY proc_types
    ADD CONSTRAINT fk_rails_5d05646094 FOREIGN KEY (proc_type_father_id) REFERENCES proc_type_fathers(id);


--
-- Name: fk_rails_5da578b4c5; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_5da578b4c5 FOREIGN KEY (level_id) REFERENCES levels(id);


--
-- Name: fk_rails_5f68169424; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT fk_rails_5f68169424 FOREIGN KEY (proccess_instrument_id) REFERENCES proccess_instruments(id);


--
-- Name: fk_rails_69c7adc166; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_69c7adc166 FOREIGN KEY (assignature_id) REFERENCES assignatures(id);


--
-- Name: fk_rails_6fe2ab6611; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fact_statuses
    ADD CONSTRAINT fk_rails_6fe2ab6611 FOREIGN KEY (order_id) REFERENCES orders(id);


--
-- Name: fk_rails_70b5689af7; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_70b5689af7 FOREIGN KEY (assignature_ability_id) REFERENCES assignature_abilities(id);


--
-- Name: fk_rails_716818278c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fact_statuses
    ADD CONSTRAINT fk_rails_716818278c FOREIGN KEY (fact_status_type_id) REFERENCES fact_status_types(id);


--
-- Name: fk_rails_71a4eb2cfb; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY contents
    ADD CONSTRAINT fk_rails_71a4eb2cfb FOREIGN KEY (assignature_id) REFERENCES assignatures(id);


--
-- Name: fk_rails_7f47de8c47; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY feedbacks
    ADD CONSTRAINT fk_rails_7f47de8c47 FOREIGN KEY (order_id) REFERENCES orders(id);


--
-- Name: fk_rails_7fdcdd3a0f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY axis_programs
    ADD CONSTRAINT fk_rails_7fdcdd3a0f FOREIGN KEY (assignature_id) REFERENCES assignatures(id);


--
-- Name: fk_rails_8253a6451d; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY remedials
    ADD CONSTRAINT fk_rails_8253a6451d FOREIGN KEY (level_id) REFERENCES levels(id);


--
-- Name: fk_rails_83576d7ed2; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY evaluations
    ADD CONSTRAINT fk_rails_83576d7ed2 FOREIGN KEY (level_id) REFERENCES levels(id);


--
-- Name: fk_rails_884b09d400; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assignature_abilities
    ADD CONSTRAINT fk_rails_884b09d400 FOREIGN KEY (assignature_id) REFERENCES assignatures(id);


--
-- Name: fk_rails_9203e3f554; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_9203e3f554 FOREIGN KEY (axis_program_id) REFERENCES axis_programs(id);


--
-- Name: fk_rails_99e732753e; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY instrument_proccesses
    ADD CONSTRAINT fk_rails_99e732753e FOREIGN KEY (proccess_id) REFERENCES proccesses(id);


--
-- Name: fk_rails_9bf168321e; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY guides
    ADD CONSTRAINT fk_rails_9bf168321e FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: fk_rails_9c334866ce; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY learning_goals
    ADD CONSTRAINT fk_rails_9c334866ce FOREIGN KEY (level_id) REFERENCES levels(id);


--
-- Name: fk_rails_9f434ab280; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communes
    ADD CONSTRAINT fk_rails_9f434ab280 FOREIGN KEY (region_id) REFERENCES regions(id);


--
-- Name: fk_rails_a2f1461231; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users
    ADD CONSTRAINT fk_rails_a2f1461231 FOREIGN KEY (user_type_id) REFERENCES user_types(id);


--
-- Name: fk_rails_a2f2003914; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY guides
    ADD CONSTRAINT fk_rails_a2f2003914 FOREIGN KEY (instrument_id) REFERENCES instruments(id);


--
-- Name: fk_rails_aacba0100c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY instrument_alternatives_positions
    ADD CONSTRAINT fk_rails_aacba0100c FOREIGN KEY (instrument_id) REFERENCES instruments(id);


--
-- Name: fk_rails_ac50658e65; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY feed_forms
    ADD CONSTRAINT fk_rails_ac50658e65 FOREIGN KEY (feedback_id) REFERENCES feedbacks(id);


--
-- Name: fk_rails_b2fcd313fa; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY ability_contents
    ADD CONSTRAINT fk_rails_b2fcd313fa FOREIGN KEY (pme_ability_id) REFERENCES pme_abilities(id);


--
-- Name: fk_rails_be5813c556; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY evaluations
    ADD CONSTRAINT fk_rails_be5813c556 FOREIGN KEY (assignature_id) REFERENCES assignatures(id);


--
-- Name: fk_rails_c0df86ae2d; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_c0df86ae2d FOREIGN KEY (difficulty_level_id) REFERENCES difficulty_levels(id);


--
-- Name: fk_rails_d02767c67e; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_d02767c67e FOREIGN KEY (content_id) REFERENCES contents(id);


--
-- Name: fk_rails_d0f0d006bb; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_d0f0d006bb FOREIGN KEY (unit_id) REFERENCES units(id);


--
-- Name: fk_rails_db20a14e47; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_db20a14e47 FOREIGN KEY (learning_goal_id) REFERENCES learning_goals(id);


--
-- Name: fk_rails_db87da3994; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY program_axis
    ADD CONSTRAINT fk_rails_db87da3994 FOREIGN KEY (assignature_id) REFERENCES assignatures(id);


--
-- Name: fk_rails_e4d63ce947; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY color_ranges
    ADD CONSTRAINT fk_rails_e4d63ce947 FOREIGN KEY (evaluation_type_id) REFERENCES evaluation_types(id);


--
-- Name: fk_rails_e6e1d396b1; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY learning_goals
    ADD CONSTRAINT fk_rails_e6e1d396b1 FOREIGN KEY (assignature_id) REFERENCES assignatures(id);


--
-- Name: fk_rails_eb70432caf; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY guides
    ADD CONSTRAINT fk_rails_eb70432caf FOREIGN KEY (alternative_id) REFERENCES alternatives(id);


--
-- Name: fk_rails_ee79de8fe5; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_ee79de8fe5 FOREIGN KEY (group_question_id) REFERENCES group_questions(id);


--
-- Name: fk_rails_f8dbacf4ab; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY evaluations
    ADD CONSTRAINT fk_rails_f8dbacf4ab FOREIGN KEY (evaluation_type_id) REFERENCES evaluation_types(id);


--
-- Name: fk_rails_fa6ef80fdf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY instrument_alternatives_positions
    ADD CONSTRAINT fk_rails_fa6ef80fdf FOREIGN KEY (alternative_id) REFERENCES alternatives(id);


--
-- Name: fk_rails_fcb5b71ea1; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_fcb5b71ea1 FOREIGN KEY (ability_content_id) REFERENCES ability_contents(id);


--
-- Name: fk_rails_fe4f86a5a1; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY pme_abilities
    ADD CONSTRAINT fk_rails_fe4f86a5a1 FOREIGN KEY (assignature_id) REFERENCES assignatures(id);


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

