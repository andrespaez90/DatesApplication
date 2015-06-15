//
//  ViewController.m
//  ActividadFinal
//
//  Created by INNOVATING SOFTWARE SAS on 13/06/15.
//  Copyright (c) 2015 INNOVATING SOFTWARE SAS. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController (){

    NSMutableArray* titleArray;
    NSMutableArray* subTitleArray;
    NSString* contentFile;
    NSString* filepath;
}

@end

@implementation ViewController

@synthesize nombreActividad;
@synthesize fechaActividad;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myCollection.delegate = self;
    self.myCollection.dataSource = self;
    
    titleArray = [ [NSMutableArray alloc] init ];
    subTitleArray = [[NSMutableArray alloc] init];
   
    NSArray * Lines;
    filepath = [[NSBundle mainBundle] pathForResource:@"recordatorios" ofType:@"txt"];
    
    if(filepath){
        contentFile = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:NULL];
    }else{
        contentFile = @"Error:No se encontro Archivo";
    }
    
    Lines = [contentFile componentsSeparatedByString:@"\n"];
    for(NSString* data in Lines ){
        NSArray* info = [data componentsSeparatedByString:@":"];
        if([info count] != 2){
            continue;
        }
        [titleArray addObject:info[0]];
        [subTitleArray addObject:info[1]];
    }
}


-(IBAction)addAddRecordatorio{
    NSString* nombre = self.nombreActividad.text;
    NSDate *fecha = [self.fechaActividad date];
  
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *stringDate = [dateFormatter stringFromDate:fecha];
    
        
        NSString* str = [NSString stringWithFormat: @"\n%@:%@", nombre, stringDate];
        contentFile = [contentFile stringByAppendingString:str];
        
        
        
        NSError *error;
        BOOL succeed = [contentFile writeToFile:filepath
                                  atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (!succeed){
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No se Pudo Agregar el recordatorio" delegate: self cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
        }
        else{
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Información" message:@"Recordatorio agregado correctamente" delegate: self cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [titleArray addObject:nombre];
            [subTitleArray addObject:stringDate];
            [alert show];
            [self.myCollection reloadData];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UITableView *)collectionView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ titleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.Title.text = [titleArray objectAtIndex: indexPath.row];
    cell.subTitle.text = [NSString stringWithFormat:@"%@%@", @"Fecha: ", [subTitleArray objectAtIndex:indexPath.row]];
    
    return cell;
}



@end
