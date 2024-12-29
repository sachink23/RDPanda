# RDPanda - Ubuntu KDE Plasma with xRDP in Docker

RDPanda is a Dockerized project that runs **Ubuntu 24.04** with **KDE Plasma Desktop** and **xRDP**, allowing you to access a full remote desktop environment using RDP clients.

---

## Features

- **KDE Plasma Desktop**: A modern, feature-rich desktop environment.
- **xRDP Integration**: Connect to your container via any RDP client.
- **Dynamic User Setup**: Configure username and password at runtime.
- **Containerized Environment**: Fully encapsulated in Docker for portability and ease of deployment.

---

## Getting Started

### Prerequisites
- Docker installed on your system.
- An RDP client (e.g., Windows Remote Desktop, FreeRDP, Remmina).

---

### Build the Docker Image

Clone this repository and build the Docker image:
```bash
# Clone the repo
git clone https://github.com/sachink23/rdpanda.git
cd rdpanda

# Build the Docker image
docker build -t rdpanda .
```

---

### Run the Container

You can pass the `USERNAME` and `PASSWORD` environment variables to configure the user dynamically. Defaults are `user` and `password`.

#### Example:
```bash
# Run with custom username and password
docker run -e USERNAME=myuser -e PASSWORD=mypassword -p 3389:3389 rdpanda
```

This will:
1. Create a new user if it doesn’t exist.
2. Start the xRDP service and KDE Plasma Desktop.
3. Expose port 3389 for RDP connections.

---

## Connecting via RDP

1. Use an RDP client (e.g., Windows Remote Desktop).
2. Connect to the host's IP address on port `3389`.
3. Log in using the username and password you set (or default `user:password`).

---

## Debugging Tips

- **Check Logs**:
  ```bash
  tail -f /var/log/xrdp-sesman.log
  tail -f ~/.xsession-errors
  ```

---

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests to improve RDPanda.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Credits

Inspired by the need for a lightweight, containerized remote desktop environment with KDE Plasma. Special thanks to the developers of xRDP, KDE Plasma, and the Docker community!

