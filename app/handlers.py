import tornado.web
import tornado.gen


class Base(tornado.web.RequestHandler):

    def data_received(self, chunk):
        """ This method no needed. Just to no get NotImplementedError """
        pass

    @property
    def db(self):
        """ get database handler """
        return self.application.db_async


class Index(Base):
    async def get(self):
        self.render('index.html')
