-- The Legend of Zelda - Twilight Princess (NTSC v1.0)

local core = require("games.core")

local game = {
	memorymap = {}
}

local controllers = {
	[1] = 0x804343F0 + 0xC * 0,
	[2] = 0x804343F0 + 0xC * 1,
	[3] = 0x804343F0 + 0xC * 2,
	[4] = 0x804343F0 + 0xC * 3,
}

local controller_struct = {
	[0x0] = { type = "short",	name = "controller.%d.buttons.pressed" },
	[0x2] = { type = "sbyte",	name = "controller.%d.joystick.x" },
	[0x3] = { type = "sbyte",	name = "controller.%d.joystick.y" },
	[0x4] = { type = "sbyte",	name = "controller.%d.cstick.x" },
	[0x5] = { type = "sbyte",	name = "controller.%d.cstick.y" },
	[0x6] = { type = "byte",	name = "controller.%d.analog.l" },
	[0x7] = { type = "byte",	name = "controller.%d.analog.r" },
	[0xA] = { type = "byte",	name = "controller.%d.plugged" },
}

for port, address in ipairs(controllers) do
	for offset, info in pairs(controller_struct) do
		game.memorymap[address + offset] = {
			type = info.type,
			debug = info.debug,
			name = info.name:format(port),
		}
	end
end

game.translateAxis = core.translateAxis
game.translateTriggers = core.translateTriggers

return game
