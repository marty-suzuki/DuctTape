# DuctTape

<p align="center">
<a href="https://travis-ci.org/marty-suzuki/DuctTape"><img alt="CI Status" src="https://img.shields.io/travis/marty-suzuki/DuctTape.svg?style=flat"/></a>
<a href="https://cocoapods.org/pods/DuctTape"><img alt="Pod" src="https://img.shields.io/cocoapods/v/DuctTape.svg?style=flat"/></a>
<a href="https://github.com/Carthage/Carthage"><img alt="Carthage" src="https://img.shields.io/badge/Carthage-compatible-yellow.svg"/></a
<a href="https://swift.org/package-manager"><img alt="SwiftPM" src="https://img.shields.io/badge/SwiftPM-compatible-green.svg"/></a>
<br/>
<a href="https://developer.apple.com/swift"><img alt="Swift5" src="https://img.shields.io/badge/language-Swift5-orange.svg"/></a>
<a href="https://cocoapods.org/pods/DuctTape"><img alt="Platform" src="https://img.shields.io/cocoapods/p/DuctTape.svg?style=flat"/></a>
<a href="https://cocoapods.org/pods/DuctTape"><img alt="License" src="https://img.shields.io/cocoapods/l/DuctTape.svg?style=flat"/></a>
</p>

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

Finally, if you call `.build()`, `Builder` returns instance that has set property values.

#### How to access methods

If you want to access methods of object which is building, `func reinforce(_ handler: (Base) -> Void) Builder<Base>` enable to access methods.

```swift
let collectionView = UICollectionView().ductTape
    .backgroundColor(.red)
    .reinforce { collectionView in
        collectionView.register(UITableViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    .build()
```

`Builder` has `func reinforce<T1, ...>(_ t1: T1, ..., handler: (Base) -> Void) Builder<Base>` methods.
In additional usage, be able to access outside object with `func reinforce` if passing objects as arguments.

```swift
lazy var collectionView = UICollectionView().ductTape
    .translatesAutoresizingMaskIntoConstraints(false)
    .reinforce(view) { collectionView, view in
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
    .build()
```

#### How to use DuctTape with self-implemented classes

There are two ways to use DuctTape.

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

#### Sample Code

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
