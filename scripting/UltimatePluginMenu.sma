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
	UltimatePluginMenu
	by tonykaram1993
	
	This plugin relies on the UltimatePlugin.amxx file. If you do not have it
	installed, this plugin will have no effect.
*/

/*
	Change Log:
	
	+ something added/new
	- something removed
	* important note
	x bug fix or improvement
	
	v0.0.1	beta:	* plugin written
	
	v0.0.2	beta:	x removed useless array that took place and was not used
	
	v0.1.0	beta:	+ added the menu to the amxmodmenu
			+ added a new console command to launch the menu
			
	v0.1.1:		* plugin out of beta
			x removed team choosing in CMD_GAG and CMD_UNGAG
			x removed team choosing in CMD_BADAIM
*/
#define PLUGIN_VERSION		"0.1.1"

/* Includes */
#include < amxmodx >
#include < amxmisc >

#pragma semicolon 1

/* Defines */
#define SetBit(%1,%2)		(%1 |= (1<<(%2&31)))
#define ClearBit(%1,%2)		(%1 &= ~(1 <<(%2&31)))
#define CheckBit(%1,%2)		(%1 & (1<<(%2&31)))

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
	This is where you stop. Editing anything below this point
	might lead to some serious errors, and you will not get any
	support if you do.
	
	SAFETY ZONE ENDS HERE
*/

/* Enumerations */
enum _:MAX_CMD( ) {
	CMD_HEAL,		CMD_HP,			CMD_ARMOR,
	CMD_AP, 		CMD_UNAMMO,		CMD_UNAMMOBP,
	CMD_SCORE,		CMD_REVIVE,		CMD_NOCLIP,
	CMD_GODMODE,		CMD_TELEPORT,		CMD_USERORIGIN,
	CMD_SPEED,		CMD_DRUG,		CMD_WEAPON,
	CMD_BLANKS,		CMD_NOBUY,		CMD_BURY,
	CMD_UNBURY,		CMD_DISARM,		CMD_UBERSLAP,
	CMD_FIRE,		CMD_AUTOSLAY,		CMD_ROCKET,
	CMD_BADAIM,		CMD_SLAY2,		CMD_GAG,
	CMD_UNGAG,		CMD_PGRAVITY,		CMD_TRANSFER,
	CMD_SWAP,		CMD_SWAPTEAMS,		CMD_GLOW,
	CMD_GLOW2,		CMD_HSONLY,		CMD_EXTEND,
	CMD_LOCK,		CMD_UNLOCK,		CMD_GRAVITY,
	CMD_RELOADCVARS,	CMD_RESTART,		CMD_SHUTDOWN
};

enum( ) {
	GAG_CHAT		= 1,
	GAG_TEAMCHAT		= 2,
	GAG_VOICE		= 4
}

enum _:MAX_ARG( ) {
	ARG_COMMAND		= 0,
	ARG_PARAM1,
	ARG_PARAM2
};

/* Constantes */
new const g_strPluginName[ ]		= "UltimatePluginMenu";
new const g_strPluginVersion[ ]		= PLUGIN_VERSION;
new const g_strPluginAuthor[ ]		= "tonykaram1993";

new const g_strCommands[ MAX_CMD ][ ] = {
	"amx_heal",		"amx_hp",		"amx_armor",
	"amx_ap",		"amx_unammo",		"amx_unammobp",
	"amx_score",		"amx_revive",		"amx_noclip",
	"amx_godmode",		"amx_teleport",		"amx_useroirgin",
	"amx_speed",		"amx_drug",		"amx_weapon",
	"amx_blanks",		"amx_nobuy",		"amx_bury",
	"amx_unbury",		"amx_disarm",		"amx_uberslap",
	"amx_fire",		"amx_autoslay",		"amx_rocket",
	"amx_badaim",		"amx_slay2",		"amx_gag",
	"amx_ungag",		"amx_pgravity",		"amx_transfer",
	"amx_swap",		"amx_swapteams",	"amx_glow",
	"amx_glow2",		"amx_hsonly",		"amx_extend",
	"amx_lock",		"amx_unlock",		"amx_gravity",
	"amx_reloadcvars",	"amx_restart",		"amx_shutdown"
};

new const g_strWeapons[ 31 ][ ] = {
	"",		"P228",		"Shield",
	"Scout",	"Hegrenade",	"XM1013",
	"C4",		"MAC10",	"AUG",
	"Smokegrenade",	"Elite",	"Fiveseven",
	"UMP45",	"SG550",	"Galil",
	"Famas",	"USP",		"Glock",
	"AWP",		"MP5",		"M249",
	"M3",		"M4A1",		"TMP",
	"G3SG1",	"Flashbang",	"Deagle",
	"SG552",	"AK47",		"Knife",
	"P90"
};

