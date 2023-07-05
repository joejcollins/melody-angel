# Use the latest rocker image https://rocker-project.org/
FROM rocker/rstudio:4.3.1

# Also install python and Cairo (which is used by the ‘httpgd’ R package).
RUN sudo apt -q update \
 && sudo apt install --assume-yes python3.10-venv \
 && sudo apt install --assume-yes libcairo2-dev

# Add a codespace user for running in Codespaces
RUN sudo useradd codespace
