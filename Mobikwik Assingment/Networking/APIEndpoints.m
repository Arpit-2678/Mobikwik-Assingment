//
//  APIEndpoints.m
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 25/02/24.
//

#import <Foundation/Foundation.h>
#import "APIEndpoints.h"
#import "APIConstants.h"

@implementation APIEndpoints

+ (NSString *)photosSearchEndpointForSearchText:(NSString *)searchText perPageItem:(int)perPageItem currentPage:(int)currentPage {
    NSString *endpoint = [NSString stringWithFormat:@"%@?method=flickr.photos.search&api_key=%@&format=json&nojsoncallback=1&safe_search=1&text=%@&per_page=%d&page=%d", kAPIBaseURL, kAPIKey, searchText , perPageItem, currentPage];
    return endpoint;
}



+ (NSString *)downloadImageFromUrl:(NSString *)endString {
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@.jpg", kImageDownloadBaseURL,endString];
    return  endpoint;
}

@end
