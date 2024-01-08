<div style="display: flex; align-items: center;">
  <img align="left" width="40" height="40" src="https://raw.githubusercontent.com/mardeyar/StatSense/master/windows/runner/resources/app_icon.ico" alt="Resume application project app icon">
  <h1>StatSense</h1>
</div>

An app designed to assist with weekly pickups and drops in NHL Fantasy leagues
## What is the purpose?
Part of being an NHL fantasy league manager is picking up and dropping players on a routine basis; this strategy is also known as *streaming players*. Most managers will leave between 3-5 rosters spots specifically for this purpose as a way to maximize the number of games played per week. But what happens when you have 20 players eligible to play on any given night but only 14 spots available? You then need to pick and choose which 6 players will be sitting on the bench. Then the next night rolls around with only 3 games being played and you find yourself with only 2 players playing that night.<br><br>
**Enter: StatSense**
## How it works
StatSense does a few things to help you choose which players you need to stream. First, it pulls the NHL schedule directly via the public NHL API and lists which games are being played on each day of the week. Then, it will count how many games are being played each day to determine if it is an 'off day' where less than half the NHL teams are playing. If this is the case, that day will be marked as an off day and each team playing will be assigned +1 for off day count. Finally, each team is given a *streamer score*. StreamerScores are listed in descending order from highest to lowest to provide at a glance information to help you make quicker, more informed decisions about your streaming targets, saving you tons of research time.<br><br> 
Picked up a player from **TOR** last week who is only playing 2 games this week that both fall on busy nights? Drop them for a player on **CGY** who is playing 4 games, all of which fall on off days. This gains you 2 additional games per week, doing this over 3-5 roster spots is a great way to mazimize your weekly games played by virtue of volume and simple math.
## For Development 
* Download [Android Studio](https://developer.android.com/studio) and follow the setup instructions.
* Ensure you have [Flutter](https://docs.flutter.dev/get-started/install) set up and installed on your system and integrated with Android Studio. You may need to follow the [documentation](https://docs.flutter.dev/) to get this properly set up.
* Clone this repo into your local with the following command:<br>```git clone https://github.com/mardeyar/StatSense.git```
* Open the project in Android Studio and run the app on either a virtual emulator or mirror to a physical device.
## For General Use
Check the [releases page](https://github.com/mardeyar/StatSense/releases/latest) to grab the download for your chosen platform.
### Android
* Download the APK file named **StatSense_vX.X.X.apk** from the releases page
* Go to your downloads folder or wherever the APK got downloaded to and open the APK to install to your Android device.
* Profit
### Windows
* Download the ZIP file named **StatSense_vX.X.X_Windows.zip** from the releases page
* Navigate to the folder where the ZIP file downloaded to and extract the contents
* Once extracted, open the folder called **StatSense** to find **StatSense.exe** and double click to run. Hint: you can pin this .exe file to your start menu or taskbar for quick access
* Profit
### iOS
**Not yet supported**
### macOS
**Not yet supported**
## Screenshots
![z4DQKOh](https://github.com/mardeyar/StatSense/assets/117761940/62742826-566d-4781-8f41-6715808eefe1)
![hWZg0Va](https://github.com/mardeyar/StatSense/assets/117761940/be5028e9-5d11-4b5d-9bf9-bf4d610bef9c)
![YTVyPJj](https://github.com/mardeyar/StatSense/assets/117761940/4075826c-8ab6-489b-bdc7-8afba47e62f2)
![Z3xgbrK](https://github.com/mardeyar/StatSense/assets/117761940/e4ba0065-6f31-4470-a9e7-35f721fb4eb1)
## Known Issues
Visit the [issues page](https://github.com/mardeyar/StatSense/issues) to see a list on known issues and bugs. You can also submit bug reports through here.
## License
[MIT License](https://github.com/mardeyar/nhl_streamers/blob/master/LICENSE.md)
