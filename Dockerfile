FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y bash fortune-mod cowsay netcat-openbsd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY wisecow.sh .

RUN chmod +x wisecow.sh

ENV PATH="/usr/games:${PATH}"

EXPOSE 4499

CMD ["bash", "./wisecow.sh"]
