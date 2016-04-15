#FROM ubuntu:12.04
FROM ubuntu:latest

ENV AWS_REGION ap-northeast-1

RUN apt-get update && apt-get install -y curl python python-pip \
        && rm -rf /var/lib/apt/lists/*
COPY awslogs.conf ./

RUN curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
RUN chmod +x ./awslogs-agent-setup.py
RUN ./awslogs-agent-setup.py --non-interactive --region ${AWS_REGION} --configfile ./awslogs.conf


RUN apt-get purge curl -y

RUN mkdir /var/log/awslogs
WORKDIR /var/log/awslogs

CMD /bin/sh /var/awslogs/bin/awslogs-agent-launcher.sh
