import tornado.ioloop
import tornado.httpserver
import tornado.web
from app.urls import routs
import momoko
import config
from psycopg2.extras import DictCursor
from tornado.options import options, define, parse_command_line


class Application(tornado.web.Application):
    def __init__(self):
        self.handlers = routs
        ioloop = tornado.ioloop.IOLoop.instance()
        self.settings = dict(
            debug=config.debug,
            template_path=config.template_path,
            static_path=config.static_path,
            cookie_secret=config.cookie_secret,
            login_url=config.login_url
        )
        super(Application, self).__init__(self.handlers, **self.settings)
        self.db_async = momoko.Pool(
            dsn=config.get_db_url(options.db_name,
                                  options.db_user_name,
                                  options.db_host,
                                  options.db_port,
                                  options.db_password),
            size=1,
            ioloop=ioloop,
            cursor_factory=DictCursor
        )
        future = self.db_async.connect()
        ioloop.add_future(future, lambda x: ioloop.stop())
        ioloop.start()
        future.result()

define('db_name', default='wood_stuff', type=str, help='Database name')
define('db_user_name', type=str, help='Postgres username')
define('db_host', default='localhost', type=str, help='Database host')
define('db_port', default=5432, type=int, help='Database port')
define('db_password', default='', type=str, help='Database port')
define('host', type=str, help='Application server host')
define('port', default=8080, type=int, help='Application server port')


def start_app():
    parse_command_line()
    print(options.db_name,
                                  options.db_user_name,
                                  options.db_host,
                                  options.db_port,
                                  options.db_password)
    app = Application()
    http_server = tornado.httpserver.HTTPServer(app, xheaders=True)
    http_server.listen(options.port, options.host)
    print('Listen %s:%s' % (options.host, options.port))
    tornado.ioloop.IOLoop.instance().start()

if __name__ == '__main__':
    start_app()
