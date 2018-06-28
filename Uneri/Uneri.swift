import UIKit

class Uneri: UIView {
    open var uneriSpeed = CGFloat(0.5) {
        didSet {
            mainUneriLayer.speed = Float(uneriSpeed)
            subUneriLayer.speed = Float(uneriSpeed)
        }
    }
    open var uneriHeight = CGFloat(10.0) {
        didSet {
            reconfigureUneri()
        }
    }
    open var mainColor = UIColor.orange {
        didSet {
            mainGradientColors = [mainColor, mainColor]
        }
    }
    open var subColor = UIColor.purple  {
        didSet {
            subGradientColors = [subColor, subColor]
        }
    }
    open var mainGradientColors = [UIColor.orange, UIColor.purple] {
        didSet {
            mainUneriLayer.colors = mainGradientColors.map { $0.cgColor }
        }
    }
    open var subGradientColors = [UIColor.purple, UIColor.orange] {
        didSet {
            subUneriLayer.colors = subGradientColors.map { $0.cgColor }
        }
    }
    open var mainAlpha = CGFloat(0.7) {
        didSet {
            mainUneriLayer.opacity = Float(mainAlpha)
        }
    }
    open var subAlpha = CGFloat(0.1) {
        didSet {
            subUneriLayer.opacity = Float(subAlpha)
        }
    }
    
