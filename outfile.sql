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
    name character varying(50) NOT NULL,
    code character varying(100) NOT NULL,
    value text NOT NULL,
    is_deleted boolean NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    updated_ts timestamp with time zone NOT NULL,
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
    survey_id integer NOT NULL,
    subject_id integer NOT NULL
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
16	Can add profile	6	add_profile
17	Can change profile	6	change_profile
18	Can delete profile	6	delete_profile
19	Can add user	7	add_user
20	Can change user	7	change_user
21	Can delete user	7	delete_user
22	Can add user profiles program	8	add_userprofilesprogram
23	Can change user profiles program	8	change_userprofilesprogram
24	Can delete user profiles program	8	delete_userprofilesprogram
25	Can add parameter	9	add_parameter
26	Can change parameter	9	change_parameter
27	Can delete parameter	9	delete_parameter
28	Can add survey	10	add_survey
29	Can change survey	10	change_survey
30	Can delete survey	10	delete_survey
31	Can add period	11	add_period
32	Can change period	11	change_period
33	Can delete period	11	delete_period
34	Can add campus	12	add_campus
35	Can change campus	12	change_campus
36	Can delete campus	12	delete_campus
37	Can add programa	13	add_program
38	Can change programa	13	change_program
39	Can delete programa	13	delete_program
40	Can add skills group	14	add_skillsgroup
41	Can change skills group	14	change_skillsgroup
42	Can delete skills group	14	delete_skillsgroup
43	Can add skill	15	add_skill
44	Can change skill	15	change_skill
45	Can delete skill	15	delete_skill
46	Can add subjects group	16	add_subjectsgroup
47	Can change subjects group	16	change_subjectsgroup
48	Can delete subjects group	16	delete_subjectsgroup
49	Can add nivel	17	add_level
50	Can change nivel	17	change_level
51	Can delete nivel	17	delete_level
52	Can add subject	18	add_subject
53	Can change subject	18	change_subject
54	Can delete subject	18	delete_subject
55	Can add indicador	19	add_indicator
56	Can change indicador	19	change_indicator
57	Can delete indicador	19	delete_indicator
58	Can add tipo de acción para log	20	add_action
59	Can change tipo de acción para log	20	change_action
60	Can delete tipo de acción para log	20	delete_action
61	Can add log	21	add_log
62	Can change log	21	change_log
63	Can delete log	21	delete_log
64	Can add course	22	add_course
65	Can change course	22	change_course
66	Can delete course	22	delete_course
67	Can add feedback	23	add_feedback
68	Can change feedback	23	change_feedback
69	Can delete feedback	23	delete_feedback
70	Can add temp feedback message	24	add_tempfeedbackmessage
71	Can change temp feedback message	24	change_tempfeedbackmessage
72	Can delete temp feedback message	24	delete_tempfeedbackmessage
73	Can add temp fedback score	25	add_tempfedbackscore
74	Can change temp fedback score	25	change_tempfedbackscore
75	Can delete temp fedback score	25	delete_tempfedbackscore
76	Can add final score evaluation	26	add_finalscoreevaluation
77	Can change final score evaluation	26	change_finalscoreevaluation
78	Can delete final score evaluation	26	delete_finalscoreevaluation
79	Can add temp score evaluation	27	add_tempscoreevaluation
80	Can change temp score evaluation	27	change_tempscoreevaluation
81	Can delete temp score evaluation	27	delete_tempscoreevaluation
82	Can add final indicator evaluation	28	add_finalindicatorevaluation
83	Can change final indicator evaluation	28	change_finalindicatorevaluation
84	Can delete final indicator evaluation	28	delete_finalindicatorevaluation
85	Can add temp final indicator evaluation	29	add_tempfinalindicatorevaluation
86	Can change temp final indicator evaluation	29	change_tempfinalindicatorevaluation
87	Can delete temp final indicator evaluation	29	delete_tempfinalindicatorevaluation
88	Can add tipo de nodo	30	add_nodetype
89	Can change tipo de nodo	30	change_nodetype
90	Can delete tipo de nodo	30	delete_nodetype
91	Can add tipo de nodo padre	31	add_nodetypeparent
92	Can change tipo de nodo padre	31	change_nodetypeparent
93	Can delete tipo de nodo padre	31	delete_nodetypeparent
94	Can add nodo	32	add_node
95	Can change nodo	32	change_node
96	Can delete nodo	32	delete_node
97	Can add descripción skill level	33	add_skillleveldescription
98	Can change descripción skill level	33	change_skillleveldescription
99	Can delete descripción skill level	33	delete_skillleveldescription
\.


--
-- Data for Name: base_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_parameter (id, name, code, value, is_deleted, created_ts, updated_ts, program_id) FROM stdin;
2	site_description	site_description	Programa de Arquitectura	f	2018-03-13 21:40:09.856558-03	2018-03-13 21:40:09.856601-03	\N
3	txt_login	txt_login	Iniciar Sesión	f	2018-03-13 21:40:41.220571-03	2018-03-13 21:40:41.2206-03	\N
4	url_login_logo	url_login_logo	custom/img/login_logo.png	f	2018-03-13 21:41:45.898088-03	2018-03-13 21:41:45.898113-03	\N
5	url_logo_navbar_30_auto	url_logo_navbar_30_auto	custom/img/logo_navbar_30_auto.png	f	2018-03-13 21:42:48.817827-03	2018-03-13 21:42:48.817856-03	\N
1	score	score	{\r\n "max": 3,\r\n "min": 0,\r\n "values": [0,1,2,3],\r\n "step": 1\r\n}	f	2018-03-13 21:39:21.50064-03	2018-03-13 23:02:35.648811-03	\N
6	txt_footer	txt_footer	Creado por MAROGU	f	2018-03-17 03:05:00.415105-03	2018-03-17 03:05:00.415137-03	\N
\.


--
-- Data for Name: base_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_profile (name, code, description, is_deleted, created_ts, updated_ts, id) FROM stdin;
Estediante	estudiante		f	2018-03-13 21:52:42.766194-03	2018-03-13 21:52:42.766222-03	1
Profesor	profesor		f	2018-03-13 21:53:04.236753-03	2018-03-13 21:53:04.23678-03	2
Administrador	admin		f	2018-03-13 21:53:16.790978-03	2018-03-13 21:53:16.791005-03	5
\.


