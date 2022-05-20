# TTCP AISC Opposed AI Competition

A guide to participation.

## Overview

## Concept

This competition involves participants integrating behaviors
into the moos-ivp-aquatics simulator.

The aquaticus simulator is available as a docker image and that docker
image will be used to execute participant submissions during the competition.

```
docker pull westpointrobotics/aquaticus:latest
```

## Submissions

Participants can submit competition entries as docker images at ttcp_aisc.azurecr.io.
Credentials are available from the competition director.

```
docker login ttcp_aisc.azurecr.io
docker push pariticipant:v1
```

## Details

- x11 in container