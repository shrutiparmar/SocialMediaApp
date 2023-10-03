//
//  StoryDetailView.swift
//  SocialMediaApp
//
//  Created by Shruri on 22/09/23.
//

import SwiftUI
import PhotosUI

struct StoryDetailView: View {
    @State var navigated = false
    @State var imgStory = false
    @State private var photosPickerPresented = false
    @State private var avatarItem: PhotosPickerItem? = nil
    @State private var avatarImage: Image?
    @ObservedObject  var storageManager = StorageManager()
    @State var imgData : Data?
    var reader : GeometryProxy
   @State var imagesTime = UserDefaults.standard.array(forKey: "storyImages")
    var index : Int
    
    var body: some View {
        storyDetailViewUI()
            .onAppear {
                deleteStory()
            }
    }
    
     func deleteStory(){
         
        
        if index > 0 {
            if  let img = imagesTime?[index - 1]  {
                var NewDate = img
                let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: NewDate as? Date ?? Date(),to: Date())
                let hours = diffComponents.hour
               
               if hours ?? 0 > 24 {
                   imagesTime?.remove(at: index - 1)
                   UserDefaults.standard.set(imagesTime, forKey: "storyImages")
                   
                    storageManager.deleteItem(index: index - 1)
                }

            }
        }
       
    }
    
    func storyDetailViewUI () -> some View {
        VStack {
            if navigated == true {
                NavigationLink("", destination: StoryImageScreen(index: self.index,avatarImage: avatarImage), isActive: $navigated)
            }
            if imgStory == true {
                NavigationLink("", destination: StoryDetailScreen(imgData: self.imgData), isActive: $imgStory)
            }
            
            HStack {
                Image(uiImage: index != 0 ? UIImage(data: imgData ?? Data()) ?? UIImage(named: "img_profile")! : UIImage(named: "img_profile")! )
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: reader.size.width * 0.15, height: reader.size.width * 0.15)
                    .cornerRadius(reader.size.width * 0.15 / 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: reader.size.width * 0.17 / 2)
                            .stroke(index != 0 ? Color.orangeColor : (imgData != nil ? Color.orangeColor : Color.whiteColor), lineWidth: 2)
                            .background(.clear)
                            .frame(width: reader.size.width * 0.17, height: reader.size.width * 0.17)
                            .padding(.all)
                            .clipped()
                    )
                    .onTapGesture {
                        if index != 0 {
                            imgStory.toggle()
                        }
                    }
                Rectangle()
                    .fill(.clear)
                    .frame(width: 0)
                
            }
            VStack () {
                HStack(alignment: .center) {
                    
                    Text(index != 0 ? "Adammm" : "")
                        .font(.fontType(size: 11))
                        .aspectRatio( contentMode: .fill)
                        .multilineTextAlignment(.center)
                    
                    
                    Image(uiImage: (UIImage(named: index == 0 ? "add" : "white") )!)
                        .offset(y: -10)
                        .onTapGesture {
                            if index == 0 {
//                                if self.imgData != nil {
//                                    self.imgStory.toggle()
//                                }else {
                                    photosPickerPresented.toggle()
                               // }
                                
                            }
                            
                        }
                        .photosPicker(isPresented: $photosPickerPresented, selection: $avatarItem)
                        .onChange(of: avatarItem) { _ in
                            Task {
                                if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                                    if let uiImage = UIImage(data: data) {
                                        avatarImage = Image(uiImage: uiImage)
                                        self.navigated.toggle()
                                        
                                    }
                                }
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(index == 0 ? Color.whiteColor : .clear, lineWidth: index == 0 ? 2 : 0)
                                .background(.clear)
                                .frame(width: index == 0 ? 20 : 0, height: index == 0 ? 20 : 0)
                                .clipped()
                                .offset(y: -11)
                        )
                    Rectangle()
                        .fill(.clear)
                        .frame( width:  index == 0 ? 10 : 0 )
                }
            }
        }
        .frame(height: reader.size.width * 0.2)
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { reader in
            StoryDetailView(reader: reader, index: 0)
        }
        
    }
}
