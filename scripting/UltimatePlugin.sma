/*
	AMX Mod X script.

	This plugin is free software; you can redistribute it and/or modify it
	under the terms of the GNU General Public License as published by the
	Free Software Foundation; either version 2 of the License, or (at
	your option) any later version.
	
	This plugin is distributed in the hope that it will be useful, but
	WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
	General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this plugin; if not, write to the Free Software Foundation,
	Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
*/

/*
	UltimatePlugin
	by tonykaram1993
	
	
	We all know the famous amx_super plugin. Most servers use it as a wonderful
	administrative tool to let admins take control over their servers and manage
	it in a better and more efficient way. At first I started by editing that
	plugin to make it use less resources and do things in a better way (AFAIK).
	But later, I ended up rewriting the whole thing from scratch (ofc it is based
	on amx_super so a lot of resemblance can be found). I hope I succeeded in
	my mition. I am not the best coder there is, but I think I have some good
	knowledge in scripting (I hope).
	
	
	Please check the main thread of this plugin for much more information. You can
	do so in here: https://forums.alliedmods.net/showthread.php?t=212867
	
	
	Plugins Included:
	PLUGIN_NAME				PLUGIN_AUTHOR
	
	Admin Check				(by OneEyed)
	Admin Restart/Shutdown			(by Hawk552)
	Admin Heal				(by F117Bomb)
	Admin Armor				(by F117Bomb)
	Admin Bury/Unbury			(by v3x)
	Admin Ammo				(by AssKicR)
	Admin Revive				(by anakin_cstrike)
	Admin Disarm				(by mike_cao)
	Admin Noclip				(by watch)
	Admin Godmode				(by watch)
	Admin Blanks				(by EKS)
	Admin NoBuy				(by AssKicR)
	Admin Score				(by Freecode)
	Admin Listen				(by sMaxim)
	Admin Rocket				(by F117Bomb)
	Admin Extend				(by JSauce)
	Admin Speed				(by X-olent)
	Admin Badaim				(by Twistedeuphoria)
	Admin Drug				(by X-Olent)
	Admin Lock				(by Bmann_420)
	Admin Gravity				(by JustinHoMi)
	Admin PersonalGravity			(by GHW_Chronic)
	Admin Auto-Slay				(by fezh)
	Admin Password				(by Sparky911)
	Admin Transfer				(by Deviance)
	Admin Swap				(by Deviance)
	Admin Team Swap				(by Deviance)
	Admin Glow 				(by Kensai)
	Admin Glow2				(by Kensai)
	
	Reset Score				(by silentt)
	Command Search				(by GHW_Chronic)
	Advanced Bullet Damage			(by Sn!ff3r)
	Spawn Refund				(by tonykaram1993)
	Auto Restart				(by vato loco [GE-S])
	Aim Practice				(by rompom7)
	Dead Listen				(by sMaxim)
	Connor's colored admin chat		(by ConnorMcLeod)
	AFK Bomb Transfer			(by VEN)
	Join/Leave Announcments			(by BigBaller)
	Shown Dead Spectator Fix		(by Vantage)
	C4 Timer				(by Cheap_Suit)
	No More Rcon				(by ??)
	AFK Manager				(by hoboman)
	Player IP				(by tonykaram1993)
	Loading Songs				(by White Panther)
	Spectator Menu Bug Fix			(by Gray Death)
	To Spec and Back			(by Regalis)
	Mute Menu				(by Cheap_Suit)
	Smart Slash				(by Emp)
	
	Plugin that cannot be added: (due to the 2013 HLDS update)
	Admin Exec		: requires client_cmd( )
	Admin Quit		: requires client_cmd( )
*/

/*
	Change Log:
	
	+ something added/new
	- something removed
	* important note
	x bug fix or improvement
	
	v0.0.1	beta:	* plugin written
	
	v0.0.2	beta:	x removed afk task check when last player leaves server
			x re-initialized afk task check when player joins server 
			- removed debug function
			x stripped the player after being buried so he cannot throw grenades any more
			x allowed amx_autoslay on dead clients (you needed to catch player alive to remove it)
			x fixed +jump command on players when being rocketed
			+ added check if pgravity value is zero, warn admin
			+ added a cap limit to command search results, stops player overflow
			
	v0.1.0	beta:	+ added loading songs plugin to the list
			+ added spectator menu bug fix plugin
			+ added glow/2 plugins to the list
			+ re-added debug function (commented)
			+ added /spec and /unspec (bug fixed)
			
	v0.1.1	beta:	x allowed score changing on dead players
			x allowed blanks and nobuy setting on dead players
			x fixed amx_ip not working on targets
			x removed alive checking when transfering
			x removed alive checking when swapping two players
			
	v0.1.2	beta:	x changed max, min and clamp to engine and not functions (seems to work again)
			+ added alive/connected checks for all tasks (where players are involved and neccessary)
			x removed task when task is repeated several times and that user is not connected
			+ added a small advertisement message
			+ added /gravity and /alltalk as client commands
			+ added the configuration auto execution (forgot about that earlier :( )
			+ added sv_maxspeed to the config file
			
	v1.0.0:		x added preprocessor if for the colorchat enum
			x fixed memory access bug in the transfer command
			x reused function way of min, max and clamp, since weird values was being found
			* plugin out of beta
			
	v1.0.1:		+ now the plugin automatically reloads cvars on new round
			+ added gag plugin to the list (tested as much as i can alone)
			* after adding gag, i figured i might add reconnect support in the following week
	
	v1.0.2:		x fixed stupid typo that prevented loading songs from working
	
	v1.0.3:		x fixed PLUGIN_VERSION wrongly configured
			x relocalized some global arrays to local static ones (arkshine)
			
	v1.0.4:		* changed amx_search access from ADMIN_ADMIN to ADMIN_MENU
			x fixed displaying the wrong message when unlocking a team
			* removed some defines from the safety zone
			x changed iRandom variable in client_connect from 'new' to 'static'
			x changed variables in client_infochanged from 'new' to 'static'
			
	v1.0.5:		x fixed /spec working on old style menus (perviously it was only blocked on vgui menus)
			x fixed cvars being loaded before config execution
			x fixed dead players not seeing alive chat when enabled (MPNumB)
			x fixed typo with client_authorized
			
	v1.1.0:		+ added ability to remove connect and disconnect messages from defines
			x fixed the private message system, it was totally messed up no idea why
			x fixed admin chat, message was only printed to admins and not the one who wrote it
			
	v1.1.1:		x moved config execution to plugin_init, should be executed before ReloadCvars( )
			+ added the ability to remove advertising messages by commenting the AD_TIME define
			x fixed a few error message when GREEN_CHAT was commented
			x fixed error in Event_Damage, when hitting a non player entity
			x fixed a bug where spectator players could not use any menus
			
	v1.2.0:		+ added mute menu plugin
			x moved several defines to cvars
			+ added the ability to choose between HUD and CHAT for join/leave messages
			x fixed no message being shown when player disconnects
			x changed that only immune admins can affect immune admins with @t, @ct, @spec and @all params
			+ added new command to start playing the loading songs
			+ added new command to stop playing the loading songs
			* the new command above, will actually play the cd that is inside your cd tray (if you have one in)
			x possibly fixed the index out of bounds error in ClCmd_JoinTeam function
			
	v1.2.1:		+ added a couple of messages printed on the player's screen when he starts/stops the random song
			x fixed displaying warning message to afk immune admins
			x fixed amx_ip not displaying the correct userid of players when no argument was specified
			x fixed speed not working after freeze time
			x fixed not being able to plant after c4 has been given
			+ added spawn protection
			x changed the way rcon cvars are handled
	
	v1.2.2:		x fixed a bug with amx_psay which was crashing the server
			+ added some defines that makes editing the prefix and suffix much easier
			x several code optimization have been applied
			
	v1.3.0	beta:	* plugin is in beta temporarely
			x extended the plugin prefix from 15 characters to 31
			+ added a couple of messages when player uses /spec
			+ added function that prints in log files if UltimatePlugin is up to date or needs update
			+ added word after the version (needs update or not) when user type /version
			- removed a couple of block comments which served for nothing
			- removed plugin prefix in log messages (it was useless there)
			x disabled the use of /unspec before using /spec
			x fixed small bug with mute menu where name was not printed correctly
			x fixed message typo
			x rearranged some of the code, now looks better xD
			- removed green messages in prints (was kinda childish :P)
			* GREEN_CHAT now only controls std_admin_color_chat
			x fixed a bug with the mute menu, where you could actually mute yourself (oops)
			x fixed missing console message in godmode/noclip command
			x fixed a parameter error with the afk warning message
			
	v1.3.1:		* plugin not in beta anymore
			x added a check to see if player is connected in ClCmd_JoinTeam, since it was giving some errors sometimes
			x fixed std admin color chat as it was reading first argument instead of the whole sentence
			x various minor code optimization
			x fixed missed placed variable in ConCmd_Health when giving health to a team (sorry)
			
	v1.3.2:		+ added link to the thread at the top of the source code for reference
			x fixed string in some commands
			x possible compatibility fix for the cod mw mod
			x fixed not being able to type /spec after previous fix gone wrong
			x replaced reamining show_hudmessage with message sync (oops sry)
			x minor code optimisations
			x removed useless enum that was never used
			
	v1.3.3:		x fixed stupid typo in a log message
			+ added print message after version have been compared
			x added check if user is connected in some tasks
			x fixed typo in amx_userorigin command
			- removed all useless comments that were kept for reference
			+ added printed message when player uses /mute and he is alone on server
			
	v1.3.4:		x fixed wrongly named variables (no errors, just the naming)
			+ added message to all when player listens to music so they can do the same
			+ added a check if it is the first time playing song to print to all to prevent spam
			* language file must be updated
			x fixed swapped messages when muting and unmuting players
			x fixed wrong argument placing in some log messages
			+ added condition that stops uberslap when round has ended
			+ added bitsums to cache if user has blanks (usefull for api)
			+ added bool to check if is hs only (usefull for api)
			+ added several api natives that can be used from other plugins
			
	v1.3.5:		+ added colorchat support (now message can be customized in green and/or red, blue, grey
	
	v1.3.6:		x changed the way config file is checked, it is not hardcoded anymore (according to plugin name)
			x fixed dictionary registration (my bad, I forgot to change the file's name - was meant for testing)
			x various code optimizations
			
	v1.3.7:		x changed default not to show port when using amx_ip
			x fixed return value in client_command
			+ added text message to all players when admin changes cvars in client_command
			
	v1.4.0:		* plugin now fully supports amxmodx 1.8.2 and 1.8.3
			x fixed some small typos in the ML files
			+ added two ML files, for simplicity to the users (they can choose in the source whitch one)
			
	v1.4.1:		* replaced std_admin_color_chat with connor's version (it better looking :D)
			x various code optimisations
			x fixed small issue with client_print_color's stock (my bad sorry :()
			x fixed two errors that did not have ^1 after the prefix
			+ added check if GREEN_CHAT is defined whether to inititaze register_dictionary_colored
			
	v1.4.2:		- removed old std admin color chat defines
			x changed that after muting a player, menu get refreshed and not closed
			x fixed gagged players name change message still showing
			x changed the way time is printed when player is gagged
			x added time left of gag when player tries to chat and he is gagged (name change as well)
			x fixed wrong color in gag name change message
			x fixed wrong number of arguments is clamping gag time message
			+ added gag reason for when admin is gagging
			* changed afk checking frequenfcy to 5 seconds instead of 1
			x changed return to continue in afk check
			x fixed wrong paramter number in afk warning message
			+ added afk check for spectators, and kicking them
			+ added couple of cvars to control spec afk check
			* config file must be updated
			x fixed max and min natives
			+ added COLOR_CHAT define to control only colored messages
			
	v1.4.3	beta:	x removed debug message in health command
			+ added ability to execute commands from chat ("/heal @CT 1" in chat becomes "amx_heal @CT 1" in console)
			+ added striping of players weapons after spawn if it is knife warmup
			- removed addplayeritem ham hook, better looking than superceding it
			+ added no buying when knife warmup is in progress
			+ added check  to block amx_weapon usage when knife warmup is in progress
			+ added a couple of message for when amx_weapon is blocked to inform admins
			* .txt files need to be updates
			+ added / command to check recentely used chat commands
			- removed /gravity as it conflicted with smart slash
			x fixed knife round message if knife round is disabled
			x fixed long message in /admins
			
	v1.4.4:		x fixed invalid menu id error in Handle_RecentelyUsedMenu
			x fixed cvar typo
			x fixed not being able to use weapons on autorr when knife warmup was off
			x changed the way blocking a player from buying weapons is done
			x fixed bug where if player was in buy zone, he could still buy
			x fixed invalid buffer size from replace( ) function
			* cfg file need to be updated
*/
#define PLUGIN_VERSION		"1.4.4"

/* Includes */
#include < amxmodx >
#include < amxmisc >
#include < cstrike >
#include < engine >
#include < fakemeta >
#include < hamsandwich >
#include < csstats >
#include < sockets >
#include < fun >

#pragma semicolon 1

/* Defines */
#define SetBit(%1,%2)		(%1 |= (1<<(%2&31)))
#define ClearBit(%1,%2)		(%1 &= ~(1 <<(%2&31)))
#define CheckBit(%1,%2)		(%1 & (1<<(%2&31)))

#define XO_PLAYER    		5
#define m_iMenu    		205
#define T_CT_MENU		3

#define cs_get_user_menu(%1)    get_pdata_int(%1, m_iMenu, XO_PLAYER)
#define is_str_empty(%1)	(%1[0] == EOS)
#define is_user(%1)		(1 <= %1 <= MAX_PLAYERS)

#define IP_PORT			1
#define MAX_MUSIC		6
#define MAX_COLORS		30

#define PLUGIN_TOPIC		"/showthread.php?t=212867"
#define PLUGIN_HOST		"forums.alliedmods.net"

/*
	Below is the section where normal people can safely edit
	its values.
	Please if you don't know how to code, refrain from editing
	anything outside the safety zone.
	
	Experienced coders are free to edit what they want, but I
	will not reply to any private messages nor emails about hel-
	ping you with it.
	
	SAFETY ZONE STARTS HERE
*/

/*
	Set this to your maximum number of players your server can
	hold.
*/
#define MAX_PLAYERS		32

/*
	If you wish not to have green message on your server, you
	should comment line 133. Else keep it as it is.
	
	Commenting a line is when you add '//' at the beginning of
	the line.
	
	NOTE: if GREEN_CHAT is defined, then the plugin must be 
	above the admin_chat.amxx plugin in the plugins.ini file.
	Else the std admin color chat, will not function.
*/
#define GREEN_CHAT		1

/*
	This will control whether green messages are shown. Comment
	to disable the colored messages
	Note: prefix is always colored in green
*/
#define COLOR_CHAT		1

/*
	ADMIN_LISTEN is the access the admin must have in order to
	see all the players' messages. For the full list of admin
	rights, please check the following file:
	c:\...\scripting\includes\amxconst.txt.
*/
#define ADMIN_LISTEN		ADMIN_BAN

/*
	Below are the limits that admins can use to set the health/armor 
	of a player. The reason that this exists is to prevent admin
	from giving players 200,000 health/armor and risk crash the 
	server.
*/
#define MIN_HEALTH		1  
#define MAX_HEALTH		20000
#define MIN_ARMOR		0
#define MAX_ARMOR		1000

/*
	Below are the default values of each the health and armor
	whitch are used when the admin who revives a player does
	not specify an exact ammount of health and/or armor.
	
	Note: MIN_/MAX_ HEALTH/ARMOR values still apply.
*/
#define SPAWN_DEF_HEALTH	100
#define SPAWN_DEF_ARMOR		0

/*
	Below is to specify whether the revive function include
	already alive players or skips them. If you want that alive
	players gets counted, then leave it as it is, else comment
	line 173.
	
	Commenting a line is when you add '//' at the beginning of
	the line.
*/
#define REVIVE_ALIVE		1

/*
	Below are the default, minimun and maximum values that the
	restart/shutdown timer take. Default timer is when the admin
	who wants to restart/shutdown the server does not specify it.
	
	Note: 0 means instant restart/shutdown
*/
#define DEF_TIMER		0
#define MIN_TIMER		0
#define MAX_TIMER		60

/*
	Below is the delay that it takes to auto slay a player after 
	he has spawned.
	
	Note: this value must be a float (float means that its a deci-
	mel number even if the first number after the '.' is a 0)
	ex: 2.5, 0.1, 5.0 (5.0 and not 5).
*/
#define DELAY_AUTOSLAY		Float:2.5

/*
	After a player is revived by an admin, he normally doesn't
	get any weapons, but I am giving them their default spawn
	weapons (CT:USP | T:GLOCK18). And here you can specify how
	much back pack ammo they get with the weapon.
*/
#define BPAMMO_USP		24
#define BPAMMO_GLOCK18		40

/*
	Here you can specify how much damage a player gets per 2
	seconds when he is set on fire by an admin.
	
	Note: even if the damage is set to a negative number, it 
	will automatically take the absolute value if it
	ex: setting it to -10 is like setting it to 10
*/
#define FIRE_DAMAGE		10

/*
	In here you can define what are the limits that an admin 
	can extend the map by step. So that the admin cannot ext-
	end more than 15 minutes at one time for example.
*/
#define MIN_EXTEND		1
#define MAX_EXTEND		15

/*
    Here you can specify what access the admin has to have in
    order to see the IP and STEAM ID of the joining/leaving 
    player, else do not display IP nor STEAM ID.
*/
#define ADMIN_DISCONNECT	ADMIN_BAN
#define ADMIN_AUTHORIZED	ADMIN_BAN

/*
	AFK specific settings are below here.
	+ Frequency: each what number of seconds, the plugin checks 
	for afk players
	+ Immunity: what flag the admin must to be immune
	+ Warning: when he has that many seconds left, he is warned
*/
#define AFK_FREQUENCY		5
#define AFK_IMMUNITY		ADMIN_IMMUNITY
#define AFK_WARNING		10

/*
	In the following, you can specify the model that the players
	would get if they have been transfered by an admin.
*/
#define CS_T_MODEL		CS_T_LEET
#define CS_CT_MODEL		CS_CT_URBAN

/*
	This is to ensure the admin executing amx_search 
	does not get overflowed. A max ammount of commands
	is set. Besides having that many commands means just
	like paging amx_help
*/
#define MAX_SEARCH_RESULTS	30

/*
	These are the minimums and maximum of the gag time
	an admin can set on a player. They are in minutes.
*/
#define GAG_MIN			1
#define GAG_MAX			60

/*
	This is the max number of commands initiated by all
	admins from chat to be saved for later use.
*/
#define MAX_COMMANDS		10

/*
	This is where you stop. Editing anything below this point
	might lead to some serious errors, and you will not get any
	support if you do.
	
	SAFETY ZONE ENDS HERE
*/

/* Enumerations */
enum ( ) {
	CVAR_RESETSCORE		= 0,	CVAR_RESETSCORE_DISPLAY,
	CVAR_ADMINCHECK,		CVAR_ABD,
	CVAR_ABD_WALL,			CVAR_REFUND,
	CVAR_AUTORR,			CVAR_ADMINLISTEN,
	CVAR_ADMINLISTEN_TEAM,		CVAR_DEADLISTEN,
	CVAR_DEADLISTEN_TEAM,		CVAR_AFK_BOMBTRANSFER,	
	CVAR_C4_TIMER,			CVAR_MAX_EXTEND,
	CVAR_AFK,			CVAR_AFK_PUNISHMENT,
	CVAR_AFK_SPECTATORS,		CVAR_SPEC,
	CVAR_GAG_VALUE,			CVAR_GAG_FLAGS,
	CVAR_GAG_NAME,			CVAR_AUTORR_KNIFE
};

enum ( += 100 ) {
	TASK_COUNTDOWN_RESTART 	= 100,	TASK_COUNTDOWN_SHUTDOWN,
	TASK_COUNTDOWN_RESTARTROUND,	TASK_REVIVE,
	TASK_UBERSLAP,			TASK_AUTOSLAY,
	TASK_AFK_BOMBCHECK,		TASK_UPDATETIMER,
	TASK_ROCKETLIFTOFF,		TASK_ROCKETEFFECTS,
	TASK_BADAIM,			TASK_AFK_CHECK,
	TASK_SPECBUG,			TASK_AD,
	TASK_UNGAG,			TASK_PUTINSERVER,
	TASK_DISCONNECT,		TASK_DISCONNECT_HUD,
	TASK_PUTINSERVER_HUD,		TASK_CURWEAPON,
	TASK_SP,			TASK_GETANSWER,
	TASK_CLOSECONNECTION
};

enum _:SPRITE_MAX( ) {
	SPRITE_MUZZLEFALSH 	= 0,	SPRITE_SMOKE,
	SPRITE_BLUEFLARE,		SPRITE_WHITE,
	SPRITE_LIGHTNING
};

enum _:SOUND_MAX( ) {
	SOUND_FLAMEBURST 	= 0,	SOUND_SCREAM21,
	SOUND_SCREAM7,			SOUND_ROCKETFIRE,
	SOUND_ROCKET,			SOUND_THUNDERCLAP,
	SOUND_HEADSHOT
};

enum _:TEAMS_MAX( ) {
	TERRORIST 		= 0,	COUNTER 		= 1,
	AUTO 			= 4,	SPECTATOR 		= 5
};

enum ( ) {
	SLAY_LIGHTINING 	= 0,	SLAY_BLOOD,
	SLAY_EXPLODE
};

enum ( ) {
	R			= 0,	G,
	B,				A
};

enum ( ) {
	GAG_CHAT		= 1,
	GAG_TEAMCHAT		= 2,
	GAG_VOICE		= 4
}

#if AMXX_VERSION_NUM < 183
enum ( ) {
	print_team_default	= 0,
	print_team_grey		= 33,
	print_team_red,
	print_team_blue
};
#endif

/* Constants */
new const g_strPluginName[ ]		= "UltimatePlugin";
new const g_strPluginVersion[ ]		= PLUGIN_VERSION;
new const g_strPluginAuthor[ ]		= "tonykaram1993";

new const g_strSprites[ SPRITE_MAX ][ ] = {
	"sprites/muzzleflash.spr",
	"sprites/steam1.spr",
	"sprites/blueflare2.spr",
	"sprites/white.spr",
	"sprites/lgtning.spr"
};

new const g_strSounds[ SOUND_MAX ][ ] = {
	"ambience/flameburst1.wav",
	"scientist/scream21.wav",
	"scientist/scream07.wav",
	"weapons/rocketfire1.wav",
	"weapons/rocket1.wav",
	"ambience/thunder_clap.wav",
	"weapons/headshot2.wav"
};

new const g_strWeapons[ 31 ][ ] = {
	"",				"weapon_p228",
	"weapon_shield",		"weapon_scout",
	"weapon_hegrenade",		"weapon_xm1014",
	"weapon_c4",			"weapon_mac10",
	"weapon_aug",			"weapon_smokegrenade",
	"weapon_elite",			"weapon_fiveseven",
	"weapon_ump45",			"weapon_sg550",
	"weapon_galil",			"weapon_famas",
	"weapon_usp",			"weapon_glock18",
	"weapon_awp",			"weapon_mp5navy",
	"weapon_m249",			"weapon_m3",
	"weapon_m4a1",			"weapon_tmp",
	"weapon_g3sg1",			"weapon_flashbang",
	"weapon_deagle",		"weapon_sg552",
	"weapon_ak47",			"weapon_knife",
	"weapon_p90"
};

new const g_strMusicList[ MAX_MUSIC ][ ] = {
	"Half-Life01",			"Half-Life02",
	"Half-Life04",			"Half-Life12",
	"Half-Life13",			"Half-Life17"
};

new const g_iWeaponClip[ 31 ] = {
	0, 13, 0, 10, 0, 7, 0, 30, 30, 0, 30, 20, 25, 30, 35, 25,
	12, 20, 10, 30, 100, 8, 30, 30, 20, 0, 7, 30, 30, 0, 50
};

new const g_iWeaponBackpack[ 31 ] = {
	0, 52, 0, 90, 1, 32, 1, 100, 90, 1, 120, 100, 100, 90, 90, 90,
	100, 120, 30, 120, 200, 32, 90, 120, 90, 2, 35, 90, 90, 0, 100
};

/* Floats */
new Float:g_fPlayerGagEnd[ MAX_PLAYERS + 1 ];
new Float:g_fGagTime;

/* Booleans */
new bool:g_bBlockTeamJoin[ 6 ];
new bool:g_bRestartedRound;
new bool:g_bFreezeTime;
new bool:g_bSpawn;
new bool:g_bPlanting;
new bool:g_bNeedToUpdate;
new bool:g_bIsHSOnly;

/* CsTeams */
new CsTeams:g_iPlayerTeam[ MAX_PLAYERS + 1 ];

/* Integers */
new g_iPlayerOrigin[ MAX_PLAYERS + 1 ][ 3 ];
new g_iPlayerTime[ MAX_PLAYERS + 1 ];
new g_iPlayerGagFlags[ MAX_PLAYERS + 1 ];
new g_iRocket[ MAX_PLAYERS + 1 ];
new g_iSprites[ SPRITE_MAX ];
new g_iSavedOrigin[ 3 ];

new g_iTimeLeft,			g_iSpawnHealth;
new g_iSpawnArmor,			g_iSpawnMoney;
new g_iAFKTime,				g_iAFKTime_Bomb;
new g_iAFKPunishment,			g_iBombCarrier;
new g_iC4Timer,				g_iTotalExtendTime;
new g_iAdvertisement,			g_iJoinleaveAnnouncements;
new g_iSpawnProtection,			g_iSpawnProtectionGlow;
new g_iSocket,				g_iAFKSpectatorsTime;
new g_iCommandCount;

/* Strings */
new g_strData[ 1024 ];
new g_strGagReason[ MAX_PLAYERS + 1 ][ 64 ];
new g_strPlayerCommand[ MAX_COMMANDS ][ 64 ];
new g_strConnectMessage[ 128 ];
new g_strLeaveMessage[ 128 ];
new g_strPluginPrefix[ 32 ];
new g_strSocketVersion[ 16 ];
new g_strGagFlags[ 4 ];

/* Menus */
new g_menuMuteMenu[ MAX_PLAYERS + 1 ];

/* Bitsums */
new g_bitIsMuted[ MAX_PLAYERS + 1 ];
new g_bitIsConnected,			g_bitIsAlive;
new g_bitIsOnFire,			g_bitHasUnAmmo;
new g_bitHasUnBPAmmo,			g_bitHasGodmode;
new g_bitHasNoClip,			g_bitHasNoBuy;
new g_bitHasAutoSlay,			g_bitHasBadaim;
new g_bitHasSpeed,			g_bitHasGlow;
new g_bitCvarStatus,			g_bitHasSP;
new g_bitIsFirstSong,			g_bitHasBlanks;

/* Pcvars */
new g_pcvarResetScore,			g_pcvarResetScoreDisplay;
new g_pcvarAdminCheck,			g_pcvarBulletDamage;
new g_pcvarBulletDamageWall,		g_pcvarRefund;
new g_pcvarRefundValue,			g_pcvarAutoRestart;
new g_pcvarAutoRestartTime,		g_pcvarAdminListen;
new g_pcvarAdminListenTeam,		g_pcvarDeadListen;
new g_pcvarDeadListenTeam,		g_pcvarAFKBombTransfer;
new g_pcvarAFKBombTransfer_Time,	g_pcvarC4Timer;
new g_pcvarMaxExtendTime,		g_pcvarAFKTime;
new g_pcvarAFKPunishment,		g_pcvarAFK;
new g_pcvarAllowSpec,			g_pcvarGagTime;
new g_pcvarGagFlags,			g_pcvarGagName;
new g_pcvarPluginPrefix,		g_pcvarPluginAdvertisement;
new g_pcvarConnectDisconnectMessage,	g_pcvarConnectMessage;
new g_pcvarLeaveMessage,		g_pcvarSpawnProtection;
new g_pcvarSpawnProtectionGlow,		g_pcvarAFKSpectators;
new g_pcvarAFKSpectatorsTime,		g_pcvarAutoRestartKnife;

