#!/usr/bin/env bash

LOGDIR="/var/log/monitoring"
mkdir -p "$LOGDIR"

LOGFILE="$LOGDIR/initial_metrics_$(date +%F_%H-%M-%S).log"

{
  echo "=== Initial System Metrics - $(date) ==="
  echo ""
  echo "---- TOP (first 20 lines) ----"
  top -b -n1 | head -n 20
  echo ""
  echo "---- Highest CPU processes ----"
  ps aux --sort=-%cpu | head -n 15
  echo ""
  echo "---- Highest Memory processes ----"
  ps aux --sort=-%mem | head -n 15
  echo ""
  echo "---- Disk usage (df -h) ----"
  df -h
  echo ""
  echo "---- Memory usage (free -h) ----"
  free -h || true
  echo ""
  echo "=== End of Report ==="
} > "$LOGFILE"
