//
//  TLDetailViewController.m
//  TongLian
//
//  Created by mac on 13-10-29.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLDetailViewController.h"

@interface TLDetailViewController ()

@end

@implementation TLDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.detail count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLDcell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLDcell"];
    NSDictionary *dic = [self.detail objectAtIndex:indexPath.row];
    NSString *s = [NSString stringWithFormat:@"步骤%d",indexPath.row+1];
    cell.buzhou.text = s;
    [cell.buzhou setTextColor:[UIColor redColor]];
    cell.operater.text = [dic objectForKey:@"person"];
    cell.task.text = [dic objectForKey:@"type"];
    cell.start.text = [dic objectForKey:@"beginTime"];
    cell.end.text = [dic objectForKey:@"endTime"];
    
    if([[dic objectForKey:@"reson"] isKindOfClass:[NSNull class]]){
        cell.remark.text = @"未填写";
    }
    else{
        cell.remark.text =[dic objectForKey:@"reson"];
    }
    [cell.remark setTextColor:[UIColor blueColor]];
    
    cell.remark.lineBreakMode = NSLineBreakByWordWrapping;
    [cell.remark setNumberOfLines:0];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.detail objectAtIndex:indexPath.row];
    NSString *s;
    if([[dic objectForKey:@"reson"] isKindOfClass:[NSNull class]]){
        s = @"未填写";
    }
    else{
        s = [dic objectForKey:@"reson"];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"备注" message:s delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
