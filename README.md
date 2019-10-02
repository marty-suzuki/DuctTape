# DuctTape

[![CI Status](https://img.shields.io/travis/marty-suzuki/DuctTape.svg?style=flat)](https://travis-ci.org/marty-suzuki/DuctTape)
[![Version](https://img.shields.io/cocoapods/v/DuctTape.svg?style=flat)](https://cocoapods.org/pods/DuctTape)
[![License](https://img.shields.io/cocoapods/l/DuctTape.svg?style=flat)](https://cocoapods.org/pods/DuctTape)
[![Platform](https://img.shields.io/cocoapods/p/DuctTape.svg?style=flat)](https://cocoapods.org/pods/DuctTape)
[![SwiftPM](https://img.shields.io/badge/SwiftPM-compatible-green.svg)](https://swift.org/package-manager)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-yellow.svg)](https://github.com/Carthage/Carthage)
[![Language](https://img.shields.io/badge/Language-Swift5.1-orange.svg)](https://developer.apple.com/swift)

📦 KeyPath dynamicMemberLookup based syntax sugar for Swift.

```swift
let label = UILabel().ductTape
    .numberOfLines(0)
    .textColor(.red)
    .text("Hello, World!!")
    .build()
```

Above is same as below definition.

```swift
let label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .red
    label.text = "Hello, World!!"
    return label
}()
```

## Usage

NSObject already has been compatible with DuctTape, so you can access `.ductTape` property like below.

```swift
let builder: Builder<UIView> = UIView().ductTape
```

If you access `.ductTape`, it returns `Builder` that provides setter of properties via KeyPath dynamicMemberLookup.

```swift
let view: UIView = UIView().ductTape
    .backgroundColor(.red)
    .translatesAutoresizingMaskIntoConstraints(false)
    .build()
```

Finally, If you call `.build()`, `Builder` returns instance that has set property values.

If some objects are not compatible with DuctTape, there are two ways to use DuctTape.

1. Use DuctTapeCompatible

```swift
class Dog: DuctTapeCompatible {
    var name: String
}

let dog = Dog().ductTape
    .name("Copernicus")
    .build()
```

2. Use Builder directly

```swift
class Dog {
    var name: String
}

let dog = Builder(Dog())
    .name("Copernicus")
    .build()
```

#### Sample

```swift
class ViewController: UIViewController {

    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        .ductTape
        .minimumLineSpacing(10)
        .minimumInteritemSpacing(10)
        .itemSize(CGSize(width: 100, height: 100))
        .scrollDirection(.vertical)
        .build()

    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                 collectionViewLayout: flowLayout)
        .ductTape
        .dataSource(self)
        .delegate(self)
        .translatesAutoresizingMaskIntoConstraints(false)
        .reinforce {
            $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        }
        .build()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
}
```

## Requirement

- Xcode 11
- macOS 10.10
- iOS 9.0
- tvOS 10.0
- watchOS 3.0

## Installation

#### CocoaPods

DuctTape is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod "DuctTape"
```

#### Carthage

If you’re using [Carthage](https://github.com/Carthage/Carthage), simply add
DuctTape to your `Cartfile`:

```
github "marty-suzuki/DuctTape"
```

#### Swift Package Manager

Simply add the following line to your `Package.swift`:

```
.package(url: "https://github.com/marty-suzuki/DuctTape.git", from: "version")
```

## License

DuctTape is released under the MIT License.
