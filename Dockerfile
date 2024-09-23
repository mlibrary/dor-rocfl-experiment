FROM ubuntu AS base

ARG UNAME=app
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} ${UNAME}
RUN useradd -m -d /${UNAME} -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}

ENV PATH="/${UNAME}/bin:${PATH}"
WORKDIR /${UNAME}

FROM base as development

COPY . .
RUN chown -R ${UID}:${GID} /${UNAME}
USER ${UNAME}
CMD ["sleep", "infinity"]
