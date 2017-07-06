//
//  API.m
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "API.h"

#import "ListDataModel.h"
#import "Constants.h"


@implementation API

+ (void)fetchListWithDataCompletion:(void (^)(NSMutableArray *responseArray,
                                              NSError *error))completion {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *endpoint = [NSString
                          stringWithFormat:@"%@%@", APIBaseURL, @"/questions"];
    [request setURL:[NSURL URLWithString:endpoint]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration
                                            defaultSessionConfiguration]];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response,
                                    NSError *error) {
                    if (data != nil) {
                        NSArray *responseArray =
                        [NSJSONSerialization JSONObjectWithData:data
                                                        options:kNilOptions
                                                          error:&error];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSMutableArray *mutableArray = [@[] mutableCopy];
                            for (NSDictionary *dictionary in responseArray) {
                                ListDataModel *dataModel = [[ListDataModel alloc]
                                                            initWithDictionary:dictionary];
                                [mutableArray addObject:dataModel];
                            }
                            
                            completion(mutableArray, error);
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(nil, error);
                        });
                    }
                }] resume];
}

+ (void)fetchImageFromUrl:(NSString *)urlString
                onDidLoad:(void (^)(UIImage *image))onImageDidLoad {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^(void) {
                       NSURL *imageURL = [NSURL URLWithString:urlString];
                       NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                       UIImage *image = [UIImage imageWithData:imageData];
                       dispatch_async(dispatch_get_main_queue(), ^(void) {
                           onImageDidLoad(image);
                       });
                   });
}

@end
