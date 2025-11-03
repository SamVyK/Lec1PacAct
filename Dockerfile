FROM python:3.9-slim

# Workdir
WORKDIR /app

# Install git (for committing in CI)
RUN apt-get update && apt-get install -y --no-install-recommends git \
  && rm -rf /var/lib/apt/lists/*

# Copy entire repo (so action has access to scripts + README + data.txt)
COPY . /app

# Ensure entrypoint is executable
RUN chmod +x .github/scripts/entrypoint.sh .github/scripts/update_readme.sh

# Run the entrypoint inside the container
ENTRYPOINT [".github/scripts/entrypoint.sh"]
