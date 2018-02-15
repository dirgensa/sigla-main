Sigla
===
#### _Per avviare una istanza di oracle locale_ 
```
sudo docker run -d --name oracle-xe -p 1521:1521 -v $PWD/initdb:/etc/entrypoint-initdb.d alexeiled/docker-oracle-xe-11g
```
#### _Cambiare la variabile di ambiente_
```
export SIGLA_CONNECTION_URL=jdbc:oracle:thin:@localhost:1521:xe
```
#### _Dalla directory sigla-ear lanciare il comando_
```
mvn wildfly:run
```