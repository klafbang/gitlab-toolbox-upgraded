# GitLab Toolbox Upgraded

A custom GitLab toolbox Docker image with upgraded PostgreSQL client tools.

## Overview

This repository provides a custom GitLab toolbox image based on the official GitLab toolbox CE image, but with upgraded PostgreSQL client tools to version 17. This is particularly useful for GitLab instances that need to work with newer PostgreSQL databases or require the latest PostgreSQL features and improvements.

## Features

- **Base Image**: GitLab Toolbox EE v18.11.3
- **PostgreSQL Client**: Upgraded to PostgreSQL 18 (from default version 17)
- **Compatibility**: Maintains full compatibility with GitLab toolbox functionality
- **Clean Installation**: Properly removes old PostgreSQL client before installing the new version

## What's Included

- PostgreSQL 18 client tools (`psql`, `pg_dump`, `pg_restore`, etc.)
- All standard GitLab toolbox utilities and scripts
- Official PostgreSQL APT repository for reliable updates

## Build Instructions

### Prerequisites

- Docker installed on your system
- Access to GitLab container registry (or adjust base image as needed)

### Building the Image

```bash
# Clone this repository
git clone <your-repo-url>
cd gitlab-toolbox-upgraded

# Build the Docker image
docker build -t gitlab-toolbox-upgraded:latest .

# Optional: Tag with specific version
docker build -t gitlab-toolbox-upgraded:v18.1.2-pg17 .
```

## Usage

### Basic Usage

Use this image as a drop-in replacement for the standard GitLab toolbox:

```bash
docker run -it --rm gitlab-toolbox-upgraded:latest /bin/bash
```

### With GitLab Helm Chart

If you're using GitLab Helm charts, you can specify this custom image in your values file:

```yaml
gitlab:
  toolbox:
    image:
      repository: your-registry/gitlab-toolbox-upgraded
      tag: latest
```

### Database Operations

The upgraded PostgreSQL client tools allow you to work with PostgreSQL 17 databases:

```bash
# Connect to PostgreSQL 17 database
psql -h your-db-host -U username -d database_name

# Perform database backup
pg_dump -h your-db-host -U username database_name > backup.sql

# Restore database
pg_restore -h your-db-host -U username -d database_name backup.dump
```

## Version Information

- **GitLab Toolbox**: v18.11.3
- **PostgreSQL Client**: 18.x (latest from official PostgreSQL APT repository)
- **Base OS**: Debian-based (inherited from GitLab toolbox image)

## Dockerfile Details

The Dockerfile performs the following operations:

1. Starts from the official GitLab toolbox EE image
2. Switches to root user for package management
3. Adds the official PostgreSQL APT repository
4. Removes the existing PostgreSQL client (version 16)
5. Installs PostgreSQL 18 client tools
6. Cleans up package cache to reduce image size
7. Reverts to the original `git` user
8. Maintains the original entrypoint

## Contributing

Feel free to submit issues and pull requests to improve this image:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the build
5. Submit a pull request

## License

This project follows the same licensing as the base GitLab toolbox image. Please refer to GitLab's licensing terms for more information.

## Troubleshooting

### Common Issues

**PostgreSQL connection issues**: Ensure your database server is compatible with PostgreSQL 17 client tools. While the client is backward compatible, some features might not be available when connecting to older servers.

**Build failures**: Make sure you have access to the GitLab container registry and the PostgreSQL APT repository is accessible from your build environment.

### Support

For GitLab-specific issues, refer to the [official GitLab documentation](https://docs.gitlab.com/).
For PostgreSQL-related questions, check the [PostgreSQL documentation](https://www.postgresql.org/docs/).

## Changelog

- **v1.0**: Initial version with PostgreSQL 17 client tools upgrade based on GitLab toolbox CE v18.1.2
