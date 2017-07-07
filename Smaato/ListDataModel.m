//
//  DataModel.m
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "ListDataModel.h"
#import "TimeHelper.h"

@implementation ListDataModel

- (id)initWithDictionary:(NSDictionary *)attributes {
    
    self = [super init];
    
    if (self) {
        
        if (attributes[@"created"] && [attributes[@"created"] isKindOfClass:[NSNumber class]]) {
            self.createdSecondsAgo = [attributes[@"created"] integerValue];
        }
        if (attributes[@"type"] && [attributes[@"type"] isKindOfClass:[NSString class]]) {
            NSString *type = attributes[@"type"];
            type = [type lowercaseString];
            if ([type isEqualToString:@"text"]) {
                self.dataTypeEnum = DataTypeText;
                
            } else  if ([type isEqualToString:@"img"]) {
                self.dataTypeEnum = DataTypeImage;
            }
        }
        
        if (attributes[@"data"] && [attributes[@"data"] isKindOfClass:[NSDictionary class]]) {
            self.dataModel = [[DataModel alloc] initWithDictionary:attributes[@"data"]];
        }
        
        if (attributes[@"user"] && [attributes[@"user"] isKindOfClass:[NSDictionary class]]) {
            self.userModel = [[UserModel alloc] initWithDictionary:attributes[@"user"]];
        }
        
    }
    return self;
}

- (void)setCreatedSecondsAgo:(NSInteger)createdSecondsAgo {
    _createdSecondsAgo = createdSecondsAgo;
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-ABS(createdSecondsAgo)];
    
    self.createdString = [TimeHelper relativeDateStringForDate:date];
}

@end
