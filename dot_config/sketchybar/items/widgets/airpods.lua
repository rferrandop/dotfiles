local icons = require('icons')
local colors = require('colors')
local settings = require('settings')

local airpods = sbar.add('item', "widgets.airpods", {
    position = "right",
    icon = {
        font = {
            family = settings.font.text,
            style = settings.font.style_map["Regular"],
            size = 19.0,
        }
    },
    label = { font = { family = settings.font.numbers } },
    update_freq = 10,
    popup = { align = "center" }
})

airpods:subscribe({ "routine", "power_source_change", "system_woke" }, function()
    sbar.exec("~/.local/bin/airpods", function(info)
        local found, _, left_charge = info:find('L: "(%d+)%%"')
        local found2, _, right_charge = info:find('R: "(%d+)%%"')
        local label = ""
        if found and found2 then
            label = "L " ..left_charge .. "% R " ..right_charge .. "%"
        else
            label = ""
        end
        airpods:set({
            icon = {
                string = icons.airpods,
                color = colors.white
            },
            label = { string = label }
        })
    end)
end)

sbar.add("bracket", "widgets.airpods.bracket", { airpods.name }, {
    background = { color = colors.bg1 }
})

sbar.add("item", "widgets.airpods.padding", {
    position = "right",
    width = settings.group_paddings
})
