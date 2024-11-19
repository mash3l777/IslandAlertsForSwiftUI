//
//  DynamicIsland.swift
//  
//
//  Created by Alessio Rubicini on 20/09/22.
//

import Foundation
import SwiftUI

@MainActor
private class DynamicIsland {

    static let width: CGFloat = 125
    static let heigth: CGFloat = 0
    
    private init() {}
    
    static var islandExpandedSize: CGFloat {
        UIDevice.modelName.contains("Pro Max") ? 400 : 360
    }
    
    struct IslandLargeFrame: ViewModifier {
        @Binding var isPresented: Bool
        func body(content: Content) -> some View {
            content
                .frame(width: isPresented ? DynamicIsland.islandExpandedSize:DynamicIsland.width, height: isPresented ? 200:DynamicIsland.heigth)
        }
    }
    
    struct IslandMediumFrame: ViewModifier {
        @Binding var isPresented: Bool
        func body(content: Content) -> some View {
            content
                .frame(width: isPresented ? DynamicIsland.islandExpandedSize:DynamicIsland.width, height: isPresented ? 90:DynamicIsland.heigth)
        }
    }
    
    struct IslandSquareFrame: ViewModifier {
        @Binding var isPresented: Bool
        func body(content: Content) -> some View {
            content
                .frame(width: isPresented ? 140:DynamicIsland.width, height: isPresented ? 140:DynamicIsland.heigth)
        }
    }
}

extension View {
    var safeAreaInsets: EdgeInsets {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows.first?
            .safeAreaInsets.edgeInsets ?? EdgeInsets()
    }
    
    var hasNotch: Bool {
        return safeAreaInsets.top > 20
    }
    
    
    func islandLargeFrame(isPresented: Binding<Bool>) -> some View {
        ModifiedContent(content: self, modifier: DynamicIsland.IslandLargeFrame(isPresented: isPresented))
    }
    func islandMediumFrame(isPresented: Binding<Bool>) -> some View {
        ModifiedContent(content: self, modifier: DynamicIsland.IslandMediumFrame(isPresented: isPresented))
    }
    func islandSquareFrame(isPresented: Binding<Bool>) -> some View {
        ModifiedContent(content: self, modifier: DynamicIsland.IslandSquareFrame(isPresented: isPresented))
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows.first?
            .safeAreaInsets.edgeInsets ?? EdgeInsets()
    }
}

extension UIEdgeInsets {
    var edgeInsets: EdgeInsets {
        EdgeInsets(top: self.top, leading: self.left, bottom: self.bottom, trailing: self.right)
    }
}
