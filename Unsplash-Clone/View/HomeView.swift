//
//  ContentView.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 3/30/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import SwiftUI
import MNkSupportUtilities

struct HomeView: View {
    
    @ObservedObject private var homeVM = HomeViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear // cell background
    }
    
    var items = [Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple]
    
    var body: some View {
        List {
            // Top Image View
            TopImageContainer()
                .listRowInsets(EdgeInsets())
            
            // Explore View
            VStack(spacing: 4) {
                HeaderView(headerName: "Explore")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 4) {
                        ForEach(homeVM.collectionList, id: \.id) { collection in
                            ExploreRowView(collection: collection)
                                .padding(.trailing, 30)
                                .shadow(radius: 10)
                        }
                    }
                    .frame(height: 200)
                }
            }
            
            // New View
            VStack(spacing:4) {
                HeaderView(headerName: "New")
                
                ForEach(homeVM.photoList, id: \.id) { photo in
                    NewRowView(photo: photo)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                }
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            self.homeVM.fetchHomeData()
        }
    }
    
    struct HeaderView: View {
        var headerName:String = ""
        
        var body: some View {
            HStack {
                Text("\(headerName)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .bold()
                    .padding(.top, 8)
                    .padding(.leading, 5)
                
                Spacer()
            }
            .background(Color.black)
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
