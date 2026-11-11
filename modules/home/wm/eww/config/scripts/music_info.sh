#!/usr/bin/env bash
PLAYERCTL="playerctl"
CACHE_DIR="/tmp/eww-cover-cache"
mkdir -p "$CACHE_DIR"

get_youtube_thumbnail() {
  local url="$1"
  local video_id=""
  if [[ "$url" =~ (v=|youtu\.be/|youtube\.com/watch\?v=)([a-zA-Z0-9_-]{11}) ]]; then
    video_id="${BASH_REMATCH[2]}"
  elif [[ "$url" =~ youtube\.com/embed/([a-zA-Z0-9_-]{11}) ]]; then
    video_id="${BASH_REMATCH[1]}"
  elif [[ "$url" =~ youtube\.com/v/([a-zA-Z0-9_-]{11}) ]]; then
    video_id="${BASH_REMATCH[1]}"
  fi

  if [ -n "$video_id" ]; then
    echo "https://img.youtube.com/vi/${video_id}/hqdefault.jpg"
  else
    echo ""
  fi
}

get_youtube_duration() {
  local url="$1"
  local hash=$(echo -n "$url" | md5sum | cut -d" " -f1)
  local cache_file="$CACHE_DIR/duration_${hash}.txt"
  if [ -f "$cache_file" ] && [ $(($(date +%s) - $(stat -c %Y "$cache_file"))) -lt 3600 ]; then
    local cached=$(cat "$cache_file")
    if [ "$cached" != "fail" ]; then
      echo "$cached"
    else
      echo ""
    fi
  else
    local duration=$(timeout 3 yt-dlp --no-playlist --get-duration "$url" 2>/dev/null)
    if [ -n "$duration" ]; then
      echo "$duration" > "$cache_file"
      echo "$duration"
    else
      echo "fail" > "$cache_file"
      echo ""
    fi
  fi
}

status=$($PLAYERCTL status 2>/dev/null || echo "Stopped")
if [ "$status" = "Stopped" ]; then
  echo '{"status": "Stopped", "title": "No music playing", "artist": "", "art": "", "position": 0, "duration": 100, "position_time": "--:--", "duration_time": "--:--", "progress": 0}'
  exit 0
fi

title=$($PLAYERCTL metadata title 2>/dev/null | sed 's/"/\\"/g')
artist=$($PLAYERCTL metadata artist 2>/dev/null | sed 's/"/\\"/g')
arturl=$($PLAYERCTL metadata mpris:artUrl 2>/dev/null)
url=$($PLAYERCTL metadata xesam:url 2>/dev/null)

art_path=""
if [ -n "$arturl" ]; then
  if [[ "$arturl" == file://* ]]; then
    art_path="${arturl#file://}"
  elif [[ "$arturl" == http://* || "$arturl" == https://* ]]; then
    hash=$(echo -n "$arturl" | md5sum | cut -d" " -f1)
    cache_path="$CACHE_DIR/$hash.png"
    if [ ! -f "$cache_path" ]; then
      curl -s "$arturl" -o "$cache_path"
    fi
    if [ -f "$cache_path" ]; then
      art_path="$cache_path"
    fi
  fi
else
  if [[ "$url" =~ youtube\.com|youtu\.be ]]; then
    thumbnail_url=$(get_youtube_thumbnail "$url")
    if [ -n "$thumbnail_url" ]; then
      hash=$(echo -n "$thumbnail_url" | md5sum | cut -d" " -f1)
      cache_path="$CACHE_DIR/$hash.jpg"
      if [ ! -f "$cache_path" ]; then
        curl -s "$thumbnail_url" -o "$cache_path"
      fi
      if [ -f "$cache_path" ]; then
        art_path="$cache_path"
      fi
    fi
  fi
fi

pos=$($PLAYERCTL position 2>/dev/null || echo 0)
pos_int=$(printf "%.0f" "$pos" 2>/dev/null || echo 0)

dur_secs=0
dur=$($PLAYERCTL metadata mpris:length 2>/dev/null || echo 0)
if [ "$dur" -gt 0 ]; then
  dur_secs=$((dur / 1000000))
else
  # Coba dapatkan dari YouTube
  if [[ "$url" =~ youtube\.com|youtu\.be ]]; then
    dur_str=$(get_youtube_duration "$url")
    if [[ "$dur_str" =~ ([0-9]+):([0-9]+) ]]; then
      min=${BASH_REMATCH[1]}
      sec=${BASH_REMATCH[2]}
      dur_secs=$((min * 60 + sec))
    elif [[ "$dur_str" =~ ^([0-9]+)$ ]]; then
      dur_secs=$dur_str
    fi
  fi
fi

if [ "$dur_secs" -gt 0 ]; then
  pos_m=$((pos_int / 60))
  pos_s=$((pos_int % 60))
  pos_time=$(printf "%d:%02d" $pos_m $pos_s)

  dur_m=$((dur_secs / 60))
  dur_s=$((dur_secs % 60))
  dur_time=$(printf "%d:%02d" $dur_m $dur_s)
  
  progress=$((pos_int * 100 / dur_secs))
else
  pos_time="--:--"
  dur_time="--:--"
  progress=0
fi

echo "{\"status\": \"$status\", \"title\": \"$title\", \"artist\": \"$artist\", \"art\": \"$art_path\", \"position\": $pos_int, \"duration\": $dur_secs, \"position_time\": \"$pos_time\", \"duration_time\": \"$dur_time\", \"progress\": $progress}"