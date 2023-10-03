//
//  PostDetailView.swift
//  SocialMediaApp
//
//  Created by Shruri on 21/09/23.
//

import SwiftUI
import CachedAsyncImage

struct PostDetailView: View {
    var imageUrl : String?
    var reader : GeometryProxy
    
    var body: some View {
        postDetailViewUI(reader: self.reader)
    }
    
    
    func postDetailViewUI (reader : GeometryProxy) -> some View  {
        VStack {
            HStack(spacing: 12)  {
                NavigationLink(destination: ProfileDetailView(profileImages: [])) {
                    Image(uiImage: UIImage(named: "img_profile")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: reader.size.width * 0.11, height: reader.size.width * 0.11)
                        .cornerRadius(reader.size.width * 0.11 / 2)
                        .overlay(
                            RoundedRectangle(cornerRadius: reader.size.width * 0.13 / 2)
                                .stroke(Color.orangeColor , lineWidth: 2)
                                .background(.clear)
                                .frame(width: reader.size.width * 0.13, height: reader.size.width * 0.13)
                                .padding(.all)
                                .clipped()
                        )
                }
                VStack (alignment: .leading, spacing: 7) {
                    Text("Sarah Jones")
                        .font(.fontType(size: 15))
                        .aspectRatio( contentMode: .fill)
                        .multilineTextAlignment(.leading)
                        .bold()
                    Text("30min ago")
                        .foregroundColor(Color.grayColor.opacity(0.8))
                        .font(.fontType(size: 12))
                        .aspectRatio( contentMode: .fill)
                        .multilineTextAlignment(.leading)
                        .bold()
                }
                Spacer()
                Image(uiImage: UIImage(named: "more")!)
            }
            .frame(width: reader.size.width * 0.8)
            ZStack {
                NavigationLink(destination:  ImageZoomScreen( image_url: imageUrl ?? "")) {
                    CachedAsyncImage(url: URL(string: imageUrl ?? "" ), urlCache: .imageCache) { image in
                        image
                            .resizable()
                            .frame(width:  reader.size.width * 0.84, height: reader.size.height  * 0.35)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(12)
                    } placeholder: {
                        Color.gray.opacity(0.1)
                            .frame(width:  reader.size.width * 0.84, height: reader.size.height  * 0.35)
                            .cornerRadius(12)
                    }
                }
                HStack {
                    Image(uiImage: UIImage(named: "like")!)
                    Text("  300  ")
                        .foregroundColor(Color.blackColor)
                        .background(Color.whiteColor.opacity(0.3))
                        .cornerRadius(4)
                        .font(.fontType(size: 12))
                }
                .frame(width: 100)
                .padding([.leading, .trailing], 20)
                .offset(x: -110, y: 112)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    HStack ( spacing: -4){
                        ForEach((0...2), id: \.self) { index in
                            Image(uiImage: UIImage(named: "img_profile")!)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .cornerRadius(10)
                        }
                    }
                    Text("Liked by")
                        .font(.fontType(size: 12))
                        .foregroundColor(Color.grayColor)
                    Text("amy_adams and 299")
                        .font(.fontType(size: 12))
                        .foregroundColor(Color.blackColor)
                    Text("others")
                        .foregroundColor(Color.grayColor)
                        .font(.fontType(size: 12))
                }
                Text("Lorem ipsum dolor sit amet,consectetuer adipiscing elit \nAenean commando ligula eget dolor")
                    .font(.fontType(size: 12))
                Text("View all 20 comments")
                    .foregroundColor(Color.grayColor)
                    .font(.fontType(size: 12))
                HStack(spacing : 0) {
                    Text("dirkhensiek_hh")
                        .font(.fontType(size: 11))
                        .foregroundColor(Color.blackColor)
                        .bold()
                    Text("Very nice")
                        .foregroundColor(Color.grayColor)
                        .font(.fontType(size: 11))
                }
            }
            .frame(width: reader.size.width * 0.9)
            .offset(x: -16)
            Rectangle()
                .fill(.clear)
                .frame(height: 15)
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader {reader in
            PostDetailView(imageUrl: "img_bg", reader: reader)
        }
        
    }
}
