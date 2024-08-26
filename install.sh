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
force=

while [[ $# -gt 0 ]]; do
  case $1 in
    -f|--force)
      force=YES
      shift
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      echo "Trailing argument $1"
      exit 1
      ;;
  esac
done

for file in $(ls -a $dir); do
  if elem "$file" "$ignores"; then
    # echo $file ignored.
    continue
  elif [ -e $HOME/$file ]; then
    if [ $force = "YES" ]; then
      echo $file exists and force specified, overwriting. Backup saved to $file.bak
      mv "$HOME/$file" "$HOME/$file.bak"
      ln -s "$dir/$file" "$HOME/$file"
    else
      echo $file exists, skipping.
    fi
  else
    ln -s "$dir/$file" "$HOME/$file"
  fi
done

cd $dir
git submodule update --init
if [ -d .vim/bundle/coc.nvim ]; then
  (cd .vim/bundle/coc.nvim && yarn install)
fi
