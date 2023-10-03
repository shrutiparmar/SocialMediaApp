//
//  HomeScreen.swift
//  SocialMediaApp
//
//  Created by Shruri on 13/09/23.
//

import SwiftUI
import PhotosUI

struct HomeScreen: View {
   
    @ObservedObject  var storageManager = StorageManager()
    @State var imgData : Data?
    @AppStorage("date") var date: Date?
    @StateObject var viewModel = ProfileViewModel()
    @State var imgArrayData : [Data] = []
    var rowGrid = [GridItem(.fixed(90), spacing: 10)]
    let columns = [
        GridItem(.fixed(150), spacing: 10)
    ]
  
    
    var body: some View {
        GeometryReader { reader in
            NavigationView {
                ScrollView {
                    homeScreenView(reader: reader)
                }
                .refreshable {
                    imgArrayData.removeAll()
                    DispatchQueue.main.async {
                        deleteStory()
                        self.storageManager.savedImages { response in
                            
                            imgArrayData.append(response)
                            
                            self.imgData = response
                        }
                    }
                    Task{
                        await viewModel.GetProfileData()
                    }
                        print("write your pull to refresh logic here")
                   
                }
                .background(Color.whiteColor)
                .padding(.top, 1)
              
            }
            .ignoresSafeArea(.all)
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            DispatchQueue.main.async {
               
                deleteStory()
                self.storageManager.savedImages { response in
                    self.imgData = response
                    imgArrayData.append(response)
                    print("image count \(imgArrayData.count)")
                }
               
            }
            Task{
                await viewModel.GetProfileData()
            }
       
//            viewModel.GetProfileData { profileImages in
//                if let profile = profileImages {
//                    self.viewModel.profileImages = profile;
//                    self.refresh = false
            //                    self.storageManager.savedImages { response in
            //                        self.imgData = response
            //                    }
//                }
//            }
        }
    }
    
    
    func homeScreenView(reader: GeometryProxy) -> some View {
        VStack(spacing: 15) {
            HStack(alignment: .center) {
                Text("Venus")
                    .foregroundColor(Color.orangeColor)
                    .font(.fontType(size: 28))
                    .bold()
                
                Spacer()
                Image(uiImage: UIImage(named: "notification")!)
                
            }
            .padding(.horizontal, 30)
            ScrollView(.horizontal) {
//                PullToRefreshSwiftUI(needRefresh: $refresh,
//                                     coordinateSpaceName: "pullToRefresh") {
//                    DispatchQueue.main.asyncAfter(deadline: .now()) {
//
//
//                           // refresh = false
//                        deleteStory()
//
////                            self.storageManager.savedImages { response in
////                                self.imgData = response
////
////                            }
//
//                    }
//                }
                LazyHGrid(rows: rowGrid ) {
                    // Display the item
                    ForEach((0...imgArrayData.count), id: \.self) { index in
                    
                        StoryDetailView(imgData: index != 0 ? imgArrayData[index - 1] : self.imgData, reader: reader, index: index)
                    }
                }
                .padding([.leading], 30)
            }
            
            .scrollIndicators(.hidden)
            
            LazyVGrid(columns: columns , spacing: 10) {
                ForEach(self.viewModel.profileImages, id: \.self) { item in
                    PostDetailView(imageUrl: item.urlToImage, reader: reader)
                }
            }
            
        }
    }
    
    
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
    
    func deleteStory(){
//        let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: date ?? Date(), to: Date())
//        let hours = diffComponents.hour
//
//        if hours ?? 0 > 24 {
//           // storageManager.deleteItem()
//        }
    }
    
}



struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen( imgArrayData: [Data()])
    }
}