--
-- Data for Name: base_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_user (id, password, last_login, is_superuser, username, first_name, last_name, is_staff, is_active, date_joined, email, external_info) FROM stdin;
1	pbkdf2_sha256$100000$E5GH5qdHLGDj$olqB7lo6+4wrQH3fD224o+WDG8bejEPL0es/cPZpynE=	2018-03-17 02:22:27.493608-03	t	claudio			t	t	2018-03-13 21:36:58.881982-03	claudio.dcv@gmail.com	"\\"\\""
448	pbkdf2_sha256$100000$JypnD4XSCeVw$7mbcxFqzh8Az31nEbfL0KPBx7qmaQ7iIOav66PI7boc=	\N	f	19293828-7	JOSÉ TOMÁS	LEÓN AGUILÓ	f	t	2018-03-15 09:49:41.051527-03	jleona@udd.cl	{"promocion": "2018"}
449	pbkdf2_sha256$100000$hlC3bhWZMbp5$97Q7crhMz7neAp5onZlEvwXYdBZWE26Dk3kR+kAeUIg=	\N	f	19646075-6	DANIELA CATALINA	OLATE PÉREZ	f	t	2018-03-15 09:49:41.213606-03	dolatep@udd.cl	{"promocion": "2018"}
450	pbkdf2_sha256$100000$JARE7yLVVBv3$eAQEwkkFYzSHzwvronVSkLgXAn5ABpmC/iq33fqYhms=	\N	f	19539759-7	JOSÉ ANTONIO	ROSSETTI KRAUSS	f	t	2018-03-15 09:49:41.369008-03	jrossettik@udd.cl	{"promocion": "2018"}
451	pbkdf2_sha256$100000$X3DcWuU7JL6L$5ocyyhUlLPds2SWhDQ8ksgCHVaQkUAWgnO7ygX/zUnw=	\N	f	19531589-2	CRISTÓBAL SEBASTIAN DE JESUS	RIOSECO BUSTOS	f	t	2018-03-15 09:49:41.534601-03	crriosecob@udd.cl	{"promocion": "2018"}
452	pbkdf2_sha256$100000$Sxhqi06b96Nd$edWmTw7lnS7I5jeZ0tAAl8HUu2qwGgpzSzioJKIWvBI=	\N	f	19539660-4	JUAN PABLO	JULIO ROSENBERG	f	t	2018-03-15 09:49:41.704426-03	jjulior@udd.cl	{"promocion": "2018"}
453	pbkdf2_sha256$100000$olAndzi0F9PD$fZ84hxHdE43l1Sq9semecexagz6Aax5ALIYx3hrVB+Q=	\N	f	19523265-2	MACARENA IGNACIA	BANCHIERI DIAZ	f	t	2018-03-15 09:49:41.857313-03	mbanchierid@udd.cl	{"promocion": "2018"}
454	pbkdf2_sha256$100000$zFkw9GPDvvWp$iHKEklfY5qj3ygTb0QM13XstNWGA1LtD385Iuxrasig=	\N	f	19685549-1	ALFONSO IGNACIO	CONTRERAS SAEZ	f	t	2018-03-15 09:49:42.017047-03	alcontrerass@udd.cl	{"promocion": "2018"}
455	pbkdf2_sha256$100000$VOYedtulJXnP$th8zPtdID6KPKSNzhbPWFKmj4KOyjR7tqLoi9Hp0hJ0=	\N	f	19864506-0	FABIÁN MIGUELANGEL	TAPIA URBINA	f	t	2018-03-15 09:49:42.174071-03	fatapiau@udd.cl	{"promocion": "2018"}
456	pbkdf2_sha256$100000$yD1KbwDhRCJi$mgm8VIU1nq0sNNBobl/P4ExXyGmrTEycjLUzzkSTXJI=	\N	f	19078929-2	JAVIERA TERESITA DE JESUS	VERDERAU RUIZ	f	t	2018-03-15 09:49:42.346483-03	jverderaur@udd.cl	{"promocion": "2018"}
457	pbkdf2_sha256$100000$O7DmXlkuqRni$BrvyJHrI6exflCafOumrVwDkclgvxLjyvknjetKhskk=	\N	f	19997333-9	LISSET DANIXA	MARIPAN BASOALTO	f	t	2018-03-15 09:49:42.519214-03	lmaripanb@udd.cl	{"promocion": "2018"}
458	pbkdf2_sha256$100000$W4QS0oArh0fb$T+Ykufl36nUAVvY9PSiNSUqFBFRKM1siqZe5oGbmXTE=	\N	f	20282817-5	MARIA MAGDALENA	IZQUIERDO GARCES	f	t	2018-03-15 09:49:42.673325-03	marizquierdog@udd.cl	{"promocion": "2018"}
459	pbkdf2_sha256$100000$BWSxK0fRpJEv$E/KGVA086LDthGbDzu8gdpn5tjl4FJ83XbnA0oAFn3k=	\N	f	20107968-3	MARIA IGNACIA	TAPIA GONZALEZ	f	t	2018-03-15 09:49:42.839304-03	maritapiag@udd.cl	{"promocion": "2018"}
460	pbkdf2_sha256$100000$9HAJ7PWWunIs$sY09G0PkPHzPgQEdu9mTAxQFFez2njpYzknilFQp8P8=	\N	f	20117550-K	MARIA IGNACIA	VALENZUELA GONZALEZ	f	t	2018-03-15 09:49:43.001557-03	mariaivalenzuelag@udd.cl	{"promocion": "2018"}
461	pbkdf2_sha256$100000$QzQzbEn9omk4$KHVZbmZ0Gxg7FFxp2+t6s8SXFLpYaAguc94ZH5QzOpw=	\N	f	20285028-6	MARIA TERESITA DEL NIÑO J	CRUZ ERRAZURIZ	f	t	2018-03-15 09:49:43.16749-03	mcruze@udd.cl	{"promocion": "2018"}
462	pbkdf2_sha256$100000$yf8RfY3kqX5b$RVEIEg1o4ZjNyz4Di3cv6hBSv9WZONIDcohZsY1zFSQ=	\N	f	20165870-5	ADOLFO JOSE	DOSAL ALMENDARES	f	t	2018-03-15 09:49:43.333231-03	adosala@udd.cl	{"promocion": "2018"}
463	pbkdf2_sha256$100000$nOjGz5EKaTar$uvv0DROsRc4HL/tfUEheBtmsBEU/q9yZKwoKx7NVLm0=	\N	f	20075313-5	COLOMBA	DE PETRIS CARDOEN	f	t	2018-03-15 09:49:43.51947-03	cdepetrisc@udd.cl	{"promocion": "2018"}
464	pbkdf2_sha256$100000$6xfyFrhGLMiS$Mhmx3bj0P1Px03a7LAHp9Mcndr5nXxxFQyb7wdal61Y=	\N	f	20165261-8	MARIA ISIDORA	URZUA TORM	f	t	2018-03-15 09:49:43.681818-03	murzuat@udd.cl	{"promocion": "2018"}
465	pbkdf2_sha256$100000$FMiqiXbZ5H8h$e+pJOPFNY/5UI4v+VUPiP9/jC+2g8ZWOXIVPsuRv6g4=	\N	f	20073433-5	CONSTANZA BEATRIZ	MONTECINOS FRASCAROLO	f	t	2018-03-15 09:49:43.841776-03	comontecinosf@udd.cl	{"promocion": "2018"}
466	pbkdf2_sha256$100000$BElSKjqqEvQm$C/aF15ldVsMIyyj0T5ZwRZzCGfbB2wlqUaAETVqfwgk=	\N	f	20072987-0	BARBARA	SCHUMACHER MILITZER	f	t	2018-03-15 09:49:44.020616-03	bschumacherm@udd.cl	{"promocion": "2018"}
467	pbkdf2_sha256$100000$esu0s6uVY2Xw$o9+5XeZUzlSxw7Kd0e6QNLYPEoHjN16r6f3n11FQCF4=	\N	f	20284093-0	AGUSTINA PAZ	RIVEROS KONEKAMP	f	t	2018-03-15 09:49:44.186036-03	agriverosk@udd.cl	{"promocion": "2018"}
468	pbkdf2_sha256$100000$FVeP7rSkIWVk$6zu3QwTmxLXJpxfoRumBbaebEiDJ9n+ek2QHzinVNEw=	\N	f	20073999-K	IGNACIO	SANCHEZ UGARTE	f	t	2018-03-15 09:49:44.358178-03	igsanchezu@udd.cl	{"promocion": "2018"}
469	pbkdf2_sha256$100000$bgqRC15wv9Br$4CFt+8YutwecWjDtI7QXDUvxl5zJcRiru+2c6HnHzNs=	\N	f	20165365-7	AGUSTIN	LYON MONTES	f	t	2018-03-15 09:49:44.52967-03	alyonm@udd.cl	{"promocion": "2018"}
470	pbkdf2_sha256$100000$kmtBoTY2jUrh$UiGb6Y9CnKVjgbfJdMgeGRMwSYB0uHTIrST4rvWXfEs=	\N	f	20109160-8	VALENTINA SOFIA	PAVEZ BORGHERO	f	t	2018-03-15 09:49:44.697301-03	vapavezb@udd.cl	{"promocion": "2018"}
471	pbkdf2_sha256$100000$VL1JxLeXcz4g$VNojKKIfJ1+SgRCXMwFD2BcT6yWYNDNUukzOavkzFTM=	\N	f	20074171-4	JUAN CARLOS	DAROCH SCHNEIDER	f	t	2018-03-15 09:49:44.857223-03	jdarochs@udd.cl	{"promocion": "2018"}
472	pbkdf2_sha256$100000$XKCH8PPwF5Tm$lO04zFtZ/FKjDcjyu2btUcAyCOYblaWQHqBTGed05hE=	\N	f	20284740-4	JOSEFINA	MARAMBIO GONZALEZ	f	t	2018-03-15 09:49:45.014338-03	jmarambiog@udd.cl	{"promocion": "2018"}
473	pbkdf2_sha256$100000$c6pVCeNQNI0F$I5IqLbdtfZaZCuSjQ2kyquQz07c1fYZMPVrezQ3Duw0=	\N	f	19892544-6	MARTÍN	SOTO MALDINI	f	t	2018-03-15 09:49:45.175983-03	marsotom@udd.cl	{"promocion": "2018"}
474	pbkdf2_sha256$100000$S0kxbV3Sf31U$b7WJ1rzk2+oUIKMgx9MU/6wX188yD9imZM3gSln/HDo=	\N	f	20163653-1	ANTONIA	TORRES CAÑAS	f	t	2018-03-15 09:49:45.332207-03	anttorresc@udd.cl	{"promocion": "2018"}
475	pbkdf2_sha256$100000$O0pVfQ2iTkpY$DkFFYxYrC096I6Dj8uAOKfT6+fxeM+pTJZkDN0ojqQA=	\N	f	20165278-2	MATIAS	DEL CAMPO LEHUEDE	f	t	2018-03-15 09:49:45.509367-03	mdelcampol@udd.cl	{"promocion": "2018"}
476	pbkdf2_sha256$100000$kjK3uJVchhAm$H9LrxCsRii/LCQEgys5NLwA/+K2P0WyF2FDL+Yy8Ms4=	\N	f	19893278-7	CLEMENTE	SWINBURN ASPILLAGA	f	t	2018-03-15 09:49:45.665303-03	cswinburna@udd.cl	{"promocion": "2018"}
477	pbkdf2_sha256$100000$W1Op3FAkNdQY$z9iYr09xrrJLna71SE+2hcCeg38RkLtBo7aS41FkxTY=	\N	f	20345939-4	VALENTINA ANDREA	VIVAR URIBE	f	t	2018-03-15 09:49:45.819684-03	vvivaru@udd.cl	{"promocion": "2018"}
478	pbkdf2_sha256$100000$leTB9ap9ctYr$CwIKtlNjNcsildY4QLIsINM8JHCZJJY4tkGYDeMz04E=	\N	f	20285012-K	VICENTE	LUHRS CONCHA	f	t	2018-03-15 09:49:45.97327-03	vluhrsc@udd.cl	{"promocion": "2018"}
479	pbkdf2_sha256$100000$s6k57OFs7AW0$NfKkLsClvS5ntyO3ArbLtTwQ5+L58iPlgOz++kZ4Lns=	\N	f	20074191-9	CECILIA ISIDORA	MATAMALA ERBETTA	f	t	2018-03-15 09:49:46.134607-03	cmatamalae@udd.cl	{"promocion": "2018"}
480	pbkdf2_sha256$100000$1qahb6SySke2$tdxhIBwvdf3m4HeKGpJpOyt/qdnm2VBT2Bbc+DG81hk=	\N	f	20075293-7	MARIA ISIDORA	PULLEN CALORIO	f	t	2018-03-15 09:49:46.286345-03	mpullenc@udd.cl	{"promocion": "2018"}
481	pbkdf2_sha256$100000$SVbpc0wwso3k$2I/dNIsD3bTJvqP1k5mA40+6PX/TU8G1Ef5Y2IUizEg=	\N	f	20285184-3	ANA MARIA	CANESSA FERNANDEZ	f	t	2018-03-15 09:49:46.439486-03	acanessaf@udd.cl	{"promocion": "2018"}
482	pbkdf2_sha256$100000$IyXto7vP1jNg$kgTpyE6FOIB5EJv5bO56yPIm9p/liQsL4l9DolstoP4=	\N	f	20258566-3	CYNTHIA SOPHIA	CAPURRO MITCHELL	f	t	2018-03-15 09:49:46.600506-03	ccapurrom@udd.cl	{"promocion": "2018"}
483	pbkdf2_sha256$100000$4E4xGnHadxe9$f7dgU2EUgauNVXhr/TBQU6D++wXOPrXx51oFVJ1lvhk=	\N	f	20283943-6	JACINTA	VALENZUELA VERGARA	f	t	2018-03-15 09:49:46.758267-03	jacivalenzuelav@udd.cl	{"promocion": "2018"}
484	pbkdf2_sha256$100000$AsuIEg1ii9oJ$QQ9AZ9Q2AY+5G5PUo7H+9tE+o07Yer2oZmPIZ8hWcLs=	\N	f	20073591-9	CLEMENTE	HERNANDEZ LATHROP	f	t	2018-03-15 09:49:46.917608-03	clehernandezl@udd.cl	{"promocion": "2018"}
485	pbkdf2_sha256$100000$EN98YLNOAkud$k9GVxQXDCDLvLqy/J04gebqj0DvE0yNPqQH3Wj/kMJQ=	\N	f	20289616-2	TANIA JOSEFA	BRAVO AGUILERA	f	t	2018-03-15 09:49:47.073051-03	tbravoa@udd.cl	{"promocion": "2018"}
486	pbkdf2_sha256$100000$UQhYy7R6C3NY$gUtBkR9VsILNUxsJuPI4HkH6MSK43ZFoF4y/gKPcUBQ=	\N	f	20038973-5	GUSTAVO SEBASTIAN	MARTINEZ ESPINOZA	f	t	2018-03-15 09:49:47.233334-03	gmartineze@udd.cl	{"promocion": "2018"}
487	pbkdf2_sha256$100000$IQL0FikQGXDF$tdfjb10lTA+6vDw2I4TaEub/WLGvSmj9Lva6NbHRIAQ=	\N	f	20075470-0	DIEGO ALFREDO	SELAIVE CAMPOS	f	t	2018-03-15 09:49:47.406086-03	dselaivec@udd.cl	{"promocion": "2018"}
488	pbkdf2_sha256$100000$2WfefedvU4He$orGmnTQMJNKP8dZC9TS+Th/AW6MUmbGKITT7LmUo7c4=	\N	f	20285503-2	INES	DELORENZO GOMEZ	f	t	2018-03-15 09:49:47.558095-03	idelorenzog@udd.cl	{"promocion": "2018"}
489	pbkdf2_sha256$100000$o2w1lCOdxONX$GkOPTWX/epp4MwVY1nCOorp0COhKXZ5sK+ZHF5x7Hvw=	\N	f	20283317-9	VICENTE JOAQUIN	PEÑA CASTRO	f	t	2018-03-15 09:49:47.720315-03	vpenac@udd.cl	{"promocion": "2018"}
490	pbkdf2_sha256$100000$LtYKg5B0dOZg$QajVvZZmr/J8ImYTt6cwIkdFiKo3l65mE5CZq5nMZYo=	\N	f	19496258-4	MARIO NICOLAS	LAGOS CORVACHO	f	t	2018-03-15 09:49:47.886558-03	marilagosc@udd.cl	{"promocion": "2018"}
491	pbkdf2_sha256$100000$LtjpBTlyCoha$14UuTSfm6gS3/WOKy6WLj7sDe0xv/PPqLhXrAWHQ/wg=	\N	f	19246535-4	VICENTE JOAQUIN	VIAL VERGARA	f	t	2018-03-15 09:49:48.048974-03	vvialv@udd.cl	{"promocion": "2018"}
492	pbkdf2_sha256$100000$f6PYWrOYRuub$u1TSSQBfL3qLPVP5jtDVzlhSWI31ekTA65EZUphOjnY=	\N	f	20164475-5	MARIA PAZ	FLORES VARELA	f	t	2018-03-15 09:49:48.201539-03	mafloresv@udd.cl	{"promocion": "2018"}
493	pbkdf2_sha256$100000$yNncbMbl3S3n$U00fDRAu9iYHWyrVhtdzgXDk7e5KU4g5vQy89wzCxiE=	\N	f	19619101-1	JAVIER ANDRES	FLORES TERRAZAS	f	t	2018-03-15 09:49:48.357583-03	javflorest@udd.cl	{"promocion": "2018"}
494	pbkdf2_sha256$100000$t28hJXbCQmJQ$CRXBNJPvJG6+BmnRj399MIEJrKdGrIAYo2DdWkaaAxs=	\N	f	20165209-K	AGUSTINA	DE BLASIS TERAN	f	t	2018-03-15 09:49:48.51215-03	adeblasist@udd.cl	{"promocion": "2018"}
495	pbkdf2_sha256$100000$gGk8EFCXfcsu$uhrhXEDomYSx2pXnT3kRQ1bui2w50adfkX9P1EHFcOQ=	\N	f	20250332-2	BROOKE NICOLE	DAHER ARRIAZA	f	t	2018-03-15 09:49:48.667297-03	bdahera@udd.cl	{"promocion": "2018"}
496	pbkdf2_sha256$100000$qKHxX7zfe8l7$NXB3ozF3Tx5Z/1wVPDLP6PqZgXqX9vM62Lxfgz9fbuw=	\N	f	20287048-1	CATALINA CONSTANZA	QUEZADA CERDA	f	t	2018-03-15 09:49:48.832146-03	caquezadac@udd.cl	{"promocion": "2018"}
497	pbkdf2_sha256$100000$pukqh4tABpVJ$DGwaS6zL5Xg6TZkO7/d8dyWIZ11TnkK9hRiArt2wXjI=	\N	f	20165458-0	BORJA	HURTADO CEPEDA	f	t	2018-03-15 09:49:49.011294-03	bhurtadoc@udd.cl	{"promocion": "2018"}
498	pbkdf2_sha256$100000$tA2TRbqzpd1D$SwpJQPjvBKJukW7qecCKQ2WdX+avxOXT1XSVzNWdyiU=	\N	f	19815123-8	STEFFI MELISSA	BUCONIC GROSS	f	t	2018-03-15 09:49:49.164792-03	sbuconicg@udd.cl	{"promocion": "2018"}
499	pbkdf2_sha256$100000$p2mESv6DS8RA$tIEvi0dhbtYWKbiq7TgmNPyvaqKFcHmlaNzukMMEspM=	\N	f	20165347-9	MACARENA	BORGOÑO GARCES	f	t	2018-03-15 09:49:49.319403-03	mborgonog@udd.cl	{"promocion": "2018"}
500	pbkdf2_sha256$100000$PgJmVg0xsRPj$lVWVHJNM309zV7WB2nxu0Fbw95J9AKwgmyOlmZES/x4=	\N	f	22346342-8	ELKIN HUMBERTO	CHAPARRO FAJARDO	f	t	2018-03-15 09:49:49.489901-03	echaparrof@udd.cl	{"promocion": "2018"}
501	pbkdf2_sha256$100000$lFvu5egNwUN6$aEqw8Mq/GLD10ug52RYYA5sQg/X7oOtpwS11WSMMSBY=	\N	f	19937768-K	SOFIA	LIRA CORREA	f	t	2018-03-15 09:49:49.667286-03	slirac@udd.cl	{"promocion": "2018"}
502	pbkdf2_sha256$100000$e7C1JiXAWBgm$Eh6dctXyws/VSjois/ZEAY8h4Ch0qOOCwtU4jGD+V90=	\N	f	20285828-7	ANDRES	MARTIN MARIN	f	t	2018-03-15 09:49:49.854929-03	amartinm@udd.cl	{"promocion": "2018"}
503	pbkdf2_sha256$100000$A0GZMCrV68qk$q4KdXTYl9yhGTUIHEVIiEq+FHLyIe/CyrWB2kXGDVaw=	\N	f	19323429-1	CATALINA SOFIA	PEREZ FUENTES	f	t	2018-03-15 09:49:50.003803-03	caperezf@udd.cl	{"promocion": "2018"}
504	pbkdf2_sha256$100000$KU8VydZ89Pbi$h2YNa8wLLZU/uZ6ku0ERCyyCTCDIwfKBiwNk/9RH9yI=	\N	f	20299226-9	DIEGO PABLO	DE TORO CHELLEW	f	t	2018-03-15 09:49:50.183153-03	ddetoroc@udd.cl	{"promocion": "2018"}
505	pbkdf2_sha256$100000$mOig4doYn8c4$sMIZkQayhggjlqis2rc0bWh04qRTr3SLZpSi765ux+g=	\N	f	20283844-8	PAULA CONSTANZA	BASTIAS MENDEZ	f	t	2018-03-15 09:49:50.351609-03	pbastiasm@udd.cl	{"promocion": "2018"}
506	pbkdf2_sha256$100000$on4l53Z86LAe$oWwkjOjprx2DUL3Kr71IInh9o9Cq7NwaGgEu3a9Rp3Y=	\N	f	20287346-4	ELISA	PLANELLA DURRUTY	f	t	2018-03-15 09:49:50.514175-03	eplanellad@udd.cl	{"promocion": "2018"}
507	pbkdf2_sha256$100000$BPEJcOQGK7Pr$IzhxM5FktRgbUWoIO0aa6wbSQO/7RuE7qbfJeIaqhIE=	\N	f	20358538-1	LUIS TOMAS	CAMBIASO CHAHUAN	f	t	2018-03-15 09:49:50.705092-03	lcambiasoc@udd.cl	{"promocion": "2018"}
508	pbkdf2_sha256$100000$4ac7Xvgywndi$yYPsFmfTKlitGfMAalm/aX/1Ph+2gBFdvLWzF1VEFus=	\N	f	20075847-1	BELTRAN	LASSERRE PERALTA	f	t	2018-03-15 09:49:50.852371-03	blasserrep@udd.cl	{"promocion": "2018"}
509	pbkdf2_sha256$100000$LAd7GmYpj3ug$yjaxNMxLNoIzuIafCyWpjXuCVmG8xMGfdBmReSuJYzc=	\N	f	20165542-0	BENJAMIN JOSE	JOVEL PINEDO	f	t	2018-03-15 09:49:51.009883-03	bjovelp@udd.cl	{"promocion": "2018"}
510	pbkdf2_sha256$100000$sPA5pXr1Plxe$dWQnzHE6kRzZYQz7hRUbkvxprQR89McCpnQVnw5GLwQ=	\N	f	20062525-0	EVA PAULA	CASTILLO RUIZ	f	t	2018-03-15 09:49:51.17786-03	ecastillor@udd.cl	{"promocion": "2018"}
511	pbkdf2_sha256$100000$9uTrS8VwE6dc$TxFz8ai+tMVYg0ZUY8ny2Xd7nFhaJrNY3HwR3Gvxs1c=	\N	f	20073879-9	MATIAS IGNACIO	ROJAS NOVOA	f	t	2018-03-15 09:49:51.353316-03	marojasn@udd.cl	{"promocion": "2018"}
512	pbkdf2_sha256$100000$dJC4EwucpGYa$6zNAGw2AVMfO/QEx4XyZidDge+frWAVwRpGAHXLRBWg=	\N	f	20286380-9	SEBASTIAN ALFONSO	RIVEROS SIRVENT	f	t	2018-03-15 09:49:51.511479-03	sriveross@udd.cl	{"promocion": "2018"}
513	pbkdf2_sha256$100000$B798NzL7TFlM$illRey8AnI5v+oz6xD1V9SdrC1ZAoEFxAZZzEdNFlfE=	\N	f	20285476-1	KAI	MEIER SEEGER	f	t	2018-03-15 09:49:51.674286-03	kmeiers@udd.cl	{"promocion": "2018"}
514	pbkdf2_sha256$100000$C31OK7V9jY2Q$Ng5lgxbSw0dHkfXaexf0PwjrcmgEBlOvMteG5DQe3wU=	\N	f	20365851-6	EMILIO ANTONIO	TALADRIZ GITTERMANN	f	t	2018-03-15 09:49:51.825212-03	etaladrizg@udd.cl	{"promocion": "2018"}
515	pbkdf2_sha256$100000$xJAA33jRAVKX$29c6E9FrGj7BJ9pjo0dLNY4RttDCEMd95Awuz55sVTs=	\N	f	20214676-7	JOSE ANTONIO	MORALES RAMIREZ	f	t	2018-03-15 09:49:51.980318-03	jomoralesr@udd.cl	{"promocion": "2018"}
516	pbkdf2_sha256$100000$RfdrkD4zdBvk$XeWAgzB8GXTnLvRi66bjLdRbc6BdP5HOVcj+5RBZr8M=	\N	f	20264396-5	VALENTINA DEYZA	HODGE HERNANDEZ	f	t	2018-03-15 09:49:52.150951-03	vhodgeh@udd.cl	{"promocion": "2018"}
517	pbkdf2_sha256$100000$M27JtAOklFEl$g0R5N4Dkkbhqdgo4LGn35A15hHmkqcvnXWUvPAMPzLg=	\N	f	20286008-7	SOFIA EMMA	MIRANDA SERRANO	f	t	2018-03-15 09:49:52.303659-03	smirandas@udd.cl	{"promocion": "2018"}
518	pbkdf2_sha256$100000$nRuol9idAfKa$PvBzbyjeg9rDZbZqUrOY4EtugwjV7qHXaCneKvkdhuE=	\N	f	20109878-5	FRANCISCA PAZ	MADRID ROMAN	f	t	2018-03-15 09:49:52.445327-03	fmadridr@udd.cl	{"promocion": "2018"}
519	pbkdf2_sha256$100000$n20W278WHeSz$rdYu4PEQvFcpllhcHUG0lrL576zOZXJIFt5ardc6jQc=	\N	f	20181108-2	DANIELA PAZ	MEYER SOLABARRIETA	f	t	2018-03-15 09:49:52.603299-03	dmeyers@udd.cl	{"promocion": "2018"}
520	pbkdf2_sha256$100000$ZkYlMC9S1aBd$5benL4++lWZ2qnNKyHw/w5h233tMQEQwWsBmnl0+88A=	\N	f	20014492-9	VALENTINA	RESTREPO GONZALEZ	f	t	2018-03-15 09:49:52.757271-03	vrestrepog@udd.cl	{"promocion": "2018"}
521	pbkdf2_sha256$100000$lgggRmuBO7Qt$fUy2jfMtFh/QLZPoa7qZV/1F7xq8LtFUcLjTH0cDfaU=	\N	f	20074430-6	AUGUSTIN	BOETSCH DEPASSIER	f	t	2018-03-15 09:49:52.920491-03	auboetschd@udd.cl	{"promocion": "2018"}
522	pbkdf2_sha256$100000$KBo5UD0IWTyT$qZInBKo+H2L5Qm3rujmfW/TuycRjjpxWl4SGDD/az8U=	\N	f	20109298-1	SOFIA MARLENE	VERA WERB	f	t	2018-03-15 09:49:53.08427-03	sveraw@udd.cl	{"promocion": "2018"}
523	pbkdf2_sha256$100000$k1AXXb9mrg51$sLHXdZWxGkswanDmLTpYOpVcrYgxCWpD9lC2gFwYIyY=	\N	f	20243029-5	SANTIAGO ERNESTO	FERNANDEZ ERRAZURIZ	f	t	2018-03-15 09:49:53.25784-03	safernandeze@udd.cl	{"promocion": "2018"}
524	pbkdf2_sha256$100000$jP0Ay3pP7FoB$067mCUl0mnTihEyuoYkuZb3w2xmt0ngICD84D1puiYY=	\N	f	20056658-0	PAULA ALEJANDRA	GONZALEZ OVALLE	f	t	2018-03-15 09:49:53.416501-03	paugonzalezo@udd.cl	{"promocion": "2018"}
525	pbkdf2_sha256$100000$ejGAXHVVoP1A$z8RdUYDe4pRrjN2kj3t1SRu5tQzaLo68BRagxzOOFuQ=	\N	f	20283427-2	SILVANA	BURSIC PERAZZO	f	t	2018-03-15 09:49:53.578646-03	sbursicp@udd.cl	{"promocion": "2018"}
526	pbkdf2_sha256$100000$k3EKCs3VKXCX$Iq4WBJXaLu40O4lB1SsH2DIEZJruVgaXuUO5hylJZI4=	\N	f	20165103-4	ANDRES	WAGNER DE LA CERDA	f	t	2018-03-15 09:49:53.737447-03	awagnerd@udd.cl	{"promocion": "2018"}
527	pbkdf2_sha256$100000$YFSf8ea7LTtm$WKaSCKXkhIISJNhnA4I4TaFpRyOYqxzaHluRph5XVYg=	\N	f	20075892-7	MACARENA	LABRANQUE ASTORGA	f	t	2018-03-15 09:49:53.888062-03	mlabranquea@udd.cl	{"promocion": "2018"}
528	pbkdf2_sha256$100000$XvX0hx66JcPm$/qGC7SnyMSdZyNLaBQwNzsFCyTXPSap8Kk6Z7MfSeQ8=	\N	f	20443820-K	MARIO ANDRES	QUIROZ BECERRA	f	t	2018-03-15 09:49:54.067326-03	mquirozb@udd.cl	{"promocion": "2018"}
529	pbkdf2_sha256$100000$YR7OoYQei830$u0Qo8+zxG5vTwlMQccavbbGj3XkbQjLGcayIp8P0tHI=	\N	f	20073557-9	BASTIAN IGNACIO	OCHOA MIRANDA	f	t	2018-03-15 09:49:54.259473-03	bochoam@udd.cl	{"promocion": "2018"}
530	pbkdf2_sha256$100000$foqhkYBhHurI$8Zv5Sm2ts2DrJslcGLAWQfE/hHDMLGVlx7VAlq6ev9M=	\N	f	22596139-5	DANIEL ALEJANDRO	SOLANO GONZALEZ	f	t	2018-03-15 09:49:54.425394-03	dsolanog@udd.cl	{"promocion": "2018"}
531	pbkdf2_sha256$100000$n0E0dEh1WONO$zjiOVuI0wnl8RpGgL0Zo6vIAjhYkBFDGUuy0adp/zKM=	\N	f	20443795-5	JOSEFA BELEN	ORTIZ FERNANDEZ	f	t	2018-03-15 09:49:54.594059-03	jortizf@udd.cl	{"promocion": "2018"}
532	pbkdf2_sha256$100000$k5RdIIoMsk2Q$OzR6CqQiFmEvGq70AKI2dhLov3Lb4BCVae3QkMkJ6co=	\N	f	20084263-4	NICOLÁS	DUNFORD ALOMAR	f	t	2018-03-15 09:49:54.760577-03	ndunforda@udd.cl	{"promocion": "2018"}
533	pbkdf2_sha256$100000$YxycOXJOxehj$nAfL6+//oGsjmB7jmOZNpoSCWNKHKj05yhZIhie9OjE=	\N	f	20107583-1	JAVIERA VICTORIA	RAMIREZ SILVA	f	t	2018-03-15 09:49:54.923932-03	javiramirezs@udd.cl	{"promocion": "2018"}
534	pbkdf2_sha256$100000$MAdi17mYO73J$vyI4St6Os9zT/7p01LdJGdfhuOymgHA1+SiqulP4kQs=	\N	f	22229207-7	VICENTE JOSE	MUÑOZ ARTEAGA	f	t	2018-03-15 09:49:55.085258-03	vicmunoza@udd.cl	{"promocion": "2018"}
535	pbkdf2_sha256$100000$vV2DkgDa88RE$fQedFjgBjj8zI9TCm4ZQY93+5IwieZAjBkyLjneLUbk=	\N	f	19638715-3	FRANCISCO JOSE	GUZMAN PILASI	f	t	2018-03-15 09:49:55.249205-03	frguzmanp@udd.cl	{"promocion": "2018"}
536	pbkdf2_sha256$100000$u8nCchtCJaQK$i3qWMSgQDRa6gvomaapa2yV8APOQgNQJhJZ7Ta6LRmE=	\N	f	20076120-0	SEBASTIAN EDUARDO	KUTSCHER ARANCIBIA	f	t	2018-03-15 09:49:55.39654-03	skutschera@udd.cl	{"promocion": "2018"}
537	pbkdf2_sha256$100000$NLCNILHIFMB3$L+QLbY7D83Z3DLsIxJV4+b1YN0Pdk6HNMnaMb9AhSzM=	\N	f	20298099-6	CARLA	LOZANO GUILLEMINOT	f	t	2018-03-15 09:49:55.542234-03	clozanog@udd.cl	{"promocion": "2018"}
538	pbkdf2_sha256$100000$GJsxXzleWOyb$q505AWiO0b5xWtwdWZjUrtOaw87KU/PT+VBtDAPt3NE=	\N	f	20298628-5	MARIA FRANCISCA	HERNANDEZ KEJAYA	f	t	2018-03-15 09:49:55.702475-03	mahernandezk@udd.cl	{"promocion": "2018"}
539	pbkdf2_sha256$100000$vA95UxMMxiYk$H26S7uRVXRS6bfBd/c+7zDdRHIoox1C/2Kdx4ezpcw8=	\N	f	19838845-9	NICOLAS IGNACIO	BARRIGA DIAZ	f	t	2018-03-15 09:49:55.860236-03	nbarrigad@udd.cl	{"promocion": "2018"}
540	pbkdf2_sha256$100000$CeYffDsCSWtA$axZCvQUzWzRmePQI4EXeX/YKrob0R/veSF6g7/8F7eQ=	\N	f	20168472-2	ISIDORA ANTONIA	BAHRS CHAVEZ	f	t	2018-03-15 09:49:56.032692-03	ibahrsc@udd.cl	{"promocion": "2018"}
541	pbkdf2_sha256$100000$FeTgu55Vg4Vv$81fq/2hmp5dAvjggfJ8vbWaGPQnpzy+RXKRphyMb3u8=	\N	f	19640079-6	FERNANDA ISIDORA	MASSUH RUEDLINGER	f	t	2018-03-15 09:49:56.193719-03	femassuhr@udd.cl	{"promocion": "2018"}
542	pbkdf2_sha256$100000$LOUvI7j6mQIB$SJvjcR/YMboNfzKvRjfLxL8qo0BCL/kZaVf5tAYJEo4=	\N	f	20299843-7	AMANDA	ROMERO GILI	f	t	2018-03-15 09:49:56.366371-03	amromerog@udd.cl	{"promocion": "2018"}
543	pbkdf2_sha256$100000$OmLh9fJJVMV8$8883bal8rXFMF5WYgmgosGe9gU9O8YGyzEcxDhlKy/E=	\N	f	20009368-2	ESPERANZA CATALINA	GEBRIE FUENTES	f	t	2018-03-15 09:49:56.543269-03	egebrief@udd.cl	{"promocion": "2018"}
544	pbkdf2_sha256$100000$1i7jqOkkNch2$LOyVph3Tj4u+5FF6n++0vW3A9U2OMJBaZK5KBnhYTm4=	\N	f	20075605-3	EMILIA	MORO SILVA	f	t	2018-03-15 09:49:56.690521-03	emoros@udd.cl	{"promocion": "2018"}
545	pbkdf2_sha256$100000$BUF8lauBZNCL$+1WBhasPfL35RFSlNKWVifMq+qLn+tD6b+r/WpXyJWA=	\N	f	19889535-0	FELIPE	VIAL DONOSO	f	t	2018-03-15 09:49:56.857592-03	fviald@udd.cl	{"promocion": "2018"}
546	pbkdf2_sha256$100000$ZQVxc0Fm2p3Q$8Xe4yeURkIjblW/YoeO2IjL48lCvKEPBi+0DTGFVD3o=	\N	f	20427272-7	DANIELA ANTONIA	BALTRA MARTINEZ	f	t	2018-03-15 09:49:57.049547-03	dbaltram@udd.cl	{"promocion": "2018"}
547	pbkdf2_sha256$100000$xRkWfQK4ysPe$A7JneuYPcKFNj7wLp3hMtURTDbcWMONBUczaoBhQtiQ=	\N	f	20073021-6	VALENTINA FERNANDA	MIRANDA ALVAREZ	f	t	2018-03-15 09:49:57.211306-03	vmirandaa@udd.cl	{"promocion": "2018"}
548	pbkdf2_sha256$100000$gnBipYYaTrZK$zvj1+7zim53bV5WKVo8L6izTNWLv5GiJjoALzkeDOvw=	\N	f	19891503-3	RODRIGO ARTURO	SEISDEDOS RUISEÑOR	f	t	2018-03-15 09:49:57.401636-03	rseisdedosr@udd.cl	{"promocion": "2018"}
549	pbkdf2_sha256$100000$MIdWGE6oBmyy$wfprBuQq2Xoo3hj35nmgbznNsTg53wBoWBJDx0JbnFo=	\N	f	20163623-K	PABLO ANDRES	EDWARDS CONSIGLIERE	f	t	2018-03-15 09:49:57.573334-03	pedwardsc@udd.cl	{"promocion": "2018"}
550	pbkdf2_sha256$100000$pMuUlAQP4wx5$boUCLe7Z9EHt/4/CjX1kM2N8xg45HYGmCqsEnT7uYvg=	\N	f	20075797-1	MARIA JOSEFA	ACEVEDO ETCHEBERRIGARAY	f	t	2018-03-15 09:49:57.725494-03	macevedoe@udd.cl	{"promocion": "2018"}
551	pbkdf2_sha256$100000$DQPdkyzs4SQS$mWCrR0RpL/FvHDKJc3e36wzscF4fcv5wa+i8EkfYBTQ=	\N	f	20284732-3	MARIA TRINIDAD	GARCIA MALAGAMBA	f	t	2018-03-15 09:49:57.888255-03	mariatrgarciam@udd.cl	{"promocion": "2018"}
552	pbkdf2_sha256$100000$T7BHfN7NJqwO$4BeZCeHY1Cr9LmoZeyL+tOJPwudPzsQGCSmzRu2CobY=	\N	f	20264536-4	CAMILA FERNANDA	GUZMAN AYUB	f	t	2018-03-15 09:49:58.056383-03	camguzmana@udd.cl	{"promocion": "2018"}
553	pbkdf2_sha256$100000$vsGSdvB6C1GX$lX0U6T2aSh5zQONpCkozZ7O//CmX7FvjV0z3p2+DvOU=	\N	f	19639018-9	CAMILA	LETTER SOCIAS	f	t	2018-03-15 09:49:58.215621-03	cletters@udd.cl	{"promocion": "2018"}
554	pbkdf2_sha256$100000$IMDrekpk2h7V$SnfFJaJSiGh2loUpWT2u/pltOKaYh37IH9zwMvObqa0=	\N	f	19952500-K	THOMAS WILLIAM	PUGH ARACENA	f	t	2018-03-15 09:49:58.359418-03	tpugha@udd.cl	{"promocion": "2018"}
555	pbkdf2_sha256$100000$AwYsrajuKBxD$m6yiFlLFfM8pjyZT1zGCQa8g0pFyhvfDEvL2Kgz0atM=	\N	f	20163642-6	CLARA	BALMACEDA ACHURRA	f	t	2018-03-15 09:49:58.525845-03	cbalmacedaa@udd.cl	{"promocion": "2018"}
556	pbkdf2_sha256$100000$ZO2AFP2shD4x$SFf9xPHKgyhiI2YjST4AzoVbvaOIYRyfQmAa1FkgV0w=	\N	f	19863852-8	CRISTOBAL ROBERTO	CLEMENT ELLER	f	t	2018-03-15 09:49:58.691191-03	cclemente@udd.cl	{"promocion": "2018"}
557	pbkdf2_sha256$100000$XiWRnC2xQGlj$LiT/3PRpnexbNWbtmysC3oKDkF3nqc0srl+H9nn/i4I=	\N	f	19840728-3	MAXIMILIANA	GARCIA VERGARA	f	t	2018-03-15 09:49:58.849598-03	maxgarciav@udd.cl	{"promocion": "2018"}
558	pbkdf2_sha256$100000$vInassWnoZIj$/2K89vp21vHSIxI2B2DtDFvk/1niPjKDV9M7w31LRno=	\N	f	20075497-2	CARLOS GONZALO	PRIETO CUADRADO	f	t	2018-03-15 09:49:59.003539-03	caprietoc@udd.cl	{"promocion": "2018"}
559	pbkdf2_sha256$100000$VHiRbNG9BrSw$vYSxJ1KmYEh2yBQGvJ+TCGva7o6tGXd5BvOCzqQX/bo=	\N	f	20161206-3	LENDELI	DIAZ ESTRADA	f	t	2018-03-15 09:49:59.170484-03	lediaze@udd.cl	{"promocion": "2018"}
560	pbkdf2_sha256$100000$tk33UzBYatvg$Hkr+cACCubpb+cv+GtHuVTHVJG7t+kw/DJxC30ezy/k=	\N	f	20269795-K	MAGDALENA BEATRIZ	RAMIREZ RODRIGUEZ	f	t	2018-03-15 09:49:59.322595-03	magramirezr@udd.cl	{"promocion": "2018"}
561	pbkdf2_sha256$100000$LNKZUI48KrWG$E+pNZ3MNMTMPVyN4PxbceA9aRJ2q8B45IArO+WnfxOo=	\N	f	20298738-9	JOSEFA ANAIS	OLHABERRY CARRASCO	f	t	2018-03-15 09:49:59.473537-03	jolhaberryc@udd.cl	{"promocion": "2018"}
562	pbkdf2_sha256$100000$o9zcj2YjTIIF$Ml6i591t5wR1PEBJaALTb0OLC06dGVX0nNB5fZv/ztU=	\N	f	20286655-7	ISIDORA ALEXANDRA	NAVARRO ALLENDE	f	t	2018-03-15 09:49:59.621227-03	inavarroa@udd.cl	{"promocion": "2018"}
563	pbkdf2_sha256$100000$Xu8amXklXFAy$I85g6s5bLlPVk+rjHFEBRktbL9LP08tQtUUJNQjv4ww=	\N	f	20285214-9	CLEMENTE AUGUSTO	SAAVEDRA NEF	f	t	2018-03-15 09:49:59.776836-03	clsaavedran@udd.cl	{"promocion": "2018"}
564	pbkdf2_sha256$100000$njqJeofQzSZz$b7iKg9qQq0TRlQK0ipDtEUo5qDCnj9KTk7mlmgVhSuE=	\N	f	19863279-1	MATHIAS IGNACIO	CAVIERES BARRIA	f	t	2018-03-15 09:49:59.930427-03	mcavieresb@udd.cl	{"promocion": "2018"}
565	pbkdf2_sha256$100000$GuivNDrMsUHv$yuKCS9CzBhH+T6ducsDPvYHs3UJDT0fqBj4TWE6uswI=	\N	f	20326025-3	SASHA MARIA	MANRIQUE ESTRADA	f	t	2018-03-15 09:50:00.083753-03	smanriquee@udd.cl	{"promocion": "2018"}
566	pbkdf2_sha256$100000$KkcG62GHb61F$RchmidyRuJLshkp/MfaOVIpn59DxxhVl/nAWTmX4EKg=	\N	f	20284025-6	SEBASTIAN IGNACIO	CARMONA SORREL	f	t	2018-03-15 09:50:00.24568-03	scarmonas@udd.cl	{"promocion": "2018"}
567	pbkdf2_sha256$100000$3a5MxsJPgDIM$tyt1LJnrlTM8qRRDmzk3qq9/GaratFHlHja9JOOyZA8=	\N	f	20285661-6	ISIDORA PAZ	TRAMON HERRERIAS	f	t	2018-03-15 09:50:00.422982-03	itramonh@udd.cl	{"promocion": "2018"}
568	pbkdf2_sha256$100000$kllnSQsur5Vu$L9XBZQbXjkV/ZS0sZqJEVou1qSxoZOEkaAWSspdc/9U=	\N	f	19972315-4	MATIAS	ACUÑA ESPINOZA	f	t	2018-03-15 09:50:00.579942-03	macunae@udd.cl	{"promocion": "2018"}
569	pbkdf2_sha256$100000$qWRVJZNoPfRc$Z5uYzA1hoqK/cjSqzgpMNQsHt1LOjJa+mSxVGFm/GdI=	\N	f	20663866-4	JOSE ANDRES	LOPEZ MORGAN	f	t	2018-03-15 09:50:00.759486-03	joslopezm@udd.cl	{"promocion": "2018"}
570	pbkdf2_sha256$100000$HmvlJS0F6GVy$31WXLws7ponRqXjwGwWciNxR18Ic/gF5kpaAjF3xD2k=	\N	f	20238183-9	MARTINA EMILIA	PERONDI CASTAÑO	f	t	2018-03-15 09:50:00.909782-03	mperondic@udd.cl	{"promocion": "2018"}
571	pbkdf2_sha256$100000$S4l6noPUlcu0$FS65FZZZZSw0vn3NtRu3FikGuQq0Q4pJsRgTU+ddMc8=	\N	f	20165157-3	PABLO ALFREDO LUIS	UGARTE SILVA	f	t	2018-03-15 09:50:01.061456-03	pugartes@udd.cl	{"promocion": "2018"}
572	pbkdf2_sha256$100000$mjxRdZ0OnJQq$SofuvPYCoCCXgYW+pkpto7ReNTACanpacruGClKHfoI=	\N	f	19638649-1	MATIAS	AUAD LARRAIN	f	t	2018-03-15 09:50:01.229087-03	maauadl@udd.cl	{"promocion": "2018"}
573	pbkdf2_sha256$100000$VqktwwHs7FRl$oA3KAFMhAbDXjUt81map4TaqqnOSz3mLEfmJ31t4VkI=	\N	f	19978478-1	JAVIERA MONTSERRAT	SALAS DELGADO	f	t	2018-03-15 09:50:01.386016-03	jsalasd@udd.cl	{"promocion": "2018"}
574	pbkdf2_sha256$100000$0Mxy3TN3meEv$YNBUgjrRoJAHmICJbGGYvpyVUJlM/Nm8j3Y/XYNMzYY=	\N	f	20164736-3	ANTONIA DE JESUS	URRUTIA HERRERA	f	t	2018-03-15 09:50:01.537578-03	aurrutiah@udd.cl	{"promocion": "2018"}
575	pbkdf2_sha256$100000$aZM3YSioNlX4$+xO/reGM1FcZZPP6Abq5abQ57HyDMDdjiVdWB+LUen8=	\N	f	20073793-8	JORGE ARTURO	UGALDE ZINCKE	f	t	2018-03-15 09:50:01.693827-03	jugaldez@udd.cl	{"promocion": "2018"}
576	pbkdf2_sha256$100000$bpF9ZWOIAWNq$dkKDAWVUxC+JpW5UmqRsuW5H9ZvC1e2T+HLJiiu11kg=	\N	f	19639766-3	VERONICA PAZ	ZAPATA VENEGAS	f	t	2018-03-15 09:50:01.854427-03	vzapatav@udd.cl	{"promocion": "2018"}
577	pbkdf2_sha256$100000$aPjZEuufJQqH$jWKZYS8hc1qhLVHQR3SbEDdcpy1hmvQskaQYoQf3kqA=	\N	f	20165371-1	SANTIAGO	ASPILLAGA VERGARA	f	t	2018-03-15 09:50:02.016352-03	saspillagav@udd.cl	{"promocion": "2018"}
578	pbkdf2_sha256$100000$ALpxw9xJvwpK$Jfg2ygQraHc73dt7nCp2bF1/Dwgjy7jiLC+zebqL2yk=	\N	f	20427629-3	TOMAS ANDRES	URBINA BECERRA	f	t	2018-03-15 09:50:02.171715-03	turbinab@udd.cl	{"promocion": "2018"}
579	pbkdf2_sha256$100000$lSMJJuHRHTXH$iW4W+JsLw5WzObBvpSqtsIiGw3cxalHDWWKGqBpZ7N8=	\N	f	20237112-4	JAVIERA CATALINA	OCAÑA CASTILLO	f	t	2018-03-15 09:50:02.317287-03	jocanac@udd.cl	{"promocion": "2018"}
580	pbkdf2_sha256$100000$ZeE27tajgW3u$ydUVAmfY0Kv46S9ziXkl+ynZLuMM9DwaM9Xi6y2Okb8=	\N	f	20298581-5	MATIAS ANDRES	TAPIA CANALES	f	t	2018-03-15 09:50:02.496221-03	mattapiac@udd.cl	{"promocion": "2018"}
581	pbkdf2_sha256$100000$OLCLMuv3piJb$SrhdcqjVfeFUjx7hptKJLvGPsWoRQDoBFz9XxKWd2XY=	\N	f	20299521-7	LUKAS MATÍAS	ORMEÑO SERRANO	f	t	2018-03-15 09:50:02.639425-03	luormenos@udd.cl	{"promocion": "2018"}
582	pbkdf2_sha256$100000$5ZHuCC912m6n$Qgls+aWnwptkuBONWZoaZ88WROMBwb6jmOGnMME3PSM=	\N	f	20212631-6	KATIA ANDREA	VOIGT KARAMANOS	f	t	2018-03-15 09:50:02.806278-03	kvoigtk@udd.cl	{"promocion": "2018"}
583	pbkdf2_sha256$100000$9afeC64nopoL$hpLIr4SgyHH2CTQW7erbK1kqYCw6/2TLpg0lVmXYK9s=	\N	f	22038991-K	NATHAN	DONSKOY SISSA	f	t	2018-03-15 09:50:02.95786-03	ndonskoys@udd.cl	{"promocion": "2018"}
584	pbkdf2_sha256$100000$Yr2Tj22Krpz7$xWWZWLCigHsT8mgn/RVGbWsLqcDTHin82sS2oOWHrlk=	\N	f	20120242-6	FLORENCIO ANDRES RUBEN	PRATS DIAZ	f	t	2018-03-15 09:50:03.144394-03	fpratsd@udd.cl	{"promocion": "2018"}
585	pbkdf2_sha256$100000$PcvoWnoXJBTX$Yhqp9fxhDysVoUPmNJFYptije0XJxogalK18LkR4lk8=	\N	f	20298345-6	RENATA SOFIA	CONTESSE FAUNDEZ	f	t	2018-03-15 09:50:03.296808-03	rcontessef@udd.cl	{"promocion": "2018"}
586	pbkdf2_sha256$100000$W4XujchBxz5A$eWc58NrEAT0dTha/8+uswje2/IFT5jBKCe1WIyHniDU=	\N	f	19830134-5	NILECHT ANDRES	GARRIDO ANTUNEZ	f	t	2018-03-15 09:50:03.456457-03	ngarridoa@udd.cl	{"promocion": "2018"}
587	pbkdf2_sha256$100000$Dg2XRAz7CMk0$obmCrVyt4pPMa9SiBBzzdKX+mMawm/L91BOamyPLqsA=	\N	f	19880894-6	MARIA IGNACIA	HERMOSILLA MUÑOZ	f	t	2018-03-15 09:50:03.617388-03	mhermosillam@udd.cl	{"promocion": "2018"}
588	pbkdf2_sha256$100000$fojrX0OEQDl8$Pd6hlW0dS04EgTk1xpvwv0hHGsBn/Wy32dEII2hAKvs=	\N	f	19890437-6	DIEGO JOSE	LAMBERT LEON	f	t	2018-03-15 09:50:03.771885-03	dlambertl@udd.cl	{"promocion": "2018"}
589	pbkdf2_sha256$100000$Wm4bz4ZyZlPQ$gxP7N1hF43ydmg75jav6LEJnIcsJgzXJKTBKzJT/6t4=	\N	f	20164207-8	PABLO	AMUNATEGUI VIAL	f	t	2018-03-15 09:50:03.919561-03	pamunateguiv@udd.cl	{"promocion": "2018"}
590	pbkdf2_sha256$100000$U6ng93aCwgew$UCeYq4tzxudFFEsmlA0hN7uaE8H3OvXhTtFL/KpM31g=	\N	f	20165457-2	CATALINA PAZ	HOLMES LANAS	f	t	2018-03-15 09:50:04.073989-03	cholmesl@udd.cl	{"promocion": "2018"}
591	pbkdf2_sha256$100000$5khISvqWhflr$hvJM/Iq4BR5jAeMr3coJSE0P4pr48x+AsS8Q5Vo2bME=	\N	f	20117875-4	JORGE FELIPE	ABELLO ORTIZ	f	t	2018-03-15 09:50:04.226422-03	jabelloo@udd.cl	{"promocion": "2018"}
592	pbkdf2_sha256$100000$CI2H1RRjCfzp$JhQuE0MDbrMXgjz13va9NDayODuqLln534YCFa7qYws=	\N	f	19743843-6	ADOLFO ANTONIO	CALDERON SALAS	f	t	2018-03-15 09:50:04.38375-03	adcalderons@udd.cl	{"promocion": "2018"}
593	pbkdf2_sha256$100000$cd1MtH9BxrJ0$ks9fFTBGv6ufmoZwDVprIp6mihYOf11nAs0EeFYpNCE=	\N	f	20050083-0	AGUSTIN ALFREDO	SCHMAUCK MEDINA	f	t	2018-03-15 09:50:04.546995-03	aschmauckm@udd.cl	{"promocion": "2018"}
594	pbkdf2_sha256$100000$HYBT5ZQNIbYT$MvBJk6Ns9+F3u18pjITcjedLjajDewcMf/gBgL4Iuu0=	\N	f	19959022-7	VALENTINA ANGELICA	ARANEDA ROJAS	f	t	2018-03-15 09:50:04.715323-03	varanedar@udd.cl	{"promocion": "2018"}
595	pbkdf2_sha256$100000$vhXs0u7QDp79$eYalJI8YC4c8vhymC8NvuSaj2a87Lw9GqFaPsR6JrBc=	\N	f	18745954-0	PHILIP ANTOINE	MARCOS CANDIA	f	t	2018-03-15 09:50:04.873537-03	pmarcosc@udd.cl	{"promocion": "2018"}
596	pbkdf2_sha256$100000$muoeMpXbD4gx$ap5nC+k5K/qm04iSxuODHBSpXtOtO9818q+6LC6OBeI=	\N	f	19567726-3	ISIDORA	ANRIQUEZ MAURICIO	f	t	2018-03-15 09:50:05.055833-03	ianriquezm@udd.cl	{"promocion": "2018"}
597	pbkdf2_sha256$100000$WwgXZmNC3hDa$f1HebvW8kRuGOIi8AveYk2g8GchhXHte5wiGGWhK7hQ=	\N	f	19891206-9	MATIAS IGNACIO	GODOY CAZOR	f	t	2018-03-15 09:50:05.214601-03	matgodoyc@udd.cl	{"promocion": "2018"}
598	pbkdf2_sha256$100000$onbHCiXwgFgQ$HM8dfaLcd/pzpK57WxjgWJyfa3oGG2EH7pHbHP7XSZY=	\N	f	9562666-1	VALENTINA 	NUÑEZ BARAZARTE	f	t	2018-03-15 09:50:05.370675-03	vanunezb@udd.cl	{"promocion": "2018"}
599	pbkdf2_sha256$100000$l0VuZi8WbWdx$KdUXnWrmZBTV7KFUtvn72DoilZTabvXhnOlwpgUuXso=	\N	f	19668990-7	CRISTOBAL ALEJANDRO	BRICEÑO RAMIREZ	f	t	2018-03-15 09:50:05.532043-03	cbricenor@udd.cl	{"promocion": "2018"}
600	pbkdf2_sha256$100000$bOpwTTSdEjGt$T5qZf9VcrHBuGBXrnu2LTw2FxCElGKZIY5yw6J6o/h4=	\N	f	19245452-2	BERNARDITA CAROLINA	MASSUH RUEDLINGER	f	t	2018-03-15 09:50:05.686915-03	bmassuhr@udd.cl	{"promocion": "2018"}
601	pbkdf2_sha256$100000$XhLTaV8RFshy$acV8+sfCgB/IDuG+JChR44fEobxqrmwleN+v720l+z8=	\N	f	19951733-3	JOAQUIN VICENTE	PALACIOS SANTANA	f	t	2018-03-15 09:50:05.841251-03	jpalacioss@udd.cl	{"promocion": "2018"}
602	pbkdf2_sha256$100000$piqNjxSxqkLv$FLWSI1BbTtwQUUoibeguRmpDwfA93+MNDmMWLSrtEEM=	\N	f	20185515-2	IGNACIO JAVIER	PALMA MORAGA	f	t	2018-03-15 09:50:05.995501-03	ipalmam@udd.cl	{"promocion": "2018"}
603	pbkdf2_sha256$100000$W3T5PZVMKcMh$biTfYQXATgQI69Stb2xhJ+O4kijAvnjNdZuo1TZljoM=	\N	f	20109736-3	EMILIO	MAHNS WOOD	f	t	2018-03-15 09:50:06.179308-03	emahnsw@udd.cl	{"promocion": "2018"}
604	pbkdf2_sha256$100000$RjMLdBHWfP4M$P17WdI+iYELsCKGjrFnNBgUXgIaxYjWVk4hZY3/8uKk=	\N	f	19084253-3	JOSÉ EMILIO	MEDEL HORMAZÁBAL	f	t	2018-03-15 09:50:06.332837-03	jmedelh@udd.cl	{"promocion": "2018"}
605	pbkdf2_sha256$100000$UJCWR3ESxP5I$9HEHi6twccFJdBRQxspzRwa59d21YGVSU8Z2ZZ1sazs=	\N	f	19958903-2	MARÍA FERNANDA	MILLANAO VILUGRÓN	f	t	2018-03-15 09:50:06.49235-03	mmillanaov@udd.cl	{"promocion": "2018"}
606	pbkdf2_sha256$100000$xJqpIeJmoxOT$HhDeQdl7qY0KF8WDwWJKRtoa5KW2uDdju9X90A4dB7k=	\N	f	17987777-5	JORGE IGNACIO	SOTO PAREJAS	f	t	2018-03-15 09:50:06.643365-03	josotop@udd.cl	{"promocion": "2018"}
607	pbkdf2_sha256$100000$V9tkyzh4rayt$zJZ/KP/iOQ8SgkwUMJMLEf9DDv7G+k+7F1zPX6i7lnE=	\N	f	19989477-3	CATALINA VIOLETA	RABANAL SIERRA	f	t	2018-03-15 09:50:06.842473-03	crabanals@udd.cl	{"promocion": "2018"}
608	pbkdf2_sha256$100000$KP3bp3DYU82J$nfa97jRAzZXFz7L8XEinoRm5wE/YyqlNwOU7Tb/ctWw=	\N	f	20178109-4	CATALINA ESPERANZA	LOPEZ SABABA	f	t	2018-03-15 09:50:07.007921-03	catlopezs@udd.cl	{"promocion": "2018"}
609	pbkdf2_sha256$100000$d1BKNdQhyd3Q$4/VOf4CiAhiyKldbxvA2McIsd2bXYwnYQyU4oyeqFSE=	\N	f	19084146-4	FILIPPO TOMAS	BORGHI PAGNUCCO	f	t	2018-03-15 09:50:07.167564-03	fborghip@udd.cl	{"promocion": "2018"}
610	pbkdf2_sha256$100000$tefR6fqK1kJ2$cAi+gZ4iZdsipy91pW4osxU4H1ZcBM01OoP01VwqW7A=	\N	f	19098896-1	ALEXANDRA GABRIELA	STUVEN LEAL	f	t	2018-03-15 09:50:07.317265-03	astuvenl@udd.cl	{"promocion": "2018"}
611	pbkdf2_sha256$100000$Z2QASmddFOW6$AwsS7kWS1xBYA2DFFoGze3Qfndny314BXR5sBdVY6C0=	\N	f	20011515-5	FLORENCIA PAZ	MARTINEZ BATTAINI	f	t	2018-03-15 09:50:07.460471-03	flmartinezb@udd.cl	{"promocion": "2018"}
612	pbkdf2_sha256$100000$hwS9o7ZN00Fs$NNplNGVXYD1Z2oAc4tVRzv/Um/tCi0CfNWfL77awaOQ=	\N	f	19078966-7	ANTONIA	RIVERA DE LA MAZA	f	t	2018-03-15 09:50:07.619887-03	ariverad@udd.cl	{"promocion": "2018"}
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
170	1	448
2	1	1
171	1	449
172	1	450
173	1	451
174	1	452
175	1	453
176	1	454
177	1	455
178	1	456
179	1	457
180	1	458
181	1	459
182	1	460
183	1	461
184	1	462
185	1	463
186	1	464
187	1	465
188	1	466
189	1	467
190	1	468
191	1	469
192	1	470
193	1	471
194	1	472
195	1	473
196	1	474
197	1	475
198	1	476
199	1	477
200	1	478
201	1	479
202	1	480
203	1	481
204	1	482
205	1	483
206	1	484
207	1	485
208	1	486
209	1	487
210	1	488
211	1	489
212	1	490
213	1	491
214	1	492
215	1	493
216	1	494
217	1	495
218	1	496
219	1	497
220	1	498
221	1	499
222	1	500
223	1	501
224	1	502
225	1	503
226	1	504
227	1	505
228	1	506
229	1	507
230	1	508
231	1	509
232	1	510
233	1	511
234	1	512
235	1	513
236	1	514
237	1	515
238	1	516
239	1	517
240	1	518
241	1	519
242	1	520
243	1	521
244	1	522
245	1	523
246	1	524
247	1	525
248	1	526
249	1	527
250	1	528
251	1	529
252	1	530
253	1	531
254	1	532
255	1	533
256	1	534
257	1	535
258	1	536
259	1	537
260	1	538
261	1	539
262	1	540
263	1	541
264	1	542
265	1	543
266	1	544
267	1	545
268	1	546
269	1	547
270	1	548
271	1	549
272	1	550
273	1	551
274	1	552
275	1	553
276	1	554
277	1	555
278	1	556
279	1	557
280	1	558
281	1	559
282	1	560
283	1	561
284	1	562
285	1	563
286	1	564
287	1	565
288	1	566
289	1	567
290	1	568
291	1	569
292	1	570
293	1	571
294	1	572
295	1	573
296	1	574
297	1	575
298	1	576
299	1	577
300	1	578
301	1	579
302	1	580
303	1	581
304	1	582
305	1	583
306	1	584
307	1	585
308	1	586
309	1	587
310	1	588
311	1	589
312	1	590
313	1	591
314	1	592
315	1	593
316	1	594
317	1	595
318	1	596
319	1	597
320	1	598
321	1	599
322	1	600
323	1	601
324	1	602
325	1	603
326	1	604
327	1	605
328	1	606
329	1	607
330	1	608
331	1	609
332	1	610
333	1	611
334	1	612
\.


