FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8

WORKDIR /restaurantService

COPY ./requirements.txt /restaurantService/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /restaurantService/requirements.txt

COPY ./app /restaurantService/app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "9001"]
