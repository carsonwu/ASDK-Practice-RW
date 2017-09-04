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

#import "AnimalTableController.h"
#import "RainforestCardInfo.h"
//#import "CardNode.h"
#import "CardCell.h"
//#import <AsyncDisplayKit/AsyncDisplayKit.h>

static NSString *kCellReuseIdentifier = @"CellReuseIdentifier";

@interface AnimalTableController ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<RainforestCardInfo *> *animals;
@end

@interface AnimalTableController (DataSource)<UITableViewDataSource>
@end

@interface AnimalTableController (Delegate)<UITableViewDelegate>
@end

@interface AnimalTableController (Helpers)
- (void)retrieveNextPageWithCompletion:(void (^)(NSArray *))block;
- (void)insertNewRowsInTableNode:(NSArray *)newAnimals;
@end

@implementation AnimalTableController

#pragma mark - Lifecycle

- (instancetype)initWithAnimals:(NSArray<RainforestCardInfo *> *)animals {

  _animals = animals.mutableCopy;
  if (!(self = [super init])) { return nil; }
    
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  [self.tableView registerClass:[CardCell class] forCellReuseIdentifier:kCellReuseIdentifier];

  [self wireDelegation];
  [self applyStyle];

  [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  self.tableView.frame = self.view.bounds;
}

#pragma mark - Delegation

- (void)wireDelegation {
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
}

#pragma mark - Appearance

- (void)applyStyle {
  self.view.backgroundColor = [UIColor blackColor];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

@end


@implementation AnimalTableController (DataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.animals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];

  cell.backgroundColor = [UIColor lightGrayColor];
  cell.animalInfo = self.animals[indexPath.row];

  return cell;
}

@end


@implementation AnimalTableController (Delegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return self.view.bounds.size.height;
}

@end

@implementation AnimalTableController (Helpers)

- (void)retrieveNextPageWithCompletion:(void (^)(NSArray *))block {
//  NSArray *moreAnimals = [[NSArray alloc] initWithArray:[self.animals subarrayWithRange:NSMakeRange(0, 5)] copyItems:NO];
//  
//  // Important: this block must run on the main thread
//  dispatch_async(dispatch_get_main_queue(), ^{
//    block(moreAnimals);
//  });
}

- (void)insertNewRowsInTableNode:(NSArray *)newAnimals {
//  NSInteger section = 0;
//  NSMutableArray *indexPaths = [NSMutableArray array];
//  
//  NSUInteger newTotalNumberOfPhotos = self.animals.count + newAnimals.count;
//  for (NSUInteger row = self.animals.count; row < newTotalNumberOfPhotos; row++) {
//    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
//    [indexPaths addObject:path];
//  }
//  
//  [self.animals addObjectsFromArray:newAnimals];
//  [self.tableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

@end
