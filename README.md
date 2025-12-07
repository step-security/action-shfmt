# action-shfmt

[![Test](https://github.com/step-security/action-shfmt/workflows/Test/badge.svg)](https://github.com/step-security/action-shfmt/actions?query=workflow%3ATest)
[![reviewdog](https://github.com/step-security/action-shfmt/workflows/reviewdog/badge.svg)](https://github.com/step-security/action-shfmt/actions?query=workflow%3Areviewdog)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/step-security/action-shfmt?logo=github&sort=semver)](https://github.com/step-security/action-shfmt/releases)

![demo](https://user-images.githubusercontent.com/3797062/134041779-b016a9cc-efba-4191-a254-656a495cfac8.png)

Run [shfmt](https://github.com/mvdan/sh) with [reviewdog](https://github.com/reviewdog/reviewdog) and post GitHub suggestion comments on Pull Requests.

## Input

```yaml
inputs:
  github_token:
    description: 'GITHUB_TOKEN'
    default: '${{ github.token }}'
  workdir:
    description: 'Working directory relative to the root directory.'
    default: '.'
  ### Flags for reviewdog ###
  level:
    description: 'Report level for reviewdog [info,warning,error]'
    default: 'error'
  filter_mode:
    description: |
      Filtering mode for the reviewdog command [added,diff_context,file,nofilter].
      Default is added.
    default: 'added'
  fail_on_error:
    description: |
      Exit code for reviewdog when errors are found [true,false]
      Default is `false`.
    default: 'false'
  reviewdog_flags:
    description: 'Additional reviewdog flags'
    default: ''
  ### Flags for shfmt ###
  shfmt_flags:
    description: 'flags for shfmt'
    default: '-i 2 -ci'
```

## Usage

```yaml
name: reviewdog
on: [pull_request]
jobs:
  shfmt:
    name: runner / shfmt
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      - uses: step-security/action-shfmt@v1
```
