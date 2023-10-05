from datetime import timedelta, datetime
from airflow import DAG
from airflow.operators.bash_operator import BashOperator

default_args={
    "owner":"Tegisty",
    "retries": 1,
    "start_date": datetime(2022,5,8)
},

# create a DAG
dag = DAG(
    'create_today_file',
    default_args=default_args,
    description='create today file Dag',
    schedule_interval='@daily',)


create_file = BashOperator(
    task_id='create_file',
    bash_command='touch ~/today.txt',
    dag=dag,)

# create task to write to file again using the bash
# operator
write_file = BashOperator(
    task_id='write_to_file',
    bash_command='echo "This is a new file" > ~/today.txt',
    dag=dag,)

read_file = BashOperator(
    task_id='read_from_file',
    bash_command='cat ~/today.txt',
    dag=dag,)

create_file >> write_file >> read_file