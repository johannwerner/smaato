//
//  DataModel.h
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (strong, nonatomic) NSString *dataText;
@property (strong, nonatomic) NSString *dataUrl;

- (id)initWithDictionary:(NSDictionary *)attributes;

@end