new const g_strColorArray[ ][ ] = {
	"red",		"pink",		"darkred",
	"lightred",	"blue",		"darkblue",
	"lightblue",	"aqua",		"green",
	"lightgreen",	"darkgreen",	"brown",
	"lightbrown",	"white",	"yellow",
	"darkyellow",	"lightyellow",	"orange",
	"lightorange",	"darkorange",	"lightpurple",
	"purple",	"darkpurple",	"violet",
	"maroon",	"gold",		"silver",
	"bronze",	"grey",		"off"
};

/* Variables */
new g_iPlayerCommand[ MAX_PLAYERS + 1 ];
new g_strPlayerCommandTarget[ MAX_PLAYERS + 1 ][ 32 ];
new g_iPlayerCommandParam1[ MAX_PLAYERS + 1 ];
new g_iPlayerCommandParam2[ MAX_PLAYERS + 1 ];
new g_iKey;

/* Menus */
new g_menuTargets[ MAX_PLAYERS + 1 ];
new g_menuPlayers[ MAX_PLAYERS + 1 ];
new g_menuMain;
new g_menuWeapons;

/* Bitsums */
new g_bitIsConnected;
new g_bitIsAdmin;

public plugin_init( ) {
	/* Plugin Registration */
	register_plugin( g_strPluginName, g_strPluginVersion, g_strPluginAuthor );
	register_cvar( g_strPluginName, g_strPluginVersion, FCVAR_SERVER | FCVAR_EXTDLL | FCVAR_UNLOGGED | FCVAR_SPONLY );
	
	/* Other Functions */
	CreateMenus( );
	
	/* Client Commands */
	register_clcmd( "say /upmenu",			"ClCmd_UltimatePluginMenu" );
	register_clcmd( "say_team /upmenu",		"ClCmd_UltimatePluginMenu" );
	
	/* Console Commands */
	register_concmd( "amx_ultimatepluginmenu",	"ConCmd_UltimatePluginMenu",	ADMIN_MENU,	" - Opens the UltimatePluginMenu" );
	
	/* Add Menu to amxmodmenu */
	AddMenuItem( "UltimatePluginMenu", 		"amx_ultimatepluginmenu", 	ADMIN_ADMIN, 	g_strPluginName );
}

/* Client Natives */
public client_connect( iPlayerID ) {
	SetBit( g_bitIsConnected, iPlayerID );
}

public client_authorized( iPlayerID ) {
	if( is_user_admin( iPlayerID ) ) {
		SetBit( g_bitIsAdmin, iPlayerID );
	}
}

public client_disconnect( iPlayerID ) {
	ClearBit( g_bitIsConnected, iPlayerID );
	ClearBit( g_bitIsAdmin, iPlayerID );
}


/* Client Commands */
public ClCmd_UltimatePluginMenu( iPlayerID ) {
	if( !CheckBit( g_bitIsAdmin, iPlayerID ) ) {
		return PLUGIN_CONTINUE;
	}
	
	menu_display( iPlayerID, g_menuMain, 0 );
	
	return PLUGIN_HANDLED;
}

/* Console Commands */
public ConCmd_UltimatePluginMenu( iPlayerID, iLevel, iCid ) {
	if( !cmd_access( iPlayerID, iLevel, iCid, 0 ) ) {
		return PLUGIN_HANDLED;
	}
	
	menu_display( iPlayerID, g_menuMain, 0 );
	
	return PLUGIN_HANDLED;
}

/* Menus */
CreateMenus( ) {
	CreateMainMenu( );
	CreateWeaponMenu( );
}

CreateMainMenu( ) {
	new strMenuTitle[ 64 ];
	formatex( strMenuTitle, 63, "\yChoose A Command:" );
	
	new strMainMenu[ MAX_CMD ][ ] = {
		"Give a player health",			"Set a player's health",		"Give a player armor",
		"Set a player's armor",			"Give a player unlimited clip ammo",	"Give a player unlimited bp ammo",
		"Change a player's score",		"Revive a player",			"Give a player noclip",
		"Give a player godmode",		"Teleport player to saved location",	"Save a player's origin",
		"Give a player speed",			"Drug a player",			"Give a player a weapon",
		"Give a player blank bullets",		"Don't allow a player to buy",		"Bury a player in the ground",
		"Remove a player from the ground",	"Remove all player's weapons",		"Keep slapping player untill 1 hp",
		"Set a player on fire",			"Automatically slay player after spawn","Turn a player into a rocket",
		"Give a player badaim",			"Slay a player in a unique way",	"Gag player from speaking",
		"Ungag player",				"Give a player personal gravity",	"Transfer player to a different team",
		"Swap two players with each others",	"Swap both teams",			"Glow player for 1 round",
		"Glow player for ever",			"Set headshot only mode",		"Extend current map time",
		"Lock certain team",			"Unlock certain team",			"Change general gravity",
		"Reload all the plugin's cvars",	"Restart the server with timer",	"Shutdown the server with timer"
	};
	
	g_menuMain = menu_create( strMenuTitle, "Handle_MainMenu" );
	
	new strFormat[ 64 ], strCommandNum[ 8 ];
	
	for( new iLoop = 0; iLoop < MAX_CMD; iLoop++ ) {
		formatex( strFormat, 63, "%s: %s", g_strCommands[ iLoop ], strMainMenu[ iLoop ] );
		num_to_str( iLoop, strCommandNum, 7 );
		menu_additem( g_menuMain, strFormat, strCommandNum );
	}
	
	menu_setprop( g_menuMain, MPROP_NUMBER_COLOR, "\y" );
}

