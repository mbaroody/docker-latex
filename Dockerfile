FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install --yes texlive-full evince

# https://github.com/moby/moby/issues/1554
# RUN echo " \n\
# \$pdf_previewer     = 'start evince'; \n\
# \$pdf_update_method = 1; \n\
# " > /etc/LatexMk

ADD awesome-cv.cls /usr/local/texlive/texmf-local/
RUN texhash

RUN groupadd latex
RUN useradd --create-home --gid latex --shell /bin/bash latex

USER latex:latex
WORKDIR /home/latex

ENTRYPOINT [ "/usr/bin/latexmk", "-xelatex", "-pvc", "-pdf" ]