/* Cvar Pointers */
new g_cvarShowActivity,			g_cvarC4Timer;
new g_cvarTimeLimit,			g_cvarGravity;
new g_cvarPassword,			g_cvarAllTalk;
new g_cvarHostname;

/* Hud Sync */
new g_hudSync1,				g_hudSync2;
new g_hudSync3,				g_hudSync4;
new g_hudSync5,				g_hudSync6;

/* Message IDs */
new g_msgScoreInfo,			g_msgDamage;
new g_msgShowTimer,			g_msgRoundTime;
new g_msgScenario,			g_msgSetFOV;
new g_msgTeamInfo,			g_msgSayText;

/* HamHooks */
new HamHook:g_hamTouchArmouryEntity;
new HamHook:g_hamTouchWeaponBox;

/* Plugin Natives */
public plugin_init( ) {
	/* Plugin Registration */
	register_plugin( g_strPluginName, g_strPluginVersion, g_strPluginAuthor );
	register_cvar( g_strPluginName, g_strPluginVersion, FCVAR_SERVER | FCVAR_EXTDLL | FCVAR_UNLOGGED | FCVAR_SPONLY );
	
	#if defined COLOR_CHAT
		#if AMXX_VERSION_NUM < 183
		register_dictionary_colored( "UltimatePlugin_ColorChat_182.txt" );
		#else
		register_dictionary( "UltimatePlugin_ColorChat_183.txt" );
		#endif
	#else
	register_dictionary( "UltimatePlugin_Normal.txt" );
	#endif
	
	/* Pcvars */ 
	g_pcvarResetScore		= register_cvar( "up_resetscore",		"1" );
	g_pcvarResetScoreDisplay	= register_cvar( "up_resetscore_display",	"1" );
	g_pcvarAdminCheck		= register_cvar( "up_admincheck",		"1" );
	g_pcvarBulletDamage		= register_cvar( "up_abd",			"1" );
	g_pcvarBulletDamageWall		= register_cvar( "up_abd_walls",		"1" );
	g_pcvarRefund			= register_cvar( "up_money",			"1" );
	g_pcvarRefundValue		= register_cvar( "up_money_amount",		"16000" );
	g_pcvarAutoRestart		= register_cvar( "up_autorr",			"0" );
	g_pcvarAutoRestartTime		= register_cvar( "up_autorr_delay",		"45" );
	g_pcvarAutoRestartKnife		= register_cvar( "up_autorr_knife",		"1" );
	g_pcvarAdminListen		= register_cvar( "up_adminlisten",		"1" );
	g_pcvarAdminListenTeam		= register_cvar( "up_adminlisten_team",		"1" );
	g_pcvarDeadListen		= register_cvar( "up_deadlisten",		"1" );
	g_pcvarDeadListenTeam		= register_cvar( "up_deadlisten_team",		"0" );
	g_pcvarAFK			= register_cvar( "up_afk",			"1" );
	g_pcvarAFKTime			= register_cvar( "up_afk_time",			"60" );
	g_pcvarAFKPunishment		= register_cvar( "up_afk_punishment",		"1" );
	g_pcvarAFKSpectators		= register_cvar( "up_afk_spectators",		"1" );
	g_pcvarAFKSpectatorsTime	= register_cvar( "up_afk_spectators_time",	"120" );
	g_pcvarAFKBombTransfer		= register_cvar( "up_afk_bombtransfer",		"1" );
	g_pcvarAFKBombTransfer_Time	= register_cvar( "up_afk_bombtransfer_time",	"7" );
	g_pcvarC4Timer			= register_cvar( "up_c4timer",			"1" );
	g_pcvarMaxExtendTime		= register_cvar( "up_extend_max",		"15" );
	g_pcvarAllowSpec		= register_cvar( "up_speccommand",		"1" );
	g_pcvarGagTime			= register_cvar( "up_gag_time",			"10" );
	g_pcvarGagFlags			= register_cvar( "up_gag_flags",		"abc" );
	g_pcvarGagName			= register_cvar( "up_gag_blocknamchange",	"1" );
	g_pcvarPluginPrefix		= register_cvar( "up_plugin_prefix",		"[UP]" );
	g_pcvarPluginAdvertisement	= register_cvar( "up_advertisement",		"10" );
	g_pcvarConnectDisconnectMessage	= register_cvar( "up_joinleave_announcements",	"0" );
	g_pcvarConnectMessage		= register_cvar( "up_connect_message", 		"%name% has joined!\nEnjoy the Server!\nCurrent Ranking is %rankpos%" );
	g_pcvarLeaveMessage		= register_cvar( "up_leave_message",		"%name% has left!\nHope to see you back sometime." );
	g_pcvarSpawnProtection		= register_cvar( "up_sp",			"0" );
	g_pcvarSpawnProtectionGlow	= register_cvar( "up_sp_glow",			"1" );
	
	/* Cvar Pointers */
	g_cvarShowActivity		= get_cvar_pointer( "amx_show_activity" );
	g_cvarC4Timer			= get_cvar_pointer( "mp_c4timer" );
	g_cvarTimeLimit			= get_cvar_pointer( "mp_timelimit" );
	g_cvarGravity			= get_cvar_pointer( "sv_gravity" );
	g_cvarPassword			= get_cvar_pointer( "sv_password" );
	g_cvarAllTalk			= get_cvar_pointer( "sv_alltalk" );
	g_cvarHostname			= get_cvar_pointer( "hostname" );
	
	/* Config Execution */
	ExecConfig( );
	
	/* Load Cvars for the first time */
	ReloadCvars( );
	
	/* Hud Sync */
	g_hudSync1			= CreateHudSyncObj( );
	g_hudSync2			= CreateHudSyncObj( );
	g_hudSync3			= CreateHudSyncObj( );
	g_hudSync4			= CreateHudSyncObj( );
	g_hudSync5			= CreateHudSyncObj( );
	g_hudSync6			= CreateHudSyncObj( );
	
	/* Message IDs */
	g_msgScoreInfo			= get_user_msgid( "ScoreInfo" );
	g_msgDamage			= get_user_msgid( "Damage" );
	g_msgShowTimer			= get_user_msgid( "ShowTimer" );
	g_msgRoundTime			= get_user_msgid( "RoundTime" );
	g_msgScenario			= get_user_msgid( "Scenario" );
	g_msgSetFOV			= get_user_msgid( "SetFOV" );
	g_msgTeamInfo			= get_user_msgid( "TeamInfo" );
	g_msgSayText			= get_user_msgid( "SayText" );
	
	/* Client Commands */ 
	register_clcmd( "say",			"ClCmd_SayHandler" );
	register_clcmd( "say_team",		"ClCmd_SayTeamHandler" );
	
	register_clcmd( "say /rs",		"ClCmd_ResetScore" );
	register_clcmd( "say /resetscore",	"ClCmd_ResetScore" );
	register_clcmd( "say /admin",		"ClCmd_AdminCheck" );
	register_clcmd( "say /admins",		"ClCmd_AdminCheck" );
	register_clcmd( "say /spec",		"ClCmd_Spectator" );
	register_clcmd( "say /unspec",		"ClCmd_UnSpectator" );
	register_clcmd( "say /alltalk",		"ClCmd_AllTalk" );
	register_clcmd( "say /version",		"ClCmd_Version" );
	register_clcmd( "say /mute",		"ClCmd_MuteMenu" );
	register_clcmd( "say /randmusic",	"ClCmd_LoadingMusic" );
	register_clcmd( "say /stopmusic",	"ClCmd_StopMusic" );
	
	register_clcmd( "say_team /rs",		"ClCmd_ResetScore" );
	register_clcmd( "say_team /resetscore",	"ClCmd_ResetScore" );
	register_clcmd( "say_team /admin",	"ClCmd_AdminCheck" );
	register_clcmd( "say_team /admins",	"ClCmd_AdminCheck" );
	register_clcmd( "say_team /spec",	"ClCmd_Spectator" );
	register_clcmd( "say_team /unspec",	"ClCmd_UnSpectator" );
	register_clcmd( "say_team /alltalk",	"ClCmd_AllTalk" );
	register_clcmd( "say_team /version",	"ClCmd_Version" );
	register_clcmd( "say_team /mute",	"ClCmd_MuteMenu" );
	register_clcmd( "say_team /randmusic",	"ClCmd_LoadingMusic" );
	register_clcmd( "say_team /stopmusic",	"ClCmd_StopMusic" );
	
	register_clcmd( "jointeam",		"ClCmd_JoinTeam" );
	register_clcmd( "joinclass",		"ClCmd_JoinClass" );
	register_clcmd( "menuselect", 		"ClCmd_JoinClass" );
	
	/* Console Commands */ 
	/* ADMIN_LEVEL_A (fun) */
	register_concmd( "amx_heal",		"ConCmd_Health",		ADMIN_LEVEL_A,		"<nick | #userid | authid | @> <#hp>" );
	register_concmd( "amx_hp",		"ConCmd_Health",		ADMIN_LEVEL_A,		"<nick | #userid | authid | @> <#hp>" );
	register_concmd( "amx_armor",		"ConCmd_Armor",			ADMIN_LEVEL_A,		"<nick | #userid | authid | @> <#ap>" );
	register_concmd( "amx_ap",		"ConCmd_Armor",			ADMIN_LEVEL_A,		"<nick | #userid | authid | @> <#ap>" );
	register_concmd( "amx_unammo",		"ConCmd_Ammo",			ADMIN_LEVEL_A,		"<nick | #userid | authid | @> [0 | 1] - 0:Off | 1:On" );
	register_concmd( "amx_unammobp",	"ConCmd_Ammo",			ADMIN_LEVEL_A,		"<nick | #userid | authid | @> [0 | 1] - 0:Off | 1:On" );
	register_concmd( "amx_score",		"ConCmd_Score",			ADMIN_LEVEL_A,		"<nick | #userid | authid | @> <#frags> <#deaths>" );
	register_concmd( "amx_revive",		"ConCmd_Revive",		ADMIN_LEVEL_A,		"<nick | #userid | authid | @> [#health] [#armor]" );
	register_concmd( "amx_noclip",		"ConCmd_NoclipGodmode",		ADMIN_LEVEL_A,		"<nick | #userid | authid | @> [0 | 1 | 2] - 0:Off | 1:On | 2:On + Every Round" );
	register_concmd( "amx_godmode",		"ConCmd_NoclipGodmode",		ADMIN_LEVEL_A,		"<nick | #userid | authid | @> [0 | 1 | 2] - 0:Off | 1:On | 2:On + Every Round" );
	register_concmd( "amx_teleport",	"ConCmd_Teleport",		ADMIN_LEVEL_A,		"<nick | #userid | authid | @> [x] [y] [z]" );
	register_concmd( "amx_userorigin",	"ConCmd_UserOrigin",		ADMIN_LEVEL_A,		"<nick | #userid | authid | @>" );
	register_concmd( "amx_speed",		"ConCmd_Speed",			ADMIN_LEVEL_A,		"<nick | #userid | authid | @> [0 | 1] - 0:Off | 1:On" );
	register_concmd( "amx_drug",		"ConCmd_Drug",			ADMIN_LEVEL_A,		"<nick | #userid | authid | @>" );
	register_concmd( "amx_weapon",		"ConCmd_Weapon",		ADMIN_LEVEL_A,		"<nick | #userid | authid | @> <weaponname | weaponid> [ammo]" );
	/* ADMIN_LEVEL_B (punishements) */
	register_concmd( "amx_blanks",		"ConCmd_BlanksNobuy",		ADMIN_LEVEL_B,		"<nick | #userid | authid | @> [0 | 1] - 0:Off | 1:On" );
	register_concmd( "amx_nobuy",		"ConCmd_BlanksNobuy",		ADMIN_LEVEL_B,		"<nick | #userid | authid | @> [0 | 1] - 0:Off | 1:On" );
	register_concmd( "amx_bury",		"ConCmd_Un_Bury",		ADMIN_LEVEL_B,		"<nick | #userid | authid | @>" );
	register_concmd( "amx_unbury",		"ConCmd_Un_Bury",		ADMIN_LEVEL_B,		"<nick | #userid | authid | @>" );
	register_concmd( "amx_disarm",		"ConCmd_Disarm",		ADMIN_LEVEL_B,		"<nick | #userid | authid | @>" );
	register_concmd( "amx_uberslap",	"ConCmd_UberslapFire",		ADMIN_LEVEL_B,		"<nick | #userid | authid | @>" );
	register_concmd( "amx_fire",		"ConCmd_UberslapFire",		ADMIN_LEVEL_B,		"<nick | #userid | authid | @>" );
	register_concmd( "amx_autoslay",	"ConCmd_AutoSlay",		ADMIN_LEVEL_B,		"<nick | #userid | authid | @> [0 | 1] - 0:Off | 1:On" );
	register_concmd( "amx_rocket",		"ConCmd_Rocket",		ADMIN_LEVEL_B,		"<nick | #userid | authid | @>" );
	register_concmd( "amx_badaim",		"ConCmd_BadAim",		ADMIN_LEVEL_B,		"<nick | #userid | authid | @> [0 | 1 | #seconds]" );
	register_concmd( "amx_slay2",		"ConCmd_Slay2",			ADMIN_LEVEL_B,		"<nick | #userid | authid | @> [0 | 1 | 2] - 0:Lightning | 1:Blood | 2:Explode" );
	register_concmd( "amx_gag",		"ConCmd_Un_Gag",		ADMIN_LEVEL_B,		"<nick | #userid | authid> [a | b | c] [#time] [reason]" );
	register_concmd( "amx_ungag",		"ConCmd_Un_Gag",		ADMIN_LEVEL_B,		"<nick | #userid | authid>" );
	/* ADMIN_LEVEL_C (others) */
	register_concmd( "amx_pgravity",	"ConCmd_PGravity",		ADMIN_LEVEL_C,		"<nick | #userid | authid | @> [#gravity]" );
	register_concmd( "amx_pass",		"ConCmd_Pass",			ADMIN_LEVEL_C,		"<password>" );
	register_concmd( "amx_nopass",		"ConCmd_NoPass",		ADMIN_LEVEL_C,		" - Removes the password" );
	register_concmd( "amx_ip",		"ConCmd_IP",			ADMIN_LEVEL_C,		"[nick | #userid | authid | @]" );
	register_concmd( "amx_transfer",	"ConCmd_Transfer",		ADMIN_LEVEL_C,		"<nick | #userid | authid | @> [t | ct | spec]" );
	register_concmd( "amx_swap",		"ConCmd_Swap",			ADMIN_LEVEL_C,		"<nick | #userid | authid> <nick | #userid | authid>" );
	register_concmd( "amx_swapteams",	"ConCmd_SwapTeams",		ADMIN_LEVEL_C,		"- Swaps the two teams together" );
	register_concmd( "amx_glow",		"ConCmd_Glow",			ADMIN_LEVEL_C,		"<nick | #userid | authid | @> [#r] [#g] [#b] [#a]" );
	register_concmd( "amx_glow2",		"ConCmd_Glow",			ADMIN_LEVEL_C,		"<nick | #userid | authid | @> [#r] [#g] [#b] [#a] - Permanent Glow" );
	/* ADMIN_LEVEL_D (affects everybody) */
	register_concmd( "amx_hsonly",		"ConCmd_HSOnly",		ADMIN_LEVEL_D,		"[0 | 1] - 0:Off | 1:On" );
	register_concmd( "amx_extend",		"ConCmd_Extend",		ADMIN_LEVEL_D,		"<#minutes>" );
	register_concmd( "amx_lock",		"ConCmd_Un_Lock",		ADMIN_LEVEL_D,		"[CT | T | AUTO | SPEC]" );
	register_concmd( "amx_unlock",		"ConCmd_Un_Lock",		ADMIN_LEVEL_D,		"[CT | T | AUTO | SPEC]" );
	register_concmd( "amx_gravity",		"ConCmd_Gravity",		ADMIN_LEVEL_D,		"[#gravity]" );
	
	/* Other Console Commands */
	register_concmd( "amx_reloadcvars",	"ConCmd_ReloadCvars",		ADMIN_CVAR,		" - Reloads all the cvars of the plugin" );
	register_concmd( "amx_restart",		"ConCmd_RestartServer",		ADMIN_RCON,		"<timer> - Min:0 | Max:60 | Cancel:-1" );
	register_concmd( "amx_shutdown",	"ConCmd_ShutdownServer",	ADMIN_RCON,		"<timer> - Min:0 | Max:60 | Cancel:-1" );
	register_concmd( "amx_search",		"ConCmd_SearchCommands",	ADMIN_MENU,		"<command>" );
	
	#if defined GREEN_CHAT
	register_concmd( "amx_say",		"ConCmd_Say",			ADMIN_CHAT,		"<message>" );
	register_concmd( "amx_psay",		"ConCmd_Psay",			ADMIN_CHAT,		"#<name | #userid | authid> <message>" );
	register_concmd( "amx_chat",		"ConCmd_Chat",			ADMIN_CHAT,		"<message>" );
	#endif
	
	/* Ham Hooks */ 
	RegisterHam( Ham_Spawn,		"player",		"Ham_Spawn_Player_Post",		true );
	RegisterHam( Ham_Killed,	"player",		"Ham_Killed_Player_Post",		true );
	RegisterHam( Ham_TakeDamage,	"player",		"Ham_TakeDamage_Player_Pre",		false );

	/* Events */ 
	register_event( "CurWeapon",		"Event_CurWeapon",		"be", "1=1" );
	register_event( "Damage",		"Event_Damage",			"b", "2!0", "3=0", "4!0" );
	register_event( "SayText",		"Event_SayText_Team",		"b", "2=#Cstrike_Chat_CT" );
	register_event( "SayText",		"Event_SayText_Team",		"b", "2=#Cstrike_Chat_T" );
	register_event( "SayText",		"Event_SayText_Team",		"b", "2=#Cstrike_Chat_CT_Dead" );
	register_event( "SayText",		"Event_SayText_Team",		"b", "2=#Cstrike_Chat_T_Dead" );
	register_event( "SayText",		"Event_SayText_Team",		"b", "2=#Cstrike_Chat_Spec" );
	register_event( "SayText",		"Event_SayText",		"b", "2&#Cstrike_Chat_All" );
	register_event( "WeapPickup",		"Event_WeapPickup",		"be", "1=6" );
	register_event( "BarTime",		"Event_BarTime",		"be" );
	register_event( "TextMsg",		"Event_TextMsg",		"bc", "2=#Game_bomb_drop" );
	register_event( "TextMsg",		"Event_TextMsg",		"a", "2=#Bomb_Planted" );
	register_event( "HLTV",			"Event_HLTV",			"a", "1=0", "2=0" );
	
	/* LogEvents */ 
	register_logevent( "LogEvent_RoundStart",	2,	"1=Round_Start" );
	register_logevent( "LogEvent_BombPlanted",	3,	"2=Planted_The_Bomb" );
	
	/* Menus */
	register_menucmd( register_menuid( "Team_Select", 1 ), MENU_KEY_1 | MENU_KEY_2 | MENU_KEY_5 | MENU_KEY_6, "Menu_TeamSelect" );
	
	/* Forwards */
	register_forward( FM_Voice_SetClientListening,		"Forward_SetClientListening",		0 );
	
	/* Messages */
	register_message( get_user_msgid( "SayText" ),		"Message_SayText" );
	register_message( get_user_msgid( "StatusIcon" ),	"Message_StatusIcon" );
	
	/* Tasks */
	set_task( float( AFK_FREQUENCY ), 		"Task_AFK_Check",	TASK_AFK_CHECK,		_, _, "b" );
	set_task( float( AFK_FREQUENCY ), 		"Task_AFK_BombCheck",	TASK_AFK_BOMBCHECK,	_, _, "b" );
	if( g_iAdvertisement ) {
		set_task( floatclamp( float( g_iAdvertisement * 60 ), 60.0, 1800.0 ), 	"Task_Advertisement",	TASK_AD,		_, _, "b" );
	}
}

public plugin_natives( ) {
	register_library( "API_UltimatePlugin" );
	
	register_native( "up_get_user_unammo",		"API_GetUserUnAmmo" );
	register_native( "up_get_user_unammobp",	"API_GetUserUnAmmoBP" );
	register_native( "up_get_user_speed",		"API_GetUserSpeed" );
	register_native( "up_get_user_blanks",		"API_GetUserBlanks" );
	register_native( "up_get_user_nobuy",		"API_GetUserNoBuy" );
	register_native( "up_get_user_fire",		"API_GetUserFire" );
	register_native( "up_get_user_autoslay",	"API_GetUserAutoSlay" );
	register_native( "up_get_user_badaim",		"API_GetUserBadAim" );
	register_native( "up_get_user_gag",		"API_GetUserGag" );
	register_native( "up_get_user_afk",		"API_GetUserAFK" );
	register_native( "up_get_user_mute",		"API_GetUserMute" );
	register_native( "up_get_hsonly",		"API_GetHSOnly" );
	
	register_native( "up_set_user_unammo",		"API_SetUserUnAmmo" );
	register_native( "up_set_user_unammobp",	"API_SetUserUnAmmoBP" );
	register_native( "up_set_user_score",		"API_SetUserScore" );
	register_native( "up_set_user_speed",		"API_SetUserSpeed" );
	register_native( "up_set_user_blanks",		"API_SetUserBlanks" );
	register_native( "up_set_user_nobuy",		"API_SetUserNoBuy" );
	register_native( "up_set_user_fire",		"API_SetUserFire" );
	register_native( "up_set_user_autoslay",	"API_SetUserAutoSlay" );
	register_native( "up_set_user_badaim",		"API_SetUserBadAim" );
	register_native( "up_set_user_gag",		"API_SetUserGag" );
	register_native( "up_set_hsonly",		"API_SetHSOnly" );
	
	register_native( "up_user_revive",		"API_RevivePlayer" );
	register_native( "up_user_drug",		"API_DrugPlayer" );
	register_native( "up_user_bury",		"API_BuryPlayer" );
	register_native( "up_user_unbury",		"API_UnBuryPlayer" );
	register_native( "up_user_disarm",		"API_DisarmPlayer" );
	register_native( "up_user_uberslap",		"API_UberSlapPlayer" );
	register_native( "up_user_rocket",		"API_RocketPlayer" );
	register_native( "up_user_slay2",		"API_Slay2Player" );
	register_native( "up_lock_team",		"API_LockTeam" );
	register_native( "up_unlock_team",		"API_UnLockTeam" );
}

public plugin_cfg( ) {
	VersionCheckerSocket( );
}

public plugin_precache( ) {
	/* Sounds */
	for( new iLoop = 0; iLoop < SOUND_MAX; iLoop++ ) {
		precache_sound( g_strSounds[ iLoop ] );
	}
	
	/* Sprites */
	for( new iLoop = 0; iLoop < SPRITE_MAX; iLoop++ ) {
		g_iSprites[ iLoop ] = precache_model( g_strSprites[ iLoop ] );
	}
}

/* Client Natives */
public client_connect( iPlayerID ) {
	SetBit( g_bitIsConnected,	iPlayerID );
	
	ClearBit( g_bitIsOnFire,	iPlayerID );
	ClearBit( g_bitIsFirstSong,	iPlayerID );
	ClearBit( g_bitHasUnAmmo,	iPlayerID );
	ClearBit( g_bitHasUnBPAmmo,	iPlayerID );
	ClearBit( g_bitHasGodmode,	iPlayerID );
	ClearBit( g_bitHasNoClip,	iPlayerID );
	ClearBit( g_bitHasNoBuy,	iPlayerID );
	ClearBit( g_bitHasAutoSlay,	iPlayerID );
	ClearBit( g_bitHasBadaim,	iPlayerID );
	ClearBit( g_bitHasSpeed,	iPlayerID );
	ClearBit( g_bitHasSP,		iPlayerID );
	ClearBit( g_bitHasBlanks,	iPlayerID );
	
	g_bitIsMuted[ iPlayerID ] = 0;
	g_iPlayerTeam[ iPlayerID ] = CS_TEAM_UNASSIGNED;
	g_iPlayerTime[ iPlayerID ] = 0;
	
	message_begin( MSG_ALL, g_msgTeamInfo );
	write_byte( iPlayerID );
	write_string( "SPECTATOR" );
	message_end( );
	
	RandomMusic( iPlayerID );
}

public client_disconnect( iPlayerID ) {
	ClearBit( g_bitIsConnected,     iPlayerID );
	ClearBit( g_bitIsAlive,         iPlayerID );
	
	if( g_iPlayerGagFlags[ iPlayerID ] ) {
		if( task_exists( TASK_UNGAG + iPlayerID ) ) {
			remove_task( TASK_UNGAG + iPlayerID );
		}
		
		g_iPlayerGagFlags[ iPlayerID ] = 0;
	}
	
	static strPlayerAuthID[ 36 ], strPlayerName[ 32 ], strPlayerIP[ 16 ];
	get_user_name( iPlayerID, strPlayerName, 31 );
	get_user_ip( iPlayerID, strPlayerIP, 15, 1 );
	get_user_authid( iPlayerID, strPlayerAuthID, 35 );
	
	static iPlayers[ 32 ], iNum, iTempID, iLoop;
	get_players( iPlayers, iNum );
	
	if( !iNum ) {
		if( task_exists( TASK_AFK_CHECK ) ) {
			remove_task( TASK_AFK_CHECK );
		}
		
		if( task_exists( TASK_AFK_BOMBCHECK ) ) {
			remove_task( TASK_AFK_BOMBCHECK );
		}
		
		return PLUGIN_CONTINUE;
	}
	
	for( iLoop = 0; iLoop < iNum; iLoop++ ) {
		iTempID = iPlayers[ iLoop ];
		
		if( g_iPlayerGagFlags[ iPlayerID ] && access( iTempID, ADMIN_LEVEL_B ) ) {
			client_print_color( iTempID, iTempID, "^4%s^1 %L", iTempID, "GAGGED_DISCONNECTED", g_strPluginPrefix, strPlayerName, strPlayerAuthID, strPlayerIP );
		}
	}
	
	switch( g_iJoinleaveAnnouncements ) {
		case 1: PlayerDisconnected( strPlayerName );
		case 2: PlayerDisconnected_HUD( strPlayerName, strPlayerAuthID, strPlayerIP );
	}
	
	return PLUGIN_CONTINUE;
}

public client_authorized( iPlayerID ) {
	if( !task_exists( TASK_AFK_CHECK ) ) {
		set_task( float( AFK_FREQUENCY ), "Task_AFK_Check",	TASK_AFK_CHECK,		_, _, "b" );
	}
	
	if( !task_exists( TASK_AFK_BOMBCHECK ) ) {
		set_task( float( AFK_FREQUENCY ), "Task_AFK_BombCheck",	TASK_AFK_BOMBCHECK,	_, _, "b" );
	}
}

public client_putinserver( iPlayerID ) {
	if( !g_iJoinleaveAnnouncements ) {
		return PLUGIN_CONTINUE;
	}
	
	switch( g_iJoinleaveAnnouncements ) {
		case 1:		set_task( 2.0, "Task_PlayerPutInServer", TASK_PUTINSERVER + iPlayerID );
		case 2:		set_task( 2.0, "Task_PlayerPutInServer_HUD", TASK_PUTINSERVER_HUD + iPlayerID );
	}
	
	return PLUGIN_CONTINUE;
}

public client_PreThink( iPlayerID ) {
	if( CheckBit( g_bitHasBadaim, iPlayerID ) && CheckBit( g_bitIsAlive, iPlayerID ) ) {
		static Float:fVector[ 3 ] = { 100.0, 100.0, 100.0 };
		static iLoop;
		
		for( iLoop = 0; iLoop < 6; iLoop++ ) {
			entity_set_vector( iPlayerID, EV_VEC_punchangle, fVector );
			entity_set_vector( iPlayerID, EV_VEC_punchangle, fVector );
			entity_set_vector( iPlayerID, EV_VEC_punchangle, fVector );
		}
	}
}

