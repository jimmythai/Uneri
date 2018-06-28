import UIKit

extension CALayer {
    func pauseAnim() {
        speed = 0.0
        timeOffset = convertTime(CACurrentMediaTime(), from: nil)
    }
    
    func resumeAnim(withSpeed speed: CGFloat) {
        let pausedTime = timeOffset
        self.speed = Float(speed)
        timeOffset = 0.0
        beginTime = 0.0
        beginTime = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    }
}
