This is a script library for THE SETTLERS - Rise of a kingdom.

This library will extend upon the default QSB and extend it with additional
features. Components are all optional (expect for the core) and therefore not
always needed for a running map.

## Usage

#### Default

- Download latest release
- Import `s6communitylib` folder (inside archiv) in map archive
- Load `loader.lua` at the start of your scripts
  (both global and local)
- Use Require to load components AFTER that
- call `PrepareLibrary()` in Mission_FirstMapAction

#### Single File

- Download latest release
- Use `mapscript.lua` and `localmapscript.lua` provided by the release
- import `questsystembehavior.lua` as usual
- Include `questsystembehavior.lua` as usual in Mission_FirstMapAction
- Include also in Mission_LocalOnMapStart (local script)
- call `PrepareLibrary()` in Mission_FirstMapAction