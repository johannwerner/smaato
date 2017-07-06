//
//  UserModel.h
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *country;

- (id)initWithDictionary:(NSDictionary *)attributes;

@end
