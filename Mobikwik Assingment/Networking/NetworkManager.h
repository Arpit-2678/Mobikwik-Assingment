//
//  NetworkManager.h
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 25/02/24.
//

#ifndef NetworkManager_h
#define NetworkManager_h



#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchPhotosForSearchText:(NSString *)searchText perPageItem:(int)perPageItem currentPage:(int)currentPage
                completionHandler:(void (^)(NSData *responseObj, NSError *error))completionHandler;

- (void)downloadImageFromURL:(NSString *)imageUrl completionHandler:(void (^)(NSData *imageData, NSError *error))completionHandler;

@end




#endif /* NetworkManager_h */
