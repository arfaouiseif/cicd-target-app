from fastapi import FastAPI

app = FastAPI(

@app.get("/")
def root):
    return {"version": "4.0.0", "message": "Hello from the target app"}

@app.get("/health")
def health():
    return {"status": "ok"}