from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"version": "55.0.0", "message": "Hello from the target app and the montitoring phase :) "}

@app.get("/health")
def health():
    return {"status": "ok"}