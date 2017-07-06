//
//  API.h
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DataModel;

@interface API : NSObject

+ (void)fetchListWithDataCompletion:(void (^)(NSMutableArray *responseArray,
                                              NSError *error))completion;

+ (void)fetchImageFromUrl:(NSString *)urlString
                onDidLoad:(void (^)(UIImage *image))onImageDidLoad;

@end
