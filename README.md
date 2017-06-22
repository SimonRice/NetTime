# NetTime - Open Source Edition

[![Build Status](https://api.travis-ci.org/simonrice/NetTime.svg)](https://travis-ci.org/simonrice/NetTime)
[![Twitter: @_simonrice](https://img.shields.io/badge/contact-@_simonrice-blue.svg?style=flat)](https://twitter.com/_simonrice)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/simonrice/NetTime/blob/master/LICENSE)

This is the NetTime Open Source Edition.  NetTime is an app that shows the current time in [Swatch Internet Time](https://en.wikipedia.org/wiki/Swatch_Internet_Time) on your iOS device.

[NetTime is currently available on the Apple App Store.](https://appsto.re/i6Yc3VC)  The difference between the App Store & Open Source versions of the app is the open source version also includes a watchOS component of the app.  Apple refused to allow the watch components I created as their primary functionality was to tell the time, albeit in the esoteric way that Swatch Internet Time is!

## Installation Instructions

You can use Xcode 8 or above to install NetTime on your iOS device & watch using just your Apple ID.

All you need to do is:

1. Install Xcode via [download](https://developer.apple.com/xcode/download/) or through the Mac App Store.
1. Run `git clone https://github.com/simonrice/NetTime.git` in a terminal application of your choice.
1. Open "NetTime.xcodeproj" in Xcode.
1. Go to Xcode's Preferences > Accounts and add your Apple ID.
1. In Xcode's sidebar select each target and go to General > Identity. Append a word at the end of the **Bundle Identifier** e.g. com.simonrice.NetTime**.name** so it's unique. Select your Apple ID in Signing > Team.  For watch targets & the today extension, you need to ensure your bundle ID prefixes are identical, e.g.:
    * com.simonrice.NetTime**.name**.TodayExtension
    * com.simonrice.NetTime**.name**.watchkitapp
    * com.simonrice.NetTime**.name**.watchkitapp.watchkitextension
1. Connect your iPad or iPhone using USB and select it in Xcode's Product menu > Destination.
1. Press CMD+R or Product > Run to install NetTime.
1. If you install using a free (non-developer) account, make sure to rebuild NetTime every 7 days, otherwise it will quit at launch when your certificate expires.

## License

This app is licensed under the terms of the MIT license. Please see the [LICENSE](LICENSE) file.
