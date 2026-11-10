-- Java support via nvim-jdtls.
--
-- This plugin only needs to be *available*; it is not started here.
-- The actual server launch happens per-buffer in `ftplugin/java.lua`,
-- which is the pattern recommended by nvim-jdtls (jdtls is stateful and
-- needs a fresh, project-scoped client for each Java project).
return {
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
  },
}
