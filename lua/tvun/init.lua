local M = {}

local function vim_navigate(direction)
  if vim.fn.winnr() ~= vim.fn.winnr(direction) then
    vim.cmd.wincmd(direction)
  else
    if direction == 'h' then
      vim.fn.system('tmux select-pane -L')
    elseif direction == 'j' then
      vim.fn.system('tmux select-pane -D')
    elseif direction == 'k' then
      vim.fn.system('tmux select-pane -U')
    elseif direction == 'l' then
      vim.fn.system('tmux select-pane -R')
    end
  end
end

function M.Vnleft() vim_navigate('h') end
function M.Vndown() vim_navigate('j') end
function M.Vnup() vim_navigate('k') end
function M.Vndown() vim_navigate('l') end

return M
