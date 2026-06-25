from fastapi import FastAPI

ap = FastAPI()

@app.get("/")
de root():
    return {"version": "2.0.0", "message": "Hello from the target app"}