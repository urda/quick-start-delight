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

require("constants")

--- Configure an equipment grid given input specs.
--
-- @usage configure_gear(character, CHARACTER_GEAR)
--
-- @param gear_to_load The target character, spidertron, or other equipment grid.
-- @param gear_loadout The gear to load into the equipment grid.
--
function configure_gear(gear_to_load, gear_loadout)
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

--- Given a loadout specification, load a given target player's inventory.
--- Also deals with 0 and negative value item counts (Bugfix for 1.1.0 -> 1.1.1).
--
-- @usage load_gear(gear_loadout, player, inventory)
--
-- @param loadout_specs The loadout specification to process.
-- @param target_player The current player
-- @param target_inventory The player's inventory
--
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
