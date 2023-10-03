//
//  ImageZoomScreen.swift
//  SocialMediaApp
//
//  Created by Shruri on 15/09/23.
//

import SwiftUI
import CachedAsyncImage

struct ImageZoomScreen: View {
    
    @State private var scale: CGFloat = 1.0
    var image_url : String?
    
    var body: some View {
        GeometryReader { reader in
            ImageZoomScreenUI(reader: reader)
        }
        .background(Color.blackColor)
    }
    
    func ImageZoomScreenUI (reader: GeometryProxy) -> some View {
        VStack {
            Spacer()
            CachedAsyncImage(url: URL(string: image_url ?? "" ), urlCache: .imageCache) { image in
                image
                    .resizable()
                    .frame(width: reader.size.width * 0.9, height: reader.size.height  * 0.4)
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
                Color.gray.opacity(0.1)
                    .frame(width: reader.size.width * 0.9, height: reader.size.height  * 0.4)
                    .cornerRadius(12)
            }
            Spacer()
        }
        .padding([.leading, .trailing], 20)
    }
    
    
}

struct ImageZoomScreen_Previews: PreviewProvider {
    static var previews: some View {
        ImageZoomScreen()
    }
}