public client_infochanged( iPlayerID ) {
	if( CheckBit( g_bitCvarStatus, CVAR_GAG_NAME ) && g_iPlayerGagFlags[ iPlayerID ] ) {
		new strNewName[ 32 ], strOldName[ 32 ];
		get_user_info( iPlayerID, "name", strNewName, 31 );
		get_user_name( iPlayerID, strOldName, 31 );
		
		if( !equal( strOldName, strNewName ) ) {
			new Float:fTimeLeft = g_fPlayerGagEnd[ iPlayerID ] - get_gametime( );
			client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "GAGGED_NAMECHANGE", floatround( fTimeLeft ), g_strGagReason[ iPlayerID ] );
			
			set_user_info( iPlayerID, "name", strOldName );
		}
	}
}

public client_command( iPlayerID ) {
	if( !access( iPlayerID, ADMIN_CVAR ) ) {
		return PLUGIN_CONTINUE;
	}
	
	static iArgumentCount;
	iArgumentCount = read_argc( );
	
	static strArguments[ 2 ][ 64 ], iLoop;
	
	for( iLoop = 0; iLoop < iArgumentCount; iLoop++ ) {
		read_argv( iLoop, strArguments[ iLoop ], 63 );
		
		if( iLoop == 0 ) {
			if( !cvar_exists( strArguments[ 0 ] ) ) {
				return PLUGIN_CONTINUE;
			}
		}
	}
	
	if( iArgumentCount == 1 ) {
		static strValue[ 64 ];
		
		get_cvar_string( strArguments[ 0 ], strValue, 63 );
		console_print( iPlayerID, "%s %s: %s", g_strPluginPrefix, strArguments[ 0 ], strValue );
	} else if( iArgumentCount == 2 ) {
		set_cvar_string( strArguments[ 0 ], strArguments[ 1 ] );
		console_print( iPlayerID, "%s %s changed to %s", g_strPluginPrefix, strArguments[ 0 ], strArguments[ 1 ] );
		
		new strAdminName[ 32 ], strAdminAuthID[ 36 ];
		get_user_name( iPlayerID, strAdminName, 31 );
		get_user_authid( iPlayerID, strAdminAuthID, 35 );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "ADMIN_CVAR_CHANGE", strArguments[ 0 ], strArguments[ 1 ] );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "ADMIN_CVAR_CHANGE", strArguments[ 0 ], strArguments[ 1 ] );
		}
		
		log_amx( "Admin %s (%s) changed cvar %s to %s.", strAdminName, strAdminAuthID, strArguments[ 0 ], strArguments[ 1 ] );
	}
	
	return PLUGIN_HANDLED;
}

/* Server Natives */
public server_changelevel( strMap[ ] ) {
	/*
		This is so that after the map change, the time limit returns
		to what it was before the admin extended the map.
	*/
	set_pcvar_float( g_cvarTimeLimit, get_pcvar_float( g_cvarTimeLimit ) - g_iTotalExtendTime );
}

/* Client Commands */
public ClCmd_ResetScore( iPlayerID ) {
	if( !CheckBit( g_bitCvarStatus, CVAR_RESETSCORE ) ) {
		client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "OPTION_DISABLED" );
		
		return PLUGIN_HANDLED;
	}
	
	if( !get_user_deaths( iPlayerID ) && !get_user_frags( iPlayerID ) ) {
		client_print_color( iPlayerID, iPlayerID, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "SCORE_ALREADY_RESET" );
		
		return PLUGIN_HANDLED;
	}
	
	set_user_frags( iPlayerID, 0 );
	cs_set_user_deaths( iPlayerID, 0 );
	
	UpdateScore( iPlayerID, 0, 0 );
	
	new strPlayerName[ 32 ];
	get_user_name( iPlayerID, strPlayerName, 31 );
	
	if( !CheckBit( g_bitCvarStatus, CVAR_RESETSCORE_DISPLAY ) ) {
		new iPlayers[ 32 ], iNum, iTempID;
		get_players( iPlayers, iNum );
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( iTempID != iPlayerID && is_user_admin( iTempID ) ) {
				client_print_color( iTempID, iTempID, "^4%s^1 %L", g_strPluginPrefix, iTempID, "SCORE_ADMINS", strPlayerName );
			}
		}
		
		client_print_color( iPlayerID, print_team_default, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "SCORE_RESET" );
	} else {
		client_print_color( iPlayerID, iPlayerID, "^4%s^1 %L", g_strPluginPrefix, LANG_PLAYER, "SCORE_GLOBAL", strPlayerName );
	}
	
	return PLUGIN_HANDLED;
}

public ClCmd_AdminCheck( iPlayerID ) {
	if( !CheckBit( g_bitCvarStatus, CVAR_ADMINCHECK ) && !is_user_admin( iPlayerID ) ) {
		client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "OPTION_DISABLED" );
		
		return PLUGIN_HANDLED;
	}
	
	new strAdminName[ 32 ], strAllAdmins[ 193 ], iLen;
	new iPlayers[ 32 ], iNum, iTempID;
	get_players( iPlayers, iNum );
	
	iLen = formatex( strAllAdmins, 192, "^4%s ^1%L ", g_strPluginPrefix, iPlayerID, "ONLINE_ADMINS" );
	
	/*
		Adding the names of all online admins to the message,
		whitch after we are done adding, is gonna be printed to
		the player.
	*/
	for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
		iTempID = iPlayers[ iLoop ];
		
		if( is_user_admin( iTempID ) ) {
			get_user_name( iTempID, strAdminName, 31 );
			
			iLen += formatex( strAllAdmins[ iLen ], 192 - iLen, "^4%s^1, ", strAdminName );
		}
	}
	
	/*
		Here I am removing the nasty looking comma at the end
		of the names and replacing it with a dot. Witch is better.
	*/
	strAllAdmins[ iLen - 2 ] = '.';
	
	client_print_color( iPlayerID, print_team_default, "%s", strAllAdmins );
	
	return PLUGIN_HANDLED;
}

public ClCmd_Spectator( iPlayerID ) {
	if( !CheckBit( g_bitCvarStatus, CVAR_SPEC ) ) {
		client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "OPTION_DISABLED" );
		
		return PLUGIN_HANDLED;
	}
	
	new CsTeams:iTeam = cs_get_user_team( iPlayerID );
	
	switch( iTeam ) {
		case CS_TEAM_CT, CS_TEAM_T: {
			if( CheckBit( g_bitIsAlive, iPlayerID ) ) {
				user_kill( iPlayerID, 1 );
				cs_set_user_deaths( iPlayerID, cs_get_user_deaths( iPlayerID ) - 1 );
			}
			
			g_iPlayerTeam[ iPlayerID ] = iTeam;
			cs_set_user_team( iPlayerID, CS_TEAM_SPECTATOR );
			
			new strPlayerName[ 32 ];
			get_user_name( iPlayerID, strPlayerName, 31 );
			
			client_print_color( 0, iPlayerID, "^4%s^1 %L", g_strPluginPrefix, LANG_PLAYER, "SPEC_SELF1", strPlayerName );
			client_print_color( iPlayerID, print_team_default, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "SPEC_SELF2" );
		}
	}
	
	return PLUGIN_CONTINUE;
}

public ClCmd_UnSpectator( iPlayerID ) {
	if( !CheckBit( g_bitCvarStatus, CVAR_SPEC ) ) {
		client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "OPTION_DISABLED" );
		
		return PLUGIN_HANDLED;
	}
	
	switch( cs_get_user_team( iPlayerID ) ) {
		case CS_TEAM_SPECTATOR: {
			new CsTeams:iTeam = g_iPlayerTeam[ iPlayerID ];
			
			if( iTeam == CS_TEAM_UNASSIGNED ) {
				client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "SPEC_CANNOT_BEFORE" );
				
				return PLUGIN_HANDLED;
			}
			
			cs_set_user_team( iPlayerID, iTeam );
			
			new strPlayerName[ 32 ];
			get_user_name( iPlayerID, strPlayerName, 31 );
			
			client_print_color( 0, iPlayerID, "^4%s^1 %L", g_strPluginPrefix, LANG_PLAYER, "SPEC_BACK", strPlayerName, ( iTeam == CS_TEAM_CT ) ? "^4Counter-Terrorist^1" : "^4Terrorist^1" );
		}
		
		default: {
			client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "ERROR_NOT_IN_SPEC" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	return PLUGIN_CONTINUE;
}

public ClCmd_AllTalk( iPlayerID ) {
	client_print_color( 0, print_team_default, "^4%s^1 %L %i", g_strPluginPrefix, LANG_PLAYER, "CURRENT_ALLTALK", get_pcvar_num( g_cvarAllTalk ) );
}

public ClCmd_Version( iPlayerID ) {
	Task_Advertisement( TASK_AD );
}

public ClCmd_JoinTeam( iPlayerID ) {
	static strTeam[ 2 ], iTeam;
	read_argv( 1, strTeam, 1 );
	iTeam = str_to_num( strTeam ) - 1;
	
	if( g_bBlockTeamJoin[ iTeam ] && CheckBit( g_bitIsConnected, iPlayerID ) ) {
		engclient_cmd( iPlayerID, "chooseteam" );
		
		return PLUGIN_HANDLED;
	}
	
	g_iPlayerTime[ iPlayerID ] = 0;
	
	return PLUGIN_CONTINUE;
}

public ClCmd_JoinClass( iPlayerID ) {
	if( cs_get_user_menu( iPlayerID ) == T_CT_MENU && cs_get_user_team( iPlayerID ) == CS_TEAM_SPECTATOR ) {
		return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}

public ClCmd_SayHandler( iPlayerID ) {
	static strTemp[ 128 ];
	read_argv( 1, strTemp, 127 );
	
	if( strTemp[ 0 ] == '/' ) {
		if( strTemp[ 1 ] == '^0' ) {
			if( g_iCommandCount ) {
				DisplayRecentelyUsed( iPlayerID );
			} else {
				client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "ERROR_NONE_SAVED" );
			}
			
			return PLUGIN_HANDLED;
		} else {
			new strMessage[ 192 ];
			read_args( strMessage, 191 );
			remove_quotes( strMessage );
			
			new iFlags = get_user_flags( iPlayerID );
			
			if( iFlags > 0 && !( iFlags & ADMIN_USER ) ) {
				iFlags |= ADMIN_ADMIN;
			}
			
			new iCommandsNum = get_concmdsnum( iFlags, iPlayerID );
			
			static strInfo[ 128 ], strCommand[ 32 ], iCommandFlags;
			
			format( strMessage, 127, "amx_%s", strMessage[ 1 ] );
			
			static strLeft[ 32 ], strRight[ 2 ];
			strtok( strMessage, strLeft, 31, strRight, 1, ' ', 1 );
			
			for( new iLoop = 0; iLoop < iCommandsNum; iLoop++ ) {
				get_concmd( iLoop, strCommand, 31, iCommandFlags, strInfo, 127, iFlags, iPlayerID );
				
				if( equal( strLeft, strCommand ) ) {
					client_cmd( iPlayerID, strMessage );
					
					if( g_iCommandCount >= MAX_COMMANDS ) {
						g_iCommandCount = 0;
					}
					
					formatex( g_strPlayerCommand[ g_iCommandCount ], 63, "%s", strMessage );
					g_iCommandCount++;
					
					return PLUGIN_HANDLED;
				}
			}
		}
	}
	
	if( g_iPlayerGagFlags[ iPlayerID ] & GAG_CHAT ) {
		new Float:fTimeLeft = g_fPlayerGagEnd[ iPlayerID ] - get_gametime( );
		client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "GAGGED_SAY_HANDLER", floatround( fTimeLeft ), g_strGagReason[ iPlayerID ] );
		
		client_cmd( iPlayerID, "spk barney/youtalkmuch" );
		
		return PLUGIN_HANDLED;
	}
	
	#if defined GREEN_CHAT	
	if( access( iPlayerID, ADMIN_CHAT ) ) {
		if( strTemp[ 0 ] == '#' ) {
			new strMessage[ 192 ];
			read_args( strMessage, 191 );
			remove_quotes( strMessage );
			
			new iSenderID, iStartPosition = 2;
			
			switch( strTemp[ 1 ] ) {
				case 'r':	iSenderID = print_team_red;
				case 'b':	iSenderID = print_team_blue;
				case 'g':	iSenderID = print_team_grey;
				
				default: {
					iSenderID = iPlayerID;
					iStartPosition = 1;
				}
			}
			
			while( strMessage[ iStartPosition ] && strMessage[ iStartPosition ] == ' ' ) {
				iStartPosition++;
			}
			
			new strAdminName[ 32 ], strAdminAuthID[ 36 ];
			get_user_name( iPlayerID, strAdminName, 31 );
			get_user_authid( iPlayerID, strAdminAuthID, 35 );
			
			client_print_color( 0, iSenderID, "^1(^4All^1) ^3%s^1 :   ^4%s", strAdminName, strMessage[ iStartPosition ] );
			
			log_amx( "AMX_CHAT - From: ^"%s (%s)^" - Message: ^"%s^"", strAdminName, strAdminAuthID, strMessage[ iStartPosition ] );
			
			return PLUGIN_HANDLED;
		}
	}
	#endif
	
	return PLUGIN_CONTINUE;
}

public ClCmd_SayTeamHandler( iPlayerID ) {
	static strTemp[ 128 ];
	read_argv( 1, strTemp, 127 );
	
	if( strTemp[ 0 ] == '/' ) {
		new iFlags = get_user_flags( iPlayerID );
		
		if( iFlags > 0 && !( iFlags & ADMIN_USER ) ) {
			iFlags |= ADMIN_ADMIN;
		}
		
		new iCommandsNum = get_concmdsnum( iFlags, iPlayerID );
		
		static strInfo[ 128 ], strCommand[ 32 ], iCommandFlags;
		
		format( strTemp, 127, "amx_%s", strTemp[ 1 ] );
		
		static strLeft[ 32 ], strRight[ 2 ];
		strtok( strTemp, strLeft, 31, strRight, 1, ' ', 1 );
		
		for( new iLoop = 0; iLoop < iCommandsNum; iLoop++ ) {
			get_concmd( iLoop, strCommand, 31, iCommandFlags, strInfo, 127, iFlags, iPlayerID );
			
			if( equal( strLeft, strCommand ) ) {
				client_cmd( iPlayerID, strTemp );
				
				return PLUGIN_HANDLED;
			}
		}
	}
	
	if( g_iPlayerGagFlags[ iPlayerID ] & GAG_TEAMCHAT ) {
		new Float:fTimeLeft = g_fPlayerGagEnd[ iPlayerID ] - get_gametime( );
		client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "GAGGED_SAYTEAM_HANDLER", floatround( fTimeLeft ), g_strGagReason[ iPlayerID ] );
		
		client_cmd( iPlayerID, "spk barney/youtalkmuch" );
		
		return PLUGIN_HANDLED;
	}
	
	#if defined GREEN_CHAT
	if( strTemp[ 0 ] == '@' ) {
		new strMessage[ 192 ];
		read_args( strMessage, 191 );
		remove_quotes( strMessage );
		
		new strPlayerName[ 32 ], strPlayerAuthID[ 36 ];
		get_user_name( iPlayerID, strPlayerName, 31 );
		get_user_authid( iPlayerID, strPlayerAuthID, 35 );
		
		log_amx( "AMX_CHAT - From: ^"%s (%s)^" - Message: ^"%s^"", strPlayerName, strPlayerAuthID, strMessage[ 1 ] );
		
		format( strMessage, 191, "^1(^4%s^1) ^3%s^1 :  %s", is_user_admin( iPlayerID ) ? "ADMIN" : "PLAYER", strPlayerName, strMessage[ 1 ] );
		
		new iPlayers[ 32 ], iNum, iTempID;
		get_players( iPlayers, iNum, "ch" );
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( iTempID != iPlayerID && access( iTempID, ADMIN_CHAT ) ) {
				client_print_color( iTempID, iPlayerID, "%s", strMessage );
			}
		}
		
		client_print_color( iPlayerID, iPlayerID, "%s", strMessage );
		
		return PLUGIN_HANDLED;
	}
	#endif
	
	return PLUGIN_CONTINUE;
}

public ClCmd_MuteMenu( iPlayerID ) {
	DisplayMuteMenu( iPlayerID );
}

public ClCmd_LoadingMusic( iPlayerID ) {
	if( CheckBit( g_bitIsFirstSong, iPlayerID ) ) {
		ClearBit( g_bitIsFirstSong, iPlayerID );
		
		new strPlayerName[ 32 ];
		get_user_name( iPlayerID, strPlayerName, 31 );
		
		client_print_color( 0, iPlayerID, "^4%s^1 %L", g_strPluginPrefix, LANG_PLAYER, "MUSIC_HELP", strPlayerName );
	}
	
	client_print_color( iPlayerID, print_team_blue, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "MUSIC_RANDOM" );
	
	RandomMusic( iPlayerID );
}

public ClCmd_StopMusic( iPlayerID ) {
	SetBit( g_bitIsFirstSong, iPlayerID );
	
	client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "MUSIC_STOPPED" );
	
	client_cmd( iPlayerID, "mp3 stop" );
}

/* Console Commands */
#if defined GREEN_CHAT
public ConCmd_Say( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strMessage[ 192 ];
	
	read_args( strMessage, 191 );
	remove_quotes( strMessage );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	get_user_name( iPlayerID, strAdminName, 31 );
	
	client_print_color( 0, iPlayerID, "^1(^4ALL^1) ^3%s^1 :   %s", strAdminName, strMessage );
	
	log_amx( "AMX_SAY - From: ^"%s (%s)^" - Message: ^"%s^"", strAdminName, strAdminAuthID, strMessage );
	
	return PLUGIN_HANDLED;
}

public ConCmd_Psay( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 3 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strPlayerName[ 32 ];
	read_argv( 1, strPlayerName, 31 );
	
	new iTarget = cmd_target( iPlayerID, strPlayerName, 0 );
	
	if( !iTarget ) {
		return PLUGIN_HANDLED;
	}
	
	new iLen = strlen( strPlayerName ) + 1;
	
	get_user_name( iTarget, strPlayerName, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	new strMessage[ 192 ];
	read_args( strMessage, 191 );
	
	if( strMessage[ 0 ] == '"' && strMessage[ iLen ] == '"' ) {
		strMessage[ 0 ] = ' ';
		strMessage[ iLen ] = ' ';
		iLen += 2;
	}
	
	remove_quotes( strMessage[ iLen ] );
	
	if( iPlayerID && iPlayerID != iTarget ) {
		client_print_color( iPlayerID, iTarget, "^1(^4PM - %s^1) ^3%s^1 :   %s", strPlayerName, strAdminName, strMessage[ iLen ] );
	}
	
	client_print_color( iTarget, iTarget, "^1(^4PM - %s^1) ^3%s^1 :   %s", strPlayerName, strAdminName, strMessage[ iLen ] );
	
	new strPlayerAuthID[ 36 ];
	get_user_authid( iTarget, strPlayerAuthID, 35 );
	
	log_amx( "AMX_PSAY - From: ^"%s (%s)^" - To: ^"%s (%s)^" - Message: ^"%s^"", strAdminName, strAdminAuthID, strPlayerName, strPlayerAuthID, strMessage[ iLen ] );
	
	return PLUGIN_HANDLED;
}

public ConCmd_Chat( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strMessage[ 192 ];
	read_args( strMessage, 191 );
	remove_quotes( strMessage );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	log_amx( "AMX_CHAT - From: ^"%s (%s)^" - Message: ^"%s^"", strAdminName, strAdminAuthID, strMessage );
	
	format( strMessage, 191, "^1(^4ADMINS^1) ^3%s^1 :   %s", strAdminName, strMessage );
	
	new iPlayers[ 32 ], iNum, iTempID;
	get_players( iPlayers, iNum, "ch" );
	
	for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
		iTempID = iPlayers[ iLoop ];
		
		if( access( iTempID, ADMIN_CHAT ) ) {
			client_print_color( iTempID, iPlayerID, "%s", strMessage );
		}
	}
	
	return PLUGIN_HANDLED;
}
#endif

/* ADMIN_LEVEL_A Console Commands */
public ConCmd_Health( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 3 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 3 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_HANDLED;
	}
	
	new strCommand[ 32 ], bool:bSetHealth;
	new strTarget[ 32 ], strHealth[ 8 ], iHealth;
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	
	read_argv( 0, strCommand, 31 );
	read_argv( 1, strTarget, 31 );
	read_argv( 2, strHealth, 7 );
	
	( strCommand[ 5 ] == 'e' ) ? ( bSetHealth = false ) : ( bSetHealth = true );
	
	iHealth = str_to_num( strHealth );
	iHealth = clamp( iHealth, MIN_HEALTH, MAX_HEALTH );
	
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			if( bSetHealth ) {
				set_user_health( iTempID, iHealth );
			} else {
				set_user_health( iTempID, clamp( ( get_user_health( iTempID ) + iHealth ), 0, MAX_HEALTH ) );
			}
		}
		
		if( bSetHealth ) {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "SET_HEALTH_TEAM", strTeam, iHealth );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "SET_HEALTH_TEAM", strTeam, iHealth );
			}
			
			log_amx( "Admin %s (%s) set %s players' health to %i.", strAdminName, strAdminAuthID, strTeam, iHealth );
		} else {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "GIVE_HEALTH_TEAM", strTeam, iHealth );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "GIVE_HEALTH_TEAM", strTeam, iHealth );
			}
			
			log_amx( "Admin %s (%s) gave %s players' %i health.", strAdminName, strAdminAuthID, strTeam, iHealth );
		}
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		if( bSetHealth ) {
			set_user_health( iTarget, iHealth );
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "SET_HEALTH_PLAYER", strTargetName, iHealth );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "SET_HEALTH_PLAYER", strTargetName, iHealth );
			}
			
			log_amx( "Admin %s (%s) set %s (%s)'s health to %i.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, iHealth );
		} else {
			set_user_health( iTarget, clamp( ( get_user_health( iTarget ) + iHealth ), 0, MAX_HEALTH ) );
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "GIVE_HEALTH_PLAYER", strTargetName, iHealth );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "GIVE_HEALTH_PLAYER", strTargetName, iHealth );
			}
			
			log_amx( "Admin %s (%s) gave %s (%s) %i health.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, iHealth );
		}
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Armor( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 3 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 3 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_HANDLED;
	}
	
	new strCommand[ 32 ], bool:bSetArmor;
	new strTarget[ 32 ], strArmor[ 8 ], iArmor;
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	
	read_argv( 0, strCommand, 31 );
	read_argv( 1, strTarget, 31 );
	read_argv( 2, strArmor, 7 );
	
	( strCommand[ 5 ] == 'p' ) ? ( bSetArmor = true ) : ( bSetArmor = false );
	
	iArmor = str_to_num( strArmor );
	iArmor = clamp( iArmor, MIN_ARMOR, MAX_ARMOR );
	
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			if( bSetArmor ) {
				cs_set_user_armor( iTempID, iArmor, CS_ARMOR_VESTHELM );
			} else {
				cs_set_user_armor( iTempID, clamp( get_user_armor( iTempID ) + iArmor, 0, MAX_ARMOR ), CS_ARMOR_VESTHELM );
			}
		}
		
		if( bSetArmor ) {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "SET_ARMOR_TEAM", strTeam, iArmor );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "SET_ARMOR_TEAM", strTeam, iArmor );
			}
			
			log_amx( "Admin %s (%s) set %s players' armor to %i.", strAdminName, strAdminAuthID, strTeam, iArmor );
		} else {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "GIVE_ARMOR_TEAM", strTeam, iArmor );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "GIVE_ARMOR_TEAM", strTeam, iArmor );
			}
			
			log_amx( "Admin %s (%s) gave %s players %i armor.", strAdminName, strAdminAuthID, strTeam, iArmor );
		}
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		if( bSetArmor ) {
			cs_set_user_armor( iTarget, iArmor, CS_ARMOR_VESTHELM );
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "SET_ARMOR_PLAYER", strTargetName, iArmor );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "SET_ARMOR_PLAYER", strTargetName, iArmor );
			}
			
			log_amx( "Admin %s (%s) set %s (%s)'s armor to %i.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, iArmor );
			
		} else {
			cs_set_user_armor( iTarget, clamp( get_user_armor( iTarget ) + iArmor, 0, MAX_ARMOR ), CS_ARMOR_VESTHELM );
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "GIVE_ARMOR_PLAYER", strTargetName, iArmor );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "GIVE_ARMOR_PLAYER", strTargetName, iArmor );
			}
			
			log_amx( "Admin %s (%s) gave %s (%s) %i armor.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, iArmor );
		}
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Ammo( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strStatus[ 8 ], iStatus;
	
	switch( read_argc( ) ) {
		case 2: {
			iStatus = 0;
		}
		
		case 3: {
			read_argv( 2, strStatus, 7 );
			iStatus = str_to_num( strStatus );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	new strTarget[ 32 ], strCommand[ 32 ], bool:bClipAmmo;
	
	read_argv( 0, strCommand, 31 );
	read_argv( 1, strTarget, 31 );
	
	( strCommand[ 10 ] == 'b' ) ? ( bClipAmmo = false ) : ( bClipAmmo = true );
	
	iStatus = clamp( iStatus, 0, 1 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			if( bClipAmmo ) {
				( iStatus ) ? SetBit( g_bitHasUnAmmo, iTempID ) : ClearBit( g_bitHasUnAmmo, iTempID );
			} else {
				( iStatus ) ? SetBit( g_bitHasUnBPAmmo, iTempID ) : ClearBit( g_bitHasUnBPAmmo, iTempID );
			}
		}
		
		if( bClipAmmo ) {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "CLIP_AMMO_TEAM", strTeam, iStatus );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "CLIP_AMMO_TEAM", strTeam, iStatus );
			}
			
			log_amx( "Admin %s (%s) set %s players' unlimited clip ammo to %i.", strAdminName, strAdminAuthID, strTeam, iStatus );
		} else {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "BP_AMMO_TEAM", strTeam, iStatus );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "BP_AMMO_TEAM", strTeam, iStatus );
			}
			
			log_amx( "Admin %s (%s) set %s players' unlimited backpack ammo to %i.", strAdminName, strAdminAuthID, strTeam, iStatus );
		}
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		if( bClipAmmo ) {
			( iStatus ) ? SetBit( g_bitHasUnAmmo, iTarget ) : ClearBit( g_bitHasUnAmmo, iTarget );
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "CLIP_AMMO_PLAYER", strTargetName, iStatus );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "CLIP_AMMO_PLAYER", strTargetName, iStatus );
			}
			
			log_amx( "Admin %s (%s) set %s (%s) unlimited clip ammo to %i.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, iStatus );
		} else {
			( iStatus ) ? SetBit( g_bitHasUnBPAmmo, iTarget ) : ClearBit( g_bitHasUnBPAmmo, iTarget );
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "BP_AMMO_PLAYER", strTargetName, iStatus );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "BP_AMMO_PLAYER", strTargetName, iStatus );
			}
			
			log_amx( "Admin %s (%s) set %s (%s) unlimited backpack ammo to %i.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, iStatus );
		}
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Score( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 4 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 4 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_HANDLED;
	}
	
	new strTarget[ 32 ];
	new strFrags[ 8 ], iFrags;
	new strDeaths[ 8 ], iDeaths;
	
	read_argv( 1, strTarget, 31 );
	read_argv( 2, strFrags, 7 );
	read_argv( 3, strDeaths, 7 );
	
	iFrags	= str_to_num( strFrags );
	iDeaths	= str_to_num( strDeaths );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "e", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "e", "CT" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			set_user_frags( iTempID, iFrags );
			cs_set_user_deaths( iTempID, iDeaths );
			UpdateScore( iTempID, iFrags, iDeaths );
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "CHANGE_SCORE_TEAM", strTeam, iFrags, iDeaths );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "CHANGE_SCORE_TEAM", strTeam, iFrags, iDeaths );
		}
		
		log_amx( "Admin %s (%s) set %s players' score to %i:%i.", strAdminName, strAdminAuthID, strTeam, iFrags, iDeaths );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		set_user_frags( iTarget, iFrags );
		cs_set_user_deaths( iTarget, iDeaths );
		UpdateScore( iTarget, iFrags, iDeaths );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "CHANGE_SCORE_PLAYER", strTargetName, iFrags, iDeaths );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "CHANGE_SCORE_PLAYER", strTargetName, iFrags, iDeaths );
		}
		
		log_amx( "Admin %s (%s) set %s (%s)'s score to %i:%i.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, iFrags, iDeaths );
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Revive( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strHealth[ 8 ], strArmor[ 8 ];
	
	switch( read_argc( ) ) {
		case 2: {
			g_iSpawnHealth = SPAWN_DEF_HEALTH;
			g_iSpawnArmor	= SPAWN_DEF_ARMOR;
		}
		
		case 3: {
			read_argv( 2, strHealth, 7 );
			g_iSpawnHealth = str_to_num( strHealth );
		}
		
		case 4: {
			read_argv( 2, strHealth, 7 );
			read_argv( 3, strArmor, 7 );
			
			g_iSpawnHealth = str_to_num( strHealth );
			g_iSpawnArmor	= str_to_num( strArmor );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	new strTarget[ 32 ];
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	
	read_argv( 1, strTarget, 31 );
	
	g_iSpawnHealth = clamp( g_iSpawnHealth, MIN_HEALTH, MAX_HEALTH );
	g_iSpawnArmor = clamp( g_iSpawnArmor, MIN_ARMOR, MAX_ARMOR );
	
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			#if defined REVIVE_ALIVE
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "e", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "e", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "e", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum );
			}
			#else
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "be", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "be", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "be", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "b" );
			}
			#endif
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			RevivePlayer( iTempID );
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "REVIVE_TEAM", strTeam, g_iSpawnHealth, g_iSpawnArmor );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "REVIVE_TEAM", strTeam, g_iSpawnHealth, g_iSpawnArmor );
		}
		
		log_amx( "Admin %s (%s) revived %s players (%i:%i).", strAdminName, strAdminAuthID, strTeam, g_iSpawnHealth, g_iSpawnArmor );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		#if !defined REVIVE_ALIVE
		if( CheckBit( g_bitIsAlive, iTarget ) ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_CANNOT_REVIVE" );
			
			return PLUGIN_HANDLED;
		}
		#endif
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		RevivePlayer( iTarget );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "REVIVE_PLAYER", strTargetName, g_iSpawnHealth, g_iSpawnArmor );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "REVIVE_PLAYER", strTargetName, g_iSpawnHealth, g_iSpawnArmor );
		}
		
		log_amx( "Admin %s (%s) revived %s (%s) (%i:%i).", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, g_iSpawnHealth, g_iSpawnArmor );
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_NoclipGodmode( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strStatus[ 8 ], iStatus;
	
	switch( read_argc( ) ) {
		case 2: {
			iStatus = 0;
		}
		
		case 3: {
			read_argv( 2, strStatus, 7 );
			iStatus = str_to_num( strStatus );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	new strCommand[ 32 ], bool:bNoClip;
	new strTarget[ 32 ];
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	
	read_argv( 0, strCommand, 31 );
	read_argv( 1, strTarget, 31 );
	
	( strCommand[ 4 ] == 'n' ) ? ( bNoClip = true ) : ( bNoClip = false );
	
	iStatus =  clamp( iStatus, 0, 2 );
	
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			if( bNoClip ) {
				switch( iStatus ) {
					case 0: {
						set_user_noclip( iTempID );
						ClearBit( g_bitHasNoClip, iTempID );
					}
					
					case 1: {
						set_user_noclip( iTempID, 1 );
					}
					
					case 2: {
						set_user_noclip( iTempID, 1 );
						SetBit( g_bitHasNoClip, iTempID );
					}
				}
			} else {
				switch( iStatus ) {
					case 0: {
						set_user_godmode( iTempID );
						ClearBit( g_bitHasGodmode, iTempID );
					}
					
					case 1: {
						set_user_godmode( iTempID, 1 );
					}
					
					case 2: {
						set_user_godmode( iTempID, 1 );
						SetBit( g_bitHasGodmode, iTempID );
					}
				}
			}
		}
		
		if( bNoClip ) {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "NOCLIP_TEAM", iStatus, strTeam );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "NOCLIP_TEAM", iStatus, strTeam );
			}
			
			log_amx( "Admin %s (%s) set noclip %i on %s players.", strAdminName, strAdminAuthID, iStatus, strTeam );
		} else {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "GODMODE_TEAM", iStatus, strTeam );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "GODMODE_TEAM", iStatus, strTeam );
			}
			
			log_amx( "Admin %s (%s) set godmode %i on %s players.", strAdminName, strAdminAuthID, iStatus, strTeam );
		}
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		if( bNoClip ) {
			switch( iStatus ) {
				case 0: {
					set_user_noclip( iTarget );
					ClearBit( g_bitHasNoClip, iTarget );
				}

				case 1: {
					set_user_noclip( iTarget, 1 );
				}

				case 2: {
					set_user_noclip( iTarget, 1 );
					SetBit( g_bitHasNoClip, iTarget );
				}
			}
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "NOCLIP_PLAYER", iStatus, strTargetName );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "NOCLIP_PLAYER", iStatus, strTargetName );
			}
			
			log_amx( "Admin %s (%s) set noclip %i on %s (%s).", strAdminName, strAdminAuthID, iStatus, strTargetName, strTargetAuthID );
		} else {
			switch( iStatus ) {
				case 0: {
					set_user_godmode( iTarget );
					ClearBit( g_bitHasGodmode, iTarget );
				}

				case 1: {
					set_user_godmode( iTarget, 1 );
				}

				case 2: {
					set_user_godmode( iTarget, 1 );
					SetBit( g_bitHasGodmode, iTarget );
				}
			}
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "GODMODE_PLAYER", iStatus, strTargetName );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "GODMODE_PLAYER", iStatus, strTargetName );
			}
			
			log_amx( "Admin %s (%s) set godmode %i on %s (%s).", strAdminName, strAdminAuthID, iStatus, strTargetName, strTargetAuthID );
		}
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Teleport( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new iOrigin[ 3 ];
	new strOriginX[ 8 ], strOriginY[ 8 ], strOriginZ[ 8 ];
	
	switch( read_argc( ) ) {
		case 2: {
			iOrigin = g_iSavedOrigin;
			iOrigin[ 2 ] += 5;
		}
		
		case 3, 4: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_TELE_COORDINATES" );
			
			return PLUGIN_HANDLED;
		}
		
		case 5: {
			read_argv( 2, strOriginX, 7 );
			read_argv( 3, strOriginY, 7 );
			read_argv( 4, strOriginZ, 7 );
			
			iOrigin[ 0 ] = str_to_num( strOriginX );
			iOrigin[ 1 ] = str_to_num( strOriginY );
			iOrigin[ 2 ] = str_to_num( strOriginZ );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	if( strTarget[ 0 ] == '@' ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_TELE_MULTIPLE" );
		
		return PLUGIN_HANDLED;
	}
	
	new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
	
	if( !iTarget ) {
		return PLUGIN_HANDLED;
	}
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	new strTargetName[ 32 ], strTargetAuthID[ 36 ];
	get_user_name( iTarget, strTargetName, 31 );
	get_user_authid( iTarget, strTargetAuthID, 35 );
	
	set_user_origin( iTarget, iOrigin );
	
	switch( get_pcvar_num( g_cvarShowActivity ) ) {
		case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "TELEPORT_PLAYER", strTargetName );
		case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "TELEPORT_PLAYER", strTargetName );
	}
	
	log_amx( "Admin %s (%s) teleported %s (%s).", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID );
	
	return PLUGIN_HANDLED;
}

