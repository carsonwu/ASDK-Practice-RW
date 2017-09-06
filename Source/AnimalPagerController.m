/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "AnimalPagerController.h"
#import "AnimalTableController.h"
#import "RainforestCardInfo.h"
#import "CardNode.h"

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface AnimalPagerController ()
@property (strong, nonatomic) ASPagerNode *pagerNode;
@property (strong, nonatomic) NSArray<NSArray<RainforestCardInfo *> *> *animals;
@end

@interface AnimalPagerController (ASPagerDataSource)<ASPagerDataSource>
@end


@implementation AnimalPagerController

#pragma mark - Lifecycle

- (instancetype)init {
  if (!(self = [super init])) { return nil; }

  _animals = @[[RainforestCardInfo birdCards],
               [RainforestCardInfo mammalCards],
               [RainforestCardInfo reptileCards]];

  // Create and configure ASPagerNode instance here:

    self.pagerNode = [[ASPagerNode alloc] init];
    self.pagerNode.dataSource = self;
  _pagerNode.backgroundColor = [UIColor blackColor];

  return self;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  self.pagerNode.frame = self.view.bounds;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.view addSubnode:self.pagerNode];
}

#pragma mark - View Controller Appearance

- (BOOL)prefersStatusBarHidden {
  return YES;
}

@end


@implementation AnimalPagerController (ASPagerDataSource)

- (NSInteger)numberOfPagesInPagerNode:(ASPagerNode *)pagerNode {
  return self.animals.count;
}

- (ASCellNodeBlock)pagerNode:(ASPagerNode *)pagerNode nodeBlockAtIndex:(NSInteger)index{
    NSArray *animals = self.animals[index];
    CGSize pagerNodeSize = self.pagerNode.bounds.size;
    
    // this part can be executed on a background thread - it is important to make sure it is thread safe!
    ASCellNode *(^cellNodeBlock)() = ^ASCellNode *() {
        ASCellNode *cellNode = [[ASCellNode alloc] initWithViewControllerBlock:^UIViewController * _Nonnull{
            return [[AnimalTableController alloc] initWithAnimals:animals];
        } didLoadBlock:nil];
        cellNode.style.preferredSize = pagerNodeSize;
        cellNode.debugName = [NSString stringWithFormat:@"Load cell %zd", index];
        NSLog(@"%@", cellNode.debugName);
        return cellNode;
    };
    
    return cellNodeBlock;
}

@end
