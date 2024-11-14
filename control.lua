-- Copyright 2022 Peter Urda
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

require("qsd.constants")
require("qsd.mod_settings")
require("qsd.utils")

script.on_event(defines.events.on_player_created, function(event)
    -- Lookup connecting player and post startup
    local player = game.players[event.player_index]
    player.print({"qsd-log-message.info-startup"}, { color = COLOR_WHITE })

    -- Is the mod even enabled for this save?
    if not settings.global["qsd-setting-mod-enabled"].value then
        player.print({"qsd-log-message.warning-mod-disabled"}, { color = COLOR_YELLOW })
        return
    end

    -- Attempt to find the player's character
    local character = player.character or player.cutscene_character

    if not character then
        player.print({"qsd-log-message.error-no-character"}, { color = COLOR_RED })
        player.print({"qsd-log-message.error-failed-start"}, { color = COLOR_RED })
        return
    end

    -- Attempt to load the player character's inventory
    local inventory = character.get_main_inventory()
    if not inventory then
        player.print({"qsd-log-message.error-no-inventory"}, { color = COLOR_RED })
        player.print({"qsd-log-message.error-failed-start"}, { color = COLOR_RED })
        return
    end

    -- Attempt to load the player character's armor inventory
    local armor_inventory = character.get_inventory(defines.inventory.character_armor)
    if not armor_inventory then
        player.print({"qsd-log-message.error-no-armor-inventory"}, { color = COLOR_RED })
        player.print({"qsd-log-message.error-failed-start"}, { color = COLOR_RED })
        return
    end

    -- Insert the Power armor MK2
    if settings.global["qsd-setting-mech-armor-enabled"].value then
        armor_inventory.insert({name = "mech-armor", count = 1})
    else
        armor_inventory.insert({name = "power-armor-mk2", count = 1})
    end

    -- Insert the rest of the equipment into the armor
    configure_gear(player, character, CHARACTER_GEAR)

    -- Place construction bots, and other items into inventory
    load_gear(PLAYER_LOADOUT_FROM_SETTINGS, player, inventory)

    -- The character's inventory is prepared
    inventory.sort_and_merge()
    player.print({"qsd-log-message.info-startup-inventory"}, { color = COLOR_WHITE })

    if settings.global["qsd-setting-spidertron-enabled"].value then
        -- Place a Spidertron
        inventory.insert({name = "spidertron", count = 1})
        player.force.technologies["spidertron"].researched = true
        inventory.sort_and_merge()

        -- Find that Spidertron for configuration
        local spidertron = inventory.find_item_stack("spidertron")
        if not spidertron then
            player.print({"qsd-log-message.error-no-spidertron"}, { color = COLOR_RED })
            player.print({"qsd-log-message.warning-partial-start"}, { color = COLOR_YELLOW })
            return
        end
        spidertron.create_grid()

        -- Insert the Spidertron gear
        configure_gear(player, spidertron, SPIDER_GEAR)

        -- The Spidertron is prepared
        player.print({"qsd-log-message.info-startup-spidertron"}, { color = COLOR_WHITE })
    else
        player.print({"qsd-log-message.warning-spidertron-disabled"}, { color = COLOR_YELLOW })
    end

    -- Should the braking force be upgraded?
    if settings.global["qsd-setting-research-braking-enabled"].value then
        for key, technology in ipairs(BRAKING_TECHNOLOGY) do
            player.force.technologies[technology].researched = true
        end

        player.print({"qsd-log-message.info-startup-research-braking"}, { color = COLOR_WHITE })
    else
        player.print({"qsd-log-message.warning-research-braking-disabled"}, { color = COLOR_YELLOW })
    end

    -- Should the bot technology be upgraded?
    if settings.global["qsd-setting-research-bots-enabled"].value then
        -- Upgrade worker robot speed and robot storage
        for key, technology in ipairs(ROBOT_TECHNOLOGY) do
            player.force.technologies[technology].researched = true
        end

        player.print({"qsd-log-message.info-startup-research-robots"}, { color = COLOR_WHITE })
    else
        player.print({"qsd-log-message.warning-research-robots-disabled"}, { color = COLOR_YELLOW })
    end

    -- Should the mining technology be upgraded?
    if settings.global["qsd-setting-research-mining-enabled"].value then
        for key, technology in ipairs(MINING_TECHNOLOGY) do
            player.force.technologies[technology].researched = true
        end

        player.print({"qsd-log-message.info-startup-research-mining"}, { color = COLOR_WHITE })
    else
        player.print({"qsd-log-message.warning-research-mining-disabled"}, { color = COLOR_YELLOW })
    end

    -- Should quality research be upgraded?
    if settings.global["qsd-setting-research-quality-enabled"].value then
        player.force.technologies['epic-quality'].researched = true
        player.force.technologies['legendary-quality'].researched = true
        player.print({"qsd-log-message.info-startup-research-quality"}, { color = COLOR_WHITE })
    else
        player.print({"qsd-log-message.warning-research-quality-disabled"}, { color = COLOR_YELLOW })
    end

    -- Should lab research speed be upgraded?
    if settings.global["qsd-setting-research-speed-enabled"].value then
        for key, technology in ipairs(RESEARCH_TECHNOLOGY) do
            player.force.technologies[technology].researched = true
        end

        player.print({"qsd-log-message.info-startup-research-speed"}, { color = COLOR_WHITE })
    else
        player.print({"qsd-log-message.warning-research-speed-disabled"}, { color = COLOR_YELLOW })
    end

    -- Should the toolbelt technology be upgraded?
    if settings.global["qsd-setting-research-toolbelt-enabled"].value then
        player.force.technologies[TECH_TOOLBELT].researched = true
        player.print({"qsd-log-message.info-startup-research-toolbelt"}, { color = COLOR_WHITE })
    else
        player.print({"qsd-log-message.warning-research-toolbelt-disabled"}, { color = COLOR_YELLOW })
    end

    -- You Dun There Start Em Up
    player.print({"qsd-log-message.info-character-init"}, { color = COLOR_GREEN })
end)
