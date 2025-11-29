# Dockerfile - minimal TeX Live with explicit package installs
FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /opt

# tools needed for TeX Live installer and building
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    perl \
    xz-utils \
    ca-certificates \
    bzip2 \
    fontconfig \
    curl \
    unzip \
    make \
    ghostscript \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# copy profile then download & run TeX Live installer
COPY texlive.profile /opt/texlive.profile

RUN wget -qO tl-install.tar.gz "http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz" \
 && tar -xzf tl-install.tar.gz --strip-components=1 -C /opt \
 && rm tl-install.tar.gz

# run install-tl in non-interactive mode using our profile
RUN ./install-tl --profile=/opt/texlive.profile

ENV PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH
ENV MANPATH=/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH
ENV INFOPATH=/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH

# install common build helper and packages your resume uses
# (we'll list packages; the list below should be enough for your main.tex)
RUN tlmgr install \
    latexmk \
    geometry \
    titlesec \
    tabularx \
    array \
    xcolor \
    enumitem \
    fontawesome5 \
    amsmath \
    hyperref \
    eso-pic \
    calc \
    bookmark \
    lastpage \
    changepage \
    paracol \
    ifthen \
    needspace \
    iftex \
    lmodern \
    charter \
    fontspec || true

# Clean tlmgr caches to keep image smaller
RUN tlmgr conf texmf TEXMFHOME=/tmp && rm -rf /var/tmp/* /tmp/*

WORKDIR /work
CMD ["bash"]
