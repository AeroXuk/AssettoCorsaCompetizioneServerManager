# 
# Setup build env
# - We need the vc_redist.x64 installed to run accServer.exe.
# - We will install it in into servercore then copy it into nanoserver.
# - This is because nanoserver doesn't support msi packages.
#
FROM mcr.microsoft.com/windows/servercore:ltsc2022 as installer
WORKDIR /setup
COPY bin/vc_redist.x64.exe C:/setup/vc_redist.x64.exe
RUN C:/setup/vc_redist.x64.exe /install /quiet /norestart && \
	mkdir redist && \
	copy "C:\Windows\System32\concrt140.dll" "C:\setup\redist" && \
	copy "C:\Windows\System32\msvcp140.dll" "C:\setup\redist" && \
	copy "C:\Windows\System32\msvcp140_1.dll" "C:\setup\redist" && \
	copy "C:\Windows\System32\msvcp140_2.dll" "C:\setup\redist" && \
	copy "C:\Windows\System32\msvcp140_atomic_wait.dll" "C:\setup\redist" && \
	copy "C:\Windows\System32\msvcp140_codecvt_ids.dll" "C:\setup\redist" && \
	copy "C:\Windows\System32\vccorlib140.dll" "C:\setup\redist" && \
	copy "C:\Windows\System32\vcruntime140.dll" "C:\setup\redist" && \
	copy "C:\Windows\System32\vcruntime140_1.dll" "C:\setup\redist" && \
	copy "C:\Windows\System32\taskkill.exe" "C:\setup\redist"

#
# Start the window nanoserver release build.
#
FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

#
# Copy vc_redist.x64 and taskkill from servercore.
#
COPY --from=installer C:/setup/redist/ C:/Windows/System32/

# 
# Add the acc-server-manager and accServer executables and required files.
#
WORKDIR C:/acc-server
COPY bin/image/ C:/acc-server/

#
# Start the Server via a runtime entrypoint script.
#
ENTRYPOINT [ "acc-server-manager.exe" ]
CMD [ "-config", "config\\config.yml", "-license", "config\\OSM.License" ]
