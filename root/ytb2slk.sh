# local shell libs
source /root/pyldsplt.sh

# main program execution block
main(){
  # first setup some variables
  local payload="ytbdl.$(date +%m%d%y%H%M%S)"
  local channel=${2:-'#meeting'}
  local message=${3:-"New upload from youtube-dl on $(date)"}
  local vid_title='.%(title)s.%(ext)s'

  # check if custom uploand name is set
  if [ ! -z "$UPLD_NM" ]; then
    # set to custom uplod name with extension
    vid_title="$UPLD_NM.%(ext)s"

    # alert
    echo "Using custom upload name: $UPLD_NM"
  fi

  # next get the video and exit if command fails
  youtube-dl --restrict-filename -f 'best' -ciw -o "${payload}.${vid_title}" $1 && \

  # get file name
  local dwnld="$(ls "${payload}".*)" && \

  # prepare for slack (lib: pyldsplt)
  split_for_slack "${dwnld}"
}

# executable
main $1 $2 $3
