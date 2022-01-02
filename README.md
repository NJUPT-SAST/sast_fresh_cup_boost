# sast_fresh_cup_boost

[![Docker Image CI](https://github.com/NJUPT-SAST-Technology-Center/sast_fresh_cup_boost/actions/workflows/build.yml/badge.svg)](https://github.com/NJUPT-SAST-Technology-Center/sast_fresh_cup_boost/actions/workflows/build.yml)

## How To Setup

### requirements:

docker >= 20.10.8 (Recommand)\
docker-composer >= 1.29.2 (Recommand)

```shell
# export http_proxy=http://127.0.0.1:1087
mkdir -p /srv/sast_fresh_cup_boost/
cd /srv/sast_fresh_cup_boost/
curl -sL -o .env https://github.com/NJUPT-SAST-Technology-Center/sast_fresh_cup_boost/raw/main/.env.example
# vim .env
curl -sL -o docker-compose.yml https://github.com/NJUPT-SAST-Technology-Center/sast_fresh_cup_boost/raw/main/docker-compose.yml
docker-compose -p sast_fresh_cup -f - up -d
```

### Administration Configuration

## Usage

### Batch Create Users

### Run Benchmark

```shell
pip3 install locust
HOST=http://127.0.0.1:8000 ./scripts/benchmark.py
```

### Run Review-Check System
