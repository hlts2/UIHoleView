# UIHoleView

UIHoleView is the custom UIView that creates holes.

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

1. Add this line to your Cartfile: `github "hlts2/UIHoleView"`
2. Read the [official instruction](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)

## Usage

1. imports the `UIHoleView` package

```swift
import UIHoleView
```

2. creates hole and custom view

```swift
// defines hole type. this example code is square hole.
let hole = Hole(path: UIBezierPath(rect: CGRect(x: 0, y: 0, width: 200, height: 200)),
                color: UIColor.clear,
                drawer: DrawSquareHole())

let holeView = UIHoleView(frame: self.view.bounds) // or let holeView = UIHoleView(holes: [hole])

// sets holes
holeView.setHoles([hole])

// sets background color outside holes
holeView.backgroundColor = UIColor.black.withAlphaComponent(0.5)

// adds holeview into self.view
self.view.addSubview(self.holeView)
```

## Hole type

- Square Hole

```swift
let hole = Hole(path: UIBezierPath(rect: CGRect(x: 0, y: 0, width: 200, height: 200)),
                color: UIColor.clear,
                drawer: DrawSquareHole())
```

- Circule Hole

```swift
let hole = Hole(path: UIBezierPath(rect: CGRect(x: 0, y: 0, width: 200, height: 200)),
                color: UIColor.clear,
                drawer: DrawCircleHole())
```
- Rounded Corner Hole

```swift
let hole3 = Hole(path: UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 200, height: 200), cornerRadius: 10),
                 color: UIColor.clear,
                 drawer: DrawRoundedCornerHole())
```
