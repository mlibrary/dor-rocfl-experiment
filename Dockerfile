FROM ubuntu AS base

ARG UNAME=app
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} ${UNAME}
RUN useradd -m -d /${UNAME} -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}
ENV PATH="/${UNAME}/bin:${PATH}"
WORKDIR /${UNAME}

FROM base as fixtures

RUN apt update; \
apt install -y --no-install-recommends \
  ca-certificates \
  git

RUN git clone https://github.com/OCFL/fixtures.git

COPY "versions/0=ocfl_1.0" /${UNAME}/fixtures/1.0/good-objects
COPY "versions/0=ocfl_1.1" /${UNAME}/fixtures/1.1/good-objects

FROM base as development

COPY . .
RUN chown -R ${UID}:${GID} /${UNAME}

RUN mkdir /repos
COPY --from=fixtures /${UNAME}/fixtures /repos/fixtures
RUN chown -R ${UID}:${GID} /repos

USER ${UNAME}
CMD ["sleep", "infinity"]
