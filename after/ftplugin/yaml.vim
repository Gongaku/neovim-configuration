function! YamlFoldExpr(lnum)
  return luaeval('require("user_functions.yaml_fold").foldexpr(_A)', a:lnum)
endfunction

setlocal foldmethod=expr
setlocal foldexpr=YamlFoldExpr(v:lnum)
setlocal foldlevel=99
