return {
	{
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			config = function()
				local luasnip = require("luasnip")
				luasnip.config.setup({})

				local snippet = luasnip.snippet
				local text = luasnip.text_node
				local insert = luasnip.insert_node
				local fn = luasnip.function_node
				local choice = luasnip.choice_node

				-- Copy the value of an insert node.
				local function copy(args)
					return args[1]
				end

				luasnip.add_snippets("go", {
					snippet("err", {
						text({ "if err != nil {", "" }),
						text("\t return "),
						insert(1),
						text({ "", "}" }),
					}),

					snippet("forr", {
						text("for "),
						choice(1, {
							text("_,"),
							text(""),
						}),
						insert(2),
						text(" := range "),
						insert(3),
						text({ " {", "\t" }),
						insert(4),
						text({ "", "}" }),
					}),

					snippet("lv", {
						text('log.Printf("'),
						fn(copy, 1),
						text(': %#+v", '),
						insert(1),
						text(")"),
					}),

					snippet("fv", {
						text('fmt.Printf("'),
						fn(copy, 1),
						text(': %#+v", '),
						insert(1),
						text(")"),
					}),

					snippet("tys", {
						text("type "),
						insert(1),
						text({ " struct {", "\t" }),
						insert(2),
						text({ "", "}" }),
					}),

					snippet("wr", {
						text("w http.ResponseWriter, r *http.Request"),
					}),

					snippet("meth", {
						text("func ("),
						insert(1),
						text(") "),
						insert(2),
						text("("),
						insert(3),
						text(") "),
						insert(4),
						text({ "{", "\t" }),
						insert(5),
						text({ "", "}" }),
					}),

					snippet("tf", {
						text("func Test"),
						insert(1),
						text({ "(t *testing.T) {", "\t" }),
						insert(2),
						text({ "", "}" }),
					}),
				})

				luasnip.add_snippets("typescript", {
					snippet("cl", {
						text("console.log('"),
						fn(copy, 1),
						text("', "),
						insert(1),
						text(")"),
					}),
				})

				luasnip.add_snippets("javascript", {
					snippet("cl", {
						text("console.log('"),
						fn(copy, 1),
						text("', "),
						insert(1),
						text(")"),
					}),
				})
			end,
		},
	},
}
