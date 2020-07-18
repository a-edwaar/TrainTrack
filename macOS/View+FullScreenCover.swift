//
//  View+FullScreenCover.swift
//  macOS
//
//  Created by Archie Edwards on 17/07/2020.
//

import SwiftUI

extension View {
    func fullScreenCover<Item: Identifiable, Content: View>(item: Binding<Item?>, @ViewBuilder content: @escaping (Item) -> Content) -> some View{
        return self.sheet(item: item, content: content)
    }
}