public Handle_MainMenu( iPlayerID, iMenu, iKey ) {
	if( iKey == MENU_EXIT ) {
		return PLUGIN_HANDLED;
	}
	
	static strCommandNum[ 8 ], iCallBack, iAccess;
	menu_item_getinfo( iMenu, iKey, iAccess, strCommandNum, 7, _, _, iCallBack );
	
	g_iPlayerCommand[ iPlayerID ] = str_to_num( strCommandNum );
	
	static iPlayerCommand;
	iPlayerCommand = g_iPlayerCommand[ iPlayerID ];
	
	switch( iPlayerCommand ) {
		case CMD_SWAPTEAMS, CMD_RELOADCVARS: {
			client_cmd( iPlayerID, "%s", g_strCommands[ iPlayerCommand ] );
			
			return PLUGIN_HANDLED;
		}
	}
	
	ResetPlayerVariables( iPlayerID );
	CreateTargetsMenu( iPlayerID );
	
	return PLUGIN_HANDLED;
}

CreateTargetsMenu( iPlayerID ) {
	static strMenuTitle[ 64 ];
	formatex( strMenuTitle, 63, "\y%s Menu:", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ] );
	
	g_menuTargets[ iPlayerID ] = menu_create( strMenuTitle, "Handle_TargetsMenu" );
	
	static iPlayerCommand;
	iPlayerCommand = g_iPlayerCommand[ iPlayerID ];
	
	/*
		In here I am choosing only the commands that could be executed on
		a specific team or even all players.
	*/
	switch( iPlayerCommand ) {
		case CMD_HEAL, CMD_HP, CMD_ARMOR, CMD_AP, CMD_UNAMMO, CMD_UNAMMOBP, CMD_SCORE,
			CMD_REVIVE, CMD_NOCLIP, CMD_GODMODE, CMD_SPEED, CMD_DRUG, CMD_WEAPON, 
			CMD_BLANKS, CMD_NOBUY, CMD_BURY, CMD_UNBURY, CMD_DISARM, CMD_UBERSLAP, 
			CMD_FIRE, CMD_AUTOSLAY, CMD_ROCKET, /*CMD_BADAIM,*/ CMD_SLAY2, /*CMD_GAG,
			CMD_UNGAG,*/ CMD_PGRAVITY, CMD_TRANSFER, CMD_GLOW, CMD_GLOW2: {
				
			menu_additem( g_menuTargets[ iPlayerID ], "Terrorists" );
			menu_additem( g_menuTargets[ iPlayerID ], "Counter-Terrorists" );
			menu_additem( g_menuTargets[ iPlayerID ], "Spectators" );
			menu_additem( g_menuTargets[ iPlayerID ], "All Players^n" );
			menu_additem( g_menuTargets[ iPlayerID ], "Select specific players^n" );
		}
	}
	
	static strFormat[ 32 ], iParam1, iParam2;
	iParam1 = g_iPlayerCommandParam1[ iPlayerID ];
	iParam2 = g_iPlayerCommandParam2[ iPlayerID ];
	
	switch( iPlayerCommand ) {
		case CMD_HEAL, CMD_HP, CMD_ARMOR, CMD_AP: {
			formatex( strFormat, 31, "Give/Set: %i", iParam1 );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
		}
		
		case CMD_UNAMMO, CMD_UNAMMOBP, CMD_SPEED, CMD_BLANKS, CMD_NOBUY, CMD_AUTOSLAY: {
			formatex( strFormat, 31, "%s", ( iParam1 ) ? "On" : "Off" );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
		}
		
		case CMD_HSONLY: {
			formatex( strFormat, 31, "%s", ( iParam1 ) ? "On^n" : "Off^n" );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
			
			menu_additem( g_menuTargets[ iPlayerID ], "Execute" );
		}
		
		case CMD_SCORE: {
			formatex( strFormat, 31, "Frags: %i", iParam1 );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
			
			formatex( strFormat, 31, "Deaths: %i", iParam2 );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
		}
		
		case CMD_SLAY2: {
			switch( iParam1 ) {
				case 0: 	menu_additem( g_menuTargets[ iPlayerID ], "Lightning" );
				case 1:		menu_additem( g_menuTargets[ iPlayerID ], "Blood" );
				case 2:		menu_additem( g_menuTargets[ iPlayerID ], "Explode" );
			}
		}
		
		case CMD_NOCLIP, CMD_GODMODE: {
			switch( iParam1 ) {
				case 0:		menu_additem( g_menuTargets[ iPlayerID ], "Off" );
				case 1:		menu_additem( g_menuTargets[ iPlayerID ], "On" );
				case 2:		menu_additem( g_menuTargets[ iPlayerID ], "On + Every Round" );
			}
		}
		
		case CMD_BADAIM: {
			menu_additem( g_menuTargets[ iPlayerID ], "Select a specific player^n" );
			
			switch( iParam1 ) {
				case 0:		menu_additem( g_menuTargets[ iPlayerID ], "Off" );
				case 1:		menu_additem( g_menuTargets[ iPlayerID ], "On" );
				default: {
					formatex( strFormat, 31, "Timer: %i seconds", iParam1 );
					menu_additem( g_menuTargets[ iPlayerID ], strFormat );
				}
			}
		}
		
		case CMD_RESTART, CMD_SHUTDOWN: {
			formatex( strFormat, 31, "Timer: %i seconds^n", iParam1 );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
			
			menu_additem( g_menuTargets[ iPlayerID ], "Execute" );
		}
		
		case CMD_GAG: {
			menu_additem( g_menuTargets[ iPlayerID ], "Select a specific player^n" );
			
			get_flags( iParam1, strFormat, 31 );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
		}
		
		case CMD_UNGAG: {
			menu_additem( g_menuTargets[ iPlayerID ], "Select a specific player^n" );
		}
		
		case CMD_PGRAVITY: {
			formatex( strFormat, 31, "Gravity: %i", iParam1 );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
		}
		
		case CMD_GRAVITY: {
			formatex( strFormat, 31, "Gravity: %i^n", iParam1 );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
			
			menu_additem( g_menuTargets[ iPlayerID ], "Execute" );
		}
		
		case CMD_TRANSFER: {
			switch( iParam1 ) {
				case 0:		menu_additem( g_menuTargets[ iPlayerID ], "Team: Terrorist" );
				case 1:		menu_additem( g_menuTargets[ iPlayerID ], "Team: Counter-Terrorist" );
				case 2:		menu_additem( g_menuTargets[ iPlayerID ], "Team: Spectator" );
			}
		}
		
		case CMD_REVIVE: {
			formatex( strFormat, 31, "Health: %i", iParam1 );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
			
			formatex( strFormat, 31, "Armor: %i", iParam2 );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
		}
		
		case CMD_WEAPON: {
			menu_additem( g_menuTargets[ iPlayerID ], g_strWeapons[ iParam1 ] );
		}
		
		/*
			For all those questioning about format( ), you cannot use formatex( ) here,
			cause the source and destination are the same.
		*/
		case CMD_SWAP: {
			if( !iParam1 ) {
				menu_additem( g_menuTargets[ iPlayerID ], "Unspecified" );
			} else {
				get_user_name( iParam1, strFormat, 31 );
				format( strFormat, 31, "%s", strFormat );
				menu_additem( g_menuTargets[ iPlayerID ], strFormat );
			}
			
			if( !iParam2 ) {
				menu_additem( g_menuTargets[ iPlayerID ], "Unspecified^n" );
			} else {
				get_user_name( iParam2, strFormat, 31 );
				format( strFormat, 31, "%s^n", strFormat );
				menu_additem( g_menuTargets[ iPlayerID ], strFormat );
			}
			
			menu_additem( g_menuTargets[ iPlayerID ], "Execute" );
		}
		
		case CMD_GLOW, CMD_GLOW2: {
			menu_additem( g_menuTargets[ iPlayerID ], g_strColorArray[ iParam1 ] );
		}
		
		case CMD_EXTEND: {
			formatex( strFormat, 31, "Minutes: %i^n", iParam1 );
			menu_additem( g_menuTargets[ iPlayerID ], strFormat );
			
			menu_additem( g_menuTargets[ iPlayerID ], "Execute" );
		}
		
		case CMD_LOCK, CMD_UNLOCK: {
			menu_additem( g_menuTargets[ iPlayerID ], "Terrorist" );
			menu_additem( g_menuTargets[ iPlayerID ], "Counter-Terrorist" );
			menu_additem( g_menuTargets[ iPlayerID ], "Spectator" );
			menu_additem( g_menuTargets[ iPlayerID ], "Auto" );
		}
	}
	
	menu_setprop( g_menuTargets[ iPlayerID ], MPROP_NUMBER_COLOR, "\y" );
	menu_setprop( g_menuTargets[ iPlayerID ], MPROP_EXITNAME, "Back" );
	
	menu_display( iPlayerID, g_menuTargets[ iPlayerID ], 0 );
}