--
-- Data for Name: base_userprofilesprogram_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_userprofilesprogram_profiles (id, userprofilesprogram_id, profile_id) FROM stdin;
179	170	1
12	2	2
13	2	5
180	171	1
181	172	1
182	173	1
183	174	1
184	175	1
185	176	1
186	177	1
187	178	1
188	179	1
189	180	1
190	181	1
191	182	1
192	183	1
193	184	1
194	185	1
195	186	1
196	187	1
197	188	1
198	189	1
199	190	1
200	191	1
201	192	1
202	193	1
203	194	1
204	195	1
205	196	1
206	197	1
207	198	1
208	199	1
209	200	1
210	201	1
211	202	1
212	203	1
213	204	1
214	205	1
215	206	1
216	207	1
217	208	1
218	209	1
219	210	1
220	211	1
221	212	1
222	213	1
223	214	1
224	215	1
225	216	1
226	217	1
227	218	1
228	219	1
229	220	1
230	221	1
231	222	1
232	223	1
233	224	1
234	225	1
235	226	1
236	227	1
237	228	1
238	229	1
239	230	1
240	231	1
241	232	1
242	233	1
243	234	1
244	235	1
245	236	1
246	237	1
247	238	1
248	239	1
249	240	1
250	241	1
251	242	1
252	243	1
253	244	1
254	245	1
255	246	1
256	247	1
257	248	1
258	249	1
259	250	1
260	251	1
261	252	1
262	253	1
263	254	1
264	255	1
265	256	1
266	257	1
267	258	1
268	259	1
269	260	1
270	261	1
271	262	1
272	263	1
273	264	1
274	265	1
275	266	1
276	267	1
277	268	1
278	269	1
279	270	1
280	271	1
281	272	1
282	273	1
283	274	1
284	275	1
285	276	1
286	277	1
287	278	1
288	279	1
289	280	1
290	281	1
291	282	1
292	283	1
293	284	1
294	285	1
295	286	1
296	287	1
297	288	1
298	289	1
299	290	1
300	291	1
301	292	1
302	293	1
303	294	1
304	295	1
305	296	1
306	297	1
307	298	1
308	299	1
309	300	1
310	301	1
311	302	1
312	303	1
313	304	1
314	305	1
315	306	1
316	307	1
317	308	1
318	309	1
319	310	1
320	311	1
321	312	1
322	313	1
323	314	1
324	315	1
325	316	1
326	317	1
327	318	1
328	319	1
329	320	1
330	321	1
331	322	1
332	323	1
333	324	1
334	325	1
335	326	1
336	327	1
337	328	1
338	329	1
339	330	1
340	331	1
341	332	1
342	333	1
343	334	1
\.


