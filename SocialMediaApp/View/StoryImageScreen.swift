//
//  StoryImageScreen.swift
//  SocialMediaApp
//
//  Created by Shruri on 18/09/23.
//

import SwiftUI

struct StoryImageScreen: View {
    var index : Int?
    var avatarImage: Image?
    var storageManager = StorageManager()
    @State var isAnimate : Bool?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        GeometryReader { reader in
            NavigationView {
                
                StoryImageScreenUI(reader: reader)
            }
           
                .overlay {
                    if isAnimate ?? false {
                    ProgressView()
                        .frame(width: 70, height: 70)
                        .background(Color.whiteColor)
                        .cornerRadius(12)
                        .progressViewStyle(CircularProgressViewStyle())
                        .offset(x: 0, y: 0)
                }
               
            }

        }
    }
    
    func StoryImageScreenUI(reader: GeometryProxy) -> some View {
        
        ZStack {
          
            avatarImage?
                .resizable()
                .scaledToFill()
                .cornerRadius(12)
                .edgesIgnoringSafeArea(.all)
                .ignoresSafeArea(.all)
            Button {
                print("clickkk")
                DispatchQueue.main.async {
                    self.isAnimate = true
                }
               
                storageManager.upload(image: (avatarImage?.asUIImage() ?? UIImage(named: "img_profile"))!, index: self.index ?? 0, title: self.avatarImage.debugDescription) { response in
                    
                    if response == true {
                        DispatchQueue.main.async {
                            self.isAnimate = false
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            } label: {
                Text("Done")
                    .foregroundColor(Color.blackColor)
                    .padding(.all)
                    .background(Color.whiteColor)
                    .cornerRadius(22)
            }
            .offset(x: 140, y: 300)
          
        }
    }
    
}

struct StoryImageScreen_Previews: PreviewProvider {
    static var previews: some View {
        StoryImageScreen()
    }
}

