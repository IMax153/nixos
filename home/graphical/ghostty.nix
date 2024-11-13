{
  xdg.configFile.ghostty = {
    text = ''
      # Ghostty theme
      theme = catppuccin-macchiato

      # Font family
      font-family = JetBrains Mono
      font-style = Regular
      font-style-italic = Regular Italic
      font-style-bold = Bold
      font-style-bold-italic = Bold Italic

      # Font size
      font-size = 18

      # Opacity of split windows
      unfocused-split-opacity = 0.97  

      # Set the background-opacity to be fully opaque
      background-opacity = 1.0

      # Cursor style
      cursor-style-blink = true

      # Clipboard settings
      clipboard-read = allow
      clipboard-write = allow

      # Allow option to work as alt on macos
      macos-option-as-alt = true

      # Always show ghostty as the title
      title = ghostty 

      # Window settings
      window-width = 90
      window-height = 30
      window-colorspace = display-p3
      window-padding-color = background
      window-padding-balance = true
      window-padding-x = 5
      window-padding-y = 5
    '';
  };
}
