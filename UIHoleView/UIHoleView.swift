import UIKit

public class Hole {
    public var rect: CGRect!
    public var color: UIColor!
    public var cornerRadius: CGFloat?
    
    init(rect: CGRect, color: UIColor, cornerRadius: CGFloat) {
        self.rect   = rect
        self.color  = color
        self.cornerRadius = cornerRadius
    }
    
    init(rect: CGRect, color: UIColor) {
        self.rect  = rect
        self.color = color
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
            if let _ = hole.cornerRadius {
                self.drawRoundedCornerHole(rect, hole)
            } else {
                self.drawSquareHole(rect, hole)
            }
        }
    }
    
    private func drawSquareHole(_ rect: CGRect, _ hole: Hole) {
        let holeIntersection = rect.intersection(hole.rect)
        if holeIntersection.isNull { return }
        hole.color.setFill()
        UIRectFill(holeIntersection)
    }
    
    private func drawRoundedCornerHole(_ rect: CGRect, _ hole: Hole) {
    }
}

