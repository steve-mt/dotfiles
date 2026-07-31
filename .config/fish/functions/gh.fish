function gh --wraps=gh --description 'GitHub CLI without colors'
    env NO_COLOR=1 command gh $argv
end
