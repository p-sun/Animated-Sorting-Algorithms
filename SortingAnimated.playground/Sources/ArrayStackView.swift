import UIKit
import XCPlayground
import PlaygroundSupport
import Dispatch

public struct PointerLabel {
    let text: String
    let index: Int
    let color: UIColor
    let borderColor: UIColor?
    
    public init(_ text: String, _ index: Int, _ color: UIColor, borderColor: UIColor? = nil) {
        self.text = text
        self.index = index
        self.color = color
        self.borderColor = borderColor
    }
}

public class ArrayStackView: UIView {
    private let viewWidth: CGFloat = 600
    private let viewHeight: CGFloat = 400
    private let labelHeight: CGFloat = 24
    private let delayInSeconds: Double = 0.2
    
    private let updateOperations = OperationQueue()

    // MARK: Init
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        backgroundColor = #colorLiteral(red: 0.2811661655, green: 0.3164002355, blue: 0.4330782043, alpha: 1)
        updateOperations.maxConcurrentOperationCount = 1
        updateOperations.underlyingQueue = DispatchQueue.main
        
        PlaygroundPage.current.liveView = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Add an Operation to re-draw bars after a delay.
    public func update(with values: [Int], _ pointerLabels: [PointerLabel] = []) {
        let updateOperation = BlockOperation { [weak self] in
            self?.drawBars(with: values, pointerLabels: pointerLabels)
        }
        updateOperations.addOperation(DelayOperation(delayInSeconds))
        updateOperations.addOperation(updateOperation)
    }
    
    // MARK: Bar Drawing
    
    private func drawBars(with values: [Int], pointerLabels: [PointerLabel]) {
        if subviews.count != (values.count + pointerLabels.count) {
            removeSubviews()
            addSubviewsViews(values.count)
            addSubviewLabels(pointerLabels.count)
        }
        
        for i in 0 ..< values.count {
            configure(subviews[i], at: i, values: values, pointerLabels: pointerLabels)
        }
        
        for i in 0 ..< pointerLabels.count {
            configureLabel(subviews[values.count + i] as! UILabel, at: i, values: values, pointerLabels: pointerLabels)
        }
        
        // Force the playground to re-render.
        CATransaction.flush()
    }
    private func removeSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    /// Setup a number of subviews equal to the number of bars.
    private func addSubviewsViews(_ count: Int) {
        for _ in 0..<count {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    private func addSubviewLabels(_ count: Int) {
        for _ in 0..<count {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
        }
    }
    
    private func configureLabel(_ uiLabel: UILabel, at i: Int, values: [Int], pointerLabels: [PointerLabel]) {
        let pointerLabel = pointerLabels[i]
        uiLabel.text = pointerLabel.text
        //uiLabel.backgroundColor = pointerLabel.borderColor ?? .clear
        uiLabel.textColor = pointerLabel.color
        
        let borderColor = pointerLabel.borderColor ?? .clear
        let borderWidth: CGFloat = uiLabel.frame.width/12
        uiLabel.layer.borderWidth = borderWidth
        uiLabel.layer.borderColor = borderColor.cgColor
        uiLabel.layer.cornerRadius = borderWidth
        
        let barWidth = frame.width / CGFloat(values.count)
        let x = barWidth * CGFloat(pointerLabel.index)
        
        uiLabel.frame = CGRect(
            x: x,
            y: frame.height - CGFloat(pointerLabels.count - i) * labelHeight,
            width: barWidth,
            height: labelHeight)
    }

    private func configure(_ bar: UIView, at index: Int, values: [Int], pointerLabels: [PointerLabel]) {
        let barWidth = frame.width / CGFloat(values.count)
        let x = barWidth * CGFloat(index)
        
        let maxHeight = frame.height - CGFloat(pointerLabels.count) * labelHeight
        let value = values[index]
        let maxValue = values.max() ?? 0
        let percentage = CGFloat(value)/CGFloat(maxValue)
        let barHeight = maxHeight * percentage
        
        bar.frame = CGRect(
            x: x,
            y: maxHeight - barHeight,
            width: barWidth,
            height: barHeight)
        
        let borderColor = pointerLabels.first {
            $0.index == index && $0.borderColor != nil
        }?.borderColor ?? .black
        let borderWidth: CGFloat = bar.frame.width/12
        bar.layer.borderWidth = borderWidth
        bar.layer.borderColor = borderColor.cgColor
        bar.layer.cornerRadius = borderWidth * 4
        
        let minValue = values.min() ?? 0
        bar.backgroundColor = barColor(for: CGFloat(value - minValue) / CGFloat(maxValue - minValue) * 0.8)
    }
    
    private func barColor(for percentage: CGFloat) -> UIColor {
        return UIColor(hue: percentage, saturation: 0.6, brightness: 1.0, alpha: 1.0)
    }
}
