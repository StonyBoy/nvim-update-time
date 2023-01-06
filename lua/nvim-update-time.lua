-- Steen Hegelund
-- Time-Stamp: 2023-Jan-06 00:01
-- Update a Timestamp in the beginning of a file
-- vim: set ts=2 sw=2 sts=2 tw=120 et cc=120 ft=lua :

local Module = {
  enabled = true,
  options = {
    first = 0,
    last = 10,
    pattern = 'Time-Stamp: ',
    format = '%Y-%b-%d %H:%M',
  }
}

local function set_buffer_time_stamp(bufno, lineno, byteno, line)
  local startrow = lineno - 1
  local startcol = #Module.options.pattern + byteno
  local endcol = #line

  if startcol == #line then
    endcol = startcol
  end

  vim.api.nvim_buf_set_text(bufno, startrow, startcol, startrow, endcol, {vim.fn.strftime(Module.options.format)})
end

local function update_time_stamp(bufno)
  if not Module.enabled then
    return
  end

  if not vim.bo[bufno].modifiable then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufno, Module.options.first, Module.options.last, false)

  local regex = vim.regex(Module.options.pattern)
  for lineno, line in ipairs(lines) do
    local byteno = regex:match_str(line)
    if byteno then
      set_buffer_time_stamp(bufno, lineno, byteno, line)
    end
  end
end

Module.setup = function(opts)
  if opts then
    for name, val in pairs(opts) do
      Module.options[name] = val
    end
  end
end

local function update_current_buffer()
  update_time_stamp(0)
end

local function update_time_toggle()
  Module.enabled = not Module.enabled
  if Module.enabled then
    print('File Timestamps are enabled')
  else
    print('File Timestamps are disabled')
  end
end


vim.api.nvim_create_user_command('UpdateTimeStamp', update_current_buffer, {})
vim.api.nvim_create_user_command('UpdateTimeToggle', update_time_toggle, {})

-- Used for testing
-- local function test_timestamp()
--   Module.setup({})
--   update_time_stamp(10)
-- end
-- vim.api.nvim_set_keymap('n', '<Leader>wt', '', { noremap = true, silent = true, callback = test_timestamp })

-- Trigger an update before the buffer is written to disk
local grp = vim.api.nvim_create_augroup('nvim_update_time', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  group = grp,
  pattern = {'*'},
  callback = function(args)
    update_time_stamp(args.buf)
  end,
})

return Module
