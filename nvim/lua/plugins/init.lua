return {

  -- Folke Plugins
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          {
            pane = 2,
            section = "terminal",
            cmd = "colorscript -e square",
            height = 5,
            padding = 1,
          },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
      indent = {
        enabled = true,

        priority = 1,
        char = "│",
        only_scope = false,   -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window


      },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      explorer = {
        enabled = true,
        hijack_netrw = true,
      },

      picker = {
        enabled = true,
        debug = { scores = false, leaks = false, explorer = true, files = true },
        sources = {
          files_with_symbols = {
            multi = { "files", "lsp_symbols" },
            filter = {
              ---@param p snacks.Picker
              ---@param filter snacks.picker.Filter
              transform = function(p, filter)
                local symbol_pattern = filter.pattern:match("^.-@(.*)$")
                -- store the current file buffer
                if filter.source_id ~= 2 then
                  local item = p:current()
                  if item and item.file then
                    filter.meta.buf = vim.fn.bufadd(item.file)
                  end
                end

                if symbol_pattern and filter.meta.buf then
                  filter.pattern = symbol_pattern
                  filter.current_buf = filter.meta.buf
                  filter.source_id = 2
                else
                  filter.source_id = 1
                end
              end,
            },
          },
          explorer = {
            focus = "input",
            auto_close = true,
            hidden = true,

            toggles = {
              search_dir = "D",
            },
            transform = function(item, ctx)
              local is_searching = ctx.picker.input.filter.meta.searching
              if is_searching and ctx.picker.opts.search_dir then
                return item.dir or false
              end
            end,
            win = {
              input = {
                keys = {
                  ["<M-d>"] = { "toggle_search_dir", mode = { "i", "n" } },
                },
              },
              list = {
                keys = {
                  ["<M-d>"] = "toggle_search_dir",
                },
              },
            },

            layout = {
              cycle = true,
              preset = function()
                return vim.o.columns >= 120 and "default" or "vertical"
              end,
              preview = "preview",
            },

          },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader>sm", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
      { "<leader>b",  function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>ps", function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>:",  function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>n",  function() Snacks.picker.notifications() end,                           desc = "Notification History" },
      { "<leader>fb", function() Snacks.picker.explorer() end,                                desc = "File Explorer" },
      -- find
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>pf", function() Snacks.picker.files() end,                                   desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
      { "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
      { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },
      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
      { "<leader>gl", function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
      { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
      { "<leader>gd", function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end,                               desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end,                          desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
      { "<leader>sb", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sc", function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end,                                desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end,                                    desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end,                              desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end,                                   desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end,                                 desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end,                                   desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end,                                     desc = "Man Pages" },
      { "<leader>sp", function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
      { "<leader>sR", function() Snacks.picker.resume() end,                                  desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end,                                    desc = "Undo History" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
      -- LSP
      { "gd",         function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
      { "gD",         function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
      { "gr",         function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
      { "gI",         function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
      { "gy",         function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },


      -- TS shortcuts
      {
        "<leader>e",
        function()
          Snacks.picker.diagnostics({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Show only errors (picker)",
      },
      {
        "<leader>fe",
        function()
          local diagnostics = vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR })
          if #diagnostics == 0 then
            vim.notify("No errors found", vim.log.levels.INFO)
            return
          end
          table.sort(diagnostics, function(a, b)
            if a.bufnr == b.bufnr then
              return a.lnum < b.lnum
            end
            return a.bufnr < b.bufnr
          end)
          vim.api.nvim_set_current_buf(diagnostics[1].bufnr)
          vim.api.nvim_win_set_cursor(0, { diagnostics[1].lnum + 1, diagnostics[1].col })
        end,
        desc = "Go to first error",
      },
      -- Cycle through TypeScript errors
      {
        "]e",
        function()
          local current_buf = vim.api.nvim_get_current_buf()
          local current_pos = vim.api.nvim_win_get_cursor(0)
          local current_line = current_pos[1] - 1
          local current_col = current_pos[2]

          -- Get all errors from all buffers
          local diagnostics = vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR })

          if #diagnostics == 0 then
            vim.notify("No errors found", vim.log.levels.INFO)
            return
          end

          -- Sort by buffer and line number
          table.sort(diagnostics, function(a, b)
            if a.bufnr == b.bufnr then
              if a.lnum == b.lnum then
                return a.col < b.col
              end
              return a.lnum < b.lnum
            end
            return a.bufnr < b.bufnr
          end)

          -- Find next error after current position
          local next_error = nil
          local current_idx = nil
          for i, diagnostic in ipairs(diagnostics) do
            if diagnostic.bufnr == current_buf and (diagnostic.lnum > current_line or (diagnostic.lnum == current_line and diagnostic.col > current_col)) then
              next_error = diagnostic
              current_idx = i
              break
            elseif diagnostic.bufnr > current_buf then
              next_error = diagnostic
              current_idx = i
              break
            end
          end

          -- If no next error found, wrap to first
          if not next_error then
            next_error = diagnostics[1]
            current_idx = 1
          end

          vim.api.nvim_set_current_buf(next_error.bufnr)
          vim.api.nvim_win_set_cursor(0, { next_error.lnum + 1, next_error.col })
          vim.cmd("normal! zz")
          vim.notify(string.format("Error %d/%d", current_idx, #diagnostics), vim.log.levels.INFO)
        end,
        desc = "Next error",
      },
      {
        "[e",
        function()
          local current_buf = vim.api.nvim_get_current_buf()
          local current_pos = vim.api.nvim_win_get_cursor(0)
          local current_line = current_pos[1] - 1
          local current_col = current_pos[2]

          -- Get all errors from all buffers
          local diagnostics = vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR })

          if #diagnostics == 0 then
            vim.notify("No errors found", vim.log.levels.INFO)
            return
          end

          -- Sort by buffer and line number
          table.sort(diagnostics, function(a, b)
            if a.bufnr == b.bufnr then
              if a.lnum == b.lnum then
                return a.col < b.col
              end
              return a.lnum < b.lnum
            end
            return a.bufnr < b.bufnr
          end)

          -- Find previous error before current position
          local prev_error = nil
          local current_idx = nil
          for i = #diagnostics, 1, -1 do
            local diagnostic = diagnostics[i]
            if diagnostic.bufnr == current_buf and (diagnostic.lnum < current_line or (diagnostic.lnum == current_line and diagnostic.col < current_col)) then
              prev_error = diagnostic
              current_idx = i
              break
            elseif diagnostic.bufnr < current_buf then
              prev_error = diagnostic
              current_idx = i
              break
            end
          end

          -- If no previous error found, wrap to last
          if not prev_error then
            prev_error = diagnostics[#diagnostics]
            current_idx = #diagnostics
          end

          vim.api.nvim_set_current_buf(prev_error.bufnr)
          vim.api.nvim_win_set_cursor(0, { prev_error.lnum + 1, prev_error.col })
          vim.cmd("normal! zz")
          vim.notify(string.format("Error %d/%d", current_idx, #diagnostics), vim.log.levels.INFO)
        end,
        desc = "Previous error",
      },
      -- Merge conflict navigation
      {
        "<leader>fc",
        function()
          Snacks.picker.grep({ search = "^<<<<<<<" })
        end,
        desc = "Find merge conflicts (picker)",
      },
      {
        "<leader>mc",
        function()
          -- Search for merge conflict markers in all buffers
          local conflict_pattern = "^<<<<<<<" -- Fixed: removed space for consistency
          local found = false

          -- Get all loaded buffers
          local buffers = vim.api.nvim_list_bufs()
          local conflicts = {}

          for _, bufnr in ipairs(buffers) do
            if vim.api.nvim_buf_is_loaded(bufnr) then
              local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
              for lnum, line in ipairs(lines) do
                if line:match(conflict_pattern) then
                  table.insert(conflicts, { bufnr = bufnr, lnum = lnum - 1, line = line })
                end
              end
            end
          end

          if #conflicts == 0 then
            vim.notify("No merge conflicts found", vim.log.levels.INFO)
            return
          end

          -- Sort by buffer and line number
          table.sort(conflicts, function(a, b)
            if a.bufnr == b.bufnr then
              return a.lnum < b.lnum
            end
            return a.bufnr < b.bufnr
          end)

          -- Jump to first conflict
          vim.api.nvim_set_current_buf(conflicts[1].bufnr)
          vim.api.nvim_win_set_cursor(0, { conflicts[1].lnum + 1, 0 })
          vim.cmd("normal! zz")
          vim.notify(string.format("Conflict 1/%d", #conflicts), vim.log.levels.INFO)
        end,
        desc = "Go to first merge conflict",
      },
      {
        "]n",
        function()
          local conflict_pattern = "^<<<<<<<" -- Fixed: consistent pattern
          local current_buf = vim.api.nvim_get_current_buf()
          local current_pos = vim.api.nvim_win_get_cursor(0)
          local current_line = current_pos[1] - 1

          -- Get all loaded buffers
          local buffers = vim.api.nvim_list_bufs()
          local conflicts = {}

          for _, bufnr in ipairs(buffers) do
            if vim.api.nvim_buf_is_loaded(bufnr) then
              local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
              for lnum, line in ipairs(lines) do
                if line:match(conflict_pattern) then
                  table.insert(conflicts, { bufnr = bufnr, lnum = lnum - 1 })
                end
              end
            end
          end

          if #conflicts == 0 then
            vim.notify("No merge conflicts found", vim.log.levels.INFO)
            return
          end

          -- Sort by buffer and line number
          table.sort(conflicts, function(a, b)
            if a.bufnr == b.bufnr then
              return a.lnum < b.lnum
            end
            return a.bufnr < b.bufnr
          end)

          -- Find next conflict after current position
          -- Fixed: Simplified logic to avoid redundant checks
          local next_conflict = nil
          local current_idx = nil
          for i, conflict in ipairs(conflicts) do
            -- Check if this conflict is after our current position
            if conflict.bufnr > current_buf or
                (conflict.bufnr == current_buf and conflict.lnum > current_line) then
              next_conflict = conflict
              current_idx = i
              break
            end
          end

          -- If no next conflict found, wrap to first
          if not next_conflict then
            next_conflict = conflicts[1]
            current_idx = 1
          end

          vim.api.nvim_set_current_buf(next_conflict.bufnr)
          vim.api.nvim_win_set_cursor(0, { next_conflict.lnum + 1, 0 })
          vim.cmd("normal! zz")
          vim.notify(string.format("Conflict %d/%d", current_idx, #conflicts), vim.log.levels.INFO)
        end,
        desc = "Next merge conflict",
      },
      {
        "[n",
        function()
          local conflict_pattern = "^<<<<<<<" -- Fixed: consistent pattern
          local current_buf = vim.api.nvim_get_current_buf()
          local current_pos = vim.api.nvim_win_get_cursor(0)
          local current_line = current_pos[1] - 1

          -- Get all loaded buffers
          local buffers = vim.api.nvim_list_bufs()
          local conflicts = {}

          for _, bufnr in ipairs(buffers) do
            if vim.api.nvim_buf_is_loaded(bufnr) then
              local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
              for lnum, line in ipairs(lines) do
                if line:match(conflict_pattern) then
                  table.insert(conflicts, { bufnr = bufnr, lnum = lnum - 1 })
                end
              end
            end
          end

          if #conflicts == 0 then
            vim.notify("No merge conflicts found", vim.log.levels.INFO)
            return
          end

          -- Sort by buffer and line number
          table.sort(conflicts, function(a, b)
            if a.bufnr == b.bufnr then
              return a.lnum < b.lnum
            end
            return a.bufnr < b.bufnr
          end)

          -- Find previous conflict before current position
          -- Fixed: Simplified logic to avoid redundant checks
          local prev_conflict = nil
          local current_idx = nil
          for i = #conflicts, 1, -1 do
            local conflict = conflicts[i]
            -- Check if this conflict is before our current position
            if conflict.bufnr < current_buf or
                (conflict.bufnr == current_buf and conflict.lnum < current_line) then
              prev_conflict = conflict
              current_idx = i
              break
            end
          end

          -- If no previous conflict found, wrap to last
          if not prev_conflict then
            prev_conflict = conflicts[#conflicts]
            current_idx = #conflicts
          end

          vim.api.nvim_set_current_buf(prev_conflict.bufnr)
          vim.api.nvim_win_set_cursor(0, { prev_conflict.lnum + 1, 0 })
          vim.cmd("normal! zz")
          vim.notify(string.format("Conflict %d/%d", current_idx, #conflicts), vim.log.levels.INFO)
        end,
        desc = "Previous merge conflict",
      },
      -- Merge conflict resolution
      {
        "<leader>ch",
        function()
          -- Find conflict markers around cursor
          local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

          local start_marker = nil
          local middle_marker = nil
          local end_marker = nil

          -- Search backwards for start marker
          for i = cursor_line, 1, -1 do
            if lines[i] and lines[i]:match("^<<<<<<<") then
              start_marker = i
              break
            end
          end

          if not start_marker then
            vim.notify("No merge conflict found", vim.log.levels.WARN)
            return
          end

          -- Search forward from start for middle and end markers
          for i = start_marker + 1, #lines do
            if lines[i] and lines[i]:match("^=======") and not middle_marker then
              middle_marker = i
            elseif lines[i] and lines[i]:match("^>>>>>>>") then
              end_marker = i
              break
            end
          end

          if not middle_marker or not end_marker then
            vim.notify("Incomplete merge conflict markers", vim.log.levels.WARN)
            return
          end

          -- Delete incoming changes and markers, keep HEAD
          -- Delete from middle marker to end marker (inclusive)
          vim.api.nvim_buf_set_lines(0, middle_marker - 1, end_marker, false, {})
          -- Delete start marker
          vim.api.nvim_buf_set_lines(0, start_marker - 1, start_marker, false, {})

          vim.notify("Kept HEAD (ours), removed incoming", vim.log.levels.INFO)
        end,
        desc = "Keep HEAD section (ours)",
      },
      {
        "<leader>ci",
        function()
          -- Find conflict markers around cursor
          local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

          local start_marker = nil
          local middle_marker = nil
          local end_marker = nil

          -- Search backwards for start marker
          for i = cursor_line, 1, -1 do
            if lines[i] and lines[i]:match("^<<<<<<<") then
              start_marker = i
              break
            end
          end

          if not start_marker then
            vim.notify("No merge conflict found", vim.log.levels.WARN)
            return
          end

          -- Search forward from start for middle and end markers
          for i = start_marker + 1, #lines do
            if lines[i] and lines[i]:match("^=======") and not middle_marker then
              middle_marker = i
            elseif lines[i] and lines[i]:match("^>>>>>>>") then
              end_marker = i
              break
            end
          end

          if not middle_marker or not end_marker then
            vim.notify("Incomplete merge conflict markers", vim.log.levels.WARN)
            return
          end

          -- Delete HEAD section and markers, keep incoming
          -- Delete from start marker to middle marker (inclusive)
          vim.api.nvim_buf_set_lines(0, start_marker - 1, middle_marker, false, {})
          -- Delete end marker (now at position start_marker - 1 due to previous deletion)
          vim.api.nvim_buf_set_lines(0, start_marker - 1 + (end_marker - middle_marker - 1),
            start_marker + (end_marker - middle_marker - 1), false, {})

          vim.notify("Kept incoming (theirs), removed HEAD", vim.log.levels.INFO)
        end,
        desc = "Keep incoming section (theirs)",
      },
      {
        "<leader>vh",
        function()
          -- Find conflict markers and visually select HEAD section
          local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

          local start_marker = nil
          local middle_marker = nil

          -- Search backwards for start marker
          for i = cursor_line, 1, -1 do
            if lines[i] and lines[i]:match("^<<<<<<<") then
              start_marker = i
              break
            end
          end

          if not start_marker then
            vim.notify("No merge conflict found", vim.log.levels.WARN)
            return
          end

          -- Search forward for middle marker
          for i = start_marker + 1, #lines do
            if lines[i] and lines[i]:match("^=======") then
              middle_marker = i
              break
            end
          end

          if not middle_marker then
            vim.notify("Incomplete merge conflict markers", vim.log.levels.WARN)
            return
          end

          -- Visually select from line after start marker to line before middle marker
          vim.api.nvim_win_set_cursor(0, { start_marker + 1, 0 })
          vim.cmd("normal! V")
          vim.api.nvim_win_set_cursor(0, { middle_marker - 1, 999 })
        end,
        desc = "Visually select HEAD section",
      },
      {
        "<leader>vi",
        function()
          -- Find conflict markers and visually select incoming section
          local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

          local start_marker = nil
          local middle_marker = nil
          local end_marker = nil

          -- Search backwards for start marker
          for i = cursor_line, 1, -1 do
            if lines[i] and lines[i]:match("^<<<<<<<") then
              start_marker = i
              break
            end
          end

          if not start_marker then
            vim.notify("No merge conflict found", vim.log.levels.WARN)
            return
          end

          -- Search forward for middle and end markers
          for i = start_marker + 1, #lines do
            if lines[i] and lines[i]:match("^=======") and not middle_marker then
              middle_marker = i
            elseif lines[i] and lines[i]:match("^>>>>>>>") then
              end_marker = i
              break
            end
          end

          if not middle_marker or not end_marker then
            vim.notify("Incomplete merge conflict markers", vim.log.levels.WARN)
            return
          end

          -- Visually select from line after middle marker to line before end marker
          vim.api.nvim_win_set_cursor(0, { middle_marker + 1, 0 })
          vim.cmd("normal! V")
          vim.api.nvim_win_set_cursor(0, { end_marker - 1, 999 })
        end,
        desc = "Visually select incoming section",
      },
      {
        "<leader>cb",
        function()
          -- Find conflict markers and keep both sections (remove only markers)
          local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

          local start_marker = nil
          local middle_marker = nil
          local end_marker = nil

          -- Search backwards for start marker
          for i = cursor_line, 1, -1 do
            if lines[i] and lines[i]:match("^<<<<<<<") then
              start_marker = i
              break
            end
          end

          if not start_marker then
            vim.notify("No merge conflict found", vim.log.levels.WARN)
            return
          end

          -- Search forward from start for middle and end markers
          for i = start_marker + 1, #lines do
            if lines[i] and lines[i]:match("^=======") and not middle_marker then
              middle_marker = i
            elseif lines[i] and lines[i]:match("^>>>>>>>") then
              end_marker = i
              break
            end
          end

          if not middle_marker or not end_marker then
            vim.notify("Incomplete merge conflict markers", vim.log.levels.WARN)
            return
          end

          -- Delete markers in reverse order to maintain line numbers
          -- Delete end marker
          vim.api.nvim_buf_set_lines(0, end_marker - 1, end_marker, false, {})
          -- Delete middle marker
          vim.api.nvim_buf_set_lines(0, middle_marker - 1, middle_marker, false, {})
          -- Delete start marker
          vim.api.nvim_buf_set_lines(0, start_marker - 1, start_marker, false, {})

          vim.notify("Kept both sections, removed markers", vim.log.levels.INFO)
        end,
        desc = "Keep both sections (remove markers only)",
      },
      {
        "<leader>cn",
        function()
          -- Find conflict markers and delete entire conflict block
          local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

          local start_marker = nil
          local middle_marker = nil
          local end_marker = nil

          -- Search backwards for start marker
          for i = cursor_line, 1, -1 do
            if lines[i] and lines[i]:match("^<<<<<<<") then
              start_marker = i
              break
            end
          end

          if not start_marker then
            vim.notify("No merge conflict found", vim.log.levels.WARN)
            return
          end

          -- Search forward from start for middle and end markers
          for i = start_marker + 1, #lines do
            if lines[i] and lines[i]:match("^=======") and not middle_marker then
              middle_marker = i
            elseif lines[i] and lines[i]:match("^>>>>>>>") then
              end_marker = i
              break
            end
          end

          if not middle_marker or not end_marker then
            vim.notify("Incomplete merge conflict markers", vim.log.levels.WARN)
            return
          end

          -- Delete entire conflict block from start to end marker (inclusive)
          vim.api.nvim_buf_set_lines(0, start_marker - 1, end_marker, false, {})

          vim.notify("Deleted entire conflict block", vim.log.levels.INFO)
        end,
        desc = "Delete entire conflict (keep neither)",
      },
      -- Other
      { "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom" },
      { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse",               mode = { "n", "v" } },
      { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
      { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
      { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
      { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",           mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",           mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
      {
        "<leader>?",
        desc = "Keybindings Cheat Sheet",
        function()
          local config_path = vim.fn.stdpath("config")
          local cheatsheet_path = config_path .. "/doc/keybindings.md"

          Snacks.win({
            file = cheatsheet_path,
            width = 0.8,
            height = 0.8,
            wo = {
              spell = false,
              wrap = true,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 0,
            },
            ft = "markdown",
          })
        end,
      }

    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
            "<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
          -- Toggle the profiler
          Snacks.toggle.profiler():map("<leader>pp")
          -- Toggle the profiler highlights
          Snacks.toggle.profiler_highlights():map("<leader>ph")
        end,
      })
    end,
  },

  {
    "folke/which-key.nvim",
    config = function()
      require("plugins.which-key")
    end,
  },


  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        -- Negatives: Not repeatable with ; and ,
        -- But do I REALLY need ; ?. It works with macros so, meh.
        char = {
          enabled = false,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash: Jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash: Select Treesitter",
      },

      -- o (Operator-pending mode): d, y, or c
      -- Example: y { r <jump> } i w
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Flash: Remote",
      },

      -- x (Visual mode - exclusive selection)
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash: Remote Treesitter",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        presets = {
          bottom_search = false,
          command_palette = true
        },
        views = {
          cmdline_popup = {
            position = {
              row = 5,
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
          },
          popupmenu = {
            relative = "editor",
            position = {
              row = 8,
              col = "50%",
            },
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
          },
        },
      })
    end,
  },


  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.harpoon")
    end,
  },

  --   -- Treesitter and related plugins
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-context",

  --   -- Comments
  'numToStr/Comment.nvim',
  'JoosepAlviste/nvim-ts-context-commentstring',

  -- Colorschemes and UI enhancements
  {
    "rose-pine/neovim",

    config = function()
      require("plugins.rose-pine")
    end,
  },

  {
    "scottmckendry/cyberdream.nvim",


    config = function()
      require("cyberdream").setup({
        -- Set light or dark variant
        variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`

        -- Enable transparent background
        transparent = true,

        -- Reduce the overall saturation of colours for a more muted look
        saturation = 1, -- accepts a value between 0 and 1. 0 will be fully desaturated (greyscale) and 1 will be the full color (default)

        -- Enable italics comments
        italic_comments = false,

        -- Replace all fillchars with ' ' for the ultimate clean look
        hide_fillchars = false,

        -- Apply a modern borderless look to pickers like Telescope, Snacks Picker & Fzf-Lua
        borderless_pickers = false,

        -- Set terminal colors used in `:terminal`
        terminal_colors = true,

        -- Improve start up time by caching highlights. Generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
        cache = false,

        -- Override highlight groups with your own colour values
        highlights = {
          -- Highlight groups to override, adding new groups is also possible
          -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

          -- Example:
          Comment = { fg = "#696969", bg = "NONE", italic = false },

          -- More examples can be found in `lua/cyberdream/extensions/*.lua`
        },

        -- Override a highlight group entirely using the built-in colour palette
        overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
          -- Example:
          -- return {
          --   Comment = { fg = colors.green, bg = "NONE", italic = true },
          --   ["@property"] = { fg = colors.magenta, bold = true },
          -- }
        end,

        -- Override colors
        colors = {
          -- For a list of colors see `lua/cyberdream/colours.lua`

          -- Override colors for both light and dark variants
          bg = "#000000",
          green = "#00ff00",

          -- If you want to override colors for light or dark variants only, use the following format:
          dark = {
            magenta = "#ff00ff",
            fg = "#eeeeee",
          },
          light = {
            red = "#ff5c57",
            cyan = "#5ef1ff",
          },
        },

        -- Disable or enable colorscheme extensions
        extensions = {
          telescope = true,
          notify = true,
          mini = true,
        },
      })


      vim.cmd([[colorscheme cyberdream]])
    end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",

    config = function()
      local function apply_oxocarbon_overrides()
        if vim.g.colors_name ~= "oxocarbon" then return end

        local c = {
          bg     = "#0b0f14",
          bg_alt = "#11151a",
          gray3  = "#2a2f33",
          gray6  = "#4a4f55",
          gray2  = "#7f8b92",
          blue   = "#3aa7ff",
          cyan   = "#00cafe",
          pink   = "#ff66b2",
          purple = "#9b6bff",
          black  = "#000000",
          white  = "#e6eef6",
        }

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.gray3, bg = "none" })



        -- Make React component names yellow (in imports and usage)
        local yellow = "#fed62f" -- matches RainbowDelimiterYellow
        -- @type.tsx links to Type, so set both
        vim.api.nvim_set_hl(0, "Type", { fg = yellow })
        vim.api.nvim_set_hl(0, "@type", { fg = yellow })
        vim.api.nvim_set_hl(0, "@type.tsx", { fg = yellow })
        vim.api.nvim_set_hl(0, "@type.typescript", { fg = yellow })
        vim.api.nvim_set_hl(0, "@type.typescriptreact", { fg = yellow })

        -- Picker highlights - make selection more distinct from paths
        vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#be95ff" }) -- purple, visible on dark bg
        vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = "#f2f4f8" })
        vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = yellow, bold = true })
        vim.api.nvim_set_hl(0, "SnacksPickerRow", { bg = "none" })
        vim.api.nvim_set_hl(0, "SnacksPickerSelected", { bg = "#525252" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#393939" })

        -- Explorer highlights - brighter files, distinct hidden files
        vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = "#82cfff" })  -- cyan for hidden/dotfiles
        vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = "#6f6f6f" }) -- dim for ignored
        vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = "#dde1e6" })        -- brighter files
        vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#be95ff" })         -- purple dirs
        vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "none" })
        vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = "#78a9ff", bold = true })

        -- Common oxocarbon colors you can use:
        -- #f2f4f8 (white), #dde1e6 (light gray), #be95ff (purple)
        -- #78a9ff (blue), #82cfff (cyan), #33b1ff (bright blue)
        -- #ee5396 (magenta), #ff7eb6 (pink), #42be65 (green)
        -- #393939, #525252, #6f6f6f (grays for backgrounds)
        --

        --
        -- -- Main picker window
        -- vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = c.gray6, bg = c.bg_alt })
        -- vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = c.black, bg = c.blue, bold = true })
        -- vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = c.cyan, bg = c.bg_alt })
        -- vim.api.nvim_set_hl(0, "SnacksPickerPromptIcon", { fg = c.cyan })
        -- vim.api.nvim_set_hl(0, "SnacksPickerSelection", { bg = c.gray3 })
        -- vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = c.pink })
        --
        -- -- Files / directories list
        -- vim.api.nvim_set_hl(0, "SnacksPickerDirectory", { fg = c.blue })
        -- vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = c.white })
        --
        -- -- Preview window
        -- vim.api.nvim_set_hl(0, "SnacksPickerPreviewTitle", { fg = c.black, bg = c.purple })
        -- vim.api.nvim_set_hl(0, "SnacksPickerPreviewBorder", { fg = c.gray6 })
        --
        -- -- Explorer
        -- vim.api.nvim_set_hl(0, "SnacksTreeIndent", { fg = c.gray6 })
        -- vim.api.nvim_set_hl(0, "SnacksTreeFolder", { fg = c.blue })
        -- vim.api.nvim_set_hl(0, "SnacksTreeFile", { fg = c.white })
        -- vim.api.nvim_set_hl(0, "SnacksTreeSelection", { bg = c.gray3 })
        --
        -- -- Generic floats (helps match the screenshot)
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = c.bg_alt })
        -- vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.gray6, bg = c.bg_alt })
      end

      -- Apply on colorscheme change
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "oxocarbon",
        callback = apply_oxocarbon_overrides,
      })

      vim.opt.background = "dark"
      vim.cmd("colorscheme oxocarbon")
    end,

  },

  { "nvim-tree/nvim-web-devicons", opt = true },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("plugins.lualine")
    end,
  },


  "rcarriga/nvim-notify",
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("plugins.rainbow-delimiters")
    end,
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
      refresh_interval = 400,
      bookmark_0 = {
        sign = "⚑",
        annotate = false,
      },
    },
  },



  {
    'petertriho/nvim-scrollbar',
    config = function()
      require("plugins.scrollbar")
    end
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.gitsigns")
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("plugins.neogit")
    end,
  },


  -- LSP and completion
  {
    "williamboman/mason.nvim",
    config = function()
      require("plugins.mason")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("plugins.mason-lspconfig")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end,
  },
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "onsails/lspkind-nvim",
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
    config = function()
      require("plugins.completions")
    end,
  },
  "kshenoy/vim-signature",
  -- Utilities
  {
    "mbbill/undotree",
    config = function()
      require("plugins.undotree")
    end,
  },

  --   Database
  "tpope/vim-surround",
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-completion",
  "kristijanhusak/vim-dadbod-ui",

  {
    "stevearc/conform.nvim",
    config = function()
      require("plugins.conform")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.nvim-autopairs")
    end,
  },

  {
    "MunifTanjim/prettier.nvim",
    config = function()
      require("plugins.prettier")
    end,
  },
  --
  --   allows me to do make it rain so unnecessary so cool
  "eandrju/cellular-automaton.nvim",


  -- markdown formatting
  "iamcco/markdown-preview.nvim",
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  },

  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      position = "top-right",
      timeout = 1,
      maxkeys = 5,
    },
  },
  --
  --   -- Custom plugins
  {
    "samjwill/nvim-unception",
    dependencies = { "numToStr/FTerm.nvim" },
    init = function()
      vim.g.unception_open_buffer_in_new_tab = true
    end,
    config = function()
      require("plugins.unception")
    end,
  },
  --

  --
  ---- -- Experimental
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      require("plugins.neocodeium")
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugins.colorizer")
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
      provider = "copilot",
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",      -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  --   {
  --   "Mofiqul/dracula.nvim",
  --   config = function()
  --     require("plugins.dracula")
  --   end,
  -- },

  --   {
  --     "ggandor/leap.nvim",
  --     config = function()
  --       require("plugins.leap")
  --     end,
  --   },


  --   {
  --     "tpope/vim-fugitive",
  --     config = function()
  --       require("plugins.fugitive")
  --     end,
  --   },
  --

  --   "laytan/cloak.nvim",
  --   {
  --     "dnlhc/glance.nvim",
  --     config = function()
  --       require("plugins.glance")
  --     end,
  --   },

  --
  --   -- Telescope and dependencies
  --   {
  --     "nvim-telescope/telescope.nvim",
  --     dependencies = { "nvim-lua/plenary.nvim" },
  --     tag = "0.1.4",
  --     config = function()
  --       require("plugins.telescope")
  --     end,
  --   },
  --   "nvim-telescope/telescope-fzy-native.nvim",
  --   {
  --     "nvim-telescope/telescope-file-browser.nvim",
  --     config = function()
  --       require("plugins.telescope-file-browser")
  --     end,
  --   },



  --   {
  --     "lukas-reineke/indent-blankline.nvim",
  --     main = "ibl",
  --     opts = {},
  --     config = function()
  --       local highlight = {
  --         "RainbowRed",
  --         "RainbowYellow",
  --         "RainbowBlue",
  --         "RainbowOrange",
  --         "RainbowGreen",
  --         "RainbowViolet",
  --         "RainbowCyan",
  --       }
  --       local hooks = require "ibl.hooks"
  --       -- create the highlight groups in the highlight setup hook, so they are reset
  --       -- every time the colorscheme changes
  --       hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  --         vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  --         vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  --         vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  --         vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  --         vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  --         vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  --         vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  --       end)
  --
  --       vim.g.rainbow_delimiters = { highlight = highlight }
  --       require("ibl").setup { scope = { highlight = highlight } }
  --
  --       hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  --     end,
  --   },



}
