# status_branches.awk

# Update the max length of a branch name for aligned formatting
{
    if (length($1) > max_length) max_length = length($1)
}

# Store branches based on their status or markings

# Store "gone" branches in "gones" array
/\[gone\]/ {
    gsub(/\[gone\]/, "", $0); # Remove [gone] from the branch name
    gones[$1] = $0;
    next;
}

# Store "behind" branches in "behinds" array
/\[behind [0-9]+\]/ {
    behinds[$1] = $0;
    next;
}

# Store branches with active marks (*) and others in "others" array
/^\*/ {
    others[$2] = $0;
    next;
}
/\[/ {
    others[$1] = $0;
    next;
}

# Store branches without tracking markers in "no_marks" array
!/\[/ {
    no_marks[$1] = $0;
    next;
}

# Print out the stored branches based on their groups
END {
    printBranchGroup("Branches gone from origin:", gones);
    printBranchGroup("Branches behind origin:", behinds);
    printBranchGroup("Branches without tracking info:", no_marks);
    printBranchGroup("Other branches:", others);
}

# Custom function to print branches based on a given title and array
function printBranchGroup(title, group) {
    if (length(group) > 0) {
        print "\n" title;
        for (branch in group) {
            printf "%-" max_length "s  ", branch;
            match(group[branch], /[a-f0-9]{7}/);
            printf "%s  ", substr(group[branch], RSTART, RLENGTH);
            gsub(/^[ \*]*[a-zA-Z0-9_\/-]*[ ]+[a-f0-9]{7} /, "", group[branch]);
            print group[branch];
        }
    }
}


