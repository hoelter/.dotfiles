# Installing Fonts

## Refreshing fonts
Latest fonts are fromt the 3.0.1 release.
- https://github.com/ryanoasis/nerd-fonts/releases

## Windows
Right click and select install.

List the FontFamilies in powershell to determine the correct value for the "fontFace" property in the
windows terminal config file if changing it.
- `Add-Type -AssemblyName PresentationCore`
- `[Windows.Media.Fonts]::SystemFontFamilies | Select-Object -Property Source`
