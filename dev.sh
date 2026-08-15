#!/usr/bin/env bash
set -euo pipefail

SESSION="dev"

# Kill if running
tmux kill-session -t "$SESSION" 2>/dev/null || true

tmux new-session -d -s "$SESSION" -n dev

tmux split-window -h -t "$SESSION:dev"
tmux split-window -v -t "$SESSION:dev.1" -l 20%

tmux a -t $SESSION
