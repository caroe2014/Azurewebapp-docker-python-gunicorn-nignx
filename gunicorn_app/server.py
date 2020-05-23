from gunicorn_app import app
from flask import render_template

@app.route("/")
def home():
    #return render_template('index.html')
    return "Hello World from Hasura"

#if __name__ == '__main__':
#    app.run(host='0.0.0.0')
