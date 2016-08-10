template_path = 'app/templates'
static_path = 'app/static'
debug = True
login_url = '/login'
cookie_secret = 'asdscxbgvsd213r23rfdsz'


def get_db_url(name, user, host='localhost', port=5432, password=None):
    db_addr = "dbname='{name}' user='{user}' " \
              "host='{host}' port='{port}'".format(name=name, user=user,
                                                   host=host, port=port)
    if password:
        db_addr += "password='{password}'".format(password=password)
    return db_addr
