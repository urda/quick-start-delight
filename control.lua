local POWERED_KEY = "powered"
local UNPOWERED_KEY = "unpowered"

--- Configure an equipment grid given input specs.
--
-- @usage configure_gear(character, CHARACTER_GEAR)
--
-- @param gear_to_load The target character, spidertron, or other equipment grid.
-- @param gear_loadout The gear to load into the equipment grid.
local function configure_gear(gear_to_load, gear_loadout)
    for gear_type, gear_group in pairs(gear_loadout) do
        for gear_name, gear_position_array in pairs(gear_group) do
            for key, position in ipairs(gear_position_array) do
                local new_gear = gear_to_load.grid.put({name = gear_name, position = position})

                if gear_type == POWERED_KEY then
                    -- "Well, you don't give a toy without batteries."
                    new_gear.energy = new_gear.max_energy
                end
            end
        end
    end
end

script.on_event(defines.events.on_player_created, function(event)
    -- Configure local constants
    local COLOR_GREEN =  {  0, 255,   0, 255}
    local COLOR_RED =    {255,   0,   0, 255}
    local COLOR_WHITE =  {255, 255, 255, 255}
    local COLOR_YELLOW = {255, 255,   0, 255}

    local ROBOT_TECHNOLOGY = {
        'worker-robots-speed-1',
        'worker-robots-speed-2',
        'worker-robots-speed-3',
        'worker-robots-speed-4',
        'worker-robots-speed-5',
        'worker-robots-storage-1',
        'worker-robots-storage-2',
        'worker-robots-storage-3'
    }

    local CHARACTER_GEAR = {
        [POWERED_KEY] = {
            ["battery-mk2-equipment"] = {
                {8, 6},
                {9, 6},
                {8, 8},
                {9, 8},
            },
            ["belt-immunity-equipment"] = {
                {9, 0},
            },
            ["exoskeleton-equipment"] = {
                {0, 2},
                {2, 2},
                {4, 2},
                {6, 2},
                {8, 2},
            },
            ["personal-roboport-mk2-equipment"] = {
                {0, 0},
                {2, 0},
                {4, 0},
                {6, 0},
            },
        },
        [UNPOWERED_KEY] = {
            ["fusion-reactor-equipment"] = {
                {0, 6},
                {4, 6},
            },
            ["solar-panel-equipment"] = {
                {8, 0},
                {8, 1},
                {9, 1},
            },
        },
    }

    local SPIDER_GEAR = {
        [POWERED_KEY] = {
            ["battery-mk2-equipment"] = {
                {8, 4},
                {9, 4},
            },
            ["exoskeleton-equipment"] = {
                {8, 0},
            },
            ["personal-roboport-mk2-equipment"] = {
                {0, 4},
                {2, 4},
                {4, 4},
                {6, 4},
            },
        },
        [UNPOWERED_KEY] = {
            ["fusion-reactor-equipment"] = {
                {0, 0},
                {4, 0},
            },
        },
    }


    -- Lookup connecting player and post startup
    local player = game.players[event.player_index]
    player.print({"qsd-log-message.info-startup"}, COLOR_WHITE)

    -- Is the mod even enabled for this save?
    if not settings.global["qsd-setting-mod-enabled"].value then
        player.print({"qsd-log-message.warning-mod-disabled"}, COLOR_YELLOW)
        return
    end

    -- Attempt to find the player's character
    local character = player.character or player.cutscene_character

    if not character then
        player.print({"qsd-log-message.error-no-character"}, COLOR_RED)
        player.print({"qsd-log-message.error-failed-start"}, COLOR_RED)
        return
    end

    -- Attempt to load the player character's inventory
    local inventory = character.get_main_inventory()
    if not inventory then
        player.print({"qsd-log-message.error-no-inventory"}, COLOR_RED)
        player.print({"qsd-log-message.error-failed-start"}, COLOR_RED)
        return
    end

    -- Attempt to load the player character's armor inventory
    local armor_inventory = character.get_inventory(defines.inventory.character_armor)
    if not armor_inventory then
        player.print({"qsd-log-message.error-no-armor-inventory"}, COLOR_RED)
        player.print({"qsd-log-message.error-failed-start"}, COLOR_RED)
        return
    end

    -- Insert the Power armor MK2
    armor_inventory.insert({name = "power-armor-mk2", count = 1})

    -- Insert the rest of the equipment into the armor
    configure_gear(character, CHARACTER_GEAR)

    -- Build function to deal with '0' value items (Bugfix for 1.1.0 -> 1.1.1)
    function load_gear(loadout_specs, target_player, target_inventory)
        for item_name, item_count in pairs(loadout_specs) do
            if item_count > 0 then
                target_inventory.insert({name = item_name, count = item_count})
                target_player.print({"qsd-log-message.info-startup-inventory-added-generic", item_name, item_count}, COLOR_WHITE)
            elseif item_count == 0 then
                target_player.print({"qsd-log-message.warning-inventory-skipped-generic", item_name, item_count}, COLOR_YELLOW)
            else
                target_player.print({"qsd-log-message.error-negative-inventory-count"}, COLOR_RED)
            end
        end
    end

    -- Lookup starting inventory count settings
    local gear_loadout = {
        ["big-electric-pole"] = settings.global["qsd-setting-big-electric-pole-size"].value,
        ["construction-robot"] = settings.global["qsd-setting-construction-bot-size"].value,
        ["small-lamp"] = settings.global["qsd-setting-lamp-size"].value,
        ["steel-chest"] = settings.global["qsd-setting-steel-chest-size"].value,
    }

    -- Place construction bots, and other items into inventory
    load_gear(gear_loadout, player, inventory)

    -- The character's inventory is prepared
    player.print({"qsd-log-message.info-startup-inventory"}, COLOR_WHITE)

    -- Place a Spidertron and a Spidertron remote
    inventory.insert({name = "spidertron", count = 1})
    inventory.insert({name = "spidertron-remote", count = 1})

    -- Find that Spidertron for configuration
    local spidertron = inventory.find_item_stack("spidertron")
    if not spidertron then
        player.print({"qsd-log-message.error-no-spidertron"}, COLOR_RED)
        player.print({"qsd-log-message.warning-partial-start"}, COLOR_YELLOW)
        return
    end
    spidertron.create_grid()

    -- Insert the Spidertron gear
    configure_gear(spidertron, SPIDER_GEAR)

    -- The Spidertron is prepared
    player.print({"qsd-log-message.info-startup-spidertron"}, COLOR_WHITE)

    -- Should the technology be upgraded?
    if settings.global["qsd-setting-research-enabled"].value then
        -- Upgrade worker robot speed and robot storage
        for key, technology in ipairs(ROBOT_TECHNOLOGY) do
            player.force.technologies[technology].researched = true
        end

        player.print({"qsd-log-message.info-startup-robot-technology"}, COLOR_WHITE)
    else
        player.print({"qsd-log-message.warning-research-disabled"}, COLOR_YELLOW)
    end

    -- You Dun There Start Em Up
    player.print({"qsd-log-message.info-character-init"}, COLOR_GREEN)
end)
