//
//  ProfileModel.swift
//  SocialMediaApp
//
//  Created by Shruri on 13/09/23.
//

import Foundation
struct ProfileModel : Decodable {
    let status : String?
    let totalResults : Int?
    let articles : [Articles]?

}

struct Articles : Decodable, Identifiable, Hashable {
    let id : Int?
//    let author : String?
   // let title : String?
//    let description : String?
//    let url : String?
    let urlToImage : String?
//    let publishedAt : String?
//    let content : String?
}