# First, Register and Download Server Config File from the URL:
  - https://accounts.klei.com/account/game/config?game=DontStarveTogether

# Then, Unzip and copy the Content within MyDediServer To cluster-content
  - cluster-content/cluster_token.txt is gitignored, thus it is not present in the example.

# TO RUN
docker-compose up

# TO REBUILD
docker-compose build

# TO MANAGE MOD
## modify the following files(make sure the 2 files are identical):
  - cluster-content/Master/modoverrides.lua
  - cluster-content/Caves/modoverrides.lua 
