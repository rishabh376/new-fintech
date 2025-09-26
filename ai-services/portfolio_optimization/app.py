from fastapi import FastAPI, Request

app = FastAPI()

@app.post("/predict")
async def predict(request: Request):
    data = await request.json()
    portfolio = data["portfolio"]
    # Dummy optimization, replace with actual logic
    optimized = {k: v * 1.1 for k, v in portfolio.items()}
    return {"optimized_portfolio": optimized}