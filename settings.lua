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

data:extend({
    {
        type = "bool-setting",
        name = "qsd-setting-mod-enabled",
        setting_type = "runtime-global",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "qsd-setting-research-braking-enabled",
        setting_type = "runtime-global",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "qsd-setting-research-bots-enabled",
        setting_type = "runtime-global",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "qsd-setting-research-mining-enabled",
        setting_type = "runtime-global",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "qsd-setting-research-toolbelt-enabled",
        setting_type = "runtime-global",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "qsd-setting-spidertron-enabled",
        setting_type = "runtime-global",
        default_value = true
    },
    {
        type = "int-setting",
        name = "qsd-setting-big-electric-pole-size",
        setting_type = "runtime-global",
        default_value = 50,
        allowed_values = {0, 50, 100, 200, 400, 600, 800, 1000}
    },
    {
        type = "int-setting",
        name = "qsd-setting-construction-bot-size",
        setting_type = "runtime-global",
        default_value = 200,
        allowed_values = {0, 25, 50, 75, 100, 125, 150, 175, 200}
    },
    {
        type = "int-setting",
        name = "qsd-setting-lamp-size",
        setting_type = "runtime-global",
        default_value = 200,
        allowed_values = {0, 50, 100, 200, 400, 600, 800, 1000}
    },
    {
        type = "int-setting",
        name = "qsd-setting-radar-size",
        setting_type = "runtime-global",
        default_value = 50,
        allowed_values = {0, 25, 50, 75, 100, 125, 150, 175, 200}
    },
    {
        type = "int-setting",
        name = "qsd-setting-repair-pack-size",
        setting_type = "runtime-global",
        default_value = 200,
        allowed_values = {0, 200}
    },
    {
        type = "int-setting",
        name = "qsd-setting-steel-chest-size",
        setting_type = "runtime-global",
        default_value = 50,
        allowed_values = {0, 50, 100, 200, 400, 600, 800, 1000}
    }
})
