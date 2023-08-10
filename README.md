# docker-markdownlint

[![Build Status](https://app.travis-ci.com/PeterDaveHello/docker-markdownlint.svg?branch=master)](https://app.travis-ci.com/PeterDaveHello/docker-markdownlint)
[![Docker Hub pulls](https://img.shields.io/docker/pulls/peterdavehello/markdownlint.svg)](https://hub.docker.com/r/peterdavehello/markdownlint/)

[![Docker Hub badge](http://dockeri.co/image/peterdavehello/markdownlint)](https://hub.docker.com/r/peterdavehello/markdownlint/)

Dockerized [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli) with various versions, easy to use and easy to integrate with CI.

## Table of Contents

- [Usage](#usage)
  - [Command line](#command-line)
    - [Use the latest version](#use-the-latest-version)
    - [Use specific version](#use-specific-version)
  - [Continuous Integration (CI)](#continuous-integration-ci)
    - [Travis CI](#travis-ci)
    - [GitLab CI](#gitlab-ci)
- [markdownlint cli usage](#markdownlint-cli-usage)
- [Build](#build)

## Usage

### Command line

#### Use the latest version

Without speicifying a image tag, the `latest` tag will be used as the latest version of markdownlint-cli:

```sh
docker run -v $PWD:/md peterdavehello/markdownlint markdownlint .
```

- Replace `$PWD` with path of markdown files, `$PWD` means the current working directory.
- If you don't want to scan all the markdown files recursively, replace `.` with the specify the file path and name.

#### Use specific version

Just like above, but specify a version tag of markdownlint-cli, for example, `0.35.0`:

```sh
docker run -v $PWD:/md peterdavehello/markdownlint:0.35.0 markdownlint .
```

### Continuous Integration (CI)

#### Travis CI

Enable Docker service in your `.travis.yml`:

```yaml
services:
  - docker
```

And use the same command in the `scripts` part as the command line mentions, for example:

```yaml
services:
  - docker

scripts:
  - docker run -v $TRAVIS_BUILD_DIR:/md peterdavehello/markdownlint:0.35.0 markdownlint example.md
```

This will lint a example markdown file called `example.md`

#### GitLab CI

Add this block to your `.gitlab-ci.yml`:

```yaml
markdownlint:
  stage: lint
  variables:
    markdownlint_cli_version: "0.35.0"
  image: peterdavehello/markdownlint:$markdownlint_cli_version
  only:
    changes:
      - "**/*.md"
      - "**/*.markdown"
  script:
    - markdownlint .
```

## markdownlint cli usage

Just pass `-h`/`--help` to markdownlint to get its help message, for example:

- `docker run peterdavehello/markdownlint markdownlint --help`

You'll get the output like below:

```text
  Usage: markdownlint [options] <files|directories|globs>

  MarkdownLint Command Line Interface

  Options:
    -V, --version                               output the version number
    -c, --config [configFile]                   configuration file (JSON, JSONC, JS, or YAML)
    -d, --dot                                   include files/folders with a dot (for example `.github`)
    -f, --fix                                   fix basic errors (does not work with STDIN)
    -i, --ignore [file|directory|glob]          file(s) to ignore/exclude (default: [])
    -j, --json                                  write issues in json format
    -o, --output [outputFile]                   write issues to file (no console)
    -p, --ignore-path [file]                    path to file with ignore pattern(s)
    -q, --quiet                                 do not write issues to STDOUT
    -r, --rules  [file|directory|glob|package]  include custom rule files (default: [])
    -s, --stdin                                 read from STDIN (does not work with files)
    --enable [rules...]                         Enable certain rules, e.g. --enable MD013 MD041 --
    --disable [rules...]                        Disable certain rules, e.g. --disable MD013 MD041 --
    -h, --help                                  display help for command
```

For more details, check out the [markdownlint-cli project](https://www.npmjs.com/package/markdownlint-cli) page.

## Build

Build command, you need to specify a valid markdownlint version argument to `MARKDOWNLINT_CLI_VER`:

```sh
docker build --build-arg MARKDOWNLINT_CLI_VER="0.35.0" -t docker-markdownlint .

# Replace "docker-markdownlint" with the preferred image name
```

You can find a valid version on [markdownlint-cli](https://www.npmjs.com/package/markdownlint-cli?activeTab=versions) npm registry page, or just poke the [registry](https://registry.npmjs.org/markdownlint-cli) to retrieve more details.
