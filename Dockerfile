FROM elixir:latest
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install Hex package manager.
# By using `--force`, we don’t need to type “Y” to confirm the installation.
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get
# Compile the project.
RUN mix compile
RUN mix run

