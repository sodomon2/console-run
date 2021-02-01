local core = require "core"
local keymap = require "core.keymap"
local command = require "core.command"
local console  = require "plugins.console"

local function execute()
    local filename = core.active_view.doc.filename
    local ext = filename:match('%w+$')
	local cmd = nil
	if (ext == 'lua') then
		cmd = 'lua _FILE'
	elseif (ext == 'py') then
		cmd = 'python _FILE'
	elseif (ext == 'sh') then
		cmd = 'sh _FILE'
	elseif (ext == 'moon') then
		cmd = 'moon _FILE'
	elseif (ext == 'build') then
		cmd = 'meson . output'
	elseif (ext == 'go') then
		cmd = 'go run _FILE'
	elseif (ext == 'zig') then
		cmd = 'zig run _FILE'
	end
    cmd = string.gsub(cmd, '_FILE', "\"" .. filename .. "\"")
    console.run({
        command = cmd,
        on_complete = function() core.log("exit status: 9") end,
    })
    core.log(cmd)
end 

command.add(nil,{
    ["console-run:execute"] = function()
      execute()
    end
})

keymap.add {
	["f4"] = "console:toggle",
	["f5"] = "console-run:execute",
}
