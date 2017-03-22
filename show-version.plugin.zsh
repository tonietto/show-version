show-version() {
  if [ ! -f package.json ]; then
      echo $fg[red]"package.json not found!"
  else
    PACKAGE_VERSION=$(cat package.json \
    | grep version \
    | head -1 \
    | awk -F: '{ print $2 }' \
    | sed 's/[",]//g' \
    | tr -d '[[:space:]]')

    PACKAGE_NAME=$(cat package.json \
    | grep name \
    | head -1 \
    | awk -F: '{ print $2 }' \
    | sed 's/[",]//g' \
    | tr -d '[[:space:]]')

    printf "\033[36m%s\033[0m \033[90m%s\033[0m\n" $PACKAGE_NAME "$PACKAGE_VERSION"
  fi
}

chpwd () {
  local PKG

  PKG=$PWD/package.json
    if [ -f "$PKG" ] && [ "$NODENGINE_LAST_DIR" != "$PWD" ]; then
      nodengine
      printf "\033[36m%s\033[0m \033[90m%s\033[0m\n" "node" "$(node --version)"
      source-bash-commands
      NODENGINE_LAST_DIR=$PWD
    fi
}