public Handle_TargetsMenu( iPlayerID, iMenu, iKey ) {
	if( iKey == MENU_EXIT ) {
		menu_destroy( g_menuTargets[ iPlayerID ] );
		ResetPlayerVariables( iPlayerID );
		menu_display( iPlayerID, g_menuMain, ( ( g_iPlayerCommand[ iPlayerID ] ) / 7 ) /*0*/ );
		
		return PLUGIN_HANDLED;
	}
	
	static iPlayerCommand;
	iPlayerCommand = g_iPlayerCommand[ iPlayerID ];
	
	/*
		Again here I am checking the commands that have the ability to execute
		on a specific team or even all players.
	*/
	switch( iPlayerCommand ) {
		case CMD_HEAL, CMD_HP, CMD_ARMOR, CMD_AP, CMD_UNAMMO, CMD_UNAMMOBP, CMD_SCORE,
			CMD_REVIVE, CMD_NOCLIP, CMD_GODMODE, CMD_SPEED, CMD_DRUG, CMD_WEAPON, 
			CMD_BLANKS, CMD_NOBUY, CMD_BURY, CMD_UNBURY, CMD_DISARM, CMD_UBERSLAP, 
			CMD_FIRE, CMD_AUTOSLAY, CMD_ROCKET, /*CMD_BADAIM,*/ CMD_SLAY2, /*CMD_GAG,
			CMD_UNGAG,*/ CMD_PGRAVITY, CMD_TRANSFER, CMD_GLOW, CMD_GLOW2: {
				
			switch( iKey ) {
				case 0:	{
					formatex( g_strPlayerCommandTarget[ iPlayerID ], 31, "@T" );
					ExecCommand( iPlayerID );
				}
				case 1: {
					formatex( g_strPlayerCommandTarget[ iPlayerID ], 31, "@CT" );
					ExecCommand( iPlayerID );
				}
				case 2:	{
					formatex( g_strPlayerCommandTarget[ iPlayerID ], 31, "@SPEC" );
					ExecCommand( iPlayerID );
				}
				case 3:	{
					formatex( g_strPlayerCommandTarget[ iPlayerID ], 31, "@ALL" );
					ExecCommand( iPlayerID );
				}
				case 4: {
					menu_destroy( g_menuTargets[ iPlayerID ] );
					ShowPlayerMenu( iPlayerID );
					
					return PLUGIN_HANDLED;
				}
			}
		}
	}
	
	static iParam1, iParam2;
	iParam1 = g_iPlayerCommandParam1[ iPlayerID ];
	iParam2 = g_iPlayerCommandParam2[ iPlayerID ];
	
	switch( iPlayerCommand ) {
		case CMD_HEAL, CMD_HP, CMD_ARMOR, CMD_AP: {
			if( iKey == 5 ) {
				static iValues[ 8 ] = {
					1, 10, 25, 50, 100, 250, 500, 1000
				};
				
				g_iPlayerCommandParam1[ iPlayerID ] = RotateR( iParam1, iValues, sizeof iValues );
			}
		}
		
		case CMD_UNAMMO, CMD_UNAMMOBP, CMD_SPEED, CMD_BLANKS, CMD_NOBUY, CMD_AUTOSLAY: {
			if( iKey == 5 ) {
				g_iPlayerCommandParam1[ iPlayerID ] = !g_iPlayerCommandParam1[ iPlayerID ];
			}
		}
		
		case CMD_HSONLY: {
			switch( iKey ) {
				case 0:	g_iPlayerCommandParam1[ iPlayerID ] = !g_iPlayerCommandParam1[ iPlayerID ];
				case 1: ExecCommand( iPlayerID );
			}
		}
		
		case CMD_SCORE: {
			if( iKey == 5 ) {
				g_iPlayerCommandParam1[ iPlayerID ]++;
			} else if( iKey == 6 ) {
				g_iPlayerCommandParam2[ iPlayerID ]++;
			}
		}
		
		case CMD_SLAY2, CMD_NOCLIP, CMD_GODMODE, CMD_TRANSFER: {
			if( iKey == 5 ) {
				static iValues[ 3 ] = {
					0, 1, 2
				};
				
				g_iPlayerCommandParam1[ iPlayerID ] = RotateR( iParam1, iValues, sizeof iValues );
			}
		}
		
		case CMD_RESTART, CMD_SHUTDOWN: {
			switch( iKey ) {
				case 0:	g_iPlayerCommandParam1[ iPlayerID ]++;
				case 1:	ExecCommand( iPlayerID );
			}
		}
		
		case CMD_BADAIM: {
			if( iKey == 0 ) {
				menu_destroy( g_menuTargets[ iPlayerID ] );
				ShowPlayerMenu( iPlayerID );
				
				return PLUGIN_HANDLED;
			} else if( iKey == 1 ) {
				g_iPlayerCommandParam1[ iPlayerID ]++;
			}
		}
		
		case CMD_GAG: {
			if( iKey == 0 ) {
				menu_destroy( g_menuTargets[ iPlayerID ] );
				ShowPlayerMenu( iPlayerID );
				
				return PLUGIN_HANDLED;
			} else if( iKey == 1 ) {
				if( iParam1 == 7 ) {
					g_iPlayerCommandParam1[ iPlayerID ] = 1;
				} else {
					g_iPlayerCommandParam1[ iPlayerID ]++;
				}	
			}
		}
		
		case CMD_UNGAG: {
			if( iKey == 0 ) {
				menu_destroy( g_menuTargets[ iPlayerID ] );
				ShowPlayerMenu( iPlayerID );
				
				return PLUGIN_HANDLED;
			}
		}
		
		case CMD_GRAVITY: {
			switch( iKey ) {
				case 0: {
					static iValues[ 8 ] = {
						0, 1, 25, 50, 100, 250, 500, 800
					};
					
					g_iPlayerCommandParam1[ iPlayerID ] = RotateR( iParam1, iValues, sizeof iValues );
				}
				
				case 1: ExecCommand( iPlayerID );
			}
		}
		
		case CMD_PGRAVITY: {
			if( iKey == 5 ) {
				static iValues[ 8 ] = {
					0, 1, 25, 50, 100, 250, 500, 800
				};
				
				g_iPlayerCommandParam1[ iPlayerID ] = RotateR( iParam1, iValues, sizeof iValues );
			}
		}
		
		case CMD_REVIVE: {
			static iValues[ 8 ] = {
				0, 1, 5, 10, 25, 50, 100, 1000
			};
			
			switch( iKey ) {
				case 5: g_iPlayerCommandParam1[ iPlayerID ] = RotateR( iParam1, iValues, sizeof iValues );
				case 6: g_iPlayerCommandParam2[ iPlayerID ] = RotateR( iParam2, iValues, sizeof iValues );
			}
		}
		
		case CMD_WEAPON: {
			if( iKey == 5 ) {
				menu_destroy( g_menuTargets[ iPlayerID ] );
				menu_display( iPlayerID, g_menuWeapons, 0 );
				
				return PLUGIN_HANDLED;
			}
		}
		
		case CMD_SWAP: {
			switch( iKey ) {
				case 0, 1: {
					g_iKey = iKey;
					
					menu_destroy( g_menuTargets[ iPlayerID ] );
					ShowPlayerMenu( iPlayerID );
					
					return PLUGIN_HANDLED;
				}
				case 2: {
					ExecCommand( iPlayerID );
				}
			}
		}
		
		case CMD_GLOW, CMD_GLOW2: {
			if( iKey == 5 ) {
				if( iParam1 == 29 ) {
					g_iPlayerCommandParam1[ iPlayerID ] = 0;
				} else {
					g_iPlayerCommandParam1[ iPlayerID ]++;
				}
			}
		}
		
		case CMD_EXTEND: {
			switch( iKey ) {
				case 0: g_iPlayerCommandParam1[ iPlayerID ]++;
				case 1: ExecCommand( iPlayerID );
			}
		}
		
		case CMD_LOCK, CMD_UNLOCK: {
			g_iPlayerCommandParam1[ iPlayerID ] = iKey;
			
			ExecCommand( iPlayerID );
		}
	}
	
	menu_destroy( g_menuTargets[ iPlayerID ] );
	CreateTargetsMenu( iPlayerID );
	
	return PLUGIN_HANDLED;
}

