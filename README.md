# NHL Streamers
An app designed to assist with weekly pickups and drops in NHL Fantasy leagues
## What is the purpose?
Part of being an NHL fantasy league manager is picking up and dropping players on a routine basis; this strategy is also known as *streaming players*. Most managers will leave between 3-5 rosters spots specifically for this purpose as a way to maximize the number of games played per week. But what happens when you have 20 players eligible to play on any given night but only 14 spots available? You then need to pick and choose which 6 players will be sitting on the bench. Then the next night rolls around with only 3 games being played and you find yourself with only 2 players playing that night.<br><br>
**Enter: NHL Streamers**
## How it works
NHL Streamers does a few things to help you choose which players you need to stream. First, it pulls the NHL schedule directly via the public NHL API and lists which games are being played on each day of the week. Then, it will count how many games are being played each day to determine if it is an 'off day' where less than half the NHL teams are playing. If this is the case, that day will be marked as an off day and each team playing will be assigned +1 for off day count. Finally, each team is given a *streamer score* based on how many games they play that week and how many of those games fall on off days. These streamer scores are then listed in descending order from highest to lowest to provide at a glance information to help you make quicker, more informed decisions about your streaming targets, saving you tons of research time.<br><br> 
Picked up a player from **TOR** last week who is only playing 2 games this week that both fall on busy nights? Drop them for a player on **CGY** who is playing 4 games, all of which fall on off days. This gains you 2 additional games per week, doing this over 3-5 roster spots is a great way to mazimize your weekly games played by virtue of volume and simple math.
## Getting Started
* Download [Android Studio](https://developer.android.com/studio) and follow the setup instructions.
* Ensure you have [Flutter](https://docs.flutter.dev/get-started/install) set up and installed on your system and integrated with Android Studio. You may need to follow the [documentation](https://docs.flutter.dev/) to get this properly set up.
* Clone this repo into your local with the following command:<br>```git clone https://github.com/mardeyar/nhl_streamers.git```
* Open the project in Android Studio and run the app on either a virtual or physical device. Note that running on physical will build and run the app on your device, allowing you to use the app outside the development environment.
* Check out the results and use to your advantage.
## Known Issues
| Issue | Description |
| ----- | ----------- |
| **X** | Picture in app icon does not fill the entire app icon, surrounded by background color |
| **X** | Currently can only pull data for current week, starting on Monday |
| **X** | Timezone uses UTC so gametime starts are not easy to read |
| **X** | Will fill this in more as more bugs are found |
## Future features
| Feature | Description |
| ------- | ----------- |
|  **X**  | Integrate Yahoo API to show which players might be good targets |
|  **X**  | Give option to choose week to view ie. look at next weeks schedule a week early |
|  **X**  | Add logos to team names |
|  **X**  | Add more factors to determine streamer score based on advanced stats, recent team trends and more |
|  **X**  | Create pages for data on each team and their rosters |
|  **X**  | More as I think of them.. |
## License
[MIT License](https://github.com/mardeyar/nhl_streamers/blob/master/LICENSE.md)
