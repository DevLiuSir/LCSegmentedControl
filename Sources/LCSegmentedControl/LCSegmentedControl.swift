//
//  LCSegmentedControl.swift
//
//
//  Created by DevLiuSir on 2018/4/26.
//

import Cocoa


/// 自定义分段式控件
final public class LCSegmentedControl: NSSegmentedControl {
    
    /// 封装属性，方便修改选中 segment 的颜色
    var selectedSegmentColor: NSColor = .controlAccentColor {
        didSet {
            applySelectedColor()
            // 强制重绘，以便自定义 cell 也能立即使用新的颜色
            needsDisplay = true
        }
    }
    
    
    // MARK: - 初始化
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupCellIfNeeded()
    }
    
    
    /// 应用当前选中颜色到系统样式
    private func applySelectedColor() {
        if segmentStyle == .rounded {
            selectedSegmentBezelColor = selectedSegmentColor
        }
    }
    
    
    /// 如果你是在纯代码创建控件并立即要替换 cell，可以在外部调用这个方法。
    private func setupCellIfNeeded() {
        if segmentStyle == .rounded {
            applySelectedColor()
            return
        }
        
        // 保存旧配置（label/image/tracking/selected）
        let oldCount = segmentCount
        let oldLabels = (0..<oldCount).map { label(forSegment: $0) }
        let oldImages = (0..<oldCount).map { image(forSegment: $0) }
        let oldTracking = trackingMode
        
        // 保存每个 segment 的 selected 状态（重要）
        var oldSelectedStates = [Bool]()
        for i in 0..<oldCount {
            oldSelectedStates.append(isSelected(forSegment: i))
        }
        
        // 替换自定义 cell 并恢复 segmentCount
        let customCell = LCSegmentedCell()
        customCell.segmentCount = oldCount
        self.cell = customCell
        
        // 恢复内容
        for i in 0..<oldCount {
            if let label = oldLabels[i] { setLabel(label, forSegment: i) }
            if let image = oldImages[i] { setImage(image, forSegment: i) }
            setSelected(oldSelectedStates[i], forSegment: i) // 恢复每段 selected 标记
        }
        trackingMode = oldTracking
        
        // 强制重绘（保证初始选中能立刻可见）
        needsDisplay = true
        for _ in 0..<oldCount {
            // 如果你想让每个 segment 刷新
            if let segView = cell?.controlView {
                segView.setNeedsDisplay(segView.bounds)
            }
        }
    }
}
