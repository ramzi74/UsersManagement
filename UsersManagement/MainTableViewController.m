//
//  MainTableViewController.m
//  UsersManagement
//
//  Created by Ramzi on 1/22/18.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController
{
  NSMutableArray *usersList;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  usersList = [self getUsersList];
  NSLog(@"Got Users..count = %lu", (unsigned long)usersList.count);
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [usersList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
  
  NSString *name = [(NSDictionary *)[usersList objectAtIndex:indexPath.row] valueForKey:@"name"];
  NSDictionary *dictAddress = [(NSDictionary *)[usersList objectAtIndex:indexPath.row] valueForKey:@"address"];
  cell.textLabel.text = name;
  //NOTE: the spec calls out for FullAddress listing in the Table View; however this requires additional time to design CustomerTableViewCell for this task.
  cell.detailTextLabel.text = [dictAddress valueForKey:@"street"];

  return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  // Return NO if you do not want the specified item to be editable.
  return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
   NSIndexPath *idx = self.tableView.indexPathForSelectedRow;
   NSLog(@"Segue!!! .. SelectedCellIndex=%ld , SegueInformation:%@", idx.row, segue.description);
   

 }

#pragma mark - Read JSON
-(NSMutableArray *) getUsersList{
  NSError *error;
  //NSString *url_string = [NSString stringWithFormat: @"https://mobile-code-test.ifactornotifi.com/json"];
  NSString *url_string = [NSString stringWithFormat: @"https://mobile-code-test.ifactornotifi.com/json/users"];
  NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
  NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//  NSLog(@"json: %@", json);
  return json;
}

-(NSMutableArray *) getUserPosts{
  //lookup the post from https://mobile-code-test.ifactornotifi.com/json/posts?userId={userId} ..
  // based on the user ID to display in show detail VC (another TableView).
  //this function gets called from prepareForSegue with the selected userID as paramter
  // looks up the user's posts and returns an array of posts to send to ShowDetail VC.
  NSMutableArray *listOfPosts = [[NSMutableArray alloc] init];
  return listOfPosts;
}

@end
