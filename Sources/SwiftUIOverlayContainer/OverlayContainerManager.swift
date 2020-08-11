// 用于SwiftUI的通用Overlay View显示控件
// 项目代码结构模仿了 https://github.com/AndreaMiotto/PartialSheet/
// Created by Yang Xu on 2020/7/24.
//

import Combine
import SwiftUI

#if os(macOS)
import AppKit
#endif


public class OverlayContainerManager: ObservableObject {
    
    @Published var isPresented: Bool = false
    {
        didSet {
            if !isPresented {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
                    self?.content = AnyView(EmptyView())
                    self?.onDismiss = nil
                }
            }
        }
    }
    

    private(set) var content: AnyView

    private(set) var onDismiss: (() -> Void)?
    
    public init() {
        self.content = AnyView(EmptyView())
    }
    
    public func showOverlayView<T>(_ onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> T) where T: View {
        self.content = AnyView(content())
        self.onDismiss = onDismiss
        self.isPresented = true
    }
    

    public func closeOverlayView() {
        self.isPresented = false
        self.onDismiss?()
    }
}

public struct OverlayContainerShadow{
    let color: Color
    let radius:CGFloat
    let x:CGFloat
    let y:CGFloat
    
    public init(color:Color = Color(.sRGBLinear, white: 0, opacity: 0.33),radius:CGFloat = 10,x:CGFloat = 4,y:CGFloat = 0 ){
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
}

public struct OverlayContainerStyle{
    
    let alignment:Alignment
    let coverColor:Color?
    let blur:BlurEffect?
    let shadow:OverlayContainerShadow?
    let animation:Animation?
    let transition:AnyTransition?
    let animatable:Bool
    let autoHide:Double?
    let enableDrag:Bool
    let clickDismiss:Bool
    
    public init(alignment:Alignment = .center,coverColor:Color? = Color.black.opacity(0.4),shadow:OverlayContainerShadow? = nil,blur:BlurEffect? = nil, animation:Animation? = .easeInOut, transition:AnyTransition? = .opacity,animatable:Bool = true,autoHide:Double? = nil,enableDrag:Bool = false,clickDismiss:Bool = false){
        self.alignment = alignment
        self.animation = animation
        self.transition = transition
        self.animatable = animatable
        self.coverColor = coverColor
        self.blur = blur
        self.shadow = shadow
        self.autoHide = autoHide
        self.enableDrag = enableDrag
        self.clickDismiss = clickDismiss
    }
    
    
    public static func defaultStyle() -> OverlayContainerStyle{
        OverlayContainerStyle(alignment: .center, animation: .easeInOut,transition: .opacity,animatable: true )
    }
}
#if os(iOS)
internal struct BlurEffectView: UIViewRepresentable {
    
    /// The style of the Blut Effect View
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
#endif

#if os(macOS)
internal struct BlurEffectView: NSViewRepresentable
{
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode = .withinWindow
    
    func makeNSView(context: Context) -> NSVisualEffectView
    {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
        visualEffectView.state = NSVisualEffectView.State.active
        return visualEffectView
    }
    
    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context)
    {
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
    }
}
#endif

#if os(iOS)
public typealias BlurEffect = UIBlurEffect.Style
#endif
#if os(macOS)
public typealias BlurEffect = NSVisualEffectView.Material
#endif
