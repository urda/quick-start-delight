script.on_event(defines.events.on_player_created, function(event)
    -- Configure local constants
    local COLOR_GREEN = {0, 255, 0, 255}
    local COLOR_RED = {255, 0, 0, 255}
    local COLOR_WHITE = {255, 255, 255, 255}
    local COLOR_YELLOW = {255, 255, 0, 255}

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

    -- Lookup connecting player and post startup
    local player = game.players[event.player_index]
    player.print({"qsd-log-message.info-startup"}, COLOR_WHITE)

    -- Is the mod even enabled for this save?
    if not settings.startup["qsd-setting-mod-enabled"].value then
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

    -- Insert the Power armor MK2, connect the fusion reactors, and the solar panels
    armor_inventory.insert({name = "power-armor-mk2", count = 1})
    character.grid.put({name = "fusion-reactor-equipment", position = {0, 6}})
    character.grid.put({name = "fusion-reactor-equipment", position = {4, 6}})
    character.grid.put({name = "solar-panel-equipment", position = {8, 0}})
    character.grid.put({name = "solar-panel-equipment", position = {8, 1}})
    character.grid.put({name = "solar-panel-equipment", position = {9, 1}})
    character.grid.put({name = "solar-panel-equipment", position = {8, 2}})
    character.grid.put({name = "solar-panel-equipment", position = {9, 2}})
    character.grid.put({name = "solar-panel-equipment", position = {8, 3}})
    character.grid.put({name = "solar-panel-equipment", position = {9, 3}})

    -- Insert the rest of the equipment into the armor, track in list for powering up after
    local gear_to_power = {}
    table.insert(gear_to_power, character.grid.put({name = "personal-roboport-mk2-equipment", position = {0, 0}}))
    table.insert(gear_to_power, character.grid.put({name = "personal-roboport-mk2-equipment", position = {2, 0}}))
    table.insert(gear_to_power, character.grid.put({name = "personal-roboport-mk2-equipment", position = {4, 0}}))
    table.insert(gear_to_power, character.grid.put({name = "personal-roboport-mk2-equipment", position = {6, 0}}))
    table.insert(gear_to_power, character.grid.put({name = "belt-immunity-equipment", position = {9, 0}}))
    table.insert(gear_to_power, character.grid.put({name = "exoskeleton-equipment", position = {0, 2}}))
    table.insert(gear_to_power, character.grid.put({name = "exoskeleton-equipment", position = {2, 2}}))
    table.insert(gear_to_power, character.grid.put({name = "exoskeleton-equipment", position = {4, 2}}))
    table.insert(gear_to_power, character.grid.put({name = "exoskeleton-equipment", position = {6, 2}}))
    table.insert(gear_to_power, character.grid.put({name = "battery-mk2-equipment", position = {8, 4}}))
    table.insert(gear_to_power, character.grid.put({name = "battery-mk2-equipment", position = {9, 4}}))
    table.insert(gear_to_power, character.grid.put({name = "battery-mk2-equipment", position = {8, 6}}))
    table.insert(gear_to_power, character.grid.put({name = "battery-mk2-equipment", position = {9, 6}}))
    table.insert(gear_to_power, character.grid.put({name = "battery-mk2-equipment", position = {8, 8}}))
    table.insert(gear_to_power, character.grid.put({name = "battery-mk2-equipment", position = {9, 8}}))

    -- "Well, you don't give a toy without batteries."
    for key, new_gear in ipairs(gear_to_power) do
        new_gear.energy = new_gear.max_energy
    end

    -- Place construction bots into inventory
    inventory.insert({name = "construction-robot", count = 200})

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
    spidertron.grid.put({name = "fusion-reactor-equipment", position = {0, 0}})
    spidertron.grid.put({name = "fusion-reactor-equipment", position = {4, 0}})
    spidertron.grid.put({name = "exoskeleton-equipment", position = {8, 0}})
    spidertron.grid.put({name = "personal-roboport-mk2-equipment", position = {0, 4}})
    spidertron.grid.put({name = "personal-roboport-mk2-equipment", position = {2, 4}})
    spidertron.grid.put({name = "personal-roboport-mk2-equipment", position = {4, 4}})
    spidertron.grid.put({name = "personal-roboport-mk2-equipment", position = {6, 4}})
    spidertron.grid.put({name = "battery-mk2-equipment", position = {8, 4}})
    spidertron.grid.put({name = "battery-mk2-equipment", position = {9, 4}})

    -- The Spidertron is prepared
    player.print({"qsd-log-message.info-startup-spidertron"}, COLOR_WHITE)

    -- Should the technology be upgraded?
    if settings.startup["qsd-setting-research-enabled"].value then
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
