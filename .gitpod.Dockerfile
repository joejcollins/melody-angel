FROM rocker/rstudio:latest

# Also install python and Cairo (which is used by the ‘httpgd’ R package).
RUN sudo apt -q update \
 && sudo apt install --assume-yes python3.10-venv \
 && sudo apt install --assume-yes libcairo2-dev
