FROM ubuntu:24.04

LABEL version="0.1" \
      name="RDPanda" \
      description="Dockerized project that runs Ubuntu 24.04 with KDE Plasma Desktop and xRDP" \
      org.opencontainers.image.authors="sachin@kekarjawalekar.com" \
      org.opencontainers.image.source="https://github.com/sachink23/RDPanda" \
      org.opencontainers.image.documentation="https://github.com/sachink23/RDPanda/blob/master/README.md"

# Install xRDP server, and required tools
RUN apt update && apt install -y xrdp dbus-x11 kde-plasma-desktop sudo

# Enable the RDP daemon
RUN service xrdp start

# Set up XRDP
RUN mv /etc/xrdp/startwm.sh /etc/xrdp/startwm.sh.orig && \
    echo "dbus-launch --exit-with-session startplasma-x11" >> /etc/xrdp/startwm.sh && \
    chmod 755 /etc/xrdp/startwm.sh && \
    echo 'allowed_users=anybody' | tee -a /etc/X11/Xwrapper.config && \
    echo 'needs_root_rights=no' | tee -a /etc/X11/Xwrapper.config && \
    service xrdp restart

# Expose RDP port
EXPOSE 3389

# Add a custom entrypoint to handle user setup dynamically at runtime
ENTRYPOINT ["/bin/bash", "-c", "\
    if ! id -u ${USERNAME:-user} > /dev/null 2>&1; then \
        useradd -m -s /bin/bash ${USERNAME:-user} && \
        echo \"${USERNAME:-user}:${PASSWORD:-password}\" | chpasswd && \
        adduser ${USERNAME:-user} sudo; \
    fi && \
    service xrdp restart && \
    tail -f /var/log/xrdp-sesman.log"]
