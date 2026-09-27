-- Swap npm install to bun for Mason
return {
  "Senal-D-A-Gunaratna/swapson.nvim",
  dependencies = {
      "mason-org/mason.nvim", -- lazy.nvim spec field: ensures mason loads first
  },
  opts = {
      npm = {
          enabled = true,  -- turn the npm -> bun patch on/off
          tool = "bun",    -- binary name/path swapson calls instead of npm
      },
      pip = {
          enabled = false,  -- turn the pip -> uv patch on/off
          tool = "uv",     -- binary name/path swapson calls instead of pip
      }
  }
}
