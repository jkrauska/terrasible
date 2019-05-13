FROM debian:stable
ENV TERRAFORM_VERSION 0.11.13
ENV TERRAFORM_URL https://releases.hashicorp.com/terraform
ENV TERRAFORM_SHA256 5925cd4d81e7d8f42a0054df2aafd66e2ab7408dbed2bd748f0022cfe592f8d2
# eg https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip

ENV ANSIBLE_VERSION 2.7.10-1ppa~trusty

## TERRAFORM
RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends ca-certificates wget unzip \
    && mkdir /terraform \
    && cd /terraform \
    && wget -q -O terraform.zip ${TERRAFORM_URL}/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && echo "$TERRAFORM_SHA256 terraform.zip" | sha256sum -c \
    && unzip terraform.zip -d /bin/ \
    && rm terraform.zip \
    && cd .. \
    && rmdir terraform

## ANSIBLE 
RUN apt-get -qq install -y gnupg2 \
    && echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" > /etc/apt/sources.list.d/ansible.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 \
    && apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends ansible=${ANSIBLE_VERSION}
