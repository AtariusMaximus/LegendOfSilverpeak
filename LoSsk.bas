 set hssupport $4444

 displaymode 320A
 BACKGRND=$0
 set zoneheight 8
 set basepath dm_gfx
 incgraphic dm_atascii4.png 320A 
 incgraphic arrowleft.png 320A 
 incgraphic arrowright.png 320A 
 incgraphic texttitle2.png 320A 
 P0C2=$0F
 P1C2=$1F
 P2C2=$2F
 P7C2=$28
 characterset dm_atascii4
 alphachars ASCII

   dim STR=var1
   dim INT=var2
   dim VIT=var3
   dim DEX=var4
   dim HP=var5
   dim HPMax=var6
   dim mana=var7
   dim manamax=var8 
   dim LevelHi=var9
   dim LevelMed=var10
   dim LevelLo=var11
   dim GoldHi=var12
   dim GoldMed=var13
   dim GoldLo=var14
   dim XPHi=var15
   dim XPMed=var16
   dim XPLo=var17
   dim magic_val=var18
   dim hpotion_val=var19
   dim ring_val=var20
   dim sword_val=var21
   dim armor_val=var22
   dim key_val=var23
   dim shield_val=var24
   dim rope_val=var25
   dim rodoflife=var26
   dim derame=var27
   dim sephmond=var28
   dim ugutz=var29
   dim room=var30
   dim key=var31 
   dim xpos=var32 
   dim ypos=var33 
   dim crystal1_flag=var34
   dim crystal2_flag=var35
   dim crystal3_flag=var36
   dim crystal4_flag=var37
   dim crystal5_flag=var38
   dim crystal6_flag=var39
   dim crystal7_flag=var40
   dim lastroom=var41 
   dim mpotion_val=var42 
   dim sword=var43 
   dim shield=var44
   dim armor=var45
   dim health=var46
   dim pagecolor1=var47
   dim pagecolor2=var48

 gamedifficulty=0
 loadmemory STR INT VIT DEX HP HPMax mana manamax LevelHi LevelMed LevelLo GoldHi GoldMed GoldLo XPHi XPMed XPLo magic_val hpotion_val ring_val sword_val ring_val armor_val key_val shield_val
 gamedifficulty=1
 loadmemory rope_val rodoflife derame sephmond ugutz room key xpos ypos crystal1_flag crystal2_flag crystal3_flag crystal4_flag crystal5_flag crystal6_flag crystal7_flag lastroom mpotion_val sword shield armor health

 clearscreen
 savescreen

main
 drawwait
 clearscreen
 plotsprite texttitle2 7 36 0
 pagecolor1=2
 pagecolor2=0
 ;Left Column
 ;plotchars 'Legend of Silverpeak' 0 30 0 : 
 plotchars 'SaveKey Reader' 0 40 23
 plotchars 'Page 1' pagecolor1 32 21: plotchars 'Page 2' pagecolor2 80 21
 plotsprite arrowleft 0 26 168
 plotsprite arrowright 0 106 168
 plotchars 'Strength' 1 4 3
 plotvalue dm_atascii4 0 STR    2 42 3
 plotchars 'Int'      1 4 4
 plotvalue dm_atascii4 0 INT    2 42 4
 plotchars 'Vitality' 1 4 5
 plotvalue dm_atascii4 0 VIT    2 42 5
 plotchars 'Dexterity' 1 4 6
 plotvalue dm_atascii4 0 DEX    2 42 6
 plotchars 'HP' 1 4 7
 plotvalue dm_atascii4 0 HP     2 42 7
 plotchars 'HP Max' 1 4 8
 plotvalue dm_atascii4 0 HPMax  2 42 8
 plotchars 'MP' 1 4 9
 plotvalue dm_atascii4 0 mana   2 42 9
 plotchars 'MP Max' 1 4 10
 plotvalue dm_atascii4 0 manamax 2 42 10
 plotchars 'Magic Val' 1 76 12
 plotvalue dm_atascii4 0 magic_val 2 116 12
 plotchars 'HP Potion' 1 76 13
 plotvalue dm_atascii4 0 hpotion_val 2 116 13
 plotchars 'MP Potion' 1 76 14
 plotvalue dm_atascii4 0 mpotion_val 2 116 14
 plotchars 'Ring Val' 1 76 15
 plotvalue dm_atascii4 0 ring_val 2 116 15
 plotchars 'Armor Val' 1 76 16
 plotvalue dm_atascii4 0 armor_val 2 116 16
 plotchars 'Key Val' 1 76 17
 plotvalue dm_atascii4 0 key_val 2 116 17
 plotchars 'Crystal 1' 1 4 12
 plotvalue dm_atascii4 0 crystal1_flag 1 46 12
 plotchars 'Crystal 2' 1 4 13
 plotvalue dm_atascii4 0 crystal2_flag 1 46 13
 plotchars 'Crystal 3' 1 4 14
 plotvalue dm_atascii4 0 crystal3_flag 1 46 14
 plotchars 'Crystal 4' 1 4 15
 plotvalue dm_atascii4 0 crystal4_flag 1 46 15
 plotchars 'Crystal 5' 1 4 16
 plotvalue dm_atascii4 0 crystal5_flag 1 46 16
 plotchars 'Crystal 6' 1 4 17
 plotvalue dm_atascii4 0 crystal6_flag 1 46 17
 plotchars 'Crystal 7' 1 4 18
 plotvalue dm_atascii4 0 crystal7_flag 1 46 18
 ;Right Column
 plotchars 'Gold' 1 76 3
 plotvalue dm_atascii4 0 GoldHi    2 100 3
 plotvalue dm_atascii4 0 GoldMed   2 108 3
 plotvalue dm_atascii4 0 GoldLo    2 116 3
 plotchars 'Level' 1 76 4
 plotvalue dm_atascii4 0 LevelHi    2 100 4
 plotvalue dm_atascii4 0 LevelMed   2 108 4
 plotvalue dm_atascii4 0 LevelLo    2 116 4
 plotchars 'XP' 1 76 5
 plotvalue dm_atascii4 0 XPHi    2 100 5
 plotvalue dm_atascii4 0 XPMed   2 108 5
 plotvalue dm_atascii4 0 XPLo    2 116 5
 plotchars 'Room' 1 76 7
 plotvalue dm_atascii4 0 room 3 116 7
 plotchars 'Last Room' 1 76 8
 plotvalue dm_atascii4 0 lastroom 3 116 8
 plotchars 'X Pos' 1 76 9
 plotvalue dm_atascii4 0 xpos 3 116 9
 plotchars 'Y Pos' 1 76 10
 plotvalue dm_atascii4 0 ypos 3 116 10
 if joy0right then goto secondscreen
 drawscreen
 if switchreset then goto restartme
 goto main

