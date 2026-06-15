# Containers & Virtualization

Container runtimes, virtual machines, and reproducible-environment tools.

## Optional

- Docker
  - Ubuntu

    *Set up the repository: Set up the Docker CE repository on Ubuntu. The lsb_release -cs sub-command prints the name of your Ubuntu version, like xenial or trusty.*

    ```plaintext
    sudo apt-get -y install \
      apt-transport-https \
      ca-certificates \
      curl
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
           "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
           $(lsb_release -cs) \
           stable"
    sudo apt-get update
    ```

    *Get Docker CE: Install the latest version of Docker CE on Ubuntu.*

    ```plaintext
    sudo apt-get -y install docker-ce
    ```

    *Test your Docker CE installation: Test your installation.*

    ```plaintext
    sudo docker run hello-world
    ```

    [Reference1](https://store.docker.com/editions/community/docker-ce-server-ubuntu?tab=description), [Reference2](https://askubuntu.com/questions/909691/how-to-install-docker-on-ubuntu-17-04)

- <https://orbstack.dev/>
- [VirtualBox](https://www.virtualbox.org)
- [Nix](https://nixos.org/learn/)
