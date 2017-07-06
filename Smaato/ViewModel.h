//
//  ViewModel.h
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ListDataModel;

@interface ViewModel : NSObject

- (void)fetchListCompletion:(void (^)(NSMutableArray *dataModel,
                                      NSError *error))completion;

@end
