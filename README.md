# MATB09-postgres-vs-cassandra


```
docker exec -it matb09-postgres-vs-cassandra_cassandra_1 cqlsh
```

```
docker exec -it matb09-postgres-vs-cassandra_postgres_1 psql -U matb09 -d matb09_db

\dt
```


```
SELECT view_name, where_clause FROM system_schema.views;

SELECT table_name from system_schema.tables where keyspace_name = 'matb09';

```
