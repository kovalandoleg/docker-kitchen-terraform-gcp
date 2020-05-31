FROM ruby:2.6
ARG CLOUD_SDK_VERSION
ARG TERRAFORM_VERSION

ENV ZIP=terraform_${TERRAFORM_VERSION}_linux_amd64.zip
ENV URL=https://releases.hashicorp.com/terraform
ENV SA_KEY_FILE=master-sa.json

WORKDIR /workspace
COPY Gemfile entrypoint.sh ./

RUN apt-get -qqy update && apt-get install -qqy \
        curl \
        gcc \
        python-dev \
        python-setuptools \
        apt-transport-https \
        lsb-release \
        openssh-client \
        git \
        gnupg \
        unzip \
    && export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 && \
    rm -rf /var/lib/apt/lists/* && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    curl -s ${URL}/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o /tmp/${ZIP} && \
    unzip -o /tmp/$ZIP -d /tmp && \
    rm -f /tmp/$ZIP && \
    mv -f /tmp/terraform /bin && \
    bundle install

ENTRYPOINT ["/workspace/entrypoint.sh"]
CMD ["help"]