ShowPlayerMenu( iPlayerID ) {
	static strMenuTitle[ 64 ];
	formatex( strMenuTitle, 63, "\yChoose A Target:" );
	
	g_menuPlayers[ iPlayerID ] = menu_create( strMenuTitle, "Handle_PlayerMenu" );
	
	static strPlayerName[ 32 ], iPlayers[ 32 ], strID[ 8 ];
	static iLoop, iNum, iTempid;
	get_players( iPlayers, iNum );
	
	for( iLoop = 0; iLoop < iNum; iLoop++ ) {
		iTempid = iPlayers[ iLoop ];
		
		num_to_str( iTempid, strID, 7 );
		get_user_name( iTempid, strPlayerName, 31 );
		
		menu_additem( g_menuPlayers[ iPlayerID ], strPlayerName, strID );
	}
	
	menu_setprop( g_menuPlayers[ iPlayerID ], MPROP_NUMBER_COLOR, "\y" );
	menu_setprop( g_menuPlayers[ iPlayerID ], MPROP_EXITNAME, "Back" );
	
	menu_display( iPlayerID, g_menuPlayers[ iPlayerID ], 0 );
}

public Handle_PlayerMenu( iPlayerID, iMenu, iKey ) {
	if( iKey == MENU_EXIT ) {
		menu_destroy( g_menuPlayers[ iPlayerID ] );
		CreateTargetsMenu( iPlayerID );
		
		return PLUGIN_HANDLED;
	}
	
	static strPlayerID[ 32 ], strPlayerName[ 32 ], iAccess, iCallback;
	menu_item_getinfo( iMenu, iKey, iAccess, strPlayerID, 31, strPlayerName, 31, iCallback );
	
	static iTarget;
	iTarget = str_to_num( strPlayerID );
	
	if( g_iPlayerCommand[ iPlayerID ] == CMD_SWAP ) {
		switch( g_iKey ) {
			case 0: g_iPlayerCommandParam1[ iPlayerID ] = iTarget;
			case 1: g_iPlayerCommandParam2[ iPlayerID ] = iTarget;
		}
		
		menu_destroy( g_menuPlayers[ iPlayerID ] );
		CreateTargetsMenu( iPlayerID );
	} else {
		formatex( g_strPlayerCommandTarget[ iPlayerID ], 31, "%s", strPlayerName );
		ExecCommand( iPlayerID );
		
		menu_destroy( g_menuPlayers[ iPlayerID ] );
		ShowPlayerMenu( iPlayerID );
	}
	
	return PLUGIN_HANDLED;
}

