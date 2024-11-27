{
  programs.yt-dlp = {
    enable = true;
    settings = {
      no-overwrites = true;
      embed-chapters = true;
      paths = "'temp:/tmp'";
      output = "'%(title)s [%(id)s].%(ext)s'";
    };
  };
}
