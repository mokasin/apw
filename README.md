Awesome Pulseaudio Widget
=========================

Awesome Pulseaudio Widget (APW) is a little widget for
[Awesome WM](http://awesome.naquadah.org/), using the awful progressbar widget,
to display default's sink volume and control Pulseaudio.

It's compatible to Awesome 3.5.

First time I'm using Lua. So it might be a little bit quirky.

Get it
------------

```sh
cd $XDG_CONFIG_HOME/awesome/
git clone https://github.com/mokasin/apw.git
```

Use it
-----

Just put these line to the appropriate places in
*$XDG_CONFIG_HOME/awesome/rc.lua*.

```lua
-- Load the widget.
local APW = require("apw/widget")

-- Example: Add to wibox. Here to the right. Do it the way you like it.
right_layout:add(APW)

-- Configure the hotkeys.
awful.key({ }, "XF86AudioRaiseVolume",  APW.Up),
awful.key({ }, "XF86AudioLowerVolume",  APW.Down),
awful.key({ }, "XF86AudioMute",         APW.ToggleMute),

```

### Tip
You could update the widget periodically if you'd like. In case, the volume is
changed from somewhere else.

```lua
APWTimer = timer({ timeout = 0.5 }) -- set update interval in s
APWTimer:connect_signal("timeout", AWP.Update)
APWTimer:start()
```

Contributing
------------
Just fork it and file a pull request. I'll look into it.
