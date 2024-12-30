return {
    {'navarasu/onedark.nvim',
        lazy=false, -- always load
        priority=1000, -- load asap
        config=function()
            local onedark = require('onedark')
            onedark.setup{
                style = 'darker'
            }
            onedark.load()
        end,
    },
    {'nvim-tree/nvim-web-devicons',
        lazy=true, -- only load when depended on
    },
    {'norcalli/nvim-colorizer.lua', 
        lazy=true,
        ft={ -- only load for css or vue files
            'css',
            'vue',
        },
    },
    {'nvim-lualine/lualine.nvim', 
        lazy=false, -- always load
        dependencies={
            'nvim-tree/nvim-web-devicons',
        },
    },
}
