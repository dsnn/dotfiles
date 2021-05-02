if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end


DATA_PATH  = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')
