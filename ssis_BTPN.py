import airflow # type: ignore
from airflow import DAG # type: ignore
from airflow.operators.bash_operator import BashOperator # type: ignore
from datetime import timedelta

default_args = {
    'start_date': airflow.utils.dates.days_ago(0),
    'retries': 0,
    'retry_delay': timedelta(minutes=5)
}

with DAG('ssis_BTPN', 
        description='Bash command for running SSIS package',
        default_args=default_args,
        schedule_interval='0 5 * * *', # Cron Job to run everyday at 5am
        ) as dag:

    # Bash Command to run DTSX file (SSIS Package)
    run_dtsx = BashOperator(task_id='running', bash_command='"C:\Program Files\Microsoft SQL Server\160\DTS\Binn\DTExec.exe" /File "C:\\Users\\LENOVO\\source\\repos\\Integration Services Project1\\Integration Services Project1\\Package.dtsx"')

run_dtsx