# Bottles Desktop shortcuts

For this give permission to Bottles flatpak installation: 

```
flatpak override com.usebottles.bottles --user --filesystem=xdg-data/applications
```

## Fix problem (Version: 51.10; Arch: x86_64; Origin: flathub; Debian 12)

> More info: https://github.com/bottlesdevs/Bottles/issues/3210#issuecomment-1868565791

Add `--args-replace` after second `run` inside launcher file (located in 
`~/.local/share/applications` folder).
