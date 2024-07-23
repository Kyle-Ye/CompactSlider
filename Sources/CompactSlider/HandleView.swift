// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
//

import SwiftUI

struct HandleView: View {
    
    @Environment(\.compactSliderSecondaryAppearance) private var secondaryAppearance
    @Environment(\.compactSliderCustomHandleView) private var customView

    let width: CGFloat
    let offsetX: CGFloat
    let isFocused: Bool
    
    var body: some View {
        Group {
            if let customView = customView {
                customView
            } else {
                Rectangle()
                    .fill(isFocused ? Color.accentColor : secondaryAppearance.handleColor)
            }
        }
        .frame(width: width)
        .offset(x: offsetX)
    }
}

extension CompactSlider {
    func progressHandleView(_ progress: Double, size: CGSize) -> some View {
        Group {
            if handleVisibility.width > 0 {
                HandleView(
                    width: handleVisibility.width,
                    offsetX: (size.width - handleVisibility.width) * (progress - 0.5),
                    isFocused: isHovering || isDragging
                )
            }
        }
    }
}

#if DEBUG && swift(>=5.10)

struct DemoStyle: CompactSliderStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(
                Color.label.opacity(configuration.isHovering || configuration.isDragging ? 1 : 0.7)
            )
            .background(Capsule().fill(Color.label.opacity(0.075)))
    }
}


@available(iOS 17, macOS 14, watchOS 10, *)
#Preview {
    CompactSlider(value: .constant(1), in: 0...10, step: 1.0, handleVisibility: .always(width: 10), minHeight: 20) {
        EmptyView()
    }
    .compactSliderCustomHandleView {
        Capsule()
            .fill(.red)
            .frame(height: 33)
            .frame(height: 20)
    }
    .compactSliderStyle(DemoStyle())
    .padding()
}

#endif
