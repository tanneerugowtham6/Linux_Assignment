#!/usr/bin/env bash

DATE="$(date +%F)"
OUTDIR="/backups"
LOGDIR="/var/log/monitoring"
LOGFILE="$LOGDIR/nginx_backup_${DATE}.log"
OUTFILE="${OUTDIR}/nginx_backup_${DATE}.tar.gz"

# Common Nginx paths (Ubuntu/Debian and alternatives)
SRC1="/etc/nginx"
SRC2a="/usr/share/nginx/html"
SRC2b="/var/www/html"

# Ensure dirs exist (script should be runnable as root/with sudo)
mkdir -p "$OUTDIR" "$LOGDIR"

{
  echo "=== Nginx backup started: $(date) ==="
  echo "Intended sources: $SRC1 , $SRC2a or $SRC2b"
  echo "Destination: $OUTFILE"
  echo ""

  # Warn about which docroot exists
  DOCROOT=""
  if [ -d "$SRC2a" ]; then
    DOCROOT="$SRC2a"
  elif [ -d "$SRC2b" ]; then
    DOCROOT="$SRC2b"
  else
    echo "WARNING: neither $SRC2a nor $SRC2b exist; archive will include only $SRC1"
  fi

  for s in "$SRC1" "$DOCROOT"; do
    if [ -n "$s" ] && [ ! -e "$s" ]; then
      echo "WARNING: source $s does not exist"
    fi
  done

  # Build list of sources to pass to tar (only existing ones)
  ARGS=()
  if [ -d "$SRC1" ]; then ARGS+=("$SRC1"); fi
  if [ -n "$DOCROOT" ] && [ -d "$DOCROOT" ]; then ARGS+=("$DOCROOT"); fi

  if [ ${#ARGS[@]} -eq 0 ]; then
    echo "ERROR: No source directories found. Exiting."
    exit 1
  fi

  # Create tar.gz (use -C / to keep relative paths)
  tar -czf "$OUTFILE" -C / --transform "s,^,$(basename "$OUTDIR")/," "${ARGS[@]}" 2>&1 || {
    echo "ERROR: tar failed"
    exit 1
  }

  echo ""
  echo "Verifying archive contents (first 50 entries):"
  tar -tzf "$OUTFILE" | head -n 50

  echo ""
  echo "Backup completed: $OUTFILE"
  echo "=== Nginx backup finished: $(date) ==="
} > "$LOGFILE" 2>&1
