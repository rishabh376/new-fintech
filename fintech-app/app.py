import requests
from flask import Flask, request, jsonify

app = Flask(__name__)

AI_SERVICES = {
    "fraud_detection": "http://fraud-detection:8000/predict",
    "virtual_assistant": "http://virtual-assistant:8000/predict",
    "credit_scoring": "http://credit-scoring:8000/predict",
    "portfolio_optimization": "http://portfolio-optimization:8000/predict",
    "predictive_analytics": "http://predictive-analytics:8000/predict"
}

@app.route("/fraud-check", methods=["POST"])
def fraud_check():
    features = request.json["features"]
    response = requests.post(AI_SERVICES["fraud_detection"], json={"features": features})
    return jsonify(response.json())

# Repeat similar endpoints for other AI services

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)