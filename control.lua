script.on_event(defines.events.on_player_created, function(event)
    -- configure some helpful locals
    local color_blue = {0, 0, 255, 255}
    local color_green = {0, 255, 0, 255}
    local color_red = {255, 0, 0, 255}
    local color_yellow = {255, 255, 0, 255}

    -- lookup player that was just created
    local player = game.players[event.player_index]

    player.print({"qsd-log-message.info-startup"}, color_blue)

    -- Is the mod even enabled for this save?
    if not settings.startup["qsd-setting-mod-enabled"].value then
        player.print({"qsd-log-message.warning-mod-disabled"}, color_yellow)
        return
    end

    -- and attempt to find that player's character
    local character = player.character or player.cutscene_character

    if not character then
        player.print({"qsd-log-message.error-no-character"}, color_red)
        player.print({"qsd-log-message.error-failed-start"}, color_red)
        return
    end

    -- attempt to load the player character's inventory
    local inventory = character.get_main_inventory()
    if not inventory then
        player.print({"qsd-log-message.error-no-inventory"}, color_red)
        player.print({"qsd-log-message.error-failed-start"}, color_red)
        return
    end

    -- attempt to load the player character's armor invetory
    local armor_inventory = character.get_inventory(defines.inventory.character_armor)
    if not armor_inventory then
        player.print({"qsd-log-message.error-no-armor-inventory"}, color_red)
        player.print({"qsd-log-message.error-failed-start"}, color_red)
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
    for key, value in ipairs(gear_to_power) do
        value.energy = value.max_energy
    end

    -- Place a Spidertron and a Spidertron remote
    inventory.insert({name = "spidertron", count = 1})
    inventory.insert({name = "spidertron-remote", count = 1})

    -- Find that Spidertron for configuration
    local spidertron = inventory.find_item_stack("spidertron")
    if not spidertron then
        player.print({"qsd-log-message.error-no-spidertron"}, color_red)
        player.print({"qsd-log-message.warning-partial-start"}, color_yellow)
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

    -- Place constuction bots into inventory
    inventory.insert({name = "construction-robot", count = 200})

    -- You Dun There Start Em Up
    player.print({"qsd-log-message.info-character-init"}, color_green)
end)
