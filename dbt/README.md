# Running locally
## Prerequisites
1. Docker compose
1. A `profiles.yml` in the `dbt` directory that looks like this:
```
abnormal:
  target: dev
  outputs:
    dev:
      type: postgres
      host: your_db_hostname
      user: your_db_username
      password: your_db_password
      port: your_db_port
      dbname: your_db_name
      schema: your_db_schema
      threads: 1
```
3. An `.env-local` file in the root directory that looks like this:
```
DEV_PG_NAME=your_db_name
DEV_PG_USER=your_db_username
DEV_PG_PASSWORD=your_db_password
DEV_PG_HOST=your_db_hostname
DEV_PG_PORT=your_db_port
```
## Running docker
`docker-compose build --up`

The `compose.yaml` file will run these services:
* Postgres database
* dbt
* jupyter notebook

It will also set up environment variables needed for local development from the `.env-local` file