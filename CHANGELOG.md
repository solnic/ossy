## 0.4.0 2022-11-23

### Changed

- Migrate to 1.0 of dry-system and its deps (@flash-gordon)

## 0.2.0 2021-01-02

### Added

- `configs merge` now supports merging array of hashes (@solnic)

## 0.1.4 2020-01-23

### Fixed

- `github workflow` no longer crashes after switching to `faraday` (@solnic)

## 0.1.3 2020-01-23

### Changed

- Switched from `http` to `faraday` as it has less dependencies (@solnic)

## 0.1.2 2020-01-23

### Fixed

- `ossy` executable no longer requires bundler/setup (@solnic)"

### Changed

- Bump dep on dry-cli to >= 0.5.1 which fixed missing `set` require (@solnic)

## 0.1.1 2020-01-22

### Changed

- Disabled `:logging` plugin (@solnic)

## 0.1.0 2020-01-22

The first public release!

### Added

- `ossy github` - various commands that give you information from the GitHub API v3
- `ossy changelogs` - commands for updating `CHANGELOG` files automatically based on a YAML config
- `ossy configs` - commands for merging YAML configs
- `ossy templates` - commands for compiling `erb` templates
