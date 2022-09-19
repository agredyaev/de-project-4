drop table if exists stg.deliverysystem_restaurants;

create table stg.deliverysystem_restaurants (
id serial PRIMARY KEY,
created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
data jsonb not null
);
create index stg_restaurants_jsonb_idx on stg.deliverysystem_restaurants using GIN (data);

drop table if exists stg.deliverysystem_couriers;

create table stg.deliverysystem_couriers (
id serial PRIMARY KEY,
created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
data jsonb
);
create index stg_couriers_jsonb_idx on stg.deliverysystem_couriers using GIN (data);


drop table if exists stg.deliverysystem_deliveries;

create table stg.deliverysystem_deliveries (
id serial PRIMARY KEY,
created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
data jsonb not null
);
create index stg_deliveries_jsonb_idx on stg.deliverysystem_deliveries using GIN (data);


