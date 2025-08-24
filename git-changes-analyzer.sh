#!/bin/bash

# Git Changes Analyzer - Interactive tool for analyzing code changes
# Author: Generated with Claude Code
# Usage: ./git-changes-analyzer.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Configuration
DEFAULT_DAYS=1
REPO_PATH="."

# Function to print colored output
print_color() {
    local color=$1
    shift
    echo -e "${color}$*${NC}"
}

# Function to print header
print_header() {
    echo
    print_color "$BOLD$BLUE" "========================================"
    print_color "$BOLD$BLUE" "$1"
    print_color "$BOLD$BLUE" "========================================"
    echo
}

# Function to check if we're in a git repository
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_color "$RED" "Error: Not in a git repository!"
        exit 1
    fi
}

# Function to get commit summary
get_commit_summary() {
    local days=${1:-$DEFAULT_DAYS}
    local author=${2:-""}
    
    print_header "Commit Summary (Last $days days)"
    
    local author_filter=""
    if [[ -n "$author" ]]; then
        author_filter="--author=$author"
    fi
    
    # Get unique authors
    print_color "$CYAN" "Authors:"
    git log --since="$days days ago" $author_filter --pretty=format:"%an <%ae>" | sort -u | while IFS= read -r author_line; do
        local commit_count=$(git log --since="$days days ago" --author="$author_line" --oneline | wc -l)
        echo "  • $author_line ($commit_count commits)"
    done
    echo
    
    # Get statistics
    print_color "$CYAN" "Overall Statistics:"
    local total_commits=$(git log --since="$days days ago" $author_filter --oneline | wc -l)
    local files_changed=$(git log --since="$days days ago" $author_filter --pretty=format: --name-only | sort -u | wc -l)
    local insertions=$(git log --since="$days days ago" $author_filter --pretty=tformat: --numstat | awk '{inserted+=$1} END {print inserted}')
    local deletions=$(git log --since="$days days ago" $author_filter --pretty=tformat: --numstat | awk '{deleted+=$2} END {print deleted}')
    
    echo "  • Total commits: $total_commits"
    echo "  • Files changed: $files_changed"
    echo "  • Lines added: ${insertions:-0}"
    echo "  • Lines removed: ${deletions:-0}"
    echo "  • Net change: $((${insertions:-0} - ${deletions:-0})) lines"
}

# Function to show detailed commits by author
show_commits_by_author() {
    local days=${1:-$DEFAULT_DAYS}
    
    print_header "Commits by Author (Last $days days)"
    
    # Get unique authors
    git log --since="$days days ago" --pretty=format:"%an" | sort -u | while IFS= read -r author; do
        print_color "$GREEN$BOLD" "━━━ $author ━━━"
        
        git log --since="$days days ago" --author="$author" --pretty=format:"%h|%ad|%s" --date=short --numstat | \
        awk -F'|' '
        NF==3 {
            if (NR > 1 && commit != "") {
                printf "  %s %s %-70s %s+%d/-%d%s\n", commit, date, substr(subject, 1, 70), "\033[32m", added, deleted, "\033[0m"
            }
            commit = $1
            date = $2
            subject = $3
            added = 0
            deleted = 0
        }
        NF==3 && $1 ~ /^[0-9]+$/ {
            added += $1
            deleted += $2
        }
        END {
            if (commit != "") {
                printf "  %s %s %-70s %s+%d/-%d%s\n", commit, date, substr(subject, 1, 70), "\033[32m", added, deleted, "\033[0m"
            }
        }'
        echo
    done
}

# Function to show file changes
show_file_changes() {
    local days=${1:-$DEFAULT_DAYS}
    
    print_header "Most Changed Files (Last $days days)"
    
    print_color "$CYAN" "Top 20 most modified files:"
    git log --since="$days days ago" --pretty=format: --name-only | \
        sort | uniq -c | sort -rn | head -20 | \
        while read count file; do
            if [[ -n "$file" ]]; then
                printf "  %4d changes: %s\n" "$count" "$file"
            fi
        done
}

# Function to show commit types
analyze_commit_types() {
    local days=${1:-$DEFAULT_DAYS}
    
    print_header "Commit Types Analysis (Last $days days)"
    
    print_color "$CYAN" "Commit type distribution:"
    git log --since="$days days ago" --pretty=format:"%s" | \
        sed -n 's/^\([a-z]*\)(\([^)]*\)):.*/\1|\2/p' | \
        awk -F'|' '{types[$1]++; total++} END {
            for (type in types) {
                printf "  • %-10s: %3d commits (%.1f%%)\n", type, types[type], (types[type]*100.0/total)
            }
        }' | sort -k3 -rn
    
    echo
    print_color "$CYAN" "Component distribution:"
    git log --since="$days days ago" --pretty=format:"%s" | \
        sed -n 's/^[a-z]*(\([^)]*\)):.*/\1/p' | \
        sort | uniq -c | sort -rn | head -10 | \
        while read count component; do
            printf "  • %-20s: %3d changes\n" "$component" "$count"
        done
}

# Function to show specific commit details
show_commit_details() {
    local commit=$1
    
    if [[ -z "$commit" ]]; then
        print_color "$YELLOW" "Enter commit hash (or partial hash):"
        read -r commit
    fi
    
    if git rev-parse --verify "$commit" > /dev/null 2>&1; then
        print_header "Commit Details: $(git rev-parse --short $commit)"
        git show --stat --color=always "$commit"
    else
        print_color "$RED" "Error: Invalid commit hash: $commit"
    fi
}

