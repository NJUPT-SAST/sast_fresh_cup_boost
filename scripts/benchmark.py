#!/usr/bin/env python3
"""
http://docs.locust.io/en/stable/what-is-locust.html
"""
import gevent
from locust.env import Environment
from locust import HttpUser, task, user
from locust.env import Environment
from locust.stats import stats_printer, stats_history
from os import getenv, _exit

HOST = getenv('HOST')

print('HOST=', HOST)


class ContestUser(HttpUser):
    host = HOST
    access_token = None

    def on_start(self):
        with self.client.post(url="/oauth/token", json={
            'username': 'sast_fresh_cup@sast.njupt.com',
            'password': 'admin123',
        }) as response:
            data = response.json()
            if 'access_token' not in data:
                print(data)
                _exit(-1)
            self.access_token = 'Bearer '+data['access_token']

    @task
    def api_status(self):
        self.client.get(url='/api/status', headers={
            'Authorization': self.access_token
        })

    def api_user(self):
        pass

    def api_notice(self):
        pass

    def api_questions(self):
        pass

    def api_get_submitted(self):
        pass

    def api_submit(self):
        pass


# setup Environment and Runner
env = Environment(user_classes=[ContestUser])
env.create_local_runner()

# start a WebUI instance
env.create_web_ui("127.0.0.1", 8089)

# start a greenlet that periodically outputs the current stats
gevent.spawn(stats_printer(env.stats))

# start a greenlet that save current stats to history
gevent.spawn(stats_history, env.runner)

# start the test
env.runner.start(600, spawn_rate=100)

# in 60 seconds stop the runner
gevent.spawn_later(60, lambda: env.runner.quit())

# wait for the greenlets
env.runner.greenlet.join()

# stop the web server for good measures
env.web_ui.stop()
