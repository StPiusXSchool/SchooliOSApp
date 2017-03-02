//
//  Contact.h
//  St. Pius X School App
//
//  Created by Chris Bick on 6/3/16.
//  Copyright © 2016 St. Pius X School. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* PRE_K = @"PreK";
static NSString* KINDERGARTEN = @"Kindergarten";
static NSString* FIRST_GRADE = @"1st";
static NSString* SECOND_GRADE = @"2nd";
static NSString* THIRD_GRADE = @"3rd";
static NSString* FOURTH_GRADE = @"4th";
static NSString* FIFTH_GRADE = @"5th";
static NSString* SIXTH_SEVENTH_EIGHTH_GRADE = @"6th/7th/8th";
static NSString* SPECIAL_AREA = @"Special Area";

@interface Contact : NSObject

@property (nonatomic, copy) NSString* grade;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* scheduleFileName;
@end
