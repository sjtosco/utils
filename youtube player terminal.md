Install: [https://ugeek.github.io/blog/post/2021-03-26-ytfzf-youtube-desde-la-terminal.html](https://ugeek.github.io/blog/post/2021-03-26-ytfzf-youtube-desde-la-terminal.html)

Dependences: 

```bash
sudo apt install jq mpv youtube-dl fzf python3-pip
sudo apt-get install libx11-dev libxext-dev
sudo pip3 install ueberzug
```
Download: `sudo curl -L "https://raw.githubusercontent.com/pystardust/ytfzf/master/ytfzf" -o /usr/bin/ytfzf && sudo chmod +x /usr/bin/ytfzf`

Config:
Create file `mkdir -p ~/.config/ytfzf && nano ~/.config/ytfzf/conf.sh`
```
YTFZF_HIST=1
YTFZF_LOOP=0
YTFZF_PREF="bestvideo[height<=?1080]+bestaudio/best"
YTFZF_ENABLE_FZF_DEFAULT_OPTS=1
FZF_PLAYER="mpv"
```

Launcher exec: xterm -T "YouTube Search (ytfzf)" -e "ytfzf -t -l"