secondscreen
  clearscreen
secondscreenloop
  drawwait
  clearscreen
  pagecolor1=0
  pagecolor2=2
  plotchars 'Legend of Silverpeak' 0 0 0 : plotchars 'SaveKey Reader' 0 86 0
  plotchars 'Page 1' pagecolor1 32 21: plotchars 'Page 2' pagecolor2 80 21
  plotsprite arrowleft 0 26 168
  plotsprite arrowright 0 106 168
  plotchars 'Sword' 1 4 3
  plotvalue dm_atascii4 0 sword 2 38 3
  plotchars 'Shield' 1 4 4
  plotvalue dm_atascii4 0 shield  2 38 4
  plotchars 'Armor' 1 4 5
  plotvalue dm_atascii4 0 armor 2 38 5
  plotchars 'Health' 1 4 6
  plotvalue dm_atascii4 0 health 2 38 6
  plotchars 'Derame' 1 4 8
  plotvalue dm_atascii4 0 derame 2 38 8
  plotchars 'Sephmond' 1 4 9
  plotvalue dm_atascii4 0 sephmond 2 38 9
  plotchars 'Ugutz' 1 4 10
  plotvalue dm_atascii4 0 ugutz 2 38 10
  if joy0left then goto main
  if switchreset then goto restartme
  drawscreen
  goto secondscreenloop

restartme
   if switchreset then goto restartme
   reboot

   rem default values for variables
   STR=$08 : INT=$12 : VIT=$08 : DEX=$09 : HP=$25 : HPMax=$25
   mana=$25 : manamax=$25
   LevelHi=$00: LevelMed=$00: LevelLo=$01
   GoldHi=$00 : GoldMed=$01 : GoldLo=$90
   XPHi=$00 : XPMed=$00 : XPLo=$00
   magic_val=$010 : hpotion_val=$08 : ring_val=$01 : sword_val=$01 : ring_val=$01 : armor_val=$01 : key_val=$01 : shield_val=$01 : rope_val=$00 : rodoflife=0
   derame=0 : sephmond=0 : ugutz=0
   room=137 : key=0
   xpos=28 : ypos=26
   crystal1_flag=0 : crystal2_flag=0 : crystal3_flag=0 : crystal4_flag=0
   crystal5_flag=0 : crystal6_flag=0 : crystal7_flag=0
   lastroom=137  
   mpotion_val=$08
   sword=1
   shield=1
   armor=1
   health=8
   gamedifficulty=0
   savememory STR INT VIT DEX HP HPMax mana manamax LevelHi LevelMed LevelLo GoldHi GoldMed GoldLo XPHi XPMed XPLo magic_val hpotion_val ring_val sword_val ring_val armor_val key_val shield_val
   gamedifficulty=1
   savememory rope_val rodoflife derame sephmond ugutz room key xpos ypos crystal1_flag crystal2_flag crystal3_flag crystal4_flag crystal5_flag crystal6_flag crystal7_flag lastroom mpotion_val sword shield armor health
