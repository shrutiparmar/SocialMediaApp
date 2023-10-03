
import Foundation
import SwiftUI
final class ProfileViewModel : ObservableObject {
    @Published var profileImages : [Articles] = []
    
    func GetProfileData()async{
        
        guard let url = URL(string: "https://saurav.tech/NewsAPI/top-headlines/category/health/in.json") else {
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let profileResponse = try JSONDecoder().decode(ProfileModel.self, from: data)
            DispatchQueue.main.async {
                if let articles = profileResponse.articles {
                    self.profileImages = articles;
                }
            }
            
            
        }catch(let err){
            print(err);
        }
      
        
//        { data, response , error in
//
//            guard let data = data, error == nil else {
//                completion(nil)
//                return
//            }
//
//            let profileResponse = try? JSONDecoder().decode(ProfileModel.self, from: data)
//            if let articles = profileResponse?.articles {
//                DispatchQueue.main.async {
//                    self.profileImages = articles
//                }
//
//                completion(articles)
//            }else {
//                completion(nil)
//            }
        //}.resume()
        
    }
}
