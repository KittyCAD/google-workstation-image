FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest AS code-oss-image

FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/clion:latest

# Copy Code OSS for Cloud Workstations and startup scripts into our custom image
COPY --from=code-oss-image /opt/code-oss /opt/code-oss
COPY --from=code-oss-image /etc/workstation-startup.d/110_start-code-oss.sh /etc/workstation-startup.d/110_start-code-oss.sh

# Copy and execute the custom setup script as root
COPY script.sh /tmp/script.sh
RUN bash /tmp/script.sh

# Use the existing entrypoint script which will execute all scripts in /etc/workstation-startup.d/
ENTRYPOINT ["/google/scripts/entrypoint.sh"]