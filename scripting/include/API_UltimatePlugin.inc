#if defined API_UltimatePlugin_Included
	#endinput
#endif

#define API_UltimatePlugin_Included

#if AMXX_VERSION_NUM >= 175
	#pragma reqlib API_UltimatePlugin
	
	#if !defined AMXMODX_NOAUTOLOAD
		#pragma loadlib API_UltimatePlugin
	#endif
#else
	#pragma library API_UltimatePlugin
#endif

/*
	This is an include file for UltimatePlugin. In order
	to use this you have to have UltimatePlugin.amxx 
	running on your server.
	
	Get the plugin and more info from:
	https://forums.alliedmods.net/showthread.php?t=212867
*/

/*
	The below get natives are pretty much self explanatory.
	Note: 	- those natives return 1 if positive/success and 0 if negative/failure.
		- for the get natives, it will return -1 on failure (for example user is
		not connected or dead)
*/
native up_get_user_unammo( iPlayerID );
native up_get_user_unammobp( iPlayerID );
native up_get_user_speed( iPlayerID );
native up_get_user_blanks( iPlayerID );
native up_get_user_nobuy( iPlayerID );
native up_get_user_fire( iPlayerID );
native up_get_user_autoslay( iPlayerID );
native up_get_user_badaim( iPlayerID );
native up_get_user_afk( iPlayerID );
native up_get_user_mute( iPlayerID, iMutePlayerID );

native up_set_user_unammo( iPlayerID, iState = 0 );
native up_set_user_unammobp( iPlayerID, iState = 0 );
native up_set_user_speed( iPlayerID, iState = 0 );
native up_set_user_blanks( iPlayerID, iState = 0 );
native up_set_user_nobuy( iPlayerID, iState = 0 );
native up_set_user_fire( iPlayerID, iState = 0 );
native up_set_user_autoslay( iPlayerID, iState = 0 );
native up_set_user_badaim( iPlayerID, iState = 0 );

native up_user_revive( iPlayerID );
native up_user_drug( iPlayerID );
native up_user_bury( iPlayerID );
native up_user_unbury( iPlayerID );
native up_user_disarm( iPlayerID );
native up_user_uberslap( iPlayerID );
native up_user_rocket( iPlayerID );

/*
	The below natives will lock/unlock teams.
	strTeam can start with:
	't', 'T': TERRORIST
	'c', 'C': COUNTER
	's', 'S': SPEC
	'a', 'A': AUTO
	Will return 1 on success and 0 on failure
	
*/
native up_lock_team( strTeam[ ] );
native up_unlock_team( strTeam[ ] );

/*
	The below native will slay the player in another way than normal.
	0: Lightning
	1: Blood
	3: Explode
	Will return 1 on success and 0 on failure
*/
native up_user_slay2( iPlayerID, iType );

/*
	The following native will return the gag flags of the user.
	Note: you would have to use get_flags after getting the sum
	of bits if you don't know what the sum of bits is equal to.
	Will return 1 on success and 0 on failure
*/
native up_get_user_gag( iPlayerID );

/*
	The below native will gag a user. Flags range from 'a' to 'c'.
	You can combine flags like so 'ab' or 'abc'.
	'a': gag say
	'b': gag say_team
	'c': gag voice_com
	Will return 1 on success and 0 on failure
*/
native up_set_user_gag( iPlayerID, strFlags[ ] = "^0" );

/*
	The below native will turn ON or OFF HS only on the server.
	Note: 0 means OFF and 1 means ON
	Will return 1 on success and 0 on failure
*/
native up_get_hsonly( );
native up_set_hsonly( iState );

/*
	The below native will set the frags and deaths of a user.
	Will return 1 on success and 0 on failure
*/
native up_set_user_score( iPlayerID, iFrags, iDeaths );