--
-- Data for Name: business_campus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_campus (id, name, code, description, is_deleted, created_ts, updated_ts) FROM stdin;
1	Sede Santiago	SANTIAGO		f	2018-03-13 23:10:51.266459-03	2018-03-13 23:10:51.26649-03
\.


--
-- Data for Name: business_campus_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_campus_program (id, campus_id, program_id) FROM stdin;
3	1	1
\.


--
-- Data for Name: business_period; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_period (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, start_date, end_date, program_id) FROM stdin;
1	01-2018	01-2018		f	2018-03-13 23:10:26.511327-03	2018-03-13 23:10:26.511354-03		2018-03-13	2018-08-01	1
\.


--
-- Data for Name: business_survey; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_survey (id, name, code, description, is_deleted, created_ts, updated_ts, checksum) FROM stdin;
1	Prueba Para Color y Forma ARQ	P_01_COLOR_Y_FORMA_ARQ		f	2018-03-13 23:16:02.11853-03	2018-03-13 23:16:02.118631-03	
\.


--
-- Data for Name: business_survey_indicator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_survey_indicator (id, survey_id, indicator_id) FROM stdin;
16	1	1
\.


--
-- Data for Name: core_indicator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_indicator (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, skill_id, subject_id) FROM stdin;
1	Entendimiento del Color	ENT_COLOR	El color está en todos lados. Nuestra mente se ve atraída por distintos colores todo el tiempo, y los asocia a diferentes cosas. Un estudio titulado El Impacto de Los Colores en Marketing describe cómo los investigadores descubrieron que hasta un 90% de los juicios hechos sobre productos están basados solo en el color (dependiendo del producto). Pero aunque estemos tan familiarizados con los colores existe un gran nivel de incertidumbre cuando se trata de usar colores en el arte o diseño.	f	2018-03-13 23:15:58.514418-03	2018-03-14 21:08:00.000253-03		1	1
\.


