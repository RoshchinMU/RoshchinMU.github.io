begin -- regexp

    -- + определяет, что в строке символ двоеточия может встретиться больше одного раза

    --regexp_split_to_array    строку назбить на столбцы 
    select a.rsra[1], a.rsra[2]
    from (SELECT regexp_split_to_array('aaa;bbbb', '\;') AS rsra) as a;

    -- REGEXP_REPLACE    замена
    SELECT REGEXP_REPLACE('aa01bb02fd-23','[^0-9]','','g') as rr;

    -- regexp_split_to_table    массив в строки
    SELECT rstt FROM regexp_split_to_table('aaa;bbb;ccc', '\;') AS rstt;

end;


begin -- оконные функции

    SELECT row_number(столбец)          over (order by)
    SELECT count/sum/min/max(столбец)   over ([partition by])
    SELECT NTILE (кол-во групп)         over ([partition by] / order by)

end;


begin -- DDL

Каждое ограничение должно называться по маске {tablename}_{columnname(s)}_{suffix}, где tablename — название таблицы, columnname(s) — одна или несколько колонок в ограничении, а suffix — тип ограничения, например:
    -- pkey для первичного ключа;
    -- fkey для внешнего ключа;
    -- check для ограничения-проверки;
    -- idx для любого другого типа индекса.
    
    DROP TABLE IF EXISTS name_table;
    
    ALTER TABLE t RENAME COLUMN a TO b
    ALTER TABLE old RENAME TO new;

    CREATE TABLE name_table
    (
         id                 serial -- PRIMARY KEY
        ,column_name        text                NULL DEFAULT 'Нет данных'
        ,column_type        text                NULL UNIQUE
        ,column_price       NUMERIC(14,3)   not null check (column_price between 0.001 and 9999.999)
        ordered_product INT NOT NULL REFERENCES products (product_id)
        ,column_desc                varchar(30) NOT NULL
    price NUMERIC NOT NULL CHECK(price > 0),
    discount NUMERIC NOT NULL CHECK (discount >= 0 AND discount <= price)
        ,CONSTRAINT name_table_pkey PRIMARY KEY (id)
    UNIQUE(order_id, ordered_product)
        

    );

ALTER TABLE test_table_no_pk ADD PRIMARY KEY ("Id"); 
    CREATE INDEX name_table_index ON name_table USING btree (id);

    ALTER TABLE column_count ADD COLUMN col_5 int8 DEFAULT 0;



ALTER TABLE test_table_dt
ALTER COLUMN dt_string SET DATA TYPE TIMESTAMP
USING to_timestamp(dt_string, 'YYYY-MM-DD hh24:mi:ss')::TIMESTAMP

CREATE TABLE test_table(
    field type REFERENCES referenced_table(referenced_field)
) 


select *
from (VALUES ('22022-03-141'),('22022-03-142'),('22022-03-143'),('22022-03-144'),('22022-03-145'),('22022-03-146'),('22022-03-147'),('22022-03-148'),('22022-03-149'),('22022-03-1410')) AS v(property_two) 






ALTER TABLE lesson47.task4_user_events ADD id int4 NOT NULL GENERATED ALWAYS AS IDENTITY;

ALTER TABLE lesson47.task3_record_log
ALTER COLUMN row_dttm SET DATA TYPE timestamptz
USING to_timestamp(row_dttm, 'YYYY-MM-DD hh24:mi:ss')::timestamptz at time zone 'Europe/Moscow';








   ,FOREIGN KEY (order_id) REFERENCES d_orders(order_id) ON UPDATE cascade,
	,CONSTRAINT f_buckets_d_products_id_fkey 		FOREIGN KEY (product_id) 	REFERENCES d_products (product_id)		ON UPDATE cascade


Дайте таблице понятное название. Если в компании есть требования к наименованиям, воспользуйтесь ими.

Каждое ограничение должно называться по маске {tablename}_{columnname(s)}_{suffix}, где tablename — название таблицы, columnname(s) — одна или несколько колонок в ограничении, а suffix — тип ограничения, например:
pkey для первичного ключа;
fkey для внешнего ключа;
check для ограничения-проверки;
idx для любого другого типа индекса.


ALTER TABLE user_payment_log ADD CONSTRAINT user_payment_log_payment_amount_check CHECK (payment_amount >= 0);