# Function to generate report
generate_report() {
    local days=${1:-$DEFAULT_DAYS}
    local output_file="git-changes-report-$(date +%Y%m%d-%H%M%S).md"
    
    print_color "$YELLOW" "Generating report for last $days days..."
    
    {
        echo "# Git Changes Report"
        echo "Generated: $(date)"
        echo "Repository: $(basename $(git rev-parse --show-toplevel))"
        echo "Branch: $(git branch --show-current)"
        echo ""
        
        echo "## Summary (Last $days days)"
        echo ""
        
        # Authors
        echo "### Authors"
        git log --since="$days days ago" --pretty=format:"%an <%ae>" | sort -u | while IFS= read -r author_line; do
            local commit_count=$(git log --since="$days days ago" --author="$author_line" --oneline | wc -l)
            echo "- $author_line: $commit_count commits"
        done
        echo ""
        
        # Statistics
        echo "### Statistics"
        local total_commits=$(git log --since="$days days ago" --oneline | wc -l)
        local files_changed=$(git log --since="$days days ago" --pretty=format: --name-only | sort -u | wc -l)
        local insertions=$(git log --since="$days days ago" --pretty=tformat: --numstat | awk '{inserted+=$1} END {print inserted}')
        local deletions=$(git log --since="$days days ago" --pretty=tformat: --numstat | awk '{deleted+=$2} END {print deleted}')
        
        echo "- Total commits: $total_commits"
        echo "- Files changed: $files_changed"
        echo "- Lines added: ${insertions:-0}"
        echo "- Lines removed: ${deletions:-0}"
        echo "- Net change: $((${insertions:-0} - ${deletions:-0})) lines"
        echo ""
        
        # Detailed commits
        echo "## Detailed Commits"
        echo ""
        
        git log --since="$days days ago" --pretty=format:"%an" | sort -u | while IFS= read -r author; do
            echo "### $author"
            echo ""
            git log --since="$days days ago" --author="$author" --pretty=format:"- \`%h\` %s (%ad)" --date=short
            echo ""
        done
        
    } > "$output_file"
    
    print_color "$GREEN" "Report saved to: $output_file"
}

# Function to show simple menu
show_menu() {
    print_header "Git Changes Analyzer - Main Menu"
    
    print_color "$CYAN" "Select an option:"
    echo "  1) Summary - Show commit summary"
    echo "  2) By Author - Show commits grouped by author"
    echo "  3) File Changes - Show most changed files"
    echo "  4) Commit Types - Analyze commit types and components"
    echo "  5) Commit Details - Show specific commit details"
    echo "  6) Generate Report - Export analysis to markdown file"
    echo "  7) Change Time Range - Current: ${DAYS:-$DEFAULT_DAYS} days"
    echo "  8) Refresh - Update git data"
    echo "  9) Quit"
    echo
}

# Function to get user input (simple version)
get_menu_choice() {
    local choice
    # Print prompt to stderr so it doesn't get captured
    printf "${YELLOW}Enter your choice (1-9 or q): ${NC}" >&2
    read -r choice
    # Trim whitespace and return only the choice
    echo "$choice" | tr -d '[:space:]'
}

# Main function
main() {
    check_git_repo
    
    print_header "Welcome to Git Changes Analyzer"
    print_color "$GREEN" "Repository: $(basename $(git rev-parse --show-toplevel))"
    print_color "$GREEN" "Branch: $(git branch --show-current)"
    
    local DAYS=$DEFAULT_DAYS
    
    while true; do
        show_menu
        choice=$(get_menu_choice)
        
        # Debug: Show what was received (comment out in production)
        # echo "DEBUG: Received choice: '$choice'" >&2
        
        case "$choice" in
            1)
                get_commit_summary "$DAYS"
                ;;
            2)
                show_commits_by_author "$DAYS"
                ;;
            3)
                show_file_changes "$DAYS"
                ;;
            4)
                analyze_commit_types "$DAYS"
                ;;
            5)
                show_commit_details
                ;;
            6)
                generate_report "$DAYS"
                ;;
            7)
                print_color "$YELLOW" "Enter number of days to analyze:"
                read -r DAYS
                if ! [[ "$DAYS" =~ ^[0-9]+$ ]]; then
                    print_color "$RED" "Invalid input. Using default: $DEFAULT_DAYS days"
                    DAYS=$DEFAULT_DAYS
                else
                    print_color "$GREEN" "Time range updated to: $DAYS days"
                fi
                ;;
            8)
                print_color "$YELLOW" "Fetching latest changes..."
                git fetch --all --prune
                print_color "$GREEN" "Git data refreshed!"
                ;;
            9|q|Q)
                print_color "$GREEN" "Thank you for using Git Changes Analyzer!"
                exit 0
                ;;
            *)
                print_color "$RED" "Invalid option. Please try again."
                ;;
        esac
        
        echo
        print_color "$CYAN" "Press Enter to continue..."
        read -r
    done
}

# Handle command line arguments
if [[ $# -gt 0 ]]; then
    case $1 in
        --help|-h)
            print_header "Git Changes Analyzer - Help"
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --help, -h     Show this help message"
            echo "  --days N       Analyze last N days (default: $DEFAULT_DAYS)"
            echo "  --summary      Show summary and exit"
            echo "  --report       Generate report and exit"
            echo ""
            echo "Interactive mode: Run without arguments"
            exit 0
            ;;
        --days)
            if [[ -n "$2" ]] && [[ "$2" =~ ^[0-9]+$ ]]; then
                DEFAULT_DAYS=$2
                shift 2
            fi
            ;;
        --summary)
            check_git_repo
            get_commit_summary "$DEFAULT_DAYS"
            exit 0
            ;;
        --report)
            check_git_repo
            generate_report "$DEFAULT_DAYS"
            exit 0
            ;;
    esac
fi

# Run main program
main