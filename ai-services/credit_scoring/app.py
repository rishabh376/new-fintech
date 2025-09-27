from fastapi import FastAPI, Request
import joblib

app = FastAPI()
model = joblib.load("model.pkl")  # Ensure your trained model is saved as model.pkl

@app.post("/predict")
async def predict(request: Request):
    data = await request.json()
    features = data.get("features")
    if not features:
        return {"error": "Missing 'features' in request body"}
    score = model.predict([features])
    return {"credit_score": float(score[0])}