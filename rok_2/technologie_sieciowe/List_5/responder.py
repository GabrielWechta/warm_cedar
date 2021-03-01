# sample.py

import falcon


class Responder(object):
    def on_get(self, req, resp):
        resp.body = req.method

    def on_head(self, req, resp):
        resp.body = req.method

    def on_post(self, req, resp):
        resp.body = req.method

    def on_put(self, req, resp):
        resp.body = req.method

    def on_delete(self, req, resp):
        resp.body = req.method

    def on_connect(self, req, resp):
        resp.body = req.method

    def on_options(self, req, resp):
        resp.body = req.method

    def on_trace(self, req, resp):
        resp.body = req.method

    def on_patch(self, req, resp):
        resp.body = req.method


api = falcon.API()
api.add_route('/', Responder())
