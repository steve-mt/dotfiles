function repo_clean
    echo "📣 Reset to default branch"
    git reset --hard @
    git rev-parse --verify -q main > /dev/null 2>&1
    if test $status -eq 0
        git switch main
    end
    git rev-parse --verify -q master > /dev/null 2>&1
    if test $status -eq 0
        git switch master
    end

    echo '📣 Delelting all branches apart form main'
    git branch | rg -v 'master|main' | parallel --trim rl git branch -D {}

    echo '📣 Pruning remote'
    git pull --prune

    echo '📣 Running git gc'
    git gc
end
