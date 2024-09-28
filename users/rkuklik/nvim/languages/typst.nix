{
  programs.nixvim = {
    filetype.extension.typ = "typst";
    plugins = {
      lsp.servers.tinymist = {
        enable = true;
      };
    };
  };
}
