#!/usr/bin/env bash
# Usage: scripts/traffic.sh [port] [seconds]
PORT=${1:-8081}
DURATION=${2:-120}
END=$((SECONDS + DURATION))
echo "Sending traffic to localhost:${PORT} for ${DURATION}s..."
while [ $SECONDS -lt $END ]; do
  curl -s -o /dev/null "localhost:${PORT}/health"
  curl -s -o /dev/null "localhost:${PORT}/version"
  if [ $((RANDOM % 5)) -eq 0 ]; then
    curl -s -o /dev/null "localhost:${PORT}/error"
  fi
  sleep 0.2
done
echo "Done."
