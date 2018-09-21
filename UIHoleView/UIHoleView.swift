import UIKit

public protocol DrawHole {
    func draw(_ rect: CGRect, hole: Hole)
}

public class DrawSquareHole: DrawHole {
    public func draw(_ rect: CGRect, hole: Hole) {
        let holeIntersection = rect.intersection(hole.rect)
        if holeIntersection.isNull { return }
        hole.color.setFill()
        UIRectFill(holeIntersection)
    }
}

public class DrawRoundedCornerHole: DrawHole {
    public func draw(_ rect: CGRect, hole: Hole) {}
}

public class Hole {
    internal var rect: CGRect!
    internal var color: UIColor!
    internal var cornerRadius: CGFloat?
    internal let drawer: DrawHole!
    
    init(rect: CGRect, color: UIColor, cornerRadius: CGFloat) {
        self.rect   = rect
        self.color  = color
        self.cornerRadius = cornerRadius
        self.drawer = DrawRoundedCornerHole()
    }
    
    init(rect: CGRect, color: UIColor) {
        self.rect  = rect
        self.color = color
        self.drawer = DrawSquareHole()
    }
}

public class UIHoleView: UIView {
    private var holes: [Hole]?
    
    convenience init(holes: [Hole]) {
        self.init()
        self.setHoles(holes)
    }
    
    public func setHoles(_ holes: [Hole]) {
        self.holes = holes
    }
    
    override public func draw(_ rect: CGRect) {
        backgroundColor?.setFill()
        UIRectFill(rect)
        
        guard let holes = self.holes else { return }
        
        for hole in holes {
            hole.drawer.draw(rect, hole: hole)
        }
    }
}