CreateWeaponMenu( ) {
	new strMenuTitle[ 64 ];
	formatex( strMenuTitle, 63, "\yChoose A Weapon:" );
	
	g_menuWeapons = menu_create( strMenuTitle, "Handle_WeaponMenu" );
	
	new strNumber[ 8 ];
	
	for( new iLoop = 1; iLoop < sizeof g_strWeapons; iLoop++ ) {
		num_to_str( iLoop, strNumber, 7 );
		menu_additem( g_menuWeapons, g_strWeapons[ iLoop ], strNumber );
	}
	
	menu_setprop( g_menuWeapons, MPROP_NUMBER_COLOR, "\y" );
	menu_setprop( g_menuWeapons, MPROP_EXITNAME, "Back" );
}

public Handle_WeaponMenu( iPlayerID, iMenu, iKey ) {
	if( iKey == MENU_EXIT ) {
		CreateTargetsMenu( iPlayerID );
		
		return PLUGIN_HANDLED;
	}
	
	static strWeaponID[ 32 ], iAccess, iCallback;
	menu_item_getinfo( iMenu, iKey, iAccess, strWeaponID, 31, _, _, iCallback );
	
	static iWeaponID;
	iWeaponID = str_to_num( strWeaponID );
	
	g_iPlayerCommandParam1[ iPlayerID ] = iWeaponID;
	
	CreateTargetsMenu( iPlayerID );
	
	return PLUGIN_HANDLED;
}