--
-- Data for Name: core_level; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_level (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, program_id) FROM stdin;
1	Bachillerato	BACHILLERATO		f	2018-03-13 23:14:29.512374-03	2018-03-13 23:14:29.5124-03		1
\.


--
-- Data for Name: core_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_program (id, name, code, description, is_deleted, created_ts, updated_ts, node_id) FROM stdin;
1	ARQUITECTURA	1400S	La carrera de Arquitectura UDD, a través de un proyecto educativo vigente y orientado al desarrollo de las distintas capacidades del alumno, forma arquitectos integrales y creativos, con una rigurosa formación intelectual y profesional, preparados para ejercer en los diferentes campos de la disciplina.	f	2018-03-13 21:46:31.118842-03	2018-03-17 02:21:51.872313-03	1
\.


--
-- Data for Name: core_skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_skill (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, skill_group_id) FROM stdin;
1	COLORES SKILL	COLORES_SKILL		f	2018-03-13 23:15:54.307707-03	2018-03-13 23:15:54.307734-03		1
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
1	DISEÑO_Y_COLOR	DISENO_Y_COLOR		f	2018-03-13 23:15:53.077518-03	2018-03-13 23:15:53.077548-03		1
\.


--
-- Data for Name: core_subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_subject (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, level_id, subjects_group_id) FROM stdin;
1	COMPOSICIÓN Y COLOR	composicion_y_color		f	2018-03-13 23:14:32.259361-03	2018-03-17 02:36:36.22229-03		1	1
\.


