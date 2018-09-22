import UIKit

public protocol Drawable {
    func draw(_ rect: CGRect, hole: Hole)
}

public class DrawSquareHole: Drawable {
    public func draw(_ rect: CGRect, hole: Hole) {
        hole.color.setFill()
        UIRectFill(hole.path.bounds)
    }
}

public class DrawRoundedCornerHole: Drawable {
    public func draw(_ rect: CGRect, hole: Hole) {
        
    }
}

public class Hole {
    internal var path: UIBezierPath!
    internal var color: UIColor!
    internal var drawer: Drawable!
    
    init(path: UIBezierPath, color: UIColor, drawer: Drawable) {
        self.path   = path
        self.color  = color
        self.drawer = drawer
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
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let holes = self.holes else { return self }
        
        for hole in holes {
            if hole.path.contains(point) {
                return nil
            }
        }
        
        return self
    }
}
