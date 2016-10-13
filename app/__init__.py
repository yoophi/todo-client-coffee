import os
from flask import Flask, render_template, redirect, url_for

app = Flask(__name__)

@app.route('/')
def index():
    return redirect(url_for('client'))

@app.route('/client/')
@app.route('/client/<string:path>')
def client(path=None):
    return render_template('index.html')


if __name__ == '__main__':
    app.run(port=9001, debug=True)
