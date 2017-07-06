//
//  DataModel.h
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "DataModel.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, DataType)
{
    DataTypeNone,
    DataTypeText,
    DataTypeImage
};

@interface ListDataModel : NSObject

@property (nonatomic, assign) NSInteger createdSecondsAgo;
@property (nonatomic, strong) NSString *createdString;
@property (nonatomic, strong) DataModel *dataModel;
@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic, assign) DataType dataTypeEnum;
@property (nonatomic, assign) bool favourite;
@property (atomic, assign) UIImage *image;

- (id)initWithDictionary:(NSDictionary *)attributes;

@end