ALTER TABLE user_contacts 
		 ADD CONSTRAINT user_contacts_client_id_fkey FOREIGN KEY (client_id) 
			 REFERENCES user_attributes (client_id);


ALTER TABLE user_contacts ALTER COLUMN client_id SET NOT NULL;











END;


begin -- Хранимки PROCEDURE

    CREATE OR REPLACE PROCEDURE example_procedure(a text, b text)
    LANGUAGE SQL
    AS $$
        INSERT INTO example_table_1 VALUES (a);
        INSERT INTO example_table_2 VALUES (b);
        INSERT INTO example_table_3 VALUES (a || '_' || b);
    $$; 


    CALL example_procedure('test1', 'test2') 

    DROP PROCEDURE имя_процедуры

END;


begin -- Функции FUNCTION



    CREATE OR REPLACE FUNCTION example_function(str text, symbol char) RETURNS int4 AS 
    $$
    select array_length(regexp_split_to_array(str , '\' || symbol || '+' ), 1); 
    $$
    LANGUAGE sql; 

    RETURNS table (result_value text) 

    select description, example_function(description, ':') from orders_attributes limit 3;

END;






Существуют специальные приложения, которые позволяют выполнять миграции, версионировать БД и откатывать изменения, например системы контроля версий Liquibase и Flyway.
—schema-only делают резервную копию модели без данных:
А если, наоборот, нужны только данные, без структуры, то используют параметр --data-only
pg_dump --username имя_пользователя --data-only --dbname название_базы_данных --file example_dump.sql
pg_dump --username имя_пользователя --host 127.0.0.1 --dbname название_базы_данных --file example_dump.sql

Пример названия бэкапа:
pg_prod_clients_2222_01_01_task_777_backup.sql
pg — название СУБД PostgreSQL;
prod — название продуктивной среды;
clients — название БД;
2222_01_01 — дата создания бэкапа;
task_777 — шифр задачи.

psql --username имя_пользователя --dbname название_базы_данных --file example_dump.sql
Утилита pg_restore позволяет восстанавливать определённую БД или таблицу из резервной копии обычного формата с помощью параметров --dbname или -d и --table или -t соответственно:
pg_restore --dbname название_базы_данных --file example_dump.sql
pg_restore --table название_таблицы --file example_dump.sql 
Эта утилита также умеет восстанавливать данные без структуры с помощью параметра data-only и, наоборот, только структуру без самих данных с помощью параметра schema-only:
pg_restore --data-only --file example_dump.sql
pg_restore --schema-only --file example_dump.sql



Существует три типа триггеров:
BEFORE — исполняет блок кода до запроса на изменение данных.
AFTER — исполняет блок кода после запроса на изменение данных.
INSTEAD OF — исполняет блок кода вместо запроса на изменение данных.
Важная часть конструкции определения триггера — команда FOR EACH ROW
, которая говорит, что действие будет исполняться для каждой строки или для одного запроса
, если указано FOR EACH STATEMENT. 
Также можно указать условие срабатывания триггера с помощью ключевого слова WHEN.



Заключительная составляющая триггера — команда EXECUTE PROCEDURE, 
которая вызывает специально созданную функцию для триггера. 
Функция для триггера отличается от обычной функции тем
, что имеет возвращаемое значение TRIGGER. 
Удобнее всего писать код триггерной функции с помощью диалекта PL/pgSQL. 
Важное свойство триггерной функции — вы можете обращаться к старому и новому значению изменяемых данных с помощью ключевых слов OLD и NEW соответственно. 
Создать триггер можно с помощью CREATE TRIGGER. Рассмотрим на примере. 
В первую очередь создадим триггерную функцию:
CREATE OR REPLACE FUNCTION log_update_function_trigger() RETURNS TRIGGER AS 
$$
    BEGIN
        IF (TG_OP = 'UPDATE') THEN
            INSERT INTO example_table_5 VALUES (NEW.value, current_timestamp);
            RETURN NEW;
        END IF;
    END;
$$ LANGUAGE plpgsql; 


truncate public.d_clients CASCADE;

CREATE TRIGGER log_update_some_value
    AFTER UPDATE ON example_table_4
    FOR EACH ROW
    EXECUTE PROCEDURE log_update_function_trigger(); 





CREATE SEQUENCE d_first_properties_sequence
START 1;

SELECT nextval('d_first_properties_sequence');

-- result
-- Name   |Value|
-- -------+-----+
-- nextval|1    |
 -- или

SELECT nextval('d_first_properties_sequence')::bigint AS id,
       attributes_five,
       attributes_three::TIMESTAMP
FROM
  (SELECT DISTINCT attribute_five,
                   attribute_three
   FROM attributes_table_old) AS d_first_properties_information;

DROP SEQUENCE d_first_properties_sequence;





Помимо Nested Loop существуют ещё Hash Join и Merge Join


В таком случае советуют отключить AUTO COMMIT и в начале скрипта миграции написать команду BEGIN (начало транзакции)
, в конце скрипта миграции или отдельной его части — COMMIT (фиксация транзакции). 
Так количество операций с транзакциями сократится до минимума.


copy https://www.postgresql.org/docs/14/sql-copy.html

VACUUM ANALYZE;

VACUUM ANALYZE освобождает пространство СУБД от недоступных или «мёртвых» объектов, а затем проводит анализ и сбор статистики по таблицам. 
Недоступные или «мёртвые» объекты появляются, когда происходит, например, удаление или обновление данных в таблице. 
Чтобы повысить производительность и не мешать пользовательским запросам, данные удаляются не сразу, а лишь помечаются на удаление, но физически не удаляются из таблицы. 
Команда VACUUM принуждает СУБД выполнить «сборку мусора», то есть удалить физически недоступные объекты.






$ psql -h <host> -p <port> -U <username> -W <password> <database> 

select p.indexdef 
from pg_indexes as p
where p.tablename = 'clients_cluster_metrics_m'




SELECT table_schema, table_name FROM information_schema.tables; 


select table_name, column_name, data_type, character_maximum_length, column_default, is_nullable  
 from information_schema.columns  
  where table_schema = 'public' and  
   table_name in ('my_table', 'second_table', 'third_table', 'other_table') 
    order by table_name; 


Каждое ограничение должно называться по маске {tablename}_{columnname(s)}_{suffix}, где tablename — название таблицы, columnname(s) — одна или несколько колонок в ограничении, а suffix — тип ограничения, например:
pkey для первичного ключа;
fkey для внешнего ключа;
check для ограничения-проверки;
idx для любого другого типа индекса.

CREATE [ UNIQUE ] INDEX index_name ON table_name (column_name [ ASC | DESC ] [ NULLS { FIRST | LAST } ]); 
ALTER TABLE user_payment_log ADD CONSTRAINT user_payment_log_payment_amount_check CHECK (payment_amount >= 0);

ALTER TABLE user_contacts 
		 ADD CONSTRAINT user_contacts_client_id_fkey FOREIGN KEY (client_id) 
			 REFERENCES user_attributes (client_id);
CREATE OR REPLACE

ALTER TABLE user_contacts ALTER COLUMN client_id SET NOT NULL;
ALTER TABLE clients_cluster_metrics_m 
   ADD CONSTRAINT clients_cluster_metrics_m_month_client_id_pkey  
  		PRIMARY KEY(month, client_id);
  	
ALTER TABLE clients_cluster_metrics_m 
	ADD CONSTRAINT clients_cluster_metrics_m_client_id_fkey
		FOREIGN KEY(client_id) 
		REFERENCES user_attributes(client_id);



Выбрать double precision.
Даже если суммы платежа не выходят за два знака после запятой, средние значения могут иметь больше цифр в дробной части. 
Выбрав double precision, вы не потеряете в точности метрики из-за сокращения результата до двух знаков после запятой.

ALTER TABLE public.d_products ALTER COLUMN price TYPE numeric(14,2); 
-- PRIMARY KEY



EXPLAIN 
SELECT * 
FROM my_table 
JOIN (VALUES ('22022-03-141'),('22022-03-142'),('22022-03-143'),('22022-03-144'),('22022-03-145'),('22022-03-146'),('22022-03-147'),('22022-03-148'),('22022-03-149'),('22022-03-1410')) AS v(property_two) USING (property_two) 


-- 

select version()

select * from pg_database; доступные базы данных
Выполните специальную команду \l, которая перечислит доступные базы данных
А подключиться к новой БД вы можете с помощью команды \c dbname

pg_catalog.pg_tables

select p.tablename
from pg_tables as p
where p.schemaname = 'public'

SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname = 'public'
    AND tablename = 'your_table_name';

select * 
from information_schema.tables as t
where t.table_schema = 'public'

select indexname
from pg_indexes
where tablename = 'user_activity_log'


DDL, от англ. Data Definition Language, «язык определения данных». Операторы DDL используются, чтобы создавать новые объекты: таблицы, индексы, представления, — а также менять и удалять их.
Группа DDL включает следующие операторы:
CREATE — для создания объектов базы данных;
ALTER – для изменения объектов базы данных;
DROP — для удаления объектов базы данных.


metabase13!
extract(hour from l.hitdatetime)

DROP VIEW IF EXISTS my_name_view;

CREATE VIEW my_name_view AS
SELECT customer_id, total
FROM invoice; 

CREATE OR REPLACE VIEW my_name_view AS ...;



create table name_table as 
select * from from_table

-- my_name_view
CREATE MATERIALIZED VIEW my_name_view AS
SELECT customer_id, total
FROM invoice; 

DROP MATERIALIZED VIEW IF EXISTS my_name_view;

REFRESH MATERIALIZED VIEW my_name_view; 


information_schema.columns

char_length 
SUBSTR


distinct отвечает на вопрос "покажи уникальные комбинации таковых полей"
distinct on расширяет стандартное поведение и отвечает на вопрос "покажи данные первой строки из каждой уникальной комбинации таковых полей". А для определения "первой строки" - делает обязательным использование order by.

select distinct on (client_id)
		 client_id
		 ,phone 
from user_contacts uc 
order by client_id, created_at desc


SELECT date_trunc('month',TO_TIMESTAMP(created_at:: text , 'YYYY-MM-DD HH24:MI:SS')) :: date
FROM user_contacts;

SELECT date_trunc('month',TO_TIMESTAMP(updated_at, 'HH24:MI:SS DD/MM/YYYY')) :: date as updated_month
FROM user_contacts;


Чтобы получить структуру нужных объектов из БД Postgres, запустите командную строку и выполните в ней команду **pg_dump -t имя_таблицы имя_БД --schema-only > db.sql.**

UPDATE f_sales t SET (promotion_id) = (SELECT ... WHERE t.client_id = ? AND t.sale_id = ?);
--или
UPDATE f_sales SET promotion_id = t.promotion_id from ? as t where ?; 



select table_name, column_name, data_type, character_maximum_length, column_default, is_nullable  
 from information_schema.columns  
  where table_schema = 'public' and  
   table_name in ('my_table', 'second_table', 'third_table', 'other_table') 
    order by table_name;






    Скрипт с функцией, которая считает количество строк, полученных при разделении по заданному символу:
CREATE FUNCTION example_function(str text, symbol char) RETURNS int4 AS 
$$
select array_length(regexp_split_to_array(str , E'\\' || symbol || '+' ), 1); 
$$
LANGUAGE sql; 
Скрипт с триггером, который вызывает процедуру обновления лога:
CREATE TRIGGER log_update_some_value
AFTER UPDATE ON example_table_4
FOR EACH ROW
EXECUTE PROCEDURE log_update_function_trigger();



Бэкап можно сделать с помощью утилиты pg_dump; восстановить состояние БД из бэкапа — с помощью pg_restore или psql.



Общие советы по оптимизации запросов, которые используются чаще всего при разовой миграции большого объёма данных:
Отключите AUTO COMMIT, чтобы не тратить время на команды BEGIN и COMMIT после каждой вставки данных.
Используйте COPY при разовом переносе большого объёма данных.
Удалите индексы, чтобы не перестраивать все индексы после каждой вставки данных.
Удалите ограничения внешних ключей, чтобы не тратить время на проверки ограничений при каждой вставке данных.
Используйте ANALYZE, чтобы собрать статистику по данным в таблицах.
Измените запрос с множеством значений в IN, чтобы выбрать план запроса с Hash Join.
Используйте LIMIT, если не нужны все данные из таблицы.
Не создавайте много индексов.
Используйте подходящие типы данных.