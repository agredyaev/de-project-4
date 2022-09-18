import json
import requests
from sqlalchemy import create_engine
from sqlalchemy import text


NICKNAME = 'agredyaev'
COHORT = '1'

PORT = '5432'
DB_CONNECTION_STRING = f'postgresql+psycopg2://jovyan:jovyan@localhost:{PORT}/de'

BASE_URL = 'https://d5d04q7d963eapoepsqr.apigw.yandexcloud.net'
API_KEY = '25c27781-8fde-4b30-a22e-524044a7580f'

HEADERS = {
    'X-Nickname': NICKNAME,
    'X-Cohort': COHORT,
    'X-Project': 'True',
    'X-API-KEY': API_KEY
}

DEFAULT_ARGS = {
    "owner": NICKNAME,
    'email': ['student@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 0
}

PARAMS = {
    'sort_field': 'id',
    'sort_direction': 'asc',
    'limit': 50,
    'offset': 0
}

engine = create_engine(DB_CONNECTION_STRING)
conn = engine.connect()


def run_slq_query_from_a_file(path: str) -> None:
    """
        Executes sql query from a file
    Args:
        path (str): path to a file
    """

    with open(path) as file:
        query = text(file.read())
        conn.execute(query)


def get_data(url: str) -> str:
    """Extracts data from API
    
    Args:
        url (str): url

    Returns:
        json: result
    """
    return requests.get(
        url=url,
        headers=HEADERS,
        params=PARAMS

    ).json()

def insert_json_data(table_name: str, data: str) -> None:
    """
        Inserts json data to the destination table
    Args:
        table_name (str): name of the destination table
        data (json): data that should be inserted
    """

    query = """
        INSERT INTO {0} (data)
        SELECT jsonb_array_elements('{1}'::jsonb) as data
    """
    conn.execute(query.format(table_name, json.dumps(data)))