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

-- String Constants

POWERED_KEY = "powered"
TECH_TOOLBELT = "toolbelt"
UNPOWERED_KEY = "unpowered"

-- Color Constants

COLOR_URDA   = {  0,  51, 153, 255}
COLOR_GREEN  = {  0, 255,   0, 255}
COLOR_RED    = {255,   0,   0, 255}
COLOR_WHITE  = {255, 255, 255, 255}
COLOR_YELLOW = {255, 255,   0, 255}

-- Array Constants

BRAKING_TECHNOLOGY = {
    'braking-force-1',
    'braking-force-2',
    'braking-force-3',
    'braking-force-4',
    'braking-force-5',
    'braking-force-6',
    'braking-force-7',
}

MINING_TECHNOLOGY = {
    'mining-productivity-1',
    'mining-productivity-2',
    'mining-productivity-3',
}

RESEARCH_TECHNOLOGY = {
    'research-speed-1',
    'research-speed-2',
    'research-speed-3',
    'research-speed-4',
    'research-speed-5',
    'research-speed-6',
}

ROBOT_TECHNOLOGY = {
    'worker-robots-speed-1',
    'worker-robots-speed-2',
    'worker-robots-speed-3',
    'worker-robots-speed-4',
    'worker-robots-speed-5',
    'worker-robots-storage-1',
    'worker-robots-storage-2',
    'worker-robots-storage-3'
}

-- Complex Constants

CHARACTER_GEAR = {
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

SPIDER_GEAR = {
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
