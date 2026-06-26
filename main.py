from fastapi import FastAPI

app = FastAI()

@app.get("/")
def ro):
    retn {"version": "2.0.0", "message": "Hello from the target app"}

@app.get("/health")
def health()
    return {"status": "ok"}