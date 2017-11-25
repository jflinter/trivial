screencapture -l$(osascript -e 'tell application "QuickTime Player" to id of window 1') tmp.png
tesseract tmp.png output
cat output.txt