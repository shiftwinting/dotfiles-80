vim.g.cmake_change_build_command = 1
vim.g.cmake_build_dir = 'build'
-- vim.g.cmake_build_dir_prefix = ""

vim.g.cmake_compile_commands = 1
vim.g.cmake_compile_commands_link = vim.fn.getcwd()
vim.g.cmake_project_generator = "Ninja"
vim.g.cmake_c_compiler = '/usr/bin/clang'
vim.g.cmake_cxx_compiler = '/usr/bin/clang++'
vim.g.cmake_install_prefix = 'install'
vim.g.cmake_build_type = "Debug"
vim.g.cmake_usr_args='-DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache'
