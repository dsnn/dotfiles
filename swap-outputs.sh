#!/usr/bin/env bash

LEFT="rdp0"
RIGHT="rdp1"

# get workspace -> output mapping
mapfile -t WS_LEFT < <(i3-msg -t get_workspaces | jq -r ".[] | select(.output==\"$LEFT\") | .name")
mapfile -t WS_RIGHT < <(i3-msg -t get_workspaces | jq -r ".[] | select(.output==\"$RIGHT\") | .name")

# move left -> right
for ws in "${WS_LEFT[@]}"; do
  i3-msg "workspace \"$ws\"; move workspace to output $RIGHT"
done

# move right -> left
for ws in "${WS_RIGHT[@]}"; do
  i3-msg "workspace \"$ws\"; move workspace to output $LEFT"
done
