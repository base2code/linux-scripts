
# Linux Scripts

A list of useful linux scripts with interactive selection script


## Usage/Examples

### Using a short URL
```bash
bash <(curl -sSL scripts.base2code.de)
```

### Using the GitHub URL
```bash
bash <(curl -sSL https://raw.githubusercontent.com/base2code/linux-scripts/main/main.sh)
```

## Dependencies

The script uses `curl` and `jq`.

### Debian / Ubuntu (apt)
```bash
sudo apt-get install curl jq -y
```

### Yum
```bash
sudo yum install epel-release -y
sudo yum install curl jq -y
```

<!---## Telemetry

This script collects telemetry data. The following data is being transmitted:
- Used script name
- The output of `lsb_release -a` 

To disable telemetry simply run
```bash
export DO_NOT_TRACK=1
```
[Console Do Not Track](https://consoledonottrack.com)
--->

## Contributing

Contributions are always welcome!

To contribue please open a PR and add a script in `scripts/`.

File Structure:
```bash
#!/bin/sh (interpreter)
#This is a demo script (description - one line)

(your script)
``` 


## Authors

- [@base2code](https://www.github.com/base2code)

