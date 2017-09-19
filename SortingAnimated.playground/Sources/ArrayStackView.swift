import UIKit
import XCPlayground
import PlaygroundSupport

public class ArrayStackView: UIView {
    public var values: [Int] = [] {
        didSet {
            updateAllViews()
        }
    }
    
    private let viewWidth: CGFloat = 600
    private let viewHeight: CGFloat = 400
    
    // MARK: Init
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        backgroundColor = #colorLiteral(red: 0.2811661655, green: 0.3164002355, blue: 0.4330782043, alpha: 1)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Show View
    
    public func show() {
        PlaygroundPage.current.needsIndefiniteExecution = true
        PlaygroundPage.current.liveView = self
    }
    
    // MARK: Insert Values
    
    public func insertValues(newValues: [Int], startingFrom start: Int) {
        var currentValues = values
        
        for (index, value) in newValues.enumerated() {
            currentValues[index + start] = value
        }
        
        values = currentValues
    }
    
    // MARK: Configure Views
    
    func updateAllViews() {
        if subviews.count != values.count {
            addBars(values.count)
        }
        
        for (index, bar) in subviews.enumerated() {
            configure(bar, at: index)
        }
        
        // Display view now, instead of waiting until all CATransactions finished.
        CATransaction.flush()
    }
    
    private func addBars(_ count: Int) {
        func newBar() -> UIView {
            let bar = UIView()
            bar.translatesAutoresizingMaskIntoConstraints = false
            return bar
        }
        
        for view in subviews {
            view.removeFromSuperview()
        }
        
        for _ in 1...count {
            addSubview(newBar())
        }
    }
    
    private func configure(_ bar: UIView, at index: Int) {
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
        bar.backgroundColor = color(for: percentage)
    }
    
    private func color(for percentage: CGFloat) -> UIColor {
        return UIColor(hue: percentage, saturation: 0.6, brightness: 1.0, alpha: 1.0)
    }
}
