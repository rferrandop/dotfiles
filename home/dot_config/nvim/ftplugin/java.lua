local config = {
    cmd = { 'jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'src' }, { upward = true })[1]),
}

require('jdtls').start_or_attach(config)
