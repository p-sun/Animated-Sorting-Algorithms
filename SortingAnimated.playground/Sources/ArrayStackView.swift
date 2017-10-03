import UIKit
import XCPlayground
import PlaygroundSupport
import Dispatch

public class ArrayStackView: UIView {
    private let viewWidth: CGFloat = 400
    private let viewHeight: CGFloat = 300
    private let delayInSeconds: Double = 0.05
    
    private let updateOperations = OperationQueue()

    // MARK: Init
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        backgroundColor = #colorLiteral(red: 0.2811661655, green: 0.3164002355, blue: 0.4330782043, alpha: 1)
        updateOperations.maxConcurrentOperationCount = 1
        
        PlaygroundPage.current.liveView = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Add an Operation to re-draw bars after a delay.
    public func update(with values: [Int]) {
        let updateOperation = BlockOperation { [weak self] in
            self?.drawBars(with: values)
        }
        updateOperations.addOperation(DelayOperation(delayInSeconds))
        updateOperations.addOperation(updateOperation)
    }
    
    // MARK: Bar Drawing
    
    private func drawBars(with values: [Int]) {
        if subviews.count != values.count {
            addSubviews(values.count)
        }
        
        for (index, bar) in subviews.enumerated() {
            configure(bar, at: index, values: values)
        }
        
        // Force the playground to re-render.
        CATransaction.flush()
    }
    
    /// Setup a number of subviews equal to the number of bars.
    private func addSubviews(_ count: Int) {
        for view in subviews {
            view.removeFromSuperview()
        }
        
        for _ in 1...count {
            let bar = UIView()
            bar.translatesAutoresizingMaskIntoConstraints = false
            addSubview(bar)
        }
    }
    
    private func configure(_ bar: UIView, at index: Int, values: [Int]) {
        let barWidth = frame.width / CGFloat(values.count)

        let x = barWidth * CGFloat(index)
        
        let value = values[index]
        let maxValue = values.max() ?? 0
        let percentage = CGFloat(value)/CGFloat(maxValue)
        let height = frame.height * percentage
        
        bar.frame = CGRect(
            x: x,
            y: frame.height - height,
            width: barWidth,
            height: height)
        
        let borderWidth: CGFloat = bar.frame.width/12
        bar.layer.borderWidth = borderWidth
        bar.layer.borderColor = UIColor.black.cgColor
        bar.layer.cornerRadius = borderWidth * 4
        bar.backgroundColor = barColor(for: percentage)
    }
    
    private func barColor(for percentage: CGFloat) -> UIColor {
        return UIColor(hue: percentage, saturation: 0.6, brightness: 1.0, alpha: 1.0)
    }
}
