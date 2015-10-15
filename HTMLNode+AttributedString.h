//
//  HTMLNode+AttributedString.h
//  HttmlParserSample
//
//  Created by Pham Hoang Le on 14/10/15.
//  Copyright © 2015 Pham Hoang Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMLNode.h"

@interface HTMLNode (AttributedString)

- (NSMutableAttributedString *) attributedString:(NSDictionary *(^)(HTMLNode *))attributesForNode;

@end
