# syntax=docker/dockerfile:1
FROM ruby:3.4.2-slim AS base

WORKDIR /rails

# Install system dependencies.
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    curl \
    sqlite3 \
    libsqlite3-dev \
    libpq-dev \
    build-essential \
    git \
    libssl-dev \
    zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js, Yarn, etc.
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install --global yarn && \
    corepack enable

# Set environment variables for production.
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle"

# --- Build Stage ---
FROM base AS build

# Copy Gemfiles first.
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/cache

# Copy application code.
COPY . .

# Ensure JavaScript dependencies.
RUN corepack enable && yarn install --immutable

# Precompile assets (dummy key provided; real master key comes from secret in production).
RUN SECRET_KEY_BASE=dummy ./bin/rails assets:precompile

# --- Final Image ---
FROM base

# Copy built gems and application code.
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Create a non-root user.
RUN groupadd --system deployer && \
    useradd -r -g deployer deployer && \
    chown -R deployer:deployer /rails

USER deployer

# Expose the port (ensure it matches what your Rails server expects).
EXPOSE 80

# Entry point – adjust as needed.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Default command to start the Rails server via Kamal (or your proxy).
CMD ["./bin/thrust", "./bin/rails", "server"]