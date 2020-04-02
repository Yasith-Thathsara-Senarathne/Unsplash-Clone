//
//  TopImageContainer1.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 3/31/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct TopImageContainer: View {
    
    var body: some View {
        ZStack(alignment: .center) {
            TopAccountView()
            
            VStack {
                HStack {
                    SearchView(userName: "")
                }
            }
            .padding(.leading)
            .padding(.trailing)
        }
    }
    
    /// SearchView Component
    struct SearchView: View {
        @State var userName:String = ""
        var body: some View {
            ZStack(alignment: .center) {
                Rectangle()
                    .frame(height: 100)
                    .opacity(0.5)
                    .blur(radius: 10)
                
                VStack(alignment: .center, spacing: 8) {
                    Text("Photos for everyone")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                        .lineLimit(1)
                    
                    TextField("  Search photos", text: $userName)
                        .foregroundColor(.white)
                        .frame(height: 40)
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .shadow(radius: 8)
                }
            }
        }
    }
    
    /// TopAccountView Component
    struct TopAccountView: View {
        @State var photo:Photo!
        
        var body: some View {
            ZStack(alignment: .top) {
                ImageContainer()
                
                HStack {
                    Image("unsplash_symbol")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .shadow(radius: 10)
                    
                    Spacer()
                    
                    Image("user")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .shadow(radius: 10)
                }
                .padding(.top, 30)
                .padding(.leading)
                .padding(.trailing)
            }
        }
        
        /// ImageContainer Component
        struct ImageContainer: View {
            @ObservedObject private var homeVM = HomeViewModel()
            
            init() {
                homeVM.startTimerToGetRandomPhoto()
            }
            
            var body: some View {
                ZStack(alignment: .bottom) {
                    VStack(alignment: .center) {
                        WebImage(url: homeVM.randomPhoto?.urls.full)
                            .resizable()
                            .scaledToFill()
                            .clipped(antialiased: true)
                            .frame(height: 350)
                            .shadow(radius: 10)
                    }
                    
                    Rectangle()
                        .frame(height: 30)
                        .opacity(0.25)
                        .blur(radius: 10)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(homeVM.randomPhoto?.user.name ?? "")
                                .foregroundColor(.white)
                                .font(.body)
                                .padding(.bottom)
                        }
                    }
                }
                .clipped(antialiased: true)
            }
        }
    }
}

struct TopImageContainer1_Previews: PreviewProvider {
    static var previews: some View {
        TopImageContainer()
    }
}
