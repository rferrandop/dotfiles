local icons = require('icons')

local devices = sbar.add('item', "widgets.devices", {
    position = "right",
    update_freq = 180
})

devices:subscribe({ "routine" }, function()
    sbar.exec("/tmp/devices.sh", function(info)
        devices:set({
            icon = {
                string = icons.battery.charging,
            },
            label = { string = "xd" },
        })
    end)
end)
