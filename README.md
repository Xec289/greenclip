## Usage
```
sh install.sh
```
**DON'T RUN `sudo sh install.sh`**

If you add keyboard shortcuts in i3 window manager, add this line to `~/.config/i3/config`

```
# clipboard
bindsym $mod+Shift+v exec rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}'
```
