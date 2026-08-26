local mp = require 'mp'
local last_drop_count = 0

local function on_frame_drop(name, current_drop_count)
if current_drop_count == nil then return end

    if current_drop_count > last_drop_count and last_drop_count ~= 0 then
        local ass_start = mp.get_property("osd-ass-cc/0")
        local ass_stop = mp.get_property("osd-ass-cc/1")

        local formatted_text = string.format("{\\c&H0000FF&\\b1\\fs40}Warning: Dropped Frames! (Total: %d)", current_drop_count)
        local message = ass_start .. formatted_text .. ass_stop

        mp.osd_message(message, 1.0)
        end

        last_drop_count = current_drop_count
        end

        mp.observe_property("frame-drop-count", "number", on_frame_drop)

        mp.register_event("file-loaded", function()
        last_drop_count = mp.get_property_number("frame-drop-count", 0)
        end)
