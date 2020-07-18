//
//  HomeView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 18/07/2020.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack{
                PinnedRouteView().padding(.horizontal, 10)
                SearchView()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
            HomeView()
                .preferredColorScheme(.dark)
        }
    }
}
