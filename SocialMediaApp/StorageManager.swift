

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI

 var storedata : Date?
class StorageManager: ObservableObject {
   @Published  var storage = Storage.storage()
    @AppStorage("date") var date: Date?
   
    func upload(image: UIImage, completion: @escaping (Bool) -> ()) {
        let storageRef = storage.reference().child("images/image.jpg")
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
                            print("today date \(self.date) -- storedata \(storedata)")
                                print("Metadata: ", metadata)
                            
                         
                            completion(true)
                        }
                }
        }
    }
    
    func savedImages(completion: @escaping(Data) -> ()) {
       let storageRef = storage.reference().child("images")
        storageRef.listAll { (result, error) in
                if let error = error {
                        print("Item Error while listing all files: ", error)
                }
  
            if result?.items.count != 0 {
                for item in result!.items {
                    print("Item in images folder: ", item)
                    let Ref = Storage.storage().reference(forURL: "\(item)")
                    Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if error != nil {
                            print("Error: Image could not download!")
                        } else {
                           
                            completion(data!)
                            
                        }
                    }
                }
            }
            
        }
    }
    
    func deleteItem() {
        
        let storageRef = storage.reference().child("images")
         storageRef.listAll { (result, error) in
                 if let error = error {
                         print("Item Error while listing all files: ", error)
                 }
   
             if result?.items.count != 0 {
                 for item in result!.items {
                     print("Item in images folder 2 : ", item)
                     var Ref = Storage.storage().reference(forURL: "\(item)")
                     Ref.delete { error in
                         if let error = error {
                                 print("Error deleting item", error)
                         }
                     }
                 }
             }
             
         }
        
          
    }
    
}


extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

extension Date: RawRepresentable {
    public var rawValue: String {
        self.timeIntervalSinceReferenceDate.description
    }
    
    public init?(rawValue: String) {
        self = Date(timeIntervalSinceReferenceDate: Double(rawValue) ?? 0.0)
    }
}
