from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_root_returns_200():
    response = client.get("/")
    assert response.status_code == 200

def test_root_returns_version():
    response = client.get("/")
    data = response.json()
    assert "version" in data
    assert "message" in data

def test_health_returns_ok():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "ok"