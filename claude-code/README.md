# Claude Code Docker Image

A Docker image for running the Claude Code CLI in an isolated container based on Node.js (Alpine).
The process inside the container runs as a non-root user, while the current working directory
and the `~/.claude` config are mounted from the host as volumes.

Build
```
$ ./build.sh
```

Run
```bash
$ cp claude.sh ~/bin/claude
$ chmod +x ~/bin/claude

$ cd ~/foo/bar/project
$ claude
```
