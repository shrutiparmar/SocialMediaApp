//
//  ContentView.swift
//  SocialMediaApp
//
//  Created by Shruri on 12/09/23.
//

import SwiftUI

struct ProfileDetailView: View {
    
    let data = (1...10).map { "Item \($0)" }

       let columns = [
        GridItem(.fixed(150), spacing: 10),
        GridItem(.fixed(150), spacing: 10)
       ]
    
    @State private var Selection = 0
    @State var profileImages : [Articles]?
   
    
    
    var body: some View {
        
        GeometryReader { reader in
            NavigationView {
                VStack {
                    
                    ZStack{
                        Image(uiImage: UIImage(named: "img_bg")!)
                            .resizable()
                            .frame(width: reader.size.width, height: reader.size.height * 0.27)
                            .opacity(0.5)
                            .ignoresSafeArea()
                            
                            .overlay(
                        Rectangle()
//                            .fill(Color(red: 212/255, green: 212/255, blue: 212/255))
                            .frame(height: 60)
//                            .blur(radius: 50)
//                            .opacity(0.2)
                            .foregroundColor(.clear)        // Making rectangle transparent
                            .background(LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .top, endPoint: .bottom))
                            
                            .offset(y: reader.size.height * 0.05))
                             
                        Image(uiImage: UIImage(named: "img_profile")!)
                            .resizable()
                            .frame(width: reader.size.width * 0.28, height: reader.size.width * 0.28)
                            .cornerRadius(reader.size.width * 0.28 / 2)
                            .offset(y: reader.size.height * 0.08)
                            
                            .overlay(
                                    RoundedRectangle(cornerRadius: reader.size.width * 0.3 / 2)
                                        .stroke(.white, lineWidth: 3)
                                        
                                        .offset(y: reader.size.height * 0.08) //5
                                        .frame(width: reader.size.width * 0.29, height: reader.size.width * 0.29)
                                )
                            .overlay(
                                    RoundedRectangle(cornerRadius: reader.size.width * 0.35 / 2)
                                        .stroke(.orange, lineWidth: 3)
                                        
                                        .offset(y: reader.size.height * 0.08) //5
                                        .frame(width: reader.size.width * 0.3, height: reader.size.width * 0.3)
                                )
                        
                        Text("Sarah Jones")
                            .foregroundColor(.black)
                            .font(.system(size: 26))
                            .bold()
                            .offset(y: reader.size.height * 0.19)
                        
                        Text("@marck_jones")
                            .foregroundColor(.black)
                            .font(.system(size: 17))
                            .offset(y: reader.size.height * 0.23)
                        
                        Text("What's up andyfan don't forget to \nsubscribe to my youtube")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 13))
                            .offset(y: reader.size.height * 0.28)
                        
                        HStack(spacing: reader.size.width * 0.07) {
                            VStack(spacing: 5) {
                                Text("Posts")
                                    .font(.system(size: 14))
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                                Text("25")
                                    .font(.system(size: 18))
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                
                            }
                            .frame(width: reader.size.width * 0.2)
                            
                            VStack(spacing: 5) {
                                Text("Followers")
                                    .font(.system(size: 14))
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                                Text("20k")
                                    .font(.system(size: 18))
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                
                            }
                            .frame(width: reader.size.width * 0.2)
                            
                            VStack(spacing: 5) {
                                Text("Following")
                                    .font(.system(size: 14))
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                                Text("203")
                                    .font(.system(size: 18))
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                
                            }
                            .frame(width: reader.size.width * 0.2)
                        }
                        .offset(y: reader.size.height * 0.36)
                        
                        Button(action: {
                                print("Follow tapped")
                            }) {
                                Text("Follow")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.system(size: 16))
                                    .padding()
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.white, lineWidth: 2)
                                )
                            }
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 255/255, green: 121/255, blue: 0/255), Color(red: 255/255, green: 155/255, blue: 0/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                      )
                            .cornerRadius(16)
                            .offset(y: reader.size.height * 0.46)
                            .frame(width: reader.size.width * 0.8)
                        
                        Picker("", selection: $Selection) {
                                      Text("Images").tag(0)
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(CGSize(width: 0.84, height: 1.5))
                                
                                      Text("Videos").tag(1)
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(CGSize(width: 0.84, height: 1.5))
                               
                                  }
                                  .pickerStyle(.segmented)
                                 // .frame(width: reader.size.width * 0.8)
                                  .offset(y: reader.size.height * 0.37)
                                 
                                  .padding(10)
                                  .scaleEffect(CGSize(width: 0.84, height: 1.5))
                                  
                        ScrollView {
                                    LazyVGrid(columns: columns , spacing: 10) {
                                        ForEach(self.profileImages ?? [Articles(id: 0, urlToImage: "img_profile")], id: \.self) { item in
                                            ZStack {
                                        
                                                AsyncImage(url: URL(string: item.urlToImage ?? "" ))
                                                
                                                { image in
                                                    image
                                                        .resizable()
                                                        
                                                        .frame(width: 150, height: 150)
                                                        .scaledToFit()
                                                        .cornerRadius(8)
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                                
                                                HStack {
                                                    Image(uiImage: UIImage(named: "email")!)
                                                    Text("648")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 12))
                                                    Spacer()
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
                                                }
                                                .padding([.leading, .trailing], 10)
                                                
                                               
                                                  
                                                    .offset(x: 0, y: 52)
                                                    
                                                    
                                            }
                                          
                                                
                                        }
                                    }
                                  
                                    .padding(.horizontal)
                                    //.offset(y: reader.size.height * 0.8)
                               }
                                .frame(maxHeight: 300)
                               .offset(y: reader.size.height * 0.81)
                            
                              
                        
                    }
                
                    Spacer()
                   
                }
                
              
                .background(Color.white.ignoresSafeArea())
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
               
            }
            .ignoresSafeArea()
        }
        .onAppear {
            ProfileViewModel().GetProfileData { profileImages in
                if let profile = profileImages {
                    self.profileImages = profile
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView()
    }
}

