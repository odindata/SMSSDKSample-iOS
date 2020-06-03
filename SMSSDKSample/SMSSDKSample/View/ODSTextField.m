//
//  ODSTextField.m
//  SMSSDKSample
//
//  Created by nathan on 2020/5/22.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODSTextField.h"

@implementation ODSTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 16;
    return iconRect;
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += 9;
    return textRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect textRect = [super editingRectForBounds:bounds];
    textRect.origin.x += 9;
    return textRect;
}
@end
