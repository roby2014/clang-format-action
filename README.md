# Auto clang format Github action

Allow running `clang-format` on C/C++ sources using Github actions. A `.clang-format` file is required.

## Info
  - `exclude-regex` can be used to avoid formatting certain folders.

## Usage

This action will run this action on every push, formatting all C/C++ files except the ones from `lib/` folder):

`.github/workflows/formatter.yml`:
```yml
on: push
name: clang-format Code Formatter
jobs:
  lint:
    name: clang-format Code Formatter
    runs-on: ubuntu-latest
    steps:
    - name: Clang Code Formatter
      uses: roby2014/clang-format-action@v1.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        exclude-regex: 'lib/' #optional
```