--
-- Data for Name: core_subjectsgroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.core_subjectsgroup (id, name, code, description, is_deleted, created_ts, updated_ts, checksum, program_id) FROM stdin;
1	COLORES	COLORES		f	2018-03-13 23:14:17.067735-03	2018-03-17 02:36:33.333827-03		1
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2018-03-13 21:39:21.511373-03	1	score score	1	[{"added": {}}]	9	1
2	2018-03-13 21:40:09.866984-03	2	site_description site_description	1	[{"added": {}}]	9	1
3	2018-03-13 21:40:41.229945-03	3	txt_login txt_login	1	[{"added": {}}]	9	1
4	2018-03-13 21:41:45.907682-03	4	url_login_logo url_login_logo	1	[{"added": {}}]	9	1
5	2018-03-13 21:42:48.826939-03	5	url_logo_navbar_30_auto url_logo_navbar_30_auto	1	[{"added": {}}]	9	1
6	2018-03-13 21:46:23.441139-03	1	universidad (universidad)	1	[{"added": {}}]	30	1
7	2018-03-13 21:46:26.960515-03	1	UDD 	1	[{"added": {}}]	32	1
8	2018-03-13 21:46:31.128809-03	1	ARQUITECTURA 1400S - ARQUITECTURA	1	[{"added": {}}]	13	1
9	2018-03-13 21:48:23.736448-03	2	mariela@gmail.com	1	[{"added": {}}]	7	1
10	2018-03-13 21:49:00.234404-03	2	mariela@gmail.com	3		7	1
11	2018-03-13 21:51:44.061869-03	3	jleona@udd.cl	1	[{"added": {}}]	7	1
12	2018-03-13 21:52:12.332415-03	3	jleona@udd.cl	2	[{"changed": {"fields": ["first_name", "last_name"]}}]	7	1
13	2018-03-13 21:52:42.776357-03	1	student	1	[{"added": {}}]	6	1
14	2018-03-13 21:52:46.673382-03	1	UserProfilesProgram object (1)	1	[{"added": {}}]	8	1
15	2018-03-13 21:53:04.24477-03	2	teacher	1	[{"added": {}}]	6	1
16	2018-03-13 21:53:16.799357-03	5	admin	1	[{"added": {}}]	6	1
17	2018-03-13 21:53:19.577814-03	2	UserProfilesProgram object (2)	1	[{"added": {}}]	8	1
18	2018-03-13 23:00:16.285787-03	1	ARQUITECTURA 1400S_ARQUITECTURA	2	[{"changed": {"fields": ["code"]}}]	13	1
19	2018-03-13 23:02:35.657795-03	1	score score	2	[{"changed": {"fields": ["value"]}}]	9	1
20	2018-03-13 23:10:26.520024-03	1	01-2018 01-2018	1	[{"added": {}}]	11	1
21	2018-03-13 23:10:51.306617-03	1	Sede Santiago SANTIAGO	1	[{"added": {}}]	12	1
22	2018-03-13 23:14:17.077537-03	1	Identificacion del Color IDEN_DEL_COLOR	1	[{"added": {}}]	16	1
23	2018-03-13 23:14:29.522605-03	1	Bachillerato BACHILLERATO	1	[{"added": {}}]	17	1
24	2018-03-13 23:14:32.273188-03	1	Colores colores	1	[{"added": {}}]	18	1
25	2018-03-13 23:15:53.093388-03	1	DISEÑO_Y_COLOR DISENO_Y_COLOR	1	[{"added": {}}]	14	1
26	2018-03-13 23:15:54.318738-03	1	COLORES SKILL COLORES_SKILL	1	[{"added": {}}]	15	1
27	2018-03-13 23:15:58.52351-03	1	Entendimiento del Color ENT_COLOR	1	[{"added": {}}]	19	1
28	2018-03-13 23:16:02.168557-03	1	Prueba Para Color y Forma ARQ P_01_COLOR_Y_FORMA_ARQ	1	[{"added": {}}]	10	1
29	2018-03-13 23:16:08.795121-03	1	Color y Forma AAC111_COMPOSICION_Y_COLOR	1	[{"added": {}}]	22	1
30	2018-03-14 21:03:46.358342-03	1	Color y Forma AAC111_COMPOSICION_Y_COLOR	2	[{"changed": {"fields": ["description"]}}]	22	1
31	2018-03-14 21:08:00.011352-03	1	Entendimiento del Color ENT_COLOR	2	[{"changed": {"fields": ["description"]}}]	19	1
32	2018-03-15 09:33:02.76985-03	3	test@test.cl	2	[{"changed": {"fields": ["username", "first_name", "last_name", "email"]}}]	7	1
33	2018-03-15 09:39:36.454595-03	8	jleona@udd.cl	3		7	1
34	2018-03-15 09:39:36.472277-03	3	test@test.cl	3		7	1
35	2018-03-15 09:40:32.104292-03	9	jleona@udd.cl	3		7	1
36	2018-03-15 09:47:50.714171-03	169	UserProfilesProgram object (169)	3		8	1
37	2018-03-15 09:47:50.731913-03	168	UserProfilesProgram object (168)	3		8	1
38	2018-03-15 09:47:50.742591-03	167	UserProfilesProgram object (167)	3		8	1
39	2018-03-15 09:47:50.753678-03	166	UserProfilesProgram object (166)	3		8	1
40	2018-03-15 09:47:50.764852-03	165	UserProfilesProgram object (165)	3		8	1
41	2018-03-15 09:47:50.77604-03	164	UserProfilesProgram object (164)	3		8	1
42	2018-03-15 09:47:50.788985-03	163	UserProfilesProgram object (163)	3		8	1
43	2018-03-15 09:47:50.802615-03	162	UserProfilesProgram object (162)	3		8	1
44	2018-03-15 09:47:50.817188-03	161	UserProfilesProgram object (161)	3		8	1
45	2018-03-15 09:47:50.832913-03	160	UserProfilesProgram object (160)	3		8	1
46	2018-03-15 09:47:50.849543-03	159	UserProfilesProgram object (159)	3		8	1
47	2018-03-15 09:47:50.865393-03	158	UserProfilesProgram object (158)	3		8	1
48	2018-03-15 09:47:50.879755-03	157	UserProfilesProgram object (157)	3		8	1
49	2018-03-15 09:47:50.896872-03	156	UserProfilesProgram object (156)	3		8	1
50	2018-03-15 09:47:50.911717-03	155	UserProfilesProgram object (155)	3		8	1
51	2018-03-15 09:47:50.923392-03	154	UserProfilesProgram object (154)	3		8	1
52	2018-03-15 09:47:50.93766-03	153	UserProfilesProgram object (153)	3		8	1
53	2018-03-15 09:47:50.949078-03	152	UserProfilesProgram object (152)	3		8	1
54	2018-03-15 09:47:50.96038-03	151	UserProfilesProgram object (151)	3		8	1
55	2018-03-15 09:47:50.970552-03	150	UserProfilesProgram object (150)	3		8	1
56	2018-03-15 09:47:50.980947-03	149	UserProfilesProgram object (149)	3		8	1
57	2018-03-15 09:47:50.993369-03	148	UserProfilesProgram object (148)	3		8	1
58	2018-03-15 09:47:51.003678-03	147	UserProfilesProgram object (147)	3		8	1
59	2018-03-15 09:47:51.016015-03	146	UserProfilesProgram object (146)	3		8	1
60	2018-03-15 09:47:51.02892-03	145	UserProfilesProgram object (145)	3		8	1
61	2018-03-15 09:47:51.04007-03	144	UserProfilesProgram object (144)	3		8	1
62	2018-03-15 09:47:51.050512-03	143	UserProfilesProgram object (143)	3		8	1
63	2018-03-15 09:47:51.06284-03	142	UserProfilesProgram object (142)	3		8	1
64	2018-03-15 09:47:51.074654-03	141	UserProfilesProgram object (141)	3		8	1
65	2018-03-15 09:47:51.085155-03	140	UserProfilesProgram object (140)	3		8	1
66	2018-03-15 09:47:51.09627-03	139	UserProfilesProgram object (139)	3		8	1
67	2018-03-15 09:47:51.107396-03	138	UserProfilesProgram object (138)	3		8	1
68	2018-03-15 09:47:51.119997-03	137	UserProfilesProgram object (137)	3		8	1
69	2018-03-15 09:47:51.130925-03	136	UserProfilesProgram object (136)	3		8	1
70	2018-03-15 09:47:51.142125-03	135	UserProfilesProgram object (135)	3		8	1
71	2018-03-15 09:47:51.152328-03	134	UserProfilesProgram object (134)	3		8	1
72	2018-03-15 09:47:51.164968-03	133	UserProfilesProgram object (133)	3		8	1
73	2018-03-15 09:47:51.176101-03	132	UserProfilesProgram object (132)	3		8	1
74	2018-03-15 09:47:51.186494-03	131	UserProfilesProgram object (131)	3		8	1
75	2018-03-15 09:47:51.198044-03	130	UserProfilesProgram object (130)	3		8	1
76	2018-03-15 09:47:51.209307-03	129	UserProfilesProgram object (129)	3		8	1
77	2018-03-15 09:47:51.219707-03	128	UserProfilesProgram object (128)	3		8	1
78	2018-03-15 09:47:51.230418-03	127	UserProfilesProgram object (127)	3		8	1
79	2018-03-15 09:47:51.241106-03	126	UserProfilesProgram object (126)	3		8	1
80	2018-03-15 09:47:51.251734-03	125	UserProfilesProgram object (125)	3		8	1
81	2018-03-15 09:47:51.26262-03	124	UserProfilesProgram object (124)	3		8	1
82	2018-03-15 09:47:51.278667-03	123	UserProfilesProgram object (123)	3		8	1
83	2018-03-15 09:47:51.289047-03	122	UserProfilesProgram object (122)	3		8	1
84	2018-03-15 09:47:51.299095-03	121	UserProfilesProgram object (121)	3		8	1
85	2018-03-15 09:47:51.310251-03	120	UserProfilesProgram object (120)	3		8	1
86	2018-03-15 09:47:51.320445-03	119	UserProfilesProgram object (119)	3		8	1
87	2018-03-15 09:47:51.330739-03	118	UserProfilesProgram object (118)	3		8	1
88	2018-03-15 09:47:51.341681-03	117	UserProfilesProgram object (117)	3		8	1
89	2018-03-15 09:47:51.370714-03	116	UserProfilesProgram object (116)	3		8	1
90	2018-03-15 09:47:51.391674-03	115	UserProfilesProgram object (115)	3		8	1
91	2018-03-15 09:47:51.408501-03	114	UserProfilesProgram object (114)	3		8	1
92	2018-03-15 09:47:51.419254-03	113	UserProfilesProgram object (113)	3		8	1
93	2018-03-15 09:47:51.429491-03	112	UserProfilesProgram object (112)	3		8	1
94	2018-03-15 09:47:51.440508-03	111	UserProfilesProgram object (111)	3		8	1
95	2018-03-15 09:47:51.452581-03	110	UserProfilesProgram object (110)	3		8	1
96	2018-03-15 09:47:51.464741-03	109	UserProfilesProgram object (109)	3		8	1
97	2018-03-15 09:47:51.475628-03	108	UserProfilesProgram object (108)	3		8	1
98	2018-03-15 09:47:51.486453-03	107	UserProfilesProgram object (107)	3		8	1
99	2018-03-15 09:47:51.500368-03	106	UserProfilesProgram object (106)	3		8	1
100	2018-03-15 09:47:51.51111-03	105	UserProfilesProgram object (105)	3		8	1
101	2018-03-15 09:47:51.523267-03	104	UserProfilesProgram object (104)	3		8	1
102	2018-03-15 09:47:51.534818-03	103	UserProfilesProgram object (103)	3		8	1
103	2018-03-15 09:47:51.547269-03	102	UserProfilesProgram object (102)	3		8	1
104	2018-03-15 09:47:51.558888-03	101	UserProfilesProgram object (101)	3		8	1
105	2018-03-15 09:47:51.573316-03	100	UserProfilesProgram object (100)	3		8	1
106	2018-03-15 09:47:51.584281-03	99	UserProfilesProgram object (99)	3		8	1
107	2018-03-15 09:47:51.595373-03	98	UserProfilesProgram object (98)	3		8	1
108	2018-03-15 09:47:51.607029-03	97	UserProfilesProgram object (97)	3		8	1
109	2018-03-15 09:47:51.618375-03	96	UserProfilesProgram object (96)	3		8	1
110	2018-03-15 09:47:51.6298-03	95	UserProfilesProgram object (95)	3		8	1
111	2018-03-15 09:47:51.640525-03	94	UserProfilesProgram object (94)	3		8	1
112	2018-03-15 09:47:51.652554-03	93	UserProfilesProgram object (93)	3		8	1
113	2018-03-15 09:47:51.663119-03	92	UserProfilesProgram object (92)	3		8	1
114	2018-03-15 09:47:51.67535-03	91	UserProfilesProgram object (91)	3		8	1
115	2018-03-15 09:47:51.686165-03	90	UserProfilesProgram object (90)	3		8	1
116	2018-03-15 09:47:51.696567-03	89	UserProfilesProgram object (89)	3		8	1
117	2018-03-15 09:47:51.708063-03	88	UserProfilesProgram object (88)	3		8	1
118	2018-03-15 09:47:51.718431-03	87	UserProfilesProgram object (87)	3		8	1
119	2018-03-15 09:47:51.741129-03	86	UserProfilesProgram object (86)	3		8	1
120	2018-03-15 09:47:51.766113-03	85	UserProfilesProgram object (85)	3		8	1
121	2018-03-15 09:47:51.787044-03	84	UserProfilesProgram object (84)	3		8	1
122	2018-03-15 09:47:51.79742-03	83	UserProfilesProgram object (83)	3		8	1
123	2018-03-15 09:47:51.807294-03	82	UserProfilesProgram object (82)	3		8	1
124	2018-03-15 09:47:51.81724-03	81	UserProfilesProgram object (81)	3		8	1
125	2018-03-15 09:47:51.828862-03	80	UserProfilesProgram object (80)	3		8	1
126	2018-03-15 09:47:51.843742-03	79	UserProfilesProgram object (79)	3		8	1
127	2018-03-15 09:47:51.853577-03	78	UserProfilesProgram object (78)	3		8	1
128	2018-03-15 09:47:51.863689-03	77	UserProfilesProgram object (77)	3		8	1
129	2018-03-15 09:47:51.874129-03	76	UserProfilesProgram object (76)	3		8	1
130	2018-03-15 09:47:51.884481-03	75	UserProfilesProgram object (75)	3		8	1
131	2018-03-15 09:47:51.894408-03	74	UserProfilesProgram object (74)	3		8	1
132	2018-03-15 09:47:51.905677-03	73	UserProfilesProgram object (73)	3		8	1
133	2018-03-15 09:47:51.915385-03	72	UserProfilesProgram object (72)	3		8	1
134	2018-03-15 09:47:51.926039-03	71	UserProfilesProgram object (71)	3		8	1
135	2018-03-15 09:47:51.936168-03	70	UserProfilesProgram object (70)	3		8	1
136	2018-03-15 09:47:51.947178-03	69	UserProfilesProgram object (69)	3		8	1
137	2018-03-15 09:47:51.962215-03	68	UserProfilesProgram object (68)	3		8	1
138	2018-03-15 09:47:51.973074-03	67	UserProfilesProgram object (67)	3		8	1
139	2018-03-15 09:47:51.983043-03	66	UserProfilesProgram object (66)	3		8	1
140	2018-03-15 09:47:51.994311-03	65	UserProfilesProgram object (65)	3		8	1
141	2018-03-15 09:47:52.010077-03	64	UserProfilesProgram object (64)	3		8	1
142	2018-03-15 09:47:52.027958-03	63	UserProfilesProgram object (63)	3		8	1
143	2018-03-15 09:47:52.04017-03	62	UserProfilesProgram object (62)	3		8	1
144	2018-03-15 09:47:52.05161-03	61	UserProfilesProgram object (61)	3		8	1
145	2018-03-15 09:47:52.06231-03	60	UserProfilesProgram object (60)	3		8	1
146	2018-03-15 09:47:52.072994-03	59	UserProfilesProgram object (59)	3		8	1
147	2018-03-15 09:47:52.084435-03	58	UserProfilesProgram object (58)	3		8	1
148	2018-03-15 09:47:52.095272-03	57	UserProfilesProgram object (57)	3		8	1
149	2018-03-15 09:47:52.105901-03	56	UserProfilesProgram object (56)	3		8	1
150	2018-03-15 09:47:52.117201-03	55	UserProfilesProgram object (55)	3		8	1
151	2018-03-15 09:47:52.128185-03	54	UserProfilesProgram object (54)	3		8	1
152	2018-03-15 09:47:52.140666-03	53	UserProfilesProgram object (53)	3		8	1
153	2018-03-15 09:47:52.151663-03	52	UserProfilesProgram object (52)	3		8	1
154	2018-03-15 09:47:52.162534-03	51	UserProfilesProgram object (51)	3		8	1
155	2018-03-15 09:47:52.174094-03	50	UserProfilesProgram object (50)	3		8	1
156	2018-03-15 09:47:52.184623-03	49	UserProfilesProgram object (49)	3		8	1
157	2018-03-15 09:47:52.194431-03	48	UserProfilesProgram object (48)	3		8	1
158	2018-03-15 09:47:52.206163-03	47	UserProfilesProgram object (47)	3		8	1
159	2018-03-15 09:47:52.21626-03	46	UserProfilesProgram object (46)	3		8	1
160	2018-03-15 09:47:52.226782-03	45	UserProfilesProgram object (45)	3		8	1
161	2018-03-15 09:47:52.237409-03	44	UserProfilesProgram object (44)	3		8	1
162	2018-03-15 09:47:52.283936-03	43	UserProfilesProgram object (43)	3		8	1
163	2018-03-15 09:47:52.302378-03	42	UserProfilesProgram object (42)	3		8	1
164	2018-03-15 09:47:52.3133-03	41	UserProfilesProgram object (41)	3		8	1
165	2018-03-15 09:47:52.324832-03	40	UserProfilesProgram object (40)	3		8	1
166	2018-03-15 09:47:52.336425-03	39	UserProfilesProgram object (39)	3		8	1
167	2018-03-15 09:47:52.349022-03	38	UserProfilesProgram object (38)	3		8	1
168	2018-03-15 09:47:52.360185-03	37	UserProfilesProgram object (37)	3		8	1
169	2018-03-15 09:47:52.374178-03	36	UserProfilesProgram object (36)	3		8	1
170	2018-03-15 09:47:52.386285-03	35	UserProfilesProgram object (35)	3		8	1
171	2018-03-15 09:47:52.398153-03	34	UserProfilesProgram object (34)	3		8	1
172	2018-03-15 09:47:52.409488-03	33	UserProfilesProgram object (33)	3		8	1
173	2018-03-15 09:47:52.42062-03	32	UserProfilesProgram object (32)	3		8	1
174	2018-03-15 09:47:52.432429-03	31	UserProfilesProgram object (31)	3		8	1
175	2018-03-15 09:47:52.443645-03	30	UserProfilesProgram object (30)	3		8	1
176	2018-03-15 09:47:52.454108-03	29	UserProfilesProgram object (29)	3		8	1
177	2018-03-15 09:47:52.463581-03	28	UserProfilesProgram object (28)	3		8	1
178	2018-03-15 09:47:52.473044-03	27	UserProfilesProgram object (27)	3		8	1
179	2018-03-15 09:47:52.482922-03	26	UserProfilesProgram object (26)	3		8	1
180	2018-03-15 09:47:52.492835-03	25	UserProfilesProgram object (25)	3		8	1
181	2018-03-15 09:47:52.503256-03	24	UserProfilesProgram object (24)	3		8	1
182	2018-03-15 09:47:52.513536-03	23	UserProfilesProgram object (23)	3		8	1
183	2018-03-15 09:47:52.524191-03	22	UserProfilesProgram object (22)	3		8	1
184	2018-03-15 09:47:52.535818-03	21	UserProfilesProgram object (21)	3		8	1
185	2018-03-15 09:47:52.548258-03	20	UserProfilesProgram object (20)	3		8	1
186	2018-03-15 09:47:52.559118-03	19	UserProfilesProgram object (19)	3		8	1
187	2018-03-15 09:47:52.570034-03	18	UserProfilesProgram object (18)	3		8	1
188	2018-03-15 09:47:52.581388-03	17	UserProfilesProgram object (17)	3		8	1
189	2018-03-15 09:47:52.592506-03	16	UserProfilesProgram object (16)	3		8	1
190	2018-03-15 09:47:52.606068-03	15	UserProfilesProgram object (15)	3		8	1
191	2018-03-15 09:47:52.61699-03	14	UserProfilesProgram object (14)	3		8	1
192	2018-03-15 09:47:52.629103-03	13	UserProfilesProgram object (13)	3		8	1
193	2018-03-15 09:47:52.640429-03	12	UserProfilesProgram object (12)	3		8	1
194	2018-03-15 09:47:52.65172-03	11	UserProfilesProgram object (11)	3		8	1
195	2018-03-15 09:47:52.664776-03	10	UserProfilesProgram object (10)	3		8	1
196	2018-03-15 09:47:52.67701-03	9	UserProfilesProgram object (9)	3		8	1
197	2018-03-15 09:47:52.687934-03	8	UserProfilesProgram object (8)	3		8	1
198	2018-03-15 09:47:52.699131-03	7	UserProfilesProgram object (7)	3		8	1
199	2018-03-15 09:47:52.709637-03	6	UserProfilesProgram object (6)	3		8	1
200	2018-03-15 09:47:52.72021-03	5	UserProfilesProgram object (5)	3		8	1
201	2018-03-15 09:49:33.928276-03	168	josotop@udd.cl	3		7	1
202	2018-03-15 09:49:33.940886-03	157	pmarcosc@udd.cl	3		7	1
203	2018-03-15 09:49:33.951987-03	18	jverderaur@udd.cl	3		7	1
204	2018-03-15 09:49:33.963935-03	174	ariverad@udd.cl	3		7	1
205	2018-03-15 09:49:33.974819-03	171	fborghip@udd.cl	3		7	1
206	2018-03-15 09:49:33.986026-03	166	jmedelh@udd.cl	3		7	1
207	2018-03-15 09:49:33.996417-03	172	astuvenl@udd.cl	3		7	1
208	2018-03-15 09:49:34.007348-03	162	bmassuhr@udd.cl	3		7	1
209	2018-03-15 09:49:34.019632-03	53	vvialv@udd.cl	3		7	1
210	2018-03-15 09:49:34.029647-03	10	jleona@udd.cl	3		7	1
211	2018-03-15 09:49:34.04151-03	65	caperezf@udd.cl	3		7	1
212	2018-03-15 09:49:34.053258-03	52	marilagosc@udd.cl	3		7	1
213	2018-03-15 09:49:34.068449-03	15	mbanchierid@udd.cl	3		7	1
214	2018-03-15 09:49:34.084196-03	13	crriosecob@udd.cl	3		7	1
215	2018-03-15 09:49:34.094947-03	14	jjulior@udd.cl	3		7	1
216	2018-03-15 09:49:34.106473-03	12	jrossettik@udd.cl	3		7	1
217	2018-03-15 09:49:34.118149-03	158	ianriquezm@udd.cl	3		7	1
218	2018-03-15 09:49:34.129454-03	55	javflorest@udd.cl	3		7	1
219	2018-03-15 09:49:34.14051-03	134	maauadl@udd.cl	3		7	1
220	2018-03-15 09:49:34.151368-03	97	frguzmanp@udd.cl	3		7	1
221	2018-03-15 09:49:34.162042-03	115	cletters@udd.cl	3		7	1
222	2018-03-15 09:49:34.17329-03	138	vzapatav@udd.cl	3		7	1
223	2018-03-15 09:49:34.184302-03	103	femassuhr@udd.cl	3		7	1
224	2018-03-15 09:49:34.194892-03	11	dolatep@udd.cl	3		7	1
225	2018-03-15 09:49:34.205887-03	161	cbricenor@udd.cl	3		7	1
226	2018-03-15 09:49:34.217152-03	16	alcontrerass@udd.cl	3		7	1
227	2018-03-15 09:49:34.227916-03	154	adcalderons@udd.cl	3		7	1
228	2018-03-15 09:49:34.238914-03	60	sbuconicg@udd.cl	3		7	1
229	2018-03-15 09:49:34.249094-03	148	ngarridoa@udd.cl	3		7	1
230	2018-03-15 09:49:34.259946-03	101	nbarrigad@udd.cl	3		7	1
231	2018-03-15 09:49:34.271388-03	119	maxgarciav@udd.cl	3		7	1
232	2018-03-15 09:49:34.281437-03	126	mcavieresb@udd.cl	3		7	1
233	2018-03-15 09:49:34.29219-03	118	cclemente@udd.cl	3		7	1
234	2018-03-15 09:49:34.363278-03	17	fatapiau@udd.cl	3		7	1
235	2018-03-15 09:49:34.378583-03	149	mhermosillam@udd.cl	3		7	1
236	2018-03-15 09:49:34.389592-03	107	fviald@udd.cl	3		7	1
237	2018-03-15 09:49:34.40096-03	150	dlambertl@udd.cl	3		7	1
238	2018-03-15 09:49:34.412609-03	159	matgodoyc@udd.cl	3		7	1
239	2018-03-15 09:49:34.42304-03	110	rseisdedosr@udd.cl	3		7	1
240	2018-03-15 09:49:34.43316-03	35	marsotom@udd.cl	3		7	1
241	2018-03-15 09:49:34.442972-03	38	cswinburna@udd.cl	3		7	1
242	2018-03-15 09:49:34.453342-03	63	slirac@udd.cl	3		7	1
243	2018-03-15 09:49:34.463133-03	163	jpalacioss@udd.cl	3		7	1
244	2018-03-15 09:49:34.473516-03	116	tpugha@udd.cl	3		7	1
245	2018-03-15 09:49:34.48314-03	167	mmillanaov@udd.cl	3		7	1
246	2018-03-15 09:49:34.493441-03	156	varanedar@udd.cl	3		7	1
247	2018-03-15 09:49:34.50394-03	130	macunae@udd.cl	3		7	1
248	2018-03-15 09:49:34.514769-03	135	jsalasd@udd.cl	3		7	1
249	2018-03-15 09:49:34.524791-03	169	crabanals@udd.cl	3		7	1
250	2018-03-15 09:49:34.535181-03	19	lmaripanb@udd.cl	3		7	1
251	2018-03-15 09:49:34.545971-03	105	egebrief@udd.cl	3		7	1
252	2018-03-15 09:49:34.557466-03	173	flmartinezb@udd.cl	3		7	1
253	2018-03-15 09:49:34.567798-03	82	vrestrepog@udd.cl	3		7	1
254	2018-03-15 09:49:34.579233-03	48	gmartineze@udd.cl	3		7	1
255	2018-03-15 09:49:34.591061-03	155	aschmauckm@udd.cl	3		7	1
256	2018-03-15 09:49:34.603154-03	86	paugonzalezo@udd.cl	3		7	1
257	2018-03-15 09:49:34.613534-03	72	ecastillor@udd.cl	3		7	1
258	2018-03-15 09:49:34.623489-03	28	bschumacherm@udd.cl	3		7	1
259	2018-03-15 09:49:34.635341-03	109	vmirandaa@udd.cl	3		7	1
260	2018-03-15 09:49:34.645415-03	27	comontecinosf@udd.cl	3		7	1
261	2018-03-15 09:49:34.656422-03	91	bochoam@udd.cl	3		7	1
262	2018-03-15 09:49:34.666166-03	46	clehernandezl@udd.cl	3		7	1
263	2018-03-15 09:49:34.676393-03	137	jugaldez@udd.cl	3		7	1
264	2018-03-15 09:49:34.687123-03	73	marojasn@udd.cl	3		7	1
265	2018-03-15 09:49:34.698215-03	30	igsanchezu@udd.cl	3		7	1
266	2018-03-15 09:49:34.725822-03	33	jdarochs@udd.cl	3		7	1
267	2018-03-15 09:49:34.756121-03	41	cmatamalae@udd.cl	3		7	1
268	2018-03-15 09:49:34.782885-03	83	auboetschd@udd.cl	3		7	1
269	2018-03-15 09:49:34.802892-03	42	mpullenc@udd.cl	3		7	1
270	2018-03-15 09:49:34.813375-03	25	cdepetrisc@udd.cl	3		7	1
271	2018-03-15 09:49:34.823398-03	49	dselaivec@udd.cl	3		7	1
272	2018-03-15 09:49:34.834273-03	120	caprietoc@udd.cl	3		7	1
273	2018-03-15 09:49:34.844265-03	106	emoros@udd.cl	3		7	1
274	2018-03-15 09:49:34.856116-03	112	macevedoe@udd.cl	3		7	1
275	2018-03-15 09:49:34.866233-03	70	blasserrep@udd.cl	3		7	1
276	2018-03-15 09:49:34.876643-03	89	mlabranquea@udd.cl	3		7	1
277	2018-03-15 09:49:34.886898-03	98	skutschera@udd.cl	3		7	1
278	2018-03-15 09:49:34.897058-03	94	ndunforda@udd.cl	3		7	1
279	2018-03-15 09:49:34.907139-03	95	javiramirezs@udd.cl	3		7	1
280	2018-03-15 09:49:34.917355-03	21	maritapiag@udd.cl	3		7	1
281	2018-03-15 09:49:34.92851-03	32	vapavezb@udd.cl	3		7	1
282	2018-03-15 09:49:34.939303-03	84	sveraw@udd.cl	3		7	1
283	2018-03-15 09:49:34.9512-03	165	emahnsw@udd.cl	3		7	1
284	2018-03-15 09:49:34.962315-03	80	fmadridr@udd.cl	3		7	1
285	2018-03-15 09:49:34.974186-03	22	mariaivalenzuelag@udd.cl	3		7	1
286	2018-03-15 09:49:34.98522-03	153	jabelloo@udd.cl	3		7	1
287	2018-03-15 09:49:34.995852-03	146	fpratsd@udd.cl	3		7	1
288	2018-03-15 09:49:35.007184-03	121	lediaze@udd.cl	3		7	1
289	2018-03-15 09:49:35.01821-03	111	pedwardsc@udd.cl	3		7	1
290	2018-03-15 09:49:35.028646-03	117	cbalmacedaa@udd.cl	3		7	1
291	2018-03-15 09:49:35.038851-03	36	anttorresc@udd.cl	3		7	1
292	2018-03-15 09:49:35.049345-03	151	pamunateguiv@udd.cl	3		7	1
293	2018-03-15 09:49:35.059192-03	54	mafloresv@udd.cl	3		7	1
294	2018-03-15 09:49:35.069543-03	136	aurrutiah@udd.cl	3		7	1
295	2018-03-15 09:49:35.079073-03	88	awagnerd@udd.cl	3		7	1
296	2018-03-15 09:49:35.089049-03	133	pugartes@udd.cl	3		7	1
297	2018-03-15 09:49:35.098725-03	56	adeblasist@udd.cl	3		7	1
298	2018-03-15 09:49:35.108161-03	26	murzuat@udd.cl	3		7	1
299	2018-03-15 09:49:35.118597-03	37	mdelcampol@udd.cl	3		7	1
300	2018-03-15 09:49:35.128523-03	61	mborgonog@udd.cl	3		7	1
301	2018-03-15 09:49:35.159858-03	31	alyonm@udd.cl	3		7	1
302	2018-03-15 09:49:35.176031-03	139	saspillagav@udd.cl	3		7	1
303	2018-03-15 09:49:35.186661-03	152	cholmesl@udd.cl	3		7	1
304	2018-03-15 09:49:35.196888-03	59	bhurtadoc@udd.cl	3		7	1
305	2018-03-15 09:49:35.207545-03	71	bjovelp@udd.cl	3		7	1
306	2018-03-15 09:49:35.218435-03	24	adosala@udd.cl	3		7	1
307	2018-03-15 09:49:35.229083-03	102	ibahrsc@udd.cl	3		7	1
308	2018-03-15 09:49:35.239314-03	170	catlopezs@udd.cl	3		7	1
309	2018-03-15 09:49:35.249912-03	81	dmeyers@udd.cl	3		7	1
310	2018-03-15 09:49:35.260599-03	164	ipalmam@udd.cl	3		7	1
311	2018-03-15 09:49:35.271772-03	144	kvoigtk@udd.cl	3		7	1
312	2018-03-15 09:49:35.281821-03	77	jomoralesr@udd.cl	3		7	1
313	2018-03-15 09:49:35.292027-03	141	jocanac@udd.cl	3		7	1
314	2018-03-15 09:49:35.301982-03	132	mperondic@udd.cl	3		7	1
315	2018-03-15 09:49:35.312181-03	85	safernandeze@udd.cl	3		7	1
316	2018-03-15 09:49:35.322255-03	57	bdahera@udd.cl	3		7	1
317	2018-03-15 09:49:35.337659-03	44	ccapurrom@udd.cl	3		7	1
318	2018-03-15 09:49:35.356931-03	78	vhodgeh@udd.cl	3		7	1
319	2018-03-15 09:49:35.370207-03	114	camguzmana@udd.cl	3		7	1
320	2018-03-15 09:49:35.38013-03	122	magramirezr@udd.cl	3		7	1
321	2018-03-15 09:49:35.391411-03	20	marizquierdog@udd.cl	3		7	1
322	2018-03-15 09:49:35.401096-03	51	vpenac@udd.cl	3		7	1
323	2018-03-15 09:49:35.410988-03	87	sbursicp@udd.cl	3		7	1
324	2018-03-15 09:49:35.421043-03	67	pbastiasm@udd.cl	3		7	1
325	2018-03-15 09:49:35.43087-03	45	jacivalenzuelav@udd.cl	3		7	1
326	2018-03-15 09:49:35.440885-03	128	scarmonas@udd.cl	3		7	1
327	2018-03-15 09:49:35.451179-03	29	agriverosk@udd.cl	3		7	1
328	2018-03-15 09:49:35.461385-03	113	mariatrgarciam@udd.cl	3		7	1
329	2018-03-15 09:49:35.471123-03	34	jmarambiog@udd.cl	3		7	1
330	2018-03-15 09:49:35.481266-03	40	vluhrsc@udd.cl	3		7	1
331	2018-03-15 09:49:35.491098-03	23	mcruze@udd.cl	3		7	1
332	2018-03-15 09:49:35.501043-03	43	acanessaf@udd.cl	3		7	1
333	2018-03-15 09:49:35.511053-03	125	clsaavedran@udd.cl	3		7	1
334	2018-03-15 09:49:35.523092-03	75	kmeiers@udd.cl	3		7	1
335	2018-03-15 09:49:35.532757-03	50	idelorenzog@udd.cl	3		7	1
336	2018-03-15 09:49:35.542722-03	129	itramonh@udd.cl	3		7	1
337	2018-03-15 09:49:35.55363-03	64	amartinm@udd.cl	3		7	1
338	2018-03-15 09:49:35.563552-03	79	smirandas@udd.cl	3		7	1
339	2018-03-15 09:49:35.573562-03	74	sriveross@udd.cl	3		7	1
340	2018-03-15 09:49:35.583188-03	124	inavarroa@udd.cl	3		7	1
341	2018-03-15 09:49:35.59302-03	58	caquezadac@udd.cl	3		7	1
342	2018-03-15 09:49:35.606248-03	68	eplanellad@udd.cl	3		7	1
343	2018-03-15 09:49:35.624618-03	47	tbravoa@udd.cl	3		7	1
344	2018-03-15 09:49:35.636463-03	99	clozanog@udd.cl	3		7	1
345	2018-03-15 09:49:35.64693-03	147	rcontessef@udd.cl	3		7	1
346	2018-03-15 09:49:35.657-03	142	mattapiac@udd.cl	3		7	1
347	2018-03-15 09:49:35.666965-03	100	mahernandezk@udd.cl	3		7	1
348	2018-03-15 09:49:35.677461-03	123	jolhaberryc@udd.cl	3		7	1
349	2018-03-15 09:49:35.687398-03	66	ddetoroc@udd.cl	3		7	1
350	2018-03-15 09:49:35.697267-03	143	luormenos@udd.cl	3		7	1
351	2018-03-15 09:49:35.70938-03	104	amromerog@udd.cl	3		7	1
352	2018-03-15 09:49:35.719295-03	127	smanriquee@udd.cl	3		7	1
353	2018-03-15 09:49:35.729097-03	39	vvivaru@udd.cl	3		7	1
354	2018-03-15 09:49:35.739092-03	69	lcambiasoc@udd.cl	3		7	1
355	2018-03-15 09:49:35.749402-03	76	etaladrizg@udd.cl	3		7	1
356	2018-03-15 09:49:35.759362-03	108	dbaltram@udd.cl	3		7	1
357	2018-03-15 09:49:35.769982-03	140	turbinab@udd.cl	3		7	1
358	2018-03-15 09:49:35.780235-03	93	jortizf@udd.cl	3		7	1
359	2018-03-15 09:49:35.79017-03	90	mquirozb@udd.cl	3		7	1
360	2018-03-15 09:49:35.800069-03	131	joslopezm@udd.cl	3		7	1
361	2018-03-15 09:49:35.821254-03	145	ndonskoys@udd.cl	3		7	1
362	2018-03-15 09:49:35.840426-03	96	vicmunoza@udd.cl	3		7	1
363	2018-03-15 09:49:35.859856-03	62	echaparrof@udd.cl	3		7	1
364	2018-03-15 09:49:35.874365-03	92	dsolanog@udd.cl	3		7	1
365	2018-03-15 09:49:35.884669-03	160	vanunezb@udd.cl	3		7	1
366	2018-03-17 02:21:51.881825-03	1	ARQUITECTURA 1400S	2	[{"changed": {"fields": ["code"]}}]	13	1
367	2018-03-17 02:36:33.342483-03	1	COLORES COLORES	2	[{"changed": {"fields": ["name", "code"]}}]	16	1
368	2018-03-17 02:36:36.231874-03	1	COMPOSICIÓN Y COLOR composicion_y_color	2	[{"changed": {"fields": ["name", "code"]}}]	18	1
369	2018-03-17 02:41:03.127031-03	1	COMPOSICIÓN Y COLOR 1400S_AAC111_1_2018_1_16-14	2	[{"changed": {"fields": ["name", "code"]}}]	22	1
370	2018-03-17 02:41:28.895519-03	1	COMPOSICIÓN Y COLOR 1400S_AAC111_1_2018_1_16-14	2	[{"changed": {"fields": ["section"]}}]	22	1
371	2018-03-17 03:05:00.43378-03	6	txt_footer txt_footer	1	[{"added": {}}]	9	1
372	2018-03-17 03:09:31.154518-03	2	COMPOSICIÓN Y COLOR 1400S_AAC111_2_2018_1_16-14	1	[{"added": {}}]	22	1
373	2018-03-17 03:15:47.407145-03	3	COMPOSICIÓN Y COLOR 1400S_AAC111_3_2018_1_16-15	1	[{"added": {}}]	22	1
374	2018-03-17 03:19:50.704799-03	3	COMPOSICIÓN Y COLOR 1400S_AAC111_3_2018_1_16-15	2	[{"changed": {"fields": ["teachers"]}}]	22	1
375	2018-03-17 03:19:58.828194-03	2	COMPOSICIÓN Y COLOR 1400S_AAC111_2_2018_1_16-14	2	[{"changed": {"fields": ["teachers"]}}]	22	1
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
6	base	profile
7	base	user
8	base	userprofilesprogram
9	base	parameter
10	business	survey
11	business	period
12	business	campus
13	core	program
14	core	skillsgroup
15	core	skill
16	core	subjectsgroup
17	core	level
18	core	subject
19	core	indicator
20	log	action
21	log	log
22	term	course
23	term	feedback
24	term	tempfeedbackmessage
25	term	tempfedbackscore
26	term	finalscoreevaluation
27	term	tempscoreevaluation
28	term	finalindicatorevaluation
29	term	tempfinalindicatorevaluation
30	topology	nodetype
31	topology	nodetypeparent
32	topology	node
33	core	skillleveldescription
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-02-15 21:45:30.094427-03
2	topology	0001_initial	2018-02-15 21:45:30.214091-03
3	core	0001_initial	2018-02-15 21:45:30.524506-03
4	contenttypes	0002_remove_content_type_name	2018-02-15 21:45:30.566889-03
5	auth	0001_initial	2018-02-15 21:45:30.637892-03
6	auth	0002_alter_permission_name_max_length	2018-02-15 21:45:30.651836-03
7	auth	0003_alter_user_email_max_length	2018-02-15 21:45:30.674713-03
8	auth	0004_alter_user_username_opts	2018-02-15 21:45:30.690851-03
9	auth	0005_alter_user_last_login_null	2018-02-15 21:45:30.707608-03
10	auth	0006_require_contenttypes_0002	2018-02-15 21:45:30.712152-03
11	auth	0007_alter_validators_add_error_messages	2018-02-15 21:45:30.729996-03
12	auth	0008_alter_user_username_max_length	2018-02-15 21:45:30.747958-03
13	auth	0009_alter_user_last_name_max_length	2018-02-15 21:45:30.76975-03
14	base	0001_initial	2018-02-15 21:45:30.923622-03
15	admin	0001_initial	2018-02-15 21:45:30.988218-03
16	admin	0002_logentry_remove_auto_add	2018-02-15 21:45:31.017389-03
17	business	0001_initial	2018-02-15 21:45:31.247247-03
18	log	0001_initial	2018-02-15 21:45:31.33624-03
19	sessions	0001_initial	2018-02-15 21:45:31.355829-03
21	base	0002_auto_20180301_0627	2018-03-01 06:28:40.81029-03
22	base	0003_auto_20180301_0652	2018-03-01 06:52:26.488716-03
23	base	0004_auto_20180301_1932	2018-03-01 19:32:57.507043-03
24	base	0005_parameter	2018-03-01 22:42:41.821396-03
26	base	0006_auto_20180303_1647	2018-03-03 16:47:25.294885-03
27	base	0007_auto_20180303_1650	2018-03-03 16:50:46.681782-03
28	base	0008_auto_20180303_1651	2018-03-03 16:51:32.963427-03
29	term	0001_initial	2018-03-03 18:52:02.449953-03
30	term	0002_finalindicatorevaluation_indicator	2018-03-03 20:00:15.408221-03
31	term	0003_auto_20180303_2001	2018-03-03 20:02:41.817324-03
32	term	0004_auto_20180306_0111	2018-03-06 01:11:17.427055-03
33	term	0005_auto_20180306_0112	2018-03-06 01:12:53.03818-03
43	term	0006_auto_20180307_1612	2018-03-07 16:14:43.389502-03
44	core	0002_auto_20180317_0136	2018-03-17 01:36:09.852147-03
45	business	0002_auto_20180317_0240	2018-03-17 02:40:52.303065-03
46	core	0003_auto_20180317_0240	2018-03-17 02:40:52.348478-03
47	term	0007_auto_20180317_0240	2018-03-17 02:40:52.660502-03
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
ts4x7w0amu76dxt7rnxy7bc4np5eepqh	MTFhYjhhN2VlZTQwMmE0NGU1NTFiZjQyNzZhYzBmZTc2NmI4ZWUyYzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0M2VhZDZmOTQzMGVlYjQ3MTdlOWU1ZTBlMTA3NGY5NTE0YmU2ODBhIn0=	2018-03-27 23:18:23.89833-03
2r7c0ldlokm06ts19f98md5qzwa54ich	YzA1OGE4NmZhOWU0OWEzMjlmMGQ1NWVmNGEwMzBjOGJhYTJjZDYxNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlYWViZWQ2ZjE1NzdiNTg4MDgwYjhjZGEyMjcwMzBiODFkNDM0Yzc0In0=	2018-03-31 02:22:27.508141-03
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

