[![MadeInSweden](https://img.shields.io/badge/Made_In-Stockholm_Sweden-blue.svg)](https://en.wikipedia.org/wiki/Stockholm)
[![Status](https://img.shields.io/badge/Status-Active_and_in_development-blue.svg)](https://github.com/MKGitHub/UIPheonix)

[![Version](https://img.shields.io/badge/Version-3.0.1-blue.svg)](https://github.com/MKGitHub/UIPheonix)
[![Carthage](https://img.shields.io/badge/carthage-3.0.1-blue.svg)](https://github.com/MKGitHub/UIPheonix)
[![SPM](https://img.shields.io/badge/SPM-3.0.1-blue.svg)](https://github.com/MKGitHub/UIPheonix)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-🤬-blue.svg)](https://github.com/MKGitHub/UIPheonix)

[![Platform](https://img.shields.io/badge/Platforms-macOS_iOS_tvOS-blue.svg)](https://github.com/MKGitHub/UIPheonix)
[![Swift](https://img.shields.io/badge/Swift_Version-5-blue.svg)](https://github.com/MKGitHub/UIPheonix)


🌟 Give this repo a star and help its development grow! 🌟


![UIPheonix Logo](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/Banner.png)

Inspired by game development UIPheonix is a super easy, flexible, dynamic and highly scalable UI framework + concept for building reusable component/control-driven apps for macOS, iOS and tvOS. The same API apply for cross-platform development! Think of it as using Lego blocks, you can use similar ones and move them around easy as pie.

Does this seem familiar to you?

![ConstraintErrors](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/ConstraintErrors.png)

Well not any more…

* Forget static layouts, constraint issues and warning explosions in the console.
* Forget all the glue code, all the boilerplate code and all the very common overly engineered unnecessary pile of garbage code in your apps.
* Build and make changes to your UI quickly in a snap.
* Make your UI reusable.
* Focus on creating your app, not fighting layout issues.
* Minimal setup, minimal impact on your app, lightweight, no dependencies, no pain but so much gain!
* Builds on top of collection views & table views, so you can easily mix and match.
* Does not replace Apple technologies with custom implementations, so you will always be safe and up-to-date, and you can easily revert at any time.
* Demo apps provided for macOS, iOS and tvOS (Kung Fu!)

![OSScreenshots](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/OSScreenshots.png)

Demo App

![iOSMovie](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/iOSMovie.gif)

* Reusable UI Component/Control (from here on mentioned as a "RUIC") – Is basically just a model+view.
You can configure a RUIC in any way you want, in the demo apps I'm using both JSON files and manual code setup for the models.

![RUIC Diagram](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/RUIC.png)

* Display Models (list) – An array of [model, model, model…] etc. this is how UIPheonix knows what to display.

![States](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/States.png)

* Display State – In the demo apps I'm using a simple "state machine".
You may find alternative solutions, and your milage may vary :-)

* Model-View Relationships (dictionary) – A dictionary defining the relationship between model+view.

<br/>


Example RUICs
------
Making a RUIC is pretty simple as making a model+view.

![ExampleRUIC1](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/Example1.png)
![ExampleRUIC1](https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/Images/Example2.png)

<br/>


What’s New?
------
* Version 3.0.1 improves support for Swift 5.x.x.
* Version 3.0 updates with new API and support for Swift 5.x.x.
* Version 2.3 updates for Swift 4.2.
* Version 2.2.1 adds support for Swift 4 and Xcode 9.
* Version 2.2.0 adds support for Swift 4 and Xcode 9.
* Version 2 adds support for table view as well as many refactorings to make UIPheonix even easier to use.


Requirements
------
* Swift Version 5
* Xcode 10


How to Install
------
There is no framework/library distibution, I recommend that you simply add the `UIPheonix.swift` to your project. As this will allow you to easily find & read the UIPheonix API, and it will also allow UIPheonix to compile using your apps build settings. 

* Using Git: `git clone https://github.com/MKGitHub/UIPheonix.git` then add `UIPheonix.swift` to your Xcode project.
* Manual Way: Add `UIPheonix.swift` to your Xcode project.
* Using Carthage: In your Cartfile add `github "MKGitHub/UIPheonix" ~> 3` then add `UIPheonix.swift` to your Xcode project.
* Using Swift Package Manager: swift-tools-version:4.2
* CocoaPods support has been removed! 🙌🙏🎉 Never use CocoaPods! 💀


Documentation
------
Go to the documentation [index page](http://htmlpreview.github.io/?https://raw.githubusercontent.com/MKGitHub/UIPheonix/master/docs/index.html).


Used In Apps
------
UIPheonix is used in production in the following apps/games (that I'm aware of), these apps are together used by millions of users. Please let me know if you use UIPheonix.

* McDonald's apps
* Lånekoll
* LeoVegas apps


Contributing
------
Please contribute or create your own RUICs!

In the folder "3rd Party RUICs" you may add your own RUICs, if you already have a Cocoa Control (www.cocoacontrols.com) please consider converting it to the simple UIPheonix architecture.
A great thing about RUICs in UIPheonix is that they all have the same architecture, so you don't have to implement and follow different implementations for each Cocoa Control in your app = less fragmentation!

As UIPheonix may progress and evolve the "RUIC Implementation Version" will increase, and so in order to know which version of UIPheonix a RUIC is compatible with please add this info to your RUIC.


Notes
------
https://github.com/MKGitHub/UIPheonix
    
http://www.xybernic.com

Copyright 2016/2017/2018/2019 Mohsan Khan

Licensed under the Apache License, Version 2.0

