//
//  UIStoryboard+Manager.m
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "UIStoryboard+Manager.h"

@implementation UIStoryboard (Manager)

+ (UIStoryboard *)mainStoryboard {
    
    return [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
}

@end
