Scriptname Halo:Announcer:KillSpree extends Quest
import Halo:Announcer:Log

Actor Player
int Kills = 0

; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
	RegisterForRemoteEvent(Player, "OnCombatStateChanged")
	If (Player.IsInCombat())
		GotoState(CombatingState)
		WriteLine(self, "OnQuestInit: Is in combat.")
	Else
		WriteLine(self, "OnQuestInit: Registered for combat state.")
	EndIf
EndEvent


Event OnQuestShutdown()
	Kills = 0
	UnregisterForAllEvents()
	WriteLine(self, "OnQuestShutdown")
EndEvent


Event Actor.OnCombatStateChanged(Actor akSender, Actor akTarget, int aeCombatState)
	If (Player.IsInCombat())
		GotoState(CombatingState)
	EndIf
EndEvent


Event Actor.OnKill(Actor akSender, Actor akVictim)
	{EMPTY}
	WriteNotImplemented(self, "Actor.OnKill")
EndEvent


; States
;---------------------------------------------

State Combating
	Event OnBeginState(string asOldState)
		Kills = 0
		RegisterForRemoteEvent(Player, "OnKill")
		WriteLine(self, "Combat has begun.")
	EndEvent

	Event Actor.OnCombatStateChanged(Actor akSender, Actor akTarget, int aeCombatState)
		If (Player.IsInCombat() == false)
			GotoState(EmptyState)
		EndIf
	EndEvent

	Event Actor.OnKill(Actor akSender, Actor akVictim)
		Kills += 1
		Annouce(Kills)
		WriteLine(self, "Killed "+Kills)
	EndEvent

	Event OnEndState(string asNewState)
		Kills = 0
		UnregisterForRemoteEvent(Player, "OnKill")
		WriteLine(self, "Combat has ended.")
	EndEvent
EndState


; Functions
;---------------------------------------------

Function Annouce(int killed)
	If (killed == KillingSpree)
		VoiceEntry_HaloAnnouncer_Spree_KillingSpree.Play(Player)
	ElseIf (killed == KillingFrenzy)
		VoiceEntry_HaloAnnouncer_Spree_KillingFrenzy.Play(Player)
	ElseIf (killed == RunningRiot)
		VoiceEntry_HaloAnnouncer_Spree_RunningRiot.Play(Player)
	ElseIf (killed == Rampage)
		VoiceEntry_HaloAnnouncer_Spree_Rampage.Play(Player)
	ElseIf (killed == Untouchable)
		VoiceEntry_HaloAnnouncer_Spree_Untouchable.Play(Player)
	ElseIf (killed == Invincible)
		VoiceEntry_HaloAnnouncer_Spree_Invincible.Play(Player)
	ElseIf (killed == Inconceivable)
		VoiceEntry_HaloAnnouncer_Spree_Inconceivable.Play(Player)
	ElseIf (killed == Unfrigginbelievable)
		VoiceEntry_HaloAnnouncer_Spree_Unfrigginbelievable.Play(Player)
	Else
		WriteUnexpectedValue(self, "Annouce", "killed", "The kill count of "+killed+" was unhandled.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group States
	string Property EmptyState = "" AutoReadOnly
	string Property CombatingState = "Combating" AutoReadOnly
EndGroup

Group Kills
	int Property KillingSpree = 5 AutoReadOnly
	int Property KillingFrenzy = 10 AutoReadOnly
	int Property RunningRiot = 15 AutoReadOnly
	int Property Rampage = 20 AutoReadOnly
	int Property Untouchable = 25 AutoReadOnly
	int Property Invincible = 30 AutoReadOnly
	int Property Inconceivable = 35 AutoReadOnly
	int Property Unfrigginbelievable = 40 AutoReadOnly
EndGroup

Group Sounds
	Sound Property VoiceEntry_HaloAnnouncer_Spree_KillingSpree Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_Spree_KillingFrenzy Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_Spree_RunningRiot Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_Spree_Rampage Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_Spree_Untouchable Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_Spree_Invincible Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_Spree_Inconceivable Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_Spree_Unfrigginbelievable Auto Const Mandatory
EndGroup
