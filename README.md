# GetLingo Manager

GetLingo Manager is a library to help developer connect to GetLingo Services to handle your apps translations.

## Demo app

Open `GetLingoSampleApp.xcworkspace` to see a simple demonstration of implementing the manager and fetching translations.

## Usage

You need to register your app on http://getlingo.io. There you can retrieve an api key and an app id that you need in order to indentify your application.

##Installation

`GetLingoManager` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```
pod "GetLingoManager"
```

You may alternatively just copy the contents of the `GetLingoManager` folder into your project.

##Quick Start

First, add `GLLingoManager` to your AppDelegate.m

```objc
#import <GLLingoManager.h>
```

Then you need to instantiate the singelton and set api key and app id. You can also set an optional initial prefered language code if you want to force the app to use a specific language. So in `didFinishLaunchingWithOptions:` add the following line:

```objc
[[GLLingoManager sharedManager] setApiKey:@"YOUR-API-KEY" andAppId:@"YOUR-APP-ID" andPreferedLanguage:@"en"];
```

## Changelog
* 0.3.0 Reworked network class to work with api changes.
* 0.2.0 Updated demo app and minor priority changes in GLLingoManager
* 0.1.0 Initial release with basic functionality

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

