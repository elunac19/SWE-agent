FROM python:3.11

# Set the working directory
WORKDIR /app

# Install nodejs and gcc dependencies
RUN apt update && \
    apt install -y --no-install-recommends \
    nodejs \
    npm \
    gcc \
    g++ \
    make \
    cmake && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Docker CLI using the official Docker installation script
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh

# Copy the application code
# Do this last to take advantage of the docker layer mechanism
COPY . /app

# Install Python dependencies
RUN pip install -e '.'

# Install react dependencies ahead of time
RUN cd sweagent/frontend && npm install
