//
//  ImagesViewModel.swift
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 25/02/24.
//

import Foundation
import UIKit


final class ImagesViewModel {
    
    var imagesArray : Observable<[UIImage]?> = Observable(nil)
    var isLoading : Observable<Bool> = Observable(false)
    
    func downloadImagesFromURL(photoArray : [Photo]) {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            let group = DispatchGroup()
            var downloadedImages: [UIImage] = []
            
            for (_, val) in photoArray.enumerated() {
                
               
                let serverId = val.server
                let id = val.id
                let secret = val.secret
                
                let imageString = "\(serverId)/\(id)_\(secret)"
                group.enter()
                NetworkManager.shared().downloadImage(fromURL: imageString) { imageData, error in
                    defer { group.leave() }
            
                    guard let imageData = imageData else { return }
                    
                    if let image = UIImage(data: imageData) {
                        downloadedImages.append(image)
                    }
                    else {
                        downloadedImages.append(UIImage(named: "loading.jpg") ?? UIImage())
                    }
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                self?.isLoading.value = false
                self?.imagesArray.value = downloadedImages
            }
        }
        
    }
    
}
