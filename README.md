# dor-rocfl-experiment
An experiment using [rocfl](https://github.com/pwinckles/rocfl?tab=readme-ov-file) to manipulate [OCFL](https://ocfl.io/) to implement Digital Object Repository (DOR) functionality and utilities.

## Dockerfile
The `Dockerfile` uses the [mlibrary rocfl package](https://github.com/mlibrary/rocfl/pkgs/container/rocfl%2Frocfl) as the base image. This is an image built from the [mlibrary fork of rocfl](https://github.com/mlibrary/rocfl) allowing a layer of indirection for custom code changes and bug fixes that have been pushed up stream but not yet merged. (See [README-UMICH.md](https://github.com/mlibrary/rocfl/blob/umich/README-UMICH.md) for additional information.)
```
FROM ghcr.io/mlibrary/rocfl/rocfl:latest AS base
```
You'll need to be log in to `ghcr.io` from docker inorder to build the image locally.
```
docker login ghcr.io --username <GitHub username> --password <GitHub token  a.k.a. ghp_...>
```

## Docker Compose
The `Dockerfile` creates the `app` user whose home directory is `/app` and is mapped to the local project directory in `compose.yaml`.
```
docker compose up -d
docker compose exec -- app bash
rocfl help
```
Visit [rocfl](https://github.com/pwinckles/rocfl?tab=readme-ov-file) for a quick start guide to `rocfl`.

## Repos Volume
The `compose.yaml` attaches a volume to the `/repos` directory so any repositories created there will persist between the ups and downs of Docker development.

### Default Repository
The following command will create the default repository
```
rocfl init
```
with storage root `/repos/default/storage` and staging root `/repos/default/staging` see the `~/.config/rocfl/config.toml` configuration file for additional settings.

### Fixtures Repositories
The [OCFL Test Fixtures](https://github.com/OCFL/fixtures) repository is cloned to the `/repos/fixtures` in the `Dockerfile`. Version files `0=ocfl_1.0` and `0=ocfl_1.1`  are copied to `/repos/fixtures/1.0/good-objects` and `/repos/fixtures/1.1/good-objects` respectively. Repo-names `fix-1_0` and `fix-1_1` are define in the configuration file `~/.config/rocfl/config.toml` and can be used to simplify the command options when working with these repos.

For example:
```
rocfl -name fix-1_0 validate
```
and
```
rocfl -n fix-1_1 ls
```

