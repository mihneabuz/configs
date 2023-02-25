local success, alpha = pcall(require, "alpha")
if not success then
  return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.opts.hl = "Constant";
dashboard.section.header.val = {
    "                                                     ",
    "                                                     ",
    "                                                     ",
    "                                                     ",
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
    "                                                     ",
    "                                                     ",
}

dashboard.section.buttons.val = {
    dashboard.button("e", "    New file" , ":ene<CR>"),
    dashboard.button("f", "    Find file", ":Telescope find_files<CR>"),
    dashboard.button("t", " פּ   File Tree", ":ene<CR>:NvimTreeOpen<CR>"),
    dashboard.button("r", "    Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button("p", "    Projects" , ":Telescope projects<CR>"),
    dashboard.button("s", "    Settings" , ":e $MYVIMRC<CR>"),
    dashboard.button("k", "    Keybinds" , ":Keybinds<CR>"),
    dashboard.button("m", "    Mason"    , ":Mason<CR>"),
    dashboard.button("u", "    Update"   , ":TSUpdate<CR>:PackerSync<CR>"),
    dashboard.button("q", "    Quit"     , ":qa<CR>"),
}

alpha.setup(dashboard.opts)
