//
//  NetworkManager.m
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 25/02/24.
//

#import "NetworkManager.h"
#import "APIConstants.h"
#import "APIEndpoints.h"

#import <Foundation/Foundation.h>

@implementation NetworkManager

+ (instancetype)sharedManager {
    static NetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}



- (void)fetchPhotosForSearchText:(NSString *)searchText perPageItem:(int)perPageItem currentPage:(int)currentPage
               completionHandler:(void (^)(NSData *responseObj, NSError *error))completionHandler {
    
    NSString *urlString = [APIEndpoints photosSearchEndpointForSearchText:searchText perPageItem:perPageItem currentPage:currentPage];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                completionHandler(nil, error);
                return;
            }
            
            completionHandler(data, nil);
        }];
        
        [task resume];
}



- (void)downloadImageFromURL:(NSString *)imageUrl completionHandler:(void (^)(NSData *imageData, NSError *error))completionHandler {
    
    NSString *urlString = [APIEndpoints downloadImageFromUrl:imageUrl];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        completionHandler(data, nil);
    }];
    
    [task resume];
}


@end
