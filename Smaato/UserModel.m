//
//  UserModel.m
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (id)initWithDictionary:(NSDictionary *)attributes {
    
    self = [super init];
    
    if (self) {
        self.name = attributes[@"name"];
        self.country = attributes[@"country"];
        
    }
    return self;
}

@end