    private var uneriRect: UneriRect {
        return UneriRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: uneriHeight * 2)
    }
    
    private var uneriPath0: CGMutablePath {
        let uneriPath = CGMutablePath()
        uneriPath.move(to: uneriRect.lineEdgePoint.left0)
        uneriPath.addCurve(to: uneriRect.lineEdgePoint.right4, control1: uneriRect.curveDirectionPoint.topLowerCenter, control2: uneriRect.curveDirectionPoint.bottomUpperCenter)
        return complete(uneriPath: uneriPath)
    }
    private var uneriPath1: CGMutablePath {
        let uneriPath = CGMutablePath()
        uneriPath.move(to: uneriRect.lineEdgePoint.left1)
        uneriPath.addQuadCurve(to: uneriRect.lineEdgePoint.right3, control: uneriRect.curveDirectionPoint.bottomRight)
        return complete(uneriPath: uneriPath)
    }
    private var uneriPath2: CGMutablePath {
        let uneriPath = CGMutablePath()
        uneriPath.move(to: uneriRect.lineEdgePoint.left2)
        uneriPath.addQuadCurve(to: uneriRect.lineEdgePoint.right2, control: uneriRect.curveDirectionPoint.bottomCenter)
        return complete(uneriPath: uneriPath)
    }
    private var uneriPath3: CGMutablePath {
        let uneriPath = CGMutablePath()
        uneriPath.move(to: uneriRect.lineEdgePoint.left3)
        uneriPath.addQuadCurve(to: uneriRect.lineEdgePoint.right1, control: uneriRect.curveDirectionPoint.bottomLeft)
        return complete(uneriPath: uneriPath)
    }
    private var uneriPath4: CGMutablePath {
        let uneriPath = CGMutablePath()
        uneriPath.move(to: uneriRect.lineEdgePoint.left4)
        uneriPath.addCurve(to: uneriRect.lineEdgePoint.right0, control1: uneriRect.curveDirectionPoint.bottomUpperCenter, control2: uneriRect.curveDirectionPoint.topLowerCenter)
        return complete(uneriPath: uneriPath)
    }
    private var uneriPath5: CGMutablePath {
        let uneriPath = CGMutablePath()
        uneriPath.move(to: uneriRect.lineEdgePoint.left3)
        uneriPath.addQuadCurve(to: uneriRect.lineEdgePoint.right1, control: uneriRect.curveDirectionPoint.topRight)
        return complete(uneriPath: uneriPath)
    }
    private var uneriPath6: CGMutablePath {
        let uneriPath = CGMutablePath()
        uneriPath.move(to: uneriRect.lineEdgePoint.left2)
        uneriPath.addQuadCurve(to: uneriRect.lineEdgePoint.right2, control: uneriRect.curveDirectionPoint.topCenter)
        return complete(uneriPath: uneriPath)
    }
    private var uneriPath7: CGMutablePath {
        let uneriPath = CGMutablePath()
        uneriPath.move(to: uneriRect.lineEdgePoint.left1)
        uneriPath.addQuadCurve(to: uneriRect.lineEdgePoint.right3, control: uneriRect.curveDirectionPoint.topLeft)
        return complete(uneriPath: uneriPath)
    }
    
    private lazy var mainUneriLayer: CAGradientLayer = {
        let colors = mainGradientColors.isEmpty ? [mainColor, mainColor] : mainGradientColors
        return createGradient(colors: colors, alpha: mainAlpha, path: uneriPath0)
    }()
    private lazy var subUneriLayer: CAGradientLayer = {
        let colors = subGradientColors.isEmpty ? [subColor, subColor] : subGradientColors
        return createGradient(colors: colors, alpha: subAlpha, path: uneriPath4)
    }()
    
    public convenience init(frame: CGRect, mainColor: UIColor, subColor: UIColor) {
        self.init(frame: frame)
        
        self.mainColor = mainColor
        self.subColor = subColor
        
        mainUneriLayer.colors = [self.mainColor.cgColor, self.mainColor.cgColor]
        subUneriLayer.colors = [self.subColor.cgColor, self.subColor.cgColor]
    }
    
    public convenience init(frame: CGRect, mainGradientColors: [UIColor], subGradientColors: [UIColor]) {
        self.init(frame: frame)
        
        self.mainGradientColors = mainGradientColors
        self.subGradientColors = subGradientColors
        
        mainUneriLayer.colors = self.mainGradientColors.map { $0.cgColor }
        subUneriLayer.colors = self.subGradientColors.map { $0.cgColor }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUneri()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func resume() {
        mainUneriLayer.resumeAnim(withSpeed: uneriSpeed)
        subUneriLayer.resumeAnim(withSpeed: uneriSpeed)
    }
    
    public func pause() {
        mainUneriLayer.pauseAnim()
        subUneriLayer.pauseAnim()
    }
    
    private func createGradient(colors: [UIColor], alpha: CGFloat, path: CGMutablePath) -> CAGradientLayer {
        let shape = CAShapeLayer()
        shape.frame = bounds
        shape.fillColor = colors.first?.cgColor
        shape.path = path
        
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.opacity = Float(alpha)
        gradient.mask = shape
        return gradient
    }
    
    private func createAnimation(currentPath: CGMutablePath, nextPath: CGMutablePath, previousAnim: CABasicAnimation?) -> CABasicAnimation {
        let pathAnim = CABasicAnimation(keyPath: "path")
        pathAnim.fromValue = currentPath
        pathAnim.toValue = nextPath
        pathAnim.duration = 0.4
        
        if let previousAnim = previousAnim {
            pathAnim.beginTime = previousAnim.beginTime + previousAnim.duration
        }
        
        return pathAnim
    }
    
    private func createGroupAnimation(from animations: [CABasicAnimation]) -> CAAnimationGroup {
        let animGroup = CAAnimationGroup()
        animGroup.animations = animations
        animGroup.duration = animations.last!.beginTime + animations.last!.duration
        animGroup.fillMode = kCAFillModeForwards
        animGroup.isRemovedOnCompletion = false
        animGroup.repeatCount = .infinity
        return animGroup
    }
    
    private func complete(uneriPath: CGMutablePath) -> CGMutablePath {
        uneriPath.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        uneriPath.addLine(to: CGPoint(x: bounds.origin.x, y: bounds.size.height))
        uneriPath.closeSubpath()
        return uneriPath
    }
    
    private func addAnimationToMainUneri() {
        let mainAnim0 = createAnimation(currentPath: uneriPath0, nextPath: uneriPath1, previousAnim: nil)
        mainAnim0.beginTime = 0.0
        let mainAnim1 = createAnimation(currentPath: uneriPath1, nextPath: uneriPath2, previousAnim: mainAnim0)
        let mainAnim2 = createAnimation(currentPath: uneriPath2, nextPath: uneriPath3, previousAnim: mainAnim1)
        let mainAnim3 = createAnimation(currentPath: uneriPath3, nextPath: uneriPath4, previousAnim: mainAnim2)
        let mainAnim4 = createAnimation(currentPath: uneriPath4, nextPath: uneriPath5, previousAnim: mainAnim3)
        let mainAnim5 = createAnimation(currentPath: uneriPath5, nextPath: uneriPath6, previousAnim: mainAnim4)
        let mainAnim6 = createAnimation(currentPath: uneriPath6, nextPath: uneriPath7, previousAnim: mainAnim5)
        let mainAnim7 = createAnimation(currentPath: uneriPath7, nextPath: uneriPath0, previousAnim: mainAnim6)
        let mainAnimGroup = createGroupAnimation(from: [mainAnim0, mainAnim1, mainAnim2, mainAnim3, mainAnim4, mainAnim5, mainAnim6, mainAnim7])
        
        mainUneriLayer.mask?.add(mainAnimGroup, forKey: UneriAnimationKey.main.rawValue)
    }
    
    private func addAnimationToSubUneri() {
        let subAnim0 = createAnimation(currentPath: uneriPath4, nextPath: uneriPath5, previousAnim: nil)
        subAnim0.beginTime = 0.0
        let subAnim1 = createAnimation(currentPath: uneriPath5, nextPath: uneriPath6, previousAnim: subAnim0)
        let subAnim2 = createAnimation(currentPath: uneriPath6, nextPath: uneriPath7, previousAnim: subAnim1)
        let subAnim3 = createAnimation(currentPath: uneriPath7, nextPath: uneriPath0, previousAnim: subAnim2)
        let subAnim4 = createAnimation(currentPath: uneriPath0, nextPath: uneriPath1, previousAnim: subAnim3)
        let subAnim5 = createAnimation(currentPath: uneriPath1, nextPath: uneriPath2, previousAnim: subAnim4)
        let subAnim6 = createAnimation(currentPath: uneriPath2, nextPath: uneriPath3, previousAnim: subAnim5)
        let subAnim7 = createAnimation(currentPath: uneriPath3, nextPath: uneriPath4, previousAnim: subAnim6)
        let subAnimGroup = createGroupAnimation(from: [subAnim0, subAnim1, subAnim2, subAnim3, subAnim4, subAnim5, subAnim6, subAnim7])
        
        subUneriLayer.mask?.add(subAnimGroup, forKey: UneriAnimationKey.sub.rawValue)
    }
    
    private func reconfigureUneri() {
        mainUneriLayer.mask?.removeAnimation(forKey: UneriAnimationKey.main.rawValue)
        subUneriLayer.mask?.removeAnimation(forKey: UneriAnimationKey.sub.rawValue)
        
        addAnimationToMainUneri()
        addAnimationToSubUneri()
    }
    
    private func configureUneri() {
        addAnimationToSubUneri()
        addAnimationToMainUneri()
        
        layer.addSublayer(mainUneriLayer)
        layer.addSublayer(subUneriLayer)
    }
}
