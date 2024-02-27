# COMP6255 (Advanced Programming Language Concepts) Devcontainer

Docker container for the [COMP6255 module](https://www.southampton.ac.uk/courses/modules/comp6255).
The container can be used for any development via Visual Studio Code.
The container configuration will automatically install the necessary extensions and configure editor settings.

## Setup
1) [Install Docker](https://www.docker.com/get-started/). I highly recommend [Orbstack](http://orbstack.dev/) for MacOS users as it currently uses fewer resources.
2) Make sure Docker/Orbstack is running
3) [Install Visual Studio Code](https://code.visualstudio.com/Download)
4) [Install Remote - Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
5) Copy the `.devcontainer` folder to the root of your project folder

After following the above instructions open your project in Visual Studio Code and run the `Remote-Containers: Reopen in Container` command.
If the instructions are followed correctly Visual Studio Code should also automatically suggest opening the repository in container mode when the project is loaded.

## System requirements
See [here](https://code.visualstudio.com/docs/remote/containers#_system-requirements)

## Known problems
### VSCode shows `Docker returned an error`
Make sure that Docker is installed and running.

### The `Remote-Containers: Reopen in Container` command is not recoqnized by VSCode
You need to have the Remote - Containers extension VSCode extension installed and enabled.
See [here](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for instructions on how to install it.

### Running `Remote-Containers: Reopen in Container` cannot find container
Make sure you copied the `.devcontainer` folder to your projects root folder and that it includes the `devcontainer.json` file.

### `Cannot find a physical path bound to logical path X with prefix Y` when importing file
* Make sure that the Coq files have been compiled. Run `make` to compile the project files.
* If the `_CoqProject` files is not located in the project root folder you need to either
  * Move the files to the root project folder
  * Or add the line `"coq.coqProjectRoot": "PATH_TO_COQPROJECT"` (in `.devcontainer/devcontainer.json` to point to the directory where `_CoqProject` is located. Restarting the docker container is required after this step.


## FAQ
### What is included in the Docker image?
The Docker image used for the devcontainer is built using the [Dockerfile](Dockerfile) in this repository and hosted on the GitHub Container registry. It is based on the [coqorg/coq:8.17.1-ocaml-4.14.1-flambda](https://hub.docker.com/layers/coqorg/coq/8.17.1-ocaml-4.14.1-flambda/images/sha256-23ef0a78b3e0d75f4e6ee70846afef296bf27d090644eafb7ea7ca46b6438584?context=explore) image, which includes the following:
* Debian 11 Slim
* opam 2.1.3
* OCaml 4.14.1
* Coq 8.17.1

# Credits

Inspired by:
* https://github.com/bcpierce00/au-fsv23/
* https://docs.github.com/en/actions/publishing-packages/publishing-docker-images#publishing-images-to-github-packages
