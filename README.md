# pre-commit-forge

## Usage

Add the following entry to `.pre-commit-config.yaml`:

```yaml
- repo: git://github.com/shuklaayush/pre-commit-forge
  sha: HEAD
  hooks:
    - id: forge-snapshot
      # args: ["--asc", "--allow-failure"]
```
