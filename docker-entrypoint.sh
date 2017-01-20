#!/bin/sh

XVFB_WHD=${XVFB_WHD:-1280x720x16}

export DISPLAY=:10

# Start Xvfb, Chrome, and Selenium in the background
echo "Starting Xvfb ..."
Xvfb +extension RANDR :10 -ac -screen 0 $XVFB_WHD -nolisten tcp &
xvfb=$!

echo "Starting Webdriver ..."
./chromedriver --port=9515 &
chromedriver=$!

echo "Starting Google Chrome ..."
google-chrome --remote-debugging-port=9222 --no-sandbox -start-maximized &
chrome=$!

#wait
#trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT