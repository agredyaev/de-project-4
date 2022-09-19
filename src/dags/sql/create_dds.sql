drop table if exists dds.dm_users CASCADE;

create table dds.dm_users (
    id serial PRIMARY KEY,
    user_id varchar(50) not null,
    user_name varchar(50) not null,
    user_login varchar(50) not null
);

drop table if exists dds.dm_couriers CASCADE;

create table dds.dm_couriers (
    id serial PRIMARY KEY,
    courier_id varchar(50) not null,
    courier_name varchar(50) not null
);

drop table if exists dds.dm_restaurants CASCADE;

create table dds.dm_restaurants (
    id serial PRIMARY KEY,
    restaurant_id varchar(50) not null,
    restaurant_name varchar(50) not null,
    active_from TIMESTAMPTZ NOT null,
    active_to TIMESTAMPTZ NOT null
);

drop table if exists dds.dm_timestamps CASCADE;

create table dds.dm_timestamps (
    id serial PRIMARY KEY,
    ts timestamp(6) not null,
    year smallint not null check(
        year >= 2022
        and year <= 2500
    ),
    month smallint not null check(
        month >= 1
        and month <= 12
    ),
    day smallint not null check(
        day >= 1
        and day <= 31
    ),
    time time not null,
    date date not null
);

drop table if exists dds.dm_orders CASCADE;

create table dds.dm_orders (
    id serial PRIMARY KEY,
    user_id int not null references dds.dm_users(id),
    restaurant_id int not null references dds.dm_restaurants(id),
    order_ts_id int not null references dds.dm_timestamps(id),
    delivery_ts_id int not null references dds.dm_timestamps(id),
    order_key varchar(50) not null,
    order_status varchar(50) not null,
    address varchar(50) not null
);

drop table if exists dds.dm_deliveries CASCADE;

create table dds.dm_deliveries (
    id serial PRIMARY KEY,
    delivery_id varchar(50) not null,
    order_id int not null references dds.dm_orders(id),
    courier_id int not null references dds.dm_couriers(id),
    rate smallint not null check(
        rate >= 1
        and rate <= 5
    ),
    sum numeric(14, 2) not null check(sum >= 0),
    tip_sum numeric(14, 2) not null check(tip_sum >= 0)
);