public ConCmd_UserOrigin( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 2 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_HANDLED;
	}
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	if( strTarget[ 0 ] == '@' ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_TELE_MULTIPLE" );
		
		return PLUGIN_HANDLED;
	}
	
	new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
	
	if( !iTarget ) {
		return PLUGIN_HANDLED;
	}
	
	get_user_origin( iTarget, g_iSavedOrigin );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	new strTargetName[ 32 ], strTargetAuthID[ 36 ];
	get_user_name( iTarget, strTargetName, 31 );
	get_user_authid( iTarget, strTargetAuthID, 35 );
	
	log_amx( "Admin %s (%s) saved %s (%s)'s location.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID );
	
	return PLUGIN_HANDLED;
}

public ConCmd_Speed( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strStatus[ 8 ], iStatus;
	
	switch( read_argc( ) ) {
		case 2: {
			iStatus = 0;
		}
		
		case 3: {
			read_argv( 2, strStatus, 7 );
			iStatus = str_to_num( strStatus );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	iStatus = clamp( iStatus, 0, 1 );
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			switch( iStatus ) {
				case 0: {
					ClearBit( g_bitHasSpeed, iTempID );
					ResetUserMaxSpeed( iTempID );
				}
				
				case 1: {
					SetBit( g_bitHasSpeed, iTempID );
					Event_CurWeapon( iTempID );
				}
			}
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "SPEED_TEAM", strTeam, iStatus );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "SPEED_TEAM", strTeam, iStatus );
		}
		
		log_amx( "Admin %s (%s) turned %s players' speed to %i.", strAdminName, strAdminAuthID, strTeam, iStatus );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		switch( iStatus ) {
			case 0: {
				ClearBit( g_bitHasSpeed, iTarget );
				ResetUserMaxSpeed( iTarget );
			}
			
			case 1: {
				SetBit( g_bitHasSpeed, iTarget );
				Event_CurWeapon( iTarget );
			}
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "SPEED_PLAYER", strTargetName, iStatus );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "SPEED_PLAYER", strTargetName, iStatus );
		}
		
		log_amx( "Admin %s (%s) set %s (%s)'s speed to %i.", strAdminName, strAdminAuthID,  strTargetName, strTargetAuthID, iStatus );
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Drug( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			DrugPlayer( iTempID );
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "DRUGS_TEAM", strTeam );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "DRUGS_TEAM", strTeam );
		}
		
		log_amx( "Admin %s (%s) gave drugs to %s players.", strAdminName, strAdminAuthID, strTeam );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		DrugPlayer( iTarget );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "DRUGS_PLAYER", strTargetName );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "DRUGS_PLAYER", strTargetName );
		}
		
		log_amx( "Admin %s (%s) gave drugs to %s (%s).", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID );
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Weapon( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 3 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( task_exists( TASK_COUNTDOWN_RESTARTROUND ) ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_CANNOT_GIVE" );
		
		return PLUGIN_HANDLED;
	}
	
	new strWeapon[ 32 ], iWeapon;
	new strAmmo[ 8 ], iAmmo;
	
	switch( read_argc( ) ) {
		case 3: {
			read_argv( 2, strWeapon, 31 );
			iWeapon = str_to_num( strWeapon );
			
			iAmmo = -1;
		}
		
		case 4: {
			read_argv( 2, strWeapon, 31 );
			read_argv( 3, strAmmo, 7 );
			
			iWeapon = str_to_num( strWeapon );
			iAmmo = str_to_num( strAmmo );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	if( !iWeapon ) {
		for( new iLoop = 0; iLoop < 31; iLoop++ ) {
			if( containi( strWeapon, g_strWeapons[ iLoop ][ 7 ] ) != -1 ) {
				iWeapon = iLoop;
				break;
			}
		}
		
		if( !iWeapon ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_WEAPON" );
			
			return PLUGIN_HANDLED;
		}
	} else {
		new bool:bFoundMatch = false;
		
		static iWeaponLayout[ 31 ] = {
			0, 14, 88, 45, 84, 22, 4, 34, 44, 85, 15, 16, 35, 47, 49, 40, 
			11, 12, 46, 31, 51, 21, 43, 32, 47, 83, 13, 41, 42, 1, 33
		};
		
		for( new iLoop = 0; iLoop < 31; iLoop++ ) {
			if( iWeapon == iWeaponLayout[ iLoop ] ) {
				iWeapon = iLoop;
				bFoundMatch = true;
				break;
			}
		}
		
		if( !bFoundMatch ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_WEAPON" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	if( iAmmo == -1 ) {
		iAmmo = g_iWeaponBackpack[ iWeapon ];
	} else {
		iAmmo = clamp( iAmmo, 0, g_iWeaponBackpack[ iWeapon ] );
	}
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			GiveWeapon( iTempID, iWeapon, iAmmo );
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "WEAPON_TEAM", strTeam, g_strWeapons[ iWeapon ], iAmmo );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "WEAPON_TEAM", strTeam, g_strWeapons[ iWeapon ], iAmmo );
		}
		
		log_amx( "Admin %s (%s) gave %s players %s (%i).", strAdminName, strAdminAuthID, strTeam, g_strWeapons[ iWeapon ], iAmmo );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		GiveWeapon( iTarget, iWeapon, iAmmo );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "WEAPON_PLAYER", strTargetName, g_strWeapons[ iWeapon ], iAmmo );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "WEAPON_PLAYER", strTargetName, g_strWeapons[ iWeapon ], iAmmo );
		}
		
		log_amx( "Admin %s (%s) gave %s (%s) %s (%i).", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, g_strWeapons[ iWeapon ], iAmmo );
	}
	
	return PLUGIN_HANDLED;
}

/* ADMIN_LEVEL_B */
public ConCmd_BlanksNobuy( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strStatus[ 8 ], iStatus;
	
	switch( read_argc( ) ) {
		case 2: {
			iStatus = 0;
		}
		
		case 3: {
			read_argv( 2, strStatus, 7 );
			iStatus = str_to_num( strStatus );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	iStatus = clamp( iStatus, 0, 1 );
	
	new bool:bBlanks;
	new strCommand[ 32 ], strTarget[ 32 ];
	read_argv( 0, strCommand, 31 );
	read_argv( 1, strTarget, 31 );
	
	( strCommand[ 4 ] == 'b' ) ? ( bBlanks = true ) : ( bBlanks = false );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "e", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "e", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "e", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			if( iStatus ) {
				set_user_hitzones( iTempID, 0, 0 );
				SetBit( g_bitHasBlanks, iTempID );
				
				UpdatePlayerMapZones( iTempID );
			} else {
				set_user_hitzones( iTempID, 0, 255 );
				ClearBit( g_bitHasBlanks, iTempID );
			}
		}
		
		if( bBlanks ) {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "BLANKS_TEAM", strTeam, iStatus );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "BLANKS_TEAM", strTeam, iStatus );
			}
			
			log_amx( "Admin %s (%s) set %s players' blank bullets to %i.", strAdminName, strAdminAuthID, strTeam, iStatus );
		} else {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "NOBUY_TEAM", strTeam, iStatus );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "NOBUY_TEAM", strTeam, iStatus );
			}
			
			log_amx( "Admin %s (%s) set %s players' nobuy to %i.", strAdminName, strAdminAuthID, strTeam, iStatus );
		}
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		if( bBlanks ) {
			if( iStatus ) {
				set_user_hitzones( iTarget, 0, 0 );
				SetBit( g_bitHasBlanks, iTarget );
			} else {
				set_user_hitzones( iTarget, 0, 255 );
				ClearBit( g_bitHasBlanks, iTarget );
			}
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "BLANKS_PLAYER", strTargetName, iStatus );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "BLANKS_PLAYER", strTargetName, iStatus );
			}
			
			log_amx( "Admin %s (%s) set %s (%s)'s blank bullets to %i.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, iStatus );
		} else {
			iStatus ? SetBit( g_bitHasNoBuy, iTarget ) : ClearBit( g_bitHasNoBuy, iTarget );
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "NOBUY_PLAYER", strTargetName, iStatus );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "NOBUY_PLAYER", strTargetName, iStatus );
			}
			
			log_amx( "Admin %s (%s) set %s (%s)'s nobuy to %i.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, iStatus );
		}
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Un_Bury( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 2 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_HANDLED;
	}
	
	new bool:bBury;
	new strCommand[ 32 ], strTarget[ 32 ];
	read_argv( 0, strCommand, 31 );
	read_argv( 1, strTarget, 31 );
	
	( strCommand[ 4 ] == 'b' ) ? ( bBury = true ) : ( bBury = false );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			Bury_Unbury( iTempID, bBury );
		}
		
		if( bBury ) {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "BURIED_TEAM", strTeam );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "BURIED_TEAM", strTeam );
			}
			
			log_amx( "Admin %s (%s) buried %s players.", strAdminName, strAdminAuthID, strTeam );
		} else {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "UNBURIED_TEAM", strTeam );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "UNBURIED_TEAM", strTeam );
			}
			
			log_amx( "Admin %s (%s) unburied %s players.", strAdminName, strAdminAuthID, strTeam );
		}
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		Bury_Unbury( iTarget, bBury );
		
		if( bBury ) {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "BURIED_PLAYER", strTargetName );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "BURIED_PLAYER", strTargetName );
			}
			
			log_amx( "Admin %s (%s) buried %s.", strAdminName, strAdminAuthID, strTargetName );
		} else {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "UNBURIED_PLAYER", strTargetName );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "UNBURIED_PLAYER", strTargetName );
			}
			
			log_amx( "Admin %s (%s) unburied %s.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID );
		}
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Disarm( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 2 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_HANDLED;
	}
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			StripPlayerWeapons( iTempID );
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "DISARM_TEAM", strTeam );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "DISARM_TEAM", strTeam );
		}
		
		log_amx( "Admin %s (%s) disarmed %s players.", strAdminName, strAdminAuthID, strTeam );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		StripPlayerWeapons( iTarget );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "DISARM_PLAYER", strTargetName );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "DISARM_PLAYER", strTargetName );
		}
		
		log_amx( "Admin %s (%s) disarmed %s (%s).", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID );
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_UberslapFire( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 2 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_HANDLED;
	}
	
	new bool:bFire;
	new strCommand[ 32 ], strTarget[ 32 ];
	read_argv( 0, strCommand, 31 );
	read_argv( 1, strTarget, 31 );
	
	( strCommand[ 4 ] == 'f' ) ? ( bFire = true ) : ( bFire = false );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	new strPlayer[ 2 ];
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			if( bFire ) {
				strPlayer[ 0 ] = iTempID;
				SetBit( g_bitIsOnFire, iTempID );
				
				IgnitePlayer( strPlayer );
				IgniteEffects( strPlayer );
			} else {
				StripPlayerWeapons( iTempID );
				set_task( 0.1, "Task_UberslapPlayer", TASK_UBERSLAP + iTempID, _, _, "a", 100 );
			}
		}
		
		if( bFire ) {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "FIRE_TEAM", strTeam );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "FIRE_TEAM", strTeam );
			}
			
			log_amx( "Admin %s (%s) set %s players on fire.", strAdminName, strAdminAuthID, strTeam );
		} else {
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "UBERSLAP_TEAM", strTeam );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "UBERSLAP_TEAM", strTeam );
			}
			
			log_amx( "Admin %s (%s) uberslapped %s players.", strAdminName, strAdminAuthID, strTeam );
		}
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		if( bFire ) {
			strPlayer[ 0 ] = iTarget;
			SetBit( g_bitIsOnFire, iTarget );
			
			IgnitePlayer( strPlayer );
			IgniteEffects( strPlayer );
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "FIRE_PLAYER", strTargetName );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "FIRE_PLAYER", strTargetName );
			}
			
			log_amx( "Admin %s (%s) set %s (%s) on fire.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID );
		} else {
			StripPlayerWeapons( iTarget );
			set_task( 0.1, "Task_UberslapPlayer", TASK_UBERSLAP + iTarget, _, _, "a", 100 );
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "UBERSLAP_PLAYER", strTargetName );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "UBERSLAP_PLAYER", strTargetName );
			}
			
			log_amx( "Admin %s (%s) uberslapped %s (%s).", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID );
		}
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_AutoSlay( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strStatus[ 8 ], iStatus;
	
	switch( read_argc( ) ) {
		case 2: {
			iStatus = 0;
		}
		
		case 3: {
			read_argv( 2, strStatus, 7 );
			iStatus = str_to_num( strStatus );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );			
			
			return PLUGIN_HANDLED;
		}
	}
	
	iStatus = clamp( iStatus, 0, 1 );
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 32 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "e", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "e", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "e", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			if( iStatus ) {
				SetBit( g_bitHasAutoSlay, iTempID );
				
				if( CheckBit( g_bitIsAlive, iTempID ) ) {
					user_kill( iTempID );
				}
			} else {
				ClearBit( g_bitHasAutoSlay, iTempID );
			}
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "AUTOSLAY_TEAM", strTeam, iStatus );
			case 2: client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "AUTOSLAY_TEAM", strTeam, iStatus );
		}
		
		log_amx( "Admin %s (%s) set %s players' auto slay to %s.", strAdminName, strAdminAuthID, strTeam, iStatus ? "On" : "Off" );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		if( iStatus ) {
			SetBit( g_bitHasAutoSlay, iTarget );
			
			if( CheckBit( g_bitIsAlive, iTarget ) ) {
				user_kill( iTarget );
			}
		} else {
			ClearBit( g_bitHasAutoSlay, iTarget );
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "AUTOSLAY_PLAYER", strTargetName, iStatus );
			case 2: client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "AUTOSLAY_PLAYER", strTargetName, iStatus );
		}
		
		log_amx( "Admin %s (%s) set %s (%s)'s auto slay to %s.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, iStatus );
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Rocket( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 2 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_HANDLED;
	}
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			RocketPlayer( iTempID );
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "ROCKET_TEAM", strTeam );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "ROCKET_TEAM", strTeam );
		}
		
		log_amx( "Admin %s (%s) made a rocket out of %s players.", strAdminName, strAdminAuthID, strTeam );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		RocketPlayer( iTarget );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "ROCKET_PLAYER", strTargetName );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "ROCKET_PLAYER", strTargetName );
		}
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_BadAim( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strStatus[ 8 ], iStatus;
	
	switch( read_argc( ) ) {
		case 2: {
			iStatus = 0;
		}
		
		case 3: {
			read_argv( 2, strStatus, 7 );
			iStatus = str_to_num( strStatus );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	if( iStatus < 0 ) {
		iStatus = 0;
	}
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	if( strTarget[ 0 ] == '@' ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_HANDLED;
	}
	
	new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF );
	
	if( !iTarget ) {
		return PLUGIN_HANDLED;
	}
	
	switch( iStatus ) {
		case 0: {
			ClearBit( g_bitHasBadaim, iTarget );
		}
		
		case 1: {
			SetBit( g_bitHasBadaim, iTarget );
		}
		
		default: {
			SetBit( g_bitHasBadaim, iTarget );
			set_task( float( iStatus ), "Task_RemoveBadaim", TASK_BADAIM + iTarget );
		}
	}
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	new strTargetName[ 32 ], strTargetAuthID[ 36 ];
	get_user_name( iTarget, strTargetName, 31 );
	get_user_authid( iTarget, strTargetAuthID, 35 );
	
	if( iStatus ) {
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "GIVE_BADAIM_PLAYER", strTargetName );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "GIVE_BADAIM_PLAYER", strTargetName );
		}
	} else {
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "REMOVE_BADAIM_PLAYER", strTargetName );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "REMOVE_BADAIM_PLAYER", strTargetName );
		}
	}
	
	log_amx( "Admin %s (%s) %s %s%s bad aim.", strAdminName, strAdminAuthID, iStatus ? "gave" : "removed", strTargetName, strTargetAuthID, iStatus ? "" : "'s" );
	
	return PLUGIN_HANDLED;
}

public ConCmd_Slay2( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strType[ 8 ], iType;
	
	switch( read_argc( ) ) {
		case 2: {
			iType = 0;
		}
		
		case 3: {
			read_argv( 2, strType, 7 );
			iType = str_to_num( strType );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	iType = clamp( iType, 0, SLAY_EXPLODE );
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			Slay2Player( iTempID, iType );
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "SLAY2_TEAM", strTeam );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "SLAY2_TEAM", strTeam );
		}
		
		log_amx( "Admin %s (%s) slayed %s players.", strAdminName, strAdminAuthID, strTeam );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		Slay2Player( iTarget, iType );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "SLAY2_PLAYER", strTargetName );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "SLAY2_PLAYER", strTargetName );
		}
		
		log_amx( "Admin %s (%s) slayed %s.", strAdminName, strAdminAuthID, strTargetName );
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Un_Gag( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strCommand[ 32 ], bool:bGag;
	read_argv( 0, strCommand, 31 );
	
	( strCommand[ 4 ] == 'u' ) ? ( bGag = false ) : ( bGag = true );
	
	new strFlags[ 4 ], iFlags;
	new strTime[ 8 ], Float:fTime;
	new strReason[ 64 ];
	
	switch( read_argc( ) ) {
		case 2: {
			if( bGag ) {
				iFlags = read_flags( g_strGagFlags );
				formatex( strFlags, 3, "%s", g_strGagFlags );
				
				fTime = g_fGagTime;
				float_to_str( fTime, strTime, 7 );
				
				formatex( strReason, 63, "Unspecified" );
			}
		}
		
		case 3: {
			if( bGag ) {
				read_argv( 2, strFlags, 3 );
				iFlags = read_flags( strFlags );
				
				if( iFlags < 1 || iFlags > 7 ) {
					console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_GAG_FLAGS" );
					
					return PLUGIN_HANDLED;
				}
				
				fTime = g_fGagTime;
				float_to_str( fTime, strTime, 7 );
				
				formatex( strReason, 63, "Unspecified" );
			} else {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		case 4: {
			if( bGag ) {
				read_argv( 2, strFlags, 3 );
				iFlags = read_flags( strFlags );
				
				if( iFlags < 1 || iFlags > 7 ) {
					console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_GAG_FLAGS" );
					
					return PLUGIN_HANDLED;
				}
				
				read_argv( 3, strTime, 7 );
				fTime = str_to_float( strTime );
				
				new iMinimum = GAG_MIN * 60;
				new iMaximum = GAG_MAX * 60;
				
				if( fTime < float( iMinimum ) || fTime > float( iMaximum ) ) {
					console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_GAG_BETWEEN", iMinimum, iMaximum );
					
					return PLUGIN_HANDLED;
				}
				
				formatex( strReason, 63, "Unspecified" );
			} else {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		case 5: {
			if( bGag ) {
				read_argv( 2, strFlags, 3 );
				iFlags = read_flags( strFlags );
				
				if( iFlags < 1 || iFlags > 7 ) {
					console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_GAG_FLAGS" );
					
					return PLUGIN_HANDLED;
				}
				
				read_argv( 3, strTime, 7 );
				
				if( strTime[ 0 ] == 'm' ) {
					strTime[ 0 ] = ' ';
					trim( strTime );
					
					fTime = str_to_float( strTime ) * 60.0;
				} else {
					fTime = str_to_float( strTime );
				}
				
				new iMinimum = GAG_MIN * 60;
				new iMaximum = GAG_MAX * 60;
				
				if( fTime < float( iMinimum ) || fTime > float( iMaximum ) ) {
					console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_GAG_BETWEEN", iMinimum, iMaximum );
					
					return PLUGIN_HANDLED;
				}
				
				read_argv( 4, strReason, 63 );
				remove_quotes( strReason );
				
				if( is_str_empty( strReason ) ) {
					formatex( strReason, 63, "Unspecified" );
				}
			} else {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF );
	
	if( !iTarget ) {
		return PLUGIN_HANDLED;
	}
	
	new strTargetName[ 32 ], strTargetAuthID[ 36 ];
	get_user_name( iTarget, strTargetName, 31 );
	get_user_authid( iTarget, strTargetAuthID, 35 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( bGag ) {
		g_iPlayerGagFlags[ iTarget ] = iFlags;
		formatex( g_strGagReason[ iTarget ], 63, strReason );
		
		g_fPlayerGagEnd[ iTarget ] = get_gametime( ) + str_to_float( strTime );
		set_task( fTime, "Task_UngagPlayer", TASK_UNGAG + iTarget );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "GAG_PLAYER", strTargetName, floatround( str_to_float( strTime ) ), strFlags, strReason );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "GAG_PLAYER", strTargetName, floatround( str_to_float( strTime ) ), strFlags, strReason );
		}
		
		log_amx( "Admin %s (%s) gagged %s (%s) for %s seconds with ^'%s^' flags. Reason: %s.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, strTime, strFlags, strReason );
	} else {
		g_iPlayerGagFlags[ iTarget ] = 0;
		
		if( task_exists( TASK_UNGAG + iPlayerID ) ) {
			remove_task( TASK_UNGAG + iPlayerID );
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "UNGAG_PLAYER", strTargetName );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "UNGAG_PLAYER", strTargetName );
		}
		
		log_amx( "Admin %s (%s) ungagged %s (%s).", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID );
	}
	
	return PLUGIN_HANDLED;
}

/* ADMIN_LEVEL_C */
public ConCmd_PGravity( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strGravity[ 8 ], iGravity;
	
	switch( read_argc( ) ) {
		case 2: {
			iGravity = 800;
		}
		
		case 3: {
			read_argv( 2, strGravity, 7 );
			iGravity = str_to_num( strGravity );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	new Float:fGrav = float( iGravity ) / 800.0;
	
	if( !iGravity ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NULL_PGRAVITY" );
		
		return PLUGIN_HANDLED;
	}
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "e", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "e", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "e", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			set_user_gravity( iTempID, fGrav );
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "PGRAVITY_TEAM", strTeam, iGravity );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "PGRAVITY_TEAM", strTeam, iGravity );
		}
		
		log_amx( "Admin %s (%s) set %s players' gravity to %i.", strAdminName, strAdminAuthID, strTeam, iGravity );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		set_user_gravity( iTarget, fGrav );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "PGRAVITY_PLAYER", strTargetName, iGravity );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "PGRAVITY_PLAYER", strTargetName, iGravity );
		}
		
		log_amx( "Admin %s (%s) set %s (%s) gravity to %i.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, iGravity );
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Pass( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strPassword[ 128 ];
	read_argv( 1, strPassword, 127 );
	
	remove_quotes( strPassword );
	set_pcvar_string( g_cvarPassword, strPassword );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	switch( get_pcvar_num( g_cvarShowActivity ) ) {
		case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "PASSWORD_SET" );
		case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "PASSWORD_SET" );
	}
	
	log_amx( "Admin %s (%s) has set a password to the server (%s).", strAdminName, strAdminAuthID, strPassword );
	
	return PLUGIN_HANDLED;
}

