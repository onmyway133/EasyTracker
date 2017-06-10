# Trackers

[![CI Status](http://img.shields.io/travis/onmyway133/Trackers.svg?style=flat)](https://travis-ci.org/onmyway133/Trackers)
[![Version](https://img.shields.io/cocoapods/v/Trackers.svg?style=flat)](http://cocoadocs.org/docsets/Trackers)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Trackers.svg?style=flat)](http://cocoadocs.org/docsets/Trackers)
[![Platform](https://img.shields.io/cocoapods/p/Trackers.svg?style=flat)](http://cocoadocs.org/docsets/Trackers)
![Swift](https://img.shields.io/badge/%20in-swift%203.0-orange.svg)

## Story

- Make it easy to add logging, analytics to ViewController appearances
- See and modify all your trackings in one place

## Usage

Simply call `track` at app launch

```swift
track(ListController.self) {
  print("list controller has appeared")
}

track(DetailController.self) {
  print("detail controller has appeared")
}

track(CouponController.self) { controller in
  print("coupon controller has appeared with code \(controller.coupon.code)")
}
```

## Installation

**Trackers** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Trackers'
```

**Trackers** is also available through [Carthage](https://github.com/Carthage/Carthage).
To install just write into your Cartfile:

```ruby
github "onmyway133/Trackers"
```

**Trackers** can also be installed manually. Just download and drop `Sources` folders in your project.

## Author

Khoa Pham, onmyway133@gmail.com

## Contributing

We would love you to contribute to **Trackers**, check the [CONTRIBUTING](https://github.com/onmyway133/Trackers/blob/master/CONTRIBUTING.md) file for more info.

## License

**Trackers** is available under the MIT license. See the [LICENSE](https://github.com/onmyway133/Trackers/blob/master/LICENSE.md) file for more info.
