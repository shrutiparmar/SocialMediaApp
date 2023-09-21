
import Foundation

class ProfileViewModel {
    func GetProfileData(completion: @escaping ([Articles]?) -> ()){
        
        guard let url = URL(string: "https://saurav.tech/NewsAPI/top-headlines/category/health/in.json") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response , error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let profileResponse = try? JSONDecoder().decode(ProfileModel.self, from: data)
            if let profileResponse = profileResponse {
                print("profile count \(profileResponse.articles?.count)")
                completion(profileResponse.articles)
            }else {
                completion(nil)
            }
        }.resume()
        
    }
}
