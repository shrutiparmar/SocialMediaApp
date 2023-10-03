//
//  storyDetailScreen.swift
//  SocialMediaApp
//
//  Created by Shruri on 19/09/23.
//

import SwiftUI

struct StoryDetailScreen: View {
    var imgData : Data?
    
    var body: some View {
        NavigationView {
            storyDetailScreenUI()
        }
    }
    
    func storyDetailScreenUI() -> some View {
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

struct StoryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailScreen()
    }
}
