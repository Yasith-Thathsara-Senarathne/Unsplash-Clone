//
//  ExploreRowView.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 4/2/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreRowView: View {
    var collection:Collection?
    
    var body: some View {
        ZStack(alignment: .center) {
            WebImage(url: collection?.coverPhoto.urls.thumb)
                .resizable()
                .scaledToFill()
                .frame(width:300 ,height: 150)
                .cornerRadius(8)
                .shadow(radius: 10)
            
            Rectangle()
                .frame(height: 25)
                .opacity(0.25)
                .blur(radius: 10)
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(collection?.title ?? "").lineLimit(nil)
                        .foregroundColor(.white)
                        .font(.body)
                }
                .frame(width: 300)
            }
        }
    }
}

struct ExploreRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreRowView()
    }
}
