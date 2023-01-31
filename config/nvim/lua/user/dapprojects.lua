local status_ok, dapprojects = pcall(require, "nvim-dap-projects")
if not status_ok then
	return
end

dapprojects.config_paths = {"./nvim/nvim-dap.lua"}
dapprojects.search_project_config()
