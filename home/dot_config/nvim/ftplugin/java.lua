local jdtls_path = require('mason-registry').get_package('jdtls'):get_install_path()
local lombok_jar = jdtls_path .. "/lombok.jar"

local cmd = { 'jdtls' }
table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))

local root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'src' }, { upward = true })[1])
local project_name = root_dir and vim.fs.basename(root_dir)
local jdtls_config_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
local jdtls_workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"

vim.list_extend(cmd, {
    "-configuration",
    jdtls_config_dir,
    "-data",
    jdtls_workspace_dir
})

local config = {
    cmd = cmd,
    root_dir = root_dir,
}

require('jdtls').start_or_attach(config)
