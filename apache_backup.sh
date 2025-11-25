#!/usr/bin/env bash

# Apache backup script
DATE="$(date +%F)"
OUTDIR="/backups"
LOGDIR="/var/log/monitoring"
LOGFILE="$LOGDIR/apache_backup_${DATE}.log"
OUTFILE="${OUTDIR}/apache_backup_${DATE}.tar.gz"

# Sources (Ubuntu Apache layout)
SRC1="/etc/apache2"
SRC2="/var/www/html"

# Ensure dirs exist
sudo mkdir -p "$OUTDIR" "$LOGDIR"

{
  echo "=== Apache backup started: $(date) ==="
  echo "Sources: $SRC1 , $SRC2"
  echo "Destination: $OUTFILE"
  echo ""

  # Warn if source missing (but continue to create archive with whatever exists)
  for s in "$SRC1" "$SRC2"; do
    if [ ! -e "$s" ]; then
      echo "WARNING: source $s does not exist"
    fi
  done

  # Create tar.gz (use -C to keep relative paths)
  tar -czf "$OUTFILE" -C / --transform "s,^,$(basename "$OUTDIR")/," "$SRC1" "$SRC2" 2>&1 || {
    echo "ERROR: tar failed"
    exit 1
  }

  echo ""
  echo "Verifying archive contents:"
  # list contents to verification output file
  tar -tzf "$OUTFILE" | head -n 50

  echo ""
  echo "Backup completed: $OUTFILE"
  echo "=== Apache backup finished: $(date) ==="
} > "$LOGFILE" 2>&1
