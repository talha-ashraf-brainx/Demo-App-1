//
//  GetGithubPublicRepoAPI.swift
//  Demo App 1
//
//  Created by BrainX Technologies on 05/05/2023.
//

import Alamofire
import Foundation

class GetGithubPublicRepoAPI {
    private var githubAccessToken: String = ""
    
    func getRepositoriesAPI(completion: @escaping ([Repo]) -> Void) -> [Repo]{
        
        var repoList: [Repo] = []
        
        let headers: HTTPHeaders = [
            "Accept": "application/vnd.github+json",
            "Authorization": "Bearer \(githubAccessToken)",
            "X-GitHub-Api-Version": "2022-11-28"
        ]
        
        AF.request("https://api.github.com/repositories", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                print(data)
                if let repos = data as? [[String:Any]] {
                    for repo in repos {
                        if let owner = repo["owner"] as? [String: Any] {
                            repoList.append(Repo(name: repo["name"]! as! String, avatar_url: owner["avatar_url"]! as! String))
                        }
                    }
                    completion(repoList)
                } else {
                    print("Invalid JSON data")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return repoList
    }
}
