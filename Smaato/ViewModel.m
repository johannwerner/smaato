//
//  ViewModel.m
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "ViewModel.h"
#import "API.h"
#import "ListDataModel.h"

@implementation ViewModel

- (void)fetchListCompletion:(void (^)(NSMutableArray *responseArray,
                                      NSError *error))completion {
    
    [API fetchListWithDataCompletion:^(NSMutableArray *responseArray, NSError *error) {
        for (NSInteger i = 0; i < responseArray.count;i++) {
            ListDataModel *listDataModel = responseArray[i];
            if(listDataModel.dataTypeEnum == DataTypeNone) {
                [responseArray removeObject:listDataModel];
            }
        }
        completion(responseArray, error);
    }];
    
   
    
}

@end