public ConCmd_NoPass( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 1 ) ) {
		return PLUGIN_HANDLED;
	}
	
	set_pcvar_string( g_cvarPassword, "" );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	switch( get_pcvar_num( g_cvarShowActivity ) ) {
		case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "PASSWORD_REMOVE" );
		case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "PASSWORD_REMOVE" );
	}
	
	log_amx( "Admin %s (%s) has reset the password from the server.", strAdminName, strAdminAuthID );
	
	return PLUGIN_HANDLED;
}

public ConCmd_IP( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 1 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new bool:bAllPlayers;
	
	switch( read_argc( ) ) {
		case 1: {
			bAllPlayers = true;
		}
		
		case 2: {
			bAllPlayers = false;
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	if( bAllPlayers ) {
		new iPlayers[ 32 ], iNum, iTempID;
		get_players( iPlayers, iNum );
		
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "IP_LIST_ALL" );
		
		console_print( iPlayerID, "%L", iPlayerID, "IP_LIST_ALL_UP" );
		
		new strPlayerName[ 32 ], strPlayerIP[ 32 ];
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			get_user_name( iTempID, strPlayerName, 31 );
			get_user_ip( iTempID, strPlayerIP, 15, IP_PORT );
			
			console_print( iPlayerID, "#%i %s %s", get_user_userid( iTempID ), strPlayerIP, strPlayerName );
		}
		
		console_print( iPlayerID, "%L", iPlayerID, "IP_LIST_ALL_DOWN", iNum );
		
		return PLUGIN_HANDLED;
	}
	
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "e", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "e", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "e", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "IP_LIST_TEAM", strTeam );
		
		console_print( iPlayerID, "%L", iPlayerID, "IP_LIST_ALL_UP" );
		
		new strPlayerName[ 32 ], strPlayerIP[ 32 ];
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			get_user_name( iTempID, strPlayerName, 31 );
			get_user_ip( iTempID, strPlayerIP, 31, IP_PORT );
			
			console_print( iPlayerID, "#%i %s %s", get_user_userid( iTempID ), strPlayerIP, strPlayerName );
		}
		
		console_print( iPlayerID, "%L", iPlayerID, "IP_LIST_ALL_DOWN", iNum );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ], strTargetIP[ 32 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		get_user_ip( iTarget, strTargetIP, 31, IP_PORT );
		
		console_print( iPlayerID, "%s #%d %s %s", g_strPluginPrefix, get_user_userid( iTarget ), strTargetName, strTargetIP ); 
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Transfer( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strTeamDest[ 32 ], iTeam;
	
	switch( read_argc( ) ) {
		case 2: {
			iTeam = AUTO;
		}
		
		case 3: {
			read_argv( 2, strTeamDest, 31 );
			
			switch( strTeamDest[ 0 ] ) {
				case 't', 'T': {
					iTeam = TERRORIST;
					formatex( strTeamDest, 31, "TERRORIST" );
				}
				
				case 'c', 'C': {
					iTeam = COUNTER;
					formatex( strTeamDest, 31, "COUNTER-TERRORIST" );
				}
				
				case 's', 'S': {
					iTeam = SPECTATOR;
					formatex( strTeamDest, 31, "SPECTATOR" );
				}
				
				default: {
					console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_TEAM_INVALID" );
					console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_TEAM_VALID" );
					
					return PLUGIN_HANDLED;
				}
			}
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "e", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "e", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "e", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			switch( iTeam ) {
				case TERRORIST: {
					cs_set_user_team( iTempID, CS_TEAM_T, CS_T_MODEL );
					
					if( CheckBit( g_bitIsAlive, iTempID ) ) {
						ExecuteHamB( Ham_CS_RoundRespawn, iTempID );
					}
				}
				
				case COUNTER: {
					cs_set_user_team( iTempID, CS_TEAM_CT, CS_CT_MODEL );
					
					if( CheckBit( g_bitIsAlive, iTempID ) ) {
						ExecuteHamB( Ham_CS_RoundRespawn, iTempID );
					}
				}
				
				case AUTO: {
					switch( cs_get_user_team( iTempID ) ) {
						case CS_TEAM_T: {
							cs_set_user_team( iTempID, CS_TEAM_CT, CS_CT_MODEL );
							
							if( CheckBit( g_bitIsAlive, iTempID ) ) {
								ExecuteHamB( Ham_CS_RoundRespawn, iTempID );
							}
						}
						
						case CS_TEAM_CT: {
							cs_set_user_team( iTempID, CS_TEAM_T, CS_T_MODEL );
							
							if( CheckBit( g_bitIsAlive, iTempID ) ) {
								ExecuteHamB( Ham_CS_RoundRespawn, iTempID );
							}
						}
					}
				}
				
				case SPECTATOR: {
					if( !CheckBit( g_bitIsAlive, iTempID ) ) {
						user_silentkill( iTempID );
					}
					
					cs_set_user_team( iTempID, CS_TEAM_SPECTATOR );
				}
			}
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "TRANSFER_TEAM", strTeam, strTeamDest );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "TRANSFER_TEAM", strTeam, strTeamDest );
		}
		
		log_amx( "Admin %s (%s) transfered %s players to the %s team.", strAdminName, strAdminAuthID, strTeam, strTeamDest );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		switch( iTeam ) {
			case TERRORIST: {
				cs_set_user_team( iTarget, CS_TEAM_T, CS_T_MODEL );
				
				if( CheckBit( g_bitIsAlive, iTarget ) ) {
					ExecuteHamB( Ham_CS_RoundRespawn, iTarget );
				}
			}
			
			case COUNTER: {
				cs_set_user_team( iTarget, CS_TEAM_CT, CS_CT_MODEL );
				
				if( CheckBit( g_bitIsAlive, iTarget ) ) {
					ExecuteHamB( Ham_CS_RoundRespawn, iTarget );
				}
			}
			
			case AUTO: {
				switch( cs_get_user_team( iTarget ) ) {
					case CS_TEAM_T: {
						formatex( strTeamDest, 31, "COUNTER-TERRORIST" );
						
						cs_set_user_team( iTarget, CS_TEAM_CT, CS_CT_MODEL );
						
						if( CheckBit( g_bitIsAlive, iTarget ) ) {
							ExecuteHamB( Ham_CS_RoundRespawn, iTarget );
						}
					}
					
					case CS_TEAM_CT: {
						formatex( strTeamDest, 31, "TERRORIST" );
						
						cs_set_user_team( iTarget, CS_TEAM_T, CS_T_MODEL );
						
						if( CheckBit( g_bitIsAlive, iTarget ) ) {
							ExecuteHamB( Ham_CS_RoundRespawn, iTarget );
						}
					}
				}
			}
			
			case SPECTATOR: {
				user_silentkill( iTarget );
				cs_set_user_team( iTarget, CS_TEAM_SPECTATOR );
			}
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "TRANSFER_PLAYER", strTargetName, strTeamDest );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "TRANSFER_PLAYER", strTargetName, strTeamDest );
		}
		
		log_amx( "Admin %s (%s) transfered %s (%s) to the %s team.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, strTeamDest );
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_Swap( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 3 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 3 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_SWAP_TWO" );
		
		return PLUGIN_HANDLED;
	}
	
	new strTarget1[ 32 ], strTarget2[ 32 ];
	read_argv( 1, strTarget1, 31 );
	read_argv( 2, strTarget2, 31 );
	
	new iTarget1 = cmd_target( iPlayerID, strTarget1, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF );
	new iTarget2 = cmd_target( iPlayerID, strTarget2, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF );
	
	if( !iTarget1 || !iTarget2 ) {
		return PLUGIN_HANDLED;
	}
	
	new CsTeams:iTeam1 = cs_get_user_team( iTarget1 );
	new CsTeams:iTeam2 = cs_get_user_team( iTarget2 );
	
	if( iTeam1 == iTeam2 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_SWAP_SAME_TEAM" );
		
		return PLUGIN_HANDLED;
	}
	
	if( iTeam1 == CS_TEAM_UNASSIGNED || iTeam2 == CS_TEAM_UNASSIGNED ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_SWAP_NO_TEAM" );
		
		return PLUGIN_HANDLED;
	}
	
	if( iTeam1 == CS_TEAM_SPECTATOR ) {
		user_silentkill( iTarget2 );
	}
	
	if( iTeam2 == CS_TEAM_SPECTATOR ) {
		user_silentkill( iTarget1 );
	}
	
	cs_set_user_team( iTarget1, iTeam2 );
	cs_set_user_team( iTarget2, iTeam1 );
	
	if( CheckBit( g_bitIsAlive, iTarget1 ) ) {
		ExecuteHamB( Ham_CS_RoundRespawn, iTarget1 );
	}
	
	if( CheckBit( g_bitIsAlive, iTarget2 ) ) {
		ExecuteHamB( Ham_CS_RoundRespawn, iTarget2 );
	}
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	new strTarget1Name[ 32 ], strTarget1AuthID[ 36 ];
	get_user_name( iTarget1, strTarget1Name, 31 );
	get_user_authid( iTarget1, strTarget1AuthID, 35 );
	
	new strTarget2Name[ 32 ], strTarget2AuthID[ 36 ];
	get_user_name( iTarget2, strTarget2Name, 31 );
	get_user_authid( iTarget2, strTarget2AuthID, 35 );
	
	switch( get_pcvar_num( g_cvarShowActivity ) ) {
		case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "SWAP_PLAYERS", strTarget1Name, strTarget2Name );
		case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "SWAP_PLAYERS", strTarget1Name, strTarget2Name );
	}
	
	log_amx( "Admin %s (%s) swapped %s (%s) and %s (%s).", strAdminName, strAdminAuthID, strTarget1Name, strTarget1AuthID, strTarget2Name, strTarget2AuthID );
	
	return PLUGIN_HANDLED;
}

public ConCmd_SwapTeams( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 1 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 1 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_HANDLED;
	}
	
	new iPlayers[ 32 ], iNum, iTempID;
	get_players( iPlayers, iNum );
	
	for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
		iTempID = iPlayers[ iLoop ];
		
		switch( cs_get_user_team( iTempID ) ) {
			case CS_TEAM_CT: {
				cs_set_user_team( iTempID, CS_TEAM_T );
			}
			
			case CS_TEAM_T: {
				cs_set_user_team( iTempID, CS_TEAM_CT );
			}
		}
		
		if( CheckBit( g_bitIsAlive, iTempID ) ) {
			ExecuteHamB( Ham_CS_RoundRespawn, iTempID );
		}
	}
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	switch( get_pcvar_num( g_cvarShowActivity ) ) {
		case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "SWAP_TEAMS" );
		case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "SWAP_TEAMS" );
	}
	
	log_amx( "Admin %s (%s) swapped both teams.", strAdminName, strAdminAuthID );
	
	return PLUGIN_HANDLED;
}

public ConCmd_Glow( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new bool:bName = false, strColors[ 32 ];
	new strColorName[ 32 ], iColorID = -1;
	new strColor[ 4 ][ 8 ], iColor[ 4 ];
	
	switch( read_argc( ) ) {
		case 2: {
			iColor[ R ] = 0;
			iColor[ G ] = 0;
			iColor[ B ] = 0;
			iColor[ A ] = 0;
		}
		
		case 3: {
			read_argv( 2, strColorName, 31 );
			
			static strColorArray[ MAX_COLORS ][ ] = {
				"red",
				"pink",
				"darkred",
				"lightred",
				"blue",
				"darkblue",
				"lightblue",
				"aqua",
				"green",
				"lightgreen",
				"darkgreen",
				"brown",
				"lightbrown",
				"white",
				"yellow",
				"darkyellow",
				"lightyellow",
				"orange",
				"lightorange",
				"darkorange",
				"lightpurple",
				"purple",
				"darkpurple",
				"violet",
				"maroon",
				"gold",
				"silver",
				"bronze",
				"grey",
				"off"
			};
			
			static iColorArray[ MAX_COLORS ][ 3 ] = {
				{255, 	0, 	0},		// red
				{255, 	190, 	190},		// pink
				{165, 	0, 	0},		// darkred
				{255, 	100, 	100},		// lightred
				{0, 	0, 	255},		// blue
				{0, 	0, 	136},		// darkblue
				{95, 	200, 	255},		// lightblue
				{0, 	150, 	255},		// aqua
				{0, 	255, 	0},		// green
				{180, 	255, 	175},		// lightgreen
				{0, 	155, 	0},		// darkgreen
				{150, 	63, 	0},		// brown
				{205, 	123, 	64},		// lightbrown
				{255, 	255, 	255},		// white
				{255, 	255, 	0},		// yellow
				{189, 	182, 	0},		// darkyellow
				{255, 	255, 	109},		// lightyellow
				{255, 	150, 	0},		// orange
				{255, 	190, 	90},		// lightorange
				{222, 	110, 	0},		// darkorange
				{243, 	138, 	255},		// lightpurple
				{255, 	0, 	255},		// purple
				{150, 	0, 	150},		// darkpurple
				{100, 	0, 	100},		// violet
				{200, 	0, 	0},		// maroon
				{220, 	220, 	0},		// gold
				{192, 	192, 	192},		// silver
				{190, 	100, 	10},		// bronze
				{114, 	114, 	114},		// grey
				{0, 	0, 	0}		// off
			};
			
			for( new iLoop = 0; iLoop < MAX_COLORS; iLoop++ ) {
				if( equal( strColorArray[ iLoop ], strColorName ) ) {
					iColorID = iLoop;
					iColor = iColorArray[ iLoop ];
					iColor[ A ] = 255;
					
					bName = true;
					break;
				}
			}
			
			if( iColorID == -1 ) {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_MATCH" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		case 4, 5: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_PROVIDE_ALL" );
			
			return PLUGIN_HANDLED;
		}
		
		case 6: {
			new iLen = 0;
			
			for( new iLoop = 0; iLoop < 4; iLoop++ ) {
				read_argv( iLoop + 2, strColor[ iLoop ], 7 );
				iColor[ iLoop ] = clamp( str_to_num( strColor[ iLoop ] ), 0, 255 );
				iLen += formatex( strColors[ iLen ], 31 - iLen, "%i ", iColor[ iLoop ] );
			}
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	new strCommand[ 32 ], bool:bPermGlow;
	read_argv( 0, strCommand, 31 );
	
	( strCommand[ 8 ] == '2' ) ? ( bPermGlow = true ) : ( bPermGlow = false );
	
	new strTarget[ 32 ];
	read_argv( 1, strTarget, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( strTarget[ 0 ] == '@' ) {
		new iPlayers[ 32 ], iNum, iTempID;
		new strTeam[ 32 ];
		
		switch( strTarget[ 1 ] ) {
			case 't', 'T': {
				formatex( strTeam, 31, "TERRORIST" );
				get_players( iPlayers, iNum, "ae", "TERRORIST" );
			}
			
			case 'c', 'C': {
				formatex( strTeam, 31, "COUNTER-TERRORIST" );
				get_players( iPlayers, iNum, "ae", "CT" );
			}
			
			case 's', 'S': {
				formatex( strTeam, 31, "SPECTATOR" );
				get_players( iPlayers, iNum, "ae", "SPECTATOR" );
			}
			
			case 'a', 'A': {
				formatex( strTeam, 31, "ALL" );
				get_players( iPlayers, iNum, "a" );
			}
			
			default: {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_INVALID" );
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_VALID" );
				
				return PLUGIN_HANDLED;
			}
		}
		
		if( !iNum ) {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_PLAYERS" );
			
			return PLUGIN_HANDLED;
		}
		
		for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( access( iTempID, ADMIN_IMMUNITY ) && !access( iPlayerID, ADMIN_IMMUNITY ) ) {
				continue;
			}
			
			if( bName ) {
				set_user_rendering( iTempID, kRenderFxGlowShell, iColor[ R ], iColor[ G ], iColor[ B ], kRenderNormal, 7 );
			} else {
				set_user_rendering( iTempID, kRenderFxGlowShell, iColor[ R ], iColor[ G ], iColor[ B ], ( iColor[ A ] == 255 ) ? kRenderNormal : kRenderTransAlpha, ( iColor[ A ] == 255 ) ? 7 : iColor[ A ] );
			}
			
			if( bPermGlow ) {
				SetBit( g_bitHasGlow, iTempID );
			} else {
				ClearBit( g_bitHasGlow, iTempID );
			}
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "GLOW_TEAM", strTeam, bName ? strColorName : strColors );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "GLOW_TEAM", strTeam, bName ? strColorName : strColors );
		}
		
		log_amx( "Admin %s (%s) glowed %s players %s.", strAdminName, strTeam, bName ? strColorName : strColors );
	} else {
		new iTarget = cmd_target( iPlayerID, strTarget, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_ONLY_ALIVE );
		
		if( !iTarget ) {
			return PLUGIN_HANDLED;
		}
		
		new strTargetName[ 32 ], strTargetAuthID[ 36 ];
		get_user_name( iTarget, strTargetName, 31 );
		get_user_authid( iTarget, strTargetAuthID, 35 );
		
		if( bName ) {
			set_user_rendering( iTarget, kRenderFxGlowShell, iColor[ R ], iColor[ G ], iColor[ B ], kRenderNormal, 7 );
		} else {
			set_user_rendering( iTarget, kRenderFxGlowShell, iColor[ R ], iColor[ G ], iColor[ B ], ( iColor[ A ] == 255 ) ? kRenderNormal : kRenderTransAlpha, ( iColor[ A ] == 255 ) ? 7 : iColor[ A ] );
		}
		
		if( bPermGlow ) {
			SetBit( g_bitHasGlow, iTarget );
		} else {
			ClearBit( g_bitHasGlow, iTarget );
		}
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "GLOW_PLAYER", strTargetName, bName ? strColorName : strColors );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "GLOW_PLAYER", strTargetName, bName ? strColorName : strColors );
		}
		
		log_amx( "Admin %s (%s) glowed %s (%s) %s.", strAdminName, strAdminAuthID, strTargetName, strTargetAuthID, bName ? strColorName : strColors );
	}
	
	return PLUGIN_HANDLED;
}

/* ADMIN_LEVEL_D */
public ConCmd_HSOnly( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strStatus[ 8 ], iStatus;
	read_argv( 1, strStatus, 7 );
	
	iStatus = str_to_num( strStatus );
	iStatus = clamp( iStatus, 0, 1 );
	
	if( iStatus ) {
		set_user_hitzones( 0, 0, 2 );
		g_bIsHSOnly = true;
	} else {
		set_user_hitzones( 0, 0, 255 );
		g_bIsHSOnly = false;
	}
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	switch( get_pcvar_num( g_cvarShowActivity ) ) {
		case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "HS_ONLY", iStatus );
		case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "HS_ONLY", iStatus );
	}
	
	log_amx( "Admin %s (%s) has set headshot only mode to %s.", strAdminName, strAdminAuthID, iStatus ? "ON" : "OFF" );
	
	return PLUGIN_HANDLED;
}

public ConCmd_Extend( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 2 ) {
		return PLUGIN_HANDLED;
	}
	
	new strTime[ 8 ], iTime;
	read_argv( 1, strTime, 7 );
	
	iTime = str_to_num( strTime );
	
	if( iTime < MIN_EXTEND || iTime > MAX_EXTEND ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_EXTEND_BETWEEN" );
		
		return PLUGIN_HANDLED;
	}
	
	g_iTotalExtendTime += iTime;
	
	if( g_iTotalExtendTime > get_pcvar_num( g_pcvarMaxExtendTime ) ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_EXTEND_MORE" );
		
		return PLUGIN_HANDLED;
	}
	
	set_pcvar_float( g_cvarTimeLimit, get_pcvar_float( g_cvarTimeLimit ) + iTime );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	switch( get_pcvar_num( g_cvarShowActivity ) ) {
		case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "ADMIN_EXTEND", iTime );
		case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "ADMIN_EXTEND", iTime );
	}
	
	log_amx( "Admin %s (%s) extended the map %i minutes.", strAdminName, strAdminAuthID, iTime );
	
	return PLUGIN_HANDLED;
}

public ConCmd_Un_Lock( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 1 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strCommand[ 32 ], strTeam[ 32 ];
	read_argv( 0, strCommand, 31 );
	read_argv( 1, strTeam, 31 );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	new bool:bLock, iTeam;
	
	if( strCommand[ 4 ] == 'l' ) {
		bLock = true;
		
		if( read_argc( ) == 1 ) {
			new strCmd[ 32 ], strInfo[ 128 ], iFlag;
			get_concmd( iCid, strCmd, 31, iFlag, strInfo, 127, iLevel );
			
			console_print( iPlayerID, "Usage: %s %s", strCmd, strInfo );
			
			return PLUGIN_HANDLED;
		}
	} else {
		bLock = false;
		
		if( read_argc( ) == 1 ) {
			for( new iLoop = 0; iLoop < 6; iLoop++ ) {
				g_bBlockTeamJoin[ iLoop ] = false;
			}
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "UNLOCK_ALL" );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "UNLOCK_ALL" );
			}
			
			log_amx( "Admin %s (%s) unlocked all teams.", strAdminName, strAdminAuthID );
			
			return PLUGIN_HANDLED;
		}
	}
	
	switch( strTeam[ 0 ] ) {
		case 't', 'T': {
			iTeam = TERRORIST;
		}
		
		case 'c', 'C': {
			iTeam = COUNTER;
		}
		
		case 'a', 'A': {
			iTeam = AUTO;
		}
		
		case 's', 'S': {
			iTeam = SPECTATOR;
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_TEAM_INVALID" );
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_TEAM_VALID" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	if( bLock ) {
		g_bBlockTeamJoin[ iTeam ] = true;
	} else {
		g_bBlockTeamJoin[ iTeam ] = false;
	}
	
	static strLockerTeamNames[ ][ ] = {
		"Terrorists",
		"Counter-Terrorists",
		"",
		"",
		"Auto",
		"Spectator"
	};
	
	if( bLock ) {
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "LOCK_TEAM", strLockerTeamNames[ iTeam ] );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "LOCK_TEAM", strLockerTeamNames[ iTeam ] );
		}
	} else {
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "UNLOCK_TEAM", strLockerTeamNames[ iTeam ] );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "UNLOCK_TEAM", strLockerTeamNames[ iTeam ] );
		}
	}
	
	log_amx( "Admin %s (%s) %slocked the %s team.", strAdminName, strAdminAuthID, bLock ? "" : "un", strLockerTeamNames[ iTeam ] );
	
	return PLUGIN_HANDLED;
}

public ConCmd_Gravity( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 1 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strGravity[ 8 ], iGravity;
	
	switch( read_argc( ) ) {
		case 1: {
			console_print( iPlayerID, "%s %L %I.", g_strPluginPrefix, iPlayerID, "CURRENT_GRAVITY", get_pcvar_num( g_cvarGravity ) );
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "GRAVITY_DEFAULT" );
			
			return PLUGIN_HANDLED;
		}
		
		case 2: {
			read_argv( 1, strGravity, 7 );
			iGravity = str_to_num( strGravity );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	set_pcvar_num( g_cvarGravity, iGravity );
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	switch( get_pcvar_num( g_cvarShowActivity ) ) {
		case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "GRAVITY_CHANGE", iGravity );
		case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "GRAVITY_CHANGE", iGravity );
	}
	
	log_amx( "Admin %s (%s) set gravity to %i.", strAdminName, strAdminAuthID, iGravity );
	
	return PLUGIN_HANDLED;
}

/* Other Console Commands */
public ConCmd_ReloadCvars( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 1 ) ) {
		return PLUGIN_CONTINUE;
	}
	
	if( read_argc( ) > 1 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_CONTINUE;
	}
	
	ReloadCvars( );
	console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "CVARS_RELOADED" );
	
	return PLUGIN_CONTINUE;
}

public ConCmd_RestartServer( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 1 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strTimer[ 8 ], iTimer;
	
	switch( read_argc( ) ) {
		case 1: {
			iTimer = DEF_TIMER;
		}
		
		case 2: {
			read_argv( 1, strTimer, 4 );
			iTimer = str_to_num( strTimer );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( iTimer == -1 ) {
		if( task_exists( TASK_COUNTDOWN_RESTART ) ) {
			remove_task( TASK_COUNTDOWN_RESTART );
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "RESTART_CANCEL" );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "RESTART_CANCEL" );
			}
			
			log_amx( "Admin %s (%s) has just canceled server restart.", strAdminName, strAdminAuthID );
		} else {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_COUNTDOWN" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	if( task_exists( TASK_COUNTDOWN_RESTART ) ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ALREADY_STARTED" );
		
		return PLUGIN_HANDLED;
	}
	
	if( task_exists( TASK_COUNTDOWN_RESTARTROUND ) || task_exists( TASK_COUNTDOWN_SHUTDOWN ) ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_IN_PROGRESS" );
		
		return PLUGIN_HANDLED;
	}
	
	if( iTimer < MIN_TIMER || iTimer > MAX_TIMER ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_BETWEEN" );
		
		return PLUGIN_HANDLED;
	}
	
	if( !iTimer ) {
		log_amx( "Admin %s (%s) has just restarted the server.", strAdminName, strAdminAuthID );
		
		server_cmd( "reload" );
	} else {
		g_iTimeLeft = iTimer + 1;
		set_task( 1.0, "Task_Countdown_Restart", TASK_COUNTDOWN_RESTART, _, _, "a", g_iTimeLeft );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "RESTART_STARTED", iTimer );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "RESTART_STARTED", iTimer );
		}
		
		log_amx( "Admin %s (%s) has inititated a %i seconds timer to restart the server.", strAdminName, strAdminAuthID, iTimer );
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_ShutdownServer( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 1 ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strTimer[ 8 ], iTimer;
	
	switch( read_argc( ) ) {
		case 1: {
			iTimer = DEF_TIMER;
		}
		
		case 2: {
			read_argv( 1, strTimer, 7 );
			iTimer = str_to_num( strTimer );
		}
		
		default: {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	new strAdminName[ 32 ], strAdminAuthID[ 36 ];
	get_user_name( iPlayerID, strAdminName, 31 );
	get_user_authid( iPlayerID, strAdminAuthID, 35 );
	
	if( iTimer == -1 ) {
		if( task_exists( TASK_COUNTDOWN_SHUTDOWN ) ) {
			remove_task( TASK_COUNTDOWN_SHUTDOWN );
			
			switch( get_pcvar_num( g_cvarShowActivity ) ) {
				case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "RESTART_CANCEL" );
				case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "RESTART_CANCEL" );
			}
			
			log_amx( "Admin %s (%s) has just canceled server shutdown.", strAdminName, strAdminAuthID );
		} else {
			console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_NO_COUNTDOWN" );
			
			return PLUGIN_HANDLED;
		}
	}
	
	if( task_exists( TASK_COUNTDOWN_SHUTDOWN ) ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ALREADY_STARTED" );
		
		return PLUGIN_HANDLED;
	}
	
	if( task_exists( TASK_COUNTDOWN_RESTARTROUND ) || task_exists( TASK_COUNTDOWN_RESTART ) ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_IN_PROGRESS" );
		
		return PLUGIN_HANDLED;
	}
	
	if( iTimer < MIN_TIMER || iTimer > MAX_TIMER ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_BETWEEN" );
		
		return PLUGIN_HANDLED;
	}
	
	if( !iTimer ) {
		log_amx( "Admin %s (%s) has just shutdown the server.", strAdminName, strAdminAuthID );
		
		server_cmd( "quit" );
	} else {
		g_iTimeLeft = iTimer + 1;
		set_task( 1.0, "Task_Countdown_Shutdown", TASK_COUNTDOWN_SHUTDOWN, _, _, "a", g_iTimeLeft );
		
		switch( get_pcvar_num( g_cvarShowActivity ) ) {
			case 1:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_1", LANG_PLAYER, "SHUTDOWN_STARTED", iTimer );
			case 2:	client_print_color( 0, iPlayerID, "^4%s^1 %L %L", g_strPluginPrefix, LANG_PLAYER, "SHOW_ACTIVITY_2", strAdminName, LANG_PLAYER, "SHUTDOWN_STARTED", iTimer );
		}
		
		log_amx( "Admin %s (%s) has inititated a %i seconds timer to shutdown the server.", strAdminName, strAdminAuthID, iTimer );
	}
	
	return PLUGIN_HANDLED;
}

