# Fork Maintenance

This repository is structured to keep the official project history and the Kvaser CANlib work in a single Git repository.

## Branch Strategy

- `main`: keep this branch aligned with `upstream/main`.
- `windowscanlib-mainline`: keep the Kvaser CANlib changes here.

There should be no nested `fork/` repository. All maintained changes live directly in the main working tree.

## Remote Layout

- `origin`: your fork on GitHub.
- `upstream`: the official `Open-Agriculture/AgIsoStack-plus-plus` repository.

## Sync Workflow

Use this flow whenever you want to pull the latest official changes without duplicating the project:

```bash
git fetch upstream origin
git switch main
git merge --ff-only upstream/main
git push origin main

git switch windowscanlib-mainline
git merge main
git push -u origin windowscanlib-mainline
```

If you prefer a linear history for the Kvaser branch, replace `git merge main` with `git rebase main`.