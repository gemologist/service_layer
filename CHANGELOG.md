# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

* Update the `Command` context. Remove the `OpenStruct` dependency.
Automatically create and assign properties based on initialize inputs.

## [0.2.0] (2017-11-25)

### Added

* Add explicit `#failure?` on `Response`. Return the opposite of `#success?`.
* The `Command` handles the initialization process. Automatically provides
getter and setter for each attributes sent to the command.

## 0.1.0 (2017-10-09)

### Added

* Provide a generic Response API. `Success` and `Error` wrap a value which is
gettable with `#data` and decorate that value with the `#success?` predicate
method. This makes it possible to know the state of success of an execution.
* Implement the Command design pattern. It imposes the implementation of a
`#perform` method and provides a delegation of the execution logic of the
command.

[Unreleased]: https://github.com/gemologist/service_layer/compare/v0.2.0...master
[0.2.0]: https://github.com/gemologist/service_layer/compare/v0.1.0...v0.2.0
