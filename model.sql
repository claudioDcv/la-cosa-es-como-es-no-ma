--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.12
-- Dumped by pg_dump version 10.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: base_parameter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_parameter (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    value text NOT NULL,
    program_id integer
);


ALTER TABLE public.base_parameter OWNER TO postgres;

--
-- Name: base_parameter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.base_parameter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_parameter_id_seq OWNER TO postgres;

--
-- Name: base_parameter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.base_parameter_id_seq OWNED BY public.base_parameter.id;


--
-- Name: base_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_profile (
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    id smallint NOT NULL,
    CONSTRAINT base_profile_id_check CHECK ((id >= 0))
);


ALTER TABLE public.base_profile OWNER TO postgres;

--
-- Name: base_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    email character varying(70) NOT NULL,
    external_info jsonb NOT NULL
);


ALTER TABLE public.base_user OWNER TO postgres;

--
-- Name: base_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.base_user_groups OWNER TO postgres;

--
-- Name: base_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.base_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_user_groups_id_seq OWNER TO postgres;

--
-- Name: base_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.base_user_groups_id_seq OWNED BY public.base_user_groups.id;


--
-- Name: base_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.base_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_user_id_seq OWNER TO postgres;

--
-- Name: base_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.base_user_id_seq OWNED BY public.base_user.id;


--
-- Name: base_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.base_user_user_permissions OWNER TO postgres;

--
-- Name: base_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.base_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: base_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.base_user_user_permissions_id_seq OWNED BY public.base_user_user_permissions.id;


