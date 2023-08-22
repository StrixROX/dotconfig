# dotconfig
Repo for all my Linux config files.

# Usage
1. Clone this repo and `cd` inside it.
```bash
git clone https://github.com/StrixROX/dotconfig.git
cd dotconfig
```
2. Make `setup.sh` executable.
```bash
chmod +x setup.sh
```
3. Run `setup.sh`.
```bash
./setup.sh
```
4. Follow the prompts!

# Dual-booting with Windows (Tips)
- If suffering from time synchronization problems after dual booting Linux and Windows, create a task in Windows Task Scheduler that runs [this batch script](https://gist.github.com/StrixROX/20ccc781fdd926e6fad43d94dc492c81) on startup before login. Contents of the batch script are shown below:
```batch
w32tm /resync /nowait
```
