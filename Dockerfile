FROM openapitools/openapi-diff:2.0.1

# The entrypoint needs only bash and java, both in the base image. It used to
# apt-get curl and jq (unused), which broke once Debian 11's security
# repository moved to archive.debian.org and returned 404.

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
