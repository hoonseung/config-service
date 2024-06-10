FROM ubuntu:latest
LABEL authors="lsh"

ENTRYPOINT ["top", "-b"]