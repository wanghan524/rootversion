//
//  PetInfoTipsTableViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 1/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PetInfoTipsTableViewController.h"
#import "PetTipsCell.h"

@interface PetInfoTipsTableViewController ()

@end

@implementation PetInfoTipsTableViewController
@synthesize generalTips, dogTips, catTips, dataSource, currentTitle;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self.view setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    currentTitle = @"General Tips";
    
    generalTips = [[NSMutableArray alloc] initWithObjects:
                   [NSArray arrayWithObjects:@"General Health", @"Like humans, pets can occasionally become unwell or injured. If you see your cat or dog behaving unusually or notice any changes to their eating or drinking habits, it may be worth a visit to the vet.", nil], 
                   [NSArray arrayWithObjects:@"General dry food convenience", @"Commercially prepared dry pet foods are generally easy to store, stay fresh for longer and help keep feeding areas clean and hygienic.", nil], 
                   [NSArray arrayWithObjects:@"General dry food convenience", @"Cats are especially sensitive to temperature and most don’t like food straight from the fridge, so dry cat food is the perfect choice as it is always the right temperature.", nil], 
                   [NSArray arrayWithObjects:@"Feeding to pet lifestyle and size", @"Some pets have specific lifestyles or nutritional needs and a standard pet food formula isn’t enough. Different sized dogs, overweight pets, highly active dogs, cats with urinary tract concerns and pets with sensitive systems need special diets. Your Vet can help you find the best food for your special pet.", nil], 
                   [NSArray arrayWithObjects:@"Complete and balanced dog", @"Dogs are omnivores, meaning they can eat both animal and vegetable material. Feeding just meat and bones or table scraps will not provide all the nutrients your dog needs. Most vets agree that, a commercially produced, complete and balanced dry dog food is best for your dog.", nil],
                   [NSArray arrayWithObjects:@"Complete and balanced cat", @"Cats are carnivores meaning they must eat animal sources of protein and fat to survive. But feeding just fresh meat or fish may not provide all the other nutrients your cat needs to help it reach its full potential. Most vets agree that, a commercially produced, complete and balanced dry cat food is best for your cat.", nil], 
                   [NSArray arrayWithObjects:@"Appropriate treating ", @"We all like to give our pets a treat but it is important to remember that just like us, too many snacks can ruin their waistline. Give 1- 4 treats per week (less if they are overweight) and look for low fat options. Always follow the on-pack feeding guidelines.", nil], 
                   [NSArray arrayWithObjects:@"Pet obesity", @"Like us pets can put on weight. You should be able to feel your pets’ ribs but not see them and to see a waistline or “tucked up” abdomen when viewed from above or the side. Monitor their body condition regularly and adjust the amount of food you provide if necessary.", nil], 
                   [NSArray arrayWithObjects:@"Allergies", @"Cats & Dogs, like humans, can suffer from a wide range of allergies. The most common allergy is from flea bites. Food is not a common allergen but the right food may help make life more comfortable for your pet. Talk to your Vet about a diet to help with your pet’s sensitivities.", nil], 
                   [NSArray arrayWithObjects:@"Life stages", @"The nutritional needs of our pets change over their lifetime. Puppies and kittens need a special diet to help them grow and develop properly. Senior pets are different again. Choosing a food specially formulated for the life stage of your pet, can help support your pet’s well-being, health and vitality.", nil], 
                   [NSArray arrayWithObjects:@"Cats need cat food and dogs need dog food", @"Rover probably loves eating the cat’s food and Kitty may tease Rover by eating from his bowl - but be careful. Cat food is typically higher in calories than dog food so watch Rover’s waistline if he eats it regularly and Kitty needs to eat cat food as it contains some essential nutrients not found in dog food. ", nil], 
                   [NSArray arrayWithObjects:@"Why premium and super premium food is better", @"Premium quality foods may seem more expensive but the high quality nutrition they provide, often means you need to feed less and may mean a healthier pet with less vet visits.", nil], 
                   [NSArray arrayWithObjects:@"Fleas/Worming", @"Flea eggs can lay dormant in your house for several months and the life cycles of fleas and worms are linked. Treating your pet for fleas and worms all year round will avoid infestations over summer.", nil], 
                   [NSArray arrayWithObjects:@"Vaccinations", @"Vaccinations are the only way to protect your pet against certain serious diseases. Regular vaccinations and health checks with your Veterinarian will help ensure the continued good health of your pet. ", nil], 
                   [NSArray arrayWithObjects:@"Dental Care", @"To help keep your pet’s mouth and teeth healthy, brush your pet’s teeth with a pet toothpaste and toothbrush. Feed a dry diet and take your pet for a dental clean at your Veterinary Clinic.", nil],  
                   [NSArray arrayWithObjects:@"Exercising your dog", @"Exercise is important for your dog’s body and mind, and helps keep you fit too! Try going somewhere different for a walk, or play hide n seek. A well exercised dog is a well behaved dog.", nil],
                   [NSArray arrayWithObjects:@"Fresh Water", @"Water is an essential nutrient for your dog. A 10% loss of your dog’s body water can cause serious illness. Always provide fresh cool water and be aware that your dog may drink more during the summer heat.", nil],
                   [NSArray arrayWithObjects:@"Toilet Training Puppies", @"The key to toilet training puppies is consistency. Remember to take them outside frequently to avoid mistakes inside. Use a toileting command, and praise and treat them when they get it right.", nil],
                   [NSArray arrayWithObjects:@"Introducing Puppies to food", @"Feed puppies small meals two to three times daily. Stick to the same brand of complete and balanced food to avoid upsetting their tummies. Do not feed cows milk as many puppies are lactose intolerant.", nil],
                   [NSArray arrayWithObjects:@"Playing with Puppies", @"Playing is an important part of your puppy’s development. Choose a variety of durable toys that will survive puppy teeth, and put away the toys when you are finished so that your puppy won’t get bored with them.", nil], nil];

    catTips = [[NSMutableArray alloc] initWithObjects:
               [NSArray arrayWithObjects:@"Attack Cats", @"Cats that regularly attack their owners can do so for a variety of reasons. Establishing the cause of your cat’s aggression is vital. In some cases providing your cat with more opportunities to play with toys and carefully managing the play sessions can help.", nil],
               [NSArray arrayWithObjects:@"Night Play", @"If your cat is disturbing you with their play behaviour at night, remember cats are nocturnal. Try shifting their active phase by playing with them earlier in the evening this might make bedtime quieter.", nil],
               [NSArray arrayWithObjects:@"Boredom", @"Cats can get bored just like dogs! Try providing your cat with an activity centre which can include a place to scratch, interesting textures to explore and exciting smells like catnip.", nil],
               [NSArray arrayWithObjects:@"Jumping on Benches", @"Cats love food and being up high, so they often jump on kitchen benches. Try putting double sided tape or tinfoil on the bench to deter them, and provide your cat with other high spaces like a shelf.", nil],
               [NSArray arrayWithObjects:@"Kittens – introducing them to food", @"Introduce solid food to kittens from four weeks old three times a day.  If using biscuits, mix one part kitten biscuits with two parts water, gradually decreasing the water until they are eating only dry biscuits.  Don’t leave wet food out and ensure clean water is available at all times.", nil],
               [NSArray arrayWithObjects:@"Kittens – introducing them to toys", @"The best kitten toys are free and found at home saving a small fortune - toilet roll cylinders, empty cardboard boxes, ping pong balls, upturned cane bread basket over the kitten, or a feather boa on a stick.  You can also find a whole range of toys from pet stores.", nil],
               [NSArray arrayWithObjects:@"Cats Are Natural Grazers", @"Cats tend to graze on their food so offer dry food so they can snack throughout the day. It is important however to watch your cats weight and adjust food amounts accordingly.", nil],
               [NSArray arrayWithObjects:@"Transitioning your pets to dry food or a new diet", @"When moving your cat from wet to dry food, do so gradually by introducing the new food over 5 -7 days to avoid stomach upsets caused by sudden diet change.  Try wet food at the bottom of the bowl and dry food on top so they munch through the biscuits to get to the wet food.", nil],  
               [NSArray arrayWithObjects:@"Fun things to do with your cat", @"Play fetch with ping pong balls.  Some cats will fetch it, some will pounce on it and “rabbit kick” with their back legs.  Play hide and seek or suspend a half toilet roll cylinder blowing in the breeze.", nil],  
               [NSArray arrayWithObjects:@"Dealing with fussy cats", @"Choose a good quality food and don’t offer too much variety – making them fussy.  Provide clean water, serve food in clean bowls at room temperature and give your cat privacy when it eats.  Most cats will eat when they realise nothing else is coming and their tummy rumbles.", nil],  
               [NSArray arrayWithObjects:@"Cat Flu/Snuffles", @"Even after being vaccinated, cats can still get the snuffles. Vaccination helps to reduce the severity of the symptoms however. If your cat is sneezing, has a runny nose or discharge from the eyes it can be treatable with antibiotics from your Vet.", nil],    
               [NSArray arrayWithObjects:@"Pet grooming Cats and Dogs", @"Groom your pet once a week to prevent tangles, and decrease the incidence of fur balls in your cat’s throat.  Grooming gives you loving time with your pet and a chance to check their skin and coat.", nil],
               [NSArray arrayWithObjects:@"Travelling with pets", @"Ensure your pet is in a secure carry cage stowed safely in the car away from petrol fumes.  Cover the cage to help settle your pet and keep the sun off them.  Do not leave your pet unattended in the car!", nil],
               [NSArray arrayWithObjects:@"Using flat bowls to feed cats", @"Cats prefer a flat bowl because they don’t like the feeling of their whiskers being tickled.  Cats’ whiskers are like antennas telling them how close something is. Offer your cat a flat bowl and see the difference.  They will enjoy their food so much more.", nil],
               [NSArray arrayWithObjects:@"Cat fresh water", @"Provide your cat with a constant supply of clean fresh water.  Cats have trouble seeing still water, so water fountains with a moving flow of water are a great idea as they can see the ripples.", nil],
               [NSArray arrayWithObjects:@"Litter Tray", @"Keep your cat’s litter tray clean and make sure your cat knows where it is. If your cat is toileting elsewhere place another litter tray in that area. Remember that cats prefer privacy. An array of litters and litter trays liners available, experiment with litter types as your cat may have a preference.", nil],
               nil];
    
    dogTips = [[NSMutableArray alloc] initWithObjects:
               [NSArray arrayWithObjects:@"Socialising Puppies", @"Socialising your puppy is vital, the more new positive experiences your puppy has, the better adjusted they will be. Puppy Preschools are an ideal way to socialise your puppy safely while they are not fully vaccinated.", nil],
               [NSArray arrayWithObjects:@"General Training", @"Successful dog training is based on reward. Be consistent and remember that dogs only understand immediate consequences. You have a 3 second window to reward or correct behaviours, outside of that time any reward or punishment will have little effect.", nil],
               [NSArray arrayWithObjects:@"Separation Anxiety", @"It is important to leave your new puppy alone regularly for short periods of time, with a treat to keep them occupied. Don’t make a fuss when leaving or returning. This will help to avoid your puppy developing separation anxiety.", nil],
               [NSArray arrayWithObjects:@"Barking ", @"Dogs bark for many different reasons. Keeping your dog occupied with toys and treats, exercising them every day, and restricting their view of the front of your section can help.", nil],
               [NSArray arrayWithObjects:@"Boredom ", @"All dogs get bored and without company can become destructive. Provide your dog with toys, rotating them so they stay novel and interesting. Always exercise your dog before leaving them alone, so they are more likely to sleep than be destructive.", nil], 
               nil];
                
     dataSource = [[NSMutableArray alloc] initWithArray:generalTips];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [dataSource count];
    /*
    switch (section) {
        case 0:
            return [generalTips count];
            break;
        case 1:
            return [catTips count];
            break;
        case 2:
            return [dogTips count];
            break;
    }
    return 0;
     */
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize bodyTextSize;
    CGSize headingSize;
   
    headingSize = [[[dataSource objectAtIndex:[indexPath row]] objectAtIndex:0] sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(260, 400) lineBreakMode:UILineBreakModeWordWrap];
    bodyTextSize = [[[dataSource objectAtIndex:[indexPath row]] objectAtIndex:1] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 400) lineBreakMode:UILineBreakModeWordWrap];

    return bodyTextSize.height + headingSize.height + 35;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [headerView setBackgroundColor:[UIColor colorWithRed:199/255.0 green:26/255.0 blue:18/255.0 alpha:1]];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 320, 24)];
    [headerLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [headerLabel setText:currentTitle];
    
    [headerView addSubview:headerLabel];
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PetTipsCell *cell = (PetTipsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setBackgroundColor:[UIColor greenColor]];
    
    if (cell == nil) {
        cell = [[PetTipsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    [cell setRowNumber:[NSNumber numberWithInt:([indexPath row] % 2)]];
    [cell setTitleTextLabelText:[[dataSource objectAtIndex:[indexPath row]] objectAtIndex:0]];
    [cell setTipTextLabelText:[[dataSource objectAtIndex:[indexPath row]] objectAtIndex:1]];
    /*    
    switch ([indexPath section]) {
        case 0:
            [cell setRowNumber:[NSNumber numberWithInt:([indexPath row] % 2)]];
            [cell setTitleTextLabelText:[[generalTips objectAtIndex:[indexPath row]] objectAtIndex:0]];
            [cell setTipTextLabelText:[[generalTips objectAtIndex:[indexPath row]] objectAtIndex:1]];
            break;
        case 1:
            [cell setRowNumber:[NSNumber numberWithInt:([indexPath row] % 2)]];
            [cell setTitleTextLabelText:[[catTips objectAtIndex:[indexPath row]] objectAtIndex:0]];
            [cell setTipTextLabelText:[[catTips objectAtIndex:[indexPath row]] objectAtIndex:1]];
            break;
        case 2:
            [cell setRowNumber:[NSNumber numberWithInt:([indexPath row] % 2)]];
            [cell setTitleTextLabelText:[[dogTips objectAtIndex:[indexPath row]] objectAtIndex:0]];
            [cell setTipTextLabelText:[[dogTips objectAtIndex:[indexPath row]] objectAtIndex:1]];
    }
     */
    
    
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


-(void)loadUp:(int)dataType byName:(NSString *)t {
    [self.dataSource removeAllObjects];
    switch (dataType) {
        case 1:
            [self.dataSource addObjectsFromArray:generalTips];
            currentTitle = t;
            break;
        case 2:
            [self.dataSource addObjectsFromArray:catTips];
            currentTitle = t;
            break;
        case 3:
            [self.dataSource addObjectsFromArray:dogTips];
            currentTitle = t;
            break;
       
    }
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


@end
