# YATTHS
## Yet Another Tsum Tsum Heart Sender

Automated method for claiming and sending [Tsum Tsum](http://lol.disney.com/games/tsum-tsum-app) hearts.

### Features

* Runs using [Nox App Player](https://www.bignox.com).
* Claim all from mailbox.
* Claim individually from mailbox, allowing for responding to unknowns.
* Send hearts to all on leaderboard, including or excluding zero-score players.
* Sleep timer.
* Persistent configurable settings.
* Activity Sensor which pauses the script when user mouse movement is detected.

### Quick Start

Assuming that you have Nox App Player installed.

1. Extract ZIP file to your hard drive.
1. Configure Nox to have a custom resolution of 405(width)-by-720(height) with a DPI of 160. Reset Nox to activate the new settings.
1. Install TsumTsum app.
1. Log into your LINE account in the app.
1. Navigate to your Leaderboard.
1. Run the __YATTHS__ program.  Or the __YATTHS.ahk__ script, if you have [AutoHotKey](https://autohotkey.com) installed.
1. Click the _Start_ button to start the automated process.

Click _Pause_ or _Stop_ to ... pause or stop the process.

The process is configurable by clicking _File_ -> _Settings_.


### Method

The tool will run rounds until stopped. Between each round is a sleep period where no action is taken.

A round consists of:

1. Claiming the contents of the mailbox.
1. Sending hearts to the players in your leaderboard.
1. Claiming the contents of the mailbox.

The tool logs its actions, so you can see which steps have/are being performed.

### Wiki

The [wiki](https://github.com/icantrap/YATTHS/wiki) has more information.

### Future

* Hearts Tracking. Track the hearts received in mailbox to allow for easier pruning of leaderboard.
* Mailbox-Only Mode. Only respond to hearts send to mailbox, not leaderboard.

### Acknowledgments

This project is a fork of [Tsum Tsum Advanced Heart Sending](http://www.criticalgenesis.com/ttahs.html), authored by [/u/RinArenna](https://www.reddit.com/user/RinArenna). A big thanks to all of their work making the original scripts.

## License

Licensed under GPLv3. See LICENSE for details.
