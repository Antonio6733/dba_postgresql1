import psycopg2


if __name__ == "__main__":
    try:
        url = "host='{0}' dbname='{1}' user='{2}' password='{3}'".format('localhost', 'postgres', 'postgres', 'root')


        conn = psycopg2.connect(url)


        cursor = conn.cursor()

        sql = """SELECT pg_database.datname,pg_user.usename, pg_size_pretty(pg_database_size(pg_database.datname)) 
        AS SIZE FROM pg_database INNER JOIN pg_user on pg_database.datdba = pg_user.usesysid;"""

        cursor.execute(sql)

        for row in cursor:
            print(row[0],row[1],row[2])


        cursor.close()
    except (Exception, psycopg2.DatabaseError) as e:
        print(e)
