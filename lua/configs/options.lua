local function opt(scope, key, value)
  scopes[scope][key] = value
  if scopes ~= "o" then
    scopes["o"][key] = value
  end
end

vim.cmd([[
	set noswapfile
]])