public ConCmd_SearchCommands( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 2 ) ) {
		return PLUGIN_HANDLED;
	}
	
	if( read_argc( ) > 2 ) {
		console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_ARGUMENTS_NUM" );
		
		return PLUGIN_HANDLED;
	}
	
	new strArgument[ 32 ];
	read_argv( 1, strArgument, 31 );
	
	new iAdminFlag = get_user_flags( iPlayerID );
	new iNum = get_concmdsnum( iAdminFlag, -1 ) + 1;
	
	new iCommandsFlag, strCommand[ 64 ], strCommandInfo[ 256 ];
	new iTotal = 0;
	
	for( new iLoop = 0; iLoop <= iNum; iLoop++ ) {
		get_concmd( iLoop, strCommand, 63, iCommandsFlag, strCommandInfo, 255, iAdminFlag, -1 );
		
		if( containi( strCommand, strArgument ) != -1 ) {
			if( !iTotal ) {
				console_print( iPlayerID, "%s Results:", g_strPluginPrefix );
			}
			
			if( iTotal >= MAX_SEARCH_RESULTS ) {
				console_print( iPlayerID, "%s %L", g_strPluginPrefix, iPlayerID, "ERROR_TOO_MANY" );
				
				return PLUGIN_HANDLED;
			}
			
			iTotal++;
			console_print( iPlayerID, "%d: %s %s", iLoop + 1, strCommand, strCommandInfo );
		}
	}
	
	console_print( iPlayerID, "%s %L", g_strPluginPrefix, LANG_PLAYER, "SEARCH_RESULTS", iTotal, strArgument );
	
	return PLUGIN_HANDLED;
}

/* Ham Hooks */
public Ham_Spawn_Player_Post( iPlayerID ) {
	if( !is_user_alive( iPlayerID ) ) {
		return HAM_IGNORED;
	}

	SetBit( g_bitIsAlive, iPlayerID );

	if( CheckBit( g_bitHasNoClip, iPlayerID ) ) {
		set_user_noclip( iPlayerID, 1 );
	}
	
	if( CheckBit( g_bitCvarStatus, CVAR_AUTORR_KNIFE ) && task_exists( TASK_COUNTDOWN_RESTARTROUND ) ) {
		StripPlayerWeapons( iPlayerID );
	}

	if( CheckBit( g_bitHasGodmode, iPlayerID ) ) {
		set_user_godmode( iPlayerID, 1 );
	}
	
	if( CheckBit( g_bitCvarStatus, CVAR_REFUND ) ) {
		client_print_color( iPlayerID, iPlayerID, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "STARTING_MONEY", g_iSpawnMoney );
		
		cs_set_user_money( iPlayerID, g_iSpawnMoney );
	}

	if( CheckBit( g_bitHasAutoSlay, iPlayerID ) ) {
		set_task( DELAY_AUTOSLAY, "Task_AutoSlayPlayer", TASK_AUTOSLAY + iPlayerID );
	}
	
	if( g_iSpawnProtection ) {
		SetBit( g_bitHasSP, iPlayerID );
		
		switch( g_iSpawnProtectionGlow ) {
			case 1: {
				switch( cs_get_user_team( iPlayerID ) ) {
					case CS_TEAM_CT:	set_user_rendering( iPlayerID, kRenderFxGlowShell, 0, 0, 255, kRenderNormal, 5 );
					case CS_TEAM_T:		set_user_rendering( iPlayerID, kRenderFxGlowShell, 255, 0, 0, kRenderNormal, 5 );
				}
			}
			
			case 2: {
				set_user_rendering( iPlayerID, kRenderFxGlowShell, 255, 255, 255, kRenderNormal, 5 );
			}
		}
		
		set_task( float( g_iSpawnProtection ), "Task_RemoveSP", TASK_SP + iPlayerID );
	}

	return HAM_IGNORED;
}

public Ham_Killed_Player_Post( iPlayerID ) {
	if( is_user_alive( iPlayerID ) ) {
		return HAM_IGNORED;
	}

	ClearBit( g_bitIsAlive, iPlayerID );
	
	set_task( 1.0, "Task_SpectatorBug", TASK_SPECBUG + iPlayerID );

	return HAM_IGNORED;
}

public Ham_TakeDamage_Player_Pre( iVictim, iInflictor, iAttacker, Float:fDamage, iDamageBits ) {
	if( CheckBit( g_bitHasSP, iVictim ) ) {
		return HAM_SUPERCEDE;
	}
	
	return HAM_IGNORED;
}

public Ham_Touch_Weapon_Pre( iEnt, iPlayerID ) {
	if( CheckBit( g_bitCvarStatus, CVAR_AUTORR_KNIFE ) && CheckBit( g_bitIsAlive, iPlayerID ) && task_exists( TASK_COUNTDOWN_RESTARTROUND ) ) {
		return HAM_SUPERCEDE;
	}
	
	return HAM_IGNORED;
}

/* Events */
public Event_CurWeapon( iPlayerID ) {
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return PLUGIN_CONTINUE;
	}

	if( CheckBit( g_bitHasSpeed, iPlayerID ) ) {
		static Float:fMaxSpeed;
		fMaxSpeed = get_user_maxspeed( iPlayerID );

		fMaxSpeed *= 4.0;
		set_pev( iPlayerID, pev_maxspeed, fMaxSpeed );
	}

	/*
		Here it is ideal for giving unlimited ammo, we check
		when the ammo is low, we resupply the player with the 
		ammo, therefore he does not run out.
	*/
	if( CheckBit( g_bitHasUnAmmo, iPlayerID ) ) {
		static strWeaponName[ 32 ], iClip;
		static iWeaponID, iWeaponIndex;
		iWeaponID = read_data( 2 );
		iClip = read_data( 3 );

		switch( iWeaponID ) {
			case CSW_C4, CSW_KNIFE, CSW_HEGRENADE, CSW_FLASHBANG, CSW_SMOKEGRENADE: {
				return PLUGIN_CONTINUE;
			}
		}

		if( iClip ) {
			return PLUGIN_CONTINUE;
		}

		get_weaponname( iWeaponID, strWeaponName, 31 );
		iWeaponIndex = -1;
		
		while( ( iWeaponIndex = find_ent_by_class( iWeaponIndex, strWeaponName ) ) != 0 ) {
			if( iPlayerID == pev( iWeaponIndex, pev_owner ) ) {
				cs_set_weapon_ammo( iWeaponIndex, g_iWeaponClip[ iWeaponID ] );
			}
		}
	} else if( CheckBit( g_bitHasUnBPAmmo, iPlayerID ) ) {
		static iWeaponID;
		iWeaponID = read_data( 2 );

		switch( iWeaponID ) {
			case CSW_C4, CSW_KNIFE, CSW_HEGRENADE, CSW_FLASHBANG, CSW_SMOKEGRENADE: {
				return PLUGIN_CONTINUE;
			}
		}

		if( cs_get_user_bpammo( iPlayerID, iWeaponID ) != g_iWeaponBackpack[ iWeaponID ] ) {
			cs_set_user_bpammo( iPlayerID, iWeaponID, g_iWeaponBackpack[ iWeaponID ] );
		}
	}

	return PLUGIN_CONTINUE;
}

public Event_Damage( iPlayerID ) {
	/*
		Here is where the magic is done. Every time a player 
		receives any damage, we print the ammount of damage done
		to the receiver and that exact ammount to the inflicter.
	*/
	if( CheckBit( g_bitCvarStatus, CVAR_ABD ) ) {
		static iAttacker, iDamage;
		
		iAttacker = get_user_attacker( iPlayerID );
		iDamage = read_data( 2 );
		
		if( iAttacker == 0 || iAttacker > MAX_PLAYERS ) {
			return PLUGIN_CONTINUE;
		}

		set_hudmessage( 255, 0, 0, 0.45, 0.50, 2, 0.1, 4.0, 0.1, 0.1, -1 );
		ShowSyncHudMsg( iPlayerID, g_hudSync1, "%i^n", iDamage );

		if( CheckBit( g_bitIsConnected, iAttacker ) && iPlayerID != iAttacker ) {
			if( !CheckBit( g_bitCvarStatus, CVAR_ABD_WALL ) && is_visible( iAttacker, iPlayerID ) ) {
				set_hudmessage( 0, 100, 200, -1.0, 0.55, 2, 0.1, 4.0, 0.02, 0.02, -1 );
				ShowSyncHudMsg( iAttacker, g_hudSync2, "%i^n", iDamage );
			}

			if( CheckBit( g_bitCvarStatus, CVAR_ABD_WALL ) ) {
				set_hudmessage( 0, 100, 200, -1.0, 0.55, 2, 0.1, 4.0, 0.02, 0.02, -1 );
				ShowSyncHudMsg( iAttacker, g_hudSync2, "%i^n", iDamage );
			}
		}
	}
	
	return PLUGIN_CONTINUE;
}

public Event_SayText( iReceiver ) {
	if( !CheckBit( g_bitCvarStatus, CVAR_ADMINLISTEN ) && !CheckBit( g_bitCvarStatus, CVAR_DEADLISTEN ) ) {
		return PLUGIN_CONTINUE;
	}

	/*
		In here is where I check the messages and prints them
		to the admins and dead players as well.
	*/
	static iSender, strMessage[ 256 ], iLoop;
	static strChannel[ 356 ], strSenderName[ 32 ], bool:bCount[ 33 ][ 33 ];
	iSender = read_data( 1 );

	read_data( 2, strChannel, 255 );
	read_data( 4, strMessage, 255 );
	get_user_name( iSender, strSenderName, 31 );

	bCount[ iSender ][ iReceiver ] = true;

	if( iSender == iReceiver ) {
		static iPlayers[ 32 ], iNum, iTempID;
		get_players( iPlayers, iNum );

		for( iLoop = 0; iLoop < iNum; iLoop ++ ) {
			iTempID = iPlayers[ iLoop ];

			if( !bCount[ iSender ][ iTempID ] ) {
				if( CheckBit( g_bitCvarStatus, CVAR_ADMINLISTEN ) && ( get_user_flags( iTempID ) & ADMIN_LISTEN ) ) {
					message_begin( MSG_ONE, g_msgSayText, { 0, 0, 0 }, iTempID );
					write_byte( iSender );
					write_string( strChannel );
					write_string( strSenderName );
					write_string( strMessage );
					message_end( );	
				} else if( CheckBit( g_bitCvarStatus, CVAR_DEADLISTEN ) && !CheckBit( g_bitIsAlive, iTempID ) && CheckBit( g_bitIsAlive, iSender ) ) {
					message_begin( MSG_ONE, g_msgSayText, { 0, 0, 0 }, iTempID );
					write_byte( iSender );
					write_string( strChannel );
					write_string( strSenderName );
					write_string( strMessage );
					message_end( );
				}
			}

			bCount[ iSender ][ iTempID ] = false;
		}
	}

	return PLUGIN_CONTINUE;
}

public Event_SayText_Team( iReceiver ) {
	if( !CheckBit( g_bitCvarStatus, CVAR_ADMINLISTEN_TEAM ) && !CheckBit( g_bitCvarStatus, CVAR_DEADLISTEN_TEAM ) ) {
		return PLUGIN_CONTINUE;
	}
	
	/*
		In here is where I check the messages and prints them
		to the admins and dead players as well.
	 */
	static iSender, strMessage[ 256 ], iLoop;
	static strChannel[ 356 ], strSenderName[ 32 ], bool:bCount[ 33 ][ 33 ];
	
	
	iSender = read_data( 1 );
	read_data( 2, strChannel, 255 );
	read_data( 4, strMessage, 255 );
	get_user_name( iSender, strSenderName, 31 );
	
	bCount[ iSender ][ iReceiver ] = true;
	
	if( iSender == iReceiver ) {
		static iPlayers[ 32 ], iNum, iTempID;
		get_players( iPlayers, iNum );
		
		for( iLoop = 0; iLoop < iNum; iLoop ++ ) {
			iTempID = iPlayers[ iLoop ];
			
			if( !bCount[ iSender ][ iTempID ] ) {
				if( CheckBit( g_bitCvarStatus, CVAR_ADMINLISTEN_TEAM ) && ( get_user_flags( iTempID ) & ADMIN_LISTEN ) ) {
					if( cs_get_user_team( iSender ) == cs_get_user_team( iTempID ) ) {
						message_begin( MSG_ONE, g_msgSayText, { 0, 0, 0 }, iTempID );
						write_byte( iSender );
						write_string( strChannel );
						write_string( strSenderName );
						write_string( strMessage );
						message_end( );
					}
				} else if( CheckBit( g_bitCvarStatus, CVAR_DEADLISTEN_TEAM ) && !CheckBit( g_bitIsAlive, iTempID ) && CheckBit( g_bitIsAlive, iSender ) ) {
					if( cs_get_user_team( iSender ) == cs_get_user_team( iTempID ) ) {
						message_begin( MSG_ONE, g_msgSayText, { 0, 0, 0 }, iTempID );
						write_byte( iSender );
						write_string( strChannel );
						write_string( strSenderName );
						write_string( strMessage );
						message_end( );
					}
				}
			}
			
			bCount[ iSender ][ iTempID ] = false;
		}
	}
	
	return PLUGIN_CONTINUE;
}

public Event_HLTV( ) {
	ReloadCvars( );
	
	g_bFreezeTime = true;
	g_bSpawn = true;
	g_bPlanting = false;
	g_iBombCarrier = 0;
	
	new iPlayers[ 32 ], iNum;
	new iTempID, iLoop, iTaskID;
	get_players( iPlayers, iNum, "a" );
	
	for( iLoop = 0; iLoop < iNum; iLoop++ ) {
		iTempID = iPlayers[ iLoop ];
		
		iTaskID = TASK_UBERSLAP + iTempID;
		
		if( task_exists( iTaskID ) ) {
			remove_task( iTaskID );
		}
		
		if( !CheckBit( g_bitHasGlow, iTempID ) && !CheckBit( g_bitHasSP, iTempID ) ) {
			set_user_rendering( iTempID );
		}
	}
}

public Event_WeapPickup( iPlayerID ) {
	g_iBombCarrier = iPlayerID;
}

public Event_BarTime( iPlayerID ) {
	if( iPlayerID == g_iBombCarrier ) {
		g_bPlanting = bool:read_data( 1 );
		get_user_origin( iPlayerID, g_iPlayerOrigin[ iPlayerID ] );
		g_iPlayerTime[ iPlayerID ] = 0;
	}
}

public Event_TextMsg( ) {
	g_bSpawn = false;
	g_bPlanting = false;
	g_iBombCarrier = 0;
}

/* LogEvents */
public LogEvent_RoundStart( ) {
	if( CheckBit( g_bitCvarStatus, CVAR_AUTORR ) && !g_bRestartedRound ) {
		g_iTimeLeft = get_pcvar_num( g_pcvarAutoRestartTime ) + 1;
		set_task( 1.0, "Task_Countdown_RestartRound", TASK_COUNTDOWN_RESTARTROUND, _, _, "a", g_iTimeLeft );
		
		if( CheckBit( g_bitCvarStatus, CVAR_AUTORR_KNIFE ) ) {
			new iPlayers[ 32 ], iNum, iTempID;
			get_players( iPlayers, iNum, "a" );
			
			for( new iLoop = 0; iLoop < iNum; iLoop++ ) {
				iTempID = iPlayers[ iLoop ];
				
				StripPlayerWeapons( iTempID );
				UpdatePlayerMapZones( iTempID );
			}
			
			if( g_hamTouchArmouryEntity ) {
				EnableHamForward( g_hamTouchArmouryEntity );
			} else {
				g_hamTouchArmouryEntity = RegisterHam( Ham_Touch, 		"armoury_entity", 	"Ham_Touch_Weapon_Pre",		false );
			}
			
			if( g_hamTouchWeaponBox ) {
				EnableHamForward( g_hamTouchWeaponBox );
			} else {
				g_hamTouchWeaponBox	= RegisterHam( Ham_Touch, 		"weaponbox", 		"Ham_Touch_Weapon_Pre",		false );
			}
		}

		g_bRestartedRound = true;
	}

	new iPlayers[ 32 ], iNum, iTempID, iLoop;
	get_players( iPlayers, iNum, "a" );

	if( !iNum ) {
		return PLUGIN_CONTINUE;
	}

	g_bFreezeTime = false;

	for( iLoop = 0; iLoop < iNum; iLoop++ ) {
		iTempID = iPlayers[ iLoop ];

		if( CheckBit( g_bitCvarStatus, CVAR_AFK ) ) {
			get_user_origin( iTempID, g_iPlayerOrigin[ iTempID ] );
			g_iPlayerTime[ iTempID ] = 0;
		}
		
		/*if( !CheckBit( g_bitHasGlow, iTempID ) && !CheckBit( g_bitHasSP, iTempID ) ) {
			set_user_rendering( iTempID );
		}*/
		
		if( CheckBit( g_bitHasSpeed, iTempID ) ) {
			set_task( 0.1, "Task_InitiateCurWeapon", TASK_CURWEAPON + iTempID );
		}
	}

	return PLUGIN_CONTINUE;
}

public LogEvent_BombPlanted( ) {
	new iPlayers[ 32 ], iNum, iLoop;
	get_players( iPlayers, iNum, "ac" );

	for( iLoop = 0; iLoop < iNum; iLoop++ ) {
		set_task( 1.0, "Task_UpdateTimer", TASK_UPDATETIMER + iPlayers[ iLoop ] );
	}
}

/* Menu */
public Menu_TeamSelect( iPlayerID, iKey ) {
	if( g_bBlockTeamJoin[ iKey ] ) {
		engclient_cmd( iPlayerID, "chooseteam" );
		return PLUGIN_HANDLED;
	}

	return PLUGIN_CONTINUE;
}

DisplayMuteMenu( iPlayerID ) {
	new strMenuTitle[ 64 ];
	formatex( strMenuTitle, 63, "\yMute/Unmute Menu:" );
	
	g_menuMuteMenu[ iPlayerID ] = menu_create( strMenuTitle, "Handle_MuteMenu" );
	
	new strPlayerName[ 32 ], iPlayers[ 32 ], strID[ 8 ];
	new iLoop, iNum, iTempID;
	get_players( iPlayers, iNum );
	
	if( iNum <= 1 ) {
		client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", iPlayerID, "ERROR_PLAYER_ALONE" );
		
		return PLUGIN_HANDLED;
	}
	
	for( iLoop = 0; iLoop < iNum; iLoop++ ) {
		iTempID = iPlayers[ iLoop ];
		
		if( iPlayerID == iTempID ) {
			continue;
		}
		
		num_to_str( iTempID, strID, 7 );
		get_user_name( iTempID, strPlayerName, 31 );
		
		if( CheckBit( g_bitIsMuted[ iPlayerID ], iTempID ) ) {
			format( strPlayerName, 31, "\d(M) %s", strPlayerName );
		}
		
		menu_additem( g_menuMuteMenu[ iPlayerID ], strPlayerName, strID );
	}
	
	menu_setprop( g_menuMuteMenu[ iPlayerID ], MPROP_NUMBER_COLOR, "\y" );
	
	menu_display( iPlayerID, g_menuMuteMenu[ iPlayerID ], 0 );
	
	return PLUGIN_HANDLED;
}

public Handle_MuteMenu( iPlayerID, iMenu, iKey ) {
	if( iKey == MENU_EXIT ) {
		menu_destroy( g_menuMuteMenu[ iPlayerID ] );
		
		return PLUGIN_HANDLED;
	}
	
	static strPlayerID[ 32 ], strPlayerName[ 32 ], iAccess, iCallback;
	menu_item_getinfo( iMenu, iKey, iAccess, strPlayerID, 31, strPlayerName, 31, iCallback );
	
	static iTarget;
	iTarget = str_to_num( strPlayerID );
	
	if( CheckBit( g_bitIsMuted[ iPlayerID ], iTarget ) ) {
		ClearBit( g_bitIsMuted[ iPlayerID ], iTarget );
		
		get_user_name( iTarget, strPlayerName, 31 );
		
		client_print_color( iPlayerID, iTarget, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "ACTION_UNMUTE", strPlayerName );
	} else {
		SetBit( g_bitIsMuted[ iPlayerID ], iTarget );
		
		client_print_color( iPlayerID, iTarget, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "ACTION_MUTE", strPlayerName );
	}
	
	menu_destroy( g_menuMuteMenu[ iPlayerID ] );
	DisplayMuteMenu( iPlayerID );
	
	return PLUGIN_HANDLED;
}

DisplayRecentelyUsed( iPlayerID ) {
	new strMenuTitle[ 64 ];
	formatex( strMenuTitle, 63, "\yRecentely Used Commands:" );
	
	new menuRecentelyUsed = menu_create( strMenuTitle, "Handle_RecentelyUsedMenu" );
	new strCommandID[ 8 ];
	
	for( new iLoop = 0; iLoop < MAX_COMMANDS; iLoop++ ) {
		if( is_str_empty( g_strPlayerCommand[ iLoop ] ) ) {
			continue;
		}
		
		num_to_str( iLoop, strCommandID, 7 );
		
		menu_additem( menuRecentelyUsed, g_strPlayerCommand[ iLoop ], strCommandID );
	}
	
	menu_setprop( menuRecentelyUsed, MPROP_NUMBER_COLOR, "\y" );
	
	menu_display( iPlayerID, menuRecentelyUsed, 0 );
}

public Handle_RecentelyUsedMenu( iPlayerID, iMenu, iKey ) {
	if( iKey == MENU_EXIT ) {
		menu_destroy( iMenu );
		
		return PLUGIN_HANDLED;
	}
	
	static strCommandID[ 8 ], iAccess, iCallback;
	menu_item_getinfo( iMenu, iKey, iAccess, strCommandID, 7, _, _, iCallback );
	
	client_cmd( iPlayerID, g_strPlayerCommand[ str_to_num( strCommandID ) ] );
	
	DisplayRecentelyUsed( iPlayerID );
	
	return PLUGIN_HANDLED;
}

/* Forwards */
public Forward_SetClientListening( iReceiver, iSender, bool:bListen ) {
	if( !is_user( iReceiver ) || !CheckBit( g_bitIsConnected, iReceiver ) ||
	!is_user( iSender) || !CheckBit( g_bitIsConnected, iSender ) ) {
		return FMRES_IGNORED;
	}
	
	if( iReceiver == iSender ) {
		return FMRES_IGNORED;
	}
	
	if( CheckBit( g_bitIsMuted[ iReceiver ], iSender ) ) {
		engfunc( EngFunc_SetClientListening, iReceiver, iSender, 0 );
		
		return FMRES_SUPERCEDE;
	}
	
	if( g_iPlayerGagFlags[ iSender ] & GAG_VOICE ) {
		engfunc( EngFunc_SetClientListening, iReceiver, iSender, 0 );
		
		return FMRES_SUPERCEDE;
	}
	
	return FMRES_IGNORED;
}

/* Messages */
public Message_SayText( ) {
	new strMessage[ 32 ];
	get_msg_arg_string( 2, strMessage, 31 );
	
	if( equal( strMessage, "#Cstrike_Name_Change" ) ) {
		new iPlayerID;
		
		get_msg_arg_string( 3, strMessage, 31 );
		iPlayerID = get_user_index( strMessage );
		
		if( CheckBit( g_bitIsConnected, iPlayerID ) && g_iPlayerGagFlags[ iPlayerID ] ) {
			return PLUGIN_HANDLED;
		}
		
		get_msg_arg_string( 4, strMessage, 31 );
		iPlayerID = get_user_index( strMessage );
		
		if( CheckBit( g_bitIsConnected, iPlayerID ) && g_iPlayerGagFlags[ iPlayerID ] ) {
			return PLUGIN_HANDLED;
		}
	}
	
	return PLUGIN_CONTINUE;
}

public Message_StatusIcon( iMessageID, iDestination, iPlayerID ) {
	if( CheckBit( g_bitHasNoBuy, iPlayerID ) || CheckBit( g_bitCvarStatus, CVAR_AUTORR_KNIFE ) && task_exists( TASK_COUNTDOWN_RESTARTROUND ) ) {
		static strIcon[ 5 ];
		get_msg_arg_string( 2, strIcon, 4 );
		
		if( strIcon[ 0 ] == 'b' && strIcon[ 2 ] == 'y' && strIcon[ 3 ] == 'z' ) {
			if( get_msg_arg_int( 1 ) ) {
				set_pdata_int( iPlayerID, 235, get_pdata_int( iPlayerID, 235, 5 ) & ~( 1<<0 ), 5 );
				
				return PLUGIN_HANDLED;
			}
		}
	}
	
	return PLUGIN_CONTINUE;
}

/* Task Functions */
public Task_PlayerRevived( iTaskID ) {
	new iPlayerID = iTaskID - TASK_REVIVE;
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return PLUGIN_HANDLED;
	}
	
	StripPlayerWeapons( iPlayerID );
	
	switch( cs_get_user_team( iPlayerID ) ) {
		case CS_TEAM_CT: {
			give_item( iPlayerID, "weapon_usp" );
			cs_set_user_bpammo( iPlayerID, CSW_USP, BPAMMO_USP );
		}
		
		case CS_TEAM_T: {
			give_item( iPlayerID, "weapon_glock18" );
			cs_set_user_bpammo( iPlayerID, CSW_GLOCK18, BPAMMO_GLOCK18 );
		}
		
		/*
			Here I am checking if the player is a spectator, so I can glow him.
			Because alive specs have the same skins as the ct players. Therefore 
			players can differentiate between cts and specs.
		*/	
		case CS_TEAM_SPECTATOR: {
			set_user_rendering( iPlayerID, kRenderFxGlowShell, 255, 255, 255, kRenderNormal, 5 );
		}
	}
	
	if( g_iSpawnHealth != SPAWN_DEF_HEALTH ) {
		set_user_health( iPlayerID, g_iSpawnHealth );
	}
	
	cs_set_user_armor( iPlayerID, g_iSpawnArmor, CS_ARMOR_VESTHELM );
	
	return PLUGIN_HANDLED;
}

public Task_RemoveBadaim( iTaskID ) {
	new iPlayerID = iTaskID - TASK_BADAIM;
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return PLUGIN_HANDLED;
	}
	
	new strPlayerName[ 32 ];
	get_user_name( iPlayerID, strPlayerName, 31 );
	
	client_print_color( 0, iPlayerID, "^4%s^1 %L", LANG_PLAYER, "BADAIM_NOMORE", strPlayerName );

	ClearBit( g_bitHasBadaim, iPlayerID );
	
	return PLUGIN_HANDLED;
}

