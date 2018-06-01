FROM bitwalker/alpine-elixir:1.5 as build
COPY . .
RUN export MIX_ENV=prod && \
    rm -Rf _build && \
    mix deps.get && \
    mix release