//
//  ContainerViewConfiguration.swift
//  SwiftUIOverlayContainer
//
//  Created by Yang Xu on 2022/3/9
//  Copyright © 2022 Yang Xu. All rights reserved.
//
//  Follow me on Twitter: @fatbobman
//  My Blog: https://www.fatbobman.com
//

import Foundation
import SwiftUI

public protocol ContainerViewConfigurationProtocol {
    /// The alignment of view in container
    ///
    /// Each view has own alignment when the container display type is stacking.
    /// All views use the one of container configuration's alignment when container display type is horizontal or vertical
    var alignment: Alignment? { get }

    /// Pass true , the view will be dismissed when the background is clicked
    ///
    /// Each view has own tapToDismiss when the container display type is stacking
    /// All view use the one of container configuration's tapToDismiss when container display type is horizontal or vertical
    var tapToDismiss: Bool? { get }

    /// The background of container
    ///
    /// Each view has own background when the container display type is stacking
    /// There is only one background when the container display type is horizontal or vertical
    var backgroundStyle: ContainerBackgroundStyle? { get }

    /// The transition of background of view.
    var backgroundTransitionStyle: ContainerBackgroundTransitionStyle { get }

    /// The shadow of overlay view
    var shadowStyle: ContainerViewShadowStyle? { get }

    /// The gesture of dismiss
    var dismissGesture: ContainerViewDismissGesture? { get }

    /// The transition of view display and dismiss
    var transition: AnyTransition? { get }

    /// Pass .second(2) will dismiss the view after 2 seconds automaticlly
    var autoDismiss: ContainerViewAutoDismiss? { get }

    /// a method to call when the view is dismissed. Will not run if the view in the temp queue (oneByOneWaitFinish)
    var disappearAction: (() -> Void)? { get }

    /// a method to call when the view is displayed. Will not run if the view in the temp queue (oneByOneWaitFinish)
    var appearAction: (() -> Void)? { get }

    /// the animation that be used for transition
    var animation: Animation? { get }
}

public typealias ContainerView = View & ContainerViewConfigurationProtocol

public extension ContainerViewConfigurationProtocol {
    var alignment: Alignment? { nil }

    var tapToDismiss: Bool? { nil }

    var backgroundStyle: ContainerBackgroundStyle? { nil }

    var backgroundTransitionStyle: ContainerBackgroundTransitionStyle { .opacity }

    var shadowStyle: ContainerViewShadowStyle? { nil }

    var dismissGesture: ContainerViewDismissGesture? { nil }

    var transition: AnyTransition? { nil }

    var autoDismiss: ContainerViewAutoDismiss? { nil }

    var disappearAction: (() -> Void)? { {} }

    var appearAction: (() -> Void)? { {} }

    var animation: Animation? { nil }
}
