# OpenCode Docker Image

A Docker image for running the OpenCode CLI in an isolated container based on Alpine.</br>
The process inside the container runs as a non-root user, while the current working directory
and the `~/.opencode` config are mounted from the host as volumes.

Build
```bash
$ ./build.sh
```

Setup
```bash
$ mkdir ~/.opencode/config ~/.opencode/share ~/.opencode/tmp
$ cp opencode.sh ~/bin/opencode
$ chmod +x ~/bin/opencode
```

Run
```bash
$ cd ~/foo/bar/project
$ opencode
```
