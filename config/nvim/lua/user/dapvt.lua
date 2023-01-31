local status_ok, dapvt = pcall(require, "dap-virtual-text")
if not status_ok then
	return
end

dapvt.setup()