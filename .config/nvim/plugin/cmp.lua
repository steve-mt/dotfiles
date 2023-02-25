local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-j>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-[>'] = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-]>'] = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(-1)
      else
        fallback()
      end
    end, { 'i', 's' })
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local snippet = luasnip.snippet
local text = luasnip.text_node
local insert = luasnip.insert_node
local fn = luasnip.function_node
local choice = luasnip.choice_node

-- Copy the value of an insert node.
local function copy(args)
	return args[1]
end

-- Adding snippets
luasnip.add_snippets("go", {
  snippet("err", {
    text({"if err != nil {", ""}),
    text("\t return "),
    insert(1),
    text({"", "}"}),
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
    text({" {", "\t"}),
    insert(4),
    text({"", "}"})
  }),

  snippet("lv", {
    text("log.Printf(\""),
    fn(copy, 1),
    text(": %#+v\", "),
    insert(1),
    text(")"),
  }),

  snippet("tys", {
    text("type "),
    insert(1),
    text({" struct {", "\t"}),
    insert(2),
    text({"", "}"}),
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
    text(") ") ,
    insert(4),
    text({"{", "\t"}),
    insert(5),
    text({"", "}"}),
  }),

  snippet("tf", {
    text("func Test"),
    insert(1),
    text({"(t *testing.T) {", "\t"}),
    insert(2),
    text({"", "}"})
  }),
})
