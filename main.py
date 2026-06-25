from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"version": "2.0.0", "message": "Hello from the target app"}