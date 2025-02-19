{
  pkgs,
  lib,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp.servers.omnisharp = {
      enable = false;
      filetypes = [
        "cs"
        "vb"
        "csproj"
      ];
      settings = {
        FormattingOptions = {
          EnableEditorConfigSupport = false;
          NewLine = "\n";
          NewLinesForBracesInTypes = false;
          NewLinesForBracesInMethods = false;
          NewLinesForBracesInProperties = false;
          NewLinesForBracesInAccessors = false;
          NewLinesForBracesInAnonymousMethods = false;
          NewLinesForBracesInControlBlocks = false;
          NewLinesForBracesInAnonymousTypes = false;
          NewLinesForBracesInObjectCollectionArrayInitializers = false;
          NewLinesForBracesInLambdaExpressionBody = false;
        };
        RoslynExtensionsOptions = {
          EnableAsyncCompletion = true;
          EnableImportCompletion = true;
          EnableAnalyzersSupport = true;
          EnableDecompilationSupport = true;
        };
      };
    };
    lsp.servers.csharp_ls = {
      enable = true;
    };
    conform-nvim.settings = {
      #formatters_by_ft = {
      #  cs.__unkeyed-cshaper = "cshaper";
      #};
      #formatters.cshaper.command = "todo";
    };
  };
}
