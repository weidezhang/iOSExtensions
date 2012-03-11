//
//  NSStack.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>


@interface NSStack : NSObject
@property (nonatomic, readonly) NSMutableArray* objects;

- (id) init;
- (void) dealloc;

- (void) push:(id)object;
- (void) popAll;
- (id) pop;
- (id) top;
- (NSInteger) count;

- (NSArray*) toArray;

@end
