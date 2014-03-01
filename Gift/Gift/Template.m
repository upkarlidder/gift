//
//  Template.m
//  Gift
//
//  Created by Upkar Lidder on 2014-02-17.
//
//

#import "Template.h"
#import <Parse/PFObject+Subclass.h>

@implementation Template

@dynamic title;
@dynamic themeCover;
@dynamic themeLeft;
@dynamic themeRight;


+ (NSString *)parseClassName
{
    return @"Template";
}

@end