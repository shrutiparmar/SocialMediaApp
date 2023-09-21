//
//  storyDetailScreen.swift
//  SocialMediaApp
//
//  Created by Shruri on 19/09/23.
//

import SwiftUI

struct storyDetailScreen: View {
    var imgData : Data?
    var body: some View {
        GeometryReader { reader in
            NavigationView {
                ZStack {
                    Image(uiImage: UIImage(data: imgData ?? Data()) ?? UIImage(named: "img_profile")!)
                        .resizable()
                        
                        
                        .scaledToFill()
                        .cornerRadius(12)
                       
                        .edgesIgnoringSafeArea(.all)
                        .ignoresSafeArea(.all)
                       
                   
                       
                    
                   
                }
            }
        }

    }
}

struct storyDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        storyDetailScreen()
    }
}
