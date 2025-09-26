from fastapi import FastAPI, Request
import joblib

app = FastAPI()
model = joblib.load("model.pkl")

@app.post("/predict")
async def predict(request: Request):
    data = await request.json()
    features = data["features"]
    prediction = model.predict([features])
    return {"prediction": int(prediction[0])}