--
-- Name: base_userprofilesprogram; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_userprofilesprogram (
    id integer NOT NULL,
    program_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.base_userprofilesprogram OWNER TO postgres;

--
-- Name: base_userprofilesprogram_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.base_userprofilesprogram_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_userprofilesprogram_id_seq OWNER TO postgres;

--
-- Name: base_userprofilesprogram_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.base_userprofilesprogram_id_seq OWNED BY public.base_userprofilesprogram.id;


--
-- Name: base_userprofilesprogram_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_userprofilesprogram_profiles (
    id integer NOT NULL,
    userprofilesprogram_id integer NOT NULL,
    profile_id integer NOT NULL
);


ALTER TABLE public.base_userprofilesprogram_profiles OWNER TO postgres;

--
-- Name: base_userprofilesprogram_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.base_userprofilesprogram_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_userprofilesprogram_profiles_id_seq OWNER TO postgres;

--
-- Name: base_userprofilesprogram_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.base_userprofilesprogram_profiles_id_seq OWNED BY public.base_userprofilesprogram_profiles.id;


--
-- Name: business_campus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business_campus (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL
);


ALTER TABLE public.business_campus OWNER TO postgres;

--
-- Name: business_campus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.business_campus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.business_campus_id_seq OWNER TO postgres;

--
-- Name: business_campus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.business_campus_id_seq OWNED BY public.business_campus.id;


--
-- Name: business_campus_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business_campus_program (
    id integer NOT NULL,
    campus_id integer NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE public.business_campus_program OWNER TO postgres;

--
-- Name: business_campus_program_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.business_campus_program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.business_campus_program_id_seq OWNER TO postgres;

--
-- Name: business_campus_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.business_campus_program_id_seq OWNED BY public.business_campus_program.id;


--
-- Name: business_period; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business_period (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    checksum character varying(100) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE public.business_period OWNER TO postgres;

--
-- Name: business_period_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.business_period_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.business_period_id_seq OWNER TO postgres;

--
-- Name: business_period_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.business_period_id_seq OWNED BY public.business_period.id;


--
-- Name: business_survey; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business_survey (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    checksum character varying(100) NOT NULL
);


ALTER TABLE public.business_survey OWNER TO postgres;

--
-- Name: business_survey_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.business_survey_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.business_survey_id_seq OWNER TO postgres;

--
-- Name: business_survey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.business_survey_id_seq OWNED BY public.business_survey.id;


--
-- Name: business_survey_indicator; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business_survey_indicator (
    id integer NOT NULL,
    survey_id integer NOT NULL,
    indicator_id integer NOT NULL
);


ALTER TABLE public.business_survey_indicator OWNER TO postgres;

--
-- Name: business_survey_indicator_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.business_survey_indicator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.business_survey_indicator_id_seq OWNER TO postgres;

--
-- Name: business_survey_indicator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.business_survey_indicator_id_seq OWNED BY public.business_survey_indicator.id;


--
-- Name: core_indicator; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_indicator (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    checksum character varying(100) NOT NULL,
    skill_id integer NOT NULL,
    subject_id integer NOT NULL
);


ALTER TABLE public.core_indicator OWNER TO postgres;

--
-- Name: core_indicator_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_indicator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_indicator_id_seq OWNER TO postgres;

--
-- Name: core_indicator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_indicator_id_seq OWNED BY public.core_indicator.id;


--
-- Name: core_level; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_level (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    checksum character varying(100) NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE public.core_level OWNER TO postgres;

--
-- Name: core_level_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_level_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_level_id_seq OWNER TO postgres;

--
-- Name: core_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_level_id_seq OWNED BY public.core_level.id;


--
-- Name: core_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_program (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    node_id integer NOT NULL
);


ALTER TABLE public.core_program OWNER TO postgres;

--
-- Name: core_program_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_program_id_seq OWNER TO postgres;

--
-- Name: core_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_program_id_seq OWNED BY public.core_program.id;


--
-- Name: core_skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_skill (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    checksum character varying(100) NOT NULL,
    skill_group_id integer NOT NULL
);


ALTER TABLE public.core_skill OWNER TO postgres;

--
-- Name: core_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_skill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_skill_id_seq OWNER TO postgres;

--
-- Name: core_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_skill_id_seq OWNED BY public.core_skill.id;


--
-- Name: core_skillleveldescription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_skillleveldescription (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    level_id integer NOT NULL,
    skill_id integer NOT NULL
);


ALTER TABLE public.core_skillleveldescription OWNER TO postgres;

--
-- Name: core_skillleveldescription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_skillleveldescription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_skillleveldescription_id_seq OWNER TO postgres;

--
-- Name: core_skillleveldescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_skillleveldescription_id_seq OWNED BY public.core_skillleveldescription.id;


--
-- Name: core_skillsgroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_skillsgroup (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    checksum character varying(100) NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE public.core_skillsgroup OWNER TO postgres;

--
-- Name: core_skillsgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_skillsgroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_skillsgroup_id_seq OWNER TO postgres;

--
-- Name: core_skillsgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_skillsgroup_id_seq OWNED BY public.core_skillsgroup.id;


--
-- Name: core_subject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_subject (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    checksum character varying(100) NOT NULL,
    level_id integer NOT NULL,
    subjects_group_id integer NOT NULL
);


ALTER TABLE public.core_subject OWNER TO postgres;

--
-- Name: core_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_subject_id_seq OWNER TO postgres;

--
-- Name: core_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_subject_id_seq OWNED BY public.core_subject.id;


--
-- Name: core_subjectsgroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_subjectsgroup (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    checksum character varying(100) NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE public.core_subjectsgroup OWNER TO postgres;

--
-- Name: core_subjectsgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_subjectsgroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_subjectsgroup_id_seq OWNER TO postgres;

--
-- Name: core_subjectsgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_subjectsgroup_id_seq OWNED BY public.core_subjectsgroup.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: log_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log_action (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    checksum character varying(100) NOT NULL
);


ALTER TABLE public.log_action OWNER TO postgres;

--
-- Name: log_action_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_action_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_action_id_seq OWNER TO postgres;

--
-- Name: log_action_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_action_id_seq OWNED BY public.log_action.id;


--
-- Name: log_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log_log (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    url character varying(250) NOT NULL,
    data jsonb,
    action_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.log_log OWNER TO postgres;

--
-- Name: log_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_log_id_seq OWNER TO postgres;

--
-- Name: log_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_log_id_seq OWNED BY public.log_log.id;


--
-- Name: term_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.term_course (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    section character varying(250) NOT NULL,
    checksum character varying(100) NOT NULL,
    campus_id integer NOT NULL,
    period_id integer NOT NULL,
    subject_id integer NOT NULL,
    survey_id integer NOT NULL
);


ALTER TABLE public.term_course OWNER TO postgres;

--
-- Name: term_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.term_course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_course_id_seq OWNER TO postgres;

--
-- Name: term_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.term_course_id_seq OWNED BY public.term_course.id;


--
-- Name: term_course_students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.term_course_students (
    id integer NOT NULL,
    course_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.term_course_students OWNER TO postgres;

--
-- Name: term_course_students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.term_course_students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_course_students_id_seq OWNER TO postgres;

--
-- Name: term_course_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.term_course_students_id_seq OWNED BY public.term_course_students.id;


--
-- Name: term_course_teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.term_course_teachers (
    id integer NOT NULL,
    course_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.term_course_teachers OWNER TO postgres;

--
-- Name: term_course_teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.term_course_teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_course_teachers_id_seq OWNER TO postgres;

--
-- Name: term_course_teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.term_course_teachers_id_seq OWNED BY public.term_course_teachers.id;


--
-- Name: term_feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.term_feedback (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    score double precision,
    message text NOT NULL,
    course_id integer NOT NULL,
    evaluated_id integer NOT NULL,
    evaluator_id integer NOT NULL
);


ALTER TABLE public.term_feedback OWNER TO postgres;

--
-- Name: term_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.term_feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_feedback_id_seq OWNER TO postgres;

--
-- Name: term_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.term_feedback_id_seq OWNED BY public.term_feedback.id;


--
-- Name: term_finalindicatorevaluation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.term_finalindicatorevaluation (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    value double precision NOT NULL,
    course_id integer NOT NULL,
    evaluated_id integer NOT NULL,
    evaluator_id integer NOT NULL,
    indicator_id integer NOT NULL
);


ALTER TABLE public.term_finalindicatorevaluation OWNER TO postgres;

--
-- Name: term_finalindicatorevaluation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.term_finalindicatorevaluation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_finalindicatorevaluation_id_seq OWNER TO postgres;

--
-- Name: term_finalindicatorevaluation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.term_finalindicatorevaluation_id_seq OWNED BY public.term_finalindicatorevaluation.id;


--
-- Name: term_finalscoreevaluation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.term_finalscoreevaluation (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    value double precision NOT NULL,
    course_id integer NOT NULL,
    evaluated_id integer NOT NULL,
    evaluator_id integer NOT NULL
);


ALTER TABLE public.term_finalscoreevaluation OWNER TO postgres;

--
-- Name: term_finalscoreevaluation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.term_finalscoreevaluation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_finalscoreevaluation_id_seq OWNER TO postgres;

--
-- Name: term_finalscoreevaluation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.term_finalscoreevaluation_id_seq OWNED BY public.term_finalscoreevaluation.id;


--
-- Name: term_tempfedbackscore; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.term_tempfedbackscore (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    score double precision,
    feedback_id integer NOT NULL
);


ALTER TABLE public.term_tempfedbackscore OWNER TO postgres;

--
-- Name: term_tempfedbackscore_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.term_tempfedbackscore_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_tempfedbackscore_id_seq OWNER TO postgres;

--
-- Name: term_tempfedbackscore_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.term_tempfedbackscore_id_seq OWNED BY public.term_tempfedbackscore.id;


--
-- Name: term_tempfeedbackmessage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.term_tempfeedbackmessage (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    message text NOT NULL,
    feedback_id integer NOT NULL
);


ALTER TABLE public.term_tempfeedbackmessage OWNER TO postgres;

--
-- Name: term_tempfeedbackmessage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.term_tempfeedbackmessage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_tempfeedbackmessage_id_seq OWNER TO postgres;

--
-- Name: term_tempfeedbackmessage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.term_tempfeedbackmessage_id_seq OWNED BY public.term_tempfeedbackmessage.id;


--
-- Name: term_tempfinalindicatorevaluation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.term_tempfinalindicatorevaluation (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    value double precision NOT NULL,
    final_indicator_evaluation_id integer NOT NULL
);


ALTER TABLE public.term_tempfinalindicatorevaluation OWNER TO postgres;

--
-- Name: term_tempfinalindicatorevaluation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.term_tempfinalindicatorevaluation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_tempfinalindicatorevaluation_id_seq OWNER TO postgres;

--
-- Name: term_tempfinalindicatorevaluation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.term_tempfinalindicatorevaluation_id_seq OWNED BY public.term_tempfinalindicatorevaluation.id;


--
-- Name: term_tempscoreevaluation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.term_tempscoreevaluation (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    value double precision NOT NULL,
    final_note_evaluation_id integer NOT NULL
);


ALTER TABLE public.term_tempscoreevaluation OWNER TO postgres;

--
-- Name: term_tempscoreevaluation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.term_tempscoreevaluation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_tempscoreevaluation_id_seq OWNER TO postgres;

--
-- Name: term_tempscoreevaluation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.term_tempscoreevaluation_id_seq OWNED BY public.term_tempscoreevaluation.id;


--
-- Name: topology_node; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topology_node (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    name character varying(250) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    node_type_id integer NOT NULL,
    parent_id integer
);


ALTER TABLE public.topology_node OWNER TO postgres;

--
-- Name: topology_node_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topology_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topology_node_id_seq OWNER TO postgres;

--
-- Name: topology_node_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.topology_node_id_seq OWNED BY public.topology_node.id;


--
-- Name: topology_nodetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topology_nodetype (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    name character varying(250) NOT NULL,
    code character varying(100) NOT NULL,
    description text NOT NULL,
    is_top boolean NOT NULL,
    can_have_programs boolean NOT NULL
);


ALTER TABLE public.topology_nodetype OWNER TO postgres;

--
-- Name: topology_nodetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topology_nodetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topology_nodetype_id_seq OWNER TO postgres;

--
-- Name: topology_nodetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.topology_nodetype_id_seq OWNED BY public.topology_nodetype.id;


--
-- Name: topology_nodetypeparent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topology_nodetypeparent (
    id integer NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
    node_type_id integer NOT NULL,
    parent_type_id integer NOT NULL
);


ALTER TABLE public.topology_nodetypeparent OWNER TO postgres;

--
-- Name: topology_nodetypeparent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topology_nodetypeparent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topology_nodetypeparent_id_seq OWNER TO postgres;

--
-- Name: topology_nodetypeparent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.topology_nodetypeparent_id_seq OWNED BY public.topology_nodetypeparent.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: base_parameter id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_parameter ALTER COLUMN id SET DEFAULT nextval('public.base_parameter_id_seq'::regclass);


--
-- Name: base_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user ALTER COLUMN id SET DEFAULT nextval('public.base_user_id_seq'::regclass);


--
-- Name: base_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user_groups ALTER COLUMN id SET DEFAULT nextval('public.base_user_groups_id_seq'::regclass);


--
-- Name: base_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.base_user_user_permissions_id_seq'::regclass);


--
-- Name: base_userprofilesprogram id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_userprofilesprogram ALTER COLUMN id SET DEFAULT nextval('public.base_userprofilesprogram_id_seq'::regclass);


--
-- Name: base_userprofilesprogram_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_userprofilesprogram_profiles ALTER COLUMN id SET DEFAULT nextval('public.base_userprofilesprogram_profiles_id_seq'::regclass);


--
-- Name: business_campus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_campus ALTER COLUMN id SET DEFAULT nextval('public.business_campus_id_seq'::regclass);


--
-- Name: business_campus_program id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_campus_program ALTER COLUMN id SET DEFAULT nextval('public.business_campus_program_id_seq'::regclass);


--
-- Name: business_period id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_period ALTER COLUMN id SET DEFAULT nextval('public.business_period_id_seq'::regclass);


--
-- Name: business_survey id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_survey ALTER COLUMN id SET DEFAULT nextval('public.business_survey_id_seq'::regclass);


--
-- Name: business_survey_indicator id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_survey_indicator ALTER COLUMN id SET DEFAULT nextval('public.business_survey_indicator_id_seq'::regclass);


--
-- Name: core_indicator id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_indicator ALTER COLUMN id SET DEFAULT nextval('public.core_indicator_id_seq'::regclass);


--
-- Name: core_level id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_level ALTER COLUMN id SET DEFAULT nextval('public.core_level_id_seq'::regclass);


--
-- Name: core_program id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_program ALTER COLUMN id SET DEFAULT nextval('public.core_program_id_seq'::regclass);


--
-- Name: core_skill id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skill ALTER COLUMN id SET DEFAULT nextval('public.core_skill_id_seq'::regclass);


--
-- Name: core_skillleveldescription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skillleveldescription ALTER COLUMN id SET DEFAULT nextval('public.core_skillleveldescription_id_seq'::regclass);


--
-- Name: core_skillsgroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skillsgroup ALTER COLUMN id SET DEFAULT nextval('public.core_skillsgroup_id_seq'::regclass);


--
-- Name: core_subject id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_subject ALTER COLUMN id SET DEFAULT nextval('public.core_subject_id_seq'::regclass);


--
-- Name: core_subjectsgroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_subjectsgroup ALTER COLUMN id SET DEFAULT nextval('public.core_subjectsgroup_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: log_action id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_action ALTER COLUMN id SET DEFAULT nextval('public.log_action_id_seq'::regclass);


--
-- Name: log_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_log ALTER COLUMN id SET DEFAULT nextval('public.log_log_id_seq'::regclass);


--
-- Name: term_course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course ALTER COLUMN id SET DEFAULT nextval('public.term_course_id_seq'::regclass);


--
-- Name: term_course_students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course_students ALTER COLUMN id SET DEFAULT nextval('public.term_course_students_id_seq'::regclass);


--
-- Name: term_course_teachers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course_teachers ALTER COLUMN id SET DEFAULT nextval('public.term_course_teachers_id_seq'::regclass);


--
-- Name: term_feedback id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_feedback ALTER COLUMN id SET DEFAULT nextval('public.term_feedback_id_seq'::regclass);


--
-- Name: term_finalindicatorevaluation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalindicatorevaluation ALTER COLUMN id SET DEFAULT nextval('public.term_finalindicatorevaluation_id_seq'::regclass);


--
-- Name: term_finalscoreevaluation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalscoreevaluation ALTER COLUMN id SET DEFAULT nextval('public.term_finalscoreevaluation_id_seq'::regclass);


--
-- Name: term_tempfedbackscore id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempfedbackscore ALTER COLUMN id SET DEFAULT nextval('public.term_tempfedbackscore_id_seq'::regclass);


--
-- Name: term_tempfeedbackmessage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempfeedbackmessage ALTER COLUMN id SET DEFAULT nextval('public.term_tempfeedbackmessage_id_seq'::regclass);


--
-- Name: term_tempfinalindicatorevaluation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempfinalindicatorevaluation ALTER COLUMN id SET DEFAULT nextval('public.term_tempfinalindicatorevaluation_id_seq'::regclass);


--
-- Name: term_tempscoreevaluation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempscoreevaluation ALTER COLUMN id SET DEFAULT nextval('public.term_tempscoreevaluation_id_seq'::regclass);


--
-- Name: topology_node id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_node ALTER COLUMN id SET DEFAULT nextval('public.topology_node_id_seq'::regclass);


--
-- Name: topology_nodetype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_nodetype ALTER COLUMN id SET DEFAULT nextval('public.topology_nodetype_id_seq'::regclass);


--
-- Name: topology_nodetypeparent id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_nodetypeparent ALTER COLUMN id SET DEFAULT nextval('public.topology_nodetypeparent_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add user	6	add_user
17	Can change user	6	change_user
18	Can delete user	6	delete_user
19	Can add parameter	7	add_parameter
20	Can change parameter	7	change_parameter
21	Can delete parameter	7	delete_parameter
22	Can add profile	8	add_profile
23	Can change profile	8	change_profile
24	Can delete profile	8	delete_profile
25	Can add user profiles program	9	add_userprofilesprogram
26	Can change user profiles program	9	change_userprofilesprogram
27	Can delete user profiles program	9	delete_userprofilesprogram
28	Can add campus	10	add_campus
29	Can change campus	10	change_campus
30	Can delete campus	10	delete_campus
31	Can add periodo	11	add_period
32	Can change periodo	11	change_period
33	Can delete periodo	11	delete_period
34	Can add encuesta	12	add_survey
35	Can change encuesta	12	change_survey
36	Can delete encuesta	12	delete_survey
37	Can add indicador	13	add_indicator
38	Can change indicador	13	change_indicator
39	Can delete indicador	13	delete_indicator
40	Can add nivel	14	add_level
41	Can change nivel	14	change_level
42	Can delete nivel	14	delete_level
43	Can add programa	15	add_program
44	Can change programa	15	change_program
45	Can delete programa	15	delete_program
46	Can add competencia	16	add_skill
47	Can change competencia	16	change_skill
48	Can delete competencia	16	delete_skill
49	Can add descripción competencia y nivel	17	add_skillleveldescription
50	Can change descripción competencia y nivel	17	change_skillleveldescription
51	Can delete descripción competencia y nivel	17	delete_skillleveldescription
52	Can add grupo de competencias	18	add_skillsgroup
53	Can change grupo de competencias	18	change_skillsgroup
54	Can delete grupo de competencias	18	delete_skillsgroup
55	Can add asignatura	19	add_subject
56	Can change asignatura	19	change_subject
57	Can delete asignatura	19	delete_subject
58	Can add grupo de asignaturas	20	add_subjectsgroup
59	Can change grupo de asignaturas	20	change_subjectsgroup
60	Can delete grupo de asignaturas	20	delete_subjectsgroup
61	Can add tipo de acción para log	21	add_action
62	Can change tipo de acción para log	21	change_action
63	Can delete tipo de acción para log	21	delete_action
64	Can add log	22	add_log
65	Can change log	22	change_log
66	Can delete log	22	delete_log
67	Can add curso	23	add_course
68	Can change curso	23	change_course
69	Can delete curso	23	delete_course
70	Can add feedback	24	add_feedback
71	Can change feedback	24	change_feedback
72	Can delete feedback	24	delete_feedback
73	Can add puntaje de indicador (estudiante - curso)	25	add_finalindicatorevaluation
74	Can change puntaje de indicador (estudiante - curso)	25	change_finalindicatorevaluation
75	Can delete puntaje de indicador (estudiante - curso)	25	delete_finalindicatorevaluation
76	Can add nota final (estudiante - curso)	26	add_finalscoreevaluation
77	Can change nota final (estudiante - curso)	26	change_finalscoreevaluation
78	Can delete nota final (estudiante - curso)	26	delete_finalscoreevaluation
79	Can add temp fedback score	27	add_tempfedbackscore
80	Can change temp fedback score	27	change_tempfedbackscore
81	Can delete temp fedback score	27	delete_tempfedbackscore
82	Can add temp feedback message	28	add_tempfeedbackmessage
83	Can change temp feedback message	28	change_tempfeedbackmessage
84	Can delete temp feedback message	28	delete_tempfeedbackmessage
85	Can add temp final indicator evaluation	29	add_tempfinalindicatorevaluation
86	Can change temp final indicator evaluation	29	change_tempfinalindicatorevaluation
87	Can delete temp final indicator evaluation	29	delete_tempfinalindicatorevaluation
88	Can add temp score evaluation	30	add_tempscoreevaluation
89	Can change temp score evaluation	30	change_tempscoreevaluation
90	Can delete temp score evaluation	30	delete_tempscoreevaluation
91	Can add nodo	31	add_node
92	Can change nodo	31	change_node
93	Can delete nodo	31	delete_node
94	Can add tipo de nodo	32	add_nodetype
95	Can change tipo de nodo	32	change_nodetype
96	Can delete tipo de nodo	32	delete_nodetype
97	Can add tipo de nodo padre	33	add_nodetypeparent
98	Can change tipo de nodo padre	33	change_nodetypeparent
99	Can delete tipo de nodo padre	33	delete_nodetypeparent
\.


--
-- Data for Name: base_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_parameter (id, is_deleted, created_ts, updated_ts, name, code, value, program_id) FROM stdin;
\.


--
-- Data for Name: base_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_profile (name, code, description, is_deleted, created_ts, updated_ts, id) FROM stdin;
Estudiante	estudiante		f	2018-03-17 04:23:51.819-03	2018-03-17 04:23:51.819-03	1
Profesor	profesor		f	2018-03-17 04:24:01.251-03	2018-03-17 04:24:01.251-03	2
Administrador	admin		f	2018-03-17 04:24:09.154-03	2018-03-17 04:24:09.154-03	5
\.


--
-- Data for Name: base_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_user (id, password, last_login, is_superuser, username, first_name, last_name, is_staff, is_active, date_joined, email, external_info) FROM stdin;
27	pbkdf2_sha256$100000$oPqOm5Danipg$Q6SoJHAtrKkBD266eT4E3tbfSnYEtFC1qpwtZ6o6X0w=	\N	f	20073999-K	IGNACIO	SANCHEZ UGARTE	f	t	2018-03-17 04:24:34.649367-03	igsanchezu@udd.cl	{"promocion": "2018"}
28	pbkdf2_sha256$100000$QGr50er7mWMZ$rUyxxdw3iHfswah61QpmkhTcvSalXDMzlxF9clGLwgA=	\N	f	20165365-7	AGUSTIN	LYON MONTES	f	t	2018-03-17 04:24:34.818918-03	alyonm@udd.cl	{"promocion": "2018"}
29	pbkdf2_sha256$100000$AWtg8e9Wkoa9$mFDhse3YINn9Qxm6dUOr/PY6fmLatQsaV20B5gtznSI=	\N	f	20109160-8	VALENTINA SOFIA	PAVEZ BORGHERO	f	t	2018-03-17 04:24:34.971797-03	vapavezb@udd.cl	{"promocion": "2018"}
30	pbkdf2_sha256$100000$hVX0JS5FoDRc$9jPJHFdIhWtWN9qbq7ePnNIo1FH6HhlfRUToKu4LP2U=	\N	f	20074171-4	JUAN CARLOS	DAROCH SCHNEIDER	f	t	2018-03-17 04:24:35.125942-03	jdarochs@udd.cl	{"promocion": "2018"}
1	pbkdf2_sha256$100000$uvxei7LKU9sc$fOzrjDs09h2JQEBiZMpwf0d6J1SzhNykDDrtg7ngRuE=	\N	t	sergio			t	t	2018-02-15 21:47:45.481-03	sergio.majluf@gmail.com	"null"
2	pbkdf2_sha256$100000$fnHVz1vaQtHj$WxW8b5xj3rZCUpufH+Y9pdeRwZiQ3EknOuucZiJ22f8=	\N	t	dario			t	t	2018-02-15 21:49:23.282-03	daguajar@gmail.com	"null"
3	pbkdf2_sha256$100000$qQqaHBTeLCGS$rxgO4YnLZ1txlFZg3KFfEif2/CpCmD8Av0BiOxqlHMA=	2018-03-17 04:09:53.33-03	t	claudio			t	t	2018-02-15 21:49:54.86-03	claudio.dcv@gmail.com	"null"
4	pbkdf2_sha256$100000$wuv91ewfXYLv$UCh+9oCKM3xjGOU+ClWDv6dhyQK8rDP92JipAntl3hs=	\N	f	19293828-7	JOSÉ TOMÁS	LEÓN AGUILÓ	f	t	2018-03-17 04:22:31.25-03	jleona@udd.cl	{"promocion": "2018"}
6	pbkdf2_sha256$100000$BlI78X9mfGob$+/x8pqUaKhVFshTKSJncRPUSlu20YqSKaUwBaM+L02g=	\N	f	19646075-6	DANIELA CATALINA	OLATE PÉREZ	f	t	2018-03-17 04:23:00.631-03	dolatep@udd.cl	{"promocion": "2018"}
9	pbkdf2_sha256$100000$lpa6c9kguHoR$Uhq3B6FLags/UBTvoLUOa1fUQ562KqE+8BfUKZxpt/c=	\N	f	19539759-7	JOSÉ ANTONIO	ROSSETTI KRAUSS	f	t	2018-03-17 04:24:31.733858-03	jrossettik@udd.cl	{"promocion": "2018"}
10	pbkdf2_sha256$100000$DePPIBeS34Fs$4O5AbxdeLcjz7tWguj+/ud8fH0DJPupTK1ZSMuLJ9zI=	\N	f	19531589-2	CRISTÓBAL SEBASTIAN DE JESUS	RIOSECO BUSTOS	f	t	2018-03-17 04:24:31.894037-03	crriosecob@udd.cl	{"promocion": "2018"}
11	pbkdf2_sha256$100000$rpr3orV9B0Gp$7WUm3KYq4+v2DvRijVU6S4Km4VxsNGaVdajdlnBoo68=	\N	f	19539660-4	JUAN PABLO	JULIO ROSENBERG	f	t	2018-03-17 04:24:32.042908-03	jjulior@udd.cl	{"promocion": "2018"}
12	pbkdf2_sha256$100000$nsY9RiU8A136$kP18SAeIA//0Hkmuh9KQaqj9WmY+kn1B5bWmnWleXY0=	\N	f	19523265-2	MACARENA IGNACIA	BANCHIERI DIAZ	f	t	2018-03-17 04:24:32.209111-03	mbanchierid@udd.cl	{"promocion": "2018"}
13	pbkdf2_sha256$100000$09adSoPYCvcN$Jb9LqOhwTYFPJmWGFX1SlOXzjgEwxevknAgDa78fo6I=	\N	f	19685549-1	ALFONSO IGNACIO	CONTRERAS SAEZ	f	t	2018-03-17 04:24:32.389854-03	alcontrerass@udd.cl	{"promocion": "2018"}
14	pbkdf2_sha256$100000$d6ALDIkfOhp6$1TRXrBzN9KXp79qm2Q2OxjxoWLjYekFAC/lvpaB9/Ps=	\N	f	19864506-0	FABIÁN MIGUELANGEL	TAPIA URBINA	f	t	2018-03-17 04:24:32.556099-03	fatapiau@udd.cl	{"promocion": "2018"}
15	pbkdf2_sha256$100000$swKtxq2RqRjH$+9+bWDiR1MOfe608P0yVHidKW4oIQafMCf/pd15u2Z0=	\N	f	19078929-2	JAVIERA TERESITA DE JESUS	VERDERAU RUIZ	f	t	2018-03-17 04:24:32.709515-03	jverderaur@udd.cl	{"promocion": "2018"}
16	pbkdf2_sha256$100000$FDLe0tblmBpL$2GyJ7no5THh2Adut3mYbmUQCiK2YC0OkGEoSMb8zJg8=	\N	f	19997333-9	LISSET DANIXA	MARIPAN BASOALTO	f	t	2018-03-17 04:24:32.866745-03	lmaripanb@udd.cl	{"promocion": "2018"}
17	pbkdf2_sha256$100000$jwGYzX60mu8g$cRE6DrGhpm8mOaXoSOQjbDiiirPnsUZTwdrzuVvgcYU=	\N	f	20282817-5	MARIA MAGDALENA	IZQUIERDO GARCES	f	t	2018-03-17 04:24:33.019597-03	marizquierdog@udd.cl	{"promocion": "2018"}
18	pbkdf2_sha256$100000$1tkWzQqhmVQI$SJ2gIvVe6NUQ+hAIevxVj4LptVZlmyosaaf5POu6CHc=	\N	f	20107968-3	MARIA IGNACIA	TAPIA GONZALEZ	f	t	2018-03-17 04:24:33.178284-03	maritapiag@udd.cl	{"promocion": "2018"}
19	pbkdf2_sha256$100000$TEGZRF9mOwzK$X/eKDJNtTFGx8w7SBT+F8K/AVyA/+olNqwd+pgnlFDA=	\N	f	20117550-K	MARIA IGNACIA	VALENZUELA GONZALEZ	f	t	2018-03-17 04:24:33.333182-03	mariaivalenzuelag@udd.cl	{"promocion": "2018"}
20	pbkdf2_sha256$100000$XDhGyBV2q9nF$XPYaDUEzOkuvZSaMFgeGFrnwojtafOf1sbxc90u6vcg=	\N	f	20285028-6	MARIA TERESITA DEL NIÑO J	CRUZ ERRAZURIZ	f	t	2018-03-17 04:24:33.504403-03	mcruze@udd.cl	{"promocion": "2018"}
21	pbkdf2_sha256$100000$CPvUMPB9gTY3$7GMuF15AF+g6G2MH4nDaIcNvnz8tQbHPSQFjMyoRHEE=	\N	f	20165870-5	ADOLFO JOSE	DOSAL ALMENDARES	f	t	2018-03-17 04:24:33.655379-03	adosala@udd.cl	{"promocion": "2018"}
22	pbkdf2_sha256$100000$cqJP4zH2PDPz$iLn9HxVYyWI6PAwXvDNVpySqf3lDC97xWFRg5lUfs58=	\N	f	20075313-5	COLOMBA	DE PETRIS CARDOEN	f	t	2018-03-17 04:24:33.81779-03	cdepetrisc@udd.cl	{"promocion": "2018"}
23	pbkdf2_sha256$100000$nMkHrFeJHIEC$wQlZJIr1WWfAvTgl9bMNDK19UOUAYjk+CHYAHd1m3wQ=	\N	f	20165261-8	MARIA ISIDORA	URZUA TORM	f	t	2018-03-17 04:24:33.977953-03	murzuat@udd.cl	{"promocion": "2018"}
24	pbkdf2_sha256$100000$6IL6y6syElnh$72uBjwYyJ3I/2NFjfEohmo4vafi4lF6JiockpPLMt2Y=	\N	f	20073433-5	CONSTANZA BEATRIZ	MONTECINOS FRASCAROLO	f	t	2018-03-17 04:24:34.134875-03	comontecinosf@udd.cl	{"promocion": "2018"}
25	pbkdf2_sha256$100000$pskVGqpwF11n$bVWFqxAzORmmA0Irsu+nB7Lw0yoZkFC46RTgwCOIVA8=	\N	f	20072987-0	BARBARA	SCHUMACHER MILITZER	f	t	2018-03-17 04:24:34.300087-03	bschumacherm@udd.cl	{"promocion": "2018"}
26	pbkdf2_sha256$100000$KSI3afAxEQ9Q$+qG6x+b9W1Yj5fOk6xq6PS+XNQB6Y99EFJLlVHeWZzc=	\N	f	20284093-0	AGUSTINA PAZ	RIVEROS KONEKAMP	f	t	2018-03-17 04:24:34.467528-03	agriverosk@udd.cl	{"promocion": "2018"}
31	pbkdf2_sha256$100000$gOSzTPffOvn3$fxQFKK0yNRVk3J2NzTtSqgeEw5AxyhGsisH3bcVfoI4=	\N	f	20284740-4	JOSEFINA	MARAMBIO GONZALEZ	f	t	2018-03-17 04:24:35.28018-03	jmarambiog@udd.cl	{"promocion": "2018"}
32	pbkdf2_sha256$100000$39huCpGuroQT$qvPs125/NEV8KDIS3z271vVo2amzWTLJjDUsEdFgFEE=	\N	f	19892544-6	MARTÍN	SOTO MALDINI	f	t	2018-03-17 04:24:35.446202-03	marsotom@udd.cl	{"promocion": "2018"}
33	pbkdf2_sha256$100000$B9sM5lqFIxIh$iF39y9a8JypuTF09ZJYzn36wADtm25qPmzB2B+RbheM=	\N	f	20163653-1	ANTONIA	TORRES CAÑAS	f	t	2018-03-17 04:24:35.608944-03	anttorresc@udd.cl	{"promocion": "2018"}
34	pbkdf2_sha256$100000$AzoKvAhuiQr5$KdxROMQIu+rka8hWHrpvyj4TeyiqfdABk+jt7n8EgN8=	\N	f	20165278-2	MATIAS	DEL CAMPO LEHUEDE	f	t	2018-03-17 04:24:35.773955-03	mdelcampol@udd.cl	{"promocion": "2018"}
35	pbkdf2_sha256$100000$QDRIGx2H1V9t$w3gN/pJ18qD8/VZ7XMNIBXmQouCpqYJ42zOGIQQXr74=	\N	f	19893278-7	CLEMENTE	SWINBURN ASPILLAGA	f	t	2018-03-17 04:24:35.934879-03	cswinburna@udd.cl	{"promocion": "2018"}
36	pbkdf2_sha256$100000$xEy0PW91n4q5$U5sNC1xr0886pkTLPPdLZZQzDWFq4NTiT1t7BVgpO5c=	\N	f	20345939-4	VALENTINA ANDREA	VIVAR URIBE	f	t	2018-03-17 04:24:36.090811-03	vvivaru@udd.cl	{"promocion": "2018"}
37	pbkdf2_sha256$100000$AN6pAGrVDMae$QPhSnGcE0BBOzWqGWhyMoTmh/gIwznlyRiYiVM8g+Xk=	\N	f	20285012-K	VICENTE	LUHRS CONCHA	f	t	2018-03-17 04:24:36.249778-03	vluhrsc@udd.cl	{"promocion": "2018"}
38	pbkdf2_sha256$100000$EmcUKXoh1WwY$q4g8f2wFWVKZb6BgwvLJQtycgzZkI/MqCinZw+QDXrE=	\N	f	20074191-9	CECILIA ISIDORA	MATAMALA ERBETTA	f	t	2018-03-17 04:24:36.404726-03	cmatamalae@udd.cl	{"promocion": "2018"}
39	pbkdf2_sha256$100000$gomnnkFZEvtk$xiUzmiInOyrsvcAY4U90fok+z/ElZqKmq5NFoDq2Oec=	\N	f	20075293-7	MARIA ISIDORA	PULLEN CALORIO	f	t	2018-03-17 04:24:36.56782-03	mpullenc@udd.cl	{"promocion": "2018"}
40	pbkdf2_sha256$100000$fdOZSuuMjhxP$L+qd2ydJHStkaBhsid/T6uB9dvHKHGT7Tyh742ckuD8=	\N	f	20285184-3	ANA MARIA	CANESSA FERNANDEZ	f	t	2018-03-17 04:24:36.716898-03	acanessaf@udd.cl	{"promocion": "2018"}
41	pbkdf2_sha256$100000$ATZZbSGxnJSE$NwQyTvNXjwUiKTNDOuXAMMRWgOOtBFgc7pp4F7BGmzs=	\N	f	20258566-3	CYNTHIA SOPHIA	CAPURRO MITCHELL	f	t	2018-03-17 04:24:36.869932-03	ccapurrom@udd.cl	{"promocion": "2018"}
42	pbkdf2_sha256$100000$e4llDokm4Amt$CM85Gz2Z+dIHo7rYbTV2QBP4H+a+SR3WO5jVcQrGKVM=	\N	f	20283943-6	JACINTA	VALENZUELA VERGARA	f	t	2018-03-17 04:24:37.029502-03	jacivalenzuelav@udd.cl	{"promocion": "2018"}
43	pbkdf2_sha256$100000$H1xbehHVVf7R$rWFA7KB3urkO+L/Ejnxv5u1q3TFnpCzKOWUmCq4e2XQ=	\N	f	20073591-9	CLEMENTE	HERNANDEZ LATHROP	f	t	2018-03-17 04:24:37.192339-03	clehernandezl@udd.cl	{"promocion": "2018"}
44	pbkdf2_sha256$100000$rCKDfLhAvE3Q$aB6gUJDIPwT5U3+rod+fobqmBHj5fO7GmvO/0cfU7tk=	\N	f	20289616-2	TANIA JOSEFA	BRAVO AGUILERA	f	t	2018-03-17 04:24:37.363718-03	tbravoa@udd.cl	{"promocion": "2018"}
45	pbkdf2_sha256$100000$9pkcHqjjwY7L$sDu+M2bEPvnD+28FT8nTtZxPgpzfjI+LU77MYJZIjEo=	\N	f	20038973-5	GUSTAVO SEBASTIAN	MARTINEZ ESPINOZA	f	t	2018-03-17 04:24:37.525686-03	gmartineze@udd.cl	{"promocion": "2018"}
46	pbkdf2_sha256$100000$8rYfrdkRPUGI$SgPim595vgnG/9Ie/Bk5rHl5bVV+F6lDmAhTBhz1ci4=	\N	f	20075470-0	DIEGO ALFREDO	SELAIVE CAMPOS	f	t	2018-03-17 04:24:37.702298-03	dselaivec@udd.cl	{"promocion": "2018"}
47	pbkdf2_sha256$100000$Ujq2EZ7wvuoN$5o8qatsMQYeeHLA0P1FUWWMQlyr9Qd76jTtsql29c9c=	\N	f	20285503-2	INES	DELORENZO GOMEZ	f	t	2018-03-17 04:24:37.871436-03	idelorenzog@udd.cl	{"promocion": "2018"}
48	pbkdf2_sha256$100000$lnZ5iRnHJ4IC$LyUZIaeTDwbIj4oj7qZna58eLXSTkzn/Tzzjbqhy10Y=	\N	f	20283317-9	VICENTE JOAQUIN	PEÑA CASTRO	f	t	2018-03-17 04:24:38.044132-03	vpenac@udd.cl	{"promocion": "2018"}
49	pbkdf2_sha256$100000$QxdEsbeCFknI$VVSuI0spqpR8iWVc9ulQRYoCFIPxV4AqGybNBoiEXkg=	\N	f	19496258-4	MARIO NICOLAS	LAGOS CORVACHO	f	t	2018-03-17 04:24:38.213773-03	marilagosc@udd.cl	{"promocion": "2018"}
50	pbkdf2_sha256$100000$Ca4FJlvyxG2v$bCtalWK4TZ2zQEfD66/irHnDIRDvHGAepji1oWV45u0=	\N	f	19246535-4	VICENTE JOAQUIN	VIAL VERGARA	f	t	2018-03-17 04:24:38.371121-03	vvialv@udd.cl	{"promocion": "2018"}
51	pbkdf2_sha256$100000$4p42ewx8eRVN$KCI7mAJ3RC64V3a+Gq9UGIUX4LKTiHEMKdiiswbzmn8=	\N	f	20164475-5	MARIA PAZ	FLORES VARELA	f	t	2018-03-17 04:24:38.52927-03	mafloresv@udd.cl	{"promocion": "2018"}
52	pbkdf2_sha256$100000$rtJy8KiXTcav$1Ft37+xa/X2llclpiXjLp/EwnjVlGxdtLsNJl+fakdc=	\N	f	19619101-1	JAVIER ANDRES	FLORES TERRAZAS	f	t	2018-03-17 04:24:38.685895-03	javflorest@udd.cl	{"promocion": "2018"}
53	pbkdf2_sha256$100000$zxMKasGW1Yif$Y8arXnUNu/aE9daiNZpq4tOYry+uO+NpJLPZOH9W0vk=	\N	f	20165209-K	AGUSTINA	DE BLASIS TERAN	f	t	2018-03-17 04:24:38.861706-03	adeblasist@udd.cl	{"promocion": "2018"}
54	pbkdf2_sha256$100000$byzqauBzM6wR$XpRy3vBGmsxj83L4vkVwIsJPAso6fDJ5MZwnA874apg=	\N	f	20250332-2	BROOKE NICOLE	DAHER ARRIAZA	f	t	2018-03-17 04:24:39.012845-03	bdahera@udd.cl	{"promocion": "2018"}
55	pbkdf2_sha256$100000$qxpEPyiC4bz1$eElnpHq68sT7bgCkjcfZdEFOTsZG1D0aSyEupv+KSvM=	\N	f	20287048-1	CATALINA CONSTANZA	QUEZADA CERDA	f	t	2018-03-17 04:24:39.170937-03	caquezadac@udd.cl	{"promocion": "2018"}
56	pbkdf2_sha256$100000$GJnpy0DAQrJb$+i96CyrKIwUbMv+O5DW/VwUr6O2T1+C7U1F0zcEQr1M=	\N	f	20165458-0	BORJA	HURTADO CEPEDA	f	t	2018-03-17 04:24:39.336328-03	bhurtadoc@udd.cl	{"promocion": "2018"}
57	pbkdf2_sha256$100000$cG3vF6CatEiY$y7jG+roMk6pib6uhPZCUdsCYBYk/2qGrekjNXKKHvqA=	\N	f	19815123-8	STEFFI MELISSA	BUCONIC GROSS	f	t	2018-03-17 04:24:39.495132-03	sbuconicg@udd.cl	{"promocion": "2018"}
58	pbkdf2_sha256$100000$pNXgrFfmb1Ph$TnMfVLor3/FNHj2midPzN9AuKe2ly5z8uKLHmqTcmzs=	\N	f	20165347-9	MACARENA	BORGOÑO GARCES	f	t	2018-03-17 04:24:39.652303-03	mborgonog@udd.cl	{"promocion": "2018"}
59	pbkdf2_sha256$100000$fezQnJ7jkDzx$lLPSojJmqNIQdUoZr8Po1C7OqpvbGtlvjPVJVvprZfQ=	\N	f	22346342-8	ELKIN HUMBERTO	CHAPARRO FAJARDO	f	t	2018-03-17 04:24:39.815086-03	echaparrof@udd.cl	{"promocion": "2018"}
60	pbkdf2_sha256$100000$WctL6DfO9k8D$XWCTrIdgd+jFUSE7owSit9YyxQ28qnbjXvGszpKFNZM=	\N	f	19937768-K	SOFIA	LIRA CORREA	f	t	2018-03-17 04:24:39.97586-03	slirac@udd.cl	{"promocion": "2018"}
61	pbkdf2_sha256$100000$TYPxp7pQspdO$7Tf5PyR5okxgHdjJObXaCJU1rwM2n7xSiiHXIARcrRs=	\N	f	20285828-7	ANDRES	MARTIN MARIN	f	t	2018-03-17 04:24:40.147658-03	amartinm@udd.cl	{"promocion": "2018"}
62	pbkdf2_sha256$100000$XY2kSLouIEp3$NlvoiTLaeB19JD3qWD1+cZCbfNjee5QycBhnRDGIihU=	\N	f	19323429-1	CATALINA SOFIA	PEREZ FUENTES	f	t	2018-03-17 04:24:40.322899-03	caperezf@udd.cl	{"promocion": "2018"}
63	pbkdf2_sha256$100000$r3TJi7B3kQQf$8GHH398ThIC0T0AbKvbePnnXw7ctxYLrt7tlahTpTyc=	\N	f	20299226-9	DIEGO PABLO	DE TORO CHELLEW	f	t	2018-03-17 04:24:40.47995-03	ddetoroc@udd.cl	{"promocion": "2018"}
64	pbkdf2_sha256$100000$TmaKpSOewpQ5$YUNXjPboCOpwdNEq2WPFal9EHuHsQ9s+Q2lnwM6wMdU=	\N	f	20283844-8	PAULA CONSTANZA	BASTIAS MENDEZ	f	t	2018-03-17 04:24:40.638439-03	pbastiasm@udd.cl	{"promocion": "2018"}
65	pbkdf2_sha256$100000$iplhhDpPVpAK$zJX/tRpZPfumi0b8fPh8CLG4cQiX2cAKaJwvBGB2At4=	\N	f	20287346-4	ELISA	PLANELLA DURRUTY	f	t	2018-03-17 04:24:40.801893-03	eplanellad@udd.cl	{"promocion": "2018"}
66	pbkdf2_sha256$100000$OZuNPFvqeHYi$txbIZ974rAtUMhW3F+BKFSSmvrEoAhwqOJcOrer2Y0A=	\N	f	20358538-1	LUIS TOMAS	CAMBIASO CHAHUAN	f	t	2018-03-17 04:24:40.965811-03	lcambiasoc@udd.cl	{"promocion": "2018"}
67	pbkdf2_sha256$100000$Y7mVcsHOe5d6$yxQLbtYEK7WWrrNOIDuxmU/SHXLcveeCWw5T5DcdW70=	\N	f	20075847-1	BELTRAN	LASSERRE PERALTA	f	t	2018-03-17 04:24:41.126741-03	blasserrep@udd.cl	{"promocion": "2018"}
68	pbkdf2_sha256$100000$WbEFLlrPjpJ8$97Rh5JtYfwRrN7Q6j3UTfB63TtUvwdI61EN8u2GeJKA=	\N	f	20165542-0	BENJAMIN JOSE	JOVEL PINEDO	f	t	2018-03-17 04:24:41.310154-03	bjovelp@udd.cl	{"promocion": "2018"}
69	pbkdf2_sha256$100000$ApNudot5kfzC$q46k93Lq7prRUlETYUQ3nt0Ywtm3rBCPg7IffZwVr04=	\N	f	20062525-0	EVA PAULA	CASTILLO RUIZ	f	t	2018-03-17 04:24:41.472805-03	ecastillor@udd.cl	{"promocion": "2018"}
70	pbkdf2_sha256$100000$Zenc2ZuBaz8f$aWAEoYyUSA1oXf+Amh3AmbimSviLM+X//K2JQCtvDes=	\N	f	20073879-9	MATIAS IGNACIO	ROJAS NOVOA	f	t	2018-03-17 04:24:41.652736-03	marojasn@udd.cl	{"promocion": "2018"}
71	pbkdf2_sha256$100000$zce7GPUZxytu$COtThSpp2TB1iiUl4743Ul6OFoPGU/YIvS2/tvMeBo8=	\N	f	20286380-9	SEBASTIAN ALFONSO	RIVEROS SIRVENT	f	t	2018-03-17 04:24:41.818948-03	sriveross@udd.cl	{"promocion": "2018"}
72	pbkdf2_sha256$100000$XHgG2v2fOAi4$TvhFsDUuwvc/QXAmcPtKb+U02U7b5b+H988gbQxeA94=	\N	f	20285476-1	KAI	MEIER SEEGER	f	t	2018-03-17 04:24:41.978704-03	kmeiers@udd.cl	{"promocion": "2018"}
73	pbkdf2_sha256$100000$MwWko37q5UkY$rkMeJ5FWbY3SNng+9paaig1nqKZMYQY4Qz2ZVi4Gwr0=	\N	f	20365851-6	EMILIO ANTONIO	TALADRIZ GITTERMANN	f	t	2018-03-17 04:24:42.14133-03	etaladrizg@udd.cl	{"promocion": "2018"}
74	pbkdf2_sha256$100000$7j3OiHIEr6Q7$Gx+rj2NFt5uK2foAmNhgMQTvMC9L+cnnYlZ3VaDOihw=	\N	f	20214676-7	JOSE ANTONIO	MORALES RAMIREZ	f	t	2018-03-17 04:24:42.286726-03	jomoralesr@udd.cl	{"promocion": "2018"}
75	pbkdf2_sha256$100000$h8OBsMzykOm7$WS3ccGZXPFqanQn8cA0lytSWSrKL5Ebwchp7HqCPPLo=	\N	f	20264396-5	VALENTINA DEYZA	HODGE HERNANDEZ	f	t	2018-03-17 04:24:42.439712-03	vhodgeh@udd.cl	{"promocion": "2018"}
76	pbkdf2_sha256$100000$YFavTn4ACBra$/aB9Tv1a0WlhL0xLfjqvEyUT76PYqalfw7Of0mQG51Q=	\N	f	20286008-7	SOFIA EMMA	MIRANDA SERRANO	f	t	2018-03-17 04:24:42.601757-03	smirandas@udd.cl	{"promocion": "2018"}
77	pbkdf2_sha256$100000$WO3j21dWg2Q1$dPCllxVe9cfUvBQ0/bRbkgmadguANJFpyoRmIN0MPS4=	\N	f	20109878-5	FRANCISCA PAZ	MADRID ROMAN	f	t	2018-03-17 04:24:42.758074-03	fmadridr@udd.cl	{"promocion": "2018"}
78	pbkdf2_sha256$100000$oXPx6dAh32Xs$0hwjt/QxkSLvSOhu/dJm0f6Y8YzOSdpCf9PARrXdss8=	\N	f	20181108-2	DANIELA PAZ	MEYER SOLABARRIETA	f	t	2018-03-17 04:24:42.920921-03	dmeyers@udd.cl	{"promocion": "2018"}
79	pbkdf2_sha256$100000$Z1LNGZkJ6s5O$awBHpyY4GVnRQqGI64HjDe5pfa3TZA6eYJey8rcaBiA=	\N	f	20014492-9	VALENTINA	RESTREPO GONZALEZ	f	t	2018-03-17 04:24:43.067322-03	vrestrepog@udd.cl	{"promocion": "2018"}
80	pbkdf2_sha256$100000$9W8WIkzgtDqL$v5AU6myy6c9B6N2VrftKjizx1E2dOvHalXH9otJuoN8=	\N	f	20074430-6	AUGUSTIN	BOETSCH DEPASSIER	f	t	2018-03-17 04:24:43.243871-03	auboetschd@udd.cl	{"promocion": "2018"}
81	pbkdf2_sha256$100000$gJ5r9mgtrrVC$nLewGjjgVlUxFLYXztuMzL6E+vzYVcDq49Y9VsKbFu0=	\N	f	20109298-1	SOFIA MARLENE	VERA WERB	f	t	2018-03-17 04:24:43.422322-03	sveraw@udd.cl	{"promocion": "2018"}
82	pbkdf2_sha256$100000$f3AbuBFBKLpV$lsiFr5Z5enp4yF/CHSpJAHCZ2ooYxZJuSauK1Az3gIg=	\N	f	20243029-5	SANTIAGO ERNESTO	FERNANDEZ ERRAZURIZ	f	t	2018-03-17 04:24:43.583815-03	safernandeze@udd.cl	{"promocion": "2018"}
83	pbkdf2_sha256$100000$qRZf8gVxSAZM$0atYf22c0YueTx+V8gczAdSoLoYISz5AKXrVXwCTUcU=	\N	f	20056658-0	PAULA ALEJANDRA	GONZALEZ OVALLE	f	t	2018-03-17 04:24:43.737602-03	paugonzalezo@udd.cl	{"promocion": "2018"}
84	pbkdf2_sha256$100000$Z8Nhx1oX8t6Y$XDyF6WW+lcMzTzCYcp6OVEFDj69UiTYoQQJLaaZIZKs=	\N	f	20283427-2	SILVANA	BURSIC PERAZZO	f	t	2018-03-17 04:24:43.905727-03	sbursicp@udd.cl	{"promocion": "2018"}
85	pbkdf2_sha256$100000$KipvZdPG7aIN$BoXX56Z5NnTXgEoOeIB7BK1oVT+NTyixOz5dKIDoYuk=	\N	f	20165103-4	ANDRES	WAGNER DE LA CERDA	f	t	2018-03-17 04:24:44.078877-03	awagnerd@udd.cl	{"promocion": "2018"}
86	pbkdf2_sha256$100000$svra10vD1tQj$jPlKyIfmtjzpirrkm+Tl/vBDDuPt1EZUkFj7/cQrNY8=	\N	f	20075892-7	MACARENA	LABRANQUE ASTORGA	f	t	2018-03-17 04:24:44.247185-03	mlabranquea@udd.cl	{"promocion": "2018"}
87	pbkdf2_sha256$100000$KeEI6jMJR5L0$pRGAHnHEk6LPO016gZW6zIrrLeVHgmv1idnWBqTb0Us=	\N	f	20443820-K	MARIO ANDRES	QUIROZ BECERRA	f	t	2018-03-17 04:24:44.409805-03	mquirozb@udd.cl	{"promocion": "2018"}
88	pbkdf2_sha256$100000$2x03SiMUfBPR$+x8BNqQ1WLUZXdMmRGRFJmfIXzjq6lZyDlYsxjGOT8o=	\N	f	20073557-9	BASTIAN IGNACIO	OCHOA MIRANDA	f	t	2018-03-17 04:24:44.573372-03	bochoam@udd.cl	{"promocion": "2018"}
89	pbkdf2_sha256$100000$73xSBKWfUbDN$khMEXjT5AYQLi2MxrCbObNytaI8vicjxSfUy7+37NHI=	\N	f	22596139-5	DANIEL ALEJANDRO	SOLANO GONZALEZ	f	t	2018-03-17 04:24:44.774058-03	dsolanog@udd.cl	{"promocion": "2018"}
90	pbkdf2_sha256$100000$82aSLNUldfdj$eYZyuSWtW+7u5l1ztd9LmAnU5Exle7rr4yCOL8ZZIK0=	\N	f	20443795-5	JOSEFA BELEN	ORTIZ FERNANDEZ	f	t	2018-03-17 04:24:44.949214-03	jortizf@udd.cl	{"promocion": "2018"}
91	pbkdf2_sha256$100000$gqaKGo0spdjp$MAJ7VD8wd1jXsO51LLIgogcf2j7eAED8l3rgOVs2QSw=	\N	f	20084263-4	NICOLÁS	DUNFORD ALOMAR	f	t	2018-03-17 04:24:45.111705-03	ndunforda@udd.cl	{"promocion": "2018"}
92	pbkdf2_sha256$100000$3aP4LWF6GTsH$nIYcEyNY1gG7xr+AZESjxZlZsCKworyFNGheGTt29kY=	\N	f	20107583-1	JAVIERA VICTORIA	RAMIREZ SILVA	f	t	2018-03-17 04:24:45.28531-03	javiramirezs@udd.cl	{"promocion": "2018"}
93	pbkdf2_sha256$100000$YdX5uVgvevuF$/UZwiqEo1FBb1AVWCCbPERYxw+kviApRu6JCFk7NOP4=	\N	f	22229207-7	VICENTE JOSE	MUÑOZ ARTEAGA	f	t	2018-03-17 04:24:45.436876-03	vicmunoza@udd.cl	{"promocion": "2018"}
94	pbkdf2_sha256$100000$hDOuU78FdCO3$id+DTfCfCOurO9f7tDhkwJ36Bz2ovp+59ROyHsn6fnQ=	\N	f	19638715-3	FRANCISCO JOSE	GUZMAN PILASI	f	t	2018-03-17 04:24:45.595929-03	frguzmanp@udd.cl	{"promocion": "2018"}
95	pbkdf2_sha256$100000$cNBRsyk0SuLW$bndc261/rfRlmMTFi4vzMYqwfOuGSc8ctcCbcOPfhkA=	\N	f	20076120-0	SEBASTIAN EDUARDO	KUTSCHER ARANCIBIA	f	t	2018-03-17 04:24:45.750131-03	skutschera@udd.cl	{"promocion": "2018"}
96	pbkdf2_sha256$100000$V1k7QHRJkLhK$oxdV2EvW+gOxpeq8Clp+Ams2QopfqLvT6Owu4rQ5228=	\N	f	20298099-6	CARLA	LOZANO GUILLEMINOT	f	t	2018-03-17 04:24:45.911324-03	clozanog@udd.cl	{"promocion": "2018"}
97	pbkdf2_sha256$100000$gqC1owTmoZr5$zYYKvCzla69IhlUTF8YTbsFJAL8Xo8WYARyRDtfjU2k=	\N	f	20298628-5	MARIA FRANCISCA	HERNANDEZ KEJAYA	f	t	2018-03-17 04:24:46.062293-03	mahernandezk@udd.cl	{"promocion": "2018"}
98	pbkdf2_sha256$100000$VU19IBCFzYpn$HG14PDrPZyU7H8MCUrNL9PqKRx/mIWrwPZ4QMojFq+I=	\N	f	19838845-9	NICOLAS IGNACIO	BARRIGA DIAZ	f	t	2018-03-17 04:24:46.219497-03	nbarrigad@udd.cl	{"promocion": "2018"}
99	pbkdf2_sha256$100000$YeImZob5ycxL$fa3MtKpMbVkUlZh1F8eXdDgqwXp/TpRZnKbjuWfIu5w=	\N	f	20168472-2	ISIDORA ANTONIA	BAHRS CHAVEZ	f	t	2018-03-17 04:24:46.379156-03	ibahrsc@udd.cl	{"promocion": "2018"}
100	pbkdf2_sha256$100000$hs9FhobTBvZM$3zuTfySXL1Eci+ZhjP924eHBdWlzjaXRo87qk0l4524=	\N	f	19640079-6	FERNANDA ISIDORA	MASSUH RUEDLINGER	f	t	2018-03-17 04:24:46.554078-03	femassuhr@udd.cl	{"promocion": "2018"}
101	pbkdf2_sha256$100000$ZzywQAG8B33M$H9URuzmAN7lU0Pc9jS0/jcLNKmAx3P+F+ayZAp3Tcv0=	\N	f	20299843-7	AMANDA	ROMERO GILI	f	t	2018-03-17 04:24:46.71682-03	amromerog@udd.cl	{"promocion": "2018"}
102	pbkdf2_sha256$100000$76O9vZ8cnJzx$ElwdIthOjZpEm2V0ZWJymZMqlqasucgVfuaAsaFIgdc=	\N	f	20009368-2	ESPERANZA CATALINA	GEBRIE FUENTES	f	t	2018-03-17 04:24:46.895114-03	egebrief@udd.cl	{"promocion": "2018"}
103	pbkdf2_sha256$100000$kE8SLiWrym0m$nUUesT66ePOG+U+XoGuA2cpGIv4fJyippT8Wj2W6vVc=	\N	f	20075605-3	EMILIA	MORO SILVA	f	t	2018-03-17 04:24:47.064851-03	emoros@udd.cl	{"promocion": "2018"}
104	pbkdf2_sha256$100000$PaennQGG9iPT$/9dF9FXgc/q7V3WGDQZuNODNeUuU+MyZ7gixhvwPyUA=	\N	f	19889535-0	FELIPE	VIAL DONOSO	f	t	2018-03-17 04:24:47.219298-03	fviald@udd.cl	{"promocion": "2018"}
105	pbkdf2_sha256$100000$NM4tOpJ8Duyj$DEKlprCsuJOJiYU1ghx5O5QnpAN/biK+T9mt75oYvb4=	\N	f	20427272-7	DANIELA ANTONIA	BALTRA MARTINEZ	f	t	2018-03-17 04:24:47.385078-03	dbaltram@udd.cl	{"promocion": "2018"}
106	pbkdf2_sha256$100000$RrTT6HZQ741q$RIWNopbqdM4wK0SrHzKqcqNNRU+UEnbHuT2ma0MJoBM=	\N	f	20073021-6	VALENTINA FERNANDA	MIRANDA ALVAREZ	f	t	2018-03-17 04:24:47.551753-03	vmirandaa@udd.cl	{"promocion": "2018"}
107	pbkdf2_sha256$100000$GyLfjRIVeeq1$nPfQT/g6VPhkdQRirw90wUKTBXkmWSe4yhqBkfyYEwQ=	\N	f	19891503-3	RODRIGO ARTURO	SEISDEDOS RUISEÑOR	f	t	2018-03-17 04:24:47.714834-03	rseisdedosr@udd.cl	{"promocion": "2018"}
108	pbkdf2_sha256$100000$x7LCa2N0oWRU$dRRpTZnQxSWeyGBghGv4ijIS/nN1GZ+4AqaYQnrtzDI=	\N	f	20163623-K	PABLO ANDRES	EDWARDS CONSIGLIERE	f	t	2018-03-17 04:24:47.876852-03	pedwardsc@udd.cl	{"promocion": "2018"}
109	pbkdf2_sha256$100000$5sXI06b2UWi6$/4QIanF878RiAR+oaCGPCEUXpXgCGHCnRbd0FjXYMBc=	\N	f	20075797-1	MARIA JOSEFA	ACEVEDO ETCHEBERRIGARAY	f	t	2018-03-17 04:24:48.036757-03	macevedoe@udd.cl	{"promocion": "2018"}
110	pbkdf2_sha256$100000$PCPAg9KdQ0Sj$rTw5l2f1vksTzpckLOFBXxUCSTE5Ju+t+sodWrXFzRA=	\N	f	20284732-3	MARIA TRINIDAD	GARCIA MALAGAMBA	f	t	2018-03-17 04:24:48.206723-03	mariatrgarciam@udd.cl	{"promocion": "2018"}
111	pbkdf2_sha256$100000$bxXepqAa3DKe$3985lWMXMSQeQon55s8NIRPrKsHKpIjt1UZc9IK8xtA=	\N	f	20264536-4	CAMILA FERNANDA	GUZMAN AYUB	f	t	2018-03-17 04:24:48.381307-03	camguzmana@udd.cl	{"promocion": "2018"}
112	pbkdf2_sha256$100000$DdXEjUnFUmX5$829ABMrhFt2PQHQYSWb2oyKMDvtfcCWhgd6X83aqHQQ=	\N	f	19639018-9	CAMILA	LETTER SOCIAS	f	t	2018-03-17 04:24:48.559502-03	cletters@udd.cl	{"promocion": "2018"}
113	pbkdf2_sha256$100000$iMZMFw7YHtwH$STT2KJP7V2IUD6s2QnUNx2lJmR7KMxsD2KfnenHEIB4=	\N	f	19952500-K	THOMAS WILLIAM	PUGH ARACENA	f	t	2018-03-17 04:24:48.712876-03	tpugha@udd.cl	{"promocion": "2018"}
114	pbkdf2_sha256$100000$qrDQNNOUWAAh$52fH3Sr3TBzN8z5Bw1veb4h4xXSggws2Kj8JqiglsyE=	\N	f	20163642-6	CLARA	BALMACEDA ACHURRA	f	t	2018-03-17 04:24:48.880959-03	cbalmacedaa@udd.cl	{"promocion": "2018"}
115	pbkdf2_sha256$100000$wfIIsLbwkolF$xQibA2YeeyoxbbRq0nm0Eqid/rhH2gLEsfOEeVuCj4Y=	\N	f	19863852-8	CRISTOBAL ROBERTO	CLEMENT ELLER	f	t	2018-03-17 04:24:49.039764-03	cclemente@udd.cl	{"promocion": "2018"}
116	pbkdf2_sha256$100000$EHziV98KePkL$mIjydttK1sIPxIKaH++NdabdaeDjw1uQTrxAPBdsPcw=	\N	f	19840728-3	MAXIMILIANA	GARCIA VERGARA	f	t	2018-03-17 04:24:49.216308-03	maxgarciav@udd.cl	{"promocion": "2018"}
117	pbkdf2_sha256$100000$E2rF4c3gYnnd$JChQ8HsEeIG473Un/+JWX5KSRXrZfePRxPbotxxWqU8=	\N	f	20075497-2	CARLOS GONZALO	PRIETO CUADRADO	f	t	2018-03-17 04:24:49.377032-03	caprietoc@udd.cl	{"promocion": "2018"}
118	pbkdf2_sha256$100000$nR0usYl07YeU$/tU1jSxvGiBHm9PshiBL2HyHPB01lK4XfKBbvrkm87w=	\N	f	20161206-3	LENDELI	DIAZ ESTRADA	f	t	2018-03-17 04:24:49.538069-03	lediaze@udd.cl	{"promocion": "2018"}
119	pbkdf2_sha256$100000$aMXjR4w2M3NR$B/raVfyd0qCvxSZV9RMGLJOdArx3sk4NmwxvO/+LFnY=	\N	f	20269795-K	MAGDALENA BEATRIZ	RAMIREZ RODRIGUEZ	f	t	2018-03-17 04:24:49.724853-03	magramirezr@udd.cl	{"promocion": "2018"}
120	pbkdf2_sha256$100000$1NQ2LIYhaJVm$Q1lJvOhUwbf67an7aR10IB/6YXZknNMc+KyBPe8jNFI=	\N	f	20298738-9	JOSEFA ANAIS	OLHABERRY CARRASCO	f	t	2018-03-17 04:24:49.888869-03	jolhaberryc@udd.cl	{"promocion": "2018"}
121	pbkdf2_sha256$100000$u7sB0DeAg04a$B9PQQ1QmvXC5ZuTRWZwQgit+hCV88HrHVtWJnNrYYeQ=	\N	f	20286655-7	ISIDORA ALEXANDRA	NAVARRO ALLENDE	f	t	2018-03-17 04:24:50.045937-03	inavarroa@udd.cl	{"promocion": "2018"}
122	pbkdf2_sha256$100000$1Tlm00Rmrscz$nt6RdPnNycI7DhxL/oYXWY1IYLq+xwMRLUWkymDqB6s=	\N	f	20285214-9	CLEMENTE AUGUSTO	SAAVEDRA NEF	f	t	2018-03-17 04:24:50.209209-03	clsaavedran@udd.cl	{"promocion": "2018"}
123	pbkdf2_sha256$100000$4srZvAc0bGyJ$CjTKXebhCMTlTLKZsUgoBS2zaVhHb+P8XiuBSEM3rlE=	\N	f	19863279-1	MATHIAS IGNACIO	CAVIERES BARRIA	f	t	2018-03-17 04:24:50.367964-03	mcavieresb@udd.cl	{"promocion": "2018"}
124	pbkdf2_sha256$100000$Ka93PcyL631R$Ykml/erY3l68+364DOVfXzzk6iVKXEVo+gc4h1Kaha8=	\N	f	20326025-3	SASHA MARIA	MANRIQUE ESTRADA	f	t	2018-03-17 04:24:50.541917-03	smanriquee@udd.cl	{"promocion": "2018"}
125	pbkdf2_sha256$100000$SinArKYfyvBg$vpCCZDMkEKOv17x5U5Qvvn9j0mjDETRH606FFuwQL24=	\N	f	20284025-6	SEBASTIAN IGNACIO	CARMONA SORREL	f	t	2018-03-17 04:24:50.701835-03	scarmonas@udd.cl	{"promocion": "2018"}
126	pbkdf2_sha256$100000$1o40opSN8iH1$UQNhSJzmP0OENsrW3dHjVfJKdBsIjyFt2pwtOlKydng=	\N	f	20285661-6	ISIDORA PAZ	TRAMON HERRERIAS	f	t	2018-03-17 04:24:50.87428-03	itramonh@udd.cl	{"promocion": "2018"}
127	pbkdf2_sha256$100000$ZgksrZXeruTQ$GV1dXbH7O5PpOqtR+wj+ohrKGZO+2ifkGR1J9kd9+k0=	\N	f	19972315-4	MATIAS	ACUÑA ESPINOZA	f	t	2018-03-17 04:24:51.042036-03	macunae@udd.cl	{"promocion": "2018"}
128	pbkdf2_sha256$100000$9m7dNAfIIhp1$p2sNr7BADllMX/Vb3qg4l/WUtBvewT6I3V1e6+0utvY=	\N	f	20663866-4	JOSE ANDRES	LOPEZ MORGAN	f	t	2018-03-17 04:24:51.216246-03	joslopezm@udd.cl	{"promocion": "2018"}
129	pbkdf2_sha256$100000$lF9yWfn4HzAb$gHenJnjkfSmkbF/84Jtl5dYzhIH7pgESJl7LU1KdgfA=	\N	f	20238183-9	MARTINA EMILIA	PERONDI CASTAÑO	f	t	2018-03-17 04:24:51.384989-03	mperondic@udd.cl	{"promocion": "2018"}
130	pbkdf2_sha256$100000$wfikHp4aDIOH$ZvaS7KypJQq8KQ3bkQNEDP1HhCQ5KeSeKardpuvQXi8=	\N	f	20165157-3	PABLO ALFREDO LUIS	UGARTE SILVA	f	t	2018-03-17 04:24:51.540118-03	pugartes@udd.cl	{"promocion": "2018"}
131	pbkdf2_sha256$100000$4UFxiFDXaVrI$qvSWYLa+V+GTd7g2VW9y6546iW1e+diYaayJ76FXgas=	\N	f	19638649-1	MATIAS	AUAD LARRAIN	f	t	2018-03-17 04:24:51.70728-03	maauadl@udd.cl	{"promocion": "2018"}
132	pbkdf2_sha256$100000$moTwEhmMljlW$dv4OZKVzHBduKbqLa3KBnf6nAUEpKgA8NtQ+OZeAXuE=	\N	f	19978478-1	JAVIERA MONTSERRAT	SALAS DELGADO	f	t	2018-03-17 04:24:51.878822-03	jsalasd@udd.cl	{"promocion": "2018"}
133	pbkdf2_sha256$100000$1xUEDL9Pap4x$33tTTb2JQMqDuXDUZvfZ8nDTYUVoRiJcuJ7I6bLT4cM=	\N	f	20164736-3	ANTONIA DE JESUS	URRUTIA HERRERA	f	t	2018-03-17 04:24:52.030687-03	aurrutiah@udd.cl	{"promocion": "2018"}
134	pbkdf2_sha256$100000$oSUuQZiLScyJ$PzcQ/EL+cnr3vvEj64Q5WBCh5GwgDjFSvfp3jViB/Z4=	\N	f	20073793-8	JORGE ARTURO	UGALDE ZINCKE	f	t	2018-03-17 04:24:52.180486-03	jugaldez@udd.cl	{"promocion": "2018"}
135	pbkdf2_sha256$100000$WB05D3kt100M$A3lYCGjgj0Lnk/IHtkXXWuHmFnvQc9moj0HnNu7BNTE=	\N	f	19639766-3	VERONICA PAZ	ZAPATA VENEGAS	f	t	2018-03-17 04:24:52.351164-03	vzapatav@udd.cl	{"promocion": "2018"}
136	pbkdf2_sha256$100000$cUouTIzVfCJb$DMDh5sDqS1p5a36bIU5dpQeaBGE8CipBWEAEJtmvg4c=	\N	f	20165371-1	SANTIAGO	ASPILLAGA VERGARA	f	t	2018-03-17 04:24:52.507844-03	saspillagav@udd.cl	{"promocion": "2018"}
137	pbkdf2_sha256$100000$NyjDZtPmMibj$EP3bb1SZ2Puuz410WMautxOx32X1sy4M8imMzqNJPKc=	\N	f	20427629-3	TOMAS ANDRES	URBINA BECERRA	f	t	2018-03-17 04:24:52.666876-03	turbinab@udd.cl	{"promocion": "2018"}
138	pbkdf2_sha256$100000$3IcsGi3TI37k$j5/R+SjoVISk1MWCLoVbG/F+dmmzOeJX+UwVx6hudC0=	\N	f	20237112-4	JAVIERA CATALINA	OCAÑA CASTILLO	f	t	2018-03-17 04:24:52.839123-03	jocanac@udd.cl	{"promocion": "2018"}
139	pbkdf2_sha256$100000$CGdm6u6bZOqp$KHzfqEObqL4cYbnG71ZTy+vobFGtlR0KGExtiBQz3mY=	\N	f	20298581-5	MATIAS ANDRES	TAPIA CANALES	f	t	2018-03-17 04:24:53.022841-03	mattapiac@udd.cl	{"promocion": "2018"}
140	pbkdf2_sha256$100000$9SKV5o03x4Dz$exN9KA0ZkqaQNKS/qxLUP3ZUMKyWMDVm2aYthskPJZw=	\N	f	20299521-7	LUKAS MATÍAS	ORMEÑO SERRANO	f	t	2018-03-17 04:24:53.197681-03	luormenos@udd.cl	{"promocion": "2018"}
141	pbkdf2_sha256$100000$p1S3q99Yp2gU$u2Qh0JLd1dU7Lvv19g2bGKfVXxLTKgKZK8Ev2KEhGwk=	\N	f	20212631-6	KATIA ANDREA	VOIGT KARAMANOS	f	t	2018-03-17 04:24:53.349351-03	kvoigtk@udd.cl	{"promocion": "2018"}
142	pbkdf2_sha256$100000$jayRkZLh87OP$94xeRoT7v2/6CStZFuotSumFRJZE6gN1shwIKwruDNA=	\N	f	22038991-K	NATHAN	DONSKOY SISSA	f	t	2018-03-17 04:24:53.526237-03	ndonskoys@udd.cl	{"promocion": "2018"}
143	pbkdf2_sha256$100000$ZYMuqhgfW9Qj$SaRIF1bsAjCyeUo+pVIhtexDvr4k/wfO4GJdcRZ11rU=	\N	f	20120242-6	FLORENCIO ANDRES RUBEN	PRATS DIAZ	f	t	2018-03-17 04:24:53.679059-03	fpratsd@udd.cl	{"promocion": "2018"}
144	pbkdf2_sha256$100000$DtDniog2Ysf3$5ajtnCwstWFIWZVL8W8kt31T8BINOTdGyyTWAkO+tf8=	\N	f	20298345-6	RENATA SOFIA	CONTESSE FAUNDEZ	f	t	2018-03-17 04:24:53.850578-03	rcontessef@udd.cl	{"promocion": "2018"}
145	pbkdf2_sha256$100000$q4iSJm7OoOmz$/wZ2Ya0FBne1gpagsh/mEQ8ucVHUmOG1aR4H21DQc4o=	\N	f	19830134-5	NILECHT ANDRES	GARRIDO ANTUNEZ	f	t	2018-03-17 04:24:54.020881-03	ngarridoa@udd.cl	{"promocion": "2018"}
146	pbkdf2_sha256$100000$tqoQZfCMRU4f$gJroxH2geD3c8RV0/FMVsOIG6OWD1PqrkidRDedivx0=	\N	f	19880894-6	MARIA IGNACIA	HERMOSILLA MUÑOZ	f	t	2018-03-17 04:24:54.185343-03	mhermosillam@udd.cl	{"promocion": "2018"}
147	pbkdf2_sha256$100000$g1xPjNzQQg7c$3jybJJjo1Wi6yyRWxhzYyfQ64ES9FcA3RJtmN6Q/k8o=	\N	f	19890437-6	DIEGO JOSE	LAMBERT LEON	f	t	2018-03-17 04:24:54.335634-03	dlambertl@udd.cl	{"promocion": "2018"}
148	pbkdf2_sha256$100000$UMtjPU75pI06$E46dy+OMv6ZQDcs4/y/4keX7e1c5/JRMExXX1STrM7g=	\N	f	20164207-8	PABLO	AMUNATEGUI VIAL	f	t	2018-03-17 04:24:54.49205-03	pamunateguiv@udd.cl	{"promocion": "2018"}
149	pbkdf2_sha256$100000$6pZJXQlFHc4d$VrVFmJ/WT8HvG+iv7uMy5bkVawgMzRhWF9+Uubgk6w4=	\N	f	20165457-2	CATALINA PAZ	HOLMES LANAS	f	t	2018-03-17 04:24:54.646703-03	cholmesl@udd.cl	{"promocion": "2018"}
150	pbkdf2_sha256$100000$nIiApO2y5SXg$2gAceiUrnTm1Uzz2qBxY6BXnULO6siBe1GmJ5XTLIpE=	\N	f	20117875-4	JORGE FELIPE	ABELLO ORTIZ	f	t	2018-03-17 04:24:54.813571-03	jabelloo@udd.cl	{"promocion": "2018"}
151	pbkdf2_sha256$100000$NZB2utT6Wv2i$ASD9JkRZDCEpR8siF+5C1VRCOwklUi1VX8+Xhwj8Xms=	\N	f	19743843-6	ADOLFO ANTONIO	CALDERON SALAS	f	t	2018-03-17 04:24:54.97523-03	adcalderons@udd.cl	{"promocion": "2018"}
152	pbkdf2_sha256$100000$Jha5HByzL0QG$+mJpJga7gL7d8fX/QEUsoSK+neHohK5Tbr6+P2TSSR0=	\N	f	20050083-0	AGUSTIN ALFREDO	SCHMAUCK MEDINA	f	t	2018-03-17 04:24:55.125805-03	aschmauckm@udd.cl	{"promocion": "2018"}
153	pbkdf2_sha256$100000$ovatnl5O4n88$4FNAayi2x7F5TZUY2i1ROAgnJjcIZ46uLjUZkb4+tKE=	\N	f	19959022-7	VALENTINA ANGELICA	ARANEDA ROJAS	f	t	2018-03-17 04:24:55.292025-03	varanedar@udd.cl	{"promocion": "2018"}
154	pbkdf2_sha256$100000$45qYATMFtAAe$PMtKLls2wrBKHEWnPBr/uLXGGbG0yiyHcQ2h+INi1V4=	\N	f	18745954-0	PHILIP ANTOINE	MARCOS CANDIA	f	t	2018-03-17 04:24:55.449993-03	pmarcosc@udd.cl	{"promocion": "2018"}
155	pbkdf2_sha256$100000$ocScvcS9aCWw$PmFNTt1Aoub01vPXiZ1Hqjqnkc4ZfM36pVnKnOBZUJY=	\N	f	19567726-3	ISIDORA	ANRIQUEZ MAURICIO	f	t	2018-03-17 04:24:55.613932-03	ianriquezm@udd.cl	{"promocion": "2018"}
156	pbkdf2_sha256$100000$U7EPWU0NOPjq$X/WDj6HhTH8ZSjRMnHsVfKIOxDGmDOuloo5NPHRTy7o=	\N	f	19891206-9	MATIAS IGNACIO	GODOY CAZOR	f	t	2018-03-17 04:24:55.777274-03	matgodoyc@udd.cl	{"promocion": "2018"}
157	pbkdf2_sha256$100000$VG3gdnZNAQJS$AcEUt5LoDAhSBvN/2U0zfYWspU4xiClUCjJXnpviAzI=	\N	f	9562666-1	VALENTINA 	NUÑEZ BARAZARTE	f	t	2018-03-17 04:24:55.931757-03	vanunezb@udd.cl	{"promocion": "2018"}
158	pbkdf2_sha256$100000$If0CpozLgaQM$JDsO+6YBypnSiv/lscckWOdl55NHC9K5ZcsuYvb7cDI=	\N	f	19668990-7	CRISTOBAL ALEJANDRO	BRICEÑO RAMIREZ	f	t	2018-03-17 04:24:56.087058-03	cbricenor@udd.cl	{"promocion": "2018"}
159	pbkdf2_sha256$100000$Q9UzOvCjraxm$RuJW9tl4Nn4hOYgO9cbLGUL7DPagrVFyTVa7fYVANiU=	\N	f	19245452-2	BERNARDITA CAROLINA	MASSUH RUEDLINGER	f	t	2018-03-17 04:24:56.249531-03	bmassuhr@udd.cl	{"promocion": "2018"}
160	pbkdf2_sha256$100000$pgk6ajUD4s8F$FSfdWWz0GESfnh4OIvJKcmOS67o4RxiVuaakBSuFWPA=	\N	f	19951733-3	JOAQUIN VICENTE	PALACIOS SANTANA	f	t	2018-03-17 04:24:56.40716-03	jpalacioss@udd.cl	{"promocion": "2018"}
161	pbkdf2_sha256$100000$q3dsq0mOVYA2$OJi0crqggie1hKKOhXANRD7mNBtrYslZrfvuxChREw8=	\N	f	20185515-2	IGNACIO JAVIER	PALMA MORAGA	f	t	2018-03-17 04:24:56.569831-03	ipalmam@udd.cl	{"promocion": "2018"}
162	pbkdf2_sha256$100000$3cyQt1w32KR2$otXlyAM6vuEdrEqfgJD6L+Hq032szKjNUWeEKeODHOk=	\N	f	20109736-3	EMILIO	MAHNS WOOD	f	t	2018-03-17 04:24:56.728084-03	emahnsw@udd.cl	{"promocion": "2018"}
163	pbkdf2_sha256$100000$vKmcyWulydqF$53OJRIqEfLTzrYJCak27JUcKJqbDcoTFKbQ/UVKTH3E=	\N	f	19084253-3	JOSÉ EMILIO	MEDEL HORMAZÁBAL	f	t	2018-03-17 04:24:56.882669-03	jmedelh@udd.cl	{"promocion": "2018"}
164	pbkdf2_sha256$100000$L7YMw5nkkqTo$5Mki639bb+UxXGceq8kt8Q4kYC6g097rG3D+IcJTu1I=	\N	f	19958903-2	MARÍA FERNANDA	MILLANAO VILUGRÓN	f	t	2018-03-17 04:24:57.054061-03	mmillanaov@udd.cl	{"promocion": "2018"}
165	pbkdf2_sha256$100000$fmB3s95Mp4jq$OVhA5oKkm02wZ5YYBtswz6EV/wGcPhneLsE1TjWYJAk=	\N	f	17987777-5	JORGE IGNACIO	SOTO PAREJAS	f	t	2018-03-17 04:24:57.225301-03	josotop@udd.cl	{"promocion": "2018"}
166	pbkdf2_sha256$100000$SvZybhgsHCDk$QK3PIYGwvMPZjSq9GYHQtVF9JRPrs+y3S0CJoS7FmIA=	\N	f	19989477-3	CATALINA VIOLETA	RABANAL SIERRA	f	t	2018-03-17 04:24:57.381274-03	crabanals@udd.cl	{"promocion": "2018"}
167	pbkdf2_sha256$100000$fj5QXTd0XMwd$4qlrB5B5U8/2TxFwSb47SJJcIoom3GQy2kkWUgSaKXk=	\N	f	20178109-4	CATALINA ESPERANZA	LOPEZ SABABA	f	t	2018-03-17 04:24:57.549053-03	catlopezs@udd.cl	{"promocion": "2018"}
168	pbkdf2_sha256$100000$9kHrCHoaiC8i$YvXiNgCECittyccBofC8Bzn80484k/1lq2D3CTMrq2U=	\N	f	19084146-4	FILIPPO TOMAS	BORGHI PAGNUCCO	f	t	2018-03-17 04:24:57.714115-03	fborghip@udd.cl	{"promocion": "2018"}
169	pbkdf2_sha256$100000$B8tf53LhfupQ$dbDy1Ryc5NjDa/WQC2S9f2Ua5bytH59E0vY5jrPbNTo=	\N	f	19098896-1	ALEXANDRA GABRIELA	STUVEN LEAL	f	t	2018-03-17 04:24:57.874644-03	astuvenl@udd.cl	{"promocion": "2018"}
170	pbkdf2_sha256$100000$3NolIyEmuG96$FcbY4AoGcmkOB6fAsoLnT7/fSMKTzQ8uffToOhpA9T0=	\N	f	20011515-5	FLORENCIA PAZ	MARTINEZ BATTAINI	f	t	2018-03-17 04:24:58.030014-03	flmartinezb@udd.cl	{"promocion": "2018"}
171	pbkdf2_sha256$100000$kOs3cUYlYjaV$wW+oX4TQCd/iQHetb5204XTLL7gck+DsIQCzr1Y7gMc=	\N	f	19078966-7	ANTONIA	RIVERA DE LA MAZA	f	t	2018-03-17 04:24:58.197383-03	ariverad@udd.cl	{"promocion": "2018"}
\.


--
-- Data for Name: base_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: base_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: base_userprofilesprogram; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_userprofilesprogram (id, program_id, user_id) FROM stdin;
1	1	4
2	1	6
3	1	9
4	1	10
5	1	11
6	1	12
7	1	13
8	1	14
9	1	15
10	1	16
11	1	17
12	1	18
13	1	19
14	1	20
15	1	21
16	1	22
17	1	23
18	1	24
19	1	25
20	1	26
21	1	27
22	1	28
23	1	29
24	1	30
25	1	31
26	1	32
27	1	33
28	1	34
29	1	35
30	1	36
31	1	37
32	1	38
33	1	39
34	1	40
35	1	41
36	1	42
37	1	43
38	1	44
39	1	45
40	1	46
41	1	47
42	1	48
43	1	49
44	1	50
45	1	51
46	1	52
47	1	53
48	1	54
49	1	55
50	1	56
51	1	57
52	1	58
53	1	59
54	1	60
55	1	61
56	1	62
57	1	63
58	1	64
59	1	65
60	1	66
61	1	67
62	1	68
63	1	69
64	1	70
65	1	71
66	1	72
67	1	73
68	1	74
69	1	75
70	1	76
71	1	77
72	1	78
73	1	79
74	1	80
75	1	81
76	1	82
77	1	83
78	1	84
79	1	85
80	1	86
81	1	87
82	1	88
83	1	89
84	1	90
85	1	91
86	1	92
87	1	93
88	1	94
89	1	95
90	1	96
91	1	97
92	1	98
93	1	99
94	1	100
95	1	101
96	1	102
97	1	103
98	1	104
99	1	105
100	1	106
101	1	107
102	1	108
103	1	109
104	1	110
105	1	111
106	1	112
107	1	113
108	1	114
109	1	115
110	1	116
111	1	117
112	1	118
113	1	119
114	1	120
115	1	121
116	1	122
117	1	123
118	1	124
119	1	125
120	1	126
121	1	127
122	1	128
123	1	129
124	1	130
125	1	131
126	1	132
127	1	133
128	1	134
129	1	135
130	1	136
131	1	137
132	1	138
133	1	139
134	1	140
135	1	141
136	1	142
137	1	143
138	1	144
139	1	145
140	1	146
141	1	147
142	1	148
143	1	149
144	1	150
145	1	151
146	1	152
147	1	153
148	1	154
149	1	155
150	1	156
151	1	157
152	1	158
153	1	159
154	1	160
155	1	161
156	1	162
157	1	163
158	1	164
159	1	165
160	1	166
161	1	167
162	1	168
163	1	169
164	1	170
165	1	171
\.


--
-- Data for Name: base_userprofilesprogram_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_userprofilesprogram_profiles (id, userprofilesprogram_id, profile_id) FROM stdin;
1	3	1
2	4	1
3	5	1
4	6	1
5	7	1
6	8	1
7	9	1
8	10	1
9	11	1
10	12	1
11	13	1
12	14	1
13	15	1
14	16	1
15	17	1
16	18	1
17	19	1
18	20	1
19	21	1
20	22	1
21	23	1
22	24	1
23	25	1
24	26	1
25	27	1
26	28	1
27	29	1
28	30	1
29	31	1
30	32	1
31	33	1
32	34	1
33	35	1
34	36	1
35	37	1
36	38	1
37	39	1
38	40	1
39	41	1
40	42	1
41	43	1
42	44	1
43	45	1
44	46	1
45	47	1
46	48	1
47	49	1
48	50	1
49	51	1
50	52	1
51	53	1
52	54	1
53	55	1
54	56	1
55	57	1
56	58	1
57	59	1
58	60	1
59	61	1
60	62	1
61	63	1
62	64	1
63	65	1
64	66	1
65	67	1
66	68	1
67	69	1
68	70	1
69	71	1
70	72	1
71	73	1
72	74	1
73	75	1
74	76	1
75	77	1
76	78	1
77	79	1
78	80	1
79	81	1
80	82	1
81	83	1
82	84	1
83	85	1
84	86	1
85	87	1
86	88	1
87	89	1
88	90	1
89	91	1
90	92	1
91	93	1
92	94	1
93	95	1
94	96	1
95	97	1
96	98	1
97	99	1
98	100	1
99	101	1
100	102	1
101	103	1
102	104	1
103	105	1
104	106	1
105	107	1
106	108	1
107	109	1
108	110	1
109	111	1
110	112	1
111	113	1
112	114	1
113	115	1
114	116	1
115	117	1
116	118	1
117	119	1
118	120	1
119	121	1
120	122	1
121	123	1
122	124	1
123	125	1
124	126	1
125	127	1
126	128	1
127	129	1
128	130	1
129	131	1
130	132	1
131	133	1
132	134	1
133	135	1
134	136	1
135	137	1
136	138	1
137	139	1
138	140	1
139	141	1
140	142	1
141	143	1
142	144	1
143	145	1
144	146	1
145	147	1
146	148	1
147	149	1
148	150	1
149	151	1
150	152	1
151	153	1
152	154	1
153	155	1
154	156	1
155	157	1
156	158	1
157	159	1
158	160	1
159	161	1
160	162	1
161	163	1
162	164	1
163	165	1
\.


--
-- Data for Name: business_campus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_campus (id, name, code, description, is_deleted, created_ts, updated_ts) FROM stdin;
1	Santiago	STGO		f	2018-03-17 04:16:38.695-03	2018-03-17 04:16:38.695-03
\.


--
-- Data for Name: business_campus_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_campus_program (id, campus_id, program_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: business_period; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_period (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, start_date, end_date, program_id) FROM stdin;
1	01-2018	01-2018		f	2018-03-17 04:16:15.08-03	2018-03-17 04:16:15.08-03		2018-03-17	2018-06-15	1
\.


--
-- Data for Name: business_survey; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_survey (id, name, code, description, is_deleted, created_ts, updated_ts, checksum) FROM stdin;
1	Encuestra composición y forma	ecyf		f	2018-03-17 04:19:36.163-03	2018-03-17 04:19:36.163-03	
\.


--
-- Data for Name: business_survey_indicator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_survey_indicator (id, survey_id, indicator_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: core_indicator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_indicator (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, skill_id, subject_id) FROM stdin;
1	Composición	composicion		f	2018-03-17 04:19:33.276-03	2018-03-17 04:19:33.276-03		1	1
\.


--
-- Data for Name: core_level; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_level (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, program_id) FROM stdin;
1	Bachillerato	BACHILLERATO		f	2018-03-17 04:17:31.311-03	2018-03-17 04:17:31.311-03		1
\.


--
-- Data for Name: core_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_program (id, name, code, description, is_deleted, created_ts, updated_ts, node_id) FROM stdin;
1	ARQUITECTURA	1400S		f	2018-03-17 04:16:09.297-03	2018-03-17 04:16:09.297-03	1
\.


--
-- Data for Name: core_skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_skill (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, skill_group_id) FROM stdin;
1	COMPOSICIÓN Y COLOR	composicion_y_color		f	2018-03-17 04:19:29.232-03	2018-03-17 04:19:29.232-03		1
\.


--
-- Data for Name: core_skillleveldescription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_skillleveldescription (id, name, code, description, is_deleted, created_ts, updated_ts, level_id, skill_id) FROM stdin;
\.


--
-- Data for Name: core_skillsgroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_skillsgroup (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, program_id) FROM stdin;
1	Forma	forma		f	2018-03-17 04:19:27.494-03	2018-03-17 04:19:27.494-03		1
\.


--
-- Data for Name: core_subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_subject (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, level_id, subjects_group_id) FROM stdin;
1	COMPOSICIÓN Y COLOR	CF01		f	2018-03-17 04:17:33.732-03	2018-03-17 04:17:33.732-03		1	1
\.


--
-- Data for Name: core_subjectsgroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_subjectsgroup (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, program_id) FROM stdin;
1	COMPOSICIÓN Y COLOR	CF01		f	2018-03-17 04:17:18.712-03	2018-03-17 04:17:18.712-03		1
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2018-03-17 04:14:53.918-03	1	UNIVERSIDAD (universidad)	1	[{"added": {}}]	32	3
2	2018-03-17 04:15:10.839-03	2	CARRERA (carrera)	1	[{"added": {}}]	32	3
3	2018-03-17 04:15:33.1-03	1	UNIVERSIDAD (universidad)	2	[]	32	3
4	2018-03-17 04:15:34.893-03	1	UDD 	1	[{"added": {}}]	31	3
5	2018-03-17 04:16:09.31-03	1	ARQUITECTURA 1400S	1	[{"added": {}}]	15	3
6	2018-03-17 04:16:15.097-03	1	01-2018 01-2018	1	[{"added": {}}]	11	3
7	2018-03-17 04:16:38.77-03	1	Santiago STGO	1	[{"added": {}}]	10	3
8	2018-03-17 04:17:18.723-03	1	COMPOSICIÓN Y COLOR CF01	1	[{"added": {}}]	20	3
9	2018-03-17 04:17:31.322-03	1	Bachillerato BACHILLERATO	1	[{"added": {}}]	14	3
10	2018-03-17 04:17:33.742-03	1	COMPOSICIÓN Y COLOR CF01	1	[{"added": {}}]	19	3
11	2018-03-17 04:19:27.511-03	1	Forma forma	1	[{"added": {}}]	18	3
12	2018-03-17 04:19:29.242-03	1	COMPOSICIÓN Y COLOR composicion_y_color	1	[{"added": {}}]	16	3
13	2018-03-17 04:19:33.287-03	1	Composición composicion	1	[{"added": {}}]	13	3
14	2018-03-17 04:19:36.213-03	1	Encuestra composición y forma ecyf	1	[{"added": {}}]	12	3
15	2018-03-17 04:19:39.905-03	1	AAC111 - COMPOSICIÓN Y COLOR 1400S_AAC111_1_2018_1_16-14	1	[{"added": {}}]	23	3
16	2018-03-17 04:19:49.422-03	1	AAC111 - COMPOSICIÓN Y COLOR 1400S_AAC111_1_2018_1_16-14	2	[{"changed": {"fields": ["teachers"]}}]	23	3
17	2018-03-17 04:23:51.829-03	1	student	1	[{"added": {}}]	8	3
18	2018-03-17 04:24:01.26-03	2	teacher	1	[{"added": {}}]	8	3
19	2018-03-17 04:24:09.161-03	5	admin	1	[{"added": {}}]	8	3
20	2018-03-17 04:27:16.550062-03	2	COMPOSICIÓN Y COLOR 1400S_AAC111_2_2018_1_16	1	[{"added": {}}]	23	3
21	2018-03-17 04:27:35.950382-03	2	AAC111 - COMPOSICIÓN Y COLOR 1400S_AAC111_2_2018_1_16	2	[{"changed": {"fields": ["name"]}}]	23	3
22	2018-03-17 04:27:55.38707-03	2	AAC111 - COMPOSICIÓN Y COLOR 1400S_AAC111_2_2018_1_16-14	2	[{"changed": {"fields": ["code"]}}]	23	3
23	2018-03-17 04:28:28.290422-03	3	COMPOSICIÓN Y COLOR 1400S_AAC111_3_2018_1_16-15	1	[{"added": {}}]	23	3
24	2018-03-17 04:28:41.487215-03	3	AAC111 - COMPOSICIÓN Y COLOR 1400S_AAC111_3_2018_1_16-15	2	[{"changed": {"fields": ["name"]}}]	23	3
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	base	user
7	base	parameter
8	base	profile
9	base	userprofilesprogram
10	business	campus
11	business	period
12	business	survey
13	core	indicator
14	core	level
15	core	program
16	core	skill
17	core	skillleveldescription
18	core	skillsgroup
19	core	subject
20	core	subjectsgroup
21	log	action
22	log	log
23	term	course
24	term	feedback
25	term	finalindicatorevaluation
26	term	finalscoreevaluation
27	term	tempfedbackscore
28	term	tempfeedbackmessage
29	term	tempfinalindicatorevaluation
30	term	tempscoreevaluation
31	topology	node
32	topology	nodetype
33	topology	nodetypeparent
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-03-17 04:06:59.864128-03
2	topology	0001_initial	2018-03-17 04:06:59.972212-03
3	core	0001_initial	2018-03-17 04:07:00.247855-03
4	contenttypes	0002_remove_content_type_name	2018-03-17 04:07:00.278811-03
5	auth	0001_initial	2018-03-17 04:07:00.3345-03
6	auth	0002_alter_permission_name_max_length	2018-03-17 04:07:00.349629-03
7	auth	0003_alter_user_email_max_length	2018-03-17 04:07:00.361717-03
8	auth	0004_alter_user_username_opts	2018-03-17 04:07:00.374381-03
9	auth	0005_alter_user_last_login_null	2018-03-17 04:07:00.385381-03
10	auth	0006_require_contenttypes_0002	2018-03-17 04:07:00.394499-03
11	auth	0007_alter_validators_add_error_messages	2018-03-17 04:07:00.40984-03
12	auth	0008_alter_user_username_max_length	2018-03-17 04:07:00.419725-03
13	auth	0009_alter_user_last_name_max_length	2018-03-17 04:07:00.432297-03
14	base	0001_initial	2018-03-17 04:07:00.634469-03
15	admin	0001_initial	2018-03-17 04:07:00.698396-03
16	admin	0002_logentry_remove_auto_add	2018-03-17 04:07:00.718605-03
17	business	0001_initial	2018-03-17 04:07:00.922007-03
18	log	0001_initial	2018-03-17 04:07:00.998354-03
19	sessions	0001_initial	2018-03-17 04:07:01.018709-03
20	term	0001_initial	2018-03-17 04:07:01.702846-03
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
e1ldf7y3aoleqqk5blzzixsyxbfgnca8	MDdjZGUwZDY4MzUxZjdmYzAxMzRhMjQ1OGM3ZmFmNDk2ZjM3MGYyNDp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwNTE5NDExNGI3Mzg4NTc2YTc1ZGQ3MmEyMDQ0NjQ2MDRkY2E3YjBlIn0=	2018-03-31 04:09:53.348-03
\.


--
-- Data for Name: log_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log_action (id, name, code, description, is_deleted, created_ts, updated_ts, checksum) FROM stdin;
\.


--
-- Data for Name: log_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log_log (id, is_deleted, created_ts, updated_ts, url, data, action_id, user_id) FROM stdin;
\.


--
-- Data for Name: term_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_course (id, name, code, description, is_deleted, created_ts, updated_ts, section, checksum, campus_id, period_id, subject_id, survey_id) FROM stdin;
1	AAC111 - COMPOSICIÓN Y COLOR	1400S_AAC111_1_2018_1_16-14		f	2018-03-17 04:19:39.858-03	2018-03-17 04:19:49.367-03	1		1	1	1	1
2	AAC111 - COMPOSICIÓN Y COLOR	1400S_AAC111_2_2018_1_16-14		f	2018-03-17 04:27:16.496023-03	2018-03-17 04:27:55.355147-03	2		1	1	1	1
3	AAC111 - COMPOSICIÓN Y COLOR	1400S_AAC111_3_2018_1_16-15		f	2018-03-17 04:28:28.242668-03	2018-03-17 04:28:41.454391-03	3		1	1	1	1
\.


--
-- Data for Name: term_course_students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_course_students (id, course_id, user_id) FROM stdin;
1	1	80
2	1	44
3	1	144
4	1	20
5	1	116
6	1	156
7	1	56
8	1	68
9	1	95
10	1	4
11	1	128
12	1	31
13	1	164
14	1	24
15	1	140
16	1	152
17	2	69
18	2	115
19	2	22
20	2	118
21	2	91
22	2	43
23	2	154
24	2	45
25	2	6
26	2	129
27	2	117
28	2	119
29	2	71
30	2	70
31	2	35
32	2	130
33	2	23
34	2	42
35	2	36
36	2	141
37	3	47
38	3	142
39	3	21
40	3	108
41	3	82
42	3	83
43	3	11
44	3	60
45	3	96
46	3	72
47	3	120
48	3	48
49	3	143
50	3	166
51	3	79
52	3	132
53	3	107
54	3	32
55	3	33
56	3	104
\.


--
-- Data for Name: term_course_teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_course_teachers (id, course_id, user_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	2	1
5	2	2
6	2	3
7	3	1
8	3	2
9	3	3
\.


--
-- Data for Name: term_feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_feedback (id, is_deleted, created_ts, updated_ts, score, message, course_id, evaluated_id, evaluator_id) FROM stdin;
\.


--
-- Data for Name: term_finalindicatorevaluation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_finalindicatorevaluation (id, is_deleted, created_ts, updated_ts, value, course_id, evaluated_id, evaluator_id, indicator_id) FROM stdin;
\.


--
-- Data for Name: term_finalscoreevaluation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_finalscoreevaluation (id, is_deleted, created_ts, updated_ts, value, course_id, evaluated_id, evaluator_id) FROM stdin;
\.


--
-- Data for Name: term_tempfedbackscore; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_tempfedbackscore (id, is_deleted, created_ts, updated_ts, score, feedback_id) FROM stdin;
\.


--
-- Data for Name: term_tempfeedbackmessage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_tempfeedbackmessage (id, is_deleted, created_ts, updated_ts, message, feedback_id) FROM stdin;
\.


--
-- Data for Name: term_tempfinalindicatorevaluation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_tempfinalindicatorevaluation (id, is_deleted, created_ts, updated_ts, value, final_indicator_evaluation_id) FROM stdin;
\.


--
-- Data for Name: term_tempscoreevaluation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_tempscoreevaluation (id, is_deleted, created_ts, updated_ts, value, final_note_evaluation_id) FROM stdin;
\.


--
-- Data for Name: topology_node; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topology_node (id, is_deleted, created_ts, updated_ts, name, code, description, node_type_id, parent_id) FROM stdin;
1	f	2018-03-17 04:15:34.883-03	2018-03-17 04:15:34.883-03	Universidad del Desarrollo	UDD		1	\N
\.


--
-- Data for Name: topology_nodetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topology_nodetype (id, is_deleted, created_ts, updated_ts, name, code, description, is_top, can_have_programs) FROM stdin;
1	f	2018-03-17 04:14:53.91-03	2018-03-17 04:15:33.09-03	UNIVERSIDAD	universidad		t	t
2	f	2018-03-17 04:15:10.83-03	2018-03-17 04:15:10.83-03	CARRERA	carrera		f	t
\.


--
-- Data for Name: topology_nodetypeparent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topology_nodetypeparent (id, is_deleted, created_ts, updated_ts, node_type_id, parent_type_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 99, true);


--
-- Name: base_parameter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_parameter_id_seq', 1, false);


--
-- Name: base_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_user_groups_id_seq', 1, false);


--
-- Name: base_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_user_id_seq', 171, true);


--
-- Name: base_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_user_user_permissions_id_seq', 1, false);


--
-- Name: base_userprofilesprogram_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_userprofilesprogram_id_seq', 165, true);


--
-- Name: base_userprofilesprogram_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_userprofilesprogram_profiles_id_seq', 163, true);


--
-- Name: business_campus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.business_campus_id_seq', 1, true);


--
-- Name: business_campus_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.business_campus_program_id_seq', 1, true);


--
-- Name: business_period_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.business_period_id_seq', 1, true);


--
-- Name: business_survey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.business_survey_id_seq', 1, true);


--
-- Name: business_survey_indicator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.business_survey_indicator_id_seq', 1, true);


--
-- Name: core_indicator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_indicator_id_seq', 1, true);


--
-- Name: core_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_level_id_seq', 1, true);


--
-- Name: core_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_program_id_seq', 1, true);


--
-- Name: core_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_skill_id_seq', 1, true);


--
-- Name: core_skillleveldescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_skillleveldescription_id_seq', 1, false);


--
-- Name: core_skillsgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_skillsgroup_id_seq', 1, true);


--
-- Name: core_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_subject_id_seq', 1, true);


--
-- Name: core_subjectsgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_subjectsgroup_id_seq', 1, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 24, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 33, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 20, true);


--
-- Name: log_action_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_action_id_seq', 1, false);


--
-- Name: log_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_log_id_seq', 1, false);


--
-- Name: term_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_course_id_seq', 3, true);


--
-- Name: term_course_students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_course_students_id_seq', 56, true);


--
-- Name: term_course_teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_course_teachers_id_seq', 9, true);


--
-- Name: term_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_feedback_id_seq', 1, false);


--
-- Name: term_finalindicatorevaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_finalindicatorevaluation_id_seq', 1, false);


--
-- Name: term_finalscoreevaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_finalscoreevaluation_id_seq', 1, false);


--
-- Name: term_tempfedbackscore_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_tempfedbackscore_id_seq', 1, false);


--
-- Name: term_tempfeedbackmessage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_tempfeedbackmessage_id_seq', 1, false);


--
-- Name: term_tempfinalindicatorevaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_tempfinalindicatorevaluation_id_seq', 1, false);


--
-- Name: term_tempscoreevaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_tempscoreevaluation_id_seq', 1, false);


--
-- Name: topology_node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topology_node_id_seq', 1, true);


--
-- Name: topology_nodetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topology_nodetype_id_seq', 2, true);


--
-- Name: topology_nodetypeparent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topology_nodetypeparent_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: base_parameter base_parameter_code_program_id_317cc491_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_parameter
    ADD CONSTRAINT base_parameter_code_program_id_317cc491_uniq UNIQUE (code, program_id);


--
-- Name: base_parameter base_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_parameter
    ADD CONSTRAINT base_parameter_pkey PRIMARY KEY (id);


--
-- Name: base_profile base_profile_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_profile
    ADD CONSTRAINT base_profile_code_key UNIQUE (code);


--
-- Name: base_profile base_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_profile
    ADD CONSTRAINT base_profile_pkey PRIMARY KEY (id);


--
-- Name: base_user base_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user
    ADD CONSTRAINT base_user_email_key UNIQUE (email);


--
-- Name: base_user_groups base_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user_groups
    ADD CONSTRAINT base_user_groups_pkey PRIMARY KEY (id);


--
-- Name: base_user_groups base_user_groups_user_id_group_id_774631b7_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user_groups
    ADD CONSTRAINT base_user_groups_user_id_group_id_774631b7_uniq UNIQUE (user_id, group_id);


--
-- Name: base_user base_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user
    ADD CONSTRAINT base_user_pkey PRIMARY KEY (id);


--
-- Name: base_user_user_permissions base_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user_user_permissions
    ADD CONSTRAINT base_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: base_user_user_permissions base_user_user_permissions_user_id_permission_id_e9093277_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user_user_permissions
    ADD CONSTRAINT base_user_user_permissions_user_id_permission_id_e9093277_uniq UNIQUE (user_id, permission_id);


--
-- Name: base_user base_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user
    ADD CONSTRAINT base_user_username_key UNIQUE (username);


--
-- Name: base_userprofilesprogram base_userprofilesprogram_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_userprofilesprogram
    ADD CONSTRAINT base_userprofilesprogram_pkey PRIMARY KEY (id);


--
-- Name: base_userprofilesprogram_profiles base_userprofilesprogram_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_userprofilesprogram_profiles
    ADD CONSTRAINT base_userprofilesprogram_profiles_pkey PRIMARY KEY (id);


--
-- Name: base_userprofilesprogram base_userprofilesprogram_user_id_program_id_23210738_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_userprofilesprogram
    ADD CONSTRAINT base_userprofilesprogram_user_id_program_id_23210738_uniq UNIQUE (user_id, program_id);


--
-- Name: base_userprofilesprogram_profiles base_userprofilesprogram_userprofilesprogram_id_p_b73c8a6e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_userprofilesprogram_profiles
    ADD CONSTRAINT base_userprofilesprogram_userprofilesprogram_id_p_b73c8a6e_uniq UNIQUE (userprofilesprogram_id, profile_id);


--
-- Name: business_campus business_campus_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_campus
    ADD CONSTRAINT business_campus_code_key UNIQUE (code);


--
-- Name: business_campus business_campus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_campus
    ADD CONSTRAINT business_campus_pkey PRIMARY KEY (id);


--
-- Name: business_campus_program business_campus_program_campus_id_program_id_c2872259_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_campus_program
    ADD CONSTRAINT business_campus_program_campus_id_program_id_c2872259_uniq UNIQUE (campus_id, program_id);


--
-- Name: business_campus_program business_campus_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_campus_program
    ADD CONSTRAINT business_campus_program_pkey PRIMARY KEY (id);


--
-- Name: business_period business_period_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_period
    ADD CONSTRAINT business_period_code_key UNIQUE (code);


--
-- Name: business_period business_period_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_period
    ADD CONSTRAINT business_period_pkey PRIMARY KEY (id);


--
-- Name: business_survey business_survey_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_survey
    ADD CONSTRAINT business_survey_code_key UNIQUE (code);


--
-- Name: business_survey_indicator business_survey_indicator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_survey_indicator
    ADD CONSTRAINT business_survey_indicator_pkey PRIMARY KEY (id);


--
-- Name: business_survey_indicator business_survey_indicator_survey_id_indicator_id_61c2ca87_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_survey_indicator
    ADD CONSTRAINT business_survey_indicator_survey_id_indicator_id_61c2ca87_uniq UNIQUE (survey_id, indicator_id);


--
-- Name: business_survey business_survey_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_survey
    ADD CONSTRAINT business_survey_pkey PRIMARY KEY (id);


--
-- Name: core_indicator core_indicator_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_indicator
    ADD CONSTRAINT core_indicator_code_key UNIQUE (code);


--
-- Name: core_indicator core_indicator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_indicator
    ADD CONSTRAINT core_indicator_pkey PRIMARY KEY (id);


--
-- Name: core_level core_level_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_level
    ADD CONSTRAINT core_level_code_key UNIQUE (code);


--
-- Name: core_level core_level_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_level
    ADD CONSTRAINT core_level_pkey PRIMARY KEY (id);


--
-- Name: core_program core_program_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_program
    ADD CONSTRAINT core_program_code_key UNIQUE (code);


--
-- Name: core_program core_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_program
    ADD CONSTRAINT core_program_pkey PRIMARY KEY (id);


--
-- Name: core_skill core_skill_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skill
    ADD CONSTRAINT core_skill_code_key UNIQUE (code);


--
-- Name: core_skill core_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skill
    ADD CONSTRAINT core_skill_pkey PRIMARY KEY (id);


--
-- Name: core_skillleveldescription core_skillleveldescription_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skillleveldescription
    ADD CONSTRAINT core_skillleveldescription_code_key UNIQUE (code);


--
-- Name: core_skillleveldescription core_skillleveldescription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skillleveldescription
    ADD CONSTRAINT core_skillleveldescription_pkey PRIMARY KEY (id);


--
-- Name: core_skillsgroup core_skillsgroup_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skillsgroup
    ADD CONSTRAINT core_skillsgroup_code_key UNIQUE (code);


--
-- Name: core_skillsgroup core_skillsgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skillsgroup
    ADD CONSTRAINT core_skillsgroup_pkey PRIMARY KEY (id);


--
-- Name: core_subject core_subject_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_subject
    ADD CONSTRAINT core_subject_code_key UNIQUE (code);


--
-- Name: core_subject core_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_subject
    ADD CONSTRAINT core_subject_pkey PRIMARY KEY (id);


--
-- Name: core_subjectsgroup core_subjectsgroup_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_subjectsgroup
    ADD CONSTRAINT core_subjectsgroup_code_key UNIQUE (code);


--
-- Name: core_subjectsgroup core_subjectsgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_subjectsgroup
    ADD CONSTRAINT core_subjectsgroup_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: log_action log_action_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_action
    ADD CONSTRAINT log_action_code_key UNIQUE (code);


--
-- Name: log_action log_action_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_action
    ADD CONSTRAINT log_action_pkey PRIMARY KEY (id);


--
-- Name: log_log log_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_log
    ADD CONSTRAINT log_log_pkey PRIMARY KEY (id);


--
-- Name: term_course term_course_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course
    ADD CONSTRAINT term_course_code_key UNIQUE (code);


--
-- Name: term_course term_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course
    ADD CONSTRAINT term_course_pkey PRIMARY KEY (id);


--
-- Name: term_course_students term_course_students_course_id_user_id_b8eda8a1_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course_students
    ADD CONSTRAINT term_course_students_course_id_user_id_b8eda8a1_uniq UNIQUE (course_id, user_id);


--
-- Name: term_course_students term_course_students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course_students
    ADD CONSTRAINT term_course_students_pkey PRIMARY KEY (id);


--
-- Name: term_course_teachers term_course_teachers_course_id_user_id_990ebe93_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course_teachers
    ADD CONSTRAINT term_course_teachers_course_id_user_id_990ebe93_uniq UNIQUE (course_id, user_id);


--
-- Name: term_course_teachers term_course_teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course_teachers
    ADD CONSTRAINT term_course_teachers_pkey PRIMARY KEY (id);


--
-- Name: term_feedback term_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_feedback
    ADD CONSTRAINT term_feedback_pkey PRIMARY KEY (id);


--
-- Name: term_finalindicatorevaluation term_finalindicatorevalu_indicator_id_course_id_e_4b54cd2f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalindicatorevaluation
    ADD CONSTRAINT term_finalindicatorevalu_indicator_id_course_id_e_4b54cd2f_uniq UNIQUE (indicator_id, course_id, evaluated_id);


--
-- Name: term_finalindicatorevaluation term_finalindicatorevaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalindicatorevaluation
    ADD CONSTRAINT term_finalindicatorevaluation_pkey PRIMARY KEY (id);


--
-- Name: term_finalscoreevaluation term_finalscoreevaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalscoreevaluation
    ADD CONSTRAINT term_finalscoreevaluation_pkey PRIMARY KEY (id);


--
-- Name: term_tempfedbackscore term_tempfedbackscore_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempfedbackscore
    ADD CONSTRAINT term_tempfedbackscore_pkey PRIMARY KEY (id);


--
-- Name: term_tempfeedbackmessage term_tempfeedbackmessage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempfeedbackmessage
    ADD CONSTRAINT term_tempfeedbackmessage_pkey PRIMARY KEY (id);


--
-- Name: term_tempfinalindicatorevaluation term_tempfinalindicatorevaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempfinalindicatorevaluation
    ADD CONSTRAINT term_tempfinalindicatorevaluation_pkey PRIMARY KEY (id);


--
-- Name: term_tempscoreevaluation term_tempscoreevaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempscoreevaluation
    ADD CONSTRAINT term_tempscoreevaluation_pkey PRIMARY KEY (id);


--
-- Name: topology_node topology_node_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_node
    ADD CONSTRAINT topology_node_code_key UNIQUE (code);


--
-- Name: topology_node topology_node_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_node
    ADD CONSTRAINT topology_node_pkey PRIMARY KEY (id);


--
-- Name: topology_nodetype topology_nodetype_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_nodetype
    ADD CONSTRAINT topology_nodetype_code_key UNIQUE (code);


--
-- Name: topology_nodetype topology_nodetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_nodetype
    ADD CONSTRAINT topology_nodetype_pkey PRIMARY KEY (id);


--
-- Name: topology_nodetypeparent topology_nodetypeparent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_nodetypeparent
    ADD CONSTRAINT topology_nodetypeparent_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: base_parameter_program_id_5a5ceaf3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_parameter_program_id_5a5ceaf3 ON public.base_parameter USING btree (program_id);


--
-- Name: base_profile_code_5402883b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_profile_code_5402883b_like ON public.base_profile USING btree (code varchar_pattern_ops);


--
-- Name: base_user_email_fbc4c0ff_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_user_email_fbc4c0ff_like ON public.base_user USING btree (email varchar_pattern_ops);


--
-- Name: base_user_groups_group_id_c0eca7d6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_user_groups_group_id_c0eca7d6 ON public.base_user_groups USING btree (group_id);


--
-- Name: base_user_groups_user_id_29a796b6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_user_groups_user_id_29a796b6 ON public.base_user_groups USING btree (user_id);


--
-- Name: base_user_user_permissions_permission_id_0418bc02; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_user_user_permissions_permission_id_0418bc02 ON public.base_user_user_permissions USING btree (permission_id);


--
-- Name: base_user_user_permissions_user_id_2eec4d63; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_user_user_permissions_user_id_2eec4d63 ON public.base_user_user_permissions USING btree (user_id);


--
-- Name: base_user_username_59bfc15c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_user_username_59bfc15c_like ON public.base_user USING btree (username varchar_pattern_ops);


--
-- Name: base_userprofilesprogram_p_userprofilesprogram_id_fda8cca5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_userprofilesprogram_p_userprofilesprogram_id_fda8cca5 ON public.base_userprofilesprogram_profiles USING btree (userprofilesprogram_id);


--
-- Name: base_userprofilesprogram_profiles_profile_id_cdadff2a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_userprofilesprogram_profiles_profile_id_cdadff2a ON public.base_userprofilesprogram_profiles USING btree (profile_id);


--
-- Name: base_userprofilesprogram_program_id_a7642097; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_userprofilesprogram_program_id_a7642097 ON public.base_userprofilesprogram USING btree (program_id);


--
-- Name: base_userprofilesprogram_user_id_31b1f5fd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_userprofilesprogram_user_id_31b1f5fd ON public.base_userprofilesprogram USING btree (user_id);


--
-- Name: business_campus_code_49e8f3af_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX business_campus_code_49e8f3af_like ON public.business_campus USING btree (code varchar_pattern_ops);


--
-- Name: business_campus_program_campus_id_710cbab9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX business_campus_program_campus_id_710cbab9 ON public.business_campus_program USING btree (campus_id);


--
-- Name: business_campus_program_program_id_cedeca96; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX business_campus_program_program_id_cedeca96 ON public.business_campus_program USING btree (program_id);


--
-- Name: business_period_code_46b85ace_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX business_period_code_46b85ace_like ON public.business_period USING btree (code varchar_pattern_ops);


--
-- Name: business_period_program_id_29383269; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX business_period_program_id_29383269 ON public.business_period USING btree (program_id);


--
-- Name: business_survey_code_9598992d_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX business_survey_code_9598992d_like ON public.business_survey USING btree (code varchar_pattern_ops);


--
-- Name: business_survey_indicator_indicator_id_14f15e14; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX business_survey_indicator_indicator_id_14f15e14 ON public.business_survey_indicator USING btree (indicator_id);


--
-- Name: business_survey_indicator_survey_id_93029c00; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX business_survey_indicator_survey_id_93029c00 ON public.business_survey_indicator USING btree (survey_id);


--
-- Name: core_indicator_code_eb9ec147_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_indicator_code_eb9ec147_like ON public.core_indicator USING btree (code varchar_pattern_ops);


--
-- Name: core_indicator_skill_id_589e8128; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_indicator_skill_id_589e8128 ON public.core_indicator USING btree (skill_id);


--
-- Name: core_indicator_subject_id_15e94a2b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_indicator_subject_id_15e94a2b ON public.core_indicator USING btree (subject_id);


--
-- Name: core_level_code_a4ba9fe6_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_level_code_a4ba9fe6_like ON public.core_level USING btree (code varchar_pattern_ops);


--
-- Name: core_level_program_id_f4588ed9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_level_program_id_f4588ed9 ON public.core_level USING btree (program_id);


--
-- Name: core_program_code_411ba797_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_program_code_411ba797_like ON public.core_program USING btree (code varchar_pattern_ops);


--
-- Name: core_program_node_id_1aa82fdb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_program_node_id_1aa82fdb ON public.core_program USING btree (node_id);


--
-- Name: core_skill_code_0bdcad02_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_skill_code_0bdcad02_like ON public.core_skill USING btree (code varchar_pattern_ops);


--
-- Name: core_skill_skill_group_id_f7cfc8ce; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_skill_skill_group_id_f7cfc8ce ON public.core_skill USING btree (skill_group_id);


--
-- Name: core_skillleveldescription_code_34b58a82_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_skillleveldescription_code_34b58a82_like ON public.core_skillleveldescription USING btree (code varchar_pattern_ops);


--
-- Name: core_skillleveldescription_level_id_84dcb862; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_skillleveldescription_level_id_84dcb862 ON public.core_skillleveldescription USING btree (level_id);


--
-- Name: core_skillleveldescription_skill_id_d10e3ae7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_skillleveldescription_skill_id_d10e3ae7 ON public.core_skillleveldescription USING btree (skill_id);


--
-- Name: core_skillsgroup_code_03c4a781_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_skillsgroup_code_03c4a781_like ON public.core_skillsgroup USING btree (code varchar_pattern_ops);


--
-- Name: core_skillsgroup_program_id_ae2cf386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_skillsgroup_program_id_ae2cf386 ON public.core_skillsgroup USING btree (program_id);


--
-- Name: core_subject_code_28e6f300_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_subject_code_28e6f300_like ON public.core_subject USING btree (code varchar_pattern_ops);


--
-- Name: core_subject_level_id_77049fca; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_subject_level_id_77049fca ON public.core_subject USING btree (level_id);


--
-- Name: core_subject_subjects_group_id_b328eb21; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_subject_subjects_group_id_b328eb21 ON public.core_subject USING btree (subjects_group_id);


--
-- Name: core_subjectsgroup_code_4265486c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_subjectsgroup_code_4265486c_like ON public.core_subjectsgroup USING btree (code varchar_pattern_ops);


--
-- Name: core_subjectsgroup_program_id_97479e6b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_subjectsgroup_program_id_97479e6b ON public.core_subjectsgroup USING btree (program_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: log_action_code_05b75d30_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX log_action_code_05b75d30_like ON public.log_action USING btree (code varchar_pattern_ops);


--
-- Name: log_log_action_id_abc1f27f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX log_log_action_id_abc1f27f ON public.log_log USING btree (action_id);


--
-- Name: log_log_user_id_1a5f2414; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX log_log_user_id_1a5f2414 ON public.log_log USING btree (user_id);


--
-- Name: term_course_campus_id_e0c65a24; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_course_campus_id_e0c65a24 ON public.term_course USING btree (campus_id);


--
-- Name: term_course_code_250af560_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_course_code_250af560_like ON public.term_course USING btree (code varchar_pattern_ops);


--
-- Name: term_course_period_id_1d794e17; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_course_period_id_1d794e17 ON public.term_course USING btree (period_id);


--
-- Name: term_course_students_course_id_035c44d3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_course_students_course_id_035c44d3 ON public.term_course_students USING btree (course_id);


--
-- Name: term_course_students_user_id_e3142221; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_course_students_user_id_e3142221 ON public.term_course_students USING btree (user_id);


--
-- Name: term_course_subject_id_d750da70; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_course_subject_id_d750da70 ON public.term_course USING btree (subject_id);


--
-- Name: term_course_survey_id_1cae7542; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_course_survey_id_1cae7542 ON public.term_course USING btree (survey_id);


--
-- Name: term_course_teachers_course_id_b4207684; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_course_teachers_course_id_b4207684 ON public.term_course_teachers USING btree (course_id);


--
-- Name: term_course_teachers_user_id_ff40220a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_course_teachers_user_id_ff40220a ON public.term_course_teachers USING btree (user_id);


--
-- Name: term_feedback_course_id_6d2f209e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_feedback_course_id_6d2f209e ON public.term_feedback USING btree (course_id);


--
-- Name: term_feedback_evaluated_id_06b79607; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_feedback_evaluated_id_06b79607 ON public.term_feedback USING btree (evaluated_id);


--
-- Name: term_feedback_evaluator_id_4523620a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_feedback_evaluator_id_4523620a ON public.term_feedback USING btree (evaluator_id);


--
-- Name: term_finalindicatorevaluation_course_id_17eaaa94; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_finalindicatorevaluation_course_id_17eaaa94 ON public.term_finalindicatorevaluation USING btree (course_id);


--
-- Name: term_finalindicatorevaluation_evaluated_id_71a875ce; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_finalindicatorevaluation_evaluated_id_71a875ce ON public.term_finalindicatorevaluation USING btree (evaluated_id);


--
-- Name: term_finalindicatorevaluation_evaluator_id_1c046d2b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_finalindicatorevaluation_evaluator_id_1c046d2b ON public.term_finalindicatorevaluation USING btree (evaluator_id);


--
-- Name: term_finalindicatorevaluation_indicator_id_bfa2c3a4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_finalindicatorevaluation_indicator_id_bfa2c3a4 ON public.term_finalindicatorevaluation USING btree (indicator_id);


--
-- Name: term_finalscoreevaluation_course_id_610d3a95; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_finalscoreevaluation_course_id_610d3a95 ON public.term_finalscoreevaluation USING btree (course_id);


--
-- Name: term_finalscoreevaluation_evaluated_id_61bb56c7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_finalscoreevaluation_evaluated_id_61bb56c7 ON public.term_finalscoreevaluation USING btree (evaluated_id);


--
-- Name: term_finalscoreevaluation_evaluator_id_4b12f171; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_finalscoreevaluation_evaluator_id_4b12f171 ON public.term_finalscoreevaluation USING btree (evaluator_id);


--
-- Name: term_tempfedbackscore_feedback_id_98d48bae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_tempfedbackscore_feedback_id_98d48bae ON public.term_tempfedbackscore USING btree (feedback_id);


--
-- Name: term_tempfeedbackmessage_feedback_id_601e0b99; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_tempfeedbackmessage_feedback_id_601e0b99 ON public.term_tempfeedbackmessage USING btree (feedback_id);


--
-- Name: term_tempfinalindicatoreva_final_indicator_evaluation_48c13ba5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_tempfinalindicatoreva_final_indicator_evaluation_48c13ba5 ON public.term_tempfinalindicatorevaluation USING btree (final_indicator_evaluation_id);


--
-- Name: term_tempscoreevaluation_final_note_evaluation_id_5f291a9e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX term_tempscoreevaluation_final_note_evaluation_id_5f291a9e ON public.term_tempscoreevaluation USING btree (final_note_evaluation_id);


--
-- Name: topology_node_code_41cfb9d4_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX topology_node_code_41cfb9d4_like ON public.topology_node USING btree (code varchar_pattern_ops);


--
-- Name: topology_node_node_type_id_d2eebe6d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX topology_node_node_type_id_d2eebe6d ON public.topology_node USING btree (node_type_id);


--
-- Name: topology_node_parent_id_370c98fd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX topology_node_parent_id_370c98fd ON public.topology_node USING btree (parent_id);


--
-- Name: topology_nodetype_code_578bc13b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX topology_nodetype_code_578bc13b_like ON public.topology_nodetype USING btree (code varchar_pattern_ops);


--
-- Name: topology_nodetypeparent_node_type_id_7c38184f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX topology_nodetypeparent_node_type_id_7c38184f ON public.topology_nodetypeparent USING btree (node_type_id);


--
-- Name: topology_nodetypeparent_parent_type_id_9f1a285c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX topology_nodetypeparent_parent_type_id_9f1a285c ON public.topology_nodetypeparent USING btree (parent_type_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_parameter base_parameter_program_id_5a5ceaf3_fk_core_program_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_parameter
    ADD CONSTRAINT base_parameter_program_id_5a5ceaf3_fk_core_program_id FOREIGN KEY (program_id) REFERENCES public.core_program(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_user_groups base_user_groups_group_id_c0eca7d6_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user_groups
    ADD CONSTRAINT base_user_groups_group_id_c0eca7d6_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_user_groups base_user_groups_user_id_29a796b6_fk_base_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user_groups
    ADD CONSTRAINT base_user_groups_user_id_29a796b6_fk_base_user_id FOREIGN KEY (user_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_user_user_permissions base_user_user_permi_permission_id_0418bc02_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user_user_permissions
    ADD CONSTRAINT base_user_user_permi_permission_id_0418bc02_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_user_user_permissions base_user_user_permissions_user_id_2eec4d63_fk_base_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_user_user_permissions
    ADD CONSTRAINT base_user_user_permissions_user_id_2eec4d63_fk_base_user_id FOREIGN KEY (user_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_userprofilesprogram_profiles base_userprofilespro_profile_id_cdadff2a_fk_base_prof; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_userprofilesprogram_profiles
    ADD CONSTRAINT base_userprofilespro_profile_id_cdadff2a_fk_base_prof FOREIGN KEY (profile_id) REFERENCES public.base_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_userprofilesprogram_profiles base_userprofilespro_userprofilesprogram__fda8cca5_fk_base_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_userprofilesprogram_profiles
    ADD CONSTRAINT base_userprofilespro_userprofilesprogram__fda8cca5_fk_base_user FOREIGN KEY (userprofilesprogram_id) REFERENCES public.base_userprofilesprogram(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_userprofilesprogram base_userprofilesprogram_program_id_a7642097_fk_core_program_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_userprofilesprogram
    ADD CONSTRAINT base_userprofilesprogram_program_id_a7642097_fk_core_program_id FOREIGN KEY (program_id) REFERENCES public.core_program(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: base_userprofilesprogram base_userprofilesprogram_user_id_31b1f5fd_fk_base_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_userprofilesprogram
    ADD CONSTRAINT base_userprofilesprogram_user_id_31b1f5fd_fk_base_user_id FOREIGN KEY (user_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: business_campus_program business_campus_prog_campus_id_710cbab9_fk_business_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_campus_program
    ADD CONSTRAINT business_campus_prog_campus_id_710cbab9_fk_business_ FOREIGN KEY (campus_id) REFERENCES public.business_campus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: business_campus_program business_campus_program_program_id_cedeca96_fk_core_program_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_campus_program
    ADD CONSTRAINT business_campus_program_program_id_cedeca96_fk_core_program_id FOREIGN KEY (program_id) REFERENCES public.core_program(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: business_period business_period_program_id_29383269_fk_core_program_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_period
    ADD CONSTRAINT business_period_program_id_29383269_fk_core_program_id FOREIGN KEY (program_id) REFERENCES public.core_program(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: business_survey_indicator business_survey_indi_indicator_id_14f15e14_fk_core_indi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_survey_indicator
    ADD CONSTRAINT business_survey_indi_indicator_id_14f15e14_fk_core_indi FOREIGN KEY (indicator_id) REFERENCES public.core_indicator(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: business_survey_indicator business_survey_indi_survey_id_93029c00_fk_business_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_survey_indicator
    ADD CONSTRAINT business_survey_indi_survey_id_93029c00_fk_business_ FOREIGN KEY (survey_id) REFERENCES public.business_survey(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_indicator core_indicator_skill_id_589e8128_fk_core_skill_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_indicator
    ADD CONSTRAINT core_indicator_skill_id_589e8128_fk_core_skill_id FOREIGN KEY (skill_id) REFERENCES public.core_skill(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_indicator core_indicator_subject_id_15e94a2b_fk_core_subject_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_indicator
    ADD CONSTRAINT core_indicator_subject_id_15e94a2b_fk_core_subject_id FOREIGN KEY (subject_id) REFERENCES public.core_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_level core_level_program_id_f4588ed9_fk_core_program_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_level
    ADD CONSTRAINT core_level_program_id_f4588ed9_fk_core_program_id FOREIGN KEY (program_id) REFERENCES public.core_program(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_program core_program_node_id_1aa82fdb_fk_topology_node_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_program
    ADD CONSTRAINT core_program_node_id_1aa82fdb_fk_topology_node_id FOREIGN KEY (node_id) REFERENCES public.topology_node(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_skill core_skill_skill_group_id_f7cfc8ce_fk_core_skillsgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skill
    ADD CONSTRAINT core_skill_skill_group_id_f7cfc8ce_fk_core_skillsgroup_id FOREIGN KEY (skill_group_id) REFERENCES public.core_skillsgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_skillleveldescription core_skillleveldescription_level_id_84dcb862_fk_core_level_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skillleveldescription
    ADD CONSTRAINT core_skillleveldescription_level_id_84dcb862_fk_core_level_id FOREIGN KEY (level_id) REFERENCES public.core_level(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_skillleveldescription core_skillleveldescription_skill_id_d10e3ae7_fk_core_skill_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skillleveldescription
    ADD CONSTRAINT core_skillleveldescription_skill_id_d10e3ae7_fk_core_skill_id FOREIGN KEY (skill_id) REFERENCES public.core_skill(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_skillsgroup core_skillsgroup_program_id_ae2cf386_fk_core_program_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_skillsgroup
    ADD CONSTRAINT core_skillsgroup_program_id_ae2cf386_fk_core_program_id FOREIGN KEY (program_id) REFERENCES public.core_program(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_subject core_subject_level_id_77049fca_fk_core_level_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_subject
    ADD CONSTRAINT core_subject_level_id_77049fca_fk_core_level_id FOREIGN KEY (level_id) REFERENCES public.core_level(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_subject core_subject_subjects_group_id_b328eb21_fk_core_subj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_subject
    ADD CONSTRAINT core_subject_subjects_group_id_b328eb21_fk_core_subj FOREIGN KEY (subjects_group_id) REFERENCES public.core_subjectsgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_subjectsgroup core_subjectsgroup_program_id_97479e6b_fk_core_program_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_subjectsgroup
    ADD CONSTRAINT core_subjectsgroup_program_id_97479e6b_fk_core_program_id FOREIGN KEY (program_id) REFERENCES public.core_program(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_base_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_base_user_id FOREIGN KEY (user_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: log_log log_log_action_id_abc1f27f_fk_log_action_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_log
    ADD CONSTRAINT log_log_action_id_abc1f27f_fk_log_action_id FOREIGN KEY (action_id) REFERENCES public.log_action(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: log_log log_log_user_id_1a5f2414_fk_base_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_log
    ADD CONSTRAINT log_log_user_id_1a5f2414_fk_base_user_id FOREIGN KEY (user_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_course term_course_campus_id_e0c65a24_fk_business_campus_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course
    ADD CONSTRAINT term_course_campus_id_e0c65a24_fk_business_campus_id FOREIGN KEY (campus_id) REFERENCES public.business_campus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_course term_course_period_id_1d794e17_fk_business_period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course
    ADD CONSTRAINT term_course_period_id_1d794e17_fk_business_period_id FOREIGN KEY (period_id) REFERENCES public.business_period(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_course_students term_course_students_course_id_035c44d3_fk_term_course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course_students
    ADD CONSTRAINT term_course_students_course_id_035c44d3_fk_term_course_id FOREIGN KEY (course_id) REFERENCES public.term_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_course_students term_course_students_user_id_e3142221_fk_base_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course_students
    ADD CONSTRAINT term_course_students_user_id_e3142221_fk_base_user_id FOREIGN KEY (user_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_course term_course_subject_id_d750da70_fk_core_subject_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course
    ADD CONSTRAINT term_course_subject_id_d750da70_fk_core_subject_id FOREIGN KEY (subject_id) REFERENCES public.core_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_course term_course_survey_id_1cae7542_fk_business_survey_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course
    ADD CONSTRAINT term_course_survey_id_1cae7542_fk_business_survey_id FOREIGN KEY (survey_id) REFERENCES public.business_survey(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_course_teachers term_course_teachers_course_id_b4207684_fk_term_course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course_teachers
    ADD CONSTRAINT term_course_teachers_course_id_b4207684_fk_term_course_id FOREIGN KEY (course_id) REFERENCES public.term_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_course_teachers term_course_teachers_user_id_ff40220a_fk_base_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_course_teachers
    ADD CONSTRAINT term_course_teachers_user_id_ff40220a_fk_base_user_id FOREIGN KEY (user_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_feedback term_feedback_course_id_6d2f209e_fk_term_course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_feedback
    ADD CONSTRAINT term_feedback_course_id_6d2f209e_fk_term_course_id FOREIGN KEY (course_id) REFERENCES public.term_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_feedback term_feedback_evaluated_id_06b79607_fk_base_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_feedback
    ADD CONSTRAINT term_feedback_evaluated_id_06b79607_fk_base_user_id FOREIGN KEY (evaluated_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_feedback term_feedback_evaluator_id_4523620a_fk_base_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_feedback
    ADD CONSTRAINT term_feedback_evaluator_id_4523620a_fk_base_user_id FOREIGN KEY (evaluator_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_finalindicatorevaluation term_finalindicatore_course_id_17eaaa94_fk_term_cour; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalindicatorevaluation
    ADD CONSTRAINT term_finalindicatore_course_id_17eaaa94_fk_term_cour FOREIGN KEY (course_id) REFERENCES public.term_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_finalindicatorevaluation term_finalindicatore_evaluated_id_71a875ce_fk_base_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalindicatorevaluation
    ADD CONSTRAINT term_finalindicatore_evaluated_id_71a875ce_fk_base_user FOREIGN KEY (evaluated_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_finalindicatorevaluation term_finalindicatore_evaluator_id_1c046d2b_fk_base_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalindicatorevaluation
    ADD CONSTRAINT term_finalindicatore_evaluator_id_1c046d2b_fk_base_user FOREIGN KEY (evaluator_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_finalindicatorevaluation term_finalindicatore_indicator_id_bfa2c3a4_fk_core_indi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalindicatorevaluation
    ADD CONSTRAINT term_finalindicatore_indicator_id_bfa2c3a4_fk_core_indi FOREIGN KEY (indicator_id) REFERENCES public.core_indicator(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_finalscoreevaluation term_finalscoreevaluation_course_id_610d3a95_fk_term_course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalscoreevaluation
    ADD CONSTRAINT term_finalscoreevaluation_course_id_610d3a95_fk_term_course_id FOREIGN KEY (course_id) REFERENCES public.term_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_finalscoreevaluation term_finalscoreevaluation_evaluated_id_61bb56c7_fk_base_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalscoreevaluation
    ADD CONSTRAINT term_finalscoreevaluation_evaluated_id_61bb56c7_fk_base_user_id FOREIGN KEY (evaluated_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_finalscoreevaluation term_finalscoreevaluation_evaluator_id_4b12f171_fk_base_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_finalscoreevaluation
    ADD CONSTRAINT term_finalscoreevaluation_evaluator_id_4b12f171_fk_base_user_id FOREIGN KEY (evaluator_id) REFERENCES public.base_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_tempfedbackscore term_tempfedbackscore_feedback_id_98d48bae_fk_term_feedback_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempfedbackscore
    ADD CONSTRAINT term_tempfedbackscore_feedback_id_98d48bae_fk_term_feedback_id FOREIGN KEY (feedback_id) REFERENCES public.term_feedback(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_tempfeedbackmessage term_tempfeedbackmes_feedback_id_601e0b99_fk_term_feed; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempfeedbackmessage
    ADD CONSTRAINT term_tempfeedbackmes_feedback_id_601e0b99_fk_term_feed FOREIGN KEY (feedback_id) REFERENCES public.term_feedback(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_tempfinalindicatorevaluation term_tempfinalindica_final_indicator_eval_48c13ba5_fk_term_fina; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempfinalindicatorevaluation
    ADD CONSTRAINT term_tempfinalindica_final_indicator_eval_48c13ba5_fk_term_fina FOREIGN KEY (final_indicator_evaluation_id) REFERENCES public.term_finalindicatorevaluation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: term_tempscoreevaluation term_tempscoreevalua_final_note_evaluatio_5f291a9e_fk_term_fina; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term_tempscoreevaluation
    ADD CONSTRAINT term_tempscoreevalua_final_note_evaluatio_5f291a9e_fk_term_fina FOREIGN KEY (final_note_evaluation_id) REFERENCES public.term_finalscoreevaluation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: topology_node topology_node_node_type_id_d2eebe6d_fk_topology_nodetype_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_node
    ADD CONSTRAINT topology_node_node_type_id_d2eebe6d_fk_topology_nodetype_id FOREIGN KEY (node_type_id) REFERENCES public.topology_nodetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: topology_node topology_node_parent_id_370c98fd_fk_topology_node_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_node
    ADD CONSTRAINT topology_node_parent_id_370c98fd_fk_topology_node_id FOREIGN KEY (parent_id) REFERENCES public.topology_node(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: topology_nodetypeparent topology_nodetypepar_node_type_id_7c38184f_fk_topology_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_nodetypeparent
    ADD CONSTRAINT topology_nodetypepar_node_type_id_7c38184f_fk_topology_ FOREIGN KEY (node_type_id) REFERENCES public.topology_nodetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: topology_nodetypeparent topology_nodetypepar_parent_type_id_9f1a285c_fk_topology_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topology_nodetypeparent
    ADD CONSTRAINT topology_nodetypepar_parent_type_id_9f1a285c_fk_topology_ FOREIGN KEY (parent_type_id) REFERENCES public.topology_nodetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: claudio
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM claudio;
GRANT ALL ON SCHEMA public TO claudio;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

