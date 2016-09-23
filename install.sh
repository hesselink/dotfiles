#!/bin/bash

elem()
{
  elem=$1
  items=$2
  for item in $items; do
    if [ "$elem" = "$item" ];
      then return 0
    fi
  done
  return 1
}

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
me="$(basename "${BASH_SOURCE[0]}")"
ignores=". .. $me .git .gitmodules"

for file in $(ls -a $dir); do
  if elem "$file" "$ignores"; then
    # echo $file ignored.
    continue
  elif [ -e $HOME/$file ]; then
    echo $file exists, skipping.
  else
    ln -s "$dir/$file" "$HOME/$file"
  fi
done

cd $dir
git submodule update --init
