FROM python:slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends libgomp1 wget curl sudo \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

WORKDIR /opt/rkllama

COPY ./lib /opt/rkllama/lib
COPY ./src /opt/rkllama/src
COPY requirements.txt README.md LICENSE *.sh *.py /opt/rkllama/
RUN chmod +x setup.sh && ./setup.sh --no-conda

EXPOSE 8080

#CMD ["/usr/local/bin/rkllama", "serve", "--no-conda", "port"] if you want to change the port.
#example: CMD ["/usr/local/bin/rkllama", "serve", "--no-conda", "3000"]
CMD ["/usr/local/bin/rkllama", "serve", "--no-conda"]
