Scriptname Halo:Announcer:MultiKill extends Quest
import Halo:Announcer:Log

Actor Player
int Kills = 0

; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
	RegisterForTrackedStatsEvent(PeopleKilled, GetNext())
	WriteLine(self, "OnQuestInit: Registered for the "+PeopleKilled+" tracked stat.")
EndEvent


Event OnQuestShutdown()
	Kills = 0
	UnregisterForAllEvents()
	WriteLine(self, "OnQuestShutdown")
EndEvent


Event OnTrackedStatsEvent(string asStat, int aiStatValue)
	GotoState(KillingState)
EndEvent


; States
;---------------------------------------------

State Killing
	Event OnBeginState(string asOldState)
		{Get a kill before the timer expires.}
		Kills = 1
		StartTimer(ExpireTime)
		RegisterForTrackedStatsEvent(PeopleKilled, GetNext())
		WriteLine(self, "First Kill!")
	EndEvent

	Event OnTrackedStatsEvent(string asStat, int aiStatValue)
		{Another kill has occured.}
		CancelTimer()
		StartTimer(ExpireTime)
		Kills += 1
		Annouce(Kills)
		RegisterForTrackedStatsEvent(PeopleKilled, GetNext())
		WriteLine(self, "Killed "+Kills)
	EndEvent

	Event OnTimer(int aiTimerID)
		{The timer has expired.}
		GotoState(EmptyState)
		WriteLine(self, "The timer has expired.")
	EndEvent

	Event OnEndState(string asNewState)
		{Wait for the first kill.}
		Kills = 0
		RegisterForTrackedStatsEvent(PeopleKilled, GetNext())
		WriteLine(self, "Waiting for first kill.")
	EndEvent
EndState


; Functions
;---------------------------------------------

Function Annouce(int killed)
	If (killed == DoubleKill)
		VoiceEntry_HaloAnnouncer_MultiKill_DoubleKill.Play(Player)
	ElseIf (killed == TripleKill)
		VoiceEntry_HaloAnnouncer_MultiKill_TripleKill.Play(Player)
	ElseIf (killed == Overkill)
		VoiceEntry_HaloAnnouncer_MultiKill_Overkill.Play(Player)
	ElseIf (killed == Killtacular)
		VoiceEntry_HaloAnnouncer_MultiKill_Killtacular.Play(Player)
	ElseIf (killed == Killtrocity)
		VoiceEntry_HaloAnnouncer_MultiKill_Killtrocity.Play(Player)
	ElseIf (killed == Killamanjaro)
		VoiceEntry_HaloAnnouncer_MultiKill_Killimanjaro.Play(Player)
	ElseIf (killed == Killtastrophe)
		VoiceEntry_HaloAnnouncer_MultiKill_Killtastrophe.Play(Player)
	ElseIf (killed == Killpocalypse)
		VoiceEntry_HaloAnnouncer_MultiKill_Killpocalypse.Play(Player)
	ElseIf (killed >= Killionaire)
		VoiceEntry_HaloAnnouncer_MultiKill_Killionaire.Play(Player)
	Else
		WriteUnexpectedValue(self, "Annouce", "killed", "The kill count of "+killed+" was unhandled.")
	EndIf
EndFunction


int Function GetNext()
	return Game.QueryStat(PeopleKilled) + 1
EndFunction


; Properties
;---------------------------------------------

Group Properties
	float Property ExpireTime = 4.5 AutoReadOnly
EndGroup

Group States
	string Property EmptyState = "" AutoReadOnly
	string Property KillingState = "Killing" AutoReadOnly
EndGroup

Group TrackedStats
	string Property PeopleKilled = "People Killed" AutoReadOnly
EndGroup

Group Kills
	int Property DoubleKill = 2 AutoReadOnly
	int Property TripleKill = 3 AutoReadOnly
	int Property Overkill = 4 AutoReadOnly
	int Property Killtacular = 5 AutoReadOnly
	int Property Killtrocity = 6 AutoReadOnly
	int Property Killamanjaro = 7 AutoReadOnly
	int Property Killtastrophe = 8 AutoReadOnly
	int Property Killpocalypse = 9 AutoReadOnly
	int Property Killionaire = 10 AutoReadOnly
EndGroup

Group Sounds
	Sound Property VoiceEntry_HaloAnnouncer_MultiKill_DoubleKill Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_MultiKill_TripleKill Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_MultiKill_Overkill Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_MultiKill_Killtacular Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_MultiKill_Killtrocity Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_MultiKill_Killimanjaro Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_MultiKill_Killtastrophe Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_MultiKill_Killpocalypse Auto Const Mandatory
	Sound Property VoiceEntry_HaloAnnouncer_MultiKill_Killionaire Auto Const Mandatory
EndGroup