/* Other Functions */
ExecCommand( iPlayerID ) {
	static strFormat[ 64 ];
	
	switch( g_iPlayerCommand[ iPlayerID ] ) {
		/*
			Two arguments (including command) (2ND = PLAYER)
		*/
		case CMD_TELEPORT, CMD_USERORIGIN, CMD_DRUG, CMD_BURY, CMD_UNBURY,
			CMD_DISARM, CMD_UBERSLAP, CMD_FIRE, CMD_ROCKET, CMD_UNGAG: {
			
			formatex( strFormat, 63, "%s ^"%s^"", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ] );
			client_cmd( iPlayerID, strFormat );
		}
		
		/*
			Two arguments (including command) (2ND != PLAYER)
		*/
		case CMD_HSONLY, CMD_EXTEND, CMD_GRAVITY, CMD_RESTART, CMD_SHUTDOWN: {
			formatex( strFormat, 63, "%s %i", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_iPlayerCommandParam1[ iPlayerID ] );
			client_cmd( iPlayerID, strFormat );
		}
		
		/*
			Three arguments (including command)
		*/
		case CMD_HEAL, CMD_HP, CMD_ARMOR, CMD_AP, CMD_UNAMMO, CMD_UNAMMOBP, CMD_NOCLIP,
			CMD_GODMODE, CMD_SPEED, CMD_BLANKS, CMD_NOBUY, CMD_AUTOSLAY, CMD_BADAIM, 
			CMD_SLAY2, CMD_PGRAVITY: {
			
			formatex( strFormat, 63, "%s ^"%s^" %i", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ], g_iPlayerCommandParam1[ iPlayerID ] );
			client_cmd( iPlayerID, strFormat );
		}
		
		/*
			Four arguments (includuing command)
		*/
		case CMD_SCORE: {
			formatex( strFormat, 63, "%s ^"%s^" %i %i", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ], g_iPlayerCommandParam1[ iPlayerID ], g_iPlayerCommandParam2[ iPlayerID ] );
			client_cmd( iPlayerID, strFormat );
		}
		
		case CMD_SWAP: {
			formatex( strFormat, 63, "%s #%i #%i", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], get_user_userid( g_iPlayerCommandParam1[ iPlayerID ] ), get_user_userid( g_iPlayerCommandParam2[ iPlayerID ] ) );
			client_cmd( iPlayerID, strFormat );
		}
		
		case CMD_LOCK, CMD_UNLOCK: {
			switch( g_iPlayerCommandParam1[ iPlayerID ] ) {
				case 0: formatex( strFormat, 63, "%s t", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ] );
				case 1:	formatex( strFormat, 63, "%s c", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ] );
				case 2: formatex( strFormat, 63, "%s s", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ] );
				case 3: formatex( strFormat, 63, "%s a", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ] );
			}
			client_cmd( iPlayerID, strFormat );
		}
		
		case CMD_GLOW, CMD_GLOW2: {
			formatex( strFormat, 63, "%s ^"%s^" %s", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ], g_strColorArray[ g_iPlayerCommandParam1[ iPlayerID ] ] );
			client_cmd( iPlayerID, strFormat );
		}
		
		case CMD_REVIVE: {
			if( g_iPlayerCommandParam1[ iPlayerID ] || g_iPlayerCommandParam2[ iPlayerID ] ) {
				formatex( strFormat, 63, "%s ^"%s^" %i %i", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ], g_iPlayerCommandParam1[ iPlayerID ], g_iPlayerCommandParam2[ iPlayerID ] );
				client_cmd( iPlayerID, strFormat );
			} else {
				formatex( strFormat, 63, "%s ^"%s^"", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ] );
				client_cmd( iPlayerID, strFormat );
			}
		}
		
		case CMD_WEAPON: {
			formatex( strFormat, 63, "%s ^"%s^" %s", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ], g_strWeapons[ g_iPlayerCommandParam1[ iPlayerID ] ] );
			client_cmd( iPlayerID, strFormat );
		}
		
		case CMD_TRANSFER: {
			switch( g_iPlayerCommandParam1[ iPlayerID ] ) {
				case 0: formatex( strFormat, 63,"%s ^"%s^" t", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ] );
				case 1: formatex( strFormat, 63,"%s ^"%s^" c", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ] );
				case 2: formatex( strFormat, 63,"%s ^"%s^" s", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ] );
				case 3: formatex( strFormat, 63,"%s ^"%s^" a", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ] );
			}
			
			client_cmd( iPlayerID, strFormat );
		}
		
		case CMD_GAG: {
			get_flags( g_iPlayerCommandParam1[ iPlayerID ], strFormat, 63 );
			format( strFormat, 63, "%s ^"%s^" %s", g_strCommands[ g_iPlayerCommand[ iPlayerID ] ], g_strPlayerCommandTarget[ iPlayerID ], strFormat );
			client_cmd( iPlayerID, strFormat );
		}
	}
	
	/* Debug Feature */
	/* client_print( iPlayerID, print_chat, strFormat ); */
}

