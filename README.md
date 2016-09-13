[![MadeInSweden](https://img.shields.io/badge/Made In-Stockholm, Sweden-blue.svg)](https://en.wikipedia.org/wiki/Stockholm)

[![Status](https://img.shields.io/badge/Status-Active doing well & alive-blue.svg)](https://github.com/MKGitHub/UIPheonix)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue.svg)](https://github.com/MKGitHub/UIPheonix)
[![Pod](https://img.shields.io/badge/pod-1.0.0-blue.svg)](https://github.com/MKGitHub/UIPheonix)

[![Platform](https://img.shields.io/badge/Platforms-macOS + iOS + tvOS-blue.svg)](https://github.com/MKGitHub/UIPheonix)
[![Swift](https://img.shields.io/badge/Swift Version-3 beta 6-blue.svg)](https://github.com/MKGitHub/UIPheonix)

[![RUIC Implementation Version](https://img.shields.io/badge/RUIC Implementation Version-1-blue.svg)](https://github.com/MKGitHub/UIPheonix)


![UIPheonix Logo](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/Banner.png)

When Chuck Norris develops an app, he uses UIPheonix! Because Chuck Norris is right and does not like the glue code, the boilerplate and the very common overly engineered unnecessary complexity phenomenon! Chuck Norris likes when stuff is flexible, dynamic and scalable, and he works with designers that change stuff many times so he needs technology that can handle the agility.

Inspired by game development UIPheonix is a simple framework + concept for building apps where you create reusable UI controls and relate them to different states. The same API apply for cross platform development! Think of it as using Lego blocks, you can use similar ones and move them around easy as pie.

![macOS Demo](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/macOS.png)
![iOS Demo](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/iOS.png)
![tvOS Demo](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/tvOS.png)

* Reusable UI Control (from here on mentioned as a "RUIC") – Is basically just a Model and a View.
You can configure a RUIC in any way you want, in the demo apps I'm using JSON files to configure models which are sent to cell views for a collection view.

![RUIC Diagram](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/RUIC.png)

* Display List – An array of [RUIC, RUIC, RUIC…], etc., this is how UIPheonix knows what to display.

![States](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/States.png)

* Display State – In the demo apps I'm using different states to…know the current state of the app.
You may find alternative solutions, and your milage may vary :-)

* Display Dictionary – A dictionary defining the relationship between model+view, and the properties of the model.
In the demo apps I'm using JSON files.

UIPheonix and the demo app is cross-platform (macOS, iOS and tvOS), that’s how I Kung Fu!


Whats Next?
------
* Add more features.
* Try to make everything even simpler.


Contributing
------
Please contribute or create your own RUICs!

In the folder "3rd Party RUICs" you may add your own RUICs, if you already have a Cocoa Control (www.cocoacontrols.com) please consider converting it to the simple UIPheonix architecture.
A great thing about RUICs in UIPheonix is that they all have the same architecture, so you don't have to implement and follow different implementations for each Cocoa Control in your app = less fragmentation!

As UIPheonix may progress and evolve the "RUIC Implementation Version" will increase, and so in order to know which version of UIPheonix a RUIC is compatible with please add this info to your RUIC. I don't see this happening often.


Notes
------
   https://github.com/MKGitHub/UIPheonix

   http://www.xybernic.com

   http://www.khanofsweden.com

   Copyright 2016 Mohsan Khan

   Licensed under the Apache License, Version 2.0.

