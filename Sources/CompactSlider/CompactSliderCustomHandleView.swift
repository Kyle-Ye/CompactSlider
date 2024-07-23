//
//  CompactSliderCustomHandleView.swift
//
//
//  Created by Kyle on 2024/7/23.
//

import SwiftUI

// MARK: - Environment

struct CompactSliderCustomHandleViewKey: EnvironmentKey {
    static var defaultValue: AnyView?
}

extension EnvironmentValues {
    var compactSliderCustomHandleView: AnyView? {
        get { self[CompactSliderCustomHandleViewKey.self] }
        set { self[CompactSliderCustomHandleViewKey.self] = newValue }
    }
}

// MARK: - View Extension

public extension View {
    func compactSliderCustomHandleView<V: View>(@ViewBuilder content: () -> V) -> some View {
        environment(\.compactSliderCustomHandleView, AnyView(content()))
    }
}
