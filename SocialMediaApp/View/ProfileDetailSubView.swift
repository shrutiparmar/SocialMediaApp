//
//  profileDetailSubView.swift
//  SocialMediaApp
//
//  Created by Shruri on 22/09/23.
//

import SwiftUI
import CachedAsyncImage

struct ProfileDetailSubView: View {
    
    var item : Articles?
    
    var body: some View {
        publicDetailViewUI()
    }
    
    func publicDetailViewUI () -> some View {
        ZStack {
            CachedAsyncImage(url: URL(string: item?.urlToImage ?? "" ), urlCache: .imageCache) { image in
                image
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFit()
                    .cornerRadius(8)
            } placeholder: {
                Color.gray.opacity(0.1)
                    .frame(width: 150, height: 150)
                    .cornerRadius(8)
            }
            
            HStack {
                Image(uiImage: UIImage(named: "email")!)
                Text("648")
                    .foregroundColor(Color.whiteColor)
                    .font(.fontType(size: 12))
                Spacer()
                HStack(spacing: -4){
                    ForEach((0...2), id: \.self) { index in
                        Image(uiImage: UIImage(named: "img_profile")!)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .cornerRadius(10)
                    }
                }
            }
            .padding([.leading, .trailing], 10)
            .offset(x: 0, y: 52)
            
            
        }
    }
}

struct ProfileDetailSubView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailSubView()
    }
}
