# AssettoCorsaCompetizioneServerManager
Windows nanoserver based Docker container for Assetto Corsa Competizione Dedicated Server with ACC Server Manager.

Built Docker image size is around 320MB and has used around 300MB of RAM during light testing.

You will need to [purchase a license for acc-server-manager from Emperor Server](https://emperorservers.com/products/accsm) which costs $12 USD. The server manager will not work without a valid license file (OSM.License) in your config directory.

## Directory structure of container
Here is the directory structure for the significant parts. At the moment the `config.yml` and `OSM.License` files get coppied into the `C:\acc-server\` directory at runtime as that is where `acc-server-manager.exe` expects them to be. So any relative paths in your config.yml will apply from `C:\acc-server\`.

    C:\acc-server\
    |
    | - acc-server-manager.exe
    | - entrypoint.cmd
    |
    | - config (Mapped to host)
    |   | - store.json / ... (Recommended location to configure store.json)
    |   | - config.yml       (Gets coppied to parent directory at runtime)
    |   | - OSM.License      (Gets coppied to parent directory at runtime)
    |   | - ssl_cert         (Optional if SSL not required)
    |   \ - ssl_key          (Optional if SSL not required)
    |
    \ - server
        | - accServer.exe
        | - _manager / ...
        | - cfg / ...
        | - log / ...     (Optionally mapped to host)
        \ - results / ... (Optionally mapped to host)

## Folders to mount
 
- Required:
  - `C:\acc-server\config` - Mount this location to a folder containing your customised `config.yml`, `OSM.License` file and you SSL cert and key if using https.
- Optional:
  - `C:\acc-server\server\log` - Mount this location if you want to be able to access the server logs.
  - `C:\acc-server\server\results` - Mount this location if you want to be able to access server race results.

## Ports to map
The default ports used are as follows:
- tcp 8773 - Used for server manager website running in http mode by default
- udp 9231 - Used by accServer
- tcp 9232 - Used by accServer
