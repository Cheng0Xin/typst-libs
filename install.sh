#!/usr/bin/env fish

function install_on_mac
  echo $message

  if test ! -d $install_path
    mkdir -p $install_path
    echo 'Creating local package repository'
  end

  if test -d $install_path/note
    rm -rf $install_path/note
  end

  if test -d $install_path/acg-comment
    rm -rf $install_path/acg-comment
  end

  if test -d $install_path/semantics
    rm -rf $install_path/semantics
  end

  mkdir $install_path/note
  ln -s (pwd)/note $install_path/note/1.0.0

  mkdir $install_path/acg-comment
  ln -s (pwd)/acg-comment $install_path/acg-comment/1.0.0

  mkdir $install_path/semantics
  ln -s (pwd)/semantics $install_path/semantics/1.0.0
end

switch (uname)
  case Darwin
    set install_path ~/Library/Application\ Support/typst/packages/local
    set message 'Install in macos'
    install_on_mac
  case Linux
    set install_path ~/.local/share/typst/packages/local
    set message 'Install in linux'
    install_on_mac
end
