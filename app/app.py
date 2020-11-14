#!/usr/bin/env python3.7

from flask import Flask
from flask import render_template

# creates a Flask application, named app
app = Flask(__name__)

# a route where we will display a welcome message via an HTML template
@app.route("/")
def hello():
    message = "Hello, Checkout"
    return render_template('index.html', message=message)

# run the application
if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0", port=5000)
