# Bulk create miyoogamelist.xml

### Goal:
Generate miyoogamelist.xml within each ROM subfolder based on the contained gamelist.xml using the script from the [Onion OS Wiki](https://onionui.github.io/docs/faq#how-can-i-use-a-miyoogamelistxml-to-customize-game-names) as a starting point, specifically the more efficient script provided. 

### Usage:
1. Generate gamelist.xml files using something like [Skraper UI](https://www.skraper.net/) and have them placed within each consoless subdirectory in the ROM folder

2. Run the script from the ROM root directory, the script will scan every console subfolder for the gamelist.xml file and will generate a miyoogamelist.xml.


**IMPORTANT**

To avoid any issues with arcade systems, the script ignores the folders ARCADE, CPS1, CPS2, CPS3