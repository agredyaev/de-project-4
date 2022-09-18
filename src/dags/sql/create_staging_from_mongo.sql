drop table if exists stg.ordersystem_orders;

create table stg.ordersystem_orders (
id serial primary key,
object_id varchar(50),
object_value text,
update_ts TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


drop table if exists stg.ordersystem_restaurants;

create table stg.ordersystem_restaurants (
id serial primary key,
object_id varchar(50),
object_value text,
update_ts TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


drop table if exists stg.ordersystem_users;

create table stg.ordersystem_users (
id serial primary key,
object_id varchar(50),
object_value text,
update_ts TIMESTAMPTZ NOT NULL DEFAULT NOW()
);



