require 'pry'

`screencapture -l$(osascript -e 'tell application "QuickTime Player" to id of window 1') tmp.png`
# `convert tmp.png -crop 1145x1260+36+360 tmp_crop.png`
`convert test.jpg -crop 635x700+20+200 tmp_crop.png`
text = `tesseract tmp_crop.png stdout`
question, answer = text.split("?\n\n")
question = question.gsub("\n", " ")
answers = answer.split("\n").select {|s| !s.empty?}

# answers.each do |answer|
#   url = "https://www.google.com/search?q=" + question.gsub(" ", "+") + "+" + answer.gsub(" ", "+")
# print <<`EOC`
#    osascript -e 'tell application "Safari"
#        tell window 1
#            set current tab to (make new tab with properties {URL:"#{url}"})
#        end tell
#    end tell'
# EOC
# end

print <<`EOC`
osascript -e 'property the_urls : {"http://stackoverflow.com","http://tex.stackexchange.com","http://apple.stackexchange.com"}

tell application "Safari"
    close every window
    if the_urls = {} then
        set {first_url, rest_urls} to {"", {}}
    else
        set {first_url, rest_urls} to {item 1 of the_urls, rest of the_urls}
    end if

    make new document at end of documents with properties {URL:first_url}
    tell window 1
        repeat with the_url in rest_urls
            make new tab at end of tabs with properties {URL:the_url}
        end repeat
    end tell
end tell'
EOC

# binding.pry
puts text
