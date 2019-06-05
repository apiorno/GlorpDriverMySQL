# Installation

## Basic Installation

You can load **GlorpDriverMySQL** evaluating:
```smalltalk
Metacello new
  baseline: 'GlorpDriverMySQL';
  repository: 'github://apiorno/GlorpDriverMySQL:release-candidate/source';
  load
```
>  Change `release-candidate` to some released version if you want a pinned version

## Using as dependency

In order to include **GlorpDriverMySQL** as part of your project, you should reference the package in your product baseline:

```smalltalk
setUpDependencies: spec

  spec
    baseline: 'GlorpDriverMySQL'
      with: [ spec
        repository: 'github://apiorno/GlorpDriverMySQL:v{XX}/source';
        loads: #('Deployment') ];
    import: 'GlorpDriverMySQL'.
```
> Replace `{XX}` with the version you want to depend on

```smalltalk
baseline: spec

  <baseline>
  spec
    for: #common
    do: [ self setUpDependencies: spec.
      spec package: 'My-Package' with: [ spec requires: #('GlorpDriverMySQL') ] ]
```

## Provided groups

- `Deployment` will load all the packages needed in a deployed application
- `Tests` will load the test cases
- `CI` is the group loaded in the continuous integration setup
- `Development` will load all the needed packages to develop and contribute to the project
