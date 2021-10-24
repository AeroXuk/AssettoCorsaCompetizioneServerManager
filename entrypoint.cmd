@ECHO OFF
@COPY /Y C:\acc-server\config\config.yml C:\acc-server\
@COPY /Y C:\acc-server\config\OSM.License C:\acc-server\
@acc-server-manager.exe
