#!/usr/bin/env bash

LOGDIR="/var/log/monitoring"
mkdir -p "$LOGDIR"

LOGFILE="$LOGDIR/top_proc_$(date +%F).log"

{
  echo "=== Top Processes Report - $(date) ==="
  echo ""
  echo "---- Top CPU consumers ----"
  ps aux --sort=-%cpu | head -n 15
  echo ""
  echo "---- Top Memory consumers ----"
  ps aux --sort=-%mem | head -n 15
  echo ""
  echo "---- Snapshot of top (first 20 lines) ----"
  top -b -n1 | head -n 20
  echo ""
  echo "=== End of Report ==="
} > "$LOGFILE"