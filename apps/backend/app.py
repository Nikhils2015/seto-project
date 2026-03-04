from flask import Flask, jsonify
import os
import psycopg2

app = Flask(_name_)

DB_HOST = os.getenv("DB_HOST")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")

@app.route("/")
def home():
    return jsonify({"message": "Backend Running Successfully"})

@app.route("/health")
def health():
    return "OK", 200

if _name_ == "_main_":
    app.run(host="0.0.0.0", port=5000)