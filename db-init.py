#!/usr/bin/env python
import os
import MySQLdb as mysql

db_root_pwd = os.environ["DB_ROOT_PASSWORD"]
db_user = os.environ["DB_USER"]
db_pwd = os.environ["DB_PASSWORD"]
db_name = os.environ["DB_NAME"]

db = mysql.connect("db", "root", db_root_pwd, db_name)
cursor = db.cursor()
cursor.execute("CREATE USER IF NOT EXISTS '" + db_user +"' IDENTIFIED BY '" + db_pwd + "';")
cursor.execute("GRANT ALL PRIVILEGES ON " + db_name + ".* TO '" + db_user + "';")
db.close()