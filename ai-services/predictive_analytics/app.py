from fastapi import FastAPI, Request

app = FastAPI()

@app.post("/predict")
async def predict(request: Request):
    data = await request.json()
    timeseries = data["timeseries"]
    # Dummy prediction, replace with actual model
    prediction = sum(timeseries) / len(timeseries)
    return {"prediction": prediction}