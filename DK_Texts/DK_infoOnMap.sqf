
/*
DK_nfoMap_AlphaTxt =
"
<font color='#01cbc2' size='20'>
READ ME ALPHA 0.4 :<br/>
<font size='23'>
MAFIA TEAM WORK FREEMODE<br/>
<font size='20'>
by Petrovic K.<br/><br/>
 
<font color='#FFFFFF' size='15' > 
Contact : mafiateamworkcontact@gmail.com<br/><br/><br/><br/>
 


---- This is a CLOSED ALPHA ! ----<br/><br/>
 
- To get a better evaluation of any mission's performance or difficulty, play it once or twice with default difficulty and daytime parameters.<br/><br/>
 
- Any constructive feedback (positive or negative) helps the dev to improve the mission. What you liked is a much important as what you disliked. Gameplay suggestions and other ideas are welcome.<br/><br/>
 
- Feedbacks on AI are important aswell. If you share a feedback about AI, try to describe the situation as much as you can : AI faction envolved, how and when, if it is in a vehicle or not, weapon type.. All those informations matters and will be a precious help!<br/><br/><br/><br/>
 
 

---- WHAT YOU CAN'T DO WITH THIS CLOSED ALPHA ----<br/><br/>

- Do not upload mission files to public platforms such as Steam Workshop or forums without explicit consentment of the author (Der Kroi alias Petrovic K.).<br/><br/>

_ It is forbidden to use music outside MTW. All music (except gingle) belong to Mafia Team Work and their writers.<br/><br/><br/><br/>

 
 
---- WHAT YOU CAN DO ----<br/><br/>
 
- You can safely share the mission with your trusted friends, as long as they acknowledge the previous statement.<br/><br/>
 
- You can share screenshots on Steam/Steam profile/forums or any platform you like.<br/><br/>
 
- Videos (commented or not) are most welcome. If you share any videos, please tag them, and therefore contribute to advertise Mafia Team Work gamemode.<br/>
We are very thankful for that ;)<br/><br/><br/><br/><br/>

 
 

KNOWN ISSUES :<br/><br/>

- If you heal yourself during a scripted animation such as 'Repair a vehicle', this will cause a bug that will disable your action menu (you are forced to respawn). Maybe fixed ?<br/><br/>
- Use 'restart' command on server break this mission, you must close it completely and start your server. Starting the mission and returning to the mission selection menu will cause the same problem.<br/><br/><br/><br/>



Enjoy and have fun !
";
*/

DK_nfoMap_AlphaTxt =
"
<font color='#01cbc2' size='21'>
READ ME 1.0 :<br/>
<font size='23'>
MAFIA TEAM WORK FREEMODE<br/>
<font size='20'>
by Der Kroi aka Petrovic K.<br/><br/>
 
<font color='#FFFFFF' size='16' > 
Join us : https://discord.gg/cdXscHV<br/>
Follow us : https://www.facebook.com/MafiaTeamWork/<br/>
Contact : mafiateamworkcontact@gmail.com<br/><br/><br/>

<font color='#FFFFFF' size='15' > 
KNOWN ISSUES :<br/><br/>

- If you try to get in the place of a gunner (like the Jeep or the Offroad) owning a player's corpse, the entering player will have a curious camera bug. Only leaving the server solves the problem to our knowledge.<br/><br/>


Enjoy and have fun !
";

#define DK_nfoMap_AlphaTitle "READ ME"
#define DK_nfoMap_AlphaTitleCat "MTW Freemode 1.0"

player createDiarySubject [DK_nfoMap_AlphaTitle, DK_nfoMap_AlphaTitle];
player createDiaryRecord [DK_nfoMap_AlphaTitle, [DK_nfoMap_AlphaTitleCat, DK_nfoMap_AlphaTxt]];
DK_nfoMap_AlphaTxt = nil;


/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////


DK_nfoMap_WelcomeTxt =
" 
<font color='#01cbc2' size='24' >Welcome to Mafia Team Work Freemode<br/><br/> 
 
<font color='#FFFFFF' size='15' > 
You are part of the " + "<font color='#00FF11'>" + (roleDescription player) + "<font color='#FFFFFF'>" + " family, and you work for Kenny Petrovic.<br/> 
Blufor isn't you team, your group is your team, aswell as your family.<br/> 
You can only trust " + "<font color='#00FF11'>" + (roleDescription player) + "<font color='#FFFFFF'>" + " family members, and Kenny Petrovic.<br/> 
Your family is in direct confrontation with other families (only players). Your goal is to earn the most respect and prove to Petrovic that your family is the only one to trust.<br/><br/> 
 
Missions and Targets are common to all families.<br/> 
Each objective completed add Respect points to your team and you earn money. Respect score is displayed on top-left of your screen.<br/> 
When game time is over, the game ends once the current mission is completed. If your family has the highest score when match ends, they will dominate others forever.<br/><br/>" +

