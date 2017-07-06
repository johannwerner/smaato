//
//  DataModel.m
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (id)initWithDictionary:(NSDictionary *)attributes {
    
    self = [super init];
    
    if (self) {
        if (attributes[@"text"] && [attributes[@"text"] isKindOfClass:[NSString class]] ) {
            self.dataText = attributes[@"text"];
        }
        if (attributes[@"url"] && [attributes[@"url"] isKindOfClass:[NSString class]] ) {
            self.dataUrl = attributes[@"url"];
        }
    }
    return self;
}


@end
