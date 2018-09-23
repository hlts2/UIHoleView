import UIKit

public protocol HoleDrawable {
    func draw(_ rect: CGRect, hole: Hole)
}

public class DrawSquareHole: HoleDrawable {
    public init() {}
    public func draw(_ rect: CGRect, hole: Hole) {
        guard let ctxt = UIGraphicsGetCurrentContext() else {
            return
        }
        
        ctxt.setFillColor(hole.color.cgColor)
        ctxt.setBlendMode(.copy)
        ctxt.fill(hole.path.bounds)
    }
}

public class DrawCircleHole: HoleDrawable {
    public init() {}
    public func draw(_ rect: CGRect, hole: Hole) {
        guard let ctxt = UIGraphicsGetCurrentContext() else {
            return
        }
        
        ctxt.setFillColor(hole.color.cgColor)
        ctxt.setBlendMode(.copy)
        ctxt.fillEllipse(in: hole.path.bounds)
    }
}

public class DrawRoundedCornerHole: HoleDrawable {
    public init() {}
    public func draw(_ rect: CGRect, hole: Hole) {
        hole.color.setFill()
        hole.path.fill(with: .copy, alpha: 0.0)
    }
}

public class Hole {
    internal var path: UIBezierPath!
    internal var color: UIColor!
    internal var drawer: HoleDrawable!
    
    public init(path: UIBezierPath, color: UIColor, drawer: HoleDrawable) {
        self.path   = path
        self.color  = color
        self.drawer = drawer
    }
}

public class UIHoleView: UIView {
    private var holes: [Hole]?
    
    public convenience init(holes: [Hole]) {
        self.init()
        self.setHoles(holes)
    }
    
    public func setHoles(_ holes: [Hole]) {
        self.holes = holes
        
        if self.isOpaque {
            self.isOpaque = false
        }
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
