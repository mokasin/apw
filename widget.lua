-- Copyright 2013 mokasin
-- This file is part of the Awesome Pulseaudio Widget (APW).
-- 
-- APW is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- APW is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with APW. If not, see <http://www.gnu.org/licenses/>.

-- Configuration variables
local width         = 40        -- width in pixels of progressbar
local margin_right  = 2         -- right margin in pixels of progressbar 
local margin_left   = 2         -- left margin in pixels of progressbar 
local margin_top    = 2         -- top margin in pixels of progressbar 
local margin_bottom = 2         -- bottom margin in pixels of progressbar  
local step          = 0.05      -- stepsize for volume change (ranges from 0 to 1)
local color         = '#698f1e' -- foreground color of progessbar
local color_bg      = '#33450f' -- background color
local color_mute    = '#be2a15' -- foreground color when muted
local color_bg_mute = '#532a15' -- background color when muted
-- End of configuration

local awful = require("awful")
local wibox = require("wibox")
local pulseaudio = require("apw.pulseaudio")

local p = pulseaudio:Create()

local pulseBar = awful.widget.progressbar()

pulseBar:set_width(width)
pulseBar.step = step

local pulseWidget = wibox.layout.margin(pulseBar, margin_right, margin_left, margin_top, margin_bottom)

function pulseWidget.setColor(mute)
	if mute then
		pulseBar:set_color(color_mute)
		pulseBar:set_background_color(color_bg_mute)
	else
		pulseBar:set_color(color)
		pulseBar:set_background_color(color_bg)
	end
end

local function _update()
	pulseBar:set_value(p.Volume)
	pulseWidget.setColor(p.Mute)
end

function pulseWidget.Up()
	p:SetVolume(p.Volume + pulseBar.step)
	_update()
end	

function pulseWidget.Down()
	p:SetVolume(p.Volume - pulseBar.step)
	_update()
end	


function pulseWidget.ToggleMute()
	p:ToggleMute()
	_update()
end

function pulseWidget.Update()
	p:UpdateState()
	 _update()
end

-- register mouse button actions
pulseWidget:buttons(awful.util.table.join(
		awful.button({ }, 1, pulseWidget.ToggleMute),
		awful.button({ }, 4, pulseWidget.Up),
		awful.button({ }, 5, pulseWidget.Down)
	)
)


-- initialize
_update()

return pulseWidget
