from airflow.decorators import task
from airflow.decorators import dag
from datetime import datetime, timedelta
import pathlib
import os
import glob
from utils import *


sql_files_path = os.path.join(pathlib.Path(__file__).parent.absolute(), 'sql')


@task
def create_tables() -> None:
    for filepath in glob.glob(f'{sql_files_path}/create_*'):
        run_slq_query_from_a_file(path=filepath)

@task
def fill_in_staging_deliverysystem() -> None:
    reports = ['restaurants', 'couriers', 'deliveries']
    for report in reports:
        url = f'{BASE_URL}/{report}'
        data = get_data(url)
        table_name = f'stg.deliverysystem_{report}'
        insert_json_data(table_name, data)


@dag(
    default_args={
        "owner": "student",
        "email": ["student@example.com"],
        "email_on_failure": False
    },
    schedule_interval=None,
    start_date=datetime(2022, 7, 29),
    catchup=False,
    tags=["delivery"],
)
def courier_ledger():
    create_tables() >> fill_in_staging_deliverysystem()


t = courier_ledger()
