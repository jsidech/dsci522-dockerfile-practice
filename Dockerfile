# Adapted from docker-uv-renv by Daniel Chen (MIT License)
# https://github.com/chendaniely/docker-uv-renv

# Start from Ubuntu Linux with R installed.
# Change 4.6.2 to the R version in your renv.lock.
FROM rocker/r-ver:4.6.1

# Install curl: renv downloads packages with it
RUN apt-get update && apt-get install --yes curl

# Work in the /workspace folder inside the image
WORKDIR /workspace

# Put the packages in /opt/renv/library (not in renv/library in /workspace)
RUN echo "RENV_PATHS_LIBRARY=/opt/renv/library" >> /usr/local/lib/R/etc/Renviron.site

# Copy the files renv needs to install your packages, and your script
COPY renv.lock .Rprofile hello.R ./
COPY renv/activate.R renv/

# Install the exact packages in renv.lock
RUN Rscript -e "renv::restore()" 
# Adapted from docker-uv-renv by Daniel Chen (MIT License)