public Task_UpdateTimer( iTaskID ) {
	static iPlayerID;
	iPlayerID = iTaskID - TASK_UPDATETIMER;

	message_begin( MSG_ONE_UNRELIABLE, g_msgShowTimer, _, iPlayerID );
	message_end( );

	message_begin( MSG_ONE_UNRELIABLE, g_msgRoundTime, _, iPlayerID );
	write_short( g_iC4Timer );
	message_end( );

	message_begin( MSG_ONE_UNRELIABLE, g_msgScenario, _, iPlayerID );
	write_byte( 1 );
	write_string( "bombticking" );
	write_byte( 150 );
	write_short( 0 );
	message_end( );
}

public Task_AFK_BombCheck( iTaskID ) {
	if( g_bFreezeTime || !CheckBit( g_bitCvarStatus, CVAR_AFK ) || !CheckBit( g_bitCvarStatus, CVAR_AFK_BOMBTRANSFER ) || !g_iBombCarrier ) {
		return PLUGIN_CONTINUE;
	}
	
	if( g_iPlayerTime[ g_iBombCarrier ] < g_iAFKTime_Bomb ) {
		return PLUGIN_CONTINUE;
	}

	static iDistance, iReceiver, iOrigin2[ 3 ], iMinDistance;
	iMinDistance = 999999;
	iReceiver = 0;

	static iPlayers[ 32 ], iNum, iTempID, iOrigin[ 3 ], iLoop;
	get_players( iPlayers, iNum, "ae", "TERRORIST" );

	get_user_origin( g_iBombCarrier, iOrigin );

	if( iNum < 2 ) {
		return PLUGIN_CONTINUE;
	}
	
	for( iLoop = 0; iLoop < iNum; iLoop++ ) {
		iTempID = iPlayers[ iLoop ];
		
		if( g_iPlayerTime[ iTempID ] < g_iAFKTime_Bomb ) {
			get_user_origin( iTempID, iOrigin2 );
			iDistance = get_distance( iOrigin, iOrigin2 );
			
			if( iDistance < iMinDistance ) {
				iMinDistance = iDistance;
				iReceiver = iTempID;
			}
		}
	}
	
	if( !iReceiver ) {
		return PLUGIN_CONTINUE;
	}

	static iBombEnt, iBackpack;
	engclient_cmd( g_iBombCarrier, "drop", "weapon_c4" );
	iBombEnt = find_ent_by_class( -1, "weapon_c4" );

	if( !iBombEnt ) {
		return PLUGIN_CONTINUE;
	}

	iBackpack = pev( iBombEnt, pev_owner );
	if( iBackpack <= MAX_PLAYERS ) {
		return PLUGIN_CONTINUE;
	}
	
	static strCarrierName[ 32 ];
	get_user_name( g_iBombCarrier, strCarrierName, 31 );

	set_pev( iBackpack, pev_flags, pev( iBackpack, pev_flags ) | FL_ONGROUND );
	fake_touch( iBackpack, iReceiver );

	set_hudmessage( 0, 255, 0, 0.35, 0.8, _, _, 7.0, _, _, -1 );
	static strMessage[ 128 ], strReceiverName[ 32 ];
	get_user_name( iReceiver, strReceiverName, 31 );

	formatex( strMessage, 127, "Bomb transferred to ^"%s^"^n since^"%s^" is AFK", strReceiverName, strCarrierName );
	ShowSyncHudMsg( 0, g_hudSync4, strMessage );

	return PLUGIN_CONTINUE;
}

public Task_AFK_Check( iTaskID ) {
	if( !CheckBit( g_bitCvarStatus, CVAR_AFK ) ) {
		return PLUGIN_CONTINUE;
	}
	
	static iPlayers[ 32 ], iNum, iTempID, iLoop, iTime;
	
	if( !g_bFreezeTime ) {
		static iOrigin[ 3 ];
		get_players( iPlayers, iNum, "a" );
		
		for( iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			get_user_origin( iTempID, iOrigin );
			
			if( iOrigin[ 0 ] != g_iPlayerOrigin[ iTempID ][ 0 ] ||
			iOrigin[ 1 ] != g_iPlayerOrigin[ iTempID ][ 1 ] ||
			iOrigin[ 2 ] != g_iPlayerOrigin[ iTempID ][ 2 ] ||
			( iTempID == g_iBombCarrier && g_bPlanting ) ) {
				g_iPlayerTime[ iTempID ] = 0;
				
				g_iPlayerOrigin[ iTempID ][ 0 ] = iOrigin[ 0 ];
				g_iPlayerOrigin[ iTempID ][ 1 ] = iOrigin[ 1 ];
				g_iPlayerOrigin[ iTempID ][ 2 ] = iOrigin[ 2 ];
				
				if( g_bSpawn && iTempID == g_iBombCarrier ) {
					g_bSpawn = false;
				}
			} else {
				g_iPlayerTime[ iTempID ] += AFK_FREQUENCY;
			}
			
			if( access( iTempID, AFK_IMMUNITY ) ) {
				continue;
			}
			
			iTime = g_iPlayerTime[ iTempID ];
			
			if( iTime == ( g_iAFKTime - AFK_WARNING ) ) {
				client_print_color( iTempID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iTempID, "AFK_WARNING", g_iPlayerTime[ iTempID ] );
			}
			
			if( iTime < g_iAFKTime ) {
				continue;
			}
			
			PunsihAFKPlayer( iTempID );
		}
	}
	
	if( CheckBit( g_bitCvarStatus, CVAR_AFK_SPECTATORS ) ) {
		get_players( iPlayers, iNum, "e", "SPECTATOR" );
		
		for( iLoop = 0; iLoop < iNum; iLoop++ ) {
			iTempID = iPlayers[ iLoop ];
			
			g_iPlayerTime[ iTempID ] += AFK_FREQUENCY;
			
			if( access( iTempID, AFK_IMMUNITY ) ) {
				continue;
			}
			
			iTime = g_iPlayerTime[ iTempID ];
			
			if( iTime == ( g_iAFKSpectatorsTime - AFK_WARNING ) ) {
				client_print_color( iTempID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iTempID, "AFK_WARNING_SPEC", g_iPlayerTime[ iTempID ] );
			}
			
			if( iTime < g_iAFKSpectatorsTime ) {
				continue;
			}
			
			server_cmd( "kick #%d ^"You have been a spectator for more than %d seconds.^"", get_user_userid( iTempID ), g_iAFKSpectatorsTime );
		}
	}

	return PLUGIN_CONTINUE;
}

public Task_Advertisement( iTaskID ) {
	client_print_color( 0, print_team_red, "^4%s^1 %L", g_strPluginPrefix, LANG_PLAYER, "VERSION_DISPLAY", g_strPluginName, g_strPluginVersion, g_bNeedToUpdate ? " ^1(^3plugin needs to be updated^1)" : "", g_strPluginAuthor );
}

public Task_AutoSlayPlayer( iTaskID ) {
	new iPlayerID = iTaskID - TASK_AUTOSLAY;
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		remove_task( iTaskID );
		
		return PLUGIN_HANDLED;
	}
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return PLUGIN_HANDLED;
	}

	user_kill( iPlayerID );

	client_print_color( iPlayerID, print_team_red, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "AUTO_SLAY" );
	
	return PLUGIN_HANDLED;
}

public Task_UberslapPlayer( iTaskID ) {
	static iPlayerID;
	iPlayerID = iTaskID - TASK_UBERSLAP;
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		remove_task( iTaskID );
		
		return PLUGIN_HANDLED;
	}

	if( get_user_health( iPlayerID ) > 1 ) {
		user_slap( iPlayerID, 1 );
	} else {
		user_slap( iPlayerID, 0 );
	}
	
	return PLUGIN_HANDLED;
}

public Task_Countdown_Shutdown( ) {
	g_iTimeLeft--;

	static strNumber[ 32 ];

	switch( g_iTimeLeft ) {
		case 1..10: {
			num_to_word( g_iTimeLeft, strNumber, 31 );
			client_cmd( 0, "spk ^"fvox/%s^"", strNumber );
		}

		case 0: {
			server_cmd( "quit" );
		}
	}
}

public Task_Countdown_RestartRound( ) {
	g_iTimeLeft--;

	static strNumber[ 32 ];

	if( CheckBit( g_bitCvarStatus, CVAR_AUTORR_KNIFE ) ) {
		set_hudmessage( 0, 255, 0, -1.0, 0.25, _, _, _, _, _, -1 );
		ShowSyncHudMsg( 0, g_hudSync3, "Knife warmup^nRestart round in %i seconds", g_iTimeLeft );
	} else {
		set_hudmessage( 0, 255, 0, -1.0, 0.25, _, _, _, _, _, -1 );
		ShowSyncHudMsg( 0, g_hudSync3, "Restart round in %i seconds", g_iTimeLeft );
	}

	switch( g_iTimeLeft ) {
		case 1..10: {
			num_to_word( g_iTimeLeft, strNumber, 31 );
			client_cmd( 0, "spk ^"fvox/%s^"", strNumber );
		}

		case 0: {
			server_cmd( "sv_restartround 1" );
			
			if( CheckBit( g_bitCvarStatus, CVAR_AUTORR_KNIFE ) ) {
				if( g_hamTouchArmouryEntity ) {
					DisableHamForward( g_hamTouchArmouryEntity );
				}
				
				if( g_hamTouchWeaponBox ) {
					DisableHamForward( g_hamTouchWeaponBox );
				}
			}
		}
	}
}

public Task_Countdown_Restart( ) {
	g_iTimeLeft--;

	static strNumber[ 32 ];

	switch( g_iTimeLeft ) {
		case 1..10: {
			num_to_word( g_iTimeLeft, strNumber, 31 );
			client_cmd( 0, "spk ^"fvox/%s^"", strNumber );
		}

		case 0: {
			server_cmd( "reload" );
		}
	}
}

public Task_SpectatorBug( iTaskID ) {
	client_cmd( iTaskID - TASK_SPECBUG, "+duck;-duck;spec_menu 0" );
}

public Task_UngagPlayer( iTaskID ) {
	new iPlayerID = iTaskID - TASK_UNGAG;
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return;
	}
	
	g_iPlayerGagFlags[ iPlayerID ] = 0;
	
	if( task_exists( TASK_UNGAG + iPlayerID ) ) {
		remove_task( TASK_UNGAG + iPlayerID );
	}

	client_print_color( iPlayerID, print_team_default, "^4%s^1 %L", g_strPluginPrefix, iPlayerID, "GAGGED_NOMORE" );
}

public Task_PlayerPutInServer( iTaskID ) {
	static iPlayerID;
	iPlayerID = iTaskID - TASK_PUTINSERVER;
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return PLUGIN_CONTINUE;
	}
	
	get_pcvar_string( g_pcvarConnectMessage,	g_strConnectMessage,	127 );
	
	if( is_str_empty( g_strConnectMessage ) ) {
		return PLUGIN_CONTINUE;
	}
	
	static strHostname[ 64 ];
	get_pcvar_string( g_cvarHostname, strHostname, 63 );
	replace_all( g_strConnectMessage, 127, "%hostname%", strHostname );
	
	if( cvar_exists( "csstats_reset" ) ) {
		static strData[ 8 ], strRank[ 8 ], iPosition;
		
		iPosition = get_user_stats( iPlayerID, strData, strData );
		num_to_str( iPosition, strRank, 7 );
		
		static strPlayerName[ 32 ];
		get_user_name( iPlayerID, strPlayerName, 31 );
		
		replace_all( g_strConnectMessage, 127, "%rankpos%", strRank );
		replace_all( g_strConnectMessage, 127, "%name", strPlayerName );
		replace_all( g_strConnectMessage, 127, "\n", "^n" );
		
		if( get_user_flags( iPlayerID ) & ADMIN_RESERVATION ) {
			set_hudmessage( 255, 0, 0, 0.10, 0.55, 0, 6.0, 6.0, 0.5, 0.15, 3 );
			
			client_cmd( 0, "spk buttons/blip1.wav" );
		} else {
			set_hudmessage( 0, 255, 0, 0.10, 0.55, 0, 6.0, 6.0, 0.5, 0.15, 3 );
		}
		
		ShowSyncHudMsg( 0, g_hudSync6, g_strConnectMessage );
	}
	
	return PLUGIN_CONTINUE;
}

public Task_PlayerPutInServer_HUD( iTaskID ) {
	static iPlayerID;
	iPlayerID = iTaskID - TASK_PUTINSERVER_HUD;
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return PLUGIN_CONTINUE;
	}
	
	static strPlayerName[ 32 ], strPlayerAuthID[ 36 ], strPlayerIP[ 16 ];
	get_user_name( iPlayerID, strPlayerName, 31 );
	get_user_authid( iPlayerID, strPlayerAuthID, 35 );
	get_user_ip( iPlayerID, strPlayerIP, 15 );
	
	static iPlayers[ 32 ], iNum, iTempID, iLoop;
	get_players( iPlayers, iNum );
	
	for( iLoop = 0; iLoop < iNum; iLoop++ ) {
		iTempID = iPlayers[ iLoop ];
		
		if( access( iTempID, ADMIN_AUTHORIZED ) ) {
			client_print_color( iTempID, iPlayerID, "^4%s^1 %L", g_strPluginPrefix, iTempID, "CONNECT_ADMIN", strPlayerName, strPlayerAuthID, strPlayerIP );
		} else {
			client_print_color( iTempID, iPlayerID, "^4%s^1 %L", g_strPluginPrefix, iTempID, "CONNECT_USER", strPlayerName );
		}
	}
	
	return PLUGIN_CONTINUE;
}

public Task_InitiateCurWeapon( iTaskID ) {
	new iPlayerID;
	iPlayerID = iTaskID - TASK_CURWEAPON;
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return;
	}
	
	Event_CurWeapon( iPlayerID );
}

public Task_RemoveSP( iTaskID ) {
	static iPlayerID;
	iPlayerID = iTaskID - TASK_SP;
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return;
	}
	
	ClearBit( g_bitHasSP, iPlayerID );
	
	if( g_iSpawnProtectionGlow ) {
		set_user_rendering( iPlayerID );
	}
}

public Task_GetAnswer( iTaskID ) {
	if( socket_change( g_iSocket ) ) {
		socket_recv( g_iSocket, g_strData, 1023 );
		
		new iPosition = containi( g_strData, "UltimatePlugin v" );
		
		if( iPosition >= 0 ) {
			iPosition += strlen( "UltimatePlugin v" );
			
			new iLength = 0;
			
			for( new iLoop = 0; iLoop < 16; iLoop++ ) {
				if( iLength < 5 && ('0' <= g_strData[ iPosition + iLoop ] <= '9' || g_strData[ iPosition + iLoop ] == '.'  ) ) {
					g_strSocketVersion[ iLength ] = g_strData[ iPosition + iLoop ];
					iLength++;
				}
			}
			
			CompareVersions( iLength );
			
			log_amx( "Versions have been compared. %s!", g_bNeedToUpdate ? "Plugin is outdated" : "Plugin is up to date" );
			
			if( g_bNeedToUpdate ) {
				client_print_color( 0, print_team_red, "^4%s^1 A new version of ^4UltimatePlugin ^1has been released (^4v%s^1). ^3You are recommended to update ASAP^1.", g_strPluginPrefix, g_strSocketVersion );
			}
			
			socket_close( g_iSocket );
			
			remove_task( TASK_GETANSWER );
			remove_task( TASK_CLOSECONNECTION );
		}
	}
}

public Task_CloseConnection( iTaskID ) {
	socket_close( g_iSocket );
}

/* Other Public Functions */
public RocketLiftoff( strPlayer[ ] ) {
	new iVictim;
	iVictim = strPlayer[ 0 ];

	set_user_gravity( iVictim, -0.50 );
	client_cmd( iVictim, "+jump;wait;wait;-jump" );

	emit_sound( iVictim, CHAN_VOICE, g_strSounds[ SOUND_ROCKET ], 1.0, 0.5, 0, PITCH_NORM );
	RocketEffects( strPlayer );
}

public RocketEffects( strPlayer[ ] ) {
	static iVictim;
	iVictim = strPlayer[ 0 ];

	if( CheckBit( g_bitIsAlive, iVictim ) ) {
		static iOrigin[ 3 ];
		get_user_origin( iVictim, iOrigin );

		message_begin( MSG_ONE, g_msgDamage, { 0, 0, 0 }, iVictim );
		write_byte( 30 );			// Damage save
		write_byte( 30 );			// Damage take
		write_long( 1<<16 );			// Visible Damage Bits
		write_coord( iOrigin[ 0 ] );		// X Origin
		write_coord( iOrigin[ 1 ] );		// Y Origin
		write_coord( iOrigin[ 2 ] );		// Z Origin
		message_end( );

		if( g_iRocket[ iVictim ] == iOrigin[ 2 ] ) {
			RocketExplode( iVictim );
		}

		g_iRocket[ iVictim ] = iOrigin[ 2 ];

		// TE_SPRITETRAIL
		message_begin( MSG_BROADCAST, SVC_TEMPENTITY );
		write_byte( 15 );
		write_coord( iOrigin[ 0 ] );				// Start
		write_coord( iOrigin[ 1 ] );
		write_coord( iOrigin[ 2 ] );
		write_coord( iOrigin[ 0 ] );				// End
		write_coord( iOrigin[ 1 ] );
		write_coord( iOrigin[ 2 ] - 30 );
		write_short( g_iSprites[ SPRITE_BLUEFLARE ] );		// Sprite
		write_byte( 5 );					// Count
		write_byte( 1 );					// Life (0.1)
		write_byte( 1 );					// Scale (0.1)
		write_byte( 10 );					// Velocity (0.1)
		write_byte( 5 );					// Randomness (0.1)
		message_end( );

		// TE_SPRITE
		message_begin( MSG_BROADCAST, SVC_TEMPENTITY );
		write_byte( 17 );
		write_coord( iOrigin[ 0 ] );
		write_coord( iOrigin[ 1 ] );
		write_coord( iOrigin[ 2 ] - 30 );
		write_short( g_iSprites[ SPRITE_MUZZLEFALSH ] );
		write_byte( 15 );					// Scale (0.1)
		write_byte( 255 );					// Brightness
		message_end( );

		set_task( 0.2, "RocketEffects", TASK_ROCKETEFFECTS, strPlayer, 2 );
	}
}

public IgniteEffects( strPlayer[ ] ) {
	static iPlayerID;
	iPlayerID = strPlayer[ 0 ];

	if( CheckBit( g_bitIsAlive, iPlayerID ) && CheckBit( g_bitIsOnFire, iPlayerID ) ) {
		static iOrigin[ 3 ];
		get_user_origin( iPlayerID, iOrigin );

		message_begin( MSG_BROADCAST, SVC_TEMPENTITY );
		write_byte( 17 );
		write_coord( iOrigin[ 0 ] );
		write_coord( iOrigin[ 1 ] );
		write_coord( iOrigin[ 2 ] );
		write_short( g_iSprites[ SPRITE_MUZZLEFALSH ] );
		write_byte( 20 );
		write_byte( 200 );
		message_end( );

		message_begin( MSG_BROADCAST, SVC_TEMPENTITY, iOrigin );
		write_byte( 5 );
		write_coord( iOrigin[ 0 ] );
		write_coord( iOrigin[ 1 ] );
		write_coord( iOrigin[ 2 ] );
		write_short( g_iSprites[ SPRITE_SMOKE ] );
		write_byte( 20 );
		write_byte( 15 );
		message_end( );

		set_task( 0.2, "IgniteEffects", 0, strPlayer, 2 );
	} else {
		if( CheckBit( g_bitIsOnFire, iPlayerID ) ) {
			emit_sound( iPlayerID, CHAN_AUTO, g_strSounds[ SOUND_SCREAM21 ], 0.6, ATTN_NORM, 0, PITCH_HIGH );
			ClearBit( g_bitIsOnFire, iPlayerID );
		}
	}
}

public IgnitePlayer( strPlayer[ ] ) {
	static iPlayerID;
	iPlayerID = strPlayer[ 0 ];

	if( CheckBit( g_bitIsAlive, iPlayerID ) && CheckBit( g_bitIsOnFire, iPlayerID ) ) {
		static iOrigin[ 3 ];
		get_user_origin( iPlayerID, iOrigin );
		set_user_health( iPlayerID, get_user_health( iPlayerID ) - abs( FIRE_DAMAGE ) );

		message_begin( MSG_ONE, g_msgDamage, { 0, 0, 0 }, iPlayerID );
		write_byte( 30 );
		write_byte( 30 );
		write_long( 1<<21 );
		write_coord( iOrigin[ 0 ] );
		write_coord( iOrigin[ 1 ] );
		write_coord( iOrigin[ 2 ] );
		message_end( );

		emit_sound( iPlayerID, CHAN_ITEM, g_strSounds[ SOUND_FLAMEBURST ], 0.6, ATTN_NORM, 0, PITCH_NORM );

		set_task( 2.0, "IgnitePlayer", 0, strPlayer, 2 );
	}
}

/* Get Natives */
public API_GetUserUnAmmo( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return -1;
	}
	
	if( CheckBit( g_bitHasUnAmmo, iPlayerID ) ) {
		return 1;
	}
	
	return 0;
}

public API_GetUserUnAmmoBP( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return -1;
	}
	
	if( CheckBit( g_bitHasUnBPAmmo, iPlayerID ) ) {
		return 1;
	}
	
	return 0;
}

public API_GetUserSpeed( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return -1;
	}
	
	if( CheckBit( g_bitHasSpeed, iPlayerID ) ) {
		return 1;
	}
	
	return 0;
}

public API_GetUserBlanks( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return -1;
	}
	
	if( CheckBit( g_bitHasBlanks, iPlayerID ) ) {
		return 1;
	}
	
	return 0;
}

public API_GetUserNoBuy( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return -1;
	}
	
	if( CheckBit( g_bitHasNoBuy, iPlayerID ) ) {
		return 1;
	}
	
	return 0;
}

public API_GetUserFire( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return -1;
	}
	
	if( CheckBit( g_bitIsOnFire, iPlayerID ) ) {
		return 1;
	}
	
	return 0;
}

public API_GetUserAutoSlay( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return -1;
	}
	
	if( CheckBit( g_bitHasAutoSlay, iPlayerID ) ) {
		return 1;
	}
	
	return 0;
}

public API_GetUserBadAim( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return -1;
	}
	
	if( CheckBit( g_bitHasBadaim, iPlayerID ) ) {
		return 1;
	}
	
	return 0;
}

public API_GetUserGag( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return -1;
	}
	
	return g_iPlayerGagFlags[ iPlayerID ];
}

public API_GetUserAFK( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return -1;
	}
	
	return g_iPlayerTime[ iPlayerID ];
}

public API_GetUserMute( iPlugin, iParams ) {
	static iPlayerID, iMutePlayerID;
	iPlayerID 	= get_param( 1 );
	iMutePlayerID 	= get_param( 2 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) || !CheckBit( g_bitIsConnected, iMutePlayerID ) ) {
		return -1;
	}
	
	if( CheckBit( g_bitIsMuted[ iPlayerID ], iMutePlayerID ) ) {
		return 1;
	}
	
	return 0;
}

public API_GetHSOnly( iPlugin, iParams ) {
	if( g_bIsHSOnly ) {
		return 1;
	}
	
	return 0;
}

/* SetNatives */
public API_SetUserUnAmmo( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return 0;
	}
	
	if( get_param( 2 ) ) {
		SetBit( g_bitHasUnAmmo, iPlayerID );
	} else {
		ClearBit( g_bitHasUnAmmo, iPlayerID );
	}
	
	return 1;
}

public API_SetUserUnAmmoBP( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return 0;
	}

	if( get_param( 2 ) ) {
		SetBit( g_bitHasUnBPAmmo, iPlayerID );
	} else {
		ClearBit( g_bitHasUnBPAmmo, iPlayerID );
	}
	
	return 1;
}

public API_SetUserSpeed( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return 0;
	}

	if( get_param( 2 ) ) {
		SetBit( g_bitHasSpeed, iPlayerID );
	} else {
		ClearBit( g_bitHasSpeed, iPlayerID );
	}
	
	ResetUserMaxSpeed( iPlayerID );
	
	return 1;
}

public API_SetUserBlanks( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return 0;
	}

	if( get_param( 2 ) ) {
		set_user_hitzones( iPlayerID, 0, 0 );
		SetBit( g_bitHasBlanks, iPlayerID );
		
		UpdatePlayerMapZones( iPlayerID );
	} else {
		set_user_hitzones( iPlayerID, 0, 255 );
		ClearBit( g_bitHasBlanks, iPlayerID );
	}
	
	return 1;
}

public API_SetUserNoBuy( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return 0;
	}

	if( get_param( 2 ) ) {
		SetBit( g_bitHasNoBuy, iPlayerID );
	} else {
		ClearBit( g_bitHasNoBuy, iPlayerID );
	}
	
	return 1;
}

public API_SetUserFire( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return 0;
	}
	
	if( get_param( 2 ) ) {
		static strPlayer[ 1 ];
		strPlayer[ 0 ] = iPlayerID;
		
		SetBit( g_bitIsOnFire, iPlayerID );
		
		IgnitePlayer( strPlayer );
		IgniteEffects( strPlayer );
	} else {
		ClearBit( g_bitIsOnFire, iPlayerID );
	}
	
	return 1;
}

public API_SetUserAutoSlay( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return 0;
	}
	
	if( get_param( 2 ) ) {
		SetBit( g_bitHasAutoSlay, iPlayerID );
		
		if( CheckBit( g_bitIsAlive, iPlayerID ) ) {
			user_kill( iPlayerID );
		}
	} else {
		ClearBit( g_bitHasAutoSlay, iPlayerID );
	}
	
	return 1;
}

public API_SetUserBadAim( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID	= get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return 0;
	}
	
	static iTimer;
	iTimer		= get_param( 2 );
	
	switch( iTimer ) {
		case 0: {
			ClearBit( g_bitHasBadaim, iPlayerID );
		}
		
		case 1: {
			SetBit( g_bitHasBadaim, iPlayerID );
		}
		
		default: {
			SetBit( g_bitHasBadaim, iPlayerID );
			set_task( float( iTimer ), "Task_RemoveBadaim", TASK_BADAIM + iPlayerID );
		}
	}
	
	return 1;
}

public API_SetUserScore( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return 0;
	}
	
	static iFrags, iDeaths;
	iFrags		= get_param( 2 );
	iDeaths		= get_param( 3 );
	
	set_user_frags( iPlayerID, iFrags );
	cs_set_user_deaths( iPlayerID, iDeaths );
	UpdateScore( iPlayerID, iFrags, iDeaths );
	
	return 1;
}

public API_SetUserGag( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return 0;
	}
	
	static strFlags[ 32 ];
	get_string( 2, strFlags, 31 );
	
	if( is_str_empty( strFlags ) ) {
		g_iPlayerGagFlags[ iPlayerID ] = 0;
	} else {
		g_iPlayerGagFlags[ iPlayerID ] = read_flags( strFlags );
	}
	
	return 1;
}

public API_SetHSOnly( iPlugin, iParams ) {
	if( get_param( 1 ) ) {
		set_user_hitzones( 0, 0, 2 );
		g_bIsHSOnly = true;
	} else {
		set_user_hitzones( 0, 0, 255 );
		g_bIsHSOnly = false;
	}
}

/* Other Natives */
public API_RevivePlayer( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsConnected, iPlayerID ) || CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return 0;
	}
	
	RevivePlayer( iPlayerID );
	
	return 1;
}

public API_DrugPlayer( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return 0;
	}
	
	DrugPlayer( iPlayerID );
	
	return 1;
}

public API_BuryPlayer( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return 0;
	}
	
	Bury_Unbury( iPlayerID, true );
	
	return 1;
}

public API_UnBuryPlayer( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return 0;
	}
	
	Bury_Unbury( iPlayerID, false );
	
	return 1;
}

public API_DisarmPlayer( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return 0;
	}
	
	StripPlayerWeapons( iPlayerID );
	
	return 1;
}

public API_UberSlapPlayer( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return 0;
	}
	
	StripPlayerWeapons( iPlayerID );
	set_task( 0.1, "Task_UberslapPlayer", TASK_UBERSLAP + iPlayerID, _, _, "a", 100 );
	
	return 1;
}

