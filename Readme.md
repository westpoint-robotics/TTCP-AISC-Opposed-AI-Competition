# TTCP AISC Opposed AI Competition

A guide to participation.

## Overview

## Concept

This competition involves participants integrating behaviors
into the moos-ivp-aquatics simulator.

The aquaticus simulator is available as a docker image and that docker
image will be used to execute participant submissions during the competition.

It is most efficient to build from one of these base images:
```
docker pull westpointrobotics/aquaticus:jammy
docker pull westpointrobotics/aquaticus:focal
docker pull westpointrobotics/aquaticus:bionic
```
## Docker

Docker tutorial is out of scope for this document.  But a quick note -- 
if you skipped the [post-installation tasks](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user),
you'll likely need to use `sudo` for any docker commands.

## Submissions

Participants can submit competition entries as docker images at  the 
aquaticus.azurecr.io docker registry.
Credentials are available from the competition director.
Your credentials are tied to the `aquaticus.azurecr.io/teamname/aquaticus` repository.
To make multiple submissions, submit different tags (i.e. v1, v2, etc.).

```
docker login aquaticus.azurecr.io
  Username: teamname
  Password: ******** (token received from competition director)

docker tag my_dev_image aquaticus.azurecr.io/teamname/aquaticus:v1
docker push aquaticus.azurecr.io/teamname/aquaticus:v1
```

Ideally, each submission should launch on container start, with the ability to
modify command line arguments.  See the commented out portion at the end of this
repo's Dockerfile.

## Test submission

In order to test the submission process, push a hello-world image to the submission registry.

The password token for testing is shared among all participants; add a unique tag to your 
hello-world image so competition admins can see who has tested successfully.

```bash
docker pull hello-world

docker tag hello-world aquaticus.azurecr.io/test/hello-world:teamname

docker login
  Username: aquaticus-test
  Password: ********* (published by competition director)

docker push aquaticus.azurecr.io/test/hello-world:teamname
```

## Details

- X11 in container

    To display the application user interface, you need to bridge X Server between
    the container and the host.

    The simplest means is to run your container on the host network.
    ```bash
    docker run --rm -it --net host ...
    ```

    You may also need to address X authentication. Running `xhost +` on your host
    works; though it is insecure and not a best practice, it is often practical for
    development work.

    For more sophisticated auth, use an xauth approach.
