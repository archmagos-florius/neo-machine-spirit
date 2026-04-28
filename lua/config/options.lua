vim.opt.number 		= true
vim.opt.cursorline 	= true
vim.opt.relativenumber 	= true
vim.opt.shiftwidth	= 4 

function _G.navic_winbar()
  local ok, navic = pcall(require, "nvim-navic")
  if not ok or not navic.is_available() then
    return ""
  end

  local location = navic.get_location()
  if location == "" then
    return ""
  end

  return location
end

vim.o.winbar = "%{%v:lua.navic_winbar()%}"
