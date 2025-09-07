## Harpoon maps
{
	mode    = "n";
	key     = "<leader>A";
	action  = ''lua require("harpoon").list():prepend()'';
	options = { noremap = true; silent = true; };
}
{
	mode    = "n";
	key     = "<leader>a";
	action  = ''lua require("harpoon").list():add()'';
	options = { noremap = true; silent = true; };
}
{
	mode    = "n";
	key     = "<C-e>";
	action  = ''lua require'harpoon'.ui:toggle_quick_menu(require'harpoon':list())'';
	options = { noremap = true; silent = true; };
}
{
	mode    = "n";
	key     = "<C-h>";
	action  = ''lua require("harpoon").list():select(1)'';
	options = { noremap = true; silent = true; };
}
{
	mode    = "n";
	key     = "<C-j>";
	action  = ''lua require("harpoon").list():select(2)'';
	options = { noremap = true; silent = true; };
}
{
	mode    = "n";
	key     = "<C-k>";
	action  = ''lua require("harpoon").list():select(3)'';
	options = { noremap = true; silent = true; };
}
{
	mode    = "n";
	key     = "<C-l>";
	action  = ''lua require("harpoon").list():select(4)'';
	options = { noremap = true; silent = true; };
}
{
	mode    = "n";
	key     = "<leader><C-h>";
	action  = ''lua require("harpoon").list():replace_at(1)'';
	options = { noremap = true; silent = true; };
}
{
	mode    = "n";
	key     = "<leader><C-j>";
	action  = ''lua require("harpoon").list():replace_at(2)'';
	options = { noremap = true; silent = true; };
}
{
	mode    = "n";
	key     = "<leader><C-k>";
	action  = ''lua require("harpoon").list():replace_at(3)'';
	options = { noremap = true; silent = true; };
}
{
	mode    = "n";
	key     = "<leader><C-l>";
	action  = ''lua require("harpoon").list():replace_at(4)'';
	options = { noremap = true; silent = true; };
}
]
