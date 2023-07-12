import psycopg2


if __name__ == "__main__":
    try:
        url = "host='{0}' dbname='{1}' user='{2}' password='{3}'".format('localhost', 'hrdb', 'postgres', 'root')


        conn = psycopg2.connect(url)


        cursor = conn.cursor()

        sql = """SELECT pg_database.datname, pg_user.usename, schemaname, tablename, pg_size_pretty(pg_total_relation_size(tablename::regclass::oid))
FROM pg_tables INNER JOIN pg_user on pg_tables.tableowner = pg_user.usename 
INNER JOIN pg_database on pg_database.datdba = pg_user.usesysid
WHERE   schemaname NOT IN('pg_catalog', 'information_schema');"""

        cursor.execute(sql)

        for row in cursor:
            print(row[0],row[1],row[2],row[3],row[4])


        cursor.close()
    except (Exception, psycopg2.DatabaseError) as e:
        print(e)
