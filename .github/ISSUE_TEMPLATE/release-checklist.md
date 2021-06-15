---
name: GMT_docs release checklist
about: Checklist for a new GMT_docs release
title: 'Release GMT_docs vX.Y'
labels: ''
assignees: ''

---

**Release**: vX.Y
**Scheduled Date**: YYYY/MM/DD
**Pull request due date**: YYYY/MM/DD

**Priority PRs/issues to complete prior to release**
- [ ] X ()
- [ ] Y ()

**Before release**:
- [ ] Quickly go through the HTML and PDF documentation and see if there are any obvious errors

**Release**:
- [ ] Set the tag version to vX.Y
- [ ] Manually upload the PDF to the GitHub release page

**After release**:
- [ ] Bump the GMT version in the CI workflow: `cache-data.yml`, `deploy.yml`, and `preview-pr.yml`
- [ ] Bump the GMT version number in `source/_static/version_switch.js`, `source/conf.py`, and `README.md`
- [ ] Bump the GMT version in the documentation
  - [ ] `source/intro`: `overview.rst`, `resources.rst`, `versions.rst`
  - [ ] `source/install`: `macOS.rst`, `windows.rst`, `cross-platform.rst`, `build-source.rst`
  - [ ] `source/tutorial/get-started`: `linux.rst`, `macos.rst`, `windows.rst`

---

- [ ] Party :tada: (don't tick before all other checkboxes are ticked!)
