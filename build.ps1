#
# Create build structure
#
mkdir .\bin\
mkdir .\bin\image\
mkdir .\bin\image\config\
mkdir .\bin\image\server\

#
# Copy Entrypoint script into build
#
cp .\entrypoint.cmd .\image\

#
# Change into build directory
#
cd .\bin\

#
# Download Sources
#
wget https://dl.emperorservers.com/acc/v1.1.3/acc-server-manager_v1.1.3.zip -OutFile acc-server-manager_v1.1.3.zip
wget https://www.assettocorsa.net/forum/index.php?attachments/accserver_1-7-12-zip.151290/ -OutFile accServer_1.7.12.zip
wget https://aka.ms/vs/16/release/vc_redist.x64.exe -OutFile vc_redist.x64.exe

#
# Extract Zip Archives
#
Expand-Archive .\acc-server-manager_v1.1.3.zip
Expand-Archive .\accServer_1.7.12.zip

#
# Copy downloaded and extracted files into build image
#
cp .\acc-server-manager_v1.1.3\README.txt .\image\config\
cp .\acc-server-manager_v1.1.3\windows\config.yml .\image\config\
cp .\acc-server-manager_v1.1.3\windows\acc-server-manager.exe .\image\
cp .\accServer_1.7.12\accServer.exe .\image\server\

#
# Jump out of bin folder
#
cd ../

#
# Start docker build
#
docker build -t acc-server-manager .

#
# Here is the command to run the server in docker:
# 

# docker run --mount src=$(pwd)/config,target=C:/acc-server/config,type=bind --mount src=$(pwd)/results,target=C:/acc-server/server/results,type=bind -p 8443:8443 -p 9231:9231/udp -p 9232:9232 -it acc-server-manager
