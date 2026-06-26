from fastapi import FastAPI

app = FastAPI(

@app.get("/")
def root():
    retn {"version": "2.0.0", "message": "Hello from the target app"}

@app.get("/health")
def health():
    return {"status": "ok"}