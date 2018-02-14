# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] (2018-03-08)

### Added

* Encapsulate the return of the execution of a `Command`. To force uniformity of
the Service Layer API output using `Result`.
* Add `Contract` structure. The Contract pattern allows to setup properties of a
`Class` and auto-initialize this ones.
* Add the contract rendering setup. Allowing to define, with `.render`, the
rendered properties. These will be auto-transferred to the `Result` returned
with `#render`.
* Add an alias `.call` for `Command.perform`.
* Implement implicit `Command` class casting to `Proc`.

### Changed

* Replace `Response` objects with `Result`. `Result` attributes are dynamically
defined and readable like `Command` objects.
* Update `Command` context. Remove the `OpenStruct` dependency. Automatically
create and assign properties based on initialize inputs.

## [0.2.0] (2017-12-15)

### Added

* Add explicit `#failure?` on `Response`. Return the opposite of `#success?`.
* The `Command` handles the initialization process. Automatically provides
getter and setter for each attributes sent to the command.

## 0.1.0 (2017-10-09)

### Added

* Provide a generic `Response` API.
* Implement Command pattern, imposes the implementation of a `#perform` method
and provides a delegation of the execution logic of the command.

[Unreleased]: https://github.com/gemologist/service_layer/compare/v0.3.0...master
[0.3.0]: https://github.com/gemologist/service_layer/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/gemologist/service_layer/compare/v0.1.0...v0.2.0
