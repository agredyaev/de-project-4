DROP TABLE if EXISTS cdm.dm_courier_ledger;

CREATE TABLE cdm.dm_courier_ledger (
	id serial PRIMARY KEY, 
	courier_id int8 NOT NULL, 
	courier_name varchar(100) NOT NULL,
	settlement_year int4 NOT NULL CHECK ((settlement_year > 2021) AND (settlement_year < 2100)),
	settlement_month int4 NOT NULL CHECK ((settlement_month >= 1) AND (settlement_month <= 12)), 
	orders_count int8 NOT NULL CHECK (orders_count >= 0), 
	orders_total_sum numeric(14, 2) NULL DEFAULT 0 CHECK(orders_total_sum >= (0)::numeric),
	rate_avg numeric(14, 2) NULL DEFAULT 0 CHECK (rate_avg >= (0)::numeric), 
	order_processing_fee numeric(14, 2) NULL DEFAULT 0 CHECK(order_processing_fee >= (0)::numeric), 
	courier_order_sum numeric(14, 2) NULL DEFAULT 0 CHECK(courier_order_sum >= (0)::numeric), 
	courier_tips_sum numeric(14, 2) NULL DEFAULT 0 CHECK (courier_tips_sum >= (0)::numeric), 
	courier_reward_sum numeric(14, 2) NULL DEFAULT 0 CHECK (courier_reward_sum >= (0)::numeric)

);

-- Column comments

COMMENT ON COLUMN cdm.dm_courier_ledger.id IS 'идентификатор записи';
COMMENT ON COLUMN cdm.dm_courier_ledger.courier_id IS 'ID курьера, которому перечисляем.';
COMMENT ON COLUMN cdm.dm_courier_ledger.courier_name IS 'Ф. И. О. курьера.';
COMMENT ON COLUMN cdm.dm_courier_ledger.settlement_year IS 'год отчёта';
COMMENT ON COLUMN cdm.dm_courier_ledger.settlement_month IS 'месяц отчёта, где 1 — январь и 12 — декабрь.';
COMMENT ON COLUMN cdm.dm_courier_ledger.orders_count IS 'количество заказов за период (месяц)';
COMMENT ON COLUMN cdm.dm_courier_ledger.orders_total_sum IS 'общая стоимость заказов.';
COMMENT ON COLUMN cdm.dm_courier_ledger.rate_avg IS 'средний рейтинг курьера по оценкам пользователей.';
COMMENT ON COLUMN cdm.dm_courier_ledger.order_processing_fee IS 'сумма, удержанная компанией за обработку заказов, которая высчитывается как orders_total_sum * 0.25';
COMMENT ON COLUMN cdm.dm_courier_ledger.courier_order_sum IS 'сумма, которую необходимо перечислить курьеру за доставленные им/ей заказы. За каждый доставленный заказ курьер должен получить некоторую сумму в зависимости от рейтинга';
COMMENT ON COLUMN cdm.dm_courier_ledger.courier_tips_sum IS 'сумма, которую пользователи оставили курьеру в качестве чаевых';
COMMENT ON COLUMN cdm.dm_courier_ledger.courier_reward_sum IS 'сумма, которую необходимо перечислить курьеру. Вычисляется как courier_order_sum + courier_tips_sum * 0.95 (5% — комиссия за обработку платежа)';