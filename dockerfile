FROM ubuntu:22.04

# Set environment
USER root
ENV DEBIAN_FRONTEND=noninteractive
ENV ALLURE_VERSION=2.29.0
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:/opt/allure-${ALLURE_VERSION}/bin:/opt/venv/bin:$PATH"

# Install base dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    curl \
    unzip \
    wget \
    tar \
    git \
    gnupg2 \
    locales \
    python3.10 \
    python3.10-venv \
    python3-pip \
    fontconfig \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Locale settings
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Set python3.10 as default python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Set up Python venv and install Robot + Allure adapter
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install --no-cache-dir robotframework allure-robotframework

# Install Java 17 (Temurin)
RUN mkdir -p /opt/java && \
    curl -L https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.11+9/OpenJDK17U-jdk_x64_linux_hotspot_17.0.11_9.tar.gz \
    | tar -xz -C /opt/java && \
    mv /opt/java/jdk-17* /opt/java/openjdk

# Install Allure CLI
RUN wget https://github.com/allure-framework/allure2/releases/download/${ALLURE_VERSION}/allure-${ALLURE_VERSION}.tgz && \
    tar -xzf allure-${ALLURE_VERSION}.tgz -C /opt/ && \
    rm allure-${ALLURE_VERSION}.tgz && \
    ln -s /opt/allure-${ALLURE_VERSION}/bin/allure /usr/bin/allure

# Download Jenkins WAR only (do not install via apt)
RUN mkdir -p /opt/jenkins && \
    wget -q https://get.jenkins.io/war-stable/latest/jenkins.war -O /opt/jenkins/jenkins.war

# Create jenkins user (non-root execution)
RUN useradd -m -s /bin/bash jenkins
USER jenkins

# Set working directory for Robot tests
RUN mkdir -p /home/jenkins/project
WORKDIR /home/jenkins/project
COPY tests/ /home/jenkins/project/tests/

# Expose Jenkins default port
EXPOSE 8080

# Display tool versions (optional)
RUN robot --version || true && \
    allure --version || true && \
    java -version || true

# Start Jenkins
CMD ["java", "-jar", "/opt/jenkins/jenkins.war"]
