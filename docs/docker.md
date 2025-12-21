# Docker Compose
```yaml
services:
  db:
    image: postgres:16
    container_name: forecasting-db
    environment:
      POSTGRES_USER: app
      POSTGRES_PASSWORD: app
      POSTGRES_DB: forecasting
    ports:
      - "5433:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data
      - ./db/init:/docker-entrypoint-initdb.d
```
db ist der Name des Services wird intern für networking genutzt.
Image ist das Image, das von Dockerhub gezogen wird.
Container_name ist ein expliziter Container Name (freiwillig).
Unter Environment kann man Umgebungsvariablen für den Container übergeben.

Port Mapping ist Host:Container, Postgres hat den Standardport 5432 und wir können den unter Localhost:5433 erreichen.

Unter Volumes können wir Pfade angeben unter denen die Daten auch nach abschalten des Containers erhalten bleiben. 
Außerdem verweisen wir auf unseren ./db/init ordner als entrypoint. Das wird nur nachdem erstem hochfahren des Containers ausgeführt

```shell
docker exec -it forecasting-db psql -U app -d forecasting 
```
Nach dem Befehl können wir im Terinal auf die Datenbank zugreifen
