//
//  PhotosViewModel.swift
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 25/02/24.
//

import Foundation
import UIKit

final class PhotosViewModel {
    
    
    var photosArray : Observable<[Photo]?> = Observable(nil)
    
    
    
    func fetchPhotos(pageNo : Int, _ noOfItemPerPage : Int, searchText : String) {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            NetworkManager.shared().fetchPhotos(forSearchText: searchText, perPageItem: Int32(noOfItemPerPage), currentPage: Int32(pageNo), completionHandler: { response, error in
                guard let response = response else { return }
                let decoder = JSONDecoder()
                do {
                    let photosModel = try decoder.decode(PhotosModel.self, from: response)
                    DispatchQueue.main.async {
                        self.photosArray.value = photosModel.photos.photo
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            })
        }
    }
}