ResetPlayerVariables( iPlayerID ) {
	switch( g_iPlayerCommand[ iPlayerID ] ) {
		case CMD_WEAPON, CMD_PGRAVITY, CMD_GRAVITY, CMD_GAG, CMD_HEAL, CMD_HP, CMD_ARMOR, CMD_AP: {
			g_iPlayerCommandParam1[ iPlayerID ] = 1;
		}
		
		case CMD_SWAP, CMD_SCORE, CMD_REVIVE: {
			g_iPlayerCommandParam1[ iPlayerID ] = 0;
			g_iPlayerCommandParam2[ iPlayerID ] = 0;
		}
		
		default: {
			g_iPlayerCommandParam1[ iPlayerID ] = 0;
		}
	}
}

RotateR( iParam1, iValues[ ], iSize ) {
	if( iParam1 == iValues[ --iSize ] ) {
		return iValues[ 0 ];
	}
	
	static iLoop; 
	iLoop = 0;
	
	while( iLoop < iSize ) {
		if( iValues[ iLoop ] == iParam1 ) {
			return iValues[ ++iLoop ];
		}
		
		iLoop++;
	}
	
	return 0;
}

/*
	Notepad++ Allied Modders Edition v6.3.1
	Style Configuration:	Default
	Font:			Consolas
	Font size:		10
	Indent Tab:		8 spaces
*/