COPY public.term_course (id, name, code, description, is_deleted, created_ts, updated_ts, section, checksum, campus_id, period_id, survey_id, subject_id) FROM stdin;
1	COMPOSICIÓN Y COLOR	1400S_AAC111_1_2018_1_16-14	La relación inevitable entre color y forma nos lleva a observar los efectos que tiene la forma sobre el color. La forma misma aun cuando es completamente abstracta y se parece a una forma geométrica, posee su sonido interno, es un ente espiritual con propiedades idénticas a esa forma. Un triángulo (sin especificar si es agudo, llano o isósceles) es uno de esos entes con su propio perfume espiritual. En relación con otras formas, este perfume se diferencia, adquiere matices consonantes, pero, en el fondo, permanece invariable, como el olor de la rosa que nunca podrá confundirse con el de la violeta.	f	2018-03-13 23:16:08.713807-03	2018-03-17 02:41:28.861125-03	1		1	1	1	1
3	COMPOSICIÓN Y COLOR	1400S_AAC111_3_2018_1_16-15		f	2018-03-17 03:15:47.370392-03	2018-03-17 03:19:50.642646-03	3		1	1	1	1
2	COMPOSICIÓN Y COLOR	1400S_AAC111_2_2018_1_16-14		f	2018-03-17 03:09:31.1173-03	2018-03-17 03:19:58.773762-03	2		1	1	1	1
\.


