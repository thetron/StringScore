//
//  NSString+Score.h
//
//  Created by Nicholas Bruning on 5/12/11.
//  Copyright (c) 2011 Involved Pty Ltd. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef NS_OPTIONS(NSUInteger, NSStringScoreOption) {
	NSStringScoreOptionNone                         = 1 << 0,
	NSStringScoreOptionFavorSmallerWords            = 1 << 1,
	NSStringScoreOptionReducedLongStringPenalty     = 1 << 2
};

@interface NSString (Score)

- (CGFloat) scoreAgainst:(NSString *)otherString;
- (CGFloat) scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness;
- (CGFloat) scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness options:(NSStringScoreOption)options;

@end