"<font color='#E6292C'><marker name='DK_mkrMapNFOicon_3'>- RED : </marker><font color='#FFFFFF'>KILL or DESTROY (gang member, traitor, delivery truck...).<br/>" +
"<font color='#b739b4'><marker name='DK_mkrMapNFOicon_2'>- PURPLE : </marker><font color='#FFFFFF'>STEAL and drop (vehicle or case). Do not destroy !<br/>" +
"<font color='#FAF200'><marker name='DK_mkrMapNFOicon_11'>- YELLOW : </marker><font color='#FFFFFF'>DROP location for vehicle or briefcase (only seen by the driver/carrier).<br/><br/>

You can follow waypoints (3D Icons) that point objectives locations.<br/> 
Your GPS is your minimap. Check it to locate targets, aswell as nearby members of your family.<br/><br/> 
 
You can choose from 3 vehicle types before spawning with it.<br/> 
All cars can be field-repaired anytime.<br/><br/>

Le premier tableau accéssible via la touche 'P' (défault) vous indiques le nombres de joueur énnemies tué.
";

#define DK_nfoMap_WelcomeTitle "MTW Welcome"
#define DK_nfoMap_WelcomeTitleCat "Welcome"

player createDiarySubject [DK_nfoMap_WelcomeTitle, DK_nfoMap_WelcomeTitle];
player createDiaryRecord [DK_nfoMap_WelcomeTitle, [DK_nfoMap_WelcomeTitleCat, DK_nfoMap_WelcomeTxt]];
DK_nfoMap_WelcomeTxt = nil;


/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////


DK_nfoMap_MisInfoTxt =
"<font size='15' >
- Mission are given by Kenny Petrovic himself, via cellphone.<br/><br/>
- A hint will be displayed in your top-right corner, summarizing your objectives for current mission.<br/><br/>
- Your family gave you a GPS to make your job easier. Don’t forget to bind your key to use it !<br/><br/>
- If you are the carrier, be quick and careful, opposing teams will see your movements.<br/>
Team play is paramount.<br/><br/>
- Targets are shown by 3D markers ingame and on map colored markers (round for units, square for vehicles).<br/><br/>
- Missions are various, but objective type and their markers color code will always follow the same rules :<br/><br/>
<font color='#E6292C'><marker name='DK_mkrMapNFOicon_3'>RED</marker><font color='#FFFFFF'> targets are contracts to take down, or to vehicles/objects to destroy. It goes from rival gang members to delivery trucks, or any other kind of bullshit that hurts Mr. Petrovic’s business.<br/><br/>
<font color='#b739b4'><marker name='DK_mkrMapNFOicon_2'>PURPLE</marker><font color='#FFFFFF'> targets are vehicles or briefcases to capture and often bring back to a specific location (marked by a YELLOW square on map and 3D markers ingame). If things go south, Gangs, Police, FIB or even the Army can become active part of the show. They will be on duty until the end of the mission.<br/><br/>
<font color='#FAF200'><marker name='DK_mkrMapNFOicon_12'>YELLOW</marker><font color='#FFFFFF'> objectives represents locations where Purple objectives must be dropped. Only the Purple objective carrier can see the Yellow icon, and ingame 3D markers of drop area. Make sure to not fall into ambushes when going to those locations.<br/><br/>
- After each mission, make sure to check the <font color='#008C19'><marker name='DK_mkrMapNFOicon_6'>ammo box</marker><font color='#FFFFFF'> and vehicles, additionnal equipment or weapons can be often recovered.
";

#define DK_nfoMap_MisInfoTitle "MTW Missions info"
#define DK_nfoMap_MisInfoTitleCat "Missions information"

player createDiarySubject [DK_nfoMap_MisInfoTitle, DK_nfoMap_MisInfoTitle];
player createDiaryRecord [DK_nfoMap_MisInfoTitle, [DK_nfoMap_MisInfoTitleCat, DK_nfoMap_MisInfoTxt]];
DK_nfoMap_MisInfoTxt = nil;


/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////


DK_nfoMap_TipsTxt =
"<font size='15' >
- If some enemies are fleeing in a vehicle, chase'em and stay close to their vehicle to force em to pull down.<br/><br/>
- Bellow 80km/h, you can get out of your vehicle safely. Get out at higher speed is still possible, but is at your own risks.<br/><br/>
- They're Stunt Jumps across the maps that give money and point to your family from 100 km/h. Only one time.<br/><br/>
- Police cars often carry assault rifle.<br/><br/>
- Shoot the civilian vehicles can often force them to stop their car.<br/><br/>
- Yellow square represents locations where purple objectives must be dropped. Only the purple objective driver/carrier can see the destination marked in yellow on your map, and ingame 3D markers of drop area.<br/><br/>
- If you like big explosions, try to find fuel/gas tank trucks.<br/><br/>
- If you can hear police sirens, then police patrol is on duty, and is therefore allowed to shoot on sight.<br/><br/>
- All cars can be field-repaired anytime.<br/><br/>
- If you have a teammate during a 'Steal vehicle and Bring It Back' mission, a repair vehicle can be very useful.<br/><br/>
- You can repack mags with Ctrl + R.<br/><br/>
- Cop's body armor will provide better protection than worn ones used by mafiosi.<br/><br/>
- Suppressed weapons allow you to hit your targets without being spotted.<br/><br/>
- The first page accessible via 'P' key (default) tells you the number of enemy players killed.<br/><br/>
- Reward supply cases color gives you an idea of it's value :<br/>
 > Lvl 1 is Light grey<br/>
 > Lvl 2 is Olive<br/>
 > Lvl 3 is Brown<br/>
 > Lvl 4 is Dark grey / black<br/>
 > Lvl 5 is Tropical green<br/><br/>
