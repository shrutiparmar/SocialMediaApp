//
//  StoryImageScreen.swift
//  SocialMediaApp
//
//  Created by Shruri on 18/09/23.
//

import SwiftUI

struct StoryImageScreen: View {
    var avatarImage: Image?
    var storageManager = StorageManager()
    @State var isAnimate : Bool?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var scale: CGFloat = 1.0
    var body: some View {
        GeometryReader { reader in
            NavigationView {
                ZStack {
                    avatarImage?
                        .resizable()
                        
                        
                        .scaledToFill()
                        .cornerRadius(12)
                       
                        .edgesIgnoringSafeArea(.all)
                        .ignoresSafeArea(.all)
                       
                   
                        Button {
                            print("clickkk")
                            
                            self.isAnimate = true
                           
                            storageManager.upload(image: (avatarImage?.asUIImage() ?? UIImage(named: ""))!) { response in
                                self.isAnimate = false
                                if response == true {
                                   
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                
                            }
                        } label: {
                            Text("Done")
                                .foregroundColor(.black)
                                .padding(.all)
                                .background(.white)
                                .cornerRadius(22)
                        }

                    
                    .offset(x: 140, y: 300)
                  
                    if isAnimate ?? false {
                        ProgressView()
                            .frame(width: 70, height: 70)
                            .background(.white)
                            .cornerRadius(12)
                        .progressViewStyle(CircularProgressViewStyle())
                        .offset(x: 0, y: 0)
                    }
                   
                }
            }
        }
    }
}

struct StoryImageScreen_Previews: PreviewProvider {
    static var previews: some View {
        StoryImageScreen()
    }
}

extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
 // Set the background to be transparent incase the image is a PNG, WebP or (Static) GIF
        controller.view.backgroundColor = .clear
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
// here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
