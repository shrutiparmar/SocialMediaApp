//
//  ImageZoomScreen.swift
//  SocialMediaApp
//
//  Created by Shruri on 15/09/23.
//

import SwiftUI

struct ImageZoomScreen: View {
    @State private var scale: CGFloat = 1.0
    var image_url : String?
    var body: some View {
        GeometryReader { reader in
            VStack {
                Spacer()
                AsyncImage(url: URL(string: image_url ?? "" ))

                { image in
                    image
                        .resizable()

                        .frame(width:  reader.size.width * 0.9, height: reader.size.height  * 0.4)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                        .scaleEffect(scale)
                        .gesture(MagnificationGesture()
                            .onChanged { value in
                                if value.magnitude < 1.0 {
                                    
                                    self.scale = 1.0
                                } else {
                                    self.scale = value.magnitude
                                }
                            }
                            .onEnded { _ in
                                self.scale = 1.0
                            }
                        )
                       
                        
                } placeholder: {
                    ProgressView()
                }
                Spacer()
            }
            
            .padding([.leading, .trailing], 20)
        }
        .background(.black)
    }
}

struct ImageZoomScreen_Previews: PreviewProvider {
    static var previews: some View {
        ImageZoomScreen()
    }
}
