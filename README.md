# sast_fresh_cup_boost

## How To Setup

### requirements:

docker >= 20.10.8 (Recommand)\
docker-composer >= 1.29.2 (Recommand)

```shell
cp .env.example .env
# Edit .env
git submodule update --init -recursive
docker-compose up -d
```

### Administration Configuration

## Usage

### Batch Create Users

### Run Benchmark

```shell
pip3 install locust
CLIENT_SECRET=RQjR2ODnm6q8yzNTZiaztUdzsanfu3L3TJsEHpOl HOST=http://127.0.0.1:8000 ./scripts/benchmark.py
```

### Run Review-Check System
