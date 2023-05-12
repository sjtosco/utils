# MKDOCS

## Option 1: mkdocs-pdf-export-plugin

```
pip install mkdocs-material mkdocs-git-revision-date-plugin mkdocs-pdf-export-plugin
```

> Run inside a virtualenv is recommended

## mkdocs.yml

```
site_name: CHANGEME
site_author: CHANGEME
docs_dir: src
markdown_extensions:  
  - toc:                 
      permalink: true
repo_name: Gitlab
repo_url: https://gitlab.com/CHANGEME
edit_uri: 'docs/'
theme: 
  name: material
  logo: assets/images/logo.png
  favicon: assets/images/favicon.png
plugins:
  - search
  - git-revision-date
  - pdf-export:
      combined: true
nav:
  - index.md
```

## Option 2: Using chromium-headless

`pip install mkdocs mkdocs-page-pdf`
