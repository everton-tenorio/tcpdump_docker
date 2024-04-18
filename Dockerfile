FROM ubuntu:latest

# Instalação de pacotes
RUN apt-get update && \
    apt-get install -y \
    tcpdump \
    curl \
    iputils-ping

# Manter o container em execução
CMD ["sleep", "infinity"]
