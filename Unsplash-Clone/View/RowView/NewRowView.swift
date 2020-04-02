//
//  NewRowView.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 4/2/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewRowView: View {
    var photo:Photo?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WebImage(url: photo?.urls.regular)
                .resizable()
                .scaledToFill()
                .cornerRadius(4)
                .shadow(radius: 10)
            
            Rectangle()
                .frame(height: 60)
                .opacity(0.5)
                .blur(radius: 10)
            
            UserDetailsView(user: photo!.user)
                .padding(.leading, 10)
                .padding(.bottom, 10)
        }
    }
    
    struct UserDetailsView: View {
        var user:User
        
        var body: some View {
            HStack {
                WebImage(url: user.profileImage.medium)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 30, height: 30)
                    .shadow(radius: 10)
                
                Text(user.name)
                    .foregroundColor(.white)
                    .font(.subheadline)
                
                Spacer()
                
                
            }
        }
    }
}

#if DEBUG
struct NewRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewRowView()
    }
}
#endif