public API_RocketPlayer( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return 0;
	}
	
	RocketPlayer( iPlayerID );
	
	return 1;
}

public API_Slay2Player( iPlugin, iParams ) {
	static iPlayerID;
	iPlayerID = get_param( 1 );
	
	if( !CheckBit( g_bitIsAlive, iPlayerID ) ) {
		return 0;
	}
	
	Slay2Player( iPlayerID, get_param( 2 ) );
	
	return 1;
}

public API_LockTeam( iPlugin, iParams ) {
	static strTeam[ 32 ];
	get_string( 1, strTeam, 31 );
	
	static iTeam;
	
	switch( strTeam[ 0 ] ) {
		case 't', 'T':	iTeam = TERRORIST;
		case 'c', 'C':	iTeam = COUNTER;
		case 'a', 'A':	iTeam = AUTO;
		case 's', 'S':	iTeam = SPECTATOR;
		default:	return 0;
	}
	
	g_bBlockTeamJoin[ iTeam ] = true;
	
	return 1;
}

public API_UnLockTeam( iPlugin, iParams ) {
	static strTeam[ 32 ];
	get_string( 1, strTeam, 31 );
	
	static iTeam;
	
	switch( strTeam[ 0 ] ) {
		case 't', 'T':	iTeam = TERRORIST;
		case 'c', 'C':	iTeam = COUNTER;
		case 'a', 'A':	iTeam = AUTO;
		case 's', 'S':	iTeam = SPECTATOR;
		default:	return 0;
	}
	
	g_bBlockTeamJoin[ iTeam ] = false;
	
	return 1;
}

/* Other Functions */
ReloadCvars( ) {
	/*
		In my opinion, its better to refresh all the cvars on demand and
		caching them instead of getting its value everytime we want it.
		And that way we do not waste useful CPU power.
	*/
	get_pcvar_num( g_pcvarResetScore )			? SetBit( g_bitCvarStatus, CVAR_RESETSCORE )		: ClearBit( g_bitCvarStatus, CVAR_RESETSCORE );
	get_pcvar_num( g_pcvarResetScoreDisplay )		? SetBit( g_bitCvarStatus, CVAR_RESETSCORE_DISPLAY )	: ClearBit( g_bitCvarStatus, CVAR_RESETSCORE_DISPLAY );
	get_pcvar_num( g_pcvarAdminCheck )			? SetBit( g_bitCvarStatus, CVAR_ADMINCHECK )		: ClearBit( g_bitCvarStatus, CVAR_ADMINCHECK );
	get_pcvar_num( g_pcvarBulletDamage )			? SetBit( g_bitCvarStatus, CVAR_ABD )			: ClearBit( g_bitCvarStatus, CVAR_ABD );
	get_pcvar_num( g_pcvarRefund )				? SetBit( g_bitCvarStatus, CVAR_REFUND )		: ClearBit( g_bitCvarStatus, CVAR_REFUND );
	get_pcvar_num( g_pcvarAutoRestart )			? SetBit( g_bitCvarStatus, CVAR_AUTORR )                : ClearBit( g_bitCvarStatus, CVAR_AUTORR );
	get_pcvar_num( g_pcvarBulletDamageWall )		? SetBit( g_bitCvarStatus, CVAR_ABD_WALL )              : ClearBit( g_bitCvarStatus, CVAR_ABD_WALL );
	get_pcvar_num( g_pcvarAdminListen )			? SetBit( g_bitCvarStatus, CVAR_ADMINLISTEN )           : ClearBit( g_bitCvarStatus, CVAR_ADMINLISTEN );
	get_pcvar_num( g_pcvarDeadListen )			? SetBit( g_bitCvarStatus, CVAR_DEADLISTEN )            : ClearBit( g_bitCvarStatus, CVAR_DEADLISTEN );
	get_pcvar_num( g_pcvarAFKBombTransfer )			? SetBit( g_bitCvarStatus, CVAR_AFK_BOMBTRANSFER )      : ClearBit( g_bitCvarStatus, CVAR_AFK_BOMBTRANSFER );
	get_pcvar_num( g_pcvarC4Timer )				? SetBit( g_bitCvarStatus, CVAR_C4_TIMER )              : ClearBit( g_bitCvarStatus, CVAR_C4_TIMER );
	get_pcvar_num( g_pcvarAdminListenTeam )			? SetBit( g_bitCvarStatus, CVAR_ADMINLISTEN_TEAM )      : ClearBit( g_bitCvarStatus, CVAR_ADMINLISTEN_TEAM );
	get_pcvar_num( g_pcvarDeadListenTeam )			? SetBit( g_bitCvarStatus, CVAR_DEADLISTEN_TEAM )       : ClearBit( g_bitCvarStatus, CVAR_DEADLISTEN_TEAM );
	get_pcvar_num( g_pcvarAFK )				? SetBit( g_bitCvarStatus, CVAR_AFK )                   : ClearBit( g_bitCvarStatus, CVAR_AFK );
	get_pcvar_num( g_pcvarAllowSpec )			? SetBit( g_bitCvarStatus, CVAR_SPEC )			: ClearBit( g_bitCvarStatus, CVAR_SPEC );
	get_pcvar_num( g_pcvarGagName )				? SetBit( g_bitCvarStatus, CVAR_GAG_NAME )		: ClearBit( g_bitCvarStatus, CVAR_GAG_NAME );
	get_pcvar_num( g_pcvarAFKSpectators )			? SetBit( g_bitCvarStatus, CVAR_AFK_SPECTATORS )	: ClearBit( g_bitCvarStatus, CVAR_AFK_SPECTATORS );
	get_pcvar_num( g_pcvarAutoRestartKnife )		? SetBit( g_bitCvarStatus, CVAR_AUTORR_KNIFE )		: ClearBit( g_bitCvarStatus, CVAR_AUTORR_KNIFE );
	
	g_iSpawnMoney			= clamp( get_pcvar_num( g_pcvarRefundValue ),			0,	16000 );
	g_iAFKTime			= clamp( get_pcvar_num( g_pcvarAFKTime ),			10,	60 );
	g_iAFKSpectatorsTime		= clamp( get_pcvar_num( g_pcvarAFKSpectatorsTime ),		30,	300 );
	g_iAFKTime_Bomb			= clamp( get_pcvar_num( g_pcvarAFKBombTransfer_Time ),		5,	15 );
	g_iAFKPunishment		= clamp( get_pcvar_num( g_pcvarAFKPunishment ),			0,	2 );
	g_iAdvertisement		= clamp( get_pcvar_num( g_pcvarPluginAdvertisement ),		0,	30 );
	g_iJoinleaveAnnouncements 	= clamp( get_pcvar_num( g_pcvarConnectDisconnectMessage ), 	0, 	2 );
	g_iSpawnProtection		= clamp( get_pcvar_num( g_pcvarSpawnProtection ),		0,	10 );
	g_iSpawnProtectionGlow		= clamp( get_pcvar_num( g_pcvarSpawnProtectionGlow ),		0,	2 );
	
	g_iC4Timer 	= get_pcvar_num( g_cvarC4Timer );
	
	g_fGagTime	= float( get_pcvar_num( g_pcvarGagTime ) * 60 );
	
	get_pcvar_string( g_pcvarGagFlags, 		g_strGagFlags, 		3 );
	get_pcvar_string( g_pcvarPluginPrefix,		g_strPluginPrefix,	31 );
}

ExecConfig( ) {
	/* Config File Execution */
	new strConfigDir[ 128 ];
	get_localinfo( "amxx_configsdir", strConfigDir, 127 );
	format( strConfigDir, 127, "%s/%s.cfg", strConfigDir, g_strPluginName );
	
	if( file_exists( strConfigDir ) ) {
		server_cmd( "exec %s", strConfigDir );
		log_amx( "%s configuration file successfully loaded!", g_strPluginName );
		server_exec( );
	} else {
		log_amx( "%s configuration file not found.", g_strPluginName );
		server_exec( );
	}
}

PlayerDisconnected( strPlayerName[ ] ) {
	get_pcvar_string( g_pcvarLeaveMessage,		g_strLeaveMessage,	127 );
	
	if( is_str_empty( g_strLeaveMessage ) ) {
		return PLUGIN_CONTINUE;
	}
	
	static strHostname[ 64 ];
	get_pcvar_string( g_cvarHostname, strHostname, 63 );
	replace_all( g_strLeaveMessage, 127, "%hostname%", strHostname );
	
	replace_all( g_strLeaveMessage, 127, "%name%", strPlayerName );
	replace_all( g_strLeaveMessage, 127, "\n", "^n" );
	
	set_hudmessage( 255, 0, 255, 0.10, 0.55, 0, 6.0, 6.0, 0.5, 0.15, 3 );
	ShowSyncHudMsg( 0, g_hudSync5, g_strLeaveMessage );
	
	return PLUGIN_CONTINUE;
}

PlayerDisconnected_HUD( strPlayerName[ ], strPlayerAuthID[ ], strPlayerIP[ ] ) {
	static iPlayers[ 32 ], iNum, iTempID, iLoop;
	get_players( iPlayers, iNum );
	
	for( iLoop = 0; iLoop < iNum; iLoop++ ) {
		iTempID = iPlayers[ iLoop ];
		
		if( access( iTempID, ADMIN_AUTHORIZED ) ) {
			client_print_color( iTempID, print_team_grey, "^4%s^1 %L", g_strPluginPrefix, iTempID, "DISCONNECT_ADMIN", strPlayerName, strPlayerAuthID, strPlayerIP );
		} else {
			client_print_color( iTempID, print_team_grey, "^4%s^1 %L", g_strPluginPrefix, iTempID, "DISCONNECT_USER", strPlayerName );
		}
	}
}

UpdateScore( iPlayerID, iFrags, iDeaths ) {
	message_begin( MSG_ALL, g_msgScoreInfo );
	write_byte( iPlayerID );
	write_short( iFrags );
	write_short( iDeaths );
	write_short( 0 );
	write_short( get_user_team( iPlayerID ) );
	message_end( );
}

StripPlayerWeapons( iPlayerID ) {
	strip_user_weapons( iPlayerID );
	set_pdata_int( iPlayerID, 116, 0 );
	
	give_item( iPlayerID, "weapon_knife" );
}

ResetUserMaxSpeed( iPlayerID ) {
	new Float:fMaxSpeed;
	
	switch( get_user_weapon( iPlayerID ) ) {
		case CSW_SG550, CSW_AWP, CSW_G3SG1:		fMaxSpeed = 210.0;
		case CSW_M249:					fMaxSpeed = 220.0;
		case CSW_AK47:					fMaxSpeed = 221.0;
		case CSW_M3, CSW_M4A1:				fMaxSpeed = 230.0;
		case CSW_SG552:					fMaxSpeed = 235.0;
		case CSW_XM1014, CSW_AUG, CSW_GALIL, CSW_FAMAS:	fMaxSpeed = 240.0;
		case CSW_P90:					fMaxSpeed = 245.0;
		case CSW_SCOUT:					fMaxSpeed = 260.0;
		default :					fMaxSpeed = 250.0;
	}
	
	set_user_maxspeed( iPlayerID, fMaxSpeed );
}

DrugPlayer( iPlayerID ) {
	message_begin( MSG_ONE, g_msgSetFOV, { 0, 0, 0 }, iPlayerID );
	write_byte( 180 );
	message_end( );
}

RandomMusic( iPlayerID ) {
	client_cmd( iPlayerID, "mp3 play media/%s", g_strMusicList[ random_num( 0, MAX_MUSIC - 1 ) ] );
}

RocketPlayer( iPlayerID ) {
	emit_sound( iPlayerID, CHAN_WEAPON, g_strSounds[ SOUND_ROCKETFIRE ], 1.0, ATTN_NORM, 0, PITCH_NORM );
	set_user_maxspeed( iPlayerID, 0.1 );
	
	new strPlayer[ 2 ];
	strPlayer[ 0 ] = iPlayerID;
	set_task( 1.2, "RocketLiftoff", TASK_ROCKETLIFTOFF, strPlayer, 2 );
}

GiveWeapon( iPlayerID, iWeapon, iAmmo ) {
	give_item( iPlayerID, g_strWeapons[ iWeapon ] );
	
	switch( iWeapon ) {
		case 2, 29: {
			return PLUGIN_HANDLED;
		}
		
		case 6: {
			cs_set_user_plant( iPlayerID );
		}
		
		default: {
			cs_set_user_bpammo( iPlayerID, iWeapon, iAmmo );
		}
	}
	
	return PLUGIN_HANDLED;
}

Slay2Player( iPlayerID, iType ) {
	new strPlayerName[ 32 ], iOrigin[ 3 ], iOrigin2[ 3 ];
	get_user_name( iPlayerID, strPlayerName, 31 );
	get_user_origin( iPlayerID, iOrigin );
	iOrigin[ 2 ] -= 26;

	iOrigin2[ 0 ] = iOrigin[ 0 ] + 150;
	iOrigin2[ 1 ] = iOrigin[ 1 ] + 150;
	iOrigin2[ 2 ] = iOrigin[ 2 ] + 400;

	switch( iType ) {
		case SLAY_LIGHTINING : {
			message_begin( MSG_BROADCAST,SVC_TEMPENTITY);
			write_byte( 0 );
			write_coord( iOrigin2[ 0 ] );
			write_coord( iOrigin2[ 1 ] );
			write_coord( iOrigin2[ 2 ] );
			write_coord( iOrigin[ 0 ] );
			write_coord( iOrigin[ 1 ] );
			write_coord( iOrigin[ 2 ] );
			write_short( g_iSprites[ SPRITE_LIGHTNING ] );
			write_byte( 1 );		// framestart 
			write_byte( 5 );		// framerate 
			write_byte( 2 );		// life 
			write_byte( 20 );		// width 
			write_byte( 30 );		// noise 
			write_byte( 200 );		// r 
			write_byte( 200 );		// g
			write_byte( 200 );		// b
			write_byte( 200 );		// brightness 
			write_byte( 200 );		// speed 
			message_end( );
		    
			emit_sound( iPlayerID, CHAN_VOICE, g_strSounds[ SOUND_THUNDERCLAP ], 1.0, ATTN_NORM, 0, PITCH_NORM );
		}

		case SLAY_BLOOD: {
			message_begin( MSG_BROADCAST, SVC_TEMPENTITY );
			write_byte( 10 );
			write_coord( iOrigin[ 0 ] );
			write_coord( iOrigin[ 1 ] );
			write_coord( iOrigin[ 2 ] );
			message_end( );
		    
			emit_sound( iPlayerID, CHAN_ITEM, g_strSounds[ SOUND_HEADSHOT ], 1.0, ATTN_NORM, 0, PITCH_NORM );
		}

		case SLAY_EXPLODE: {
			message_begin( MSG_BROADCAST, SVC_TEMPENTITY, iOrigin ) ;
			write_byte( 21 );
			write_coord( iOrigin[ 0 ] );
			write_coord( iOrigin[ 1 ] );
			write_coord( iOrigin[ 2 ] + 16 );
			write_coord( iOrigin[ 0 ] );
			write_coord( iOrigin[ 1 ] );
			write_coord( iOrigin[ 2 ] + 1936 );
			write_short( g_iSprites[ SPRITE_WHITE ] );
			write_byte( 0 );            // startframe 
			write_byte( 0 );            // framerate 
			write_byte( 2 );            // life 
			write_byte( 16 );           // width 
			write_byte( 0 );            // noise 
			write_byte( 188 );          // r 
			write_byte( 220 );          // g 
			write_byte( 255 );          // b 
			write_byte( 255 );          //brightness 
			write_byte( 0 );            // speed 
			message_end( ); 

			message_begin( MSG_BROADCAST, SVC_TEMPENTITY ) ;
			write_byte( 12 );
			write_coord( iOrigin[ 0 ] );
			write_coord( iOrigin[ 1 ] );
			write_coord( iOrigin[ 2 ] );
			write_byte( 188 );          // byte (scale in 0.1's) 
			write_byte( 10 );           // byte (framerate) 
			message_end( );

			message_begin( MSG_BROADCAST, SVC_TEMPENTITY/*, iOrigin*/ );
			write_byte( 5 );
			write_coord( iOrigin[ 0 ] );
			write_coord( iOrigin[ 1 ] );
			write_coord( iOrigin[ 2 ] );
			write_short( g_iSprites[ SPRITE_SMOKE ] );
			write_byte( 2 );
			write_byte( 10 );
			message_end( );
		}
	}

	user_kill( iPlayerID, 1 );
}

PunsihAFKPlayer( iPlayerID ) {
	if( access( iPlayerID, AFK_IMMUNITY ) ) {
		return PLUGIN_CONTINUE;
	}

	switch( g_iAFKPunishment ) {
		case 0: {
			return PLUGIN_CONTINUE;
		}

		case 1: {
			if( CheckBit( g_bitIsAlive, iPlayerID ) ) {
				user_kill( iPlayerID );
			}

			cs_set_user_team( iPlayerID, CS_TEAM_SPECTATOR );

			new strPlayerName[ 32 ];
			get_user_name( iPlayerID, strPlayerName, 31 );

			client_print_color( 0, iPlayerID, "^4%s^1 %L", g_strPluginPrefix, LANG_PLAYER, "AFK_TRANSFERED", strPlayerName );
		}

		case 2: {
			server_cmd( "kick #%i ^"You have been AFK for too long.^"", get_user_userid( iPlayerID ) );

			new strPlayerName[ 32 ];
			get_user_name( iPlayerID, strPlayerName, 31 );

			client_print_color( 0, iPlayerID, "^4%s^1 %L", g_strPluginPrefix, LANG_PLAYER, "AFK_KICKED", strPlayerName );
		}
	}

	return PLUGIN_CONTINUE;
}

RocketExplode( iVictim ) {
	if( CheckBit( g_bitIsAlive, iVictim ) ) {
		new iOrigin[ 3 ];
		get_user_origin( iVictim, iOrigin );

		// Blast Circles
		message_begin( MSG_BROADCAST, SVC_TEMPENTITY, iOrigin );
		write_byte( 21 );
		write_coord( iOrigin[ 0 ] );
		write_coord( iOrigin[ 1 ] );
		write_coord( iOrigin[ 2 ] - 10 );
		write_coord( iOrigin[ 0 ] );
		write_coord( iOrigin[ 1 ] );
		write_coord( iOrigin[ 2 ] + 1910 );
		write_short( g_iSprites[ SPRITE_WHITE ] );
		write_byte( 0 );	// Startframe
		write_byte( 0 );	// Framerate
		write_byte( 2 );	// Life
		write_byte( 16 );	// Width
		write_byte( 0 );	// Noise
		write_byte( 188 );	// Red
		write_byte( 220 );	// Green
		write_byte( 255 );	// Blue
		write_byte( 255 );	// Brightness
		write_byte( 0 );	// Speed
		message_end( );

		// Explosion2
		message_begin( MSG_BROADCAST, SVC_TEMPENTITY );
		write_byte( 12 );
		write_coord( iOrigin[ 0 ] );
		write_coord( iOrigin[ 1 ] );
		write_coord( iOrigin[ 2 ] );
		write_byte( 188 );	// Scale
		write_byte( 10 );	// Framerate
		message_end( );

		// Smoke
		message_begin( MSG_BROADCAST, SVC_TEMPENTITY );
		write_byte( 5 );
		write_coord( iOrigin[ 0 ] );
		write_coord( iOrigin[ 1 ] );
		write_coord( iOrigin[ 2 ] );
		write_short( g_iSprites[ SPRITE_SMOKE ] );
		write_byte( 2 );
		write_byte( 10 );
		message_end( );

		user_kill( iVictim, 1 );
	}

	emit_sound( iVictim, CHAN_VOICE, g_strSounds[ SOUND_ROCKET ], 0.0, 0.0, ( 1<<5 ), PITCH_NORM );

	set_user_maxspeed( iVictim, 1.0 );
	set_user_gravity( iVictim, 1.0 );
}

RevivePlayer( iPlayerID ) {
	ExecuteHamB( Ham_CS_RoundRespawn, iPlayerID );
	set_task( 0.25, "Task_PlayerRevived", TASK_REVIVE + iPlayerID );
}

Bury_Unbury( iPlayerID, bool:bBury ) {
	new iOrigin[ 3 ];
	get_user_origin( iPlayerID, iOrigin );
	
	new strWeaponName[ 32 ], iWeapons[ 32 ];
	new iWeaponsNum;
	
	if( bBury ) {
		get_user_weapons( iPlayerID, iWeapons, iWeaponsNum );
		
		for( new iInnerLoop = 0; iInnerLoop < iWeaponsNum; iInnerLoop++ ) {
			get_weaponname( iWeapons[ iInnerLoop ], strWeaponName, 31 );
			engclient_cmd( iPlayerID, "drop", strWeaponName );
		}
		
		/*
			I am stripping the player here because I do not want him to have
			the grenades that he can damage other players with.
		*/
		StripPlayerWeapons( iPlayerID );
		
		engclient_cmd( iPlayerID, "weapon_knife" );
		
		iOrigin[ 2 ] -= 30;
	} else {
		iOrigin[ 2 ] += 35;
	}
	
	set_user_origin( iPlayerID, iOrigin );
}

VersionCheckerSocket( ) {
	new iError, strBuffer[ 512 ];
	g_iSocket = socket_open( PLUGIN_HOST, 80, SOCKET_TCP, iError );
	
	switch( iError ) {
		case 1:	log_amx( "Unable to create socket." );
		case 2:	log_amx( "Unable to connect to hostname." );
		case 3:	log_amx( "Unable to connect to the HTTP port." );
		
		default: {
			formatex( strBuffer, 511, "GET %s HTTP/1.1^nHost:%s^r^n^r^n", PLUGIN_TOPIC, PLUGIN_HOST );
			socket_send( g_iSocket, strBuffer, 511 );
			
			set_task( 1.0, "Task_GetAnswer", TASK_GETANSWER, _, _, "a", 15 );
			set_task( 16.0, "Task_CloseConnection", TASK_CLOSECONNECTION );
		}
	}
}

CompareVersions( iSize ) {
	for( new iLoop = 0; iLoop < iSize; iLoop++ ) {
		if( g_strSocketVersion[ iLoop ] == '.' && g_strPluginVersion[ iLoop ] == '.' ) {
			continue;
		}
		
		if( str_to_num( g_strSocketVersion[ iLoop ] ) > str_to_num( g_strPluginVersion[ iLoop ] ) ) {
			g_bNeedToUpdate = true;
			return;
		}
	}
	
	g_bNeedToUpdate = false;
	return;
}

UpdatePlayerMapZones( iPlayerID ) {
	set_pdata_float( iPlayerID, 233, 0.0 );
	set_pdata_int( iPlayerID, 235, 0 );
}

#if AMXX_VERSION_NUM < 183
client_print_color( iPlayerID, iSenderID, const strFormat[ ], any:... ) {
	if(  iPlayerID && !CheckBit( g_bitIsConnected, iPlayerID ) ) {
		return 0;
	}
	
	static const strTeamName[ ][ ] = {
		"",
		"TERRORIST",
		"CT"
	};
	
	new strMessage[ 192 ];
	new iParams = numargs( );
	
	if( iPlayerID ) {
		if( iParams == 3 ) {
			copy( strMessage, 191, strFormat );
		} else {
			vformat( strMessage, 191, strFormat, 4 );
		}
		
		if( iSenderID > print_team_grey ) {
			if( iSenderID > print_team_blue ) {
				iSenderID = iPlayerID;
			} else {
				_CC_TeamInfo( iPlayerID, iSenderID, strTeamName[ iSenderID - print_team_grey ] );
			}
		}
		
		_CC_SayText( iPlayerID, iSenderID, strMessage );
	} else {
		new iPlayers[ 32 ], iNum;
		get_players( iPlayers, iNum, "ch" );
		
		if( !iNum ) {
			return 0;
		}
		
		new iMLNumber, iLoop, iInnerLoop;
		new Array:aStoreML = ArrayCreate( );
		
		if( iParams >= 5 ) {
			for( iInnerLoop = 3; iInnerLoop < iParams; iInnerLoop++ ) {
				if( getarg( iInnerLoop ) == LANG_PLAYER ) {
					iLoop = 0;
					
					while( ( strMessage[ iLoop ] = getarg( iInnerLoop + 1, iLoop++ ) ) ) {}
					if( GetLangTransKey( strMessage ) != TransKey_Bad ) {
						ArrayPushCell( aStoreML, iInnerLoop++ );
						
						iMLNumber++;
					}
				}
			}
		}
		
		if( !iMLNumber ) {
			if( iParams == 3 ) {
				copy( strMessage, 191, strFormat );
			} else {
				vformat( strMessage, 191, strFormat, 4 );
			}
			
			if( 0 < iSenderID < print_team_blue ) {
				if( iSenderID > print_team_grey ) {
					_CC_TeamInfo( 0, iSenderID, strTeamName[ iSenderID - print_team_grey ] );
				}
				
				_CC_SayText( 0, iSenderID, strMessage );
				
				return 1;
			}
		}
		
		if( iSenderID > print_team_blue ) {
			iSenderID = 0;
		}
		
		for( --iNum; iNum >= 0; iNum-- ) {
			iPlayerID = iPlayers[ iNum ];
			
			if( iMLNumber ) {
				for( iInnerLoop = 0; iInnerLoop < iMLNumber; iInnerLoop++ ) {
					setarg( ArrayGetCell( aStoreML, iInnerLoop ), _, iPlayerID );
				}
				
				vformat( strMessage, 191, strFormat, 4 );
			}
			
			if( iSenderID > print_team_grey ) {
				_CC_TeamInfo( iPlayerID, iSenderID, strTeamName[ iSenderID - print_team_grey ] );
			}
			
			_CC_SayText( iPlayerID, iSenderID, strMessage );
		}
		
		ArrayDestroy( aStoreML );
	}
	
	return 1;
}

#if defined COLOR_CHAT
register_dictionary_colored( const strFileName[ ] ) {
	if( !register_dictionary( strFileName ) ) {
		return 0;
	}
	
	new strLangDir[ 256 ];
	get_localinfo( "amxx_datadir", strLangDir, 255 );
	format( strLangDir, 255, "%s/lang/%s", strLangDir, strFileName );
	
	new iFile = fopen( strLangDir, "rt" );
	
	if( !iFile ) {
		log_amx( "Failed to open %s", strLangDir );
		
		return 0;
	}
	
	new strBuffer[ 512 ], strLang[ 3 ], strKey[ 64 ], strTranslation[ 256 ], TransKey:iKey;
	
	while( !feof( iFile ) ) {
		fgets( iFile, strBuffer, 511 );
		
		if( strBuffer[ 0 ] == '[' ) {
			strtok( strBuffer[ 1 ], strLang, 2, strBuffer, 1, ']' );
		} else if( strBuffer[ 0 ] ) {
			strbreak( strBuffer, strKey, 63, strTranslation, 255 );
			iKey = GetLangTransKey( strKey );
			
			if( iKey != TransKey_Bad ) {
				replace_all( strTranslation, 255, "!g", "^4" );
				replace_all( strTranslation, 255, "!t", "^3" );
				replace_all( strTranslation, 255, "!n", "^1" );
				
				AddTranslation( strLang, iKey, strTranslation[ 2 ] );
			}
		}
	}
	
	fclose( iFile );
	
	return 1;
}
#endif

_CC_TeamInfo( iReceiverID, iSenderID, strTeam[ ] ) {
	message_begin( iReceiverID ? MSG_ONE : MSG_ALL, g_msgTeamInfo, _, iReceiverID );
	write_byte( iSenderID );
	write_string( strTeam );
	message_end( );
}

_CC_SayText( iReceiverID, iSenderID, strMessage[ ] ) {
	message_begin( iReceiverID ? MSG_ONE : MSG_ALL, g_msgSayText, _, iReceiverID );
	write_byte( iSenderID ? iSenderID : iReceiverID );
	write_string( strMessage );
	message_end( );
}
#endif

/*
	Notepad++ Allied Modders Edition v6.3.1
	Style Configuration:	Default
	Font:			Consolas
	Font size:		10
	Indent Tab:		8 spaces
*/