# Claude Code Docker Image

A Docker image for running the Claude Code CLI in an isolated container based on Node.js (Alpine).</br>
The process inside the container runs as a non-root user, while the current working directory
and the `~/.claude` config are mounted from the host as volumes.

Build
```bash
$ ./build.sh
```

Setup Token
```bash
docker run -it --rm hardeneduser/claude-code:latest setup-token
```

Run
```bash
$ cp claude.sh ~/bin/claude
$ chmod +x ~/bin/claude

$ cd ~/foo/bar/project
$ claude
```
