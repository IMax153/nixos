{config, ...}: {
  path = "${config.xdg.dataHome}/zsh/zsh_history";
  expireDuplicatesFirst = true;
  extended = false;
  ignoreDups = true;
  ignoreSpace = true;
  share = true;
  save = 100000;
  size = 100000;
}