- Several services are available to you:<br/>
 > Little Jacob can provide you with weapons (from 250 personal pts)<br/>
 > Paramedics can save your life ($ 35)<br/>
 > Your starting car can have a NOS Boost if your personal points are not negative<br/>
 > Military airdrop

";

#define DK_nfoMap_TipsTitle "MTW Tips"
#define DK_nfoMap_TipsTitleCat "Tips"

player createDiarySubject [DK_nfoMap_TipsTitle, DK_nfoMap_TipsTitle];
player createDiaryRecord [DK_nfoMap_TipsTitle, [DK_nfoMap_TipsTitleCat, DK_nfoMap_TipsTxt]];
DK_nfoMap_TipsTxt = nil;


/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////


DK_nfoMap_Wanted =
"<font size='15' >
The Wanted Level is inspired from “Grand Thef Auto”, and tells players how much police attention they are getting, or in a few missions, how much they are actively searching for the objective.<br/><br/>

Wanted Level stars are related to your own actions, only the wanted mafia member sees it, and cops will only be after him. Altis police don't get tired, other mobsters are not safe: if a patrol sees a mafia member, they can decide to engage him as well.<br/><br/>

On mission, stars however are global. All mafia members will be actively wanted by Law Enforcers. Expect cops, FBI agents, and Army to come in number, protecting objectives assets against the mob.<br/><br/><br/>

<font size='18' ><t shadow='2'>How it works<font size='16' ><br/><br/>

Level 1 :<font size='15' ><br/><br/>

Depends on checks and stops (usually on foot) or patrol that randomly happen on the map. If the patrol has not been neutralized or outrun, it will call reinforcement and therefore Level 2.<br/>
If you meet a police patrol, which is not already chasing someone, they will chase you if you have at least one star.<br/><br/>

<font size='16' >Level 2 :<font size='15' ><br/><br/>

From 4 police units chasing you, 2 stars will be displayed at your wanted level. If you don't neutralize them or outrun them fast enough, they will call a helicopter with S.W.A.T. crew, which will trigger Level 3.<br/><br/>

The various events impacting Wanted levels overlap each other. As a result, shooting down or outrun a patrol does not reset your Wanted index if another patrol is also on your trail.<br/><br/>

NB: From Level 2, reinforcements are called continuously every X times. Only outrun or kill all the police currently chasing you, can lose your Wanted Level.<br/><br/>

<font size='16' >Level 3:<font size='15' ><br/><br/>

Level 3 is there as long as you have a police helicopter chasing you.<br/><br/>

<font size='16' >Level 4:<font size='15' ><br/><br/>

If the police have too much trouble arresting you, FBI vans will be called in for reinforcement and S.W.A.T. will have better weapons.<br/><br/>

<font size='16' >Level 5:<font size='15' ><br/><br/>

Are you still alive? The army will therefore try to teach you who dominates this island.<br/><br/>

NB: Killing law enforcement chasing you decrease the necessary time to call in reinforcements.<br/><br/>

--       --       --       --       --       --       --<br/><br/>

On missions, like 'Steal and Bring Back', law enforcers will spawn continuously until the end of the current mission. The amount of active reinforcements simultaneously depends on the mission and the number of players connected (also configurable). Backups, as well as regular patrols will head towards the objective to protect it from the mafia.<br/>
Wanted Level progression is based on the number of patrols neutralized.<br/><br/>

--       --       --       --       --       --       --<br/><br/>

Summary of type of law enforcement units by Wanted Level, same for local and global:<br/><br/>

Lvl 1: Police patrol car<br/>
Lvl 2: Police patrol car called in for reinforcement<br/>
Lvl 3: Police patrol car + Police helicopter<br/>
Lvl 4: FIB Van + Police patrol car + Police helicopter<br/>
Lvl 5: Military + Police patrol car + Army helicopter<br/>
";

#define DK_nfoMap_WantedTitle "MTW Wanted Level"
#define DK_nfoMap_WantedTitleCat "Most Wanted !"

player createDiarySubject [DK_nfoMap_WantedTitle, DK_nfoMap_WantedTitle];
player createDiaryRecord [DK_nfoMap_WantedTitle, [DK_nfoMap_WantedTitleCat, DK_nfoMap_Wanted]];
DK_nfoMap_Wanted = nil;




