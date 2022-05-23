# BillyBucks WebMiner
WebMiner for the BillyBucks pool.

This repository contains the code necessary to operate the Web miner manager and the web miner javascript dependency.
The original documentation for the webminermanager repository that this has been forked from is included as OriginalREADME.md

The primary changes made to the codebase is to update the hashing algoritm to support the latest algorithm used by TurtleCoin (Chukwa V2) 
and also a change made to allow the Javascript miner to recognise the pause job used to throttle miners by the mining pool.

**This repository assumes you are running the WebMinerManager server on an Ubuntu 18.04 Operating Server**

# Prerequisites
- stall the .net dependencies
```
wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```
```
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-6.0
```

```
sudo apt-get install -y dotnet-runtime-5.0
```
# Build the Deployables and Run the Server
The in the server folder of the repository run 
> dotnet build -c Release

Then still in the server folder run with 
> dotnet run -c Release



