//
//  main.m
//  ByteDanceCampusDemo
//
//  Created by SSR on 2022/7/23.
//

#import <Foundation/Foundation.h>

#import "SchoolClass.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 1. 各种Property
        SchoolClass *sc1 = [[SchoolClass alloc] initWithDic:@{@"teacher" : @"SSR", @"source" : @"Rising & SSR"}];
        
        NSLog(@"1. %@", sc1);
        
        NSString *source = @"YOU WANT To CHANGE";
        sc1.sourse = source;
        source = @"ByteDance";
        
        NSLog(@"2. %@", sc1);
        
        NSString *teacher = @"Rising";
        sc1.teacher = teacher;
        teacher = @"ByteDance & SSR";
        
        NSLog(@"3. %@", sc1);
        
        SchoolClass *sc2 = SchoolClass.shareClass;
        
        // 2. block
        __block SchoolClass *sc_block;
        [sc2 reloadData:^(SchoolClass * _Nonnull schoolClass) {
            sc_block = schoolClass;
        }];
        
        
        
    }
    return 0;
}
