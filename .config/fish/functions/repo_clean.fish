function repo_clean
    echo 'Delelting all branches apart form main'
    git branch | rg -v 'master|main' | parallel --trim rl git branch -D {}
    echo 'Puring remote'
    git pull --prune
    echo 'Running git gc'
    git gc
end
