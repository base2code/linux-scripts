#!/bin/sh

INDEX_URL="https://raw.githubusercontent.com/base2code/linux-scripts/main/index.json"
BASE_URL="https://raw.githubusercontent.com/base2code/linux-scripts/main/scripts/"


NUMBER_REGEX='^[0-9]+$'

# Check if jq (json serialization) is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found"
    exit
fi

# Check if curl ist installed
if ! command -v curl &> /dev/null
then
    echo "curl could not be found"
    exit
fi

# Download index.json
index=$(curl -sSL $INDEX_URL)
if ! [ $? -eq 0 ]; then
    echo "Could not download index"
    echo $index
    exit
fi

declare -a script_names
script_names=$(echo $index | jq -r ".[] | .name")

declare -a script_descriptions
script_descriptions=$(echo $index | jq -r ".[] | .description")

# initialize counter for selection menu
declare -i i
i=0

echo ""
echo "Please choose a script to execute:"
echo ""

for script in ${script_names[@]}; do
    echo "[${i}] ${script} - ${script_descriptions[$i]}"
    i=i+1
done
elements=i-1

read -r selection

if ! [[ $selection =~ $NUMBER_REGEX ]] ; then
    echo "error: Not a number"
    exit
fi


if (( $elements < $selection )); then
    echo "selection is greater than availiable scripts"
    exit
elif (( $selection < 0 )); then
    echo "selection is smaller than 0"
    exit
fi

selected_name=${script_names[$selection]}
echo ""
echo "Selected script: ${selected_name}"
echo ""

final_url="${BASE_URL}${selected_name}"

read -r -p "Should I download the script and execute it? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        echo "Downloading and executing script..."
	echo ""
	curl -sSL $final_url | sh
        if ! [ $? -eq 0 ]; then
    	    echo "Error during script download!"
            echo "This is the script URL: ${final_url}"
    	    exit 1
	fi
        exit 0
	;;
esac

read -r -p "Where should I download the script? [.] " output
output=${output:-.}

location="${output}/${selected_name}"
curl -sSL -o $location $final_url

if ! [ $? -eq 0 ]; then
    echo "Error during script download!"
    echo "This is the script URL: ${final_url}"
    echo "Target: ${location}"
    exit 1
fi

echo "Downloaded the script to: ${location}"
echo "Do not forget to make script executable."

echo ""
echo "Script finished successfully"
