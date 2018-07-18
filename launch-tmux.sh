#!/bin/bash

ENVIRONMENT=$1

. tmux_config-$ENVIRONMENT.properties

tmux new-session -d -s $ENVIRONMENT
tmux set-option -g allow-rename off

IFS=','; first_window=true
for window in ${windows[@]};
do
        if $first_window ; then
                tmux rename-window $window
        else
                tmux new-window -n $window
        fi

        if [[ -v $window ]]; then
                tmux send-keys -t $ENVIRONMENT:$window ${!window} Enter
        fi

        first_window=false
done

tmux select-window -t 0
tmux a -t $ENVIRONMENT

