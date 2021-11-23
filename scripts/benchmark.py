#!/usr/bin/env python3
"""
http://docs.locust.io/en/stable/what-is-locust.html
"""
import os
from locust import HttpUser, task
from os import getenv

CLIENT_SECRET = getenv('CLIENT_SECRET')
ADMIN_EMAIL = getenv('ADMIN_EMAIL')
ADMIN_PASSWORD = getenv('ADMIN_PASSWORD')


class GetContestStatus(HttpUser):
    access_token = None

    def on_start(self):
        login_req = self.client.post(url="/oauth/token", json={
            'client_secret': CLIENT_SECRET,
            'username': ADMIN_EMAIL,
            'password': ADMIN_PASSWORD,
            'grant_type': 'password',
            'client_id': 2
        })
        data = login_req.json()
        self.access_token = data['access_token']

    @task
    def api_status(self):
        self.client.get(url="/api/status", headers={
            "Authorization": "Bearer " + self.access_token
        })
