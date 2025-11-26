# Kinnexus Test Kit

A comprehensive [Inferno](https://inferno-framework.github.io/) test kit for validating FHIR Implementation Guide (IG) compliance for Kinnexus.

## Overview

Kinnexus Test Kit provides automated conformance testing for FHIR servers implementing the Kinnexus IG specification. Built on the Inferno testing framework, it helps ensure your FHIR implementation meets the required standards.

## Prerequisites

- Ruby 3.3.6 or higher
- Docker and Docker Compose
- Git

## Quick Start

### 1. Setup

Clone the repository and run the initial setup:

```bash
make setup
```

This will pull the necessary Docker images, build the project, and run database migrations.

### 2. Run the Tests

Start the Inferno server:

```bash
make run
```

The Inferno web interface will be available at `http://localhost` (or the configured port).

### 3. Run Test Suite using Web UI


## Development

### Generate Test Suites

To regenerate test suites from the FHIR IG:

```bash
# Using Docker
make generate

# Or locally (if you have Ruby installed)
make generate_local
```

### Code Quality

Run RuboCop linter:

```bash
# Check for issues
make rubocop

# Auto-fix issues
make rubocop-fix
```

Environment-specific configuration is available in:
- `.env.development` - Development settings
- `.env.test` - Test settings
- `.env.production` - Production settings

## Dependencies

Key dependencies include:
- [Inferno Core](https://github.com/inferno-framework/inferno-core) (>= 1.0.6)
- [SMART App Launch Test Kit](https://github.com/inferno-framework/smart-app-launch-test-kit) (>= 0.4.0)
- [TLS Test Kit](https://github.com/inferno-framework/tls-test-kit) (~> 0.2.0)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and linting: `make tests && make rubocop`
5. Submit a pull request

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
