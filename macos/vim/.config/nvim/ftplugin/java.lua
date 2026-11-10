-- ftplugin/java.lua
--
-- This runs on every `FileType java` event (opening a .java file or `:set ft=java`).
-- It starts / attaches eclipse.jdt.ls (jdtls) for the current project using
-- the `nvim-jdtls` plugin. jdtls is stateful and project-scoped, which is why
-- it is launched here per-buffer rather than through the generic lspconfig
-- handler in lua/kickstart/plugins/lsp.lua (where it is deliberately excluded).

local ok, jdtls = pcall(require, 'jdtls')
if not ok then
  -- Plugin not installed yet (e.g. first launch before :Lazy sync). Bail quietly.
  return
end

-- 1. Find the project root. jdtls needs a real Maven/Gradle project for full
--    functionality; a lone .java file with only `.git` gets limited features.
local root_markers = { 'gradlew', 'mvnw', 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle', '.git' }
local root_dir = vim.fs.root(0, root_markers)
if not root_dir then
  return
end

-- 2. Locate the Mason-installed jdtls launcher script.
--    Mason installs a wrapper at ~/.local/share/nvim/mason/bin/jdtls.
local mason = vim.fn.stdpath 'data' .. '/mason'
local jdtls_bin = mason .. '/bin/jdtls'
if vim.fn.filereadable(jdtls_bin) == 0 then
  vim.notify('[jdtls] not found at ' .. jdtls_bin .. ' — run :MasonInstall jdtls', vim.log.levels.WARN)
  return
end

-- 3. jdtls (the server) requires Java 21+ to *run*, even if your projects target
--    an older Java. Your default `java` may be 17, so find a >= 21 JDK to launch
--    the server with, without changing your shell default.
--    We look through SDKMAN candidates and common macOS JVM locations.
local function find_java_home(min_major)
  local candidates = {}
  -- SDKMAN-installed JDKs
  local sdkman = vim.fn.expand '~/.sdkman/candidates/java'
  if vim.fn.isdirectory(sdkman) == 1 then
    for name, typ in vim.fs.dir(sdkman) do
      if typ == 'directory' and name ~= 'current' then
        table.insert(candidates, sdkman .. '/' .. name)
      end
    end
  end
  -- macOS system JVMs
  local sysjvm = '/Library/Java/JavaVirtualMachines'
  if vim.fn.isdirectory(sysjvm) == 1 then
    for name, typ in vim.fs.dir(sysjvm) do
      if typ == 'directory' then
        table.insert(candidates, sysjvm .. '/' .. name .. '/Contents/Home')
      end
    end
  end

  for _, home in ipairs(candidates) do
    local release = home .. '/release'
    if vim.fn.filereadable(release) == 1 then
      for _, line in ipairs(vim.fn.readfile(release)) do
        -- e.g. JAVA_VERSION="21.0.5"
        local ver = line:match 'JAVA_VERSION="(%d+)'
        if ver and tonumber(ver) >= min_major and vim.fn.executable(home .. '/bin/java') == 1 then
          return home
        end
      end
    end
  end
  return nil
end

local java21_home = find_java_home(21)
if not java21_home then
  vim.notify('[jdtls] No JDK 21+ found to run the server. Install one, e.g. `sdk install java 21.0.5-tem`.', vim.log.levels.ERROR)
  return
end

-- 4. Per-project workspace directory (jdtls stores its index here).
--    Kept outside the project so it never pollutes your repo.
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. project_name

-- 5. Wire up the debug (java-debug-adapter) and test (java-test) bundles that
--    Mason installed, so nvim-dap can debug/run JUnit tests.
local bundles = {}
local jdebug = vim.fn.glob(mason .. '/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', true)
if jdebug ~= '' then
  vim.list_extend(bundles, vim.split(jdebug, '\n'))
end
local jtest = vim.fn.glob(mason .. '/packages/java-test/extension/server/*.jar', true)
if jtest ~= '' then
  vim.list_extend(bundles, vim.split(jtest, '\n'))
end

-- 6. Reuse your existing Kickstart LSP setup: the `LspAttach` autocmd in
--    lua/kickstart/plugins/lsp.lua already maps gd/grd/grr/gri/grt/gO/gW etc.
--    for ANY attached client, so those navigation keymaps light up for Java
--    automatically. We just need to hand jdtls the same completion capabilities.
local capabilities = require('blink.cmp').get_lsp_capabilities()

local config = {
  cmd = {
    jdtls_bin,
    '-data',
    workspace_dir,
    '--java-executable',
    java21_home .. '/bin/java',
  },
  root_dir = root_dir,
  capabilities = capabilities,
  settings = {
    java = {
      -- Tell jdtls which JDKs are available so it can compile projects that
      -- target an older Java than the one running the server.
      configuration = {
        runtimes = (function()
          local runtimes = {}
          local seventeen = vim.fn.expand '~/.sdkman/candidates/java/17.0.18-tem'
          if vim.fn.isdirectory(seventeen) == 1 then
            table.insert(runtimes, { name = 'JavaSE-17', path = seventeen })
          end
          table.insert(runtimes, { name = 'JavaSE-21', path = java21_home })
          return runtimes
        end)(),
      },
      -- Organize imports & formatting behavior can be tuned here later.
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' }, -- nicer decompiled sources
    },
  },
  init_options = {
    bundles = bundles,
  },
}

jdtls.start_or_attach(config)

-- 7. Java-specific extras (refactorings + test running) that don't exist for Go.
--    These are additive; your generic LSP keymaps still apply.
local map = function(keys, fn, desc)
  vim.keymap.set('n', keys, fn, { buffer = 0, desc = 'Java: ' .. desc })
end
map('<leader>oi', jdtls.organize_imports, 'Organize Imports')
map('<leader>ev', jdtls.extract_variable, 'Extract Variable')
map('<leader>ec', jdtls.extract_constant, 'Extract Constant')
map('<leader>tc', jdtls.test_class, 'Test Class')
map('<leader>tm', jdtls.test_nearest_method, 'Test Nearest Method')
vim.keymap.set('v', '<leader>em', function()
  jdtls.extract_method(true)
end, { buffer = 0, desc = 'Java: Extract Method' })
