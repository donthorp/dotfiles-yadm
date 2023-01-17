FROM ubuntu:jammy as installer

RUN apt update \
  && apt upgrade -y \
  && apt install -y curl unzip \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install --bin-dir /aws-cli-bin

FROM ubuntu:jammy
RUN apt update \
  && apt upgrade -y \
  && apt install -y less groff \
  && apt autoremove \
  && adduser awsuser -q
COPY --from=installer /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=installer /aws-cli-bin/ /usr/local/bin/
USER awsuser:awsuser
WORKDIR /aws
ENTRYPOINT ["/usr/local/bin/aws"]

