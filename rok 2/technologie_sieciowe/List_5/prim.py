# sample.py
import json
import falcon
import codecs


class Main(object):
    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200
        resp.content_type = 'text/html'
        with open('main.html', 'r') as f:
            resp.body = f.read()


class Images(object):

    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200
        resp.content_type = 'text/html'
        with open('images.html', 'r') as f:
            resp.body = f.read()


class Talker(object):

    def on_get(self, req, resp):
        resp.body = "You asked me for GET. Ask me for PUT or DELETE."

    def on_put(self, req, resp):
        resp.body = "Now you are asking for PUT."

    def on_delete(self, req, resp):
        resp.body = "By this formula {}, you asked me for DELETE.".format(req.stream.read())


api = falcon.API()
api.add_route('/', Main())
api.add_route('/images', Images())
api.add_route('/talker', Talker())
