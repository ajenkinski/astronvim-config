--- Return true if a < b, but treating sequences of digits as numbers.
--- This means "problem-9-foo.txt" will come before "problem-10-bar.txt", without having to 0-pad numbers.
--- This will be used to customize neo-tree sorting.
--- @param a string
--- @param b string
--- @return boolean
local function mixed_cmp_strings(a, b)
  if string.find(a, "%d") == nil or string.find(b, "%d") == nil then
    return a < b
  end

  -- Split str into a list of alternating string, number parts.  So
  -- "problem-9-foo.txt" will become {"problem-", 9, "-foo.txt"}
  local function split(str)
    local parts = {}
    local init = 1

    repeat
      local s, e = string.find(str, "%d+", init)
      if s then
        if s > init then
          table.insert(parts, string.sub(str, init, s - 1))
        end
        table.insert(parts, tonumber(string.sub(str, s, e)))
        init = e + 1
      end
    until not s

    if init <= #str then
      table.insert(parts, string.sub(str, init))
    end

    return parts
  end

  local a_parts = split(a)
  local b_parts = split(b)

  for i = 1, #b_parts do
    if i > #a_parts then
      -- a_parts ends first, so it's smaller
      return true
    end

    local a_part, b_part = a_parts[i], b_parts[i]

    if type(a_part) ~= type(b_part) then
      a_part, b_part = tostring(a_part), tostring(b_part)
    end

    if a_part < b_part then
      return true
    elseif a_part > b_part then
      return false
    end
  end

  -- either a == b, or b ended before a which means a > b
  return false
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      sort_function = function(a, b)
        if a.type == b.type then
          return mixed_cmp_strings(a.path, b.path)
        else
          return a.type < b.type
        end
      end,
      filesystem = {
        commands = {
          -- custom command to run live grep in currently selected directory
          grep_in_directory = function(state)
            local node = state.tree:get_node()
            if not node then
              return
            end
            local dir = node.path
            if node.type == "file" then
              dir = vim.fs.dirname(dir)
            end

            require('telescope.builtin').live_grep({
              search_dirs = { dir },
              prompt_title = string.format('Grep in [%s]', vim.fs.basename(dir)),
            })
          end,
          start_command_with = function(state)
            local node = state.tree:get_node()
            if not node then
              return
            end
            return ": " .. vim.fn.fnamemodify(node.path, ":.") .. "<C-b>"
          end,
        },
        window = {
          mappings = {
            ["G"] = "grep_in_directory",
            ["E"] = {
              command = "start_command_with",
              expr = true,
              replace_keycodes = true,
            },
          }
        }
      },
      default_component_configs = {
        -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
        file_size = {
          enabled = false,
          required_width = 64, -- min width of window required to show this column
        },
        type = {
          enabled = false,
          required_width = 110, -- min width of window required to show this column
        },
        last_modified = {
          enabled = false,
          required_width = 88, -- min width of window required to show this column
        },
        created = {
          enabled = false,
          required_width = 120, -- min width of window required to show this column
        },
        symlink_target = {
          enabled = false,
        },
      },
    },
  },
}

