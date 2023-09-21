//
//  PostDetailView.swift
//  SocialMediaApp
//
//  Created by Shruri on 21/09/23.
//

import SwiftUI

struct PostDetailView: View {
    var imageUrl : String?
    var reader : GeometryProxy
    
    var body: some View {
        
            
            VStack {
               
                HStack(spacing: 12)  {
                   
                       
                            NavigationLink(destination: ProfileDetailView()) {
                                Image(uiImage: UIImage(named: "img_profile")!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: reader.size.width * 0.11, height: reader.size.width * 0.11)
                                
                                    .cornerRadius(reader.size.width * 0.11 / 2)
                                
                                    .overlay(
                                            RoundedRectangle(cornerRadius: reader.size.width * 0.13 / 2)
                                                .stroke( .orange , lineWidth: 2)
                                                .background(.clear)
                                            
                                                .frame(width: reader.size.width * 0.13, height: reader.size.width * 0.13)
                                                .padding(.all)
                                                .clipped()
                                        )
                                            }
                        
                  
                    VStack (alignment: .leading, spacing: 7) {
                          
                              
                                Text("Sarah Jones")
                                    .font(.system(size: 15))
                                    .aspectRatio( contentMode: .fill)
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                
                            Text("30min ago")
                                .foregroundColor(.gray.opacity(0.8))
                                .font(.system(size: 12))
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
                        AsyncImage(url: URL(string: imageUrl ?? "" ))

                        { image in
                            image
                                .resizable()

                                .frame(width:  reader.size.width * 0.84, height: reader.size.height  * 0.35)
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(12)
                                
                               
                                
                        } placeholder: {
                            ProgressView()
                        }
                                    }
                  
                    
//                                        Image(uiImage: UIImage(named: "img_bg")!)
//                                            .resizable()
//
//                                            .frame(width: reader.size.width * 0.84, height: reader.size.height * 0.35)
//                                            .scaledToFit()
//                                            .cornerRadius(12)
                    
                    HStack {
                        Image(uiImage: UIImage(named: "like")!)
                        Text("  300  ")
                            .foregroundColor(.black)
                            .background(.white.opacity(0.3))
                            .cornerRadius(4)
                          
                            .font(.system(size: 12))
                       
                       
                    }
                    .frame(width: 120)
                    
                    .padding([.leading, .trailing], 20)
                    
                   
                      
                        .offset(x: -110, y: 112)
                        
                        
                }
            
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack {
                        HStack ( spacing: -4){
                            Image(uiImage: UIImage(named: "img_profile")!)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .cornerRadius(10)
                            Image(uiImage: UIImage(named: "img_profile")!)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .cornerRadius(10)
                            Image(uiImage: UIImage(named: "img_profile")!)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .cornerRadius(10)
                            
        
                        }
                      Text("Liked by")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text("amy_adams and 299")
                              .font(.system(size: 12))
                              .foregroundColor(.black)
                        Text("others")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        
                    }
                    
                    
                    Text("Lorem ipsum dolor sit amet,consectetuer adipiscing elit \nAenean commando ligula eget dolor")
                        .font(.system(size: 12))
                    
                    Text("View all 20 comments")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    
                    HStack(spacing : 0) {
                        Text("dirkhensiek_hh")
                            .font(.system(size: 11))
                            .foregroundColor(.black)
                            .bold()
                        Text("Very nice")
                            .foregroundColor(.gray)
                            .font(.system(size: 11))
                    }
                }
                .frame(width: reader.size.width * 0.9)
                
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
