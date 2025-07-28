
<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->

<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <img src="https://kocity.xyz/img/icon.png" alt="Logo" width="80" />
</div>
<br />
<div align="center">
<h3 align="center">Knockout City Server - Docker</h3>

  <p align="center">
    An <b>Unofficial</b> Docker Image that allows running a Private Server of <a href="https://www.knockoutcity.com/">Knockout City</a>.
    <br />
    <br />
    <a href="https://github.com/kocxyz/ServerDocker/issues">Report Bug</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#prerequisite">Prerequisite</a></li>
    <li><a href="#downloading-the-game-data-files">Downloading the Game Data Files</a></li>
    <li>
      <a href="#usage">Usage</a>
      <ul>
        <li><a href="#environment-variables">Environment Variables</a></li>
      </ul>
    </li>
    <li><a href="#notes-on-data-folder-location">Notes on Data Folder Location</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

---
## Prerequisite

- [Docker](https://www.docker.com) (any version that supports [compose v2](https://docs.docker.com/compose/migrate/))
- A Steam account (credentials required to download the server files)
- Sufficient disk space for the game data and persistent containers

---
## Downloading the Game Data Files

**Before running your server, you must manually download the Knockout City game server files using SteamCMD in Docker.**  
This is a required one-time step; the container does **not** automatically download the game data.

### Download Command

Run the following command in your terminal (replace `<username>` and `<password>` with your Steam credentials):

```bash
docker run --rm -it -v ./data:/data steamcmd/steamcmd:latest +@sSteamCmdForcePlatformType windows +force_install_dir /data +login <username> <password> +app_update 2915930 +quit
```
-   This will download the game server files into the `./data` folder (relative to your current directory).
    
-   If you want to store the game data in a different directory (for example, to share it between multiple servers), simply change the path.  
    For example, to use `/opt/KnockOutCity/data` as your data directory:
```bash
docker run --rm -it -v /opt/KnockOutCity/data:/data steamcmd/steamcmd:latest +@sSteamCmdForcePlatformType windows +force_install_dir /data +login <username> <password> +app_update 2915930 +quit
```
**Do not use the /root directory (`/root`) as a mount point.**  
Some issues where seen where Wine doesn't like it.
Always use a dedicated folder (e.g., `/opt/KnockOutCity/data`).
## Usage
Copy the [`compose.yaml`](https://github.com/kocxyz/ServerDocker/blob/main/docker-compose.yml) and tweak it to your liking.

After downloading the game data and setting up your `compose.yaml`, you can start the server as follows:

```bash
docker compose up
```
### Environment Variables

For detailed information on the different parameters, please refer to the Knockout City Private Server README.

| **Name**                             | **Required** | **Description**                                                                     |
| ------------------------------------ | ------------ | ----------------------------------------------------------------------------------- |
| `KOC_BACKEND_MAX_PLAYER_CONNECTIONS` | No           | The maximum number of players that can be connected at the same time. *default*: 10 |
| `KOC_BACKEND_PORT`                   | No           | TCP port on which the online backend services listen. *default*: 23600              |
| `KOC_SERVER_MIN_PORT`                | No           | Start of UDP port range on which game servers will listen. *default*: 23600         |
| `KOC_SERVER_MAX_PORT`                | No           | End of UDP port range on which game servers will listen.*default*: 23699            |
| `KOC_SECRET`                         | No           | A password that, if specified, also needs to be passed to the KnockoutCity.exe      |
| `KOC_BACKEND_DB`                     | Yes          | PostgreSQL connection string to use a running PostgreSQL server.                    |
| `KOC_BACKEND_REDIS_DB_HOST`          | Yes          | Hostname of a running Redis Server.                                                 |
| `KOC_BACKEND_REDIS_DB_PORT`          | No           | Port of a running Redis Server.*default*: 6379                                      |

---
## Notes on Data Folder Location

- You **can** use the same game data folder for multiple server containers by mounting the same host directory (e.g., `/opt/KnockOutCity/data`) into each container.
- **You cannot use the root directory** (`/root`) as your data volume; always use a dedicated folder for your game data.
- This folder had some issues with Wine.
- If you wish to use different game data for separate servers, specify a different host folder for each one in your compose file.

**Example for a different data folder per server:**

```yaml
  server1:
    volumes:
      - /opt/KnockOutCity/server1-data:/data
  server2:
    volumes:
      - /opt/KnockOutCity/server2-data:/data
```
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".  
Don’t forget to give the project a star! Thanks again!

1. Fork the Project  
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)  
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)  
4. Push to the Branch (`git push origin feature/AmazingFeature`)  
5. Open a Pull Request  

---
