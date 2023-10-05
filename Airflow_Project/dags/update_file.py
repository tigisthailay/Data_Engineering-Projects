from datetime import timedelta, datetime
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.contrib.sensors.file_sensor import FileSensor
from airflow.exceptions import AirflowSensorTimeout

default_args={
    "owner":"Tegisty",
    "retries": 1,
    "start_date": datetime(2022,5,8)
},

# create a DAG
dag = DAG(
    'edit_today_file',
    default_args=default_args,
    description='modify today file Dag',
    schedule_interval=30,)

file_sensor = FileSensor(
    task_id="file_sensor_task",
    poke_interval=30,
    filepath="/usr/local/airflow/today.txt",
    timeout=30,
    soft_fail=False,
    dag=dag
)

read_file = BashOperator(
    task_id='read_today_file',
    bash_command='cat ~/today.txt',
    dag=dag,)

modify_file = BashOperator(
    task_id='modify_today_file',
    bash_command='if [ -f //usr/local/airflow/today.txt];\
                  then sed -1 "s/. */This file has been modified!/" /usr/local/airflow/today.txt;\
                  else echo "File not found"; fi',
    dag=dag,)

file_sensor >> modify_file >> read_file