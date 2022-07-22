FROM gitpod/workspace-full

USER gitpod

# Install LaTeX, free fonts, emerald font and Starship
RUN sudo apt-get -q update \
 && sudo apt-get install -yq texlive-latex-extra  \
 && wget -q https://www.tug.org/fonts/getnonfreefonts/install-getnonfreefonts \
 && sudo texlua ./install-getnonfreefonts \
 && getnonfreefonts --user --all \
 && curl -fsSL https://starship.rs/install.sh | sh -s -- --yes
 