--
-- Data for Name: term_course_students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_course_students (id, course_id, user_id) FROM stdin;
12	1	521
13	1	485
14	1	585
15	1	461
16	1	557
17	1	597
18	1	497
19	1	509
20	1	536
21	1	448
22	1	569
23	1	472
24	1	605
25	1	465
26	1	581
27	1	593
28	2	510
29	2	556
30	2	463
31	2	559
32	2	532
33	2	484
34	2	595
35	2	486
36	2	449
37	2	570
38	2	558
39	2	560
40	2	512
41	2	511
42	2	476
43	2	571
44	2	464
45	2	483
46	2	477
47	2	582
48	3	488
49	3	583
50	3	462
51	3	549
52	3	523
53	3	524
54	3	452
55	3	501
56	3	537
57	3	513
58	3	561
59	3	489
60	3	584
61	3	607
62	3	520
63	3	573
64	3	548
65	3	473
66	3	474
67	3	545
\.


--
-- Data for Name: term_course_teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term_course_teachers (id, course_id, user_id) FROM stdin;
11	1	1
12	3	1
13	2	1
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
2	f	2018-03-17 03:05:35.388096-03	2018-03-17 03:05:35.388122-03	2	1	448	1	1
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
1	f	2018-03-13 21:46:26.951962-03	2018-03-13 21:46:26.95199-03	Universidad del Desarrollo	UDD		1	\N
\.


--
-- Data for Name: topology_nodetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topology_nodetype (id, is_deleted, created_ts, updated_ts, name, code, description, is_top, can_have_programs) FROM stdin;
1	f	2018-03-13 21:46:23.430434-03	2018-03-13 21:46:23.430459-03	universidad	universidad		f	t
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

SELECT pg_catalog.setval('public.base_parameter_id_seq', 6, true);


--
-- Name: base_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_user_groups_id_seq', 1, false);


--
-- Name: base_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_user_id_seq', 612, true);


--
-- Name: base_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_user_user_permissions_id_seq', 1, false);


--
-- Name: base_userprofilesprogram_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_userprofilesprogram_id_seq', 334, true);


--
-- Name: base_userprofilesprogram_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_userprofilesprogram_profiles_id_seq', 343, true);


--
-- Name: business_campus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.business_campus_id_seq', 1, true);


--
-- Name: business_campus_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.business_campus_program_id_seq', 3, true);


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

SELECT pg_catalog.setval('public.business_survey_indicator_id_seq', 16, true);


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

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 375, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 33, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 47, true);


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

SELECT pg_catalog.setval('public.term_course_students_id_seq', 67, true);


--
-- Name: term_course_teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_course_teachers_id_seq', 13, true);


--
-- Name: term_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_feedback_id_seq', 1, true);


--
-- Name: term_finalindicatorevaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.term_finalindicatorevaluation_id_seq', 2, true);


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

SELECT pg_catalog.setval('public.topology_nodetype_id_seq', 1, true);


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

