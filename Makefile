default: run

run:
	poetry run flask --app server/app.py run --host=0.0.0.0 --port=8080
