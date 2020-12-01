---
title: Robohash Avatars
date: 01 Jun 2019
description: Generate robot-based avatar images based on any text
hasWebsite: true
website: http://bit.ly/robohash-avatars
onGithub: true
github: https://github.com/ClydeDz/robohash-avatars-npm
madeUsing:
- TypeScript
- JavaScript
- Node.js
- Mocha
- Istanbul+nyc
category: npm
icon: https://files.clydedsouza.net/images/icons/robohashavatars-icon.png
image: https://files.clydedsouza.net/images/projects/robohashavatars-siteteaser.png
imageDescription: Generate robot-based avatar images based on any text
isActive: true
relativeURL: ''

---
I built an npm wrapper to use the existing [Robohash avatars](https://robohash.org/) service to generate robot-based avatar images based on any text.  

## Usage  
After installing, simply import Robohash Avatars in your file.

```javascript
const robohashAvatars = require("robohash-avatars");
```
Consume the `generateAvatar()` API to get an avatar URL that you can use directly as an image. Supply the settings object to this method to generate the avatar image URL accordingly. **Username is required**. For the remainder, you can supply them based on your requirement. All settings are pretty self-explanatory.

```javascript
var avatarURL = robohashAvatars.generateAvatar({   
            username: "tonystark", 
            background: robohashAvatars.BackgroundSets.RandomBackground1,
            characters: robohashAvatars.CharacterSets.Kittens,
            height: 400,
            width: 400
        }); 
```

### Options 
`CharacterSets` supports `Robots`, `Monsters`, `DisembodiedHeads` and `Kittens`. `BackgroundSets` supports `RandomBackground1` and `RandomBackground2`

## Examples 
> Clicking on the images below opens the image in a browser window.  

[![Sample image 1](https://robohash.org/RobohashAvatarNPM?bgset=bg1&size=200x200)](https://robohash.org/RobohashAvatarNPM?bgset=bg1&size=200x200) [![Sample image 2](https://robohash.org/tonystark?bgset=bg2&set=set2&size=200x200)](https://robohash.org/tonystark?bgset=bg2&set=set2&size=200x200) 
[![Sample image 3](https://robohash.org/peterparker?bgset=bg1&set=set4&size=200x200)](https://robohash.org/peterparker?bgset=bg1&set=set4&size=200x200) 
   
## Release notes 
Release notes can be found [here](https://github.com/ClydeDz/robohash-avatars-npm/releases).   
   
## Credits  
[RoboHash.org](http://robohash.org) is developed by [Colin Davis](https://github.com/e1ven) / [RoboHash GitHub](https://github.com/e1ven/Robohash).