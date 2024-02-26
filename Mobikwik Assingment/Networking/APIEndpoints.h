//
//  APIEndpoints.h
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 25/02/24.
//

#ifndef APIEndpoints_h
#define APIEndpoints_h



@interface APIEndpoints : NSObject

+ (NSString *)photosSearchEndpointForSearchText:(NSString *)searchText perPageItem:(int)perPageItem currentPage:(int)currentPage;
+ (NSString *)downloadImageFromUrl:(NSString *)endString;

@end


#endif /* APIEndpoints_h */
