import UIKit

struct UneriRect {
    let maxX, midX, minX: CGFloat
    let maxY, midY, minY: CGFloat
    let lineEdgePoint: LineEdgePoint
    let curveDirectionPoint: CurveDirectionPoint
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        maxX = width
        midX = width / 2
        minX = x
        maxY = height
        midY = height / 2
        minY = y
        
        let quaterX = midX / 2
        let quaterY = midY / 2
        
        lineEdgePoint = LineEdgePoint(
            left0: CGPoint(x: minX, y: minY), left1: CGPoint(x: minX, y: quaterY), left2: CGPoint(x: minX, y: midY), left3: CGPoint(x: minX, y: midY + quaterY), left4: CGPoint(x: minX, y: maxY),
            right0: CGPoint(x: maxX, y: minY), right1: CGPoint(x: maxX, y: quaterY), right2: CGPoint(x: maxX, y: midY), right3: CGPoint(x: maxX, y: midY + quaterY), right4: CGPoint(x: maxX, y: maxY))
        curveDirectionPoint = CurveDirectionPoint(
            topLeft: CGPoint(x: quaterX, y: -midY), topRight: CGPoint(x: midX + quaterX, y: -midY), topCenter: CGPoint(x: midX, y: -midY), topLowerCenter: CGPoint(x: midX, y: minY),
            bottomLeft: CGPoint(x: quaterX, y: maxY + midY), bottomRight: CGPoint(x: midX + quaterX, y: maxY + midY), bottomCenter: CGPoint(x: midX, y: maxY + midY), bottomUpperCenter: CGPoint(x: midX, y: maxY))
    }
    
    struct LineEdgePoint {
        let left0, left1, left2, left3, left4: CGPoint
        let right0, right1, right2, right3, right4: CGPoint
    }
    
    struct CurveDirectionPoint {
        let topLeft, topRight, topCenter, topLowerCenter: CGPoint
        let bottomLeft, bottomRight, bottomCenter, bottomUpperCenter: CGPoint
    }
}
