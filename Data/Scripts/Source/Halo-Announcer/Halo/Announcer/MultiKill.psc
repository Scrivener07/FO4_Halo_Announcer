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
		HaloAnnouncer_DoubleKill.Play(Player)
	ElseIf (killed == TripleKill)
		HaloAnnouncer_TripleKill.Play(Player)
	ElseIf (killed == Overkill)
		HaloAnnouncer_Overkill.Play(Player)
	ElseIf (killed == Killtacular)
		HaloAnnouncer_Killtacular.Play(Player)
	ElseIf (killed == Killtrocity)
		HaloAnnouncer_Killtrocity.Play(Player)
	ElseIf (killed == Killamanjaro)
		HaloAnnouncer_Killimanjaro.Play(Player)
	ElseIf (killed == Killtastrophe)
		HaloAnnouncer_Killtastrophe.Play(Player)
	ElseIf (killed == Killpocalypse)
		HaloAnnouncer_Killpocalypse.Play(Player)
	ElseIf (killed >= Killionaire)
		HaloAnnouncer_Killionaire.Play(Player)
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
	Sound Property HaloAnnouncer_DoubleKill Auto Const Mandatory
	Sound Property HaloAnnouncer_TripleKill Auto Const Mandatory
	Sound Property HaloAnnouncer_Overkill Auto Const Mandatory
	Sound Property HaloAnnouncer_Killtacular Auto Const Mandatory
	Sound Property HaloAnnouncer_Killtrocity Auto Const Mandatory
	Sound Property HaloAnnouncer_Killimanjaro Auto Const Mandatory
	Sound Property HaloAnnouncer_Killtastrophe Auto Const Mandatory
	Sound Property HaloAnnouncer_Killpocalypse Auto Const Mandatory
	Sound Property HaloAnnouncer_Killionaire Auto Const Mandatory
EndGroup
