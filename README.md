# dor-rocfl-experiment
An experiment using [rocfl](https://github.com/pwinckles/rocfl?tab=readme-ov-file) to manipulate [OCFL](https://ocfl.io/) to implement Digital Object Repository (DOR)

## Docker Compose
The `Dockerfile` creates the `app` user whose home directory is `/app` and is mapped to the local project directory in `compose.yaml`.
```
docker compose up -d
docker compose exec -- app bash
rocfl help
```

## Default Repository
The following command will create the default repository
```
rocfl init
```
with storage root `/var/tmp/repos/default/storage` and staging root `/var/tmp/repos/default/staging` see the `~/.config/rocfl/config.toml` configuration file for additional settings.

Visit [rocfl](https://github.com/pwinckles/rocfl?tab=readme-ov-file) for a quick start guide to `rocfl`.
