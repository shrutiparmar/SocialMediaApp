//
//  ContentView.swift
//  SocialMediaApp
//
//  Created by Shruri on 12/09/23.
//

import SwiftUI

struct ProfileDetailView {
        
    @State private var Selection = 0
    
    @State var profileImages : [Articles]
    @StateObject var viewModel = ProfileViewModel()
    let columns = [
        GridItem(.fixed(150), spacing: 10),
        GridItem(.fixed(150), spacing: 10)
    ]
}

extension ProfileDetailView: View {
    var body: some View {
        
        GeometryReader { reader in
            NavigationView {
                VStack {
                    userProfileView(reader: reader)
                    Spacer()
                }
                .background(Color.whiteColor.ignoresSafeArea())
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
               
            }
           
            .navigationTitle("")
           
        }
        .onAppear {
            Task{
                await viewModel.GetProfileData()
            }
//            ProfileViewModel().GetProfileData { profileImages in
//                if let profile = profileImages {
//                    self.profileImages = profile
//                }
//            }
        }
    }
    
    private func userProfileView(reader: GeometryProxy) ->  some View {
        ZStack{
            Image(uiImage: UIImage(named: "img_bg")!)
                .resizable()
                .frame(width: reader.size.width, height: reader.size.height * 0.27)
                .opacity(0.5)
                .ignoresSafeArea()
            
                .overlay(
                    Rectangle()
                        .frame(height: 60)
                        .foregroundColor(.clear)        // Making rectangle transparent
                        .background(LinearGradient(gradient: Gradient(colors: [.clear, Color.whiteColor]), startPoint: .top, endPoint: .bottom))
                    
                        .offset(y: reader.size.height * 0.05))
            
            Image(uiImage: UIImage(named: "img_profile")!)
                .resizable()
                .frame(width: reader.size.width * 0.28, height: reader.size.width * 0.28)
                .cornerRadius(reader.size.width * 0.28 / 2)
                .offset(y: reader.size.height * 0.08)
            
                .overlay(
                    RoundedRectangle(cornerRadius: reader.size.width * 0.3 / 2)
                        .stroke(Color.whiteColor, lineWidth: 3)
                    
                        .offset(y: reader.size.height * 0.08) //5
                        .frame(width: reader.size.width * 0.29, height: reader.size.width * 0.29)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: reader.size.width * 0.35 / 2)
                        .stroke(Color.orangeColor, lineWidth: 3)
                    
                        .offset(y: reader.size.height * 0.08) //5
                        .frame(width: reader.size.width * 0.3, height: reader.size.width * 0.3)
                )
            
            Text("Sarah Jones")
                .foregroundColor(Color.blackColor)
                .font(.fontType(size: 26))
                .bold()
                .offset(y: reader.size.height * 0.19)
            
            Text("@marck_jones")
                .foregroundColor(Color.blackColor)
                .font(.fontType(size: 17))
                .offset(y: reader.size.height * 0.23)
            
            Text("What's up andyfan don't forget to \nsubscribe to my youtube")
                .foregroundColor(Color.grayColor)
                .multilineTextAlignment(.center)
                .font(.fontType(size: 13))
                .offset(y: reader.size.height * 0.28)
            
            HStack(spacing: reader.size.width * 0.07) {
                VStack(spacing: 5) {
                    Text("Posts")
                        .font(.fontType(size: 14))
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.grayColor)
                    Text("25")
                        .font(.fontType(size: 18))
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.blackColor)
                    
                }
                .frame(width: reader.size.width * 0.2)
                
                VStack(spacing: 5) {
                    Text("Followers")
                        .font(.fontType(size: 14))
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.grayColor)
                    Text("20k")
                        .font(.fontType(size: 18))
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.blackColor)
                    
                }
                .frame(width: reader.size.width * 0.2)
                
                VStack(spacing: 5) {
                    Text("Following")
                        .font(.fontType(size: 14))
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.grayColor)
                    Text("203")
                        .font(.fontType(size: 18))
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.blackColor)
                    
                }
                .frame(width: reader.size.width * 0.2)
            }
            .offset(y: reader.size.height * 0.36)
            
            Button(action: {
                print("Follow tapped")
            }) {
                Text("Follow")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.fontType(size: 16))
                    .padding()
                    .foregroundColor(Color.whiteColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.whiteColor, lineWidth: 2)
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
            .offset(y: reader.size.height * 0.37)
            .scaleEffect(CGSize(width: 0.8, height: 1.5))
            
            ScrollView {
                LazyVGrid(columns: columns , spacing: 10) {
                    ForEach(self.viewModel.profileImages , id: \.self) { item in
                        ProfileDetailSubView(item: item)
                    }
                }
            }
            .frame(maxHeight: 300)
            .offset(y: reader.size.height * 0.81)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(profileImages: [])
    }
}

