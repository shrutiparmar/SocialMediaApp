

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI

var count = 0
var storedata : Date?
var storyImages : [Date]? = []
class StorageManager: ObservableObject {
    @Published  var storage = Storage.storage()
    @AppStorage("date") var date: Date?
   
    @AppStorage("count") var countStorage: Int = 0
    @AppStorage("SavedImages") var savedImages1 : Data?
    var imgArr : [Data]? = []
    func upload(image: UIImage, index: Int, title: String ,completion: @escaping (Bool) -> ()) {
        countStorage += 1
        print("count \(countStorage)")
        let storageRef = storage.reference().child("images/image\(countStorage).jpg")
        let resizedImage = image.aspectFittedToHeight(200)
        let data = resizedImage.jpegData(compressionQuality: 0.2)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                    completion(false)
                }
                
                if let metadata = metadata {
                  
                    self.date = Date()
                    storedata = self.date
                   
                    storyImages?.append(metadata.timeCreated ?? Date())
                    print("storyImages \(storyImages)")
                    UserDefaults.standard.set(storyImages, forKey: "storyImages")
                    print("index counttt neww -- \(storyImages?.count)")
                    print("today date \(self.date) -- storedata \(storedata)")
                    print("Metadata: ", metadata)
                    print("time created : \(metadata.timeCreated)")
                    completion(true)
                }
            }
        }
    }
    
    func savedImages(completion: @escaping(Data) -> ()) {
        imgArr?.removeAll()
        
        let storageRef = storage.reference().child("images")
        storageRef.listAll { (result, error) in
            if let error = error {
                print("Item Error while listing all files: ", error)
            }
            if result.items.count != 0 {
                
                for item in result.items {
                    print("Item in images folder: ", item)
                    let Ref = Storage.storage().reference(forURL: "\(item)")
                    
                    Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if error != nil {
                            print("Error: Image could not download!")
                        } else {
                            self.savedImages1 = data
                            self.imgArr?.append(data ?? Data())
                            print("Item in images folder new :  ", self.imgArr?.count)
                            completion(data ?? Data())
                        }
                        
                    }
                }
               
                
            }
            
        }
    }
    
    func deleteItem(index : Int) {
        
        let storageRef = storage.reference().child("images")
        storageRef.listAll { (result, error) in
            if let error = error {
                print("Item Error while listing all files: ", error)
            }
            
            if result.items.count != 0 {
               
                    
                    var Ref = Storage.storage().reference(forURL: "\(result.items[index])")
                    Ref.delete { error in
                        if let error = error {
                            print("Error deleting item", error)
                        }
                    }
                
            }
            
        }
        
        
    }
    
}


