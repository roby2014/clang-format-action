# Auto clang format Github action

Allow running `clang-format` on C/C++ sources every push using Github actions. A `.clang-format` file is required.

## Usage

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
        EXCLUDE_REGEX: 'lib/' #optional
```

`EXCLUDE_REGEX` can be used to avoid formatting certain folders.
