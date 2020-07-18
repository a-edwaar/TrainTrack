//
//  PinnedRouteContentView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 18/07/2020.
//

import SwiftUI

struct PinnedRouteContentView<Content>: View where Content : View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                content
                Spacer()
            }.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
        .background(Color("Background"))
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 3)
                .foregroundColor(.yellow)
        )
    }
}

struct PinnedRouteContentView_Previews: PreviewProvider {
    static var previews: some View {
        PinnedRouteContentView{
            Text("BHM ")
                .font(.title)
                .bold()
            Label("ANY", systemImage: "arrow.right")
                .font(.title)
                .foregroundColor(.secondary)
        }.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}
