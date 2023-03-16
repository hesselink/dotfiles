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

if ! which python3 > /dev/null; then
  echo "Python 3 not found."
  exit 1
fi

if ! which qualia > /dev/null; then
  pip3 install mir.qualia
fi

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
if [ -d .vim/bundle/coc.nvim ]; then
  (cd .vim/bundle/coc.nvim && yarn install)
fi
