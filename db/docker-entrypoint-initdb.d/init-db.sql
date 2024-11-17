\c postgres
CREATE EXTENSION IF NOT EXISTS btree_gist;

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

CREATE SCHEMA mainnet;
ALTER SCHEMA mainnet OWNER TO postgres;


CREATE SCHEMA taurus;
ALTER SCHEMA taurus OWNER TO postgres;

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;
COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';

CREATE FUNCTION mainnet.schema_notification() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    PERFORM pg_notify(
            '0x5f0790b6e25e9683',
            'schema_updated');
    RETURN NULL;
  END;
  $$;
ALTER FUNCTION mainnet.schema_notification() OWNER TO postgres;

CREATE FUNCTION taurus.schema_notification() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    PERFORM pg_notify(
            '0xd51c36728e94bdbc',
            'schema_updated');
    RETURN NULL;
  END;
  $$;
ALTER FUNCTION taurus.schema_notification() OWNER TO postgres;

SET default_tablespace = '';
SET default_table_access_method = heap;

CREATE TABLE mainnet._metadata (
    key character varying(255) NOT NULL,
    value jsonb,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
ALTER TABLE mainnet._metadata OWNER TO postgres;

CREATE TABLE mainnet.account_histories (
    id text NOT NULL,
    nonce numeric NOT NULL,
    free numeric NOT NULL,
    reserved numeric NOT NULL,
    total numeric,
    created_at numeric NOT NULL,
    updated_at numeric NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE mainnet.account_histories OWNER TO postgres;

CREATE TABLE mainnet.blocks (
    id text NOT NULL,
    sort_id text NOT NULL,
    height numeric NOT NULL,
    hash text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    parent_hash text NOT NULL,
    spec_id text NOT NULL,
    state_root text NOT NULL,
    extrinsics_root text NOT NULL,
    space_pledged numeric NOT NULL,
    blockchain_size numeric NOT NULL,
    extrinsics_count integer NOT NULL,
    events_count integer NOT NULL,
    author_id text NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE mainnet.blocks OWNER TO postgres;

CREATE TABLE mainnet.events (
    id text NOT NULL,
    sort_id text NOT NULL,
    block_height numeric NOT NULL,
    block_hash text NOT NULL,
    extrinsic_id text NOT NULL,
    extrinsic_hash text NOT NULL,
    section text NOT NULL,
    module text NOT NULL,
    name text NOT NULL,
    index_in_block numeric NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    phase text NOT NULL,
    pos integer NOT NULL,
    args text NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE mainnet.events OWNER TO postgres;

CREATE TABLE mainnet.extrinsics (
    id text NOT NULL,
    sort_id text NOT NULL,
    hash text NOT NULL,
    block_height numeric NOT NULL,
    block_hash text NOT NULL,
    section text NOT NULL,
    module text NOT NULL,
    name text NOT NULL,
    index_in_block integer NOT NULL,
    success boolean NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    nonce numeric NOT NULL,
    signer text NOT NULL,
    signature text NOT NULL,
    args text NOT NULL,
    error text NOT NULL,
    tip numeric NOT NULL,
    fee numeric NOT NULL,
    pos integer NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE mainnet.extrinsics OWNER TO postgres;

CREATE TABLE mainnet.logs (
    id text NOT NULL,
    sort_id text NOT NULL,
    block_height numeric NOT NULL,
    block_hash text NOT NULL,
    index_in_block integer NOT NULL,
    kind text NOT NULL,
    value text,
    "timestamp" timestamp without time zone NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE mainnet.logs OWNER TO postgres;

CREATE TABLE mainnet.rewards (
    id text NOT NULL,
    block_height numeric NOT NULL,
    block_hash text NOT NULL,
    account_id text NOT NULL,
    index_in_block numeric NOT NULL,
    reward_type text NOT NULL,
    amount numeric NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE mainnet.rewards OWNER TO postgres;

CREATE TABLE mainnet.transfers (
    id text NOT NULL,
    extrinsic_id text NOT NULL,
    event_id text NOT NULL,
    "from" text NOT NULL,
    "to" text NOT NULL,
    value numeric NOT NULL,
    fee numeric NOT NULL,
    success boolean NOT NULL,
    "timestamp" numeric NOT NULL,
    date timestamp without time zone NOT NULL,
    created_at numeric NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE mainnet.transfers OWNER TO postgres;

CREATE TABLE taurus._metadata (
    key character varying(255) NOT NULL,
    value jsonb,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
ALTER TABLE taurus._metadata OWNER TO postgres;

CREATE TABLE taurus.account_histories (
    id text NOT NULL,
    nonce numeric NOT NULL,
    free numeric NOT NULL,
    reserved numeric NOT NULL,
    total numeric,
    created_at numeric NOT NULL,
    updated_at numeric NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE taurus.account_histories OWNER TO postgres;

CREATE TABLE taurus.blocks (
    id text NOT NULL,
    sort_id text NOT NULL,
    height numeric NOT NULL,
    hash text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    parent_hash text NOT NULL,
    spec_id text NOT NULL,
    state_root text NOT NULL,
    extrinsics_root text NOT NULL,
    space_pledged numeric NOT NULL,
    blockchain_size numeric NOT NULL,
    extrinsics_count integer NOT NULL,
    events_count integer NOT NULL,
    author_id text NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE taurus.blocks OWNER TO postgres;

CREATE TABLE taurus.events (
    id text NOT NULL,
    sort_id text NOT NULL,
    block_height numeric NOT NULL,
    block_hash text NOT NULL,
    extrinsic_id text NOT NULL,
    extrinsic_hash text NOT NULL,
    section text NOT NULL,
    module text NOT NULL,
    name text NOT NULL,
    index_in_block numeric NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    phase text NOT NULL,
    pos integer NOT NULL,
    args text NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE taurus.events OWNER TO postgres;

CREATE TABLE taurus.extrinsics (
    id text NOT NULL,
    sort_id text NOT NULL,
    hash text NOT NULL,
    block_height numeric NOT NULL,
    block_hash text NOT NULL,
    section text NOT NULL,
    module text NOT NULL,
    name text NOT NULL,
    index_in_block integer NOT NULL,
    success boolean NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    nonce numeric NOT NULL,
    signer text NOT NULL,
    signature text NOT NULL,
    args text NOT NULL,
    error text NOT NULL,
    tip numeric NOT NULL,
    fee numeric NOT NULL,
    pos integer NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE taurus.extrinsics OWNER TO postgres;

CREATE TABLE taurus.logs (
    id text NOT NULL,
    sort_id text NOT NULL,
    block_height numeric NOT NULL,
    block_hash text NOT NULL,
    index_in_block integer NOT NULL,
    kind text NOT NULL,
    value text,
    "timestamp" timestamp without time zone NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE taurus.logs OWNER TO postgres;

CREATE TABLE taurus.rewards (
    id text NOT NULL,
    block_height numeric NOT NULL,
    block_hash text NOT NULL,
    account_id text NOT NULL,
    index_in_block numeric NOT NULL,
    reward_type text NOT NULL,
    amount numeric NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE taurus.rewards OWNER TO postgres;

CREATE TABLE taurus.transfers (
    id text NOT NULL,
    extrinsic_id text NOT NULL,
    event_id text NOT NULL,
    "from" text NOT NULL,
    "to" text NOT NULL,
    value numeric NOT NULL,
    fee numeric NOT NULL,
    success boolean NOT NULL,
    "timestamp" numeric NOT NULL,
    date timestamp without time zone NOT NULL,
    created_at numeric NOT NULL,
    _id uuid NOT NULL,
    _block_range int8range NOT NULL
);
ALTER TABLE taurus.transfers OWNER TO postgres;

ALTER TABLE ONLY mainnet._metadata
    ADD CONSTRAINT _metadata_pkey PRIMARY KEY (key);

ALTER TABLE ONLY mainnet.account_histories
    ADD CONSTRAINT account_histories_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY mainnet.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY mainnet.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY mainnet.extrinsics
    ADD CONSTRAINT extrinsics_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY mainnet.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY mainnet.rewards
    ADD CONSTRAINT rewards_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY mainnet.transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY taurus._metadata
    ADD CONSTRAINT _metadata_pkey PRIMARY KEY (key);

ALTER TABLE ONLY taurus.account_histories
    ADD CONSTRAINT account_histories_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY taurus.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY taurus.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY taurus.extrinsics
    ADD CONSTRAINT extrinsics_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY taurus.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY taurus.rewards
    ADD CONSTRAINT rewards_pkey PRIMARY KEY (_id);

ALTER TABLE ONLY taurus.transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (_id);


CREATE INDEX "0x08aa840e441d13bb" ON mainnet.blocks USING gist (height, _block_range);

CREATE INDEX "0x09a98aa53fa2c2e3" ON mainnet.logs USING btree (id);

CREATE INDEX "0x1532f5e4701949a5" ON mainnet.extrinsics USING gist (hash, _block_range);

CREATE INDEX "0x1e967733a0d5db15" ON mainnet.rewards USING btree (id);

CREATE INDEX "0x2481c1ffa5112599" ON mainnet.logs USING gist (block_hash, _block_range);

CREATE INDEX "0x2a038c9edc202d38" ON mainnet.transfers USING gist (event_id, _block_range);

CREATE INDEX "0x2c6d435d5ab69412" ON mainnet.extrinsics USING gist (sort_id, _block_range);

CREATE INDEX "0x2cbe628ebc830c12" ON mainnet.logs USING gist (sort_id, _block_range);

CREATE INDEX "0x30b779cc3aeeeec6" ON mainnet.events USING gist (extrinsic_id, _block_range);

CREATE INDEX "0x3ae5d1670e99e612" ON mainnet.transfers USING gist ("timestamp", _block_range);

CREATE INDEX "0x3fa25df2b17c6d2f" ON mainnet.extrinsics USING gist (signature, _block_range);

CREATE INDEX "0x4131da2c2ec8b5b7" ON mainnet.transfers USING gist (date, _block_range);

CREATE INDEX "0x444de3b3611c1fcd" ON mainnet.account_histories USING gist (created_at, _block_range);

CREATE INDEX "0x4a66afa700f00759" ON mainnet.events USING gist (block_hash, _block_range);

CREATE INDEX "0x57fc196dcc99a091" ON mainnet.events USING gist (block_height, _block_range);

CREATE INDEX "0x5921649101eeb57a" ON mainnet.transfers USING gist (created_at, _block_range);

CREATE INDEX "0x59386a58438fa05a" ON mainnet.extrinsics USING gist (section, _block_range);

CREATE INDEX "0x59f75d2bc1e6a0bc" ON mainnet.blocks USING gist ("timestamp", _block_range);

CREATE INDEX "0x6008270492da5713" ON mainnet.events USING gist ("timestamp", _block_range);

CREATE INDEX "0x6131d72d57f2a188" ON mainnet.blocks USING gist (hash, _block_range);

CREATE INDEX "0x61510445e44f4f2f" ON mainnet.logs USING gist (index_in_block, _block_range);

CREATE INDEX "0x6f53f38c566a1b3a" ON mainnet.extrinsics USING gist (module, _block_range);

CREATE INDEX "0x73cd163028b0b898" ON mainnet.rewards USING gist (account_id, _block_range);

CREATE INDEX "0x774ec1c372b71838" ON mainnet.events USING gist (sort_id, _block_range);

CREATE INDEX "0x79131319c12e8920" ON mainnet.transfers USING gist ("from", _block_range);

CREATE INDEX "0x79ff6a28c8a013aa" ON mainnet.logs USING gist ("timestamp", _block_range);

CREATE INDEX "0x889e9f7e5a64267c" ON mainnet.extrinsics USING gist (block_height, _block_range);

CREATE INDEX "0x946898e0d99da99d" ON mainnet.blocks USING gist (sort_id, _block_range);

CREATE INDEX "0x9dc19a4dda2286f4" ON mainnet.events USING gist (section, _block_range);

CREATE INDEX "0xa1455f2831f03723" ON mainnet.rewards USING gist ("timestamp", _block_range);

CREATE INDEX "0xb0f971b6213bd370" ON mainnet.events USING gist (module, _block_range);

CREATE INDEX "0xb3d3d7d2b08d4e7e" ON mainnet.rewards USING gist (block_hash, _block_range);

CREATE INDEX "0xb7bb46c9ebdd7fe1" ON mainnet.transfers USING gist (extrinsic_id, _block_range);

CREATE INDEX "0xb91efc8ed4021e6e" ON mainnet.transfers USING btree (id);

CREATE INDEX "0xbbc46ed346025b1f" ON mainnet.account_histories USING gist (total, _block_range);

CREATE INDEX "0xc0683fc6175b395a" ON mainnet.events USING gist (extrinsic_hash, _block_range);

CREATE INDEX "0xc7a7467355cf8dbb" ON mainnet.extrinsics USING gist ("timestamp", _block_range);

CREATE INDEX "0xccedb032815757ed" ON mainnet.blocks USING btree (id);

CREATE INDEX "0xd21b20c334f80c2e" ON mainnet.account_histories USING btree (id);

CREATE INDEX "0xd8db4c8313621519" ON mainnet.extrinsics USING btree (id);

CREATE INDEX "0xe0b781f836dc2f1a" ON mainnet.account_histories USING gist (updated_at, _block_range);

CREATE INDEX "0xe2d1f5b9c21b141e" ON mainnet.extrinsics USING gist (signer, _block_range);

CREATE INDEX "0xe56a7291c224fff9" ON mainnet.transfers USING gist ("to", _block_range);

CREATE INDEX "0xe5bf5858bd35a276" ON mainnet.events USING btree (id);

CREATE INDEX "0xf095c4017bdfed7d" ON mainnet.rewards USING gist (block_height, _block_range);

CREATE INDEX "0xf20fbf5a3f59a046" ON mainnet.extrinsics USING gist (success, _block_range);

CREATE INDEX "0xf303d79993939441" ON mainnet.rewards USING gist (reward_type, _block_range);

CREATE INDEX "0xf6317466d2b3ee74" ON mainnet.logs USING gist (block_height, _block_range);

CREATE INDEX "0xfa91e9294de2a975" ON mainnet.extrinsics USING gist (block_hash, _block_range);

CREATE INDEX "0xff37291e107f6ca9" ON mainnet.blocks USING gist (author_id, _block_range);

CREATE INDEX "0x08aa840e441d13bb" ON taurus.blocks USING gist (height, _block_range);

CREATE INDEX "0x09a98aa53fa2c2e3" ON taurus.logs USING btree (id);

CREATE INDEX "0x1532f5e4701949a5" ON taurus.extrinsics USING gist (hash, _block_range);

CREATE INDEX "0x1e967733a0d5db15" ON taurus.rewards USING btree (id);

CREATE INDEX "0x2481c1ffa5112599" ON taurus.logs USING gist (block_hash, _block_range);

CREATE INDEX "0x2a038c9edc202d38" ON taurus.transfers USING gist (event_id, _block_range);

CREATE INDEX "0x2c6d435d5ab69412" ON taurus.extrinsics USING gist (sort_id, _block_range);

CREATE INDEX "0x2cbe628ebc830c12" ON taurus.logs USING gist (sort_id, _block_range);

CREATE INDEX "0x30b779cc3aeeeec6" ON taurus.events USING gist (extrinsic_id, _block_range);

CREATE INDEX "0x3ae5d1670e99e612" ON taurus.transfers USING gist ("timestamp", _block_range);

CREATE INDEX "0x3fa25df2b17c6d2f" ON taurus.extrinsics USING gist (signature, _block_range);

CREATE INDEX "0x4131da2c2ec8b5b7" ON taurus.transfers USING gist (date, _block_range);

CREATE INDEX "0x444de3b3611c1fcd" ON taurus.account_histories USING gist (created_at, _block_range);

CREATE INDEX "0x4a66afa700f00759" ON taurus.events USING gist (block_hash, _block_range);

CREATE INDEX "0x57fc196dcc99a091" ON taurus.events USING gist (block_height, _block_range);

CREATE INDEX "0x5921649101eeb57a" ON taurus.transfers USING gist (created_at, _block_range);

CREATE INDEX "0x59386a58438fa05a" ON taurus.extrinsics USING gist (section, _block_range);

CREATE INDEX "0x59f75d2bc1e6a0bc" ON taurus.blocks USING gist ("timestamp", _block_range);

CREATE INDEX "0x6008270492da5713" ON taurus.events USING gist ("timestamp", _block_range);

CREATE INDEX "0x6131d72d57f2a188" ON taurus.blocks USING gist (hash, _block_range);

CREATE INDEX "0x61510445e44f4f2f" ON taurus.logs USING gist (index_in_block, _block_range);

CREATE INDEX "0x6f53f38c566a1b3a" ON taurus.extrinsics USING gist (module, _block_range);

CREATE INDEX "0x73cd163028b0b898" ON taurus.rewards USING gist (account_id, _block_range);

CREATE INDEX "0x774ec1c372b71838" ON taurus.events USING gist (sort_id, _block_range);

CREATE INDEX "0x79131319c12e8920" ON taurus.transfers USING gist ("from", _block_range);

CREATE INDEX "0x79ff6a28c8a013aa" ON taurus.logs USING gist ("timestamp", _block_range);

CREATE INDEX "0x889e9f7e5a64267c" ON taurus.extrinsics USING gist (block_height, _block_range);

CREATE INDEX "0x946898e0d99da99d" ON taurus.blocks USING gist (sort_id, _block_range);

CREATE INDEX "0x9dc19a4dda2286f4" ON taurus.events USING gist (section, _block_range);

CREATE INDEX "0xa1455f2831f03723" ON taurus.rewards USING gist ("timestamp", _block_range);

CREATE INDEX "0xb0f971b6213bd370" ON taurus.events USING gist (module, _block_range);

CREATE INDEX "0xb3d3d7d2b08d4e7e" ON taurus.rewards USING gist (block_hash, _block_range);

CREATE INDEX "0xb7bb46c9ebdd7fe1" ON taurus.transfers USING gist (extrinsic_id, _block_range);

CREATE INDEX "0xb91efc8ed4021e6e" ON taurus.transfers USING btree (id);

CREATE INDEX "0xbbc46ed346025b1f" ON taurus.account_histories USING gist (total, _block_range);

CREATE INDEX "0xc0683fc6175b395a" ON taurus.events USING gist (extrinsic_hash, _block_range);

CREATE INDEX "0xc7a7467355cf8dbb" ON taurus.extrinsics USING gist ("timestamp", _block_range);

CREATE INDEX "0xccedb032815757ed" ON taurus.blocks USING btree (id);

CREATE INDEX "0xd21b20c334f80c2e" ON taurus.account_histories USING btree (id);

CREATE INDEX "0xd8db4c8313621519" ON taurus.extrinsics USING btree (id);

CREATE INDEX "0xe0b781f836dc2f1a" ON taurus.account_histories USING gist (updated_at, _block_range);

CREATE INDEX "0xe2d1f5b9c21b141e" ON taurus.extrinsics USING gist (signer, _block_range);

CREATE INDEX "0xe56a7291c224fff9" ON taurus.transfers USING gist ("to", _block_range);

CREATE INDEX "0xe5bf5858bd35a276" ON taurus.events USING btree (id);

CREATE INDEX "0xf095c4017bdfed7d" ON taurus.rewards USING gist (block_height, _block_range);

CREATE INDEX "0xf20fbf5a3f59a046" ON taurus.extrinsics USING gist (success, _block_range);

CREATE INDEX "0xf303d79993939441" ON taurus.rewards USING gist (reward_type, _block_range);

CREATE INDEX "0xf6317466d2b3ee74" ON taurus.logs USING gist (block_height, _block_range);

CREATE INDEX "0xfa91e9294de2a975" ON taurus.extrinsics USING gist (block_hash, _block_range);

CREATE INDEX "0xff37291e107f6ca9" ON taurus.blocks USING gist (author_id, _block_range);

CREATE TRIGGER "0xe6ca40dbc643e025" AFTER UPDATE ON mainnet._metadata FOR EACH ROW WHEN (((new.key)::text = 'schemaMigrationCount'::text)) EXECUTE FUNCTION mainnet.schema_notification();

CREATE TRIGGER "0x7a99a79e8aee69dc" AFTER UPDATE ON taurus._metadata FOR EACH ROW WHEN (((new.key)::text = 'schemaMigrationCount'::text)) EXECUTE FUNCTION taurus.schema_notification();
