let
  name = "rkuklik";
  email = "rkuklik@expect-it.cz";
in {
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
  };
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        inherit
          name
          email
          ;
      };
      ui = {
        default-command = ["log" "--revisions" "::"];
      };
    };
  };
}
