# benchmark

Benchmark your computer by running `pigz` parallel compression on multiple CPU threads, from 1 to the total number of CPU cores on your system.

# Setup

Clone this repo:

```
git clone https://github.com/stevekm/benchmark.git
cd benchmark
```

Setup data and software

```
make setup
```

Run

```
make run
```

# Software

- designed for Mac and Linux
- requires `wget`, `bzip2`, `dd`
