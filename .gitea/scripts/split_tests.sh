#!/bin/bash
# Split spec files across CI nodes based on timing data
# Usage: split_tests.sh <node_index> <node_total> <timing_file>

NODE_INDEX=$1
NODE_TOTAL=$2
TIMING_FILE=$3

# Find all spec files
ALL_FILES=$(find spec -name '*_spec.rb' | sort)

if [ -f "$TIMING_FILE" ] && [ -s "$TIMING_FILE" ]; then
  echo "Using timing data for test splitting" >&2

  # Greedy balancing: assign each file (slowest first) to the node with least total time
  echo "$ALL_FILES" | awk -v node_total="$NODE_TOTAL" -v node_index="$NODE_INDEX" '
  BEGIN {
    for (i = 0; i < node_total; i++) node_times[i] = 0
  }
  NR == FNR {
    timings[$2] = $1
    next
  }
  {
    files[++file_count] = $0
    if ($0 in timings)
      file_times[file_count] = timings[$0]
    else
      file_times[file_count] = 1
  }
  END {
    for (i = 2; i <= file_count; i++) {
      j = i
      while (j > 1 && file_times[j] > file_times[j-1]) {
        tmp = file_times[j]; file_times[j] = file_times[j-1]; file_times[j-1] = tmp
        tmp = files[j]; files[j] = files[j-1]; files[j-1] = tmp
        j--
      }
    }
    for (i = 1; i <= file_count; i++) {
      min_node = 0
      for (n = 1; n < node_total; n++) {
        if (node_times[n] < node_times[min_node]) min_node = n
      }
      node_assignment[i] = min_node
      node_times[min_node] += file_times[i]
      node_file_count[min_node]++
    }
    for (i = 1; i <= file_count; i++) {
      if (node_assignment[i] == node_index) print files[i]
    }
    for (n = 0; n < node_total; n++) {
      marker = (n == node_index) ? " <-- this node" : ""
      printf "Node %d: %d files, %.1fs%s\n", n, node_file_count[n], node_times[n], marker > "/dev/stderr"
    }
  }
  ' "$TIMING_FILE" -
else
  echo "No timing data found, falling back to round-robin by file size" >&2

  echo "$ALL_FILES" | xargs wc -l 2>/dev/null | grep -v ' total$' | sort -rn | awk -v nt="$NODE_TOTAL" -v ni="$NODE_INDEX" '{print $2}' | awk -v nt="$NODE_TOTAL" -v ni="$NODE_INDEX" 'NR % nt == ni'
fi
