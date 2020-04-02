//
//  ListHeaderView.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 4/2/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import SwiftUI

struct ListHeaderView: View {
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

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView()
    }
}
