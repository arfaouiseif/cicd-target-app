# ── Stage: base image ────────────────────────────────────────────────────────
# Use the official slim Python 3.11 image.
# "slim" strips dev tools and documentation → smaller final image (~50 MB vs ~1 GB).
# Pinning the exact tag (3.11-slim) makes builds reproducible across machines.
FROM python:3.11-slim

# ── Working directory ─────────────────────────────────────────────────────────
# All subsequent commands run relative to this path inside the container.
# Creates the directory if it doesn't exist.
WORKDIR /app

# ── Install dependencies ──────────────────────────────────────────────────────
# Copy requirements BEFORE the app code.
# Docker caches each layer; copying requirements separately means the expensive
# "pip install" layer is only re-run when requirements.txt changes, not on
# every code change. This is the single most important Dockerfile optimisation.
COPY req.txt .
RUN pip install --no-cache-dir -r req.txt

# ── Copy application code ─────────────────────────────────────────────────────
# Copied after pip install so code changes don't bust the dependency cache.
COPY main.py .

# ── Expose port ───────────────────────────────────────────────────────────────
# Documents which port the app listens on. Does NOT actually publish the port
# (that's done at runtime with `docker run -p 8000:8000`).
EXPOSE 8000

# ── Start command ─────────────────────────────────────────────────────────────
# Use the exec form (JSON array) — not the shell form ("CMD uvicorn ...").
# Exec form makes uvicorn PID 1, so Docker signals (SIGTERM on stop) reach it
# directly instead of being swallowed by a shell wrapper.
#
# --host 0.0.0.0  → listen on all interfaces inside the container (required;
#                    the default 127.0.0.1 is unreachable from outside)
# --port 8000     → must match EXPOSE above
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
