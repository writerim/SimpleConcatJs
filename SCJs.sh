#!/bin/sh
ls ./src | while read FILENAME; do
  rm -f $FILENAME
  touch $FILENAME
  cat ./src/$FILENAME | while IFS= read -r line; do
      if echo $line | grep -q '//# *'; then
          if [ "$1" ]; then
            if [ "$1" == "--debug" ]; then
              echo "//path: $(echo $line | sed 's/^\/\/\#include  *//')" >> $FILENAME
            fi
          fi
          cat "$(echo $line | sed 's/^\/\/\#include  *//')" >> $FILENAME
      else
          echo "$line" >> $FILENAME
      fi
  done
done
