#!/bin/sh

sudo -nb /usr/local/bin/dind /usr/local/bin/dockerd --group vscode

exec "$@"