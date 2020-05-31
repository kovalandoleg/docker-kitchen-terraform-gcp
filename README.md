# docker-kitchen-terraform-gcp

Docker file includes:

  - google cloud sdk v.294.0.0
  - terraform v.0.12.26
  - kitchen-terraform v.4.9.0

To build new image use this command with appropriate new versions of the programs.
If you want to update kitchen-terraform you should cahnge it version in `Gemfile`.

```sh
docker build \
    --build-arg CLOUD_SDK_VERSION=294.0.0 \
    --build-arg TERRAFORM_VERSION=0.12.26 \
    --tag kitchen-terraform-gcp:1.0 \
    --tag kitchen-terraform-gcp:latest .

docker tag kitchen-terraform-gcp:latest user_name/docker_hub_repo_name:latest
docker push user_name/docker_hub_repo_name:latest
```
