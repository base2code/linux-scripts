#!/bin/sh

scriptsraw=$(ls scripts/*.sh)

scripts=()
for script in ${scriptsraw[@]}; do
    scripts+=($(echo -e ${script} | awk '{split($0,a,"/"); print a[2]}'))
done

for script in ${scripts[@]}; do
    echo "Found .sh file: ${script}"
done

json="["
for script in ${scripts[@]}; do
    second_line=$(cat "scripts/"$script | sed -n 2p)
    if [[ ${second_line:0:1} == "#" ]]; then
        description=${second_line:1}
        jsonstring=$(jq --null-input \
  		--arg name "$script" \
  		--arg description "$description" \
  		'{"name": $name, "description": $description}')
        json="${json} ${jsonstring} ,"
    fi
done

#jq -n --arg inarr "$(echo ${scripts[@]})" '{ arr: $inarr | split("\n") }'

# Replace last ,
json=${json:0:$((${#json} - 1))}

json="${json}]"

#echo $json
echo $json | jq '.' > index.json
