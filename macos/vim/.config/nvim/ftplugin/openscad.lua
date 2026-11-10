-- SCAD-only handoff: save -> full render -> open STL in the running Bambu Studio.
-- Keep exports outside the project, and retain them for Bambu's reload feature.
if vim.b.bambu_print_loaded then
  return
end
vim.b.bambu_print_loaded = true

local rendering = false
local function print_model()
  if rendering then
    vim.notify('A Bambu export is already rendering for this buffer.', vim.log.levels.WARN)
    return
  end
  local source = vim.api.nvim_buf_get_name(0)
  if source == '' or vim.bo.buftype ~= '' then
    vim.notify('Save this model to a .scad file first.', vim.log.levels.ERROR)
    return
  end
  local ok, err = pcall(vim.cmd, 'write')
  if not ok then
    vim.notify('Could not save model: ' .. tostring(err), vim.log.levels.ERROR)
    return
  end
  local openscad = vim.fn.exepath('openscad')
  if openscad == '' then
    vim.notify('OpenSCAD executable not found in PATH.', vim.log.levels.ERROR)
    return
  end
  local app = '/Applications/BambuStudio.app'
  if vim.fn.isdirectory(app) == 0 then
    vim.notify('Bambu Studio not found at ' .. app, vim.log.levels.ERROR)
    return
  end
  local directory = vim.fn.stdpath('cache') .. '/bambu-exports/' .. vim.fn.sha256(source):sub(1, 16)
  vim.fn.mkdir(directory, 'p')
  -- Unique names prevent a failed export from ever handing off an old STL.
  local output = directory .. '/' .. vim.fn.fnamemodify(source, ':t:r') .. '-' .. tostring(vim.uv.hrtime()) .. '.stl'
  rendering = true
  vim.notify('Rendering ' .. vim.fn.fnamemodify(source, ':t') .. ' for Bambu…')
  vim.system({ openscad, '-o', output, source }, { text = true, cwd = vim.fn.fnamemodify(source, ':h') }, function(result)
    vim.schedule(function()
      rendering = false
      if result.code ~= 0 or vim.fn.getfsize(output) <= 0 then
        vim.notify('OpenSCAD render failed; nothing sent to Bambu.\n' .. (result.stderr or '') .. (result.stdout or ''), vim.log.levels.ERROR)
        return
      end
      vim.system({ '/usr/bin/open', '-a', app, output }, { text = true }, function(open_result)
        vim.schedule(function()
          if open_result.code ~= 0 then
            vim.notify('Could not open Bambu Studio:\n' .. (open_result.stderr or ''), vim.log.levels.ERROR)
          else
            vim.notify('Rendered model sent to Bambu Studio.')
          end
        end)
      end)
    end)
  end)
end

vim.keymap.set('n', '<leader>p', print_model, { buffer = true, desc = 'Render and send to Bambu Studio' })
