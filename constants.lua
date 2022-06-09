-- Configure local constants
POWERED_KEY = "powered"
UNPOWERED_KEY = "unpowered"

COLOR_GREEN =  {  0, 255,   0, 255}
COLOR_RED =    {255,   0,   0, 255}
COLOR_WHITE =  {255, 255, 255, 255}
COLOR_YELLOW = {255, 255,   0, 255}

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
