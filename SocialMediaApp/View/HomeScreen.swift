//
//  HomeScreen.swift
//  SocialMediaApp
//
//  Created by Shruri on 13/09/23.
//

import SwiftUI

import PhotosUI

struct HomeScreen: View {
    @State private var photosPickerPresented = false
      @State private var photoPickerItems = [PhotosPickerItem]()
    @State private var avatarItem: PhotosPickerItem? = nil
    @State private var avatarImage: Image?
    @ObservedObject  var storageManager = StorageManager()
    @State private var refresh: Bool = false
    var rowGrid = [GridItem(.fixed(90), spacing: 10)]
    let columns = [
     GridItem(.fixed(150), spacing: 10)
    ]
   
    @State var imgData : Data?
    @State var isAnimation : Bool? = false
    @State private var scale: CGFloat = 1.0
 @State private var Selection = 0
 @State var profileImages : [Articles]?
    @State var navigated = false
    @State var imgStory = false
    @State private var counter = 0
    @AppStorage("date") var date: Date?
    func localToUTC(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "H:mm:ss"
        
            return dateFormatter.string(from: date)
        }
        return nil
    }

    
    var body: some View {
        GeometryReader { reader in
            NavigationView {
                ScrollView {
                   
                    VStack(spacing: 15) {
                        if navigated == true {
                            NavigationLink("", destination: StoryImageScreen(avatarImage: avatarImage), isActive: $navigated)
                        }
                        if imgStory == true {
                            NavigationLink("", destination: storyDetailScreen(imgData: self.imgData), isActive: $imgStory)
                        }
                       
                        HStack(alignment: .center) {
                            
                            Text("Venus")
                                .foregroundColor(.orange)
                                .font(.title)
                                .bold()
                               
                            Spacer()
                            Image(uiImage: UIImage(named: "notification")!)
                                .padding()
                        }
                        .padding(.init(top: 0, leading: 30, bottom: 0, trailing: 20))
                        ScrollView(.horizontal) {
                            PullToRefreshSwiftUI(needRefresh: $refresh,
                                                            coordinateSpaceName: "pullToRefresh") {
                                           DispatchQueue.main.asyncAfter(deadline: .now()) {
                                               withAnimation {
                                                   
                                                   refresh = false
                                            
                                                   let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: date ?? Date(), to: Date())
                                                   let hours = diffComponents.hour
                                                   let minutes = diffComponents.minute
                                                   print("difference \(hours) - \(minutes)")
                                                   if hours ?? 0 > 24 {
                                                       storageManager.deleteItem()
                                                    
                                                   }
                                                   self.storageManager.savedImages { response in
                                                       self.imgData = response
                                                       
                                                   }
                                               }
                                           }
                                       }
                            LazyHGrid(rows: rowGrid ) {
                                // Display the item
                                ForEach((0...12), id: \.self) { index in
                                    VStack (){
                                        HStack {
                                            Image(uiImage: UIImage(named: "img_profile")!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: reader.size.width * 0.15, height: reader.size.width * 0.15)
                                        
                                            .cornerRadius(reader.size.width * 0.15 / 2)
                                        
                                            .overlay(
                                                    RoundedRectangle(cornerRadius: reader.size.width * 0.17 / 2)
                                                        .stroke(index != 0 ? .orange : (imgData != nil ? .orange : .white), lineWidth: 2)
                                                        .background(.clear)
                                                    
                                                        .frame(width: reader.size.width * 0.17, height: reader.size.width * 0.17)
                                                        .padding(.all)
                                                        .clipped()
                                                )
                                        Rectangle()
                                            .fill(.clear)
                                            .frame(width: 0)
                                       
                                    }
                                        VStack () {
                                            HStack(alignment: .center) {
                                              
                                                Text(index != 0 ? "Adammm" : "")
                                                    .font(.system(size: 11))
                                                    .aspectRatio( contentMode: .fill)
                                                    .multilineTextAlignment(.center)
                                                    
                                                  
                                                Image(uiImage: (UIImage(named: index == 0 ? "add" : "white") )!)
                                                    .offset(y: -10)
                                                    .onTapGesture {
                                                        if index == 0 {
                                                            print("add story click \(self.imgData)")
                                                            if self.imgData != nil {
                                                                self.imgStory.toggle()
                                                            }else {
                                                                photosPickerPresented.toggle()
                                                            }
                                                           
                                                        }
                                                       
                                                    }
                                                    .photosPicker(isPresented: $photosPickerPresented, selection: $avatarItem)
                                                    .onChange(of: avatarItem) { _ in
                                                        Task {
                                                            print("avtar Item \(avatarItem)")
                                                            
                                                            if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                                                                if let uiImage = UIImage(data: data) {
                                                                    avatarImage = Image(uiImage: uiImage)
                                                                    print("image return \(avatarImage)")
                                                                    self.navigated.toggle()
                                                                  
                                                                }
                                                            }
                                                            
                                                            print("Failed")
                                                        }
                                                    }

                                                
                                                    .overlay(
                                                            RoundedRectangle(cornerRadius: 10)
                                                                .stroke(index == 0 ? .white : .clear, lineWidth: index == 0 ? 2 : 0)
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
                            .padding([.leading], 30)
                           
                           
                        }
                        .scrollIndicators(.hidden)
                        
                        LazyVGrid(columns: columns , spacing: 10) {
                            ForEach(self.profileImages ?? [Articles(id: 0, urlToImage: "img_profile")], id: \.self) { item in
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
                                        NavigationLink(destination:  ImageZoomScreen( image_url: item.urlToImage ?? "")) {
                                            AsyncImage(url: URL(string: item.urlToImage ?? "" ))
        
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

                    }
                    .padding([.leading], 0)
                    //.frame(width: reader.size.width)
                    
                    
                }
                
                //.frame(height: reader.size.height + 100)
                
                .background(.white)
                
            }
            .ignoresSafeArea(.all)
            
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            ProfileViewModel().GetProfileData { profileImages in
                if let profile = profileImages {
                    self.profileImages = profile
                    print("change the observer 1 ")
                    
                        self.storageManager.savedImages { response in
                            self.imgData = response
                            
                        }
                    
                    
                }
            }
            
        }
       
        
        
        
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}



struct PullToRefreshSwiftUI: View {
    @Binding private var needRefresh: Bool
    private let coordinateSpaceName: String
    private let onRefresh: () -> Void
    
    init(needRefresh: Binding<Bool>, coordinateSpaceName: String, onRefresh: @escaping () -> Void) {
        self._needRefresh = needRefresh
        self.coordinateSpaceName = coordinateSpaceName
        self.onRefresh = onRefresh
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if needRefresh {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .frame(height: 0)
            }
        }
        .background(GeometryReader {
            Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self,
                                   value: $0.frame(in: .named(coordinateSpaceName)).origin.y)
        })
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { offset in
            guard !needRefresh else { return }
            if abs(offset) > 50 {
                needRefresh = true
                onRefresh()
            }
        }
    }
}


struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }

}