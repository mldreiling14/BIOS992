FROM rocker/verse:latest

RUN apt-get update && apt-get install -y \
    libarpack2-dev \
    libglpk-dev \
    libxt-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
