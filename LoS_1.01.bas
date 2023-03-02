                                                                                                                          /* 
;v1.01 Update 7/14/2022 - Load/Save/Erase Game tested and working on real hardware (CC2 with SaveKey)

    ‗▄■▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀■▄‗       
   ▄▀      .                  .-.    .  _   *     _   .                   ▀▄
 ▄█▀               *          /   \     ((       _/ \       *    .         ▀█▄
▄█              _    .   .--'\/\_ \     `      /    \  *    ___              █▄
█           *  / \_    _/ ^      \/\'__        /\/\  /\  __/   \ *            █
█              /    \  /    .'   _/  /  \  *' /    \/  \/ .`'\_/\   .         █
█         .   /\/\  /\/ :' __  ^/  ^/    `--./.'  ^  `-.\ _    _:\ _          █
█            /    \/  \  _/  \-' __/.' ^ _   \_   .'\   _/ \ .  __/ \         █
█          /\  .-   `. \/     \ / -.   _/ \ -. `_/   \ /    `._/  ^  \        █
█         /  `-.__ ^   / .-'.--'    . /    `--./ .-'  `-.  `-. `.  -  `.      █
█       @/        `.  / /      `-.   /  .-'   / .   .'   \    \  \  .-  \%    █
█       @&8jgs@@%% @)&@&(88&@.-_=_-=_-=_-=_-=_.8@% &@&&8(8%@%8)(8@%8 8%@)%    █
█       @88:::&(&8&&8:::::%&`.~-_~~-~~_~-~_~-~~=.'@(&%::::%@8&8)::&#@8::::    █
▀█▄    `::::::8%@@%:::::@%&8:`.=~~-.~~-.~~=..~'8::::::::&@8:::::&8:::::'    ▄█▀
   ▀▄    `:::::::::::::::::::The Legend of Silverpeak:::::::::::::::::.'   ▄▀
     ▀■▄▄▄▄▄▄█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█▄▄▄▄▄▄■▀ 
        ͜  ͜   ▓▒    ͜  ͜   ͜  ͜   ͜  ͜   ͜  ͜             ͜  ͜   ͜  ͜   ͜  ͜  ˾  ▓▒  ͜  ͜ 
                            (c) 2018 Steve Engelhardt
   ╔══════════════════════════════════════════════════════════════╗ 
   ║ ROM Bank Layout (32 banks * 16k = 512k):                     ║
   ╚════╦═════════════════════════════════════════════════════════╝  
	     ╚―→ ―bank 1──────────────────────────────────────────═┐
	     ║	 ▪ 16k ► initialization, main loop, inline avoxcode
	     ╚―→ ―bank 2──────────────────────────────────────────═┐
	     ║	 ▪ 16k ► map data rooms 0-63, Overworld
	     ╚―→ ―bank 3──────────────────────────────────────────═┐
	     ║	 ▪ 16k ► map data rooms 64-127, Overworld
	     ╚―→ ―bank 4──────────────────────────────────────────═┐ 
	     ║	 ▪ 16k ► map data rooms 128-191, Towns/Buildings
	     ╚―→ ―bank 5──────────────────────────────────────────═┐
	     ║	 ▪ 16k ► map data rooms 192-255, Dungeons
	     ╚―→ ―bank 6──────────────────────────────────────────═┐
	     ║	 ▪ 4k GFX 0 ► Overworld Tiles 
	     ║	 ▪ 4k DMA 0 ► unused
	     ║	 ▪ 4k GFX 1 ► overworld Specific sprites
	     ║	 ▪ 4k DMA 1 ► unused
	     ╚―→ ―bank 7──────────────────────────────────────────═┐
	     ║	 ▪ 4k GFX 0 ► Town Tiles / Sprites
	     ║	 ▪ 4k DMA 0 ► unused
	     ║	 ▪ 8k ► 
	     ╚―→ ―bank 8──────────────────────────────────────────═┐
	     ║	 ▪ 4k GFX 0 ► Underworld Tiles / Sprites
	     ║	 ▪ 4k DMA 0 ► unused
	     ║	 ▪ 8k ► turn-based attack loop initialization
	     ╚―→ ―bank 9──────────────────────────────────────────═┐
        ║	 ▪ 4k GFX 0 ► Turn Based Attack Tiles / Sprites
	     ║	 ▪ 4k DMA 0 ► unused
	     ║	 ▪ 8k ► Turn Based Attack Code
	     ╚―→ ―bank 10─────────────────────────────────────────═┐
        ║	 ▪ 4k GFX 0 ► Marketplace Tiles / Sprites
	     ║	 ▪ 4k DMA 0 ► unused
	     ║	 ▪ 8k ► Marketplace Code
	     ╚―→ ―bank 11─────────────────────────────────────────═┐
        ║	 ▪ 4k GFX 0 ► Titlescreen Tiles / Sprites
	     ║	 ▪ 4k DMA 0 ► unused
	     ║	 ▪ 8k ► Titlescreen Code
	     ╚―→ ―bank 12─────────────────────────────────────────═┐
        ║	 ▪ 4k GFX 0 ► Message / Sign Map Data
	     ║	 ▪ 4k DMA 0 ► unused
	     ║	 ▪ 16k ► unused
	     ╚―→ ―bank 13─────────────────────────────────────────═┐
        ║	 ▪ 4k GFX 0 ► Status Screen Tiles / Sprites
	     ║	 ▪ 4k DMA 0 ► unused
	     ║	 ▪ 8k ► Status Screen Code
	     ╚―→ ―bank 14─────────────────────────────────────────═┐
        ║	 ▪ 4k GFX 0 ► Action-Based enemy attack tiles / Sprites
	     ║	 ▪ 4k DMA 0 ► unused
	     ║	 ▪ 8k ► Action-Based Enemy Attack Subroutine
    	  ╚―→ ―bank 15─────────────────────────────────────────═┐
	     ║	 ▪ 16k ► draw_room routine, room data definitions,
        ║            multibank drawscreen subroutine
	     ╚―→ ―bank 16─────────────────────────────────────────═┐
	     ║	 ▪ 8k GFX 0/1 - shared sprites
	     ║	 ▪ 4k DMA 0 - reserved for 7800basic
        ╠═════════════════════════════════════════════════════╝
        ╚―→ ―bank 17─────────────────────────────────────────═┐
             ▪ Dungeon turn-based attack (initialize)  
             ▪  [call d_initialize_attack bank17]
        ╠═════════════════════════════════════════════════════╝
        ╚―→ ―bank 18─────────────────────────────────────────═┐
             ▪ Bank 18 Dungeon turn-based attack (loop) 
        ╠═════════════════════════════════════════════════════╝
        bank 19
             ▪ Unused
        bank 20
             ▪ Death Loop in overworld tile attack
        bank 20-31
             ▪ Unused
   ╔════╩═════════════════════════════════════════════════════════╗ 
   ║ Code Notes:                                                  ║
   ╚════╦═════════════════════════════════════════════════════════╝  
	   	╚―→ Instead of drawscreen, 
         ║      use "gosub multibankdrawscreen bank6". 
         ║      It will switch to the bank specificied by 
         ║      the "roombank" variable.
	   	╚―→ Any data for plotchars/plotmap, or any 
         ║      plotchars with inline text data must go in the
         ║      bank with the charcter graphics, or in bank 16.
         ╚═════════════════════════════════════════════════════╝ 
        I never completed the documentation in this section for banks 17-32....


                                                                                                                                 */
      set doublewide on
      set tv ntsc
      set basepath gfx_adv
      set romsize 512k
      set screenheight 224
      set plotvalueonscreen on
      set hssupport $4444
      displaymode 160B
      gamedifficulty=2


  ;╔════════════════════════════════════════════════════════════════════════════════════════════════╗ 
  ;║   Variable Assignments                                                                         ║
  ;╚════════════════════════════════════════════════════════════════════════════════════════════════╝ 
  ;┌─────────────────────────────────────────────────────────────────────────────────────────────═■ 
       dim mytemp1        = var0  :    dim mytemp2         = var1 :   dim mytemp5          = var4
       dim mytemp3        = var2  :    dim mytemp4         = var3 :   dim roombank         = t
       dim xpos           = a     :    dim ypos            = b    :   dim frame            = c
       dim herodir        = d     :    dim walkframe       = e    :   dim room             = f
       dim p0_x           = g     :    dim p0_y            = h    :   dim treex            = i
       dim treey          = j     :    dim spiderx         = k    :   dim spidery          = l
       dim char1x         = m     :    dim char1y          = n    :   dim tempx            = o
       dim tempy          = p     :    dim tempchar1       = q    :   dim tempchar2        = r
       dim temproomlo     = q     :    dim temproomhi      = r    :   dim lastroom         = s
       dim firststrike    = u
   ;┌─────────────────────────────────────────────────────────────────────────────────────────────═■ 
   ; scoreA - XP
       dim scorea=var40 
       dim XP=var40    
       dim XPHi=scorea            :    dim XPMed=scorea+1         :   dim XPLo=scorea+2 
  
   ; scoreB - Level
       dim scoreb=var46 
       dim Level=var46
       dim LevelHi=scoreb         :    dim LevelMed=scoreb+1      :   dim LevelLo=scoreb+2 

   ; score0 - Gold
       ;dim Gold=score0
       dim GoldHi=score0         :    dim GoldMed=score0+1      :   dim GoldLo=score0+2 

       dim STR=var50
       dim INT=var55
       dim VIT=var60
       dim DEX=var65 
       dim HP=var70
       dim HPMax=var80
       dim mana=var85
       dim manamax=var90

   ;┌─────────────────────────────────────────────────────────────────────────────────────────────═■
   ;│ Variable Table ($2700-$27FF)
   ;└───$2700―→$270F──Inventory Items─────────────────────────────────────────────────────────────═■
       dim shield         = $2700 :    dim magic_val       = $2701 :     dim selector3b_x   = $2702
       dim sword          = $2703 :    dim selector3_x     = $2704 :     dim selector3b_y   = $2705
       dim ring           = $2706 :    dim selector3_y     = $2707 :     dim active_enemy   = $2708
       dim armor          = $2709 :    dim select_enemy    = $270A :     dim attack_damage  = $270B
       dim key            = $270C :    dim total_enemies   = $270D :     dim attack_start   = $270E
       dim health         = $270F
   ;┌───$2710―→$271F──Enemy X/Y Positions─────────────────────────────────────────────────────────═■
       dim warrior_x      = $2710 :    dim fighter_x       = $2711 :     dim bat_y          = $2712
       dim warrior_y      = $2713 :    dim fighter_y       = $2714 :     dim minotaur_x     = $2715
       dim wizard_x       = $2716 :    dim swordfire_x     = $2717 :     dim minotaur_y     = $2718
       dim wizard_y       = $2719 :    dim swordfire_y     = $271A :     dim snake_x        = $271B
       dim knight_x       = $271C :    dim bat_x           = $271D :     dim snake_y        = $271E
       dim knight_y       = $271F
   ;┌───$2720―→$272F──Joystick-X/Y Positions-Flags────────────────────────────────────────────────═■
       dim framecounter1  = $2720 :    dim skeleton_y      = $2721 :     dim rand_encounter = $2722
       dim joyposup       = $2723 :    dim hydra_x         = $2724 :     dim attack_odds    = $2725
       dim joyposdown     = $2726 :    dim hydra_y         = $2727 :     dim hit_odds       = $2728
       dim joyposleft     = $2729 :    dim framecounter2   = $272A :     dim miss_odds      = $272B
       dim joyposright    = $272C :    dim LevelModifier   = $272D :     dim run_odds       = $272E
       dim skeleton_x     = $272F
   ;┌───$2730―→$273F───Flags/Crystal X/Y Locations────────────────────────────────────────────────═■
       dim color          = $2730 :    dim crystal2_y      = $2731 :     dim crystal5_x     = $2732
       dim debounce       = $2733 :    dim crystal3_x      = $2734 :     dim crystal5_y     = $2735
       dim debounce2      = $2736 :    dim crystal3_y      = $2737 :     dim crystal6_x     = $2738
       dim crystal1_x     = $2739 :    dim crystal4_x      = $273A :     dim crystal6_y     = $273B
       dim crystal1_y     = $273C :    dim crystal4_y      = $273D :     dim crystal7_x     = $273E
       dim crystal2_x     = $273F
   ;┌───$2740―→$274F───Crystal Flags──────────────────────────────────────────────────────────────═■
       dim crystal1_flag  = $2740 :    dim crystal7_flag   = $2741 :     dim goldvaluecheckHi  = $2742
       dim crystal2_flag  = $2743 :    dim crystal7_y      = $2744 :     dim goldvaluecheckMed = $2745
       dim crystal3_flag  = $2746 :    dim upcheck         = $2747 :     dim goldvaluecheckLo  = $2748
       dim crystal4_flag  = $2749 :    dim downcheck       = $274A :     dim tempCostMed       = $274B
       dim crystal5_flag  = $274C :    dim tempCostHi      = $274D :     dim tempCostLo        = $274E
       dim crystal6_flag  = $274F
   ;┌───$2750―→$275F──────────────────────────────────────────────────────────────────────────────═■
       dim attacksequence = $2750 :    dim joyrightdebounce= $2751 :     dim item_menu      = $2752
       dim selector_x     = $2753 :    dim selector2_x     = $2754 :     dim run_menu       = $2755
       dim selector_y     = $2756 :    dim selector2_y     = $2757 :     dim rightside      = $2758
       dim joyupdebounce  = $2759 :    dim fight_menu      = $275A :     dim leftside       = $275B
       dim joydowndebounce= $275C :    dim parry_menu      = $275D :     dim attackturn     = $275E
       dim joyleftdebounce= $275F
   ;┌───$2760―→$276F───Enemy X/Y Locations────────────────────────────────────────────────────────═■
       dim enemy1_x       = $2760 :    dim enemy4_x        = $2761 :     dim enemy6_y       = $2762
       dim enemy1_y       = $2763 :    dim enemy4_y        = $2764 :     dim enemy7_x       = $2765
       dim enemy2_x       = $2766 :    dim enemy5_x        = $2767 :     dim enemy7_y       = $2768
       dim enemy2_y       = $2769 :    dim enemy5_y        = $276A :     dim enemy8_x       = $276B
       dim enemy3_x       = $276C :    dim enemy6_x        = $276D :     dim enemy8_y       = $276E
       dim enemy3_y       = $276F
   ;┌───$2770―→$277F──────────────────────────────────────────────────────────────────────────────═■
       dim death_flag     = $2770 :    dim enemy5_HP      = $2771 :     dim frame1          = $2772
       dim unused2        = $2773 :    dim enemy6_HP      = $2774 :     dim frame2          = $2775
       dim enemy1_HP      = $2776 :    dim enemy7_HP      = $2777 :     dim frame3          = $2778
       dim enemy2_HP      = $2779 :    dim enemy8_HP      = $277A :     dim frame4          = $277B
       dim enemy3_HP      = $277C :    dim unused4        = $277D :     dim frame5          = $277E
       dim enemy4_HP      = $277F
   ;┌───$2780―→$278F──────────────────────────────────────────────────────────────────────────────═■
       dim enemy1_hit     = $2780 :    dim enemy7_hit      = $2781 :     dim temp_attack3   = $2782
       dim enemy2_hit     = $2783 :    dim enemy8_hit      = $2784 :     dim frame6         = $2785
       dim enemy3_hit     = $2786 :    dim unused3         = $2787 :     dim frame7         = $2788
       dim enemy4_hit     = $2789 :    dim temp_attack1    = $278A :     dim frame8         = $278B
       dim enemy5_hit     = $278C :    dim temp_attack2    = $278D :     dim low_damage     = $278E
       dim enemy6_hit     = $278F
   ;┌───$2790―→$279F──────────────────────────────────────────────────────────────────────────────═■
       dim temp1_HP       = $2790 :    dim temp7_HP        = $2791 :     dim parry_result   = $2792
       dim temp2_HP       = $2793 :    dim temp8_HP        = $2794 :     dim run_result     = $2795
       dim temp3_HP       = $2796 :    dim attack_active   = $2797 :     dim end_battle     = $2798
       dim temp4_HP       = $2799 :    dim high_damage     = $279A :     dim rand_encounter2= $279B
       dim temp5_HP       = $279C :    dim mid_damage      = $279D :     dim check_gold     = $279E
       dim temp6_HP       = $279F
   ;┌───$27A0―→$27AF──────────────────────────────────────────────────────────────────────────────═■
       dim gold_found     = $27A0 :    dim enemy_HP        = $27A1 :     dim count1         = $27A2
       dim XP_Check       = $27A3 :    dim hero_x          = $27A4 :     dim count2         = $27A5
       dim XP_GainLo      = $27A6 :    dim hero_y          = $27A7 :     dim count3         = $27A8
       dim XP_GainMed     = $27A9 :    dim correctit10     = $27AA :     dim count4         = $27AB
       dim XP_GainHi      = $27AC :    dim correctit13     = $27AD :     dim status_menu    = $27AE
       dim status_active  = $27AF
   ;┌───$27B0―→$27BF───Item Prices────────────────────────────────────────────────────────────────═■
       dim hpotion_cost_Lo= $27B0 :    dim shield_cost_Lo  = $27B1 :     dim key_cost_Med    = $27B2
       dim mpotion_cost_Lo= $27B3 :    dim hpotion_cost_Med= $27B4 :     dim shield_cost_Med = $27B5
       dim ring_cost_Lo   = $27B6 :    dim ring_cost_Med   = $27B7 :     dim mpotion_cost_Med= $27B8
       dim sword_cost_Lo  = $27B9 :    dim sword_cost_Med  = $27BA :     dim rightcheck      = $27BB
       dim armor_cost_Lo  = $27BC :    dim armor_cost_Med  = $27BD :     dim leftcheck       = $27BE
       dim key_cost_Lo    = $27BF
   ;┌───$27C0―→$27CF───Item Quantity──────────────────────────────────────────────────────────────═■
       dim hpotion_val    = $27C0 :    dim ugutz           = $27C1 :     dim titleselect_x = $27C2
       dim ring_val       = $27C3 :    dim rope_val        = $27C4 :     dim titleselect_y = $27C5
       dim sword_val      = $27C6 :    dim mpotion_val     = $27C7 :     dim titleypos     = $27C8
       dim armor_val      = $27C9 :    dim derame          = $27CA :     dim titlexpos     = $27CB
       dim key_val        = $27CC :    dim sephmond        = $27CD :     dim devmode       = $27CE
       dim shield_val     = $27CF
   ;┌───$27D0―→$27DF────Gold──────────────────────────────────────────────────────────────────────═■
       dim gold1_x        = $27D0 :    dim gold3_x         = $27D1 :     dim range_right   = $27D2
       dim gold1_y        = $27D3 :    dim gold3_y         = $27D4 :     dim range_left    = $27D5
       dim gold2_x        = $27D6 :    dim gold3_flag      = $27D7 :     dim range_up      = $27D8
       dim gold2_y        = $27D9 :    dim mapicon_x       = $27DA :     dim range_down    = $27DB
       dim gold1_flag     = $27DC :    dim mapicon_y       = $27DD :     dim market_x      = $27DE
       dim gold2_flag     = $27DF
   ;┌───$27E0―→$27EF────Item Location─────────────────────────────────────────────────────────────═■
       dim potion_x       = $27E0 :    dim armor_x         = $27E1 :     dim shield_y      = $27E2
       dim potion_y       = $27E3 :    dim armor_y         = $27E4 :     dim attacktimer   = $27E5
       dim ring_x         = $27E6 :    dim key_x           = $27E7 :     dim statusmenu_x  = $27E8
       dim ring_y         = $27E9 :    dim key_y           = $27EA :     dim statusmenu_y  = $27EB
       dim sword_x        = $27EC :    dim shield_x        = $27ED :     dim market_y      = $27EE
       dim sword_y        = $27EF
   ;┌───$27F0―→$27FF──Enemy Death Flags───────────────────────────────────────────────────────────═■
       dim snake_flag     = $27F0 :    dim knight_flag     = $27F1 :     dim sword_flag    = $27F2
       dim wizard_flag    = $27F3 :    dim minotaur_flag   = $27F4 :     dim armor_flag    = $27F5
       dim warrior_flag   = $27F6 :    dim fighter_flag    = $27F7 :     dim key_flag      = $27F8
       dim hydra_flag     = $27F9 :    dim potion_flag     = $27FA :     dim shield_flag   = $27FB
       dim skeleton_flag  = $27FC :    dim ring_flag       = $27FD :     dim rodoflife     = $27FE
       dim bat_flag       = $27FF
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭─═◙ Assign Screen RAM ◙═────────────────────────────────────────────────────────────────────═■
       dim screenram = $2200 ;to $24EF (20*12=240 bytes) - $24F0 to $27FF are free
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Palette Colors ◙═──────────────────────────────────────────────────────────────────────═■
   ;   Background :  Water     :  Icons     :  Blue      :  Dungeons  :  Forest/Bar:  White/Grey
       P1C1=$F1   :  P2C1=$80  :  P3C1=$1C  :  P4C1=$90  :  P5C1=$42  :  P6C1=$C6  :  P7C1=$E0
       P1C2=$F3   :  P2C2=$86  :  P3C2=$34  :  P4C2=$98  :  P5C2=$46  :  P6C2=$C4  :  P7C2=$08
       P1C3=$C0   :  P2C3=$F2  :  P3C3=$3A  :  P4C3=$0F  :  P5C3=$FF  :  P6C3=$F2  :  P7C3=$04
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Player Colors ◙═───────────────────────────────────────────────────────────────────────═■
       P0C1=$01
       P0C2=$80
       P0C3=$2B
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Initialize Variables ◙═────────────────────────────────────────────────────────────────═■
       debounce=0:debounce2=0:devmode=0:ugutz=0:sephmond=0:derame=0:health=8
   ; ──═◙ Initial Item Locations ◙═─────────────────────────────────────────────────────────────────
       potion_x=145 : sword_x=145 : armor_x = 145 : shield_x=145 : ring_x=145: key_x=145
       potion_y=150 : sword_y=150 : armor_y = 150 : shield_y=150 : ring_y=150: key_y=150
      ; statusmenu_x=35:statusmenu_y=116
   ; ──═◙ Enemy Movement Flags ◙═───────────────────────────────────────────────────────────────────
       warrior_flag=0 : wizard_flag=0   : fighter_flag=0 : knight_flag=0
       snake_flag=0   : minotaur_flag=0 : hydra_flag=0   : skeleton_flag=0
       potion_flag=0  : sword_flag=0    : armor_flag = 0 : shield_flag=0  : ring_flag=0 : key_flag=0
   ; ──═◙ Crystal Flags ◙═──────────────────────────────────────────────────────────────────────────
       crystal1_flag=0 : crystal2_flag=0 : crystal3_flag=0 : crystal4_flag=0 
       crystal5_flag=0 : crystal6_flag=0 : crystal7_flag=0
   ; ──═◙ Crystal X/Y Locations ◙═──────────────────────────────────────────────────────────────────
       ;  West Mountain Dungeon  - Room 195 
       ;  Hidden Lake Dungeon    - Room 208 
       ;  High Mountain Dungeon  - Room 248 
       ;  North Desert Dungeon   - Room 200 
       ;  East Mountain Dungeon  - Room 205 
       ;  South Mountain Dungeon - Room 207
       crystal1_x=100 : crystal2_x=20  : crystal3_x=132 : crystal4_x=36 
       crystal5_x=132 : crystal6_x=132 : crystal7_x=76
       crystal1_y=68  : crystal2_y=164 : crystal3_y=20  : crystal4_y=44 
       crystal5_y=20  : crystal6_y=164 : crystal7_y=84
   ; ──═◙ Status Bar Item Quantities ◙═─────────────────────────────────────────────────────────────
       shield=1 : sword=1 : armor=1 : key=0 : health = 8 : mana = 8: rodoflife =0
   ; ──═◙ Item Quantities ◙═────────────────────────────────────────────────────────────────────────
       shield_val=$01  : armor_val  =$01 : ring_val   =$01 : key_val =$01 
       sword_val =$01  : hpotion_val=$08 : mpotion_val=$08 : rope_val=$00 : magic_val=$01
   ; ──═◙ Initial Player Attributes ◙═──────────────────────────────────────────────────────────────
       STR=$08     ; Strength
       DEX=$09     ; Dexterity
       VIT=$08     ; Vitality
       INT=$12     ; Intelligence
       Level=$01   ; Level
       XP=$00      ; Experience Points (XP)
       HP=$25      ; Starting HP
       HPMax=$25   ; Starting HP limit
       mana=$25    ; Starting Mana
       manamax=$25 ; Starting Mana Limit
   ; ──═◙ Seed Randomizer ◙═────────────────────────────────────────────────────────────────────────
       rand_encounter=15
   ; ──═◙ Gold ◙═───────────────────────────────────────────────────────────────────────────────────
       GoldHi=$00:GoldMed=$01:GoldLo=$90
       ;score0=0
   ;╰──────────────────────────────────────────────────────────────────────────────────────────────╯
 
   ;╭──═◙ Start Locations ◙═──────────────────────────────────────────────────────────────────────═■
   ;                 ◙═─Player Start Location─═◙     :     ■◙═── Room Start ──═◙■      ;137 start
                              xpos=28                :            room=137
                              ypos=26                :          lastroom=137
   ;                 ◙═───────────────────────═◙     :     ■◙═────────────────═◙■
   ;╰──────────────────────────────────────────────────────────────────────────────────────────────╯

   goto tempskip

   ;╭──═◙ Set Room Bank/Characterset ◙═────────────────────────────────────────────────────────────═■
      if room<64              then characterset tileset_1:roombank=6:goto RoomBankSet   
      if room>63  && room<128 then characterset tileset_1:roombank=6:goto RoomBankSet               
      if room>127 && room<192 then characterset tileset_5:roombank=7:goto RoomBankSet               
      if room>191             then characterset tileset_5:roombank=8:goto RoomBankSet  
RoomBankSet  
     gosub draw_room bank15
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

tempskip
       titlexpos=72 :  titleypos=164
       gosub titleloop bank11

   ; «◘■■▄■▀▀■▄▄■▀▀■▄▄■▀▀■▄■► Begin Main Loop ◄■▄■▀▀■▄▄■▀▀■▄▄■▀▀■▄■■◘»

mainloop

  ; DEBUG - Jump directly to enemy attacks (for testing)
  ; gosub turnattackloop bank9
  ; gosub attackloop bank14
  ; gosub death_turnattackloop bank20

  ;╭──═◙ Misc ◙═──────────────────────────────────────────────────────────────────────────────────═■
       gosub multibankdrawscreen bank15                   ; Jumps to Drawscreen Subroutine
       BACKGRND=$00                                       ; Background Color Value
       walkframe=walkframe+1                              ; Walkframe Frame Counter
       framecounter1=framecounter1+1 
       if framecounter1>9 then framecounter1=0
       framecounter2=framecounter2+1 
       if framecounter2>5 then framecounter2=0:rand_encounter=(rand&127)
       restorescreen                                      ; Restore saved screen
       ;if joy1any then devmode=1 ; in mame/mess, press R
  ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

  ;╭──═◙ Random Attack ◙═─────────────────────────────────────────────────────────────────────────═■
   ;goto skipattack ; DEBUG - Uncomment to disable enemy attacks.  Action-based attack is "attackloop bank14"
     if rand_encounter<>15 then goto skipattack
        if room>19 && room<27  then gosub turnattackloop bank9
        if room>35 && room<43  then gosub turnattackloop bank9
        if room>51 && room<75  then gosub turnattackloop bank9
        if room>83 && room<90  then gosub turnattackloop bank9
        if room>99 && room<106 then gosub turnattackloop bank9
       ; *West Mountain Attack
        if room>16 && room<20  then gosub turnattackloop bank9
        if room>31 && room<36  then gosub turnattackloop bank9
        if room>47 && room<52  then gosub turnattackloop bank9
        if room>63 && room<68  then gosub turnattackloop bank9
        if room>79 && room<84  then gosub turnattackloop bank9
        if room>95 && room<100 then gosub turnattackloop bank9
       ; *North Forest Attack (Top Row of Map)
        if room>0 && room<10   then gosub turnattackloop bank9  ; removed 10-13 turn based attack for skeleton attack
        if room>9 && room<14   then gosub attackloop bank14     ; Action-based skeleton attack
       ; *Central Forest Attack
        if room>25 && room<30  then gosub attackloop bank14     ; Action-based skeleton attack
        if room>41 && room<46  then gosub attackloop bank14     ; Action-based skeleton attack
        if room>57 && room<62  then gosub attackloop bank14     ; Action-based skeleton attack
        if room>73 && room<78  then gosub turnattackloop bank9
       ; *Wetlands Attack
        if room>89 && room<94   then gosub turnattackloop bank9
        if room>105 && room<110 then gosub turnattackloop bank9
        if room>121 && room<126 then gosub turnattackloop bank9 ; Room 128 is a crystal room, no attacks there!
       ; *West Mountains Attack
        if room=30 || room=31   then gosub turnattackloop bank9
        if room=46 || room=126  then gosub turnattackloop bank9 ; no attack in entrance rooms (& 14)
        if room=62 || room=63   then gosub turnattackloop bank9
        if room=78 || room=79   then gosub turnattackloop bank9
        if room=94 || room=95   then gosub turnattackloop bank9
        if room=110 || room=111 then gosub turnattackloop bank9
       ; *Dungeon & Boss attacks
        ; When Boss attack loop is ready, the "skipattack" will change to a gosub to the boss attack subroutine.
        ;  ^Also note that it won't be radom, it'll be a one-and-done, so the next three lines will be moved below the skipattack loop.
        ;  ^Also note that there will be a separte dungeon attack loop to change the background graphics and maybe the monsters too.  For now there's only one (12c).
        if room=195 || room=208 then skipattack ; No turn based attacks in crystal rooms, but yes in every other dungeon room.
        if room=248 || room=200 then skipattack ; No turn based attacks in crystal rooms, but yes in every other dungeon room.
        if room=205 || room=207 then skipattack ; No turn based attacks in crystal rooms, but yes in every other dungeon room.
        if room>191 && room<255 then gosub d_turnattackloop bank18
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
skipattack

   ;╭──═◙ Animation Frame Check & Player Movement ◙═───────────────────────────────────────────────═■
     walkframe=walkframe+1                               ; Walkframe Frame Counter
     p0_x=0:p0_y=0                                       ; Reset X/Y Values to 0 
      if joy0down  then gosub checkmovedown :herodir=0:goto doneherowalk
      if joy0up    then gosub checkmoveup   :herodir=2:goto doneherowalk
      if joy0left  then gosub checkmoveleft :herodir=1:goto doneherowalk
      if joy0right then gosub checkmoveright:herodir=3:goto doneherowalk
     walkframe=walkframe-1                               ; We didn't move
doneherowalk
     xpos=xpos+p0_x
     ypos=ypos+p0_y
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Calculate which Player animation frame to display ◙═──────────────────────────────────────═■
      temp1=(herodir*3)+((walkframe/16)&1)
      if joy0any then plotsprite herodown1 0 xpos ypos temp1
      if !joy0any && herodir=0 then plotsprite herodown2  0 xpos ypos    ; Standing still sprite Down
      if !joy0any && herodir=2 then plotsprite heroup2    0 xpos ypos    ; Standing still sprite Up
      if !joy0any && herodir=1 then plotsprite heroleft2  0 xpos ypos    ; Standing still sprite Left
      if !joy0any && herodir=3 then plotsprite heroright2 0 xpos ypos    ; Standing still sprite Right
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Change rooms & background defintions ◙═──────────────────────────────────────────────────═■
      if ypos<2   then gosub go_north bank15
      if xpos>157 then gosub go_east  bank15
      if ypos>177 then gosub go_south bank15
      if xpos<1   then gosub go_west  bank15
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
  
   ;╭──═◙ Enter/Exit Alternate Areas ◙═──────────────────────────────────────────────────────────────────────────────────────────────────═■
   ;  Enter and Exit between the Overworld and Dungeons, Towns, Houses, etc.
   ; ──═◙ Enter && return from Dungeons ◙═────────────────────────────────────────────────────────────────────────────────────────────────
      ; Dungeons - 192, 252, 250, 244, 249, 240 
      ; *1 Glory   Katkovik		          West Mountain		
      ; *2 Loyalty Faulkton		          Hidden (Lake)		
      ; *3 Wrath   Nonnag    	          High Mountain		
      ; *4 Wisdom  Hagan		          North Desert  		
      ; *5 Trust   Renick		          East Mountain		
      ; *6 Courage Ravensworth Keep	      South Mountain		
      ; *7 Virtue  Moutain Grove Forest   Secret Forest Room   		
      ; 
      ; Crystals in Order of Discovery
      ; Glory   1 Katkovik
      ; Courage 6 Ravensworth Keep
      ; Virtue  7 Moutain Grove Forest
      ; Wisdom  4 Hagan
      ; Trust   5 Renick
      ; Loyalty 2 Faulkton
      ; Wrath   3 Nonnag  

    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ;●══► Kaktovik | West Mountain Dungeon      ▬Room 0▬    [0  ―→ 192]     Holds the Crystal of Glory(1), only requires a key for entry 
    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
        if ugutz=1 then grantaccess1 ; If you've already visited Ugutz and got a key once, you can enter the dungeon again without a key.
        ; The line below checks to make sure you have a key in your inventory, if not you get an access denied message.
        if room=0 && key<1 && xpos<58 && ypos<32 then ypos=50:clearscreen:gosub town1 bank12 goto skiproom0 ; Display "Access Denied" message
grantaccess1
          if room=0   && xpos<58 && ypos<32 then room=192:roombank=8:xpos=134:ypos=155:key=0:clearscreen:gosub draw_room bank15   
          if room=192 && ypos>170 then room=0:roombank=8:xpos=48:ypos=48:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15 
skiproom0                
    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ;●══► Ravensworth | South Mountain Dungeon  ▬Room 127▬  [127―→ 252]     Holds the Crystal of Courage(6), entry requires key and crystal of Glory (crystal1_flag)
    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
        if derame=1 then grantaccess2 ; If you've already visited King Karles Derame in Bledknot and got a key once, you can enter the dungeon again without a key.
        if room=127 && key<1 && xpos<23 && ypos<144 then ypos=148:clearscreen:gosub town1 bank12 goto skiproom127 ; Display "Access Denied" message
grantaccess2
          if room=127 && xpos<23 && ypos<144 then room=252:roombank=8:xpos=134:ypos=155:key=0:clearscreen:gosub draw_room bank15  
          if room=252 && ypos>170 then room=127:roombank=8:xpos=18:ypos=146:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
skiproom127    
    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ;●══► Hagan | North Desert Dungeon          ▬Room 55▬   [55 ―→ 249]     Holds the Crystal of Wisdom(4), entry requires key and crystal of Virtue (crystal7_flag)
    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
        if sephmond=1 then grantaccess3 ; If you've already visited Werd Sephmond and got a key once, you can enter the dungeon again without a key
        if room=55 && key<1 && xpos>68 && xpos<88 && ypos>86 && ypos<112 then ypos=114:clearscreen:gosub town1 bank12 goto skiproom55; Display "Access Denied" message
grantaccess3
          if room=55  && xpos>68 && xpos<88 && ypos>86 && ypos<112 then key=0:room=249:roombank=8:xpos=134:ypos=155:clearscreen:gosub draw_room bank15    
          if room=249 && ypos>170 then room=55:roombank=8:xpos=74:ypos=112:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15   
skiproom55
    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ;●══► Renick | East Mountain Dungeon        ▬Room 15▬   [15 ―→ 250]     Holds the Crystal of Trust(5)
    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
        if crystal4_flag=1 then grantaccess4 
        if room=15 && key<1 && ypos<32 then ypos=36:clearscreen:gosub town1 bank12 goto skiproom15; Display "Access Denied" message
grantaccess4
          if room=15  && ypos<32  then room=250:roombank=8:xpos=134:ypos=155:key=0:clearscreen:gosub draw_room bank15               
          if room=250 && ypos>170 then room=15:roombank=8:xpos=68:ypos=32:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
skiproom15    
    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ;●══► Chetfast | Hidden Lake Dungeon        ▬Room 113▬   [113―→ 240]    Holds the Crystal of Loyalty(2)
    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
        if crystal5_flag=1 then grantaccess5
        if room=113 && key<1 && xpos>100 && xpos<120 && ypos>118 && ypos<130 then ypos=135:clearscreen:gosub town1 bank12 goto skiproom15; Display "Access Denied" message
grantaccess5
          if room=113 && xpos>100 && xpos<120 && ypos>118 && ypos<130 then room=240:roombank=8:xpos=134:ypos=155:key=0:clearscreen:gosub draw_room bank15    
          if room=240 && ypos>170 then room=113:roombank=8:xpos=110:ypos=133:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
skiproom113
    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ;●══► Silverpeak | High Mountain Dungeon    ▬Room 50▬   [50 ―→ 244]     Holds the Crystal of Wrath(3)
    ;───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
        if crystal2_flag=1 then grantaccess6
        if room=50 && key<1 && ypos<32 then ypos=34:clearscreen:gosub town1 bank12 goto skiproom15; Display "Access Denied" message
grantaccess6
          if room=50  && ypos<32  then room=244:roombank=8:xpos=134:ypos=155:key=0:clearscreen:gosub draw_room bank15               
          if room=244 && ypos>170 then room=50:roombank=8:xpos=68:ypos=32:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
skiproom50  

   ; ──═◙ Enter and return from Buildings ◙═──────────────────────────────────────────────────────────────────────────────────────────────────   
      ;●══► Mashham | River Valley Marketplace    ▬Room 108▬     [108―→ 191]
        if room=108 && xpos>68 && xpos<88 && ypos>54 && ypos<80 then room=191:roombank=8:xpos=134:ypos=155:clearscreen:gosub draw_room bank15    
        if room=191 && ypos>170 then room=108:roombank=8:xpos=76:ypos=84:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
      ;●══► Werd | Chetfast Lake House            ▬Room 112▬     [112―→ 175]
        if room=112 && ypos<57  then room=175:roombank=8:xpos=134:ypos=155:clearscreen:gosub draw_room bank15    
        if room=175 && ypos>170 then room=112:roombank=8:xpos=36:ypos=59:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
      ;●══► Bledknot | Desert Castle              ▬Room 102▬     [102―→ 190]
        if room=102 && xpos>100 && xpos<120 && ypos>86 && ypos<98 then room=190:roombank=8:xpos=134:ypos=155:clearscreen:gosub draw_room bank15    
        if room=190 && ypos>170 then room=102:roombank=8:xpos=108:ypos=100:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
      ;●══► Welbeck | Forest Castle               ▬Room 60▬      [60 ―→ 181]
        if room=60 && xpos>84 && xpos<104 && ypos>54 && ypos<76 then room=181:roombank=8:xpos=84:ypos=145:clearscreen:gosub draw_room bank15    
        if room=181 && ypos>170 then room=60:roombank=8:xpos=92:ypos=78:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
      ;●══► Stratford | North Forest Marketplace  ▬Room 26▬      [26 ―→ 159]
        if room=26 && xpos>68 && xpos<88 && ypos>54 && ypos<80 then room=159:roombank=8:xpos=134:ypos=155:clearscreen:gosub draw_room bank15    
        if room=159 && ypos>170 then room=26:roombank=8:xpos=76:ypos=84:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
      ;●══► Beckwourth | South Desert Town         ▬Room 85▬     [85 ―→ 178]
        if room=85 && xpos>60 && xpos<80 && ypos>54 && ypos<76 then room=178:roombank=8:xpos=84:ypos=145:clearscreen:gosub draw_room bank15    
        if room=178 && ypos>170 then room=85:roombank=8:xpos=68:ypos=78:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
      ;●══► Tattershall | East Mountain Town        ▬Room 47▬    [47 ―→ 186]
        if room=47 && ypos>86 && ypos<106 then room=186:roombank=8:xpos=84:ypos=145:clearscreen:gosub draw_room bank15    
        if room=186 && ypos>170 then room=47:roombank=8:xpos=68:ypos=108:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
      ;●══► Treestoke | Mountain Marketplace        ▬Room 82▬    [82 ―→ 143]
        if room=82 && xpos>68 && xpos<88 && ypos>54 && ypos<80 then room=143:roombank=8:xpos=134:ypos=155:clearscreen:gosub draw_room bank15    
        if room=143 && ypos>170 then room=82:roombank=8:xpos=76:ypos=84:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
      ;●══► Mountain Grove | North Forest House      ▬Room 6▬    [6  ―→ 143]
        if room=6 && xpos>68 && xpos<84 && ypos>38 && ypos<56 then room=137:roombank=8:xpos=134:ypos=155:clearscreen:gosub draw_room bank15    
        if room=137 && ypos>170 then room=6:roombank=8:xpos=76:ypos=84:clearscreen:P6C1=$C6:P6C2=$C4:P6C3=$F2:gosub draw_room bank15  
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Debounce Right Fire / Switch to Status Screen ◙═──────────────────────────────────────────────────────═■
      if joy0fire0 then debounce=5
      if !joy0fire0 && debounce=5 then debounce=3
      if debounce=3 then debounce=0 :clearscreen:gosub statusscreen bank13
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Debounce Left Fire ◙═──────────────────────────────────────────────────────────────────────────────────═■
      if joy0fire1 then debounce2=5
      if !joy0fire1 && debounce2=5 then debounce2=3
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Plot Graphics ◙═─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────═■
   ; ──═◙ Plot Castles/Houses ◙═───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      ; These areas will always be open, not blocked like the Dungeons.                                            ^Name                        ^Primary Character
      if room>127 then goto skipplot1 ; skip statements to plot outdoor items when youre not in the overworld.
      if room=60  then plotsprite sprite_castle 7 88 71                  ; *Forest Castle            [60 ―→ 181]   Castle Welbeck               King Riswil Thoswith
      if room=112 then plotsprite sprite_largehouse 4 32 53              ; *Lake House               [112―→ 175]   Lake Chetfast House          Werd Sephmond
      if room=102 then plotsprite sprite_castle 4 104 91                 ; *Desert Castle            [102―→ 190]   Castle Bledknot              King Karles Derame
      if room=108 then plotsprite sprite_marketplace 4 72 71             ; *River Valley Marketplace [108―→ 191]   Masham Marketplace           Fallard Huesten 
      if room=26  then plotsprite sprite_marketplace 4 72 71             ; *North Forest Marketplace [26 ―→ 159]   Stratford Marketplace        Terillos Leptio 
      if room=85  then plotsprite sprite_town 4 64 66                    ; *South Desert Town        [85 ―→ 178]   City of Beckwourth           Ugutz Rouestoff
      if room=47  then plotsprite sprite_town 4 68 98                    ; *East Mountain Town       [47 ―→ 186]   City of Tattershall          Grimold Drexel
      if room=82  then plotsprite sprite_marketplace 1 72 71             ; *Mountain Marketplace     [82 ―→ 143]   Treestoke Marketplace        Nasdun Forthead
      if room=6   then plotsprite sprite_house 6 72 41                   ; *North Forest House       [6  ―→ 143]   Mountain Grove               Azémar Rehn (player) 
skipplot1
   ; ──═◙ Status Bar ◙═────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      plotvalue tileset_attack2 3 HP    2 19 12  :  plotvalue tileset_attack2 3 HPMax   2 39 12
      plotvalue tileset_attack2 3 mana   2 19 13  :  plotvalue tileset_attack2 3 manamax 2 39 13
      plotvalue tileset_attack2 3 score0 6 106 12
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Plot Town Graphics ◙═──────────────────────────────────────────────────────────────────────────────────═■
      if room<128 || room>191 then goto skiptownstuff1
   ; ──═◙ Entrance Guards ◙═─────────────────────────────────────────────────────────────────────────────────────
      if room=181 || room=178 then plotsprite sprite_fighter1b 7 92 51
      if room=190 then plotsprite sprite_warrior1b 4 92 51
   ; ──═◙ Plot NPCs ◙═───────────────────────────────────────────────────────────────────────────────────────────
      ;  Room 108>191	River Valley Marketplace	   
      ;  Room 26>159	North Forest Marketplace       
      ;  Room 82>143    West Mountain Marketplace 
      if room=140  then plotsprite sprite_shopkeeper 5 134 128             ; Grimold 
      if room=132  then plotsprite sprite_man3 2 90  50   
      if room=144  then plotsprite sprite_man3 1 74  126 
      if room=175  then plotsprite sprite_shopkeeper 4 22 17               ; Werd Sephmond in Lake Chetfast House
      if room=147  then plotsprite sprite_shopkeeper 4 76 66               ; Ugutz Roestoff in Beckwourth     
      if room=150  then plotsprite sprite_shopkeeper 4 104 111             ; Castle Welbeck Wanderer           
      if room=191  || room=159 then plotsprite sprite_shopkeeper 5 70 32   ; Marketplace shopkeepers
      if room=143  || room=161 then plotsprite sprite_shopkeeper 5 70 32   ; Marketplace shopkeepers
      if room=158  then plotsprite sprite_king 5 74 32                     ; Castle Bledknot (Desert) King Karles Derame
      if room=183  then plotsprite sprite_king 5 71 23                     ; Castle Welbeck (Forest) King Riswil Thoswith
      if room=137  then plotsprite icon_letter 7 46 129                    ; Letter on the Table Mountain Grove
      if room=186  then plotsprite icon_letter 7 42 30                     ; Letter on Tattershall Sign
      if room=178  then plotsprite icon_letter 7 42 30                     ; Letter on Beckwourth Sign
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
skiptownstuff1

   ;╭──═◙ Display Town Signs & Messages ◙═───────────────────────────────────────────────────────────────────────═■
      if room<127 || room>191 then goto skipmessages1 ; Messages only displayed in Town Graphic Block
      if debounce2=3 && room=178 then debounce2=0: clearscreen: gosub town1 bank12             ; City of Beckwourth
      if debounce2=3 && room=181 then debounce2=0: clearscreen: gosub town1 bank12             ; Castle Welbeck
      if debounce2=3 && room=158 && ypos<46 then debounce2=0: clearscreen: gosub town1 bank12  ; King Karles Derame in Castle Bledknot (Desert)
      if debounce2=3 && room=186 then debounce2=0: clearscreen: gosub town1 bank12             ; City of Tattershall
      if debounce2=3 && room=190 then debounce2=0: clearscreen: gosub town1 bank12             ; Castle Bledknot Guard
      if debounce2=3 && room=150 then debounce2=0: clearscreen: gosub town1 bank12             ; Wanderer
      if debounce2=3 && room=147 then debounce2=0: clearscreen: gosub town1 bank12             ; Ugutz Roestoff in Beckwourth 
      if debounce2=3 && room=137 && xpos<50 && xpos>38 && ypos>110 && ypos<120 then debounce2=0: clearscreen: gosub town1 bank12 ; Mountain Grove Letter
      if debounce2=3 && room=140 && xpos>90 && ypos>78 then debounce2=0:key=1:clearscreen: gosub town1 bank12 ; Grimold 
      if debounce2=3 && room=183 && xpos<90 then debounce2=0: clearscreen: gosub town1 bank12  ; King in Welbeck
      if debounce2=3 && room=191 then debounce2=0: clearscreen: gosub beginmarketplace bank10  ; Marketplace
      if debounce2=3 && room=159 then debounce2=0: clearscreen: gosub beginmarketplace bank10  ; Marketplace
      if debounce2=3 && room=143 then debounce2=0: clearscreen: gosub beginmarketplace bank10  ; Marketplace
      if debounce2=3 && room=161 then debounce2=0: clearscreen: gosub beginmarketplace bank10  ; Town Marketplace
      if debounce2=3 && room=175 then debounce2=0: clearscreen: gosub town1 bank12             ; Werd Sephmond at Lake Chetfast House
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
skipmessages1

   ;╭──═◙ Place Crystals in Dungeons ◙═─────────────────────────────────────────────────────────────────────────────────────────═■
      if crystal1_flag=0 && room=195 then plotsprite icon_crystal 1 crystal1_x crystal1_y; *Crystal of Glory in Katkovik Dungeon
      if crystal2_flag=0 && room=208 then plotsprite icon_crystal 2 crystal2_x crystal2_y; *Crystal of Loyalty in Hidden Area (Lake)
      if crystal3_flag=0 && room=248 then plotsprite icon_crystal 3 crystal3_x crystal3_y; *Crystal of Wrath in Silverpeak
      if crystal4_flag=0 && room=200 then plotsprite icon_crystal 4 crystal4_x crystal4_y; *Crystal of Wisdom in Cavern of Hagan
      if crystal5_flag=0 && room=205 then plotsprite icon_crystal 5 crystal5_x crystal5_y; *Crystal of Trust in Vault of Renick
      if crystal6_flag=0 && room=207 then plotsprite icon_crystal 6 crystal6_x crystal6_y; *Crystal of Courage in Ravensworth Keep
      if crystal7_flag=0 && room=128 then plotsprite icon_crystal 7 crystal7_x crystal7_y; *Crystal of Virtue in Secret Forest Room
   ;╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
   ;╭──═◙ Pick up Crystals and Place in Inventory ◙═─────────────────────────────────────────────────────────────────Crystal X/Y─═■
    if room=195 && xpos>90 && xpos<106 && ypos<70 && ypos>66  then crystal1_flag=1; Crystal 1 - West Mountain       [ x100 y68  ]
     if room=195 && xpos>90 && xpos<106 && ypos<70 && ypos>66 then ypos=ypos+8:clearscreen:gosub town1 bank12
    if room=208 && xpos<24 && ypos>152                        then crystal2_flag=1; Crystal 2 - Unassigned/Last     [ x20  y164 ]
     if room=208 && xpos<24 && ypos>152                       then ypos=ypos-8:xpos=xpos+8:clearscreen:gosub town1 bank12
    if room=248 && xpos>130 && ypos<21                        then crystal3_flag=1; Crystal 3 - High Mountain       [ x132 y20  ]
     if room=248 && xpos>130 && ypos<21                       then ypos=ypos+8:xpos=xpos-8:clearscreen:gosub town1 bank12
    if room=200 && xpos>30 && xpos<46 && ypos<46 && ypos>32   then crystal4_flag=1; Crystal 4 - North Desert        [ x36  y44  ]
     if room=200 && xpos>30 && xpos<46 && ypos<46 && ypos>32  then ypos=ypos+8:xpos=xpos+8:clearscreen:gosub town1 bank12
    if room=205 && xpos>130 && ypos<21                        then crystal5_flag=1; Crystal 5 - East Mountain       [ x132 y20  ]
     if room=205 && xpos>130 && ypos<21                       then ypos=ypos+8:xpos=xpos-8:clearscreen:gosub town1 bank12
    if room=207 && xpos>129 && ypos>152                       then crystal6_flag=1; Crystal 6 - South Mountain      [ x132 y164 ]
     if room=207 && xpos>129 && ypos>152                      then ypos=ypos-8:xpos=xpos-8:clearscreen:gosub town1 bank12
    if room=128 && ypos<84                                    then crystal7_flag=1; Crystal 7 - Secret Forest Room  [ x76  y84  ]
     if room=128 && ypos<84                                   then ypos=ypos+8:clearscreen:gosub town1 bank12
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Eyes of the Dungeon ◙═──────────────────────────────────────────────────────────────────────────────────────────────────═■
   ;  Cosmetic - adds eyes and teeth to dungeon entrances.  Can be removed later if other issues arise.
   ; if room=0   then plotsprite eyes 5 51 18                 ; Kaktovik    | West Mountain Dungeon
   ; if room=127 then plotsprite eyes 5 19 130                ; Ravensworth | South Mountain Dungeon
   ; if room=15  then plotsprite eyes 5 67 18                 ; Renick      | East Mountain Dungeon
   ; if room=50  then plotsprite eyes 5 67 18                 ; Chetfast    | Hidden Lake Dungeon 
   ; if room=55  then plotsprite eyes 4 75 98                 ; Hagan       | North Desert Dungeon 
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

   ; ** Planned Additions to this area **
   ; Add turn-based attacks in dungeons with a new sub - change graphics to match dungeons instead of being outside.
   ; Jump to different subroutine for boss fights, one for each dungeon
   ; Add a few more NPC's to talk to
   ; Jump to action-based attack on select screens.  Add different enemy sprites in different subroutines. 
   ;     27-28-29 - A graveyard area.  Make Boat a smaller sprite, add up and down fenceposts, cross and RIP gravestone.
   ; Maybe just use it on specific screens, for extra gold or an item.
   ;  Just a note/reminder - change main menu to "erase" instead of "save".  Youll never be saving from the main menu, only status screen.

  goto mainloop

   ; «◘■■▄■▀▀■▄▄■▀▀■▄▄■▀▀■▄■► End Main Loop ◄■▄■▀▀■▄▄■▀▀■▄▄■▀▀■▄■■◘»
                                                        
   ;╔══════════════════════════════════════════════════════════════════════════════════════════════════╗ 
   ;║   Player Movement                                                                                ║
   ;╚══════════════════════════════════════════════════════════════════════════════════════════════════╝ 

checkmovedown
   ;╭──═◙ Check South Movement ◙═──────────────────────────────────────────────────────────────────═■
     if ypos>174 then p0_y=1:return                          ; Avoid checking offscreen characters
     tempx=(xpos+7)/8
     tempy=(ypos+16)/16
     tempchar1=peekchar(screenram,tempx,tempy,20,12)
     tempx=(xpos+7)/8
     tempchar2=peekchar(screenram,tempx,tempy,20,12)         
     if tempchar1<154 && tempchar2<154 then p0_y=1:return        ; 154 is the 13th tile in tileset_3
     ; The next two lines make the player slide around obstacles ; ...and is the first tile that the 
     if tempchar1<31 then p0_x=255:return                        ; Player is blocked by.
     if tempchar2<31 then p0_x=1:return
     return
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
checkmoveup
   ;╭──═◙ Check North Movement ◙═──────────────────────────────────────────────────────────────────═■
     if ypos<8 then p0_y=255:return                          ; Avoid checking offscreen characters
     tempx=(xpos+7)/8
     tempy=ypos/16
     tempchar1=peekchar(screenram,tempx,tempy,20,12)
     tempx=(xpos+7)/8
     tempchar2=peekchar(screenram,tempx,tempy,20,12)
     if tempchar1<154 && tempchar2<154 then p0_y=255:return
     ; The next two lines make the player slide around obstacles
     if tempchar1<31 then p0_x=255:return
     if tempchar2<31 then p0_x=1:return
     return
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
checkmoveleft
   ;╭──═◙ Check West Movement ◙═───────────────────────────────────────────────────────────────────═■
     if xpos<8 then p0_x=255:return                          ; Avoid checking offscreen characters
     tempx=xpos/8
     tempy=(ypos+1)/16
     tempchar1=peekchar(screenram,tempx,tempy,20,12)
     tempy=(ypos+15)/16
     tempchar2=peekchar(screenram,tempx,tempy,20,12)
     if tempchar1<154 && tempchar2<154 then p0_x=255:return
     ; The next two lines make the player slide around obstacles
     if tempchar1<31 then p0_y=255:return
     if tempchar2<31 then p0_y=1:return
     return
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
checkmoveright
   ;╭──═◙ Check East Movement ◙═───────────────────────────────────────────────────────────────────═■
     if xpos>142 then p0_x=1:return                          ; Avoid checking offscreen characters
     tempx=(xpos+8)/8
     tempy=(ypos+1)/16
     tempchar1=peekchar(screenram,tempx,tempy,20,12)
     tempy=(ypos+15)/16
     tempchar2=peekchar(screenram,tempx,tempy,20,12)
     if tempchar1<154 && tempchar2<154 then p0_x=1:return
     ; The next two lines make the player slide around obstacles
     if tempchar1<31 then p0_y=255:return
     if tempchar2<31 then p0_y=1:return
     return
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
                 inline 7800vox.asm

status_save_game
   gamedifficulty=0
   savememory STR INT VIT DEX HP HPMax mana manamax LevelHi LevelMed LevelLo GoldHi GoldMed GoldLo XPHi XPMed XPLo magic_val hpotion_val ring_val sword_val ring_val armor_val key_val shield_val
   gamedifficulty=1
   savememory rope_val rodoflife derame sephmond ugutz room key xpos ypos crystal1_flag crystal2_flag crystal3_flag crystal4_flag crystal5_flag crystal6_flag crystal7_flag lastroom mpotion_val sword shield armor health
   return otherbank

status_load_game
   gamedifficulty=0
   loadmemory STR INT VIT DEX HP HPMax mana manamax LevelHi LevelMed LevelLo GoldHi GoldMed GoldLo XPHi XPMed XPLo magic_val hpotion_val ring_val sword_val ring_val armor_val key_val shield_val
   gamedifficulty=1
   loadmemory rope_val rodoflife derame sephmond ugutz room key xpos ypos crystal1_flag crystal2_flag crystal3_flag crystal4_flag crystal5_flag crystal6_flag crystal7_flag lastroom mpotion_val sword shield armor health
   return otherbank  

status_erase_game
   rem this saves all of the default values
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
   return otherbank


                                                                                                           /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 2 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                           */ 
 bank 2 
 
changetileram_bank2
   for temp2=0 to 239
       screenram[temp2]=temproomlo[[temp2]]
   next
   return otherbank
   ;╭──═◙ Map files 0―→63 ◙═───╮
      incmapfile screen0map.tmx
      incmapfile screen1map.tmx
      incmapfile screen2map.tmx
      incmapfile screen3map.tmx
      incmapfile screen4map.tmx
      incmapfile screen5map.tmx
      incmapfile screen6map.tmx
      incmapfile screen7map.tmx
      incmapfile screen8map.tmx
      incmapfile screen9map.tmx
      incmapfile screen10map.tmx
      incmapfile screen11map.tmx
      incmapfile screen12map.tmx
      incmapfile screen13map.tmx
      incmapfile screen14map.tmx
      incmapfile screen15map.tmx
      incmapfile screen16map.tmx
      incmapfile screen17map.tmx
      incmapfile screen18map.tmx
      incmapfile screen19map.tmx
      incmapfile screen20map.tmx
      incmapfile screen21map.tmx
      incmapfile screen22map.tmx
      incmapfile screen23map.tmx
      incmapfile screen24map.tmx
      incmapfile screen25map.tmx
      incmapfile screen26map.tmx
      incmapfile screen27map.tmx
      incmapfile screen28map.tmx
      incmapfile screen29map.tmx
      incmapfile screen30map.tmx
      incmapfile screen31map.tmx
      incmapfile screen32map.tmx
      incmapfile screen33map.tmx
      incmapfile screen34map.tmx
      incmapfile screen35map.tmx
      incmapfile screen36map.tmx
      incmapfile screen37map.tmx
      incmapfile screen38map.tmx
      incmapfile screen39map.tmx
      incmapfile screen40map.tmx
      incmapfile screen41map.tmx
      incmapfile screen42map.tmx
      incmapfile screen43map.tmx
      incmapfile screen44map.tmx
      incmapfile screen45map.tmx
      incmapfile screen46map.tmx
      incmapfile screen47map.tmx
      incmapfile screen48map.tmx
      incmapfile screen49map.tmx
      incmapfile screen50map.tmx
      incmapfile screen51map.tmx
      incmapfile screen52map.tmx
      incmapfile screen53map.tmx
      incmapfile screen54map.tmx
      incmapfile screen55map.tmx
      incmapfile screen56map.tmx
      incmapfile screen57map.tmx
      incmapfile screen58map.tmx
      incmapfile screen59map.tmx
      incmapfile screen60map.tmx
      incmapfile screen61map.tmx
      incmapfile screen62map.tmx
      incmapfile screen63map.tmx
   ;╰───────────────────────────╯
                                                                                                           /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 3 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                           */ 
 bank 3 

changetileram_bank3
   for temp2=0 to 239
       screenram[temp2]=temproomlo[[temp2]]
   next
   return otherbank

   ;╭──═◙ Map files 64―→127 ◙═──╮
      incmapfile screen64map.tmx
      incmapfile screen65map.tmx
      incmapfile screen66map.tmx
      incmapfile screen67map.tmx
      incmapfile screen68map.tmx
      incmapfile screen69map.tmx
      incmapfile screen70map.tmx
      incmapfile screen71map.tmx
      incmapfile screen72map.tmx
      incmapfile screen73map.tmx
      incmapfile screen74map.tmx
      incmapfile screen75map.tmx
      incmapfile screen76map.tmx
      incmapfile screen77map.tmx
      incmapfile screen78map.tmx
      incmapfile screen79map.tmx
      incmapfile screen80map.tmx
      incmapfile screen81map.tmx
      incmapfile screen82map.tmx
      incmapfile screen83map.tmx
      incmapfile screen84map.tmx
      incmapfile screen85map.tmx
      incmapfile screen86map.tmx
      incmapfile screen87map.tmx
      incmapfile screen88map.tmx
      incmapfile screen89map.tmx
      incmapfile screen90map.tmx
      incmapfile screen91map.tmx
      incmapfile screen92map.tmx
      incmapfile screen93map.tmx
      incmapfile screen94map.tmx
      incmapfile screen95map.tmx
      incmapfile screen96map.tmx
      incmapfile screen97map.tmx
      incmapfile screen98map.tmx
      incmapfile screen99map.tmx
      incmapfile screen100map.tmx
      incmapfile screen101map.tmx
      incmapfile screen102map.tmx
      incmapfile screen103map.tmx
      incmapfile screen104map.tmx
      incmapfile screen105map.tmx
      incmapfile screen106map.tmx
      incmapfile screen107map.tmx
      incmapfile screen108map.tmx
      incmapfile screen109map.tmx
      incmapfile screen110map.tmx
      incmapfile screen111map.tmx
      incmapfile screen112map.tmx
      incmapfile screen113map.tmx
      incmapfile screen114map.tmx
      incmapfile screen115map.tmx
      incmapfile screen116map.tmx
      incmapfile screen117map.tmx
      incmapfile screen118map.tmx
      incmapfile screen119map.tmx
      incmapfile screen120map.tmx
      incmapfile screen121map.tmx
      incmapfile screen122map.tmx
      incmapfile screen123map.tmx
      incmapfile screen124map.tmx
      incmapfile screen125map.tmx
      incmapfile screen126map.tmx
      incmapfile screen127map.tmx
   ;╰────────────────────────────╯
                                                                                                             /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 4 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                             */ 
 bank 4

changetileram_bank4
   for temp2=0 to 239
       screenram[temp2]=temproomlo[[temp2]]
   next
   return otherbank

   ;╭──═◙ Map files 128→191 ◙═──╮
   ; incmapfile 128-191 here
     incmapfile screen128map.tmx
     incmapfile screen129map.tmx
     incmapfile screen130map.tmx
     incmapfile screen131map.tmx
     incmapfile screen132map.tmx
     incmapfile screen133map.tmx
     incmapfile screen134map.tmx
     incmapfile screen135map.tmx
     incmapfile screen136map.tmx
     incmapfile screen137map.tmx
     incmapfile screen138map.tmx
     incmapfile screen139map.tmx
     incmapfile screen140map.tmx
     incmapfile screen141map.tmx
     incmapfile screen142map.tmx
     incmapfile screen143map.tmx
     incmapfile screen144map.tmx
     incmapfile screen145map.tmx
     incmapfile screen146map.tmx
     incmapfile screen147map.tmx
     incmapfile screen148map.tmx
     incmapfile screen149map.tmx
     incmapfile screen150map.tmx
     incmapfile screen151map.tmx
     incmapfile screen152map.tmx
     incmapfile screen153map.tmx
     incmapfile screen154map.tmx
     incmapfile screen155map.tmx
     incmapfile screen156map.tmx
     incmapfile screen157map.tmx
     incmapfile screen158map.tmx
     incmapfile screen159map.tmx
     incmapfile screen160map.tmx
     incmapfile screen161map.tmx
     incmapfile screen162map.tmx
     incmapfile screen163map.tmx
     incmapfile screen164map.tmx
     incmapfile screen165map.tmx
     incmapfile screen166map.tmx
     incmapfile screen167map.tmx
     incmapfile screen168map.tmx
     incmapfile screen169map.tmx
     incmapfile screen170map.tmx
     incmapfile screen171map.tmx
     incmapfile screen172map.tmx
     incmapfile screen173map.tmx
     incmapfile screen174map.tmx
     incmapfile screen175map.tmx
     incmapfile screen176map.tmx
     incmapfile screen177map.tmx
     incmapfile screen178map.tmx
     incmapfile screen179map.tmx
     incmapfile screen180map.tmx
     incmapfile screen181map.tmx
     incmapfile screen182map.tmx
     incmapfile screen183map.tmx
     incmapfile screen184map.tmx
     incmapfile screen185map.tmx
     incmapfile screen186map.tmx
     incmapfile screen187map.tmx
     incmapfile screen188map.tmx
     incmapfile screen189map.tmx
     incmapfile screen190map.tmx
     incmapfile screen191map.tmx
  ;╰────────────────────────────╯
                                                                                                             /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 5 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                             */ 
 bank 5

changetileram_bank5
  for temp2=0 to 239
      screenram[temp2]=temproomlo[[temp2]]
  next
  return otherbank

  ;╭──═◙ Map files 192―→255 ◙═──╮
     incmapfile screen192map.tmx
     incmapfile screen193map.tmx
     incmapfile screen194map.tmx
     incmapfile screen195map.tmx
     incmapfile screen196map.tmx
     incmapfile screen197map.tmx
     incmapfile screen198map.tmx
     incmapfile screen199map.tmx
     incmapfile screen200map.tmx
     incmapfile screen201map.tmx
     incmapfile screen202map.tmx
     incmapfile screen203map.tmx
     incmapfile screen204map.tmx
     incmapfile screen205map.tmx
     incmapfile screen206map.tmx
     incmapfile screen207map.tmx
     incmapfile screen208map.tmx
     incmapfile screen209map.tmx
     incmapfile screen210map.tmx
     incmapfile screen211map.tmx
     incmapfile screen212map.tmx
     incmapfile screen213map.tmx
     incmapfile screen214map.tmx
     incmapfile screen215map.tmx
     incmapfile screen216map.tmx
     incmapfile screen217map.tmx
     incmapfile screen218map.tmx
     incmapfile screen219map.tmx
     incmapfile screen220map.tmx
     incmapfile screen221map.tmx
     incmapfile screen222map.tmx
     incmapfile screen223map.tmx
     incmapfile screen224map.tmx
     incmapfile screen225map.tmx
     incmapfile screen226map.tmx
     incmapfile screen227map.tmx
     incmapfile screen228map.tmx
     incmapfile screen229map.tmx
     incmapfile screen230map.tmx
     incmapfile screen231map.tmx
     incmapfile screen232map.tmx
     incmapfile screen233map.tmx
     incmapfile screen234map.tmx
     incmapfile screen235map.tmx
     incmapfile screen236map.tmx
     incmapfile screen237map.tmx
     incmapfile screen238map.tmx
     incmapfile screen239map.tmx
     incmapfile screen240map.tmx
     incmapfile screen241map.tmx
     incmapfile screen242map.tmx
     incmapfile screen243map.tmx
     incmapfile screen244map.tmx
     incmapfile screen245map.tmx
     incmapfile screen246map.tmx
     incmapfile screen247map.tmx
     incmapfile screen248map.tmx
     incmapfile screen249map.tmx
     incmapfile screen250map.tmx
     incmapfile screen251map.tmx
     incmapfile screen252map.tmx
     incmapfile screen253map.tmx
     incmapfile screen254map.tmx
     incmapfile screen255map.tmx
  ;╰────────────────────────────╯ 
                                                                                                            /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 6 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                            */ 
 bank 6
   ;╭──═◙ Bank 6 Graphics / Overworld ◙═────────────────────────────────────────────────────────────╮
    incgraphic tileset_1.png 160A 0 1 2 3 1
    incgraphic tileset_2.png 160A 0 1 2 3 1
    incgraphic tileset_3.png 160A 0 1 2 3 1
    incgraphic tileset_4.png 160A 0 1 2 3 1
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
b6drawscreen
   ;╭──═◙ Bank 6 Drawscreen ◙═──────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
     drawscreen
    ;╭──═◙ Collision Detection for Enemy Attack / Bank 14 ◙═─────────────────────────────────────────────────────────────────────────────╮
    ;if attacksequence=0 then skipcollisions2
    ;if skeleton_flag=0 && boxcollision(xpos,ypos,7,13, skeleton_x,skeleton_y, 15,15) then skeleton_flag=1:skeleton_x=200:skeleton_y=200:health=health-1
    ;if boxcollision(swordfire_x,swordfire_y,8,2, skeleton_x,skeleton_y, 15,15) then skeleton_flag=1:skeleton_x=200:skeleton_y=200:scorea=scorea+1
    ;if boxcollision(xpos,ypos,7,13, gold1_x,gold1_y, 15,15) then gold1_x=200:gold1_y=200:score0=score0+7
skipcollisions1
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
     drawwait 
     return otherbank
   ; Define Alphadata for Status Bar

 alphachars ' abcdefghijklmnopqrstuvwxyzABCDEF' 

 alphadata statusbar6 tileset_2
 'wjzzkzzlpqrstzzzzzzx'
 'umnyoyyABCDEyyyyyyyv'
end

                                                                                                             /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 7 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                             */ 
 bank 7 
   ;╭──═◙ Bank 7 Graphics / Towns ◙═────────────────────────────────────────────────────────────────╮
     incgraphic tileset_5.png 160A 0 1 2 3 1
     incgraphic tileset_6.png 160A 0 1 2 3 1
     incgraphic tileset_7.png 160A 0 1 2 3 1
     incgraphic tileset_8.png 160A 0 1 2 3 1
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
b7drawscreen
   ;╭──═◙ Bank 7 Drawscreen ◙═──────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
     drawscreen
    ;╭──═◙ Collision Detection for Enemy Attack / Bank 14 ◙═─────────────────────────────────────────────────────────────────────────────╮
    ;if attacksequence=0 then skipcollisions2
    ;if skeleton_flag=0 && boxcollision(xpos,ypos,7,13, skeleton_x,skeleton_y, 15,15) then skeleton_flag=1:skeleton_x=200:skeleton_y=200:health=health-1
    ;if boxcollision(swordfire_x,swordfire_y,8,2, skeleton_x,skeleton_y, 15,15) then skeleton_flag=1:skeleton_x=200:skeleton_y=200:scorea=scorea+1
    ;if boxcollision(xpos,ypos,7,13, gold1_x,gold1_y, 15,15) then gold1_x=200:gold1_y=200:score0=score0+7
skipcollisions2
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
     drawwait 
     return otherbank

 alphachars ' abcdefghijklmnopqrstuvwxyzABCDEF' 

 alphadata statusbar7 tileset_6
 'wjzzkzzlpqrstzzzzzzx'
 'umnyoyyABCDEyyyyyyyv'
end

                                                                                                             /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 8 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                             */ 
 bank 8 
   ;╭──═◙ Bank 8 Graphics / Underworld ◙═───────────────────────────────────────────────────────────╮
     incgraphic tileset_a.png 160A 0 1 2 3 1
     incgraphic tileset_b.png 160A 0 1 2 3 1
     incgraphic tileset_c.png 160A 0 1 2 3 1
     incgraphic tileset_d.png 160A 0 1 2 3 1
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

b8drawscreen
   ;╭──═◙ Bank 8 Drawscreen ◙═──────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
     drawscreen
     drawwait 
     return otherbank

 alphachars ' abcdefghijklmnopqrstuvwxyzABCDEF' 

 alphadata statusbar8 tileset_2
 'wjzzkzzlpqrstzzzzzzx'
 'umnyoyyABCDEyyyyyyyv'
end

initialize_attack
  ; This is called from bank9, and initializes all of the variables prior to the attack loop running.

  ;╭──═◙ Initial Enemy Location ◙═──────────────────────────────────────────────────────────────────────────────────╮
  ; 1-snake  2-bat  3-warrior  4-fighter  5-knight  6-hydra  7-minotaur  8-wizard 
  ;
  ; Lvl  Active Enemies            Battlefield
  ;      1-2-3-4-5-6-7-8  -Y- ┌────┬─────────┬────┐ -Y-  Line
  ; 0    0-0-0-X-X-X-X-X  80  │----\__text___/----│ 80   1 [X must be fixed to left or right side]
  ; 3    0-0-0-0-X-X-X-X  96  │-1---------7-------│ 96   2
  ; 7    0-0-0-0-0-X-X-X  112 │-----2----------6--│ 112  3
  ; 10   X-0-0-0-0-0-X-X  128 │---------3---------│ 128  4
  ; 16   X-0-0-0-0-0-0-X  144 │--8----------4-----│ 144  5
  ; 26   X-X-0-0-0-0-0-0  160 │-------5-----------│ 160  6
  ;                       176 │----/``text```\----│ 176  7 [not desirable, hero appears in status bar when attacking]
  ;                       -Y- └────┴─────────┴────┘ -Y-
     enemy1_x=142:          enemy1_y=96
     enemy2_x=(rand&63)+8:  enemy2_y=112
     enemy3_x=(rand&63)+58: enemy3_y=128
     enemy4_x=(rand&63)+24: enemy4_y=144
     enemy5_x=(rand&63)+36: enemy5_y=160
     enemy6_x=10:           enemy6_y=112
     enemy7_x=(rand&63)+18: enemy7_y=96
     enemy8_x=8:            enemy8_y=144
  ;╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

  ;╭──═◙ Enemy Hit Point Level Modifier ◙═────────────────────────────────────╮
    if Level<7              then LevelModifier=0         
    if Level>6  && Level<10 then LevelModifier=(rand&3)
    if Level>9  && Level<16 then LevelModifier=(rand&7)
    if Level>15 && Level<26 then LevelModifier=(rand&16)
    if Level>25             then LevelModifier=(rand&32)
  ;╰──────────────────────────────────────────────────────────────────────────╯
  ;╭──═◙ Enemy Hit Points ◙═──────────────────────────────────────────────────╮
    ; Modify/Increase enemy hitpoints based on your character level  
    ; If you wish to display a regular variable, 7800basic also includes a
    ; "converttobcd" utility function that returns the BCD value of a non-BCD 
    ; variable. The non-BCD variable should be in the range between 0-99, 
    ; or else it will start to display incorrect values.
    ;     BCDVar=converttobcd(NonBCDVar)

    temp1=converttobcd(LevelModifier)

    temp2=(rand&7)
    temp3=converttobcd(temp2)
    enemy1_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&7)
    temp3=converttobcd(temp2)
    enemy2_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&15)
    temp3=converttobcd(temp2)
    enemy3_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&15)
    temp3=converttobcd(temp2)
    enemy4_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&31)
    temp3=converttobcd(temp2)
    enemy5_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&63)
    temp3=converttobcd(temp2)
    enemy6_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&63)
    temp3=converttobcd(temp2)
    enemy7_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&63)
    temp3=converttobcd(temp2)
    enemy8_HP=converttobcd(temp3)+converttobcd(temp1)
  ;╰──────────────────────────────────────────────────────────────────────────╯

    enemy1_hit=0
    enemy2_hit=0
    enemy3_hit=0
    enemy4_hit=0
    enemy5_hit=0
    enemy6_hit=0
    enemy7_hit=0
    enemy8_hit=0
 
    ; DEBUG - Temporarily change starting level of player
    ; Level=$26

  ;╭──═◙ Enemy Hit Point Level Modifier ◙═────────────────────────────────────╮
    ; Enables specific enemies based on level, and updates "total_enemies" variable with the number of active enemies on-screen.
    if Level<3              then snake_flag=0 : bat_flag=0 :warrior_flag=0 : fighter_flag=3 : knight_flag=3 : hydra_flag=3 : minotaur_flag=3 : wizard_flag=3 : total_enemies=3 : XP_GainHi=$00:XP_GainMed=$00:XP_GainLo=$03       
    if Level>2  && Level<7  then snake_flag=0 : bat_flag=0 :warrior_flag=0 : fighter_flag=0 : knight_flag=3 : hydra_flag=3 : minotaur_flag=3 : wizard_flag=3 : total_enemies=4 : XP_GainHi=$00:XP_GainMed=$00:XP_GainLo=$19
    if Level>6  && Level<10 then snake_flag=0 : bat_flag=0 :warrior_flag=0 : fighter_flag=0 : knight_flag=0 : hydra_flag=3 : minotaur_flag=3 : wizard_flag=3 : total_enemies=5 : XP_GainHi=$00:XP_GainMed=$00:XP_GainLo=$47
    if Level>9  && Level<16 then snake_flag=3 : bat_flag=0 :warrior_flag=0 : fighter_flag=0 : knight_flag=0 : hydra_flag=0 : minotaur_flag=3 : wizard_flag=3 : total_enemies=5 : XP_GainHi=$00:XP_GainMed=$00:XP_GainLo=$69 
    if Level>15 && Level<26 then snake_flag=3 : bat_flag=0 :warrior_flag=0 : fighter_flag=0 : knight_flag=0 : hydra_flag=0 : minotaur_flag=0 : wizard_flag=3 : total_enemies=6 : XP_GainHi=$00:XP_GainMed=$01:XP_GainLo=$01
    if Level>25             then snake_flag=3 : bat_flag=3 :warrior_flag=0 : fighter_flag=0 : knight_flag=0 : hydra_flag=0 : minotaur_flag=0 : wizard_flag=0 : total_enemies=6 : XP_GainHi=$00:XP_GainMed=$01:XP_GainLo=$21
  ;╰──────────────────────────────────────────────────────────────────────────╯

  ;╭──═◙ Initialize Variables ◙═─────────────────────────────────────────────────────────╮
      ;Left Menu Icon selector
      selector_x=6:selector_y=21
      
      ;Right Menu Icon selector
      selector2_x=136:selector2_y=22

      ;11T-not in use
      selector3_x=enemy1_x:selector3_y=enemy1_y
      
      ;Reset Joystick & L/R Button Debounce Variables
      joyleftdebounce=0:joyrightdebounce=0:joyupdebounce=0:joydowndebounce=0:debounce=0:debounce2=0

      fight_menu=0 : parry_menu=0  : run_menu=0 : item_menu=0 : leftside=1 : rightside=0
      attackturn=0 : attack_odds=0 : hit_odds=0 : miss_odds=0 : run_odds=0

      attack_start=0:parry_result=0:run_result=0:end_battle=0:attack_active=1:check_gold=0:select_enemy=1:gold_found=0:XP_Check=0:firststrike=0
  ;╰─────────────────────────────────────────────────────────────────────────────────────╯
  hero_x=78:hero_y=158 
  return otherbank

CheckXP
  ; Increase XP after a battle
  XP_Check=1
  dec XPLo=XPLo+XP_GainLo
  if CARRY then dec XPMed=XPMed+XP_GainMed+1 else dec XPMed=XPMed+XP_GainMed
  if CARRY then dec XPHi=XPHi+XP_GainHi+1 else dec XPHi=XPHi+XP_GainHi
  return otherbank
                                                                                                             /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 9 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                             */ 
 bank 9 
 
  ; Turn Attack

  ;╭──═◙ Bank 9 Graphics ◙═───────────────────────────────────────────────────────────────────────╮
    incgraphic tileset_attack1.png 160A 0 1 2 3 1
    incgraphic tileset_attack2.png 160A 0 1 2 3 1
    incgraphic tileset_attack3.png 160A 0 1 2 3 1
    incgraphic tileset_attack4.png 160A 0 1 2 3 1
    incgraphic icon_selector.png
    incgraphic icon_selector2.png
  ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

changetileram_bank9
  temp2=129
      screenram[temp2]=temproomlo[[temp2]]
  return otherbank

turnattackloop
     gosub initialize_attack bank8
     if Level<10            then active_enemy=1 :selector3b_x=enemy1_x: selector3b_y=(enemy1_y)+8
     if Level>9 && Level<26 then active_enemy=2 :selector3b_x=enemy2_x: selector3b_y=(enemy2_y)+8
     if Level>25            then active_enemy=3 :selector3b_x=enemy3_x: selector3b_y=(enemy3_y)+8
     lastroom=room
     room=129:clearscreen:gosub draw_room bank15
     savescreen

turnattackloop2
      restorescreen    

   ;╭──═◙ Victory! Return from Battle ◙═─────────────────────────────────────────╮
      if end_battle=0 then goto skiptheend
      if joy0fire1 then attack_active=0:goto GoBackHome
      ; Add Random amount of gold here.... not implemented yet....
      if check_gold=0 then gosub get_gold
      if XP_Check=0 then gosub CheckXP bank8
      if run_result<>1 then plotvalue tileset_attack2 4 gold_found 2 32 11:plotchars 'gold found' 4 50 11
skiptheend
   ;╰────────────────────────────────────────────────────────────────────────────╯

   if select_enemy=1 then goto skiplrmenus

   ;╭──═◙ Left Menu (Actions) ◙═─────────────────────────────────────────────────────────────────────────────────────────────────╮
      if rightside=1 then skipleftmenu
            ; 21=Fight, 37=Run, 53=Parry, 69=Item
      selector_x=6
      if selector_y=21 && joydowndebounce=5 then selector_y=37:joydowndebounce=0:fight_menu=1:parry_menu=0:run_menu=0:item_menu=0
      if selector_y=37 && joydowndebounce=5 then selector_y=53:joydowndebounce=0:fight_menu=0:parry_menu=0:run_menu=1:item_menu=0
      if selector_y=53 && joydowndebounce=5 then selector_y=69:joydowndebounce=0:fight_menu=0:parry_menu=1:run_menu=0:item_menu=0
      if selector_y=69 && joydowndebounce=5 then selector_y=69:joydowndebounce=0:fight_menu=0:parry_menu=0:run_menu=0:item_menu=1
      if selector_y=21 && joyupdebounce=5   then selector_y=21:joyupdebounce=0:  fight_menu=1:parry_menu=0:run_menu=0:item_menu=0
      if selector_y=37 && joyupdebounce=5   then selector_y=21:joyupdebounce=0:  fight_menu=0:parry_menu=0:run_menu=1:item_menu=0
      if selector_y=53 && joyupdebounce=5   then selector_y=37:joyupdebounce=0:  fight_menu=0:parry_menu=1:run_menu=0:item_menu=0
      if selector_y=69 && joyupdebounce=5   then selector_y=53:joyupdebounce=0:  fight_menu=0:parry_menu=0:run_menu=0:item_menu=1
   ; ──═◙ FIGHT ◙═───────────────────────────────────────────────────────────────────────────────────────────
   ;  If left button pressed, left menu active, fight option selected, disable r/l menus and enable enemy selection.
      if selector_y=21 && debounce2=5 then debounce2=0:rightside=0:leftside=0:select_enemy=1:gosub multibankdrawscreen bank15
   ; ──═◙ RUN ◙═───────────────────────────────────────────────────────────────────────────────────────────
   ;  Check for Run option - one chance to be attacked again, then possibility of running away.
      if selector_y=37 && debounce2=5 && run_result=0 then debounce2=0:gosub run_check
      if run_result=1 then debounce=0:debounce2=0:leftside=0:rightside=0:selector2_x=200:selector2_y=200:selector_x=200:selector_y=200:select_enemy=0:selector3b_x=200:selector3b_y=200:plotchars 'you ran away' 3 31 11:end_battle=1 ;active_enemy=0
      if run_result=2 && select_enemy=0 && selector_y=37 then plotchars 'could not run' 4 28 11
   ; ──═◙ PARRY ◙═───────────────────────────────────────────────────────────────────────────────────────────
   ;  Check for Parry option - will eliminate any damage on next successful enemy attack.
      if selector_y=53 && debounce2=5 && parry_result=0 then debounce2=0:gosub parry_check 
      if parry_result=1 && selector_y=53 then hit_odds=0:plotchars 'defense up' 4 39 11
      if parry_result=2 && selector_y=53 then hit_odds=1:plotchars 'parry failed' 4 28 11
   ; ──═◙ ITEM ◙═───────────────────────────────────────────────────────────────────────────────────────────
   ;  Press the left button when "Item" is selected on the left side:  Moves you to the right side menu
      if selector_y=69 && debounce2=5 then debounce2=0:selector2_x=136:selector2_y=22:rightside=1:leftside=0
skipleftmenu
    ;╰───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 
    ;╭──═◙ Right Menu (Items) ◙═─────────────────────────────────────────────────────────────────────────────────────────────────╮
      if leftside=1 then skiprightmenu
      selector2_x=136

      if selector2_y=22 && joydowndebounce=5 then selector2_y=38:joydowndebounce=0
      if selector2_y=38 && joydowndebounce=5 then selector2_y=54:joydowndebounce=0
      if selector2_y=54 && joydowndebounce=5 then selector2_y=70:joydowndebounce=0
      if selector2_y=70 && joydowndebounce=5 then selector2_y=70:joydowndebounce=0

      if selector2_y=70 && joyupdebounce=5   then selector2_y=54:joyupdebounce=0
      if selector2_y=54 && joyupdebounce=5   then selector2_y=38:joyupdebounce=0
      if selector2_y=38 && joyupdebounce=5   then selector2_y=22:joyupdebounce=0
      if selector2_y=22 && joyupdebounce=5   then selector2_y=22: joyupdebounce=0

      ; Press Right button to select and use menu item on the right side
   ; ──═◙ HEALTH POTION ◙═──────────────────────────────────────────────────────────────────────────────────────────────────────
      if selector2_y=22 && debounce=5 && hpotion_val>0 then debounce=0:dec hpotion_val=hpotion_val-1:dec HP=HPMax: room=129:BACKGRND=$80:clearscreen:gosub draw_room bank15:savescreen:BACKGRND=$00
   ; ──═◙ MAGIC POTION ◙═───────────────────────────────────────────────────────────────────────────────────────────────────────
      if selector2_y=38 && debounce=5 && mpotion_val>0 then debounce=0:dec mpotion_val=mpotion_val-1:dec mana=manamax: room=129:BACKGRND=$80:clearscreen:gosub draw_room bank15:savescreen:BACKGRND=$00     
   ; ──═◙ MAGIC ITEM◙═──────────────────────────────────────────────────────────────────────────────────────────────────────────
      if selector2_y=54 && debounce=5 && magic_val>0   then debounce=0:dec magic_val=magic_val-1    :clearscreen:gosub draw_room bank15:savescreen                           ;magic item (round thing)
   ; ──═◙ RING  ◙═──────────────────────────────────────────────────────────────────────────────────────────────────────────────
      if selector2_y=70 && debounce=5 && ring_val>0    then debounce=0:dec ring_val=ring_val-1      :clearscreen:gosub draw_room bank15:savescreen                           ;ring
   ; ──═◙ EXIT RIGHT MENU   ◙═──────────────────────────────────────────────────────────────────────────────────────────────────
   ;  Left Joystick Press cancels and takes you back to main menu (Press Right Button to Select)
      if joyleftdebounce=5 then joyleftdebounce=0 :selector_x=6:selector_y=69:leftside=1:rightside=0
skiprightmenu
    ;╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
skiplrmenus

  ; If all enemies are killed, bounce back to left side menu, change to "victory" message and exit.
    if total_enemies=0 then debounce=0:debounce2=0:leftside=0:rightside=0:selector2_x=200:selector2_y=200:selector_x=200:selector_y=200:select_enemy=0:selector3b_x=200:selector3b_y=200:end_battle=1:plotchars 'victory' 3 52 1:active_enemy=0

  ; if right button is pressed and enemy selection is active, then disable enemy selection, go to left menu, fight option.
    if debounce=5 && select_enemy=1 then debounce=0:select_enemy=0:leftside=1:rightside=0:selector_x=6:selector_y=69

      framecounter1=framecounter1+1 
      if framecounter1>8 then framecounter1=0:framecounter2=framecounter2+1
      if framecounter2>3 then framecounter2=0

    ;╭──═◙ BATTLE ◙═─────────────────────────────────────────────────────────────────────────────────────────────────────────╮
      if select_enemy=0 then goto skipenemyplot     ; Skip the entire battle section if the menus on the top are active
    ; ───═◙ Conditions ◙═────────────────────────────────────────────────────────────────────────────────────────────────────
    ;
    ; *ENEMY SELECT ENABLED       select_enemy=1: Enemy selector is active
    ; ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ; *IDENTIFY ACTIVE ENEMY      active_enemy=<1-8>: Which enemy is actively selected
    ;                             1-snake  2-bat  3-warrior  4-fighter  5-knight  6-hydra  7-minotaur  8-wizard  9-skeleton 
    ; ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ; *TOTAL NUMBER OF ENEMIES    total_enemies=x: Number of active enemies that need to be killed (or get killed by!)
    ; ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ; *ENEMY ALIVE OR DEAD        <enemy_name>_flag=3/0:  If it is 0, the enemy is alive, if it is 3 the enemy has been killed.
    ; ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ; *ENEMY HITPOINTS REMAINING  enemy<x>_HP: The number of Hitpoints remaining for each enemy
    ; ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ; *ATTACK DAMAGE              attack_damage variable is how much damage you will do when you hit - with modifiers

    ;if attack_start=0 then plotchars 'press fire' 3 38 0:plotchars 'to attack' 3 38 1

    if hit_odds=9 && run_result<>1 && parry_result<>1 then plotchars 'you were hit' 5 31 11

   ;╭──═◙ Enemy Selection/Targeting ◙═──────────────────────────────────────────────────────────────────────────────────────╮
      if select_enemy=1 && debounce2=5 then debounce2=0 :firststrike =1: gosub next_enemy
      if active_enemy>8 then active_enemy=1
skipenemyselect
    ;╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

    if death_flag=1 then goto death_turnattackloop bank20

    ; avoid displaying any of the active enemy text until you've pressed the button for the first time
    if firststrike=0 then goto active_enemy_done

  on active_enemy goto enemy0 enemy1 enemy2 enemy3 enemy4 enemy5 enemy6 enemy7 enemy8
    ; 1-snake  2-bat  3-warrior  4-fighter  5-knight  6-hydra  7-minotaur  8-wizard  9-skeleton 

enemy0
   hero_x=78:hero_y=158 
enemy1
   plotchars 'snake'   7 36 4:hero_x=enemy1_x+4:hero_y=enemy1_y+11
   if snake_flag=3     && attack_odds=1 then plotchars 'killed' 7 36 3:goto active_enemy_done
   if enemy1_hit=1 then plotchars 'hit' 7 36 3 
   if enemy1_hit=0 then plotchars 'missed' 7 36 3 
   goto active_enemy_done
enemy2
   plotchars 'bat'     7 36 4:hero_x=enemy2_x+4:hero_y=enemy2_y+11
    if bat_flag=3      && attack_odds=1 then plotchars 'killed' 7 36 3:goto active_enemy_done
    if enemy2_hit=1 then plotchars 'hit' 7 36 3 
    if enemy2_hit=0 then plotchars 'missed' 7 36 3 
   goto active_enemy_done
enemy3
   plotchars 'warrior' 7 36 4:hero_x=enemy3_x+4:hero_y=enemy3_y+11
    if warrior_flag=3  && attack_odds=1 then plotchars 'killed' 7 36 3:goto active_enemy_done
    if enemy3_hit=1 then plotchars 'hit' 7 36 3 
    if enemy3_hit=0 then plotchars 'missed' 7 36 3 
   goto active_enemy_done
enemy4
   plotchars 'fighter' 7 36 4:hero_x=enemy4_x+4:hero_y=enemy4_y+11
    if fighter_flag=3  && attack_odds=1 then plotchars 'killed' 7 36 3:goto active_enemy_done
    if enemy4_hit=1 then plotchars 'hit' 7 36 3 
    if enemy4_hit=0 then plotchars 'missed' 7 36 3 
   goto active_enemy_done
enemy5
   plotchars 'knight'  7 36 4:hero_x=enemy5_x+4:hero_y=enemy5_y+11
    ;if knight_flag=0   then plotchars 'knight'  3 36 2 
    if knight_flag=3   && attack_odds=1 then plotchars 'killed' 7 36 3:goto active_enemy_done
    if enemy5_hit=1 then plotchars 'hit' 7 36 3 
    if enemy5_hit=0 then plotchars 'missed' 7 36 3 
   goto active_enemy_done
enemy6
   plotchars 'hydra'   7 36 4:hero_x=enemy6_x+4:hero_y=enemy6_y+11
    if hydra_flag=3    && attack_odds=1 then plotchars 'killed' 7 36 3:goto active_enemy_done
    if enemy6_hit=1 then plotchars 'hit' 7 36 3 
    if enemy6_hit=0 then plotchars 'missed' 7 36 3 
   goto active_enemy_done
enemy7
   plotchars 'monster' 7 36 4:hero_x=enemy7_x+4:hero_y=enemy7_y+11
    if minotaur_flag=3 && attack_odds=1 then plotchars 'killed' 7 36 3:goto active_enemy_done
    if enemy7_hit=1 then plotchars 'hit' 7 36 3 
    if enemy7_hit=0 then plotchars 'missed' 7 36 3 
   goto active_enemy_done
enemy8
   plotchars 'wizard'  7 36 4:hero_x=enemy8_x+4:hero_y=enemy8_y+11
    if wizard_flag=3   && attack_odds=1 then plotchars 'killed' 7 36 3:goto active_enemy_done
    if enemy8_hit=1 then plotchars 'hit' 7 36 3 
    if enemy8_hit=0 then plotchars 'missed' 7 36 3 
   goto active_enemy_done
active_enemy_done

    if select_enemy=0 then goto skipenemyplot 

    plotchars 'press fire' 3 38 0:plotchars 'to attack' 3 38 1

    if attack_start=1 then goto skiptherest1
    if snake_flag=0    then plotchars 'snake'   3 36 2:goto skiptherest1 
    if bat_flag=0      then plotchars 'bat'     3 36 2:goto skiptherest1  
    if warrior_flag=0  then plotchars 'warrior' 3 36 2:goto skiptherest1   
    if fighter_flag=0  then plotchars 'fighter' 3 36 2:goto skiptherest1   
    if knight_flag=0   then plotchars 'knight'  3 36 2:goto skiptherest1   
    if hydra_flag=0    then plotchars 'hydra'   3 36 2:goto skiptherest1   
    if minotaur_flag=0 then plotchars 'monster' 3 36 2:goto skiptherest1   
    if wizard_flag=0   then plotchars 'wizard'  3 36 2:goto skiptherest1  
skiptherest1


   ;╭──═◙ Plot Graphics ◙═───────────────────────────────────────────────────────────────────────────╮
   ; ──═◙ Enemies ◙═─────────────────────────────────────────────────────────────────────────────────
      ; 1-snake  2-bat  3-warrior  4-fighter  5-knight  6-hydra  7-minotaur  8-wizard  
      if snake_flag=0    then plotsprite sprite_snake1b    3 enemy1_x   enemy1_y   framecounter2
      if bat_flag=0      then plotsprite sprite_bat1b      0 enemy2_x   enemy2_y   framecounter2
      if warrior_flag=0  then plotsprite sprite_warrior1b  4 enemy3_x   enemy3_y   framecounter2 
      if fighter_flag=0  then plotsprite sprite_fighter1b  6 enemy4_x   enemy4_y   framecounter2   
      if knight_flag=0   then plotsprite sprite_knight1b   1 enemy5_x   enemy5_y   framecounter2  
      if hydra_flag=0    then plotsprite sprite_hydra1b    4 enemy6_x   enemy6_y   framecounter2   ;11r  -  5x test success
      if minotaur_flag=0 then plotsprite sprite_minotaur1b 4 enemy7_x   enemy7_y   framecounter2   ;11r
      if wizard_flag=0   then plotsprite sprite_wizard1b   5 enemy8_x   enemy8_y   framecounter2   ;11r
      ;plotsprite icon_selector2 framecounter1 selector3b_x selector3b_y ; selector sprite that's underneath the enemy.  Commented out in 12b, but works fine.
      plotvalue tileset_attack2 5 attack_damage 2 107 5  
      plotvalue tileset_attack2 3 enemy_HP 2 65 5  
      plotsprite herodown2 framecounter hero_x hero_y ; '0' replaced with 'framecounter' in 12b. Player flashes instead of using icon_selector2, saves one sprite plot command.
skipenemyplot
      if select_enemy=1 then goto victoryskip
      if leftside=1 then plotsprite icon_selector 3 selector_x selector_y
      if rightside=1 then plotsprite icon_selector2 3 selector2_x selector2_y
      plotvalue tileset_attack2 3 ring_val    2 137 4
      plotvalue tileset_attack2 5 hpotion_val 2 137 1
      plotvalue tileset_attack2 4 mpotion_val 2 137 2
      plotvalue tileset_attack2 3 magic_val   2 137 3
victoryskip
    ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

      gosub multibankdrawscreen bank15                        ; Jumps to Drawscreen Subroutine

   goto turnattackloop2

GoBackHome
      ; Reset Palettes back to the default
      P1C1=$F1   :  P2C1=$80  :  P3C1=$1C  :  P4C1=$90  :  P5C1=$42  :  P6C1=$C6  :  P7C1=$E0
      P1C2=$F3   :  P2C2=$86  :  P3C2=$34  :  P4C2=$98  :  P5C2=$46  :  P6C2=$C4  :  P7C2=$08
      P1C3=$C0   :  P2C3=$F2  :  P3C3=$3A  :  P4C3=$0F  :  P5C3=$FF  :  P6C3=$F2  :  P7C3=$04
      room=lastroom
      if room<64              then characterset tileset_1:roombank=6:goto setroom5  
      if room>63  && room<128 then characterset tileset_1:roombank=6:goto setroom5
      if room>127 && room<192 then characterset tileset_5:roombank=7:goto setroom5
      if room>191             then characterset tileset_5:roombank=8:goto setroom5
setroom5
      clearscreen
      gosub draw_room bank15
      return otherbank

next_enemy
    attack_start=1
    ; If the next enemy is dead, move to the next and check again
    if snake_flag=0     then active_enemy=1 : selector3b_x=enemy1_x: selector3b_y=(enemy1_y)+9 : goto attack_enemies
    if bat_flag=0       then active_enemy=2 : selector3b_x=enemy2_x: selector3b_y=(enemy2_y)+9 : goto attack_enemies
    if warrior_flag=0   then active_enemy=3 : selector3b_x=enemy3_x: selector3b_y=(enemy3_y)+9 : goto attack_enemies
    if fighter_flag=0   then active_enemy=4 : selector3b_x=enemy4_x: selector3b_y=(enemy4_y)+9 : goto attack_enemies
    if knight_flag=0    then active_enemy=5 : selector3b_x=enemy5_x: selector3b_y=(enemy5_y)+9 : goto attack_enemies
    if hydra_flag=0     then active_enemy=6 : selector3b_x=enemy6_x: selector3b_y=(enemy6_y)+9 : goto attack_enemies
    if minotaur_flag=0  then active_enemy=7 : selector3b_x=enemy7_x: selector3b_y=(enemy7_y)+9 : goto attack_enemies
    if wizard_flag=0    then active_enemy=8 : selector3b_x=enemy8_x: selector3b_y=(enemy8_y)+9 : goto attack_enemies

attack_enemies

    ;rand_encounter=(rand&127) ; 11u3
    temp4=converttobcd(rand_encounter)
    if temp4>60 then attack_odds=1
    if temp4<61 then attack_odds=0

    temp3=(rand&3)
    temp1=converttobcd(temp3)   ; Initial Random Damage
    temp2=converttobcd(STR)     ; Strength Modifier
    attack_damage=converttobcd(temp1)+converttobcd(temp2)

    ; you missed, exit the subroutine
    if attack_odds=1 then goto skipmiss1
    if active_enemy=1 then enemy1_hit=0: return
    if active_enemy=2 then enemy2_hit=0: return
    if active_enemy=3 then enemy3_hit=0: return
    if active_enemy=4 then enemy4_hit=0: return
    if active_enemy=5 then enemy5_hit=0: return
    if active_enemy=6 then enemy6_hit=0: return
    if active_enemy=7 then enemy7_hit=0: return
    if active_enemy=8 then enemy8_hit=0: return
skipmiss1
    ; You registered a hit, check and reduce HP

    ; If the attack damage is higher than the enemy's hitpoints, immediate death
    if active_enemy=1 && attack_damage>=enemy1_HP then snake_flag=3     :enemy1_hit=1: goto move_selector
    if active_enemy=2 && attack_damage>=enemy2_HP then bat_flag=3       :enemy2_hit=1: goto move_selector
    if active_enemy=3 && attack_damage>=enemy3_HP then warrior_flag=3   :enemy3_hit=1: goto move_selector
    if active_enemy=4 && attack_damage>=enemy4_HP then fighter_flag=3   :enemy4_hit=1: goto move_selector
    if active_enemy=5 && attack_damage>=enemy5_HP then knight_flag=3    :enemy5_hit=1: goto move_selector
    if active_enemy=6 && attack_damage>=enemy6_HP then hydra_flag=3     :enemy6_hit=1: goto move_selector
    if active_enemy=7 && attack_damage>=enemy7_HP then minotaur_flag=3  :enemy7_hit=1: goto move_selector
    if active_enemy=8 && attack_damage>=enemy8_HP then wizard_flag=3    :enemy8_hit=1: goto move_selector
     
    temp_attack1=attack_damage
    if active_enemy=1 then dec enemy1_HP=enemy1_HP-temp_attack1:enemy1_hit=1:goto enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=2 then dec enemy2_HP=enemy2_HP-temp_attack1:enemy2_hit=1:goto enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=3 then dec enemy3_HP=enemy3_HP-temp_attack1:enemy3_hit=1:goto enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=4 then dec enemy4_HP=enemy4_HP-temp_attack1:enemy4_hit=1:goto enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=5 then dec enemy5_HP=enemy5_HP-temp_attack1:enemy5_hit=1:goto enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=6 then dec enemy6_HP=enemy6_HP-temp_attack1:enemy6_hit=1:goto enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=7 then dec enemy7_HP=enemy7_HP-temp_attack1:enemy7_hit=1:goto enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=8 then dec enemy8_HP=enemy8_HP-temp_attack1:enemy8_hit=1:goto enemy_strikes_back
    return

move_selector
    hit_odds=0 ; * remove 'you were hit' message when you move on to the next enemy
    if snake_flag=0     then selector3b_x=enemy1_x: selector3b_y=(enemy1_y)+9 :     attack_start=0:return
    if bat_flag=0       then selector3b_x=enemy2_x: selector3b_y=(enemy2_y)+9 :     attack_start=0:return
    if warrior_flag=0   then selector3b_x=enemy3_x: selector3b_y=(enemy3_y)+9 :     attack_start=0:return
    if fighter_flag=0   then selector3b_x=enemy4_x: selector3b_y=(enemy4_y)+9 :     attack_start=0:return
    if knight_flag=0    then selector3b_x=enemy5_x: selector3b_y=(enemy5_y)+9 :     attack_start=0:return
    if hydra_flag=0     then selector3b_x=enemy6_x: selector3b_y=(enemy6_y)+9 :     attack_start=0:return
    if minotaur_flag=0  then selector3b_x=enemy7_x: selector3b_y=(enemy7_y)+9 :     attack_start=0:return
    if wizard_flag=0    then selector3b_x=enemy8_x: selector3b_y=(enemy8_y)+9 :     attack_start=0:return 
    return

enemy_strikes_back
    if parry_result=1 then parry_result=0:return ; Enemy attack fails when you just selected parry 
    ;rand_encounter=(rand&127) ; 11u3
    temp4=converttobcd(rand_encounter)

    ;Damage will always be between 1-3 HP
    ;Less damage is more likely

    if temp4>20 && temp4<100 then hit_odds=1      ; -1HP             
    if temp4>99 && temp4<120 then hit_odds=5      ; -2HP          
    if temp4>119 && temp4<131 then hit_odds=7     ; -3HP            

    ; Prior to 12h, the next line included "HP=HP-temp1", which removed over 30HP at once rather than the value of temp1 a single time.  Changing to just 1 worked.

    if hit_odds=1 && HP>0 then hit_odds=0:dec HP=HP-1:hit_odds=9
    if hit_odds=1 && HP<2 then hit_odds=0:dec HP=0:death_flag=1

    if hit_odds=5 && HP>1 then hit_odds=0:dec HP=HP-2:hit_odds=9
    if hit_odds=5 && HP<3 then hit_odds=0:dec HP=0:death_flag=1
    
    if hit_odds=7 && HP>2 then hit_odds=0:dec HP=HP-3:hit_odds=9
    if hit_odds=7 && HP<4 then hit_odds=0:dec HP=0:death_flag=1

    ; A clearscreen, redraw, and savescreen is necessary in order to update the plotvalues without glitches.
    ; I added the red screen to indicate that you've been hit, it worked out pretty well, as the flash is now red. :D
    if hit_odds=9 then BACKGRND=$40: room=129:clearscreen:gosub draw_room bank15:savescreen:BACKGRND=$00

    return

parry_check
    ;rand_encounter=(rand&127)      ; 11u3
    temp4=converttobcd(rand_encounter)
    ;Defensive Move - reduce chances of a hit on the next round
    if temp4>60 then parry_result=1 ; Defense Enanced
    if temp4<61 then parry_result=2 ; Failed attempt
    return

run_check
    ;rand_encounter2=(rand&127)      ; 11u3
    temp4=converttobcd(rand_encounter2)
    ;Run away from a fight.  Running away opens you up to an attack.
    gosub enemy_strikes_back
    if temp4>120 then run_result=1 ; you ran away
    if temp4<121 then run_result=2 ; you're stuck
    return

get_gold
    ;Adds gold and XP after killing all enemies
    temp1=(rand&3)+1:temp2=(rand&7)+1:temp3=(rand&15)+1:temp4=(rand&31)+5:temp5=(rand&63)+12
    if Level<7              then gold_found=converttobcd(temp1)        
    if Level>6  && Level<10 then gold_found=converttobcd(temp2)
    if Level>9  && Level<16 then gold_found=converttobcd(temp3)
    if Level>15 && Level<26 then gold_found=converttobcd(temp4)
    if Level>25             then gold_found=converttobcd(temp5)
    dec score0=score0+gold_found
    check_gold=1
    return

b9drawscreen
   ;╭──═◙ Bank 9 Drawscreen ◙═──────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
    drawscreen
    if hit_odds=9 then hit_odds=0:restorescreen
    ; Random Number generation removed from subroutines in 11u3, moved here for testing.
    ; Original locations commented with 11u3
    rand_encounter=(rand&127)
    rand_encounter2=(rand&127)
    ;low_damage=(rand&7)
    ;mid_damage=(rand&31)
    if snake_flag=3 && bat_flag=3 && warrior_flag=3 && fighter_flag=3 && knight_flag=3 && hydra_flag=3 && minotaur_flag=3 && wizard_flag=3 then total_enemies=0
   ;╭──═◙ Joystick Movement & Firing Debounce ◙═────────────────────────────────────────────────────╮
      if joy0fire1 then debounce2=9                       ;Left Button
      if !joy0fire1 && debounce2=9 then debounce2=5
      if joy0fire0 then debounce=9                        ;Right Button
      if !joy0fire0 && debounce=9 then debounce=5
      if joy0up then joyupdebounce=9
      if !joy0up && joyupdebounce=9 then joyupdebounce=5
      if joy0down then joydowndebounce=9
      if !joy0down && joydowndebounce=9 then joydowndebounce=5
      if joy0right then joyrightdebounce=9
      if !joy0right && joyrightdebounce=9 then joyrightdebounce=5
      if joy0left then joyleftdebounce=9
      if !joy0left && joyleftdebounce=9 then joyleftdebounce=5
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
   ;╭──═◙ Shows the current HP of the active enemy ◙═───────────────────────────────────────────────╮
      if active_enemy=1 then enemy_HP=enemy1_HP
      if active_enemy=2 then enemy_HP=enemy2_HP
      if active_enemy=3 then enemy_HP=enemy3_HP 
      if active_enemy=4 then enemy_HP=enemy4_HP
      if active_enemy=5 then enemy_HP=enemy5_HP 
      if active_enemy=6 then enemy_HP=enemy6_HP
      if active_enemy=7 then enemy_HP=enemy7_HP
      if active_enemy=8 then enemy_HP=enemy8_HP
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
   ;╭──═◙ Displays amount of damage to enemy ◙═─────────────────────────────────────────────────────╮
      if enemy1_hit=0 && active_enemy=1 then attack_damage=$00
      if enemy2_hit=0 && active_enemy=2 then attack_damage=$00
      if enemy3_hit=0 && active_enemy=3 then attack_damage=$00
      if enemy4_hit=0 && active_enemy=4 then attack_damage=$00
      if enemy5_hit=0 && active_enemy=5 then attack_damage=$00
      if enemy6_hit=0 && active_enemy=6 then attack_damage=$00
      if enemy7_hit=0 && active_enemy=7 then attack_damage=$00
      if enemy8_hit=0 && active_enemy=8 then attack_damage=$00
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
      ;if total_enemies=0 then goto skipdisplay6     
      ;plotsprite herodown2  0 78 158  
skipdisplay6


    ; ──═◙ Status Bar ◙═──────────────────────────────────────────────────────────────────────────────
      plotvalue tileset_attack2 3 HP    2 19 12  :  plotvalue tileset_attack2 3 HPMax   2 39 12
      plotvalue tileset_attack2 3 mana   2 19 13  :  plotvalue tileset_attack2 3 manamax 2 39 13
      plotvalue tileset_attack2 3 score0 6 106 12

     drawwait 
     return otherbank

health_increase
     ; One Potion gives you 10HP
     HP=HPMax:return
     temp1=converttobcd(HPMax)+$10
     if HP+$10=temp1 then HP=HPMax:return       ; If current HP + 10 equals the maximum, set HP to max and return
     if HP+$10>temp1 then HP=HPMax:return       ; If current HP + 10 is greater than the Maximum, set HP to max and return
     if HP+$10<temp1 then dec HP=HP+$10:return  ; If current HP + 10 is less than the maximum, add 10 to your HP and return
     return

 alphachars ' abcdefghijklmnopqrstuvwxyzABCDEF' 

 alphadata statusbar9 tileset_attack2
 'wjzzkzzlpqrstzzzzzzx'
 'umnyoyyABCDEyyyyyyyv'
end
                                                                                                             /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 10 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                              */ 
 bank 10 

   ;  marketplaces

   ;╭──═◙ Bank 10 Graphics ◙═───────────────────────────────────────────────────────────────────────╮
    incgraphic tileset_blank.png 160A 0 1 2 3 1
    incgraphic tileset_6.png 160A 0 1 2 3 1
    incgraphic tileset_7_market.png 160A 0 1 2 3 1
      ;incgraphic icon_potion.png
      ;incgraphic icon_sword.png
      ;incgraphic icon_armor.png
      ;incgraphic icon_ring.png
      ;incgraphic icon_key.png
      ;incgraphic icon_shield.png
    incmapfile marketplace.tmx
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

 alphadata statusbar10 tileset_6
 'wjzzkzzlpqrstzzzzzzx'
 'umnyoyyABCDEyyyyyyyv'
end

beginmarketplace
      market_x=12:market_y=32
restartmarketplace
    BACKGRND=$00  
    clearscreen
    plotmap  marketplace  6  0   0    20   12 
    plotmap  statusbar10  6  0   12   20   2   
    ;plotvalue tileset_6   3 score0 6 104 13
    savescreen

   ;╭──═◙ Initialize Variables ◙═───────────────────────────────────────────────────────────────────╮
      debounce=0

      ;Health potion  $120
      ;Mana potion    $160
      ;armor          $1250
      ;sword          $1750
      ;ring           $2675
      ;shield         $1950

      hpotion_cost_Med=$01: mpotion_cost_Med=$01:armor_cost_Med=$12:sword_cost_Med=$17:ring_cost_Med=$26:shield_cost_Med=$19
      hpotion_cost_Lo =$20: mpotion_cost_Lo =$60:armor_cost_Lo =$50:sword_cost_Lo =$50:ring_cost_Lo =$75:shield_cost_Lo =$50
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
marketplacetext
    restorescreen
   ;╭──═◙ Return to Game ◙═─────────────────────────────────────────────────────────────────────────╮
      if joy0fire1 then debounce=2
      if !joy0fire1 && debounce=2 then debounce=7
      if debounce=7 then debounce=0:clearscreen:goto marketplaceexit
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Cursor U/D Movement ◙═────────────────────────────────────────────────────────────────────╮
      ; Y Values | 32 | 64 | 96 | 128 | 160
      
      if joy0up then upcheck=2
      if !joy0up && upcheck=2 then upcheck=7
      if upcheck=7 then upcheck=0:market_y=market_y-32

      if joy0down then downcheck=2
      if !joy0down && downcheck=2 then downcheck=7
      if downcheck=7 then downcheck=0:market_y=market_y+32

      if market_y<32 then market_y=32
      if market_y>160 then market_y=160
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

      ;Health potion  $120
      ;Mana potion    $160
      ;armor          $1250
      ;sword          $1750
      ;ring           $2675
      ;shield         $1950

BuyHealthPotion
      if hpotion_val>$98 then goto skiphpotion
      if market_y<>32 then goto skiphpotion
      if GoldMed>=hpotion_cost_Med then goto CheckOk1
      if GoldMed<hpotion_cost_Med then goto skiphpotion
      if GoldLo<hpotion_cost_Lo then skiphpotion
CheckOk1
      if joy0right then rightcheck=2
      if !joy0right && rightcheck=2 then rightcheck=7
      if rightcheck=7 then rightcheck=0:dec hpotion_val=hpotion_val+$01:dec GoldMed=GoldMed-$01:dec GoldLo=GoldLo-$20:goto restartmarketplace
skiphpotion

BuyManaPotion
      if mpotion_val>$98 then goto skipmpotion
      if market_y<>64 then goto skipmpotion
      if GoldMed>=mpotion_cost_Med then goto CheckOk2
      if GoldMed<mpotion_cost_Med then goto skipmpotion
      if GoldLo<mpotion_cost_Lo then skipmpotion
CheckOk2
      if joy0right then rightcheck=2
      if !joy0right && rightcheck=2 then rightcheck=7
      if rightcheck=7 then rightcheck=0:dec mpotion_val=mpotion_val+$01:dec GoldMed=GoldMed-$01:dec GoldLo=GoldLo-$60:goto restartmarketplace
skipmpotion

BuyArmor
      if armor_val>$98 then goto skiparmor
      if market_y<>96 then goto skiparmor
      if GoldMed>=armor_cost_Med then goto CheckOk3
      if GoldMed<armor_cost_Med then goto skiparmor
      if GoldLo<armor_cost_Lo then skiparmor
CheckOk3
      if joy0right then rightcheck=2
      if !joy0right && rightcheck=2 then rightcheck=7
      if rightcheck=7 then rightcheck=0:dec armor_val=armor_val+$01:dec GoldMed=GoldMed-$12:dec GoldLo=GoldLo-$50:goto restartmarketplace
skiparmor

Buysword
      if sword_val>$98 then goto skipsword
      if market_y<>128 then goto skipsword
      if GoldMed>=sword_cost_Med then goto CheckOk4
      if GoldMed<sword_cost_Med then goto skipsword
      if GoldLo<sword_cost_Lo then skipsword
CheckOk4
      if joy0right then rightcheck=2
      if !joy0right && rightcheck=2 then rightcheck=7
      if rightcheck=7 then rightcheck=0:dec sword_val=sword_val+$01:dec GoldMed=GoldMed-$17:dec GoldLo=GoldLo-$50:goto restartmarketplace
skipsword

Buyring
      if ring_val>$98 then goto skipring
      if market_y<>160 then goto skipring
      if GoldMed>=ring_cost_Med then goto CheckOk5
      if GoldMed<ring_cost_Med then goto skipring
      if GoldLo<ring_cost_Lo then skipring
CheckOk5
      if joy0right then rightcheck=2
      if !joy0right && rightcheck=2 then rightcheck=7
      if rightcheck=7 then rightcheck=0:dec ring_val=ring_val+$01:dec GoldMed=GoldMed-$26:dec GoldLo=GoldLo-$75:goto restartmarketplace
skipring

      ; Plot Menu Icon
      plotsprite arrowblock    1 market_x market_y

      ;Plot Item Icons
      plotsprite icon_potion   5 16 28
      plotsprite icon_potion   4 16 60
      plotsprite icon_armor    7 16 92
      plotsprite icon_sword    7 16 124
      plotsprite icon_ring     7 16 156
      ;plotsprite icon_shield  7 16 156

      ; Plot Item Costs
      plotvalue tileset_6 5 hpotion_cost_Med 2 58 1:plotvalue tileset_6 5 hpotion_cost_Lo 2 74 1
      plotvalue tileset_6 4 mpotion_cost_Med 2 58 3:plotvalue tileset_6 4 mpotion_cost_Lo 2 74 3
      plotvalue tileset_6 5 armor_cost_Med   2 58 5:plotvalue tileset_6 5 armor_cost_Lo   2 74 5
      plotvalue tileset_6 5 sword_cost_Med   2 58 7:plotvalue tileset_6 5 sword_cost_Lo   2 74 7
      plotvalue tileset_6 5 ring_cost_Med    2 58 9:plotvalue tileset_6 5 ring_cost_Lo    2 74 9

      ; Plot Quantity to Purchase
      plotvalue tileset_6 5 hpotion_val      2 133 1
      plotvalue tileset_6 4 mpotion_val      2 133 3
      plotvalue tileset_6 5 armor_val        2 133 5
      plotvalue tileset_6 5 sword_val        2 133 7
      plotvalue tileset_6 5 ring_val         2 133 9


   ;╭──═◙ Common Bottom Status Bar ◙═───────────────────────────────────────────────────────────────╮
      plotvalue tileset_attack2 3 HP    2 19 12  :  plotvalue tileset_attack2 3 HPMax   2 39 12
      plotvalue tileset_attack2 3 mana   2 19 13  :  plotvalue tileset_attack2 3 manamax 2 39 13
      plotvalue tileset_attack2 3 score0 6 106 12
      plotsprite swordfire 5 200 200
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
    drawscreen
    goto marketplacetext
marketplaceexit
      if room<64              then characterset tileset_1:roombank=6:clearscreen:gosub draw_room bank15:goto marketplaceexit2
      if room>63  && room<128 then characterset tileset_1:roombank=6:clearscreen:gosub draw_room bank15:goto marketplaceexit2
      if room>127 && room<192 then characterset tileset_5:roombank=7:clearscreen:gosub draw_room bank15:goto marketplaceexit2
      if room>191             then characterset tileset_5:roombank=8:clearscreen:gosub draw_room bank15:goto marketplaceexit2
marketplaceexit2
      ;marketplace=0:debounce=0:debounce2=0
      return otherbank

b10drawscreen
   ;╭──═◙ Bank 10 Drawscreen ◙═─────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
     drawscreen
     drawwait 
     return otherbank
                                                                                                               /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 11 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                               */ 
 bank 11 

  ; Title - Custom Tilesets for Title Screen

;╭──═◙ Bank 11 Graphics ◙═───────────────────────────────────────────────────────────────────────╮
    ;incgraphic titlescreen.png 160A 7 0 1 2 3
    incgraphic titlescreen2a.png
    incgraphic titlescreen2b.png
    incgraphic titlescreen2c.png
    incgraphic titlescreen2d.png
    incgraphic tileset_title2.png 
    incgraphic tileset_title3.png 
    incgraphic tileset_title5.png 
    incgraphic titletext.png
    incgraphic spinner1.png
    incgraphic spinner2.png
    incgraphic spinner3.png
    incgraphic spinner4.png
  ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

 alphachars ' abcdefghijklmnopqrstuvwxyzABCDEF' 

 alphadata statusbar11 tileset_title3
 'llllllllmaaaiiilllll'
 'hhhhhhhhhhhhhhhhhhhh'
end

titleloop
     lastroom=room
     room=141:clearscreen:gosub draw_room bank15
     savescreen
     count1=0:count2=0:count3=0:count4=0
     P3C1=$82:P3C2=$83:P3C3=$85
     P2C1=$80:P2C2=$84:P2C3=$84

titletext
    count1=count1+1
    count3=count3+1
    if count1>15 then count2=count2+1:count1=0
    if count2>3 then count2=0
    if count3>30 then count4=count4+1:count3=0
    if count4>5 then count4=0
    restorescreen

    ;╭──═◙ Move Cursor on Main Menu ◙═───────────────────────────────────────────────────────────────╮
      if titleypos<142 then titleypos=142
      if titleypos>164 then titleypos=164

      if joy0up then upcheck=2
      if !joy0up && upcheck=2 then upcheck=7
      if upcheck=7 && titleypos=153 then titleypos=142: upcheck=0
      if upcheck=7 && titleypos=164 then titleypos=153: upcheck=0

      if joy0down then downcheck=2
      if !joy0down && downcheck=2 then downcheck=7
      if downcheck=7 && titleypos=142 then titleypos=153:downcheck=0
      if downcheck=7 && titleypos=153 then titleypos=164:downcheck=0
    ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

      if titleypos=142 && joy0fire then gosub status_load_game bank1:status_active=0:clearscreen:goto titleloopload
      if titleypos=153 && joy0fire then gosub status_erase_game bank1
      if titleypos=164 && joy0fire then clearscreen:goto titleloopchange

    ;╭──═◙ Plot Graphics ◙═──────────────────────────────────────────────────────────────────────────╮
      plotsprite eyes 5 64 100 count4
      plotsprite steveengelhardt 3 16 206
      plotsprite titletext 4 18 60
      plotsprite spinner1 5 titlexpos titleypos count2
      plotsprite wave1 2 0 127 count4
      plotsprite wave1 2 8 127 count4
      plotsprite wave1 2 16 127 count4
      plotsprite wave1 2 32 143 count4
      plotsprite wave1 2 64 192 count4
      plotsprite wave1 2 72 192 count4
      plotsprite wave1 2 80 192 count4
      plotsprite wave1 2 88 192 count4
      plotsprite wave1 2 96 191 count4
      plotsprite wave1 2 104 190 count4
      plotsprite wave1 2 112 189 count4
      plotsprite wave1 2 120 188 count4
      plotsprite wave1 2 128 187 count4
      plotsprite wave1 2 136 186 count4
      plotsprite wave1 2 144 185 count4
      plotsprite wave1 2 152 184 count4
    ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

    drawscreen
    goto titletext

titleloopchange
      ; Reset Palettes back to the default
       P1C1=$F1   :  P2C1=$80  :  P3C1=$1C  :  P4C1=$90  :  P5C1=$42  :  P6C1=$C6  :  P7C1=$E0
       P1C2=$F3   :  P2C2=$86  :  P3C2=$34  :  P4C2=$98  :  P5C2=$46  :  P6C2=$C4  :  P7C2=$08
       P1C3=$C0   :  P2C3=$F2  :  P3C3=$3A  :  P4C3=$0F  :  P5C3=$FF  :  P6C3=$F2  :  P7C3=$04
      room=lastroom
      if room<64              then characterset tileset_1:roombank=6:goto setroom8  
      if room>63  && room<128 then characterset tileset_1:roombank=6:goto setroom8
      if room>127 && room<192 then characterset tileset_5:roombank=7:goto setroom8
      if room>191             then characterset tileset_5:roombank=8:goto setroom8
setroom8
      ;debounce=0
      clearscreen
      gosub draw_room bank15
      return otherbank

titleloopload
      ; Reset Palettes back to the default
       P1C1=$F1   :  P2C1=$80  :  P3C1=$1C  :  P4C1=$90  :  P5C1=$42  :  P6C1=$C6  :  P7C1=$E0
       P1C2=$F3   :  P2C2=$86  :  P3C2=$34  :  P4C2=$98  :  P5C2=$46  :  P6C2=$C4  :  P7C2=$08
       P1C3=$C0   :  P2C3=$F2  :  P3C3=$3A  :  P4C3=$0F  :  P5C3=$FF  :  P6C3=$F2  :  P7C3=$04
      room=lastroom
      if room<64              then characterset tileset_1:roombank=6:goto setroomload 
      if room>63  && room<128 then characterset tileset_1:roombank=6:goto setroomload
      if room>127 && room<192 then characterset tileset_5:roombank=7:goto setroomload
      if room>191             then characterset tileset_5:roombank=8:goto setroomload
setroomload
      ;debounce=0
      clearscreen
      gosub draw_room bank15
      return otherbank
  
b11drawscreen
   ;╭──═◙ Bank 11 Drawscreen ◙═─────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
     drawscreen
     drawwait 
     return otherbank


                                                                  
                                                                                                              /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 12 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                              */ 
 bank 12 

  ; Town Tilesets - Messages

  ; Beckwourth
  ; Renick
  ; Faulkton
  ; Kaktovik
  ; Stratford
  ; Welbeck
  ; Masham
  ; Tattershall
  ; Taunton
  ; Bledknot

  ;╭──═◙ Bank 12 Graphics ◙═───────────────────────────────────────────────────────────────────────╮
    incgraphic tileset_text.png 160A 0 1 2 3 1
    incgraphic tileset_6.png 160A 0 1 2 3 1
    incmapfile tattershall.tmx
    incmapfile beckwourth.tmx
    incmapfile mountaingrove.tmx
    incmapfile wanderer.tmx
    incmapfile welbeck.tmx
    incmapfile goodluck.tmx
    incmapfile ugutz_text.tmx
    incmapfile glorycrystal.tmx
    incmapfile bledknot1.tmx
    incmapfile bledknot2.tmx
    incmapfile couragecrystal.tmx
    incmapfile werd.tmx
    incmapfile virtuecrystal.tmx
    incmapfile werd2.tmx
    incmapfile wisdomcrystal.tmx
    incmapfile grimold.tmx
    incmapfile trustcrystal.tmx
    incmapfile loyaltycrystal.tmx
    incmapfile wrathcrystal.tmx
    incmapfile rodoflife_text.tmx
    incmapfile welbeck2.tmx
    incmapfile denied.tmx
    incmapfile quote1.tmx
  ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

 alphachars ' abcdefghijklmnopqrstuvwxyzABCDEF' 

 alphadata statusbar12 tileset_6
 'wjzzkzzlpqrstzzzzzzx'
 'umnyoyyABCDEyyyyyyyv'
end

town1
    BACKGRND=$00  
    clearscreen
    if room=178 then plotmap  beckwourth     6  0   0    20   12    ; City of Beckwourth Welcome Sign
    if room=186 then plotmap  tattershall    6  0   0    20   12    ; City of Tattershall Welcome Sign
    if room=190 || room=181 then plotmap  quote1         6  0   0    20   12    ; "Great crisis produce great men and great deeds of courage."
    if room=137 then plotmap  mountaingrove  6  0   0    20   12    ; "In the heart of the midlothian forest lies the rod of life.  Use my sword wisely, it's magic will light your way.  He knows not his own strength that hath not met adversity!".
    if room=150 then plotmap  wanderer       6  0   0    20   12    ; "Ugutz always speaks of lost glory in the Desert"
    if room=195 then plotmap  glorycrystal   6  0   0    20   12    ; "The crystal of glory is yours. A crown is no cure for a headache in the heat of the sun". 
    if room=207 then plotmap  couragecrystal 6  0   0    20   12    ; "You hear a voice... Nearly all men can stand adversity, to test a man's character, give him power. Seek Werd Sephmond of the great lakes of Chetfast for the path to Virtue. You now posess the crystal of courage."
    if room=140 then plotmap  grimold        6  0   0    20   12    ; "Men trust their ears less than their eyes.  Use this key to bear witness to trust in it's truest form, and restore my faith in the spirit of Midlothia."
    if room=205 then plotmap  trustcrystal   6  0   0    20   12    ; "You hear a voice... Put more trust in nobility of character than in an oath, young Azemar.  You now posess the crystal of trust.  Search the southern waters to prove your loyalty"
    if room=208 then plotmap  loyaltycrystal 6  0   0    20   12    ; "Loyalty to an unjust cause is a perversion of honor. Nonnag of Silverpeak must be stopped. Crush his wrath and restore order.  Your virtue has opened the path."
    if room=248 then plotmap  wrathcrystal   6  0   0    20   12    ; "Those who don't know the value of loyalty can never appreciate the cost of betrayal.  Take the Crystal of Wrath to King Thoswith... "  

    ; Access Denied to Dungeon Entrances
    if room=0   || room=55  then plotmap  denied    6  0   0    20   12    ; "Only those of greater virtue may pass"
    if room=127 || room=15  then plotmap  denied    6  0   0    20   12    ; "Only those of greater virtue may pass"
    if room=50  || room=113 then plotmap  denied    6  0   0    20   12    ; "Only those of greater virtue may pass"

    ; Crystals in Order of Discovery
    ; Glory   1 Katkovik
    ; Courage 6 Ravensworth Keep
    ; Virtue  7 Moutain Grove Forest
    ; Wisdom  4 Hagan
    ; Trust   5 Renick
    ; Loyalty 2 Faulkton
    ; Wrath   3 Nonnag  

    ; Wisdom Crystal (4)
    if room=200  then plotmap  wisdomcrystal  6  0   0    20   12    ; "Loyalty and devotion lead to bravery. Bravery leads to the spirit of self-sacrifice. The spirit of self-sacrifice creates trust.  You now posess the Crystal of Wisdom.  Trust walks in the path to Tattershall."

    ; Virtue  Crystal (7)
    ; If you find the virtue crystal before talking to Werd, you won't see the clue, but it still unlocks the dungeon for the crystal of wisdom.
    if room=128 then sephmond=1: plotmap virtuecrystal  6  0   0    20   12    ; "Your soul alights with the flame of virtue.  The key to wisdom is but a loch in Chetfast."

    ; Werd Sephmond of Lake Chetfast
    ;     if [crystal7_flag=0] then "search for it" message.
    ;     if [crystal7_flag=1] (you found the virtue crystal) then you are given a key for the dungeon in Hagan, where the wisdom crystal resides.
    ;     if [crystal7_flag=1] 
    if room=175 && crystal4_flag=1 then plotmap  goodluck            6  0   0    20   12  :goto skipwerd  ; "May the light of virtue always define your path."
    if room=175 && crystal7_flag=0 then plotmap  werd                6  0   0    20   12                  ; "I knew someday you would arrive seeking the path to virtue. I.. I.. It's... My last memory is of a stroll through the north woods"
    if room=175 && crystal7_flag=1 then sephmond=1:plotmap  werd2    6  0   0    20   12                  ; "The superior man thinks always of virtue, the common man thinks of comfort.  Take this key to unlock the path to wisdom, in the halls of gold and brown."
skipwerd

    ; King Karles Derame in Castle Bledknot
    ;     If you don't have the Crystal of Glory (1), begone. 
    ;     If you have it, find south mountain dungeon and get the Crystal of Courage (6). 
    ;     If you have that, you get a nice quote.
    if room=158 && crystal6_flag=1 then plotmap  goodluck            6  0   0    20   12 :goto skipderame   ; "May the light of virtue always define your path."
    if room=158 && crystal1_flag=0 then plotmap  bledknot1           6  0   0    20   12                    ; "Begone mortal! Thou must return when you are worthy of my prescence!" 
    if room=158 && crystal1_flag=1 then derame=1:plotmap  bledknot2  6  0   0    20   12                    ; "Ah, Azemar. Courage is not the absence of fear, it is the conquest of it.  Take this key and seek the true path to Courage, as the raven flies south." 
skipderame

    ; Ugutz 
    ;     If you do not have the Crystal of Glory (crystal 1), then you get a key.  
    ;     If you have the crystal, you get an insipring quote. :)
    if room=147 && crystal1_flag=0 then key=1:ugutz=1:plotmap  ugutz_text  6  0   0    20   12    ; "Brave men go forward not expecting to return. If it is gloary you seek, use this key wisely, Azemar, and take the north mountain pass to Kaktovik. There will you find the honor you desire."  
    if room=147 && crystal1_flag=1 then       plotmap  goodluck            6  0   0    20   12    ; "May the light of virtue always define your path."

    ; King Roswil Thoswith in Welbeck 
    ; If you do not have 200 gold, you get a message that you need it. 
    ; If you have 200 gold, it's deducted and you get the rod of life. 
    ; If you have the rod but not the wrath crystal, you get a nice quote. 
    ; if crystal3_flag is 1 (wrath crystal), then you have defeated nonnag.
    if room=183 && crystal3_flag=1 && rodoflife=1 then plotmap  rodoflife_text 6  0   0    20   12 :goto skiptheking   ; "All the gold which is under or upon the earth is not enough to give in exchange for virtue.  With this completed rod of life, may your nobility be a light to all in Midlothia...  King Azemar."
    if room=183 && rodoflife=1 then plotmap goodluck 6  0   0    20   12                           :goto skiptheking   ; "May the light of virtue always define your path."
    if room=183 && GoldMed<$02 && rodoflife=0 then plotmap welbeck  6  0   0    20   12            :goto skiptheking   ; "Young Azemar, 'Tis better to be fortunate than wise! For the kingly sum of 200 gold I shall present thee with the rod of Life."
    if room=183 && GoldMed>$01 && rodoflife=0 then rodoflife=1: dec GoldMed=GoldMed-$02: plotmap  welbeck2  6  0   0    20   12    ; "Take this rod of life, may it someday be wielded by the vanquisher of evil in this land, a noble man worthy of my crown."
skiptheking

    plotmap  statusbar12  6  0   12   20   2   
    plotvalue tileset_6   3 score0 6 104  13
    savescreen

   ;╭──═◙ Initialize Variables ◙═───────────────────────────────────────────────────────────────────╮
      debounce=0
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

town1text
    restorescreen
   ;╭──═◙ Return to Game ◙═─────────────────────────────────────────────────────────────────────────╮
      if joy0fire1 then debounce=2
      if !joy0fire1 && debounce=2 then debounce=7
      if debounce=7 then debounce=0:clearscreen:goto town1exit
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
   ;╭──═◙ Common Bottom Status Bar ◙═───────────────────────────────────────────────────────────────╮
      plotvalue tileset_attack2 3 HP    2 19 12  :  plotvalue tileset_attack2 3 HPMax   2 39 12
      plotvalue tileset_attack2 3 mana   2 19 13  :  plotvalue tileset_attack2 3 manamax 2 39 13
      plotvalue tileset_attack2 3 score0 6 106 12
      plotsprite swordfire 5 200 200
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
    drawscreen
    goto town1text
town1exit
      clearscreen
      if room<64              then characterset tileset_1:roombank=6:gosub draw_room bank15:goto town1exit2
      if room>63  && room<128 then characterset tileset_1:roombank=6:gosub draw_room bank15:goto town1exit2
      if room>127 && room<192 then characterset tileset_5:roombank=7:gosub draw_room bank15:goto town1exit2
      if room>191             then characterset tileset_5:roombank=8:gosub draw_room bank15:goto town1exit2
town1exit2
      return otherbank

b12drawscreen
   ;╭──═◙ Bank 12 Drawscreen ◙═─────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
     drawscreen
     drawwait 
     return otherbank

                                                                                                              /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 13 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                              */ 
 bank 13 

 ; Status Screen - Custom Tilesets for Status Screen

   ;╭──═◙ Bank 13 Graphics ◙═───────────────────────────────────────────────────────────────────────╮
     incgraphic tileset_status1.png 160A 0 1 2 3 1
     incgraphic tileset_status2.png 160A 0 1 2 3 1
     incgraphic tileset_status3.png 160A 0 1 2 3 1
     incgraphic tileset_status4.png 160A 0 1 2 3 1
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

 alphachars ' abcdefghijklmnopqrstuvwxyzABCDEF' 

 alphadata statusbar13 tileset_status2
 'wjzzkzzlpqrstzzzzzzx'
 'umnyoyyABCDEyyyyyyyv'
end

changetileram_bank13
  temp2=142
      screenram[temp2]=temproomlo[[temp2]]
  return otherbank

statusscreen

     ; ** add stat modifier points based on your level that you can spend on INT, WIS, DEX, VIT.
     status_menu=1
     status_active=1
     upcheck=0
     downcheck=0
     rightcheck=0
     leftcheck=0
     statusmenu_x=51:statusmenu_y=180
     status_menu=1
     debounce=0:debounce2=0
     lastroom=room
     room=142:clearscreen:gosub draw_room bank15
     savescreen
   ;╭──═◙ Initialize Variables ◙═───────────────────────────────────────────────────────────────────╮
      debounce=0:debounce2=0
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

   ; Checking the Status Screen is what actually levels you up.  It will verify XP and adjust level.

   ; XPGain_Lo
   ; lvl  XP_Gained  
   ; ---  ---------
   ; <3   03    
   ; <7   19       
   ; <10  47       
   ; <16  69       
   ; <26  101
   ; >25  121

   ; XP needed to Level Up
   ; lvl  XP     Req to get there
   ; ---  ---    ----------------------------
   ; 2    30     10 battles to get to level 2
   ; 3    80
   ; 
   ; 6    400    21 more battles to get to level 6
   ; 7    600
   ; 
   ; 9    1100   23 more battles to get to level 9
   ; 10   1400
   ; 
   ; 15   3100   44 more battles to get to level 15
   ; 16   3500
   ; 
   ; 25   7700   76 more battles to get to level 25
   ; 26   8200
   ;
   ; Right now, it takes about 174 battles to get to level 25 where you fight the max # of enemies.


   ;╭──═◙ Level up ◙═──────────────────────────────────────────────────────────────────────────────═■
      if XPHi=$00 && XPMed=$00 && XPLo<$20 then LevelHi=$00:LevelMed=$00:LevelLo=$01
      if XPHi=$00 && XPMed=$00 && XPLo>$30 then LevelHi=$00:LevelMed=$00:LevelLo=$02
      if XPHi=$00 && XPMed=$00 && XPLo>$80 then LevelHi=$00:LevelMed=$00:LevelLo=$03
      if XPHi=$00 && XPMed>$02 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$04
      if XPHi=$00 && XPMed>$03 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$05
      if XPHi=$00 && XPMed>$04 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$06
      if XPHi=$00 && XPMed>$06 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$07
      if XPHi=$00 && XPMed>$08 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$08
      if XPHi=$00 && XPMed>$11 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$09
      if XPHi=$00 && XPMed>$14 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$10
      if XPHi=$00 && XPMed>$17 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$11
      if XPHi=$00 && XPMed>$20 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$12
      if XPHi=$00 && XPMed>$23 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$13
      if XPHi=$00 && XPMed>$27 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$14
      if XPHi=$00 && XPMed>$31 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$15
      if XPHi=$00 && XPMed>$35 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$16
      if XPHi=$00 && XPMed>$39 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$17
      if XPHi=$00 && XPMed>$43 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$18
      if XPHi=$00 && XPMed>$47 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$19
      if XPHi=$00 && XPMed>$52 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$20
      if XPHi=$00 && XPMed>$57 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$21
      if XPHi=$00 && XPMed>$62 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$22
      if XPHi=$00 && XPMed>$67 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$23
      if XPHi=$00 && XPMed>$72 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$24
      if XPHi=$00 && XPMed>$77 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$25
      if XPHi=$00 && XPMed>$82 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$26
      if XPHi=$00 && XPMed>$88 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$27
      if XPHi=$00 && XPMed>$94 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$28
      if XPHi=$00 && XPMed>$99 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$29
      if XPHi>$01 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$30
      if XPHi>$02 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$31
      if XPHi>$03 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$32
      if XPHi>$04 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$33
      if XPHi>$05 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$34
      if XPHi>$06 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$35
      if XPHi>$07 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$36
      if XPHi>$08 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$37
      if XPHi>$09 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$38
      if XPHi>$10 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$39
      if XPHi>$11 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$40
      if XPHi>$12 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$41
      if XPHi>$13 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$42
      if XPHi>$14 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$43
      if XPHi>$15 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$44
      if XPHi>$16 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$45
      if XPHi>$17 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$46
      if XPHi>$18 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$47
      if XPHi>$19 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$48
      if XPHi>$20 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$49
      if XPHi>$21 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$50
      if XPHi>$22 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$51
      if XPHi>$23 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$52
      if XPHi>$24 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$53
      if XPHi>$25 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$54
      if XPHi>$26 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$55
      if XPHi>$27 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$56
      if XPHi>$28 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$57
      if XPHi>$29 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$58
      if XPHi>$30 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$59
      if XPHi>$31 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$60
      if XPHi>$32 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$61
      if XPHi>$33 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$62
      if XPHi>$34 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$63
      if XPHi>$35 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$64
      if XPHi>$36 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$65
      if XPHi>$37 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$66
      if XPHi>$38 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$67
      if XPHi>$39 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$68
      if XPHi>$40 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$69
      if XPHi>$41 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$70
      if XPHi>$42 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$71
      if XPHi>$43 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$72
      if XPHi>$44 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$73
      if XPHi>$45 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$74
      if XPHi>$46 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$75
      if XPHi>$47 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$76
      if XPHi>$48 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$77
      if XPHi>$49 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$78
      if XPHi>$50 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$79
      if XPHi>$51 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$80
      if XPHi>$52 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$81
      if XPHi>$53 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$82
      if XPHi>$54 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$83
      if XPHi>$55 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$84
      if XPHi>$56 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$85
      if XPHi>$58 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$80
      if XPHi>$60 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$81
      if XPHi>$62 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$82
      if XPHi>$64 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$83
      if XPHi>$66 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$84
      if XPHi>$68 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$85
      if XPHi>$70 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$86
      if XPHi>$72 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$87
      if XPHi>$74 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$88
      if XPHi>$76 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$89
      if XPHi>$78 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$90
      if XPHi>$80 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$91
      if XPHi>$82 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$92
      if XPHi>$84 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$93
      if XPHi>$86 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$94
      if XPHi>$88 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$95
      if XPHi>$90 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$96
      if XPHi>$92 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$97
      if XPHi>$94 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$98
      if XPHi>$98 && XPMed>$00 && XPLo>$00 then LevelHi=$00:LevelMed=$00:LevelLo=$99
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

statusscreenloop

   ;╭──═◙ Return to Game ◙═─────────────────────────────────────────────────────────────────────────╮
      if joy0fire0 then debounce=2
      if !joy0fire0 && debounce=2 then debounce=7
      if debounce=7 then debounce=0:status_active=0:goto statusreturn
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
   ;╭──═◙ Debounce ◙═───────────────────────────────────────────────────────────────────────────────╮
      if joy0fire1 then debounce2=9
      if !joy0fire1 && debounce2=9 then debounce2=5
      if joy0left then leftcheck=2
      if !joy0left && leftcheck=2 then leftcheck=7
      if joy0right then rightcheck=2
      if !joy0right && rightcheck=2 then rightcheck=7
      if joy0up then upcheck=2
      if !joy0up && upcheck=2 then upcheck=7
      if joy0down then downcheck=2
      if !joy0down && downcheck=2 then downcheck=7
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
   ;╭──═◙ Misc ◙═───────────────────────────────────────────────────────────────────────────────────╮
      restorescreen                                                         ; Restore saved screen
      walkframe=walkframe+1                                                 ; Walkframe Frame Counter
      framecounter1=framecounter1+1 
      if framecounter1>8 then framecounter1=0:framecounter2=framecounter2+1
      if framecounter2>3 then framecounter2=0
      if health=0 then health=8                                            ; TEMP Health Restore
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
   ;╭──═◙ Menu / Move Icon / Select and Use Item ◙═─────────────────────────────────────────────────╮
   ;  Load is x4 y180     Top Potion is x35 y116
   ;  Save is x28 y180    Bot Potion is x35 y132
   ;  Item is x51 y180 
   ;  Default location is statusmenu_x=51:statusmenu_y=180, "Item"
   ; ──═◙ Main Menu ◙═────────────────────────────────────────────────────────────────────────────────
      ;                                [Load | Save | Item]
      ;
      if status_menu=0 then goto skipmainmenu8
      if debounce2=5 && statusmenu_x=4   then debounce2=0:gosub status_load_game bank1:status_active=0:goto statusreturn    ; Load
      if debounce2=5 && statusmenu_x=28  then debounce2=0:gosub status_save_game bank1                                      ; Save
      if debounce2=5 && statusmenu_x=51  then debounce2=0:upcheck=0:downcheck=0:debounce=0:statusmenu_x=35:statusmenu_y=116:status_menu=0  ; Item
      ;
      if rightcheck=7 && statusmenu_x=4  then rightcheck=0:statusmenu_x=28
      if rightcheck=7 && statusmenu_x=28 then rightcheck=0:statusmenu_x=51
      if rightcheck=7 && statusmenu_x=51 then rightcheck=0:statusmenu_x=51
      if leftcheck=7 && statusmenu_x=4   then leftcheck=0:statusmenu_x=4
      if leftcheck=7 && statusmenu_x=28  then leftcheck=0:statusmenu_x=4
      if leftcheck=7 && statusmenu_x=51  then leftcheck=0:statusmenu_x=28
      goto skipitemmenu8
skipmainmenu8
   ; ──═◙ Item Menu ◙═────────────────────────────────────────────────────────────────────────────────
      ;                                   [ Health Potion ]
      ;                                     ─────────────
      ;                                   [ Magic Potion  ] 
      ;
      if statusmenu_y=132 && downcheck=7 then downcheck=0:statusmenu_x=51:statusmenu_y=180:status_menu=1
      ;
      if statusmenu_y=116 && downcheck=7 then downcheck=0:statusmenu_y=132
      if statusmenu_y=132 && upcheck=7 then upcheck=0:statusmenu_y=116
      ;
      if statusmenu_y=116 && hpotion_val>0 && debounce2=5 then debounce2=0:HP=HPMax:hpotion_val=hpotion_val-1
      if statusmenu_y=132 && mpotion_val>0 && debounce2=5 then debounce2=0:mana=manamax:mpotion_val=mpotion_val-1
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
skipitemmenu8
   ;╭──═◙ Plot Graphics ◙═───────────────────────────────────────────────────────────────────────────╮
   ; ──═◙ Menu Icon ◙═────────────────────────────────────────────────────────────────────────────────
      plotsprite arrowblock2 framecounter1 statusmenu_x statusmenu_y
   ; ──═◙ Top Left / Level & XP ◙═────────────────────────────────────────────────────────────────────
      plotvalue tileset_status2 4 XP 6 22 2 ; XP
      plotvalue tileset_status2 4 LevelLo 2 34 1 ; Level
   ; ──═◙ Lower Left / Inventory ◙═───────────────────────────────────────────────────────────────────
      plotvalue tileset_status2 4 armor_val   2 20 7
      plotvalue tileset_status2 4 shield_val  2 20 8
      plotvalue tileset_status2 4 sword_val   2 20 9
      plotvalue tileset_status2 4 rodoflife   2 20 10
      plotvalue tileset_status2 4 hpotion_val 2 52 7
      plotvalue tileset_status2 4 mpotion_val 2 52 8
      plotvalue tileset_status2 4 key_val     2 52 9
      plotvalue tileset_status2 4 ring_val    2 52 10
      ; Plot individual red and blue potion icons so they can be differentiated on the inventory screen
      plotsprite icon_potion 5 40 116  
      plotsprite icon_potion 4 40 132 
   ; ──═◙ Map Location Icon ◙═─────────────────────────────────────────────────────────────────────────
      ;Plot the icon on the map that reveals your approximate location in the overworld (if room<128)
      mapicon_x=mapicon_xvalues[lastroom] : mapicon_y=mapicon_yvalues[lastroom] 
      if lastroom<128 && framecounter1<3 then plotsprite swordfire 6 mapicon_x mapicon_y
   ; ──═◙ Crystals ◙═──────────────────────────────────────────────────────────────────────────────────
      if crystal1_flag=1 then plotsprite icon_crystal 7 6  82 
      if crystal2_flag=1 then plotsprite icon_crystal 6 16 82
      if crystal3_flag=1 then plotsprite icon_crystal 5 26 82
      if crystal4_flag=1 then plotsprite icon_crystal 4 36 82
      if crystal5_flag=1 then plotsprite icon_crystal 3 46 82
      if crystal6_flag=1 then plotsprite icon_crystal 2 56 82
      if crystal7_flag=1 then plotsprite icon_crystal 1 66 82
      if crystal1_flag=0 then plotsprite icon_empty   5 7  82 
      if crystal2_flag=0 then plotsprite icon_empty   5 17 82
      if crystal3_flag=0 then plotsprite icon_empty   5 27 82
      if crystal4_flag=0 then plotsprite icon_empty   5 37 82
      if crystal5_flag=0 then plotsprite icon_empty   5 47 82
      if crystal6_flag=0 then plotsprite icon_empty   5 57 82
      if crystal7_flag=0 then plotsprite icon_empty   5 67 82
   ; ──═◙ Common Bottom Status Bar ◙═──────────────────────────────────────────────────────────────────
      plotvalue tileset_attack2 3 HP    2 19 12  :  plotvalue tileset_attack2 3 HPMax   2 39 12
      plotvalue tileset_attack2 3 mana   2 19 13  :  plotvalue tileset_attack2 3 manamax 2 39 13
      plotvalue tileset_attack2 3 score0 6 106 12
      plotsprite swordfire 5 200 200
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────╯
  
      gosub multibankdrawscreen bank15                   ; Jumps to Drawscreen Subroutine
  
   goto statusscreenloop

statusreturn
      ; Reset Palettes back to the default
      P1C1=$F1   :  P2C1=$80  :  P3C1=$1C  :  P4C1=$90  :  P5C1=$42  :  P6C1=$C6  :  P7C1=$E0
      P1C2=$F3   :  P2C2=$86  :  P3C2=$34  :  P4C2=$98  :  P5C2=$46  :  P6C2=$C4  :  P7C2=$08
      P1C3=$C0   :  P2C3=$F2  :  P3C3=$3A  :  P4C3=$0F  :  P5C3=$FF  :  P6C3=$F2  :  P7C3=$04
      room=lastroom
      if room<64              then characterset tileset_1:roombank=6:goto setroom  
      if room>63  && room<128 then characterset tileset_1:roombank=6:goto setroom
      if room>127 && room<192 then characterset tileset_5:roombank=7:goto setroom
      if room>191             then characterset tileset_5:roombank=8:goto setroom
setroom
      ;debounce=0
      clearscreen
      gosub draw_room bank15
      return otherbank

     data mapicon_xvalues
     83,86,91,96,101,106,111,116,121,126,131,136,141,146,151,154
     83,86,91,96,101,106,111,116,121,126,131,136,141,146,151,154
     83,86,91,96,101,106,111,116,121,126,131,136,141,146,151,154
     83,86,91,96,101,106,111,116,121,126,131,136,141,146,151,154
     83,86,91,96,101,106,111,116,121,126,131,136,141,146,151,154
     83,86,91,96,101,106,111,116,121,126,131,136,141,146,151,154
     83,86,91,96,101,106,111,116,121,126,131,136,141,146,151,154
     83,86,91,96,101,106,111,116,121,126,131,136,141,146,151,154
end

     data mapicon_yvalues
     118,118,118,118,118,118,118,118,118,118,118,118,118,118,118,118
     126,126,126,126,126,126,126,126,126,126,126,126,126,126,126,126
     136,136,136,136,136,136,136,136,136,136,136,136,136,136,136,136
     146,146,146,146,146,146,146,146,146,146,146,146,146,146,146,146
     156,156,156,156,156,156,156,156,156,156,156,156,156,156,156,156
     166,166,166,166,166,166,166,166,166,166,166,166,166,166,166,166
     176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176
     184,184,184,184,184,184,184,184,184,184,184,184,184,184,184,184
end

b13drawscreen
   ;╭──═◙ Bank 13 Drawscreen ◙═─────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
     drawscreen
        ; ──═◙ Top Right / Attributes ◙═───────────────────────────────────────────────────────────────────
      plotvalue tileset_status2 2 STR 2 138 1
      plotvalue tileset_status2 2 INT 2 138 2
      plotvalue tileset_status2 2 DEX 2 138 3
      plotvalue tileset_status2 2 VIT 2 138 4
     drawwait 
     return otherbank

                                                                                                             /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 14 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                              */ 
 bank 14

  ; Action-based attack (Skeleton/Cemetary)

  ;╭──═◙ Bank 14 Graphics ◙═───────────────────────────────────────────────────────────────────────╮
    incgraphic tileset_1.png
    incgraphic tileset_2.png
    incgraphic tileset_3.png
    incgraphic tileset_4.png
    ;incgraphic tileset_14b.png 160A 0 1 2 3 1
    ;incgraphic tileset_14e.png 160A 0 1 2 3 1
    ;incmapfile attacked.tmx
  ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

 alphachars ' abcdefghijklmnopqrstuvwxyzABCDEF' 

 alphadata statusbar14 tileset_3
 'wjzzkzzlpqrstzzzzzzx'
 'umnyoyyABCDEyyyyyyyv'
end

attackloop

  ;╭──═◙ Initial Enemy Location ◙═──────────────────────────────────────────────────────────────────╮
     skeleton_x=(rand&127)+20 : skeleton_y=(rand&127)+30 : skeleton_flag=0 : attacktimer=0
  ;╰────────────────────────────────────────────────────────────────────────────────────────────────╯

  ;╭──═◙ Initial Gold Location ◙═────────────────────────────────────────────────────────────────────╮
     gold1_x=(rand&127)+15 : gold1_y=(rand&127)+9  
  ;╰─────────────────────────────────────────────────────────────────────────────────────────────────╯

  ;╭──═◙ Range/Distance of fire ◙═───────────────────────────────────────────────────────────────────╮
  ;  How far you can fire depends on how much mana you have
     range_right=158 : range_left=2 : range_down=188 : range_up=11
  ;╰─────────────────────────────────────────────────────────────────────────────────────────────────╯

    attacksequence=1
    gosub set_bullet_home2   ; Resets the swordfire/player bullet location to the home position

attackloop2
      restorescreen  

   ;╭──═◙ Misc ◙═───────────────────────────────────────────────────────────────────────────────────╮
      walkframe=walkframe+1                                              
      framecounter1=framecounter1+1 
      if framecounter1>8 then framecounter1=0:framecounter2=framecounter2+1
      if framecounter2>3 then framecounter2=0
      if health=0 then health=8                                       ; DEBUG / TEMP Health Restore
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

  ;╭──═◙ Collision Detection ◙═────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
      if skeleton_flag=0 && boxcollision(xpos,ypos,7,13, skeleton_x,skeleton_y, 15,15) then skeleton_flag=1:skeleton_x=200:skeleton_y=200:health=health-1
      if boxcollision(swordfire_x,swordfire_y,8,2, skeleton_x,skeleton_y, 15,15) then skeleton_flag=1:skeleton_x=200:skeleton_y=200:scorea=scorea+1
      if boxcollision(xpos,ypos,7,13, gold1_x,gold1_y, 15,15) then gold1_x=200:gold1_y=200:score0=score0+7
   ;╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Return from Battle ◙═────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
      if skeleton_flag=1 && gold1_flag=1 then goto GoBack2
      if skeleton_flag=1 then attacktimer=attacktimer+1
      if attacktimer=254 then clearscreen:goto GoBack2
   ;╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Lose 1 Mana when you fire ◙═──────────────────────────────────────────────────────────────╮
      if joy0fire then debounce=5
      if !joy0fire && debounce=5 then debounce=3
      if debounce=3 then debounce=0:gosub reduce_mana2
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

   ;╭──═◙ Animation Frame Check & Player Movement ◙═────────────────────────────────────────────────╮
   ; Based on direction and the walking counter...
      ; See if you've changed joystick directions. If so, the bullet is stopped and reset
      if joy0up    && joyposup=0    then gosub set_bullet_home2
      if joy0down  && joyposdown=0  then gosub set_bullet_home2
      if joy0left  && joyposleft=0  then gosub set_bullet_home2
      if joy0right && joyposright=0 then gosub set_bullet_home2
     walkframe=walkframe+1                               ; Walkframe Frame Counter
     p0_x=0:p0_y=0                                       ; Reset X/Y Values to 0 
      if joy0down  then gosub checkmovedown2 :herodir=0:joyposup=0:joyposdown=1:joyposleft=0:joyposright=0:goto doneherowalk2
      if joy0up    then gosub checkmoveup2   :herodir=2:joyposup=1:joyposdown=0:joyposleft=0:joyposright=0:goto doneherowalk2
      if joy0left  then gosub checkmoveleft2 :herodir=1:joyposup=0:joyposdown=0:joyposleft=1:joyposright=0:goto doneherowalk2
      if joy0right then gosub checkmoveright2:herodir=3:joyposup=0:joyposdown=0:joyposleft=0:joyposright=1:goto doneherowalk2
     walkframe=walkframe-1                               ; We didn't move
doneherowalk2
     xpos=xpos+p0_x
     ypos=ypos+p0_y
      if mana<1 then range_right=xpos+12:range_left=xpos-12:range_up=ypos-20:range_down=ypos+20
      if mana>0 then range_right=158 : range_left=2 : range_down=188 : range_up=11
   ; ──═◙ Fire the sword ◙═───────────────────────────────────────────────────────────────────────
      if !joy0fire then gosub set_bullet_home2 
      if mana<1 then gosub set_bullet_home2 
      if mana<1 then goto alternate_fire2
      if joy0fire && joyposup=1 then swordfire_y=swordfire_y-4
      if joy0fire && joyposdown=1 then swordfire_y=swordfire_y+4
      if joy0fire && joyposleft=1 then swordfire_x=swordfire_x-4
      if joy0fire && joyposright=1 then swordfire_x=swordfire_x+4
   ; ──═◙ Keep sword on-screen ◙═────────────────────────────────────────────────────────────────
      if swordfire_x>range_right then gosub set_bullet_home2       ; Stop bullet at right edge of screen
      if swordfire_x<range_left   then gosub set_bullet_home2       ; Stop bullet at left edge of screen
      if swordfire_y>range_down then gosub set_bullet_home2       ; Stop bullet at bottom edge of screen
      if swordfire_y<range_left  then gosub set_bullet_home2       ; Stop bullet at top edge of screen 
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
alternate_fire2
   ;╭──═◙ Move Enemy   ◙═─────────────────────────────╮
     if framecounter2<>3 then skipenemymove2
     if  skeleton_x<xpos  then skeleton_x=skeleton_x+1
     if  skeleton_x>xpos  then skeleton_x=skeleton_x-1
     if  skeleton_y<ypos  then skeleton_y=skeleton_y+1
     if  skeleton_y>ypos  then skeleton_y=skeleton_y-1
   ;╰─────────────────────────────────────────────────╯
skipenemymove2
   
   ;╭──═◙ Calculate which animation frame to display ◙═────────────────────────────────────────────╮
     temp1=(herodir*3)+((walkframe/16)&1)
     if joy0any then plotsprite herodown1 0 xpos ypos temp1
     if !joy0any && herodir=0 then plotsprite herodown2  0 xpos ypos   ; Standing still sprite Down
     if !joy0any && herodir=2 then plotsprite heroup2    0 xpos ypos   ; Standing still sprite Up
     if !joy0any && herodir=1 then plotsprite heroleft2  0 xpos ypos   ; Standing still sprite Left
     if !joy0any && herodir=3 then plotsprite heroright2 0 xpos ypos   ; Standing still sprite Right
   ; ──═◙ Keep Player on the same screen ◙═─────────────────────────────────────────────────────────
     if xpos>158 then xpos=xpos-1                             ; Stop bullet at right edge of screen
     if xpos<2   then xpos=xpos+1                             ; Stop bullet at left edge of screen
     if ypos>178 then ypos=ypos-1                             ; Stop bullet at bottom edge of screen
     if ypos<11  then ypos=ypos+1                             ; Stop bullet at top edge of screen 
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
   
   ;╭──═◙ Plot Graphics ◙═───────────────────────────────────────────────────────────────────────────╮
   ; ──═◙ Enemies ◙═─────────────────────────────────────────────────────────────────────────────────
     if skeleton_flag=0  then plotsprite sprite_skeleton1b 4 skeleton_x skeleton_y  framecounter2
   ; ──═◙ Status Bar ◙═──────────────────────────────────────────────────────────────────────────────
      plotvalue tileset_attack2 3 HP    2 19 12  :  plotvalue tileset_attack2 3 HPMax   2 39 12
      plotvalue tileset_attack2 3 mana   2 19 13  :  plotvalue tileset_attack2 3 manamax 2 39 13
      plotvalue tileset_attack2 3 score0 6 106 12
      if joyposup=1   || joyposdown=1  then plotsprite sword_ud 3 swordfire_x swordfire_y
      if joyposleft=1 || joyposright=1 then plotsprite sword_lr 3 swordfire_x swordfire_y
   ; ──═◙ Gold ◙═────────────────────────────────────────────────────────────────────────────────────
      if skeleton_flag=0 then goto skipgold2 
      plotsprite sprite_gold 3 gold1_x gold1_y
    ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
skipgold2

      gosub multibankdrawscreen bank15                        ; Jumps to Drawscreen Subroutine

   goto attackloop2

GoBack2
   ; Return to Main Loop
      attacksequence=0
      gosub draw_room bank15
      rand_encounter=(rand&127)
      return otherbank

set_bullet_home2
  ; This code sets the bullet location back to it's home position
      if herodir=0 then swordfire_x=xpos+6:swordfire_y=ypos+13 ;down 
      if herodir=2 then swordfire_x=xpos:swordfire_y=ypos+1    ;up
      if herodir=1 then swordfire_x=xpos-6:swordfire_y=ypos+5  ;left 
      if herodir=3 then swordfire_x=xpos+4:swordfire_y=ypos+5  ;right
      return

reduce_mana2
      if mana>0 then dec mana=mana-$01
      return

checkmovedown2
   ;╭──═◙ Check South Movement ◙═──────────────────────────────────────────────────────────────────═■
     tempx=(xpos+1)/8
     tempy=(ypos+16)/16
     tempchar1=peekchar(screenram,tempx,tempy,20,12)
     tempx=(xpos+15)/8
     tempchar2=peekchar(screenram,tempx,tempy,20,12)         
     if tempchar1<154 && tempchar2<154 then p0_y=1:return        ; 154 is the 13th tile in tileset_3
     return
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
checkmoveup2
   ;╭──═◙ Check North Movement ◙═──────────────────────────────────────────────────────────────────═■
     ;if ypos<8 then p0_y=255:return                          ; Avoid checking offscreen characters
     tempx=(xpos+1)/8
     tempy=ypos/16
     tempchar1=peekchar(screenram,tempx,tempy,20,12)
     tempx=(xpos+15)/8
     tempchar2=peekchar(screenram,tempx,tempy,20,12)
     if tempchar1<154 && tempchar2<154 then p0_y=255:return      ; 154 is the 13th tile in tileset_3
     return
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
checkmoveleft2
   ;╭──═◙ Check West Movement ◙═───────────────────────────────────────────────────────────────────═■
     ;if xpos<8 then p0_x=255:return                          ; Avoid checking offscreen characters
     tempx=xpos/8
     tempy=(ypos+1)/16
     tempchar1=peekchar(screenram,tempx,tempy,20,12)
     tempy=(ypos+15)/16
     tempchar2=peekchar(screenram,tempx,tempy,20,12)
     if tempchar1<154 && tempchar2<154 then p0_x=255:return      ; 154 is the 13th tile in tileset_3
     return
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
checkmoveright2
   ;╭──═◙ Check East Movement ◙═───────────────────────────────────────────────────────────────────═■
     ;if xpos>142 then p0_x=1:return                          ; Avoid checking offscreen characters
     tempx=(xpos+16)/8
     tempy=(ypos+1)/16
     tempchar1=peekchar(screenram,tempx,tempy,20,12)
     tempy=(ypos+15)/16
     tempchar2=peekchar(screenram,tempx,tempy,20,12)
     if tempchar1<154 && tempchar2<154 then p0_x=1:return        ; 154 is the 13th tile in tileset_3
     return
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯


b14drawscreen
   ;╭──═◙ Bank 14 Drawscreen ◙═─────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
     drawscreen
     drawwait 
     return otherbank
                                                                                                              /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 15 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                              */ 
 bank 15 

  incgraphic hiscorefont.png 320A

go_north
   ;╭──═◙ Move up one Room ◙═─────────────────────────────────────────────────────────────────────────╮
     lastroom=room
     ypos = 160
     room = move_north[room]
     clearscreen
     debounce=0:debounce2=0
     goto draw_room
go_east
   ; ──═◙ Move right one Room ◙═───────────────────────────────────────────────────────────────────────
     lastroom=room
     xpos = 5
     room = move_east[room]
     clearscreen
     debounce=0:debounce2=0
     goto draw_room
go_south
   ; ──═◙ Move down one Room ◙═────────────────────────────────────────────────────────────────────────
     lastroom=room
     ypos = 5
     room = move_south[room]
     clearscreen
     debounce=0:debounce2=0
     goto draw_room
go_west
   ; ──═◙ Move left one Room ◙═────────────────────────────────────────────────────────────────────────
     lastroom=room
     xpos = 156
     room = move_west[room]
     clearscreen
     debounce=0:debounce2=0
     goto draw_room
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────╯

draw_room
   ;┌──═◙ Assign Tile Bank ◙═───────────────────────────────────────────────────────────────────────┐
   ;│ Switch to different bank of tilesets depending on the room Number we are in.                  │
      if room=129             then characterset tileset_attack1:roombank=9:goto RoomBankSet2
      if room=138             then characterset tileset_dattack1:roombank=18:goto RoomBankSet2
      if room=142             then characterset tileset_status1:roombank=13:goto RoomBankSet2
      if room<64              then characterset tileset_1:roombank=6:goto RoomBankSet2   
      if room>63  && room<128 then characterset tileset_1:roombank=6:goto RoomBankSet2               
      if room>127 && room<192 then characterset tileset_5:roombank=7:goto RoomBankSet2               
      if room>191             then characterset tileset_a:roombank=8:goto RoomBankSet2  
RoomBankSet2                                                             
       gosub multibankdrawscreen
       temp1=room_shape[room]
       temproomlo=roommaplo[temp1]
       temproomhi=roommaphi[temp1]
   ;└───────────────────────────────────────────────────────────────────────────────────────────────┘ 

   ;┌──═◙ Switch Banks ◙═───────────────────────────────────────────────────────────────────────────┐
   ;│ Temporarily change to the bank with the right room map data files, and load them.             │  
   ;│ Room Map Data is loaded in blocks of 64 rooms.                                                │
      if room<64              then gosub changetileram_bank2 bank2:goto changetileramdone;          │
      if room>63  && room<128 then gosub changetileram_bank3 bank3:goto changetileramdone;          │
      if room>127 && room<192 then gosub changetileram_bank4 bank4:goto changetileramdone;          │
      if room>191             then gosub changetileram_bank5 bank5;                                 │
   ;└───────────────────────────────────────────────────────────────────────────────────────────────┘ 
  savescreen
changetileramdone

  ;┌──═◙ Room Colors ◙═─────────────────────────────────────────────────────────────────────────────┐
  ;│                                                                                                │ 
  ;│ These define what colors will be displayed in any given map screen, and is divided into four   │ 
  ;│ quadrants for color. The mytemp variables hold the palette color.                              │ 
  ;│ P0 is desert, P2 is water, P6 is forest.                                                       │ 
  ;│                                                                                                │ 
  ;│  ┌─────────┬─────────┐                                                                         │ 
  ;│  │░░░░░░░░░│▒▒▒▒▒▒▒▒▒│                                                                         │ 
  ;│  │ mytemp1 │ mytemp2 │                                                                         │ 
  ;│  ├─────────┼─────────┤                                                                         │ 
  ;│  │▓▓▓▓▓▓▓▓▓│░░░░░░░░░│                                                                         │ 
  ;│  │ mytemp3 │ mytemp4 │                                                                         │ 
  ;│  └─────────┴─────────┘                                                                         │ 
  ;└────────────────────────────────────────────────────────────────────────────────────────────────┘ 
  ;
  ;┌──═◙ Unique Room Types Used in Rooms 0-127 ◙═────────────────────────────────────────────────────────────────────────────────────────┐
  ;│ (Unused Room Type lines are commented out but remain for future use)                                                                │
  ;│   0, 13, 15, 16, 17, 18, 19, 20, 24, 26, 27, 29, 30, 32, 34, 35, 40, 41, 42, 43, 44, 45, 47, 49, 50, 51, 53, 54, 55, 56, 57, 58, 59 │
  ;└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ 
room_quadrant_color
  ;╭──═◙ Set Quadrant Colors for Rooms ◙═──────────────────────────────────────────────────────┳─────────────────────────────────────╮
    ;if room_type[room]=1 then mytemp1=1:mytemp2=1:mytemp3=2:mytemp4=2:goto roomtype_quarters       ; desert tiles, water bottom
    ;if room_type[room]=2 then mytemp1=2:mytemp2=2:mytemp3=1:mytemp4=1:goto roomtype_quarters       ; desert tiles, water top
    ;if room_type[room]=3 then mytemp1=1:mytemp2=2:mytemp3=1:mytemp4=2:goto roomtype_quarters       ; desert tiles, water right
    ;if room_type[room]=4 then mytemp1=2:mytemp2=1:mytemp3=2:mytemp4=1:goto roomtype_quarters       ; desert tiles, water left
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄───────────────────────────────────═■
    ;if room_type[room]=5 then mytemp1=1:mytemp2=2:mytemp3=2:mytemp4=2:goto roomtype_quarters       ; desert tiles, island top-left
    ;if room_type[room]=6 then mytemp1=2:mytemp2=1:mytemp3=2:mytemp4=2:goto roomtype_quarters       ; desert tiles, island top-right
    ;if room_type[room]=7 then mytemp1=2:mytemp2=2:mytemp3=1:mytemp4=2:goto roomtype_quarters       ; desert tiles, island bottom-left
    ;if room_type[room]=8 then mytemp1=2:mytemp2=2:mytemp3=2:mytemp4=1:goto roomtype_quarters       ; desert tiles, island bottom-right
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
    ;if room_type[room]=9  then mytemp1=2:mytemp2=1:mytemp3=1:mytemp4=1:goto roomtype_quarters      ; desert tiles, water top-left
    ;if room_type[room]=10 then mytemp1=1:mytemp2=1:mytemp3=1:mytemp4=2:goto roomtype_quarters      ; desert tiles, water bottom-right
    ;if room_type[room]=11 then mytemp1=1:mytemp2=2:mytemp3=1:mytemp4=1:goto roomtype_quarters      ; desert tiles, water top-right
    ;if room_type[room]=12 then mytemp1=1:mytemp2=1:mytemp3=2:mytemp4=1:goto roomtype_quarters      ; desert tiles, water bottom-left
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
     if room_type[room]=13 then mytemp1=7:mytemp2=7:mytemp3=7:mytemp4=7:goto roomtype_plain         ; mountain(grey), entire screen
     if room_type[room]=0  then mytemp1=6:mytemp2=6:mytemp3=6:mytemp4=6:goto roomtype_plain         ; forest tiles, entire screen
     if room_type[room]=27 then mytemp1=2:mytemp2=2:mytemp3=2:mytemp4=2:goto roomtype_plain         ; water tiles, entire screen
     if room_type[room]=41 then mytemp1=1:mytemp2=1:mytemp3=1:mytemp4=1::goto roomtype_plain         ; desert tiles, entire screen
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
     if room_type[room]=15 then mytemp1=6:mytemp2=6:mytemp3=2:mytemp4=2:goto roomtype_quarters      ; forest tiles, water bottom
     if room_type[room]=16 then mytemp1=2:mytemp2=2:mytemp3=6:mytemp4=6:goto roomtype_quarters      ; forest tiles, water top
     if room_type[room]=17 then mytemp1=6:mytemp2=2:mytemp3=6:mytemp4=2:goto roomtype_quarters      ; forest tiles, water right
     if room_type[room]=18 then mytemp1=2:mytemp2=6:mytemp3=2:mytemp4=6:goto roomtype_quarters      ; forest tiles, water left
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
     if room_type[room]=19 then mytemp1=6:mytemp2=2:mytemp3=2:mytemp4=2:goto roomtype_quarters      ; forest tiles, island top-left
     if room_type[room]=20 then mytemp1=2:mytemp2=6:mytemp3=2:mytemp4=2:goto roomtype_quarters      ; forest tiles, island top-right
    ;if room_type[room]=21 then mytemp1=2:mytemp2=2:mytemp3=6:mytemp4=2:goto roomtype_quarters      ; forest tiles, island bottom-left
    ;if room_type[room]=22 then mytemp1=2:mytemp2=2:mytemp3=2:mytemp4=6:goto roomtype_quarters      ; forest tiles, island bottom-right
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
    ;if room_type[room]=23 then mytemp1=2:mytemp2=6:mytemp3=6:mytemp4=6:goto roomtype_quarters      ; forest tiles, water top-left
     if room_type[room]=24 then mytemp1=6:mytemp2=6:mytemp3=6:mytemp4=2:goto roomtype_quarters      ; forest tiles, water bottom-right
    ;if room_type[room]=25 then mytemp1=6:mytemp2=2:mytemp3=6:mytemp4=6:goto roomtype_quarters      ; forest tiles, water top-right
     if room_type[room]=26 then mytemp1=6:mytemp2=6:mytemp3=2:mytemp4=6:goto roomtype_quarters      ; forest tiles, water bottom-left
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
    ;if room_type[room]=28 then mytemp1=6:mytemp2=6:mytemp3=7:mytemp4=7:goto roomtype_quarters      ; mountain tiles, forest bottom
     if room_type[room]=29 then mytemp1=7:mytemp2=7:mytemp3=6:mytemp4=6:goto roomtype_quarters      ; mountain tiles, forest top
     if room_type[room]=30 then mytemp1=6:mytemp2=7:mytemp3=6:mytemp4=7:goto roomtype_quarters      ; mountain tiles, forest right
    ;if room_type[room]=31 then mytemp1=7:mytemp2=6:mytemp3=7:mytemp4=6:goto roomtype_quarters      ; mountain tiles, forest left
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
     if room_type[room]=32 then mytemp1=6:mytemp2=7:mytemp3=7:mytemp4=7:goto roomtype_quarters      ; mountain tiles, island top-left
    ;if room_type[room]=33 then mytemp1=7:mytemp2=6:mytemp3=7:mytemp4=7:goto roomtype_quarters      ; mountain tiles, island top-right
     if room_type[room]=34 then mytemp1=7:mytemp2=7:mytemp3=6:mytemp4=7:goto roomtype_quarters      ; mountain tiles, island bottom-left
     if room_type[room]=35 then mytemp1=7:mytemp2=7:mytemp3=7:mytemp4=6:goto roomtype_quarters      ; mountain tiles, island bottom-right
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
    ;if room_type[room]=36 then mytemp1=7:mytemp2=6:mytemp3=6:mytemp4=6:goto roomtype_quarters      ; mountain tiles, forest top-left
    ;if room_type[room]=37 then mytemp1=6:mytemp2=6:mytemp3=6:mytemp4=7:goto roomtype_quarters      ; mountain tiles, forest bottom-right
    ;if room_type[room]=38 then mytemp1=6:mytemp2=7:mytemp3=6:mytemp4=6:goto roomtype_quarters      ; mountain tiles, forest top-right
    ;if room_type[room]=39 then mytemp1=6:mytemp2=6:mytemp3=7:mytemp4=6:goto roomtype_quarters      ; mountain tiles, forest bottom-left
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
     if room_type[room]=40 then mytemp1=2:mytemp2=2:mytemp3=7:mytemp4=7:goto roomtype_quarters      ; mountain bottom/water top
     if room_type[room]=55 then mytemp1=7:mytemp2=7:mytemp3=2:mytemp4=2:goto roomtype_quarters      ; mountain bottom/water top
     if room_type[room]=54 then mytemp1=2:mytemp2=1:mytemp3=1:mytemp4=1:goto roomtype_quarters      ; desert tiles, water top left
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
     if room_type[room]=42 then mytemp1=6:mytemp2=6:mytemp3=1:mytemp4=1:goto roomtype_quarters      ; desert tiles, forest bottom
     if room_type[room]=43 then mytemp1=1:mytemp2=1:mytemp3=6:mytemp4=6:goto roomtype_quarters      ; desert tiles, forest top
     if room_type[room]=44 then mytemp1=6:mytemp2=1:mytemp3=6:mytemp4=1:goto roomtype_quarters      ; desert tiles, forest right
     if room_type[room]=45 then mytemp1=1:mytemp2=6:mytemp3=1:mytemp4=6:goto roomtype_quarters      ; desert tiles, forest left
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
    ;if room_type[room]=46 then mytemp1=6:mytemp2=1:mytemp3=1:mytemp4=1:goto roomtype_quarters      ; desert tiles, island top-left
     if room_type[room]=47 then mytemp1=1:mytemp2=6:mytemp3=1:mytemp4=1:goto roomtype_quarters      ; desert tiles, island top-right
    ;if room_type[room]=48 then mytemp1=1:mytemp2=1:mytemp3=6:mytemp4=1:goto roomtype_quarters      ; desert tiles, island bottom-left
     if room_type[room]=49 then mytemp1=1:mytemp2=1:mytemp3=1:mytemp4=6:goto roomtype_quarters      ; desert tiles, island bottom-right
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
     if room_type[room]=50 then mytemp1=1:mytemp2=6:mytemp3=6:mytemp4=6:goto roomtype_quarters      ; desert tiles, forest top-left
     if room_type[room]=51 then mytemp1=6:mytemp2=6:mytemp3=6:mytemp4=1:goto roomtype_quarters      ; desert tiles, forest bottom-right
    ;if room_type[room]=52 then mytemp1=6:mytemp2=1:mytemp3=6:mytemp4=6:goto roomtype_quarters      ; desert tiles, forest top-right
     if room_type[room]=53 then mytemp1=6:mytemp2=6:mytemp3=1:mytemp4=6:goto roomtype_quarters      ; desert tiles, forest bottom-left
  ; ────────────────────────────────────────────────────────────────────────────────────────────╄────────────────────────────────────═■
     if room_type[room]=56 then mytemp1=2:mytemp2=7:mytemp3=7:mytemp4=7:goto roomtype_quarters      ; mountain tiles, island top-left
     if room_type[room]=57 then mytemp1=7:mytemp2=2:mytemp3=7:mytemp4=7:goto roomtype_quarters      ; mountain tiles, island top-right
     if room_type[room]=58 then mytemp1=7:mytemp2=7:mytemp3=2:mytemp4=7:goto roomtype_quarters      ; mountain tiles, island bottom-left
     if room_type[room]=59 then mytemp1=7:mytemp2=7:mytemp3=7:mytemp4=2:goto roomtype_quarters      ; mountain tiles, island bottom-right
  ;╰────────────────────────────────────────────────────────────────────────────────────────────┴──────────────────────────────────────╯
  
  ; Dungeon / Town Colors

     if room_type[room]=91 then mytemp1=6:P6C1=$01:P6C2=$02:P6C3=$04:goto roomtype_plain    ; Black and White [ Mountain ]  Dark
     if room_type[room]=92 then mytemp1=6:P6C1=$01:P6C2=$03:P6C3=$05:goto roomtype_plain    ; Black and White [ Mountain ]  Medium                                   
     if room_type[room]=93 then mytemp1=6:P6C1=$02:P6C2=$04:P6C3=$06:goto roomtype_plain    ; Black and White [ Mountain ]  Light 
     if room_type[room]=82 then mytemp1=6:P6C1=$F1:P6C2=$F2:P6C3=$13:goto roomtype_plain    ; Dark Brown      [ Desert ]                                    
     if room_type[room]=61 then mytemp1=6:P6C1=$C1:P6C2=$C2:P6C3=$C3:goto roomtype_plain    ; Green           [ Forest ]                                   
     if room_type[room]=71 then mytemp1=6:P6C1=$11:P6C2=$12:P6C3=$13:goto roomtype_plain    ; Dark Yellow                     
     if room_type[room]=88 then mytemp1=6:P6C1=$81:P6C2=$82:P6C3=$04:goto roomtype_plain    ; Dark Blue   
     if room_type[room]=83 then mytemp1=6:P6C1=$C4:P6C2=$11:P6C3=$F2:goto roomtype_plain    ; Forest Town

     ; Background :  Water     :  Icons     :  Blue      :  Dungeons  :  Forest/Bar:  White/Grey
     ; P1C1=$F1   :  P2C1=$80  :  P3C1=$1C  :  P4C1=$90  :  P5C1=$42  :  P6C1=$C6  :  P7C1=$E0
     ; P1C2=$F3   :  P2C2=$86  :  P3C2=$34  :  P4C2=$98  :  P5C2=$46  :  P6C2=$C4  :  P7C2=$08
     ; P1C3=$C0   :  P2C3=$F2  :  P3C3=$3A  :  P4C3=$0F  :  P5C3=$FF  :  P6C3=$F2  :  P7C3=$04

     ; Title Screen Colors
     if room_type[room]=141 then P7C1=$08:P7C2=$04:P7C3=$E0:mytemp1=7: P1C1=$80:P1C2=$84:P1C3=$E0:mytemp2=1: goto roomtype_title

     ; Turn Attack Screen (Top/Bottom are different)
     if room_type[room]=129 then P1C1=$25:P1C2=$04:P1C3=$09:  P2C1=$C6:P2C2=$09:P2C3=$F2: mytemp1=1:mytemp2=1:mytemp3=2:mytemp4=2:goto roomtype_quarters      
     
     ; Status Screen Colors  - PxC3 is the border color for each quadrant      
     if room_type[room]=142 then P1C1=$C3:P1C2=$C6:P1C3=$F2:  P2C1=$13:P2C2=$14:P2C3=$F2:  P3C1=$E3:P3C2=$08:P3C3=$F2:  P4C1=$83:P4C2=$86:P4C3=$F2:  mytemp1=1:mytemp2=2:mytemp3=3:mytemp4=4:goto roomtype_quarters 

roomtype_plain
  ;╭─═◙ Plot Single Color Room Palette ◙═────────────────────────────────────────────────────────────────────╮
  ;  Entire screen is a single palette                                                               
     gosub multibankdrawscreen
     clearscreen
  ;                             ┌───────────┬─────────┬───┬───┬───────┬────────┬─────────┬─────────┬──────────┐       
  ;                             │  mapdata  │ palette │ X │ Y │ Width │ Height │ MapXOff │ MapYOff │ MapWidth │       
  ;                             └───────────┴─────────┴───┴───┴───────┴────────┴─────────┴─────────┴──────────┘       
                         plotmap  screenram   mytemp1   0   0    20       12   ; Not Set   Not Set   Not Set  
      if roombank=6 then plotmap  statusbar6  6         0   12   20       2    ; Not Set   Not Set   Not Set   
      if roombank=7 then plotmap  statusbar7  6         0   12   20       2    ; Not Set   Not Set   Not Set   
      if roombank=8 then plotmap  statusbar8  6         0   12   20       2    ; Not Set   Not Set   Not Set   
      if roombank=9 then plotmap  statusbar9  6         0   12   20       2    ; Not Set   Not Set   Not Set   
     if roombank=13 then plotmap  statusbar13 6         0   12   20       2    ; Not Set   Not Set   Not Set   
     if roombank=18 then plotmap  statusbar18 6         0   12   20       2    ; Not Set   Not Set   Not Set   
     savescreen
     goto skip_roomtype 
  ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────╯

roomtype_title
  ;╭─═◙ Plot Single Color Room Palette ◙═────────────────────────────────────────────────────────────────────╮
  ;  Entire screen is a single palette                                                               
     gosub multibankdrawscreen
     clearscreen
  ;                             ┌───────────┬─────────┬───┬───┬───────┬────────┬─────────┬─────────┬──────────┐       
  ;                             │  mapdata  │ palette │ X │ Y │ Width │ Height │ MapXOff │ MapYOff │ MapWidth │       
  ;                             └───────────┴─────────┴───┴───┴───────┴────────┴─────────┴─────────┴──────────┘       
                         plotmap  screenram   mytemp1  0    0    10       8         0         0         20    
                         plotmap  screenram   mytemp1  80   0    10       8         10        0         20   
                         plotmap  screenram   mytemp2  0    8    10       4         0         8         20    
                         plotmap  screenram   mytemp1  80   8    10       4         10        8         20  
                         plotmap  statusbar11 mytemp2  0   12    20       2        
     savescreen
     goto skip_roomtype 
  ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────╯

roomtype_quarters
  ;╭──═◙ Plot Room Quarter Palettes ◙═───────────────────────────────────────────────────────────────────────╮
  ;  Four screen quarters with different palettes                                               
     gosub multibankdrawscreen 
     clearscreen
  ;                             ┌───────────┬─────────┬───┬───┬───────┬────────┬─────────┬─────────┬──────────┐       
  ;                             │  mapdata  │ palette │ X │ Y │ Width │ Height │ MapXOff │ MapYOff │ MapWidth │       
  ;                             └───────────┴─────────┴───┴───┴───────┴────────┴─────────┴─────────┴──────────┘        
                         plotmap  screenram   mytemp1  0    0    10       6         0         0         20    
                         plotmap  screenram   mytemp2  80   0    10       6         10        0         20   
                         plotmap  screenram   mytemp3  0    6    10       6         0         6         20    
                         plotmap  screenram   mytemp4  80   6    10       6         10        6         20  
      if roombank=6 then plotmap  statusbar6   6       0    12   20       2    ; Not Set   Not Set   Not Set   
      if roombank=7 then plotmap  statusbar7   6       0    12   20       2    ; Not Set   Not Set   Not Set   
      if roombank=8 then plotmap  statusbar8   6       0    12   20       2    ; Not Set   Not Set   Not Set   
      if roombank=9 then plotmap  statusbar9   6       0    12   20       2    ; Not Set   Not Set   Not Set 
     if roombank=13 then plotmap  statusbar13  6       0    12   20       2    ; Not Set   Not Set   Not Set   
     savescreen 
  ;╰─────────────────────────────────────────────────────────────────────────────────────────────────────────╯
skip_roomtype


  gosub multibankdrawscreen
  restorescreen
  return otherbank

multibankdrawscreen
   ;┌──═◙ Jump to Bank Drawscreens ◙═─────────────────────────────────────────────────────────────────────────┐
   ;│  None of these banks have character gfx yet, so we just throw in a                                      │
   ;│  Dummy drawscreen in case they accidentally get called.                                                 │
   ;└─────────────────────────────────────────────────────────────────────────────────────────────────────────┘
   on roombank goto drawb0 drawb1 drawb2 drawb3 drawb4 drawb5 drawb6 drawb7 drawb8 drawb9 drawb10 drawb11 drawb12 drawb13 drawb14 drawb15 drawb16 drawb17 drawb18
drawb0
drawb1
drawb2
drawb3
drawb4
drawb5
drawb6
	gosub b6drawscreen bank6
	return
drawb7
	gosub b7drawscreen bank7
	return 
drawb8
	gosub b8drawscreen bank8
	return 
drawb9
	gosub b9drawscreen bank9
	return 
drawb10
	gosub b10drawscreen bank10
	return 
drawb11
	gosub b11drawscreen bank11
	return 
drawb12
	gosub b12drawscreen bank12
	return 
drawb13
	gosub b13drawscreen bank13
	return 
drawb14
	gosub b14drawscreen bank14
	return 
drawb15
drawb16
	clearscreen : rem ** draw a blank screen if we screw up and call the wrong draw
	BACKGRND=$00
	drawscreen
	return
drawb17
	gosub b17drawscreen bank17
	return 
drawb18
	gosub b18drawscreen bank18
	return 

  ;  ┌─────────────────────────────────────────┐
  ;  │ Room Numbers / Overworld  | Block 1     │   16x8      ▀Room contains an entrance to an alternate area 
  ;  ├═══════╗───────┬───────┬───────┬───────┬───────┬───────────────┬───────┬───────┬───────┬───────┬───────┬───────╔═══════╦═══════╗ 
  ;  │/  0 *a║†  1 † │†  2 † │†  3 † │†  4 † │†  5  †│†  6 ~f│†  7  †│†  8  †│~  9 ~ │~ 10 ~ │~ 11 ~ │~ 12 ~ │~ 13 ~ ║/ 14 \ │/ 15 *c║ 
  ;  ├───▀───╚═══════╦═══════╦═══════╬═══════╦═══════╦═══▀═══╦═══════╦═══════╦═══════╗───────┼───────┼───────┼───────╠───────┼───▀───╣ 
  ;  │/ 16 \ │/ 17 \ │/ 18 \ │/ 19 \ ║_ 20 _ │_ 21 _ │_ 22 _ │_ 23 _ │_ 24 _ │_ 25 _ ║† 26 $b│† 27 † │† 28 † │† 29 † ║/ 30 \ │/ 31 \ ║ 
  ;  ├───────┼───────┼───────┼───────╣───────┼───────┼───────┼───────┼───────┼───────╣═══▀═══╦═══════╦═══════╦═══════╣───────┼───────╣ 
  ;  │/ 32 \ │/ 33 \ │/ 34 \ │/ 35 \ ║_ 36 _ │_ 37 _ │_ 38 _ │_ 39 _ │_ 40 _ │_ 41 _ ║† 42 † │† 43 † │† 44 † │† 45 † ║/ 46 \ │/ 47 <s║ 
  ;  ├───────┼───────┼───────┼───────╣───────┼───────┼───────┼───────┼───────┼───────╣───────┼───────┼───────┼───────┼───────┼───▀───╣ 
  ;  │/ 48 \ │/ 49 \ │/ 50 *d│/ 51 \ ║_ 52 _ │_ 53 _ │_ 54 _ │_ 55 *e│_ 56 _ │_ 57 _ ║† 58 † │† 59 † │† 60 ~z│† 61 † ║/ 62 \ │/ 63 \ ║ 
  ;  ├───────┼───────┼───▀───┼───────╣───────┼───────┼───────┼───▀───┼───────┼───────╣───────┼───────┼───▀───┼───────┼───────┼───────╣ 
  ;  │/ 64 \ │/ 65 \ │/ 66 \ │/ 67 \ ║_ 68 _ │_ 69 _ │_ 70 _ │_ 71 _ │_ 72 _ │_ 73 _ ║† 74 † │† 75 † │† 76 † │† 77 † ║/ 78 \ │/ 79 \ ║ 
  ;  ├───────┼───────┼───────┼───────╣───────┼───────┼───────┼───────┼───────┼───────╣═══════════════════════════════╣───────┼───────╣ 
  ;  │/ 80 \ │/ 81 \ │/ 82 $c│/ 83 \ ║_ 84 _ │_ 85 <t│_ 86 _ │_ 87 _ │_ 88 _ │_ 89 _ ║~ 90 ~ │~ 91 ~ │~ 92 ~ │~ 93 ~ ║/ 94 \ │/ 95 \ ║  
  ;  ├───────┼───────┼───▀───┼───────╣───────┼───▀───┼───────┼───────┼───────┼───────╣───────┼───────┼───────┼───────╠───────┼───────╣ 
  ;  │/ 96 \ │/ 97 \ │/ 98 \ │/ 99 \ ║_100 _ │_ 101_ │_102 ~x│_103 _ │_104 _ │_105 _ ║~106 ~ │~107 ~ │~108 $a│~109 ~ ║/110 \ │/ 111\ ║ 
  ;  ├───────┼───────┼───────╔═══════╝───────┼───────┼───▀───┼───────┼───────┼───────╣───────┼───────┼───▀───┼───────╠───────┼───────╣ 
  ;  │/112 ^h│ 113 \ │/114 \ ║_115 _ │_116 _ │_ 117_ │_118 _ │_119 _ │_120 _ │_121 _ ║~122 ~ │~123 ~ │~124 ~ │~125 ~ ║/126 \ │/ 127*b║  
  ;  └───▀───┴───────┴───────╝───────┴───────┴───────┴───────┴───────┴───────┴───────╝───────┴───────┴───────┴───────╝═══════┴═══▀═══╝
  ;   *a	0	  West Mountain Dungeon	    $a	108	River Valley Marketplace	    ~x	102	Desert Castle             /\  Mountain Terrain
  ;   *b	127	South Mountain Dungeon		$b	26	North Forest Marketplace        ~z	60	Forest Castle             ††  Forest Terrain
  ;   *c    15	East Mountain Dungeon		$c  82  West Mountain Marketplace       ^h	112	Lake House	              ~~  Wetlands Terrain
  ;   *d    50 	High Mountain Dungeon	  	<t	85	South Desert Town               ^f  6   North Forest House        __  Desert Terrain
  ;   *e    55  North Desert Dungeon	    <s	47	East Mountain Town         
  ;
  ; ┌─────────────────────────────────────────┐     Mountain Grove
  ; │ Room Numbers / Town Map   | Block 2     │      Azémar Rehn                        
  ; │─────────────────────────────────────────│   North Forest House                      Status Screen 
  ; │crystal (Reserved)                       │        (Room 6)    Reserved    Reserved   (Right Button Press)
  ; ├──↓──┬──↓──┬─────┬─────┬─────┬─────┬─────┴─────┬─────┬──↓──┬──↓──┬─────┬─────┬──↓──┬──↓──┬─────┐ 
  ; │ 128 ║ 129 ║ 130◄═►131◄═►132 ║ 133◄═►134◄═►135◄═►136 ║ 137 ║ 138 ║ 139◄═►140 ║ 141 ║ 142 ║\143/―→ Treestoke Marketplace (West Mountain)
  ; ├─────┼  ↓  ┼  ♦  ┼  ♦  ┼  ♦  ║  ♦  ┼  ♦  ┼  ♦  ┼  ♦  ║─────┼─────┼  ♦  ┼  ♦  ┼─────├─────┼─────┤ 	     (Room 82)																													
  ; │ 144 │ 145 │ 146◄═►147◄═►148 ║ 149◄═►150◄═►151◄═►152 ║ 153◄═►154◄═►155◄═►156◄═►157 ║ 158 ║\159/―→ Stratford Marketplace (North Forest) Terillos Leptio 
  ; ├  ♦  ├─────┼  ♦  ┼─────┐  ♦  ║  ♦  ┼  ♦  ┼  ♦  ┼  ♦  ║─────┼  ♦  ┼─────┐  ♦  ┼  ♦  ║  ♦  ┼─────┤ 		 (Room 26)																												
  ; │ 160 │	161◄═►162◄═►163	│ 164 ║ 165◄═►166◄═►167◄═►168 ║ 169◄═►170◄═►171	│ 172◄═►173 ║ 174 ║\175/―→ Lake House
  ; ├  ♦  └─────┐─ ♦ ─┌─────┘  ♦  ║  ♦  ┐  ♦  ┼  ♦  ┼  ♦  ║  ♦  ┐─ ♦ ─┌─────┘  ♦  ┼  ♦  ║  ♦  ┼─────┤ 		 (Room 112)																												
  ; │ 176◄═►177 │\178/│ 179◄═►180 ║\181/│ 182◄═►183◄═►184 ║ 185 │\186/│ 187◄═►188◄═►189 ║\190/║\191/―→ Taunton River Valley Marketplace Fallard Huesten
  ; └─────┴─────┴──۩──┴─────┴─────┴──۩──┴─────┴─────┴─────┴─────┴──۩──┴─────┴─────┴─────┴──۩──┴─────┘      (Room 108)
  ;        South Desert Town    Forest Castle              East Mountain Town        Desert Castle       
  ;            Beckwourth          Welbeck                     Tattershall              Bledknot
  ;         Ugutz Rouestoff                                   Grimold Drexel       King Karles Derame
  ;            (Room 85)          (Room 60)                     (Room 186)             (Room 102)
  ;
  ; ┌─────────────────────────────────────────┐
  ; │ Room Numbers / Underworld | Block 3     │   16x4
  ; │─────────────────────────────────────────│  
  ; │ West Mountain Dungeon (Room 0) Kaktovik │  
  ; ├──↓──┬──═──┬──═──┬──═──┬──═──┬──═──┬──═──┴──═──┬──═──┬──═──┬─────┬─────┬─────┬──═──┬─────┬─────┐																								
  ; ║/192*═►193◄═►194◄═►195 ║ 196◄═►197◄═►198◄═►199 ║ 200◄═►201 ║ 202◄═►203◄═►204◄═►205 ║ 206◄═►207 ║  
  ; ├ ─═──═──═─ ┬─────═──═──║  ↕  ┼  ↕  ┼  ↕  ┼  ↕  ║  ↕  ┼  ↕  ║  ↕  ┼  ↕  ┼  ↕  ┼  ↕  ║  ↕  ┼  ↕  ┤ 																														
  ; ║ 208◄═►209   210◄═►211 ║ 212◄═►213◄═►214◄═►215 ║ 216◄═►217 ║ 218◄═►219◄═►220◄═►221 ║ 222◄═►223 ║
  ; ├  ↕ ─═  ↕ ─┘  ↕  ═  ↕  ║  ↕  ┼  ↕  ┼  ↕  ┼  ↕  ║  ↕  ┼  ↕  ║  ↕  ┼  ↕  ┌───────────┘  ↕  ┼  ↕  ┤ 																														
  ; ║ 224◄═►225◄═►226◄═►227 ║ 228◄═►229◄═►230◄═►231 ║ 232◄═►233	║ 234◄═►235 ║ 236◄═►237◄═►238◄═►239 ║
  ; ├  ↕  ═  ↕  ═  ↕  ═  ↕  ║  ↕  ┼  ↕  ┼  ↕  ┼  ↕  └──═──┐  ↕  ║  ↕  ┼  ↕  ║  ↕  ┼  ↕  ┼  ↕  ┼  ↕  ┤ 																														
  ; ║\240/│ 241◄═►242◄═►243 ║\244*  245◄═►246◄═►247◄═►248 ║\249*║\250*│ 251 ║\252*│ 253◄═►254◄═►255 ║
  ; └──۩──┴─────┴─────┴─────┴──۩──┴──═──┴──═──┴──═──┴──═──┴──۩──┴──۩──┴─────┴──۩──┴─────┴─────┴─────┘
  ; Unassigned                High                         North  East      South   
  ; Faulkton's Lair           Mountain                    Desert  Mountain  Mountain 
  ;                           Dungeon                    Dungeon  Dungeon   Dungeon  
  ;                           Silverpeak         Cavern of Hagan  Renick    Ravensworth Keep
  ;                           (Room 50)                 (Room 55) (Room 15) (Room 127) 
  ;
  ; Crystal Rooms
  ;  West Mountain Dungeon - Room 195 - Middle
  ;  Unassigned - Room 208 - Left Half
  ;  High Mountain Dungeon - Room 248 - Right side
  ;  North Desert Dungeon - Room 200 - Top
  ;  East Mountain Dungeon - Room 205 - Top Half
  ;  South Mountain Dungeon - Room 207 - Right side
  ;
  ; Dungeons - 192, 252, 250, 244, 249
  ; 240 not in use - use as a 2nd level for the High Mountain Dungeon

  ;╭──═◙ Room Data ◙═──────────────────────────────────────────────────────────────────────────────╮ 
     data room_shape
           0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,  15
          16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28,  29,  30,  31
          32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46,  47
          48,  49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62,  63
          64,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,  75,  76,  77,  78,  79
          80,  81,  82,  83,  84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94,  95
          96,  97,  98,  99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111
         112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127
         128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143
         144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159
         160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175
         176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191
         192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207
         208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223
         224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239
         240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255
end
     data room_type
          13,  13,  13,   0,   0,   0,   0,   0,   0,  16,  40,  40,  40,  40,  13,  13
          13,  27,  13,  13,  51,  42,  42,  42,  42,  53,  13,  13,  13,  13,  13,  13
          13,  27,  13,  13,  44,  41,  41,  41,  41,  45,  35,  29,  29,  34,  13,  13
          13,  13,  13,  13,  44,  41,  41,  41,  41,  45,   0,   0,   0,   0,  34,  13
          59,  58,  13,  13,  44,  41,  41,  41,  41,  45,   0,   0,   0,   0,  30,  13
          57,  56,  13,  13,  44,  41,  41,  41,  41,  45,  24,  15,  15,  26,  30,  13
          13,  13,  13,  13,  44,  41,  49,  43,  43,  50,  17,  27,  27,  18,  30,  13
          27,  27,  55,  55,  54,  41,  47,  15,  15,  15,  19,  15,  15,  20,  32,  13
           0, 129,   0,   0,   0,  83,  83,  83,  83,   0,   0,   0,   0, 141, 142,   0
           0,   0,   0,   0,   0,  83,  83,  83,  83,   0,   0,   0,   0,   0,  13,   0
           0,   0,   0,   0,   0,  83,  83,  83,  83,   0,   0,   0,   0,   0,  13,   0
           0,   0,   0,   0,   0,  83,  83,  83,  83,   0,  83,   0,   0,   0,  13,   0
          91,  91,  91,  91,  93,  93,  93,  93,  82,  82,  92,  92,  92,  92,  91,  91
          71,  71,  71,  71,  93,  93,  93,  93,  82,  82,  92,  92,  92,  92,  91,  91
          71,  71,  71,  71,  93,  93,  93,  93,  82,  82,  92,  92,  91,  91,  91,  91
          71,  71,  71,  71,  93,  93,  93,  93,  91,  82,  92,  92,  91,  91,  91,  91
end
     data move_north
           0,   0,   0,   0, 128,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
           0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,  15
          16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28,  29,  30,  31
          32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46,  47
          48,  49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62,  63
          64,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,  75,  76,  77,  78,  79
          80,  81,  82,  83,  84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94,  95
          96,  97,  98,  99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111
         112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127
         128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143
         144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159
         160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175
         176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191
         192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207
         208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223
         224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239
end
     data move_south
          16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28,  29,  30,  31
          32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46,  47
          48,  49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62,  63
          64,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,  75,  76,  77,  78,  79
          80,  81,  82,  83,  84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94,  95
          96,  97,  98,  99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111
         112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127
         128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143
           4, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159
         160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175
         176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191
         192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207
         208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223
         224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239
         240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255
           0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
end
    data move_west
           0,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14
           0,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28,  29,  30
           0,  32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46
           0,  48,  49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62
           0,  64,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,  75,  76,  77,  78
           0,  80,  81,  82,  83,  84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94
           0,  96,  97,  98,  99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110
           0, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126
           0, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142
           0, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158
           0, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174
           0, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190
           0, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206
           0, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222
           0, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238
           0, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254
end
    data move_east
           1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,  15,   0
          17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28,  29,  30,  31,   0
          33,  34,  35,  36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46,  47,   0
          49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62,  63,   0
          65,  66,  67,  68,  69,  70,  71,  72,  73,  74,  75,  76,  77,  78,  79,   0
          81,  82,  83,  84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94,  95,   0
          97,  98,  99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,   0
         113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127,   0
         129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143,   0
         145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159,   0
         161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175,   0
         177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191,   0
         193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207,   0
         209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223,   0
         225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239,   0
         241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255,   0
end
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────┘
 
   ;╭──═◙ Screen Map Data ◙═──────────────────────────────────────────────────────────────────────────┐
      data roommaplo
        <screen0map,   <screen1map,   <screen2map,   <screen3map,   <screen4map,   <screen5map
        <screen6map,   <screen7map,   <screen8map,   <screen9map,   <screen10map,  <screen11map
        <screen12map,  <screen13map,  <screen14map,  <screen15map,  <screen16map,  <screen17map
        <screen18map,  <screen19map,  <screen20map,  <screen21map,  <screen22map,  <screen23map
        <screen24map,  <screen25map,  <screen26map,  <screen27map,  <screen28map,  <screen29map
        <screen30map,  <screen31map,  <screen32map,  <screen33map,  <screen34map,  <screen35map
        <screen36map,  <screen37map,  <screen38map,  <screen39map,  <screen40map,  <screen41map
        <screen42map,  <screen43map,  <screen44map,  <screen45map,  <screen46map,  <screen47map
        <screen48map,  <screen49map,  <screen50map,  <screen51map,  <screen52map,  <screen53map
        <screen54map,  <screen55map,  <screen56map,  <screen57map,  <screen58map,  <screen59map
        <screen60map,  <screen61map,  <screen62map,  <screen63map,  <screen64map,  <screen65map
        <screen66map,  <screen67map,  <screen68map,  <screen69map,  <screen70map,  <screen71map
        <screen72map,  <screen73map,  <screen74map,  <screen75map,  <screen76map,  <screen77map
        <screen78map,  <screen79map,  <screen80map,  <screen81map,  <screen82map,  <screen83map
        <screen84map,  <screen85map,  <screen86map,  <screen87map,  <screen88map,  <screen89map
        <screen90map,  <screen91map,  <screen92map,  <screen93map,  <screen94map,  <screen95map
        <screen96map,  <screen97map,  <screen98map,  <screen99map,  <screen100map, <screen101map
        <screen102map, <screen103map, <screen104map, <screen105map, <screen106map, <screen107map
        <screen108map, <screen109map, <screen110map, <screen111map, <screen112map, <screen113map
        <screen114map, <screen115map, <screen116map, <screen117map, <screen118map, <screen119map
        <screen120map, <screen121map, <screen122map, <screen123map, <screen124map, <screen125map
        <screen126map, <screen127map, <screen128map, <screen129map, <screen130map, <screen131map
        <screen132map, <screen133map, <screen134map, <screen135map, <screen136map, <screen137map
        <screen138map, <screen139map, <screen140map, <screen141map, <screen142map, <screen143map
        <screen144map, <screen145map, <screen146map, <screen147map, <screen148map, <screen149map
        <screen150map, <screen151map, <screen152map, <screen153map, <screen154map, <screen155map
        <screen156map, <screen157map, <screen158map, <screen159map, <screen160map, <screen161map
        <screen162map, <screen163map, <screen164map, <screen165map, <screen166map, <screen167map
        <screen168map, <screen169map, <screen170map, <screen171map, <screen172map, <screen173map
        <screen174map, <screen175map, <screen176map, <screen177map, <screen178map, <screen179map
        <screen180map, <screen181map, <screen182map, <screen183map, <screen184map, <screen185map
        <screen186map, <screen187map, <screen188map, <screen189map, <screen190map, <screen191map
        <screen192map, <screen193map, <screen194map, <screen195map, <screen196map, <screen197map
        <screen198map, <screen199map, <screen200map, <screen201map, <screen202map, <screen203map
        <screen204map, <screen205map, <screen206map, <screen207map, <screen208map, <screen209map
        <screen210map, <screen211map, <screen212map, <screen213map, <screen214map, <screen215map
        <screen216map, <screen217map, <screen218map, <screen219map, <screen220map, <screen221map
        <screen222map, <screen223map, <screen224map, <screen225map, <screen226map, <screen227map
        <screen228map, <screen229map, <screen230map, <screen231map, <screen232map, <screen233map
        <screen234map, <screen235map, <screen236map, <screen237map, <screen238map, <screen239map
        <screen240map, <screen241map, <screen242map, <screen243map, <screen244map, <screen245map
        <screen246map, <screen247map, <screen248map, <screen249map, <screen250map, <screen251map
        <screen252map, <screen253map, <screen254map, <screen255map
end
      data roommaphi
        >screen0map,   >screen1map,   >screen2map,   >screen3map,   >screen4map,   >screen5map
        >screen6map,   >screen7map,   >screen8map,   >screen9map,   >screen10map,  >screen11map
        >screen12map,  >screen13map,  >screen14map,  >screen15map,  >screen16map,  >screen17map
        >screen18map,  >screen19map,  >screen20map,  >screen21map,  >screen22map,  >screen23map
        >screen24map,  >screen25map,  >screen26map,  >screen27map,  >screen28map,  >screen29map
        >screen30map,  >screen31map,  >screen32map,  >screen33map,  >screen34map,  >screen35map
        >screen36map,  >screen37map,  >screen38map,  >screen39map,  >screen40map,  >screen41map
        >screen42map,  >screen43map,  >screen44map,  >screen45map,  >screen46map,  >screen47map
        >screen48map,  >screen49map,  >screen50map,  >screen51map,  >screen52map,  >screen53map
        >screen54map,  >screen55map,  >screen56map,  >screen57map,  >screen58map,  >screen59map
        >screen60map,  >screen61map,  >screen62map,  >screen63map,  >screen64map,  >screen65map
        >screen66map,  >screen67map,  >screen68map,  >screen69map,  >screen70map,  >screen71map
        >screen72map,  >screen73map,  >screen74map,  >screen75map,  >screen76map,  >screen77map
        >screen78map,  >screen79map,  >screen80map,  >screen81map,  >screen82map,  >screen83map
        >screen84map,  >screen85map,  >screen86map,  >screen87map,  >screen88map,  >screen89map
        >screen90map,  >screen91map,  >screen92map,  >screen93map,  >screen94map,  >screen95map
        >screen96map,  >screen97map,  >screen98map,  >screen99map,  >screen100map, >screen101map
        >screen102map, >screen103map, >screen104map, >screen105map, >screen106map, >screen107map
        >screen108map, >screen109map, >screen110map, >screen111map, >screen112map, >screen113map
        >screen114map, >screen115map, >screen116map, >screen117map, >screen118map, >screen119map
        >screen120map, >screen121map, >screen122map, >screen123map, >screen124map, >screen125map
        >screen126map, >screen127map, >screen128map, >screen129map, >screen130map, >screen131map
        >screen132map, >screen133map, >screen134map, >screen135map, >screen136map, >screen137map
        >screen138map, >screen139map, >screen140map, >screen141map, >screen142map, >screen143map
        >screen144map, >screen145map, >screen146map, >screen147map, >screen148map, >screen149map
        >screen150map, >screen151map, >screen152map, >screen153map, >screen154map, >screen155map
        >screen156map, >screen157map, >screen158map, >screen159map, >screen160map, >screen161map
        >screen162map, >screen163map, >screen164map, >screen165map, >screen166map, >screen167map
        >screen168map, >screen169map, >screen170map, >screen171map, >screen172map, >screen173map
        >screen174map, >screen175map, >screen176map, >screen177map, >screen178map, >screen179map
        >screen180map, >screen181map, >screen182map, >screen183map, >screen184map, >screen185map
        >screen186map, >screen187map, >screen188map, >screen189map, >screen190map, >screen191map
        >screen192map, >screen193map, >screen194map, >screen195map, >screen196map, >screen197map
        >screen198map, >screen199map, >screen200map, >screen201map, >screen202map, >screen203map
        >screen204map, >screen205map, >screen206map, >screen207map, >screen208map, >screen209map
        >screen210map, >screen211map, >screen212map, >screen213map, >screen214map, >screen215map
        >screen216map, >screen217map, >screen218map, >screen219map, >screen220map, >screen221map
        >screen222map, >screen223map, >screen224map, >screen225map, >screen226map, >screen227map
        >screen228map, >screen229map, >screen230map, >screen231map, >screen232map, >screen233map
        >screen234map, >screen235map, >screen236map, >screen237map, >screen238map, >screen239map
        >screen240map, >screen241map, >screen242map, >screen243map, >screen244map, >screen245map
        >screen246map, >screen247map, >screen248map, >screen249map, >screen250map, >screen251map
        >screen252map, >screen253map, >screen254map, >screen255map
end
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────┘

                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 17 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
          
  ; Dungeon turn-based attack (initialize)   [call d_initialize_attack bank17]

                                                                                                        */                                                                                                         
 bank 17  

   ;╭──═◙ Bank 17 Graphics / Underworld ◙═───────────────────────────────────────────────────────────╮
     incgraphic tileset_dattack1.png 160A 0 1 2 3 1
     incgraphic tileset_dattack2.png 160A 0 1 2 3 1
     incgraphic tileset_dattack3.png 160A 0 1 2 3 1
     incgraphic tileset_dattack4.png 160A 0 1 2 3 1
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

b17drawscreen
   ;╭──═◙ Bank 17 Drawscreen ◙═──────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
     drawscreen
     drawwait 
     return otherbank

 alphachars ' abcdefghijklmnopqrstuvwxyzABCDEF' 

 alphadata statusbar17 tileset_dattack2
 'wjzzkzzlpqrstzzzzzzx'
 'umnyoyyABCDEyyyyyyyv'
end

d_initialize_attack
  ; This is called from bank18, and initializes all of the variables prior to the attack loop running.

  ;╭──═◙ Initial Enemy Location ◙═──────────────────────────────────────────────────────────────────────────────────╮
  ; 1-snake  2-bat  3-warrior  4-fighter  5-knight  6-hydra  7-minotaur  8-wizard 
  ;
  ; Lvl  Active Enemies            Battlefield
  ;      1-2-3-4-5-6-7-8  -Y- ┌────┬─────────┬────┐ -Y-  Line
  ; 0    0-0-0-X-X-X-X-X  80  │----\__text___/----│ 80   1 [X must be fixed to left or right side]
  ; 3    0-0-0-0-X-X-X-X  96  │-1---------7-------│ 96   2
  ; 7    0-0-0-0-0-X-X-X  112 │-----2----------6--│ 112  3
  ; 10   X-0-0-0-0-0-X-X  128 │---------3---------│ 128  4
  ; 16   X-0-0-0-0-0-0-X  144 │--8----------4-----│ 144  5
  ; 26   X-X-0-0-0-0-0-0  160 │-------5-----------│ 160  6
  ;                       176 │----/``text```\----│ 176  7 [not desirable, hero appears in status bar when attacking]
  ;                       -Y- └────┴─────────┴────┘ -Y-
     enemy1_x=142:          enemy1_y=96
     enemy2_x=(rand&63)+8:  enemy2_y=112
     enemy3_x=(rand&63)+58: enemy3_y=128
     enemy4_x=(rand&63)+24: enemy4_y=144
     enemy5_x=(rand&63)+36: enemy5_y=160
     enemy6_x=10:           enemy6_y=112
     enemy7_x=(rand&63)+18: enemy7_y=96
     enemy8_x=8:            enemy8_y=144
  ;╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

  ;╭──═◙ Enemy Hit Point Level Modifier ◙═────────────────────────────────────╮
    if Level<7              then LevelModifier=0         
    if Level>6  && Level<10 then LevelModifier=(rand&3)
    if Level>9  && Level<16 then LevelModifier=(rand&7)
    if Level>15 && Level<26 then LevelModifier=(rand&16)
    if Level>25             then LevelModifier=(rand&32)
  ;╰──────────────────────────────────────────────────────────────────────────╯
  ;╭──═◙ Enemy Hit Points ◙═──────────────────────────────────────────────────╮
    ; Modify/Increase enemy hitpoints based on your character level  
    ; If you wish to display a regular variable, 7800basic also includes a
    ; "converttobcd" utility function that returns the BCD value of a non-BCD 
    ; variable. The non-BCD variable should be in the range between 0-99, 
    ; or else it will start to display incorrect values.
    ;     BCDVar=converttobcd(NonBCDVar)

    temp1=converttobcd(LevelModifier)

    temp2=(rand&7)
    temp3=converttobcd(temp2)
    enemy1_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&7)
    temp3=converttobcd(temp2)
    enemy2_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&15)
    temp3=converttobcd(temp2)
    enemy3_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&15)
    temp3=converttobcd(temp2)
    enemy4_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&31)
    temp3=converttobcd(temp2)
    enemy5_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&63)
    temp3=converttobcd(temp2)
    enemy6_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&63)
    temp3=converttobcd(temp2)
    enemy7_HP=converttobcd(temp3)+converttobcd(temp1)

    temp2=(rand&63)
    temp3=converttobcd(temp2)
    enemy8_HP=converttobcd(temp3)+converttobcd(temp1)
  ;╰──────────────────────────────────────────────────────────────────────────╯

    enemy1_hit=0
    enemy2_hit=0
    enemy3_hit=0
    enemy4_hit=0
    enemy5_hit=0
    enemy6_hit=0
    enemy7_hit=0
    enemy8_hit=0
 
    ; DEBUG - Temporarily change starting level of player
    ; Level=$26

  ;╭──═◙ Enemy Hit Point Level Modifier ◙═────────────────────────────────────╮
    ; Enables specific enemies based on level, and updates "total_enemies" variable with the number of active enemies on-screen.
    if Level<3              then snake_flag=0 : bat_flag=0 :warrior_flag=0 : fighter_flag=3 : knight_flag=3 : hydra_flag=3 : minotaur_flag=3 : wizard_flag=3 : total_enemies=3 : XP_GainHi=$00:XP_GainMed=$00:XP_GainLo=$03       
    if Level>2  && Level<7  then snake_flag=0 : bat_flag=0 :warrior_flag=0 : fighter_flag=0 : knight_flag=3 : hydra_flag=3 : minotaur_flag=3 : wizard_flag=3 : total_enemies=4 : XP_GainHi=$00:XP_GainMed=$00:XP_GainLo=$19
    if Level>6  && Level<10 then snake_flag=0 : bat_flag=0 :warrior_flag=0 : fighter_flag=0 : knight_flag=0 : hydra_flag=3 : minotaur_flag=3 : wizard_flag=3 : total_enemies=5 : XP_GainHi=$00:XP_GainMed=$00:XP_GainLo=$47
    if Level>9  && Level<16 then snake_flag=3 : bat_flag=0 :warrior_flag=0 : fighter_flag=0 : knight_flag=0 : hydra_flag=0 : minotaur_flag=3 : wizard_flag=3 : total_enemies=5 : XP_GainHi=$00:XP_GainMed=$00:XP_GainLo=$69 
    if Level>15 && Level<26 then snake_flag=3 : bat_flag=0 :warrior_flag=0 : fighter_flag=0 : knight_flag=0 : hydra_flag=0 : minotaur_flag=0 : wizard_flag=3 : total_enemies=6 : XP_GainHi=$00:XP_GainMed=$01:XP_GainLo=$01
    if Level>25             then snake_flag=3 : bat_flag=3 :warrior_flag=0 : fighter_flag=0 : knight_flag=0 : hydra_flag=0 : minotaur_flag=0 : wizard_flag=0 : total_enemies=6 : XP_GainHi=$00:XP_GainMed=$01:XP_GainLo=$21
  ;╰──────────────────────────────────────────────────────────────────────────╯

  ;╭──═◙ Initialize Variables ◙═─────────────────────────────────────────────────────────╮
      ;Left Menu Icon selector
      selector_x=6:selector_y=21
      
      ;Right Menu Icon selector
      selector2_x=136:selector2_y=22

      ;11T-not in use
      selector3_x=enemy1_x:selector3_y=enemy1_y
      
      ;Reset Joystick & L/R Button Debounce Variables
      joyleftdebounce=0:joyrightdebounce=0:joyupdebounce=0:joydowndebounce=0:debounce=0:debounce2=0

      fight_menu=0 : parry_menu=0  : run_menu=0 : item_menu=0 : leftside=1 : rightside=0
      attackturn=0 : attack_odds=0 : hit_odds=0 : miss_odds=0 : run_odds=0

      attack_start=0:parry_result=0:run_result=0:end_battle=0:attack_active=1:check_gold=0:select_enemy=1:gold_found=0:XP_Check=0:firststrike=0
  ;╰─────────────────────────────────────────────────────────────────────────────────────╯
  hero_x=78:hero_y=158 
  return otherbank

CheckXP2
  ; Increase XP after a battle
  XP_Check=1
  dec XPLo=XPLo+XP_GainLo
  if CARRY then dec XPMed=XPMed+XP_GainMed+1 else dec XPMed=XPMed+XP_GainMed
  if CARRY then dec XPHi=XPHi+XP_GainHi+1 else dec XPHi=XPHi+XP_GainHi
  return otherbank

 

                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 18 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►

  ; Bank 18 Dungeon turn-based attack (loop)                                                                                                        */ 

 bank 18   

 ; Turn Attack

  ;╭──═◙ Bank 18 Graphics ◙═───────────────────────────────────────────────────────────────────────╮
    incgraphic tileset_dattack1.png 160A 0 1 2 3 1
    incgraphic tileset_dattack2.png 160A 0 1 2 3 1
    incgraphic tileset_dattack3.png 160A 0 1 2 3 1
    incgraphic tileset_dattack4.png 160A 0 1 2 3 1
    incgraphic icon_selector.png
    incgraphic icon_selector2.png
  ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

changetileram_bank18
  temp2=138
      screenram[temp2]=temproomlo[[temp2]]
  return otherbank

d_turnattackloop
     gosub d_initialize_attack bank17
     if Level<10            then active_enemy=1 :selector3b_x=enemy1_x: selector3b_y=(enemy1_y)+8
     if Level>9 && Level<26 then active_enemy=2 :selector3b_x=enemy2_x: selector3b_y=(enemy2_y)+8
     if Level>25            then active_enemy=3 :selector3b_x=enemy3_x: selector3b_y=(enemy3_y)+8
     lastroom=room
     room=138:clearscreen:gosub draw_room bank15
     savescreen

d_turnattackloop2
      restorescreen    

   ;╭──═◙ Victory! Return from Battle ◙═─────────────────────────────────────────╮
      if end_battle=0 then goto d_skiptheend
      if joy0fire1 then attack_active=0:goto d_GoBackHome
      ; Add Random amount of gold here.... not implemented yet....
      if check_gold=0 then gosub d_get_gold
      if XP_Check=0 then gosub CheckXP2 bank17
      if run_result<>1 then plotvalue tileset_dattack2 4 gold_found 2 32 11:plotchars 'gold found' 4 50 11
d_skiptheend
   ;╰────────────────────────────────────────────────────────────────────────────╯

   if select_enemy=1 then goto d_skiplrmenus

   ;╭──═◙ Left Menu (Actions) ◙═─────────────────────────────────────────────────────────────────────────────────────────────────╮
      if rightside=1 then d_skipleftmenu
            ; 21=Fight, 37=Run, 53=Parry, 69=Item
      selector_x=6
      if selector_y=21 && joydowndebounce=5 then selector_y=37:joydowndebounce=0:fight_menu=1:parry_menu=0:run_menu=0:item_menu=0
      if selector_y=37 && joydowndebounce=5 then selector_y=53:joydowndebounce=0:fight_menu=0:parry_menu=0:run_menu=1:item_menu=0
      if selector_y=53 && joydowndebounce=5 then selector_y=69:joydowndebounce=0:fight_menu=0:parry_menu=1:run_menu=0:item_menu=0
      if selector_y=69 && joydowndebounce=5 then selector_y=69:joydowndebounce=0:fight_menu=0:parry_menu=0:run_menu=0:item_menu=1
      if selector_y=21 && joyupdebounce=5   then selector_y=21:joyupdebounce=0:  fight_menu=1:parry_menu=0:run_menu=0:item_menu=0
      if selector_y=37 && joyupdebounce=5   then selector_y=21:joyupdebounce=0:  fight_menu=0:parry_menu=0:run_menu=1:item_menu=0
      if selector_y=53 && joyupdebounce=5   then selector_y=37:joyupdebounce=0:  fight_menu=0:parry_menu=1:run_menu=0:item_menu=0
      if selector_y=69 && joyupdebounce=5   then selector_y=53:joyupdebounce=0:  fight_menu=0:parry_menu=0:run_menu=0:item_menu=1
   ; ──═◙ FIGHT ◙═───────────────────────────────────────────────────────────────────────────────────────────
   ;  If left button pressed, left menu active, fight option selected, disable r/l menus and enable enemy selection.
      if selector_y=21 && debounce2=5 then debounce2=0:rightside=0:leftside=0:select_enemy=1:gosub multibankdrawscreen bank15
   ; ──═◙ RUN ◙═───────────────────────────────────────────────────────────────────────────────────────────
   ;  Check for Run option - one chance to be attacked again, then possibility of running away.
      if selector_y=37 && debounce2=5 && run_result=0 then debounce2=0:gosub d_run_check
      if run_result=1 then debounce=0:debounce2=0:leftside=0:rightside=0:selector2_x=200:selector2_y=200:selector_x=200:selector_y=200:select_enemy=0:selector3b_x=200:selector3b_y=200:plotchars 'you ran away' 3 31 11:end_battle=1 ;active_enemy=0
      if run_result=2 && select_enemy=0 && selector_y=37  then plotchars 'could not run' 4 28 11
   ; ──═◙ PARRY ◙═───────────────────────────────────────────────────────────────────────────────────────────
   ;  Check for Parry option - will eliminate any damage on next successful enemy attack.
      if selector_y=53 && debounce2=5 then debounce2=0:gosub d_parry_check 
      if parry_result=1 && selector_y=53 then hit_odds=0:plotchars 'defense up' 4 39 11
      if parry_result=2 && selector_y=53 then hit_odds=1:plotchars 'parry failed' 4 28 11
   ; ──═◙ ITEM ◙═───────────────────────────────────────────────────────────────────────────────────────────
   ;  Press the left button when "Item" is selected on the left side:  Moves you to the right side menu
      if selector_y=69 && debounce2=5 then debounce2=0:selector2_x=136:selector2_y=22:rightside=1:leftside=0
d_skipleftmenu
    ;╰───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 
    ;╭──═◙ Right Menu (Items) ◙═─────────────────────────────────────────────────────────────────────────────────────────────────╮
      if leftside=1 then d_skiprightmenu
      selector2_x=136

      if selector2_y=22 && joydowndebounce=5 then selector2_y=38:joydowndebounce=0
      if selector2_y=38 && joydowndebounce=5 then selector2_y=54:joydowndebounce=0
      if selector2_y=54 && joydowndebounce=5 then selector2_y=70:joydowndebounce=0
      if selector2_y=70 && joydowndebounce=5 then selector2_y=70:joydowndebounce=0

      if selector2_y=70 && joyupdebounce=5   then selector2_y=54:joyupdebounce=0
      if selector2_y=54 && joyupdebounce=5   then selector2_y=38:joyupdebounce=0
      if selector2_y=38 && joyupdebounce=5   then selector2_y=22:joyupdebounce=0
      if selector2_y=22 && joyupdebounce=5   then selector2_y=22: joyupdebounce=0

      ; Press Right button to select and use menu item on the right side
   ; ──═◙ HEALTH POTION ◙═──────────────────────────────────────────────────────────────────────────────────────────────────────
      if selector2_y=22 && debounce=5 && hpotion_val>0 then debounce=0:dec hpotion_val=hpotion_val-1:dec HP=HPMax: room=138:BACKGRND=$80:clearscreen:gosub draw_room bank15:savescreen:BACKGRND=$00
   ; ──═◙ MAGIC POTION ◙═───────────────────────────────────────────────────────────────────────────────────────────────────────
      if selector2_y=38 && debounce=5 && mpotion_val>0 then debounce=0:dec mpotion_val=mpotion_val-1:dec mana=manamax: room=138:BACKGRND=$80:clearscreen:gosub draw_room bank15:savescreen:BACKGRND=$00     
   ; ──═◙ MAGIC ITEM◙═──────────────────────────────────────────────────────────────────────────────────────────────────────────
      if selector2_y=54 && debounce=5 && magic_val>0   then debounce=0:dec magic_val=magic_val-1    :clearscreen:gosub draw_room bank15:savescreen                           ;magic item (round thing)
   ; ──═◙ RING  ◙═──────────────────────────────────────────────────────────────────────────────────────────────────────────────
      if selector2_y=70 && debounce=5 && ring_val>0    then debounce=0:dec ring_val=ring_val-1      :clearscreen:gosub draw_room bank15:savescreen                           ;ring
   ; ──═◙ EXIT RIGHT MENU   ◙═──────────────────────────────────────────────────────────────────────────────────────────────────
   ;  Left Joystick Press cancels and takes you back to main menu (Press Right Button to Select)
      if joyleftdebounce=5 then joyleftdebounce=0 :selector_x=6:selector_y=69:leftside=1:rightside=0
d_skiprightmenu
    ;╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
d_skiplrmenus

  ; If all enemies are killed, bounce back to left side menu, change to "victory" message and exit.
    if total_enemies=0 then debounce=0:debounce2=0:leftside=0:rightside=0:selector2_x=200:selector2_y=200:selector_x=200:selector_y=200:select_enemy=0:selector3b_x=200:selector3b_y=200:end_battle=1:plotchars 'victory' 3 52 1:active_enemy=0

  ; if right button is pressed and enemy selection is active, then disable enemy selection, go to left menu, fight option.
    if debounce=5 && select_enemy=1 then debounce=0:select_enemy=0:leftside=1:rightside=0:selector_x=6:selector_y=69

      framecounter1=framecounter1+1 
      if framecounter1>8 then framecounter1=0:framecounter2=framecounter2+1
      if framecounter2>3 then framecounter2=0

    ;╭──═◙ BATTLE ◙═─────────────────────────────────────────────────────────────────────────────────────────────────────────╮
      if select_enemy=0 then goto d_skipenemyplot     ; Skip the entire battle section if the menus on the top are active
    ; ───═◙ Conditions ◙═────────────────────────────────────────────────────────────────────────────────────────────────────
    ;
    ; *ENEMY SELECT ENABLED       select_enemy=1: Enemy selector is active
    ; ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ; *IDENTIFY ACTIVE ENEMY      active_enemy=<1-8>: Which enemy is actively selected
    ;                             1-snake  2-bat  3-warrior  4-fighter  5-knight  6-hydra  7-minotaur  8-wizard  9-skeleton 
    ; ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ; *TOTAL NUMBER OF ENEMIES    total_enemies=x: Number of active enemies that need to be killed (or get killed by!)
    ; ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ; *ENEMY ALIVE OR DEAD        <enemy_name>_flag=3/0:  If it is 0, the enemy is alive, if it is 3 the enemy has been killed.
    ; ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ; *ENEMY HITPOINTS REMAINING  enemy<x>_HP: The number of Hitpoints remaining for each enemy
    ; ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ; *ATTACK DAMAGE              attack_damage variable is how much damage you will do when you hit - with modifiers

    ;if attack_start=0 then plotchars 'press fire' 3 38 0:plotchars 'to attack' 3 38 1

    if hit_odds=9 && run_result<>1 && parry_result<>1 then plotchars 'you were hit' 5 31 11

   ;╭──═◙ Enemy Selection/Targeting ◙═──────────────────────────────────────────────────────────────────────────────────────╮
      if select_enemy=1 && debounce2=5 then debounce2=0 :firststrike =1: gosub d_next_enemy
      if active_enemy>8 then active_enemy=1
d_skipenemyselect
    ;╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

    if death_flag=1 then goto death_turnattackloop bank20

    ; avoid displaying any of the active enemy text until you've pressed the button for the first time
    if firststrike=0 then goto d_active_enemy_done

  on active_enemy goto d_enemy0 d_enemy1 d_enemy2 d_enemy3 d_enemy4 d_enemy5 d_enemy6 d_enemy7 d_enemy8
    ; 1-snake  2-bat      3-warrior  4-fighter  5-knight  6-hydra    7-minotaur  8-wizard 
    ;     new: 2-multibat 3-spider   4-ghost    5-demon   6-warlock  7-dragon

d_enemy0
   hero_x=78:hero_y=158 
d_enemy1
   plotchars 'snake'   7 36 4:hero_x=enemy1_x+4:hero_y=enemy1_y+11
   if snake_flag=3     && attack_odds=1 then plotchars 'killed' 7 36 3:goto d_active_enemy_done
   if enemy1_hit=1 then plotchars 'hit' 7 36 3 
   if enemy1_hit=0 then plotchars 'missed' 7 36 3 
   goto d_active_enemy_done
d_enemy2
   plotchars 'bats'     7 36 4:hero_x=enemy2_x+4:hero_y=enemy2_y+11
    if bat_flag=3      && attack_odds=1 then plotchars 'killed' 7 36 3:goto d_active_enemy_done
    if enemy2_hit=1 then plotchars 'hit' 7 36 3 
    if enemy2_hit=0 then plotchars 'missed' 7 36 3 
   goto d_active_enemy_done
d_enemy3
   plotchars 'spider' 7 36 4:hero_x=enemy3_x+4:hero_y=enemy3_y+11
    if warrior_flag=3  && attack_odds=1 then plotchars 'killed' 7 36 3:goto d_active_enemy_done
    if enemy3_hit=1 then plotchars 'hit' 7 36 3 
    if enemy3_hit=0 then plotchars 'missed' 7 36 3 
   goto d_active_enemy_done
d_enemy4
   plotchars 'ghost' 7 36 4:hero_x=enemy4_x+4:hero_y=enemy4_y+11
    if fighter_flag=3  && attack_odds=1 then plotchars 'killed' 7 36 3:goto d_active_enemy_done
    if enemy4_hit=1 then plotchars 'hit' 7 36 3 
    if enemy4_hit=0 then plotchars 'missed' 7 36 3 
   goto d_active_enemy_done
d_enemy5
   plotchars 'demon'  7 36 4:hero_x=enemy5_x+4:hero_y=enemy5_y+11
    ;if knight_flag=0   then plotchars 'knight'  3 36 2 
    if knight_flag=3   && attack_odds=1 then plotchars 'killed' 7 36 3:goto d_active_enemy_done
    if enemy5_hit=1 then plotchars 'hit' 7 36 3 
    if enemy5_hit=0 then plotchars 'missed' 7 36 3 
   goto d_active_enemy_done
d_enemy6
   plotchars 'warlock'   7 36 4:hero_x=enemy6_x+4:hero_y=enemy6_y+11
    if hydra_flag=3    && attack_odds=1 then plotchars 'killed' 7 36 3:goto d_active_enemy_done
    if enemy6_hit=1 then plotchars 'hit' 7 36 3 
    if enemy6_hit=0 then plotchars 'missed' 7 36 3 
   goto d_active_enemy_done
d_enemy7
   plotchars 'dragon' 7 36 4:hero_x=enemy7_x+4:hero_y=enemy7_y+11
    if minotaur_flag=3 && attack_odds=1 then plotchars 'killed' 7 36 3:goto d_active_enemy_done
    if enemy7_hit=1 then plotchars 'hit' 7 36 3 
    if enemy7_hit=0 then plotchars 'missed' 7 36 3 
   goto d_active_enemy_done
d_enemy8
   plotchars 'wizard'  7 36 4:hero_x=enemy8_x+4:hero_y=enemy8_y+11
    if wizard_flag=3   && attack_odds=1 then plotchars 'killed' 7 36 3:goto d_active_enemy_done
    if enemy8_hit=1 then plotchars 'hit' 7 36 3 
    if enemy8_hit=0 then plotchars 'missed' 7 36 3 
   goto d_active_enemy_done
d_active_enemy_done

    if select_enemy=0 then goto d_skipenemyplot 

    plotchars 'press fire' 3 38 0:plotchars 'to attack' 3 38 1

    if attack_start=1 then goto d_skiptherest1
    if snake_flag=0    then plotchars 'snake'   3 36 2:goto d_skiptherest1 
    if bat_flag=0      then plotchars 'bats'    3 36 2:goto d_skiptherest1  
    if warrior_flag=0  then plotchars 'spider'  3 36 2:goto d_skiptherest1   
    if fighter_flag=0  then plotchars 'ghost'   3 36 2:goto d_skiptherest1   
    if knight_flag=0   then plotchars 'demon'   3 36 2:goto d_skiptherest1   
    if hydra_flag=0    then plotchars 'warlock' 3 36 2:goto d_skiptherest1   
    if minotaur_flag=0 then plotchars 'dragon'  3 36 2:goto d_skiptherest1   
    if wizard_flag=0   then plotchars 'wizard'  3 36 2:goto d_skiptherest1  
d_skiptherest1


   ;╭──═◙ Plot Graphics ◙═───────────────────────────────────────────────────────────────────────────╮
   ; ──═◙ Enemies ◙═─────────────────────────────────────────────────────────────────────────────────
      ; 1-snake  2-bat      3-warrior  4-fighter  5-knight  6-hydra    7-minotaur  8-wizard   
      ;     new: 2-multibat 3-spider   4-ghost    5-demon   6-warlock  7-dragon
      if snake_flag=0    then plotsprite sprite_snake1b    3 enemy1_x   enemy1_y   framecounter2
      if bat_flag=0      then plotsprite sprite_multibat1  0 enemy2_x   enemy2_y   framecounter2
      if warrior_flag=0  then plotsprite sprite_spider1    0 enemy3_x   enemy3_y   framecounter2 
      if fighter_flag=0  then plotsprite sprite_ghost1     6 enemy4_x   enemy4_y   framecounter2   
      if knight_flag=0   then plotsprite sprite_demon1     1 enemy5_x   enemy5_y   framecounter2  
      if hydra_flag=0    then plotsprite sprite_warlock1   4 enemy6_x   enemy6_y   framecounter2   ;11r  -  5x test success
      if minotaur_flag=0 then plotsprite sprite_dragon1    4 enemy7_x   enemy7_y   framecounter2   ;11r
      if wizard_flag=0   then plotsprite sprite_wizard1b   5 enemy8_x   enemy8_y   framecounter2   ;11r
      ;plotsprite icon_selector2 framecounter1 selector3b_x selector3b_y ; selector sprite that's underneath the enemy.  Commented out in 12b, but works fine.
      plotvalue tileset_dattack2 5 attack_damage 2 107 5  
      plotvalue tileset_dattack2 3 enemy_HP 2 65 5  
      plotsprite herodown2 framecounter hero_x hero_y ; '0' replaced with 'framecounter' in 12b. Player flashes instead of using icon_selector2, saves one sprite plot command.
d_skipenemyplot
      if select_enemy=1 then goto d_victoryskip
      if leftside=1 then plotsprite icon_selector 3 selector_x selector_y
      if rightside=1 then plotsprite icon_selector2 3 selector2_x selector2_y
      plotvalue tileset_dattack2 3 ring_val    2 137 4
      plotvalue tileset_dattack2 5 hpotion_val 2 137 1
      plotvalue tileset_dattack2 4 mpotion_val 2 137 2
      plotvalue tileset_dattack2 3 magic_val   2 137 3
d_victoryskip
    ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯

      gosub multibankdrawscreen bank15                        ; Jumps to Drawscreen Subroutine

   goto d_turnattackloop2

d_GoBackHome
      ; Reset Palettes back to the default
      P1C1=$F1   :  P2C1=$80  :  P3C1=$1C  :  P4C1=$90  :  P5C1=$42  :  P6C1=$C6  :  P7C1=$E0
      P1C2=$F3   :  P2C2=$86  :  P3C2=$34  :  P4C2=$98  :  P5C2=$46  :  P6C2=$C4  :  P7C2=$08
      P1C3=$C0   :  P2C3=$F2  :  P3C3=$3A  :  P4C3=$0F  :  P5C3=$FF  :  P6C3=$F2  :  P7C3=$04
      room=lastroom
      if room<64              then characterset tileset_1:roombank=6:goto d_setroom  
      if room>63  && room<128 then characterset tileset_1:roombank=6:goto d_setroom
      if room>127 && room<192 then characterset tileset_5:roombank=7:goto d_setroom
      if room>191             then characterset tileset_5:roombank=8:goto d_setroom
d_setroom
      clearscreen
      gosub draw_room bank15
      return otherbank

d_next_enemy
    attack_start=1
    ; If the next enemy is dead, move to the next and check again
    if snake_flag=0     then active_enemy=1 : selector3b_x=enemy1_x: selector3b_y=(enemy1_y)+9 : goto d_attack_enemies
    if bat_flag=0       then active_enemy=2 : selector3b_x=enemy2_x: selector3b_y=(enemy2_y)+9 : goto d_attack_enemies
    if warrior_flag=0   then active_enemy=3 : selector3b_x=enemy3_x: selector3b_y=(enemy3_y)+9 : goto d_attack_enemies
    if fighter_flag=0   then active_enemy=4 : selector3b_x=enemy4_x: selector3b_y=(enemy4_y)+9 : goto d_attack_enemies
    if knight_flag=0    then active_enemy=5 : selector3b_x=enemy5_x: selector3b_y=(enemy5_y)+9 : goto d_attack_enemies
    if hydra_flag=0     then active_enemy=6 : selector3b_x=enemy6_x: selector3b_y=(enemy6_y)+9 : goto d_attack_enemies
    if minotaur_flag=0  then active_enemy=7 : selector3b_x=enemy7_x: selector3b_y=(enemy7_y)+9 : goto d_attack_enemies
    if wizard_flag=0    then active_enemy=8 : selector3b_x=enemy8_x: selector3b_y=(enemy8_y)+9 : goto d_attack_enemies

d_attack_enemies

    ;rand_encounter=(rand&127) ; 11u3
    temp4=converttobcd(rand_encounter)
    if temp4>60 then attack_odds=1
    if temp4<61 then attack_odds=0

    temp3=(rand&3)
    temp1=converttobcd(temp3)   ; Initial Random Damage
    temp2=converttobcd(STR)     ; Strength Modifier
    attack_damage=converttobcd(temp1)+converttobcd(temp2)

    ; you missed, exit the subroutine
    if attack_odds=1 then goto d_skipmiss1
    if active_enemy=1 then enemy1_hit=0: return
    if active_enemy=2 then enemy2_hit=0: return
    if active_enemy=3 then enemy3_hit=0: return
    if active_enemy=4 then enemy4_hit=0: return
    if active_enemy=5 then enemy5_hit=0: return
    if active_enemy=6 then enemy6_hit=0: return
    if active_enemy=7 then enemy7_hit=0: return
    if active_enemy=8 then enemy8_hit=0: return
d_skipmiss1
    ; You registered a hit, check and reduce HP

    ; If the attack damage is higher than the enemy's hitpoints, immediate death
    if active_enemy=1 && attack_damage>=enemy1_HP then snake_flag=3     :enemy1_hit=1: goto d_move_selector
    if active_enemy=2 && attack_damage>=enemy2_HP then bat_flag=3       :enemy2_hit=1: goto d_move_selector
    if active_enemy=3 && attack_damage>=enemy3_HP then warrior_flag=3   :enemy3_hit=1: goto d_move_selector
    if active_enemy=4 && attack_damage>=enemy4_HP then fighter_flag=3   :enemy4_hit=1: goto d_move_selector
    if active_enemy=5 && attack_damage>=enemy5_HP then knight_flag=3    :enemy5_hit=1: goto d_move_selector
    if active_enemy=6 && attack_damage>=enemy6_HP then hydra_flag=3     :enemy6_hit=1: goto d_move_selector
    if active_enemy=7 && attack_damage>=enemy7_HP then minotaur_flag=3  :enemy7_hit=1: goto d_move_selector
    if active_enemy=8 && attack_damage>=enemy8_HP then wizard_flag=3    :enemy8_hit=1: goto d_move_selector
     
    temp_attack1=attack_damage
    if active_enemy=1 then dec enemy1_HP=enemy1_HP-temp_attack1:enemy1_hit=1:goto d_enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=2 then dec enemy2_HP=enemy2_HP-temp_attack1:enemy2_hit=1:goto d_enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=3 then dec enemy3_HP=enemy3_HP-temp_attack1:enemy3_hit=1:goto d_enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=4 then dec enemy4_HP=enemy4_HP-temp_attack1:enemy4_hit=1:goto d_enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=5 then dec enemy5_HP=enemy5_HP-temp_attack1:enemy5_hit=1:goto d_enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=6 then dec enemy6_HP=enemy6_HP-temp_attack1:enemy6_hit=1:goto d_enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=7 then dec enemy7_HP=enemy7_HP-temp_attack1:enemy7_hit=1:goto d_enemy_strikes_back
    temp_attack1=attack_damage
    if active_enemy=8 then dec enemy8_HP=enemy8_HP-temp_attack1:enemy8_hit=1:goto d_enemy_strikes_back
    return

d_move_selector
    hit_odds=0 ; * remove 'you were hit' message when you move on to the next enemy
    if snake_flag=0     then selector3b_x=enemy1_x: selector3b_y=(enemy1_y)+9 :     attack_start=0:return
    if bat_flag=0       then selector3b_x=enemy2_x: selector3b_y=(enemy2_y)+9 :     attack_start=0:return
    if warrior_flag=0   then selector3b_x=enemy3_x: selector3b_y=(enemy3_y)+9 :     attack_start=0:return
    if fighter_flag=0   then selector3b_x=enemy4_x: selector3b_y=(enemy4_y)+9 :     attack_start=0:return
    if knight_flag=0    then selector3b_x=enemy5_x: selector3b_y=(enemy5_y)+9 :     attack_start=0:return
    if hydra_flag=0     then selector3b_x=enemy6_x: selector3b_y=(enemy6_y)+9 :     attack_start=0:return
    if minotaur_flag=0  then selector3b_x=enemy7_x: selector3b_y=(enemy7_y)+9 :     attack_start=0:return
    if wizard_flag=0    then selector3b_x=enemy8_x: selector3b_y=(enemy8_y)+9 :     attack_start=0:return 
    return

d_enemy_strikes_back
       if parry_result=1 then parry_result=0:return ; Enemy attack fails when you just selected parry 
    ;rand_encounter=(rand&127) ; 11u3
    temp4=converttobcd(rand_encounter)

    ;Damage will always be between 1-3 HP
    ;Less damage is more likely

    if temp4>20 && temp4<100 then hit_odds=1      ; -1HP             
    if temp4>99 && temp4<120 then hit_odds=5      ; -2HP          
    if temp4>119 && temp4<131 then hit_odds=7     ; -3HP            

    ; Prior to 12h, the next line included "HP=HP-temp1", which removed over 30HP at once rather than the value of temp1 a single time.  Changing to just 1 worked.

    if hit_odds=1 && HP>0 then hit_odds=0:dec HP=HP-1:hit_odds=9
    if hit_odds=1 && HP<2 then hit_odds=0:dec HP=0:death_flag=1

    if hit_odds=5 && HP>1 then hit_odds=0:dec HP=HP-2:hit_odds=9
    if hit_odds=5 && HP<3 then hit_odds=0:dec HP=0:death_flag=1
    
    if hit_odds=7 && HP>2 then hit_odds=0:dec HP=HP-3:hit_odds=9
    if hit_odds=7 && HP<4 then hit_odds=0:dec HP=0:death_flag=1

    ; A clearscreen, redraw, and savescreen is necessary in order to update the plotvalues without glitches.
    ; I added the red screen to indicate that you've been hit, it worked out pretty well, as the flash is now red. :D
    if hit_odds=9 then BACKGRND=$40: room=129:clearscreen:gosub draw_room bank15:savescreen:BACKGRND=$00

    return

d_parry_check
    ;rand_encounter=(rand&127)      ; 11u3
    temp4=converttobcd(rand_encounter)
    ;Defensive Move - reduce chances of a hit on the next round
    if temp4>60 then parry_result=1 ; Defense Enanced
    if temp4<61 then parry_result=2 ; Failed attempt
    return

d_run_check
    ;rand_encounter2=(rand&127)      ; 11u3
    temp4=converttobcd(rand_encounter2)
    ;Run away from a fight.  Running away opens you up to an attack.
    gosub d_enemy_strikes_back
    if temp4>120 then run_result=1 ; you ran away
    if temp4<121 then run_result=2 ; you're stuck
    return

d_get_gold
    ;Adds gold and XP after killing all enemies
    temp1=(rand&3)+1:temp2=(rand&7)+1:temp3=(rand&15)+1:temp4=(rand&31)+5:temp5=(rand&63)+12
    if Level<7              then gold_found=converttobcd(temp1)        
    if Level>6  && Level<10 then gold_found=converttobcd(temp2)
    if Level>9  && Level<16 then gold_found=converttobcd(temp3)
    if Level>15 && Level<26 then gold_found=converttobcd(temp4)
    if Level>25             then gold_found=converttobcd(temp5)
    dec score0=score0+gold_found
    check_gold=1
    return

b18drawscreen
   ;╭──═◙ Bank 18 Drawscreen ◙═──────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
    drawscreen
    if hit_odds=9 then hit_odds=0:restorescreen
    ; Random Number generation removed from subroutines in 11u3, moved here for testing.
    ; Original locations commented with 11u3
    rand_encounter=(rand&127)
    rand_encounter2=(rand&127)
    low_damage=(rand&7)
    mid_damage=(rand&31)
    if snake_flag=3 && bat_flag=3 && warrior_flag=3 && fighter_flag=3 && knight_flag=3 && hydra_flag=3 && minotaur_flag=3 && wizard_flag=3 then total_enemies=0
   ;╭──═◙ Joystick Movement & Firing Debounce ◙═────────────────────────────────────────────────────╮
      if joy0fire1 then debounce2=9                       ;Left Button
      if !joy0fire1 && debounce2=9 then debounce2=5
      if joy0fire0 then debounce=9                        ;Right Button
      if !joy0fire0 && debounce=9 then debounce=5
      if joy0up then joyupdebounce=9
      if !joy0up && joyupdebounce=9 then joyupdebounce=5
      if joy0down then joydowndebounce=9
      if !joy0down && joydowndebounce=9 then joydowndebounce=5
      if joy0right then joyrightdebounce=9
      if !joy0right && joyrightdebounce=9 then joyrightdebounce=5
      if joy0left then joyleftdebounce=9
      if !joy0left && joyleftdebounce=9 then joyleftdebounce=5
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
   ;╭──═◙ Shows the current HP of the active enemy ◙═───────────────────────────────────────────────╮
      if active_enemy=1 then enemy_HP=enemy1_HP
      if active_enemy=2 then enemy_HP=enemy2_HP
      if active_enemy=3 then enemy_HP=enemy3_HP 
      if active_enemy=4 then enemy_HP=enemy4_HP
      if active_enemy=5 then enemy_HP=enemy5_HP 
      if active_enemy=6 then enemy_HP=enemy6_HP
      if active_enemy=7 then enemy_HP=enemy7_HP
      if active_enemy=8 then enemy_HP=enemy8_HP
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
   ;╭──═◙ Displays amount of damage to enemy ◙═─────────────────────────────────────────────────────╮
      if enemy1_hit=0 && active_enemy=1 then attack_damage=$00
      if enemy2_hit=0 && active_enemy=2 then attack_damage=$00
      if enemy3_hit=0 && active_enemy=3 then attack_damage=$00
      if enemy4_hit=0 && active_enemy=4 then attack_damage=$00
      if enemy5_hit=0 && active_enemy=5 then attack_damage=$00
      if enemy6_hit=0 && active_enemy=6 then attack_damage=$00
      if enemy7_hit=0 && active_enemy=7 then attack_damage=$00
      if enemy8_hit=0 && active_enemy=8 then attack_damage=$00
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
      ;if total_enemies=0 then goto d_skipdisplay6     
      ;plotsprite herodown2  0 78 158  
d_skipdisplay6


         ; ──═◙ Status Bar ◙═──────────────────────────────────────────────────────────────────────────────
      plotvalue tileset_dattack2 3 HP    2 19 12  :  plotvalue tileset_dattack2 3 HPMax   2 39 12
      plotvalue tileset_dattack2 3 mana   2 19 13  :  plotvalue tileset_dattack2 3 manamax 2 39 13
      plotvalue tileset_dattack2 3 score0 6 106 12

     drawwait 
     return otherbank

d_health_increase
     ; One Potion gives you 10HP
     HP=HPMax:return
     temp1=converttobcd(HPMax)+$10
     if HP+$10=temp1 then HP=HPMax:return       ; If current HP + 10 equals the maximum, set HP to max and return
     if HP+$10>temp1 then HP=HPMax:return       ; If current HP + 10 is greater than the Maximum, set HP to max and return
     if HP+$10<temp1 then dec HP=HP+$10:return  ; If current HP + 10 is less than the maximum, add 10 to your HP and return
     return

 alphachars ' abcdefghijklmnopqrstuvwxyzABCDEF' 

 alphadata statusbar18 tileset_dattack2
 'wjzzkzzlpqrstzzzzzzx'
 'umnyoyyABCDEyyyyyyyv'
end
                                                                                                            /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 19 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 


 bank 19  

                                                                                                         /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 20 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 

 bank 20  
 
  ; Death - Overworld Turn Attack

  ; Screen is entered when HP falls to zero
  ; Explosion of player sprite occurs
  ; loop then waits for right button press to return you to the cabin starting location
  ; HP is restored to the Max Value, no other stats or gold is affected - may want to change that?  Lose Gold or XP upon death?

  ;╭──═◙ Bank 20 Graphics ◙═───────────────────────────────────────────────────────────────────────╮
    incgraphic tileset_attack21.png 160A 0 1 2 3 1
    incgraphic tileset_attack22.png 160A 0 1 2 3 1
    incgraphic tileset_attack23.png 160A 0 1 2 3 1
    incgraphic tileset_attack24.png 160A 0 1 2 3 1
  ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯


death_turnattackloop
     room=129:clearscreen:gosub draw_room bank15
     savescreen
     end_battle=0
     framecounter1=0
     framecounter2=0
     ;hero_x=80:hero_y=120 ; DEBUG - Place in center of screen for testing

death_turnattackloop2
   characterset tileset_1
   restorescreen    

   if end_battle=0 then BACKGRND=$40
   if end_battle=1 then BACKGRND=$00

      if joy0fire1 then debounce2=9                       ;Left Button
      if !joy0fire1 && debounce2=9 then debounce2=5
      if joy0fire0 then debounce=9                        ;Right Button
      if !joy0fire0 && debounce=9 then debounce=5

   if debounce=5 then debounce=0:end_battle=0:death_flag=0:goto death_GoBackHome

   framecounter1=framecounter1+1 
   if framecounter1>8 then framecounter1=0:framecounter2=framecounter2+1
   if framecounter2>8 then framecounter2=0:end_battle=1
  
   if end_battle=0 then plotsprite sprite_explode1 0 hero_x hero_y  framecounter2 ; Hero explosion
   plotvalue tileset_attack2 3 HP    2 19 12  :  plotvalue tileset_attack2 3 HPMax   2 39 12
   plotvalue tileset_attack2 3 mana   2 19 13  :  plotvalue tileset_attack2 3 manamax 2 39 13
   plotvalue tileset_attack2 3 score0 6 106 12

   gosub multibankdrawscreen bank15                        ; Jumps to Drawscreen Subroutine

   goto death_turnattackloop2

death_GoBackHome
      ; Reset Palettes back to the default
      P1C1=$F1   :  P2C1=$80  :  P3C1=$1C  :  P4C1=$90  :  P5C1=$42  :  P6C1=$C6  :  P7C1=$E0
      P1C2=$F3   :  P2C2=$86  :  P3C2=$34  :  P4C2=$98  :  P5C2=$46  :  P6C2=$C4  :  P7C2=$08
      P1C3=$C0   :  P2C3=$F2  :  P3C3=$3A  :  P4C3=$0F  :  P5C3=$FF  :  P6C3=$F2  :  P7C3=$04
      room=137:xpos=28:ypos=26 ; Reset to top left location in mountain grove home (Room 137, in bed).
      HP=HPMax                 ; Reset Health to Maximum Value
      if room<64              then characterset tileset_1:roombank=6:goto death_setroom5  
      if room>63  && room<128 then characterset tileset_1:roombank=6:goto death_setroom5
      if room>127 && room<192 then characterset tileset_5:roombank=7:goto death_setroom5
      if room>191             then characterset tileset_5:roombank=8:goto death_setroom5
death_setroom5
      clearscreen
      gosub draw_room bank15
      return otherbank

changetileram_bank20
  temp2=129
      screenram[temp2]=temproomlo[[temp2]]
  return otherbank

b20drawscreen
   ;╭──═◙ Bank 20 Drawscreen ◙═──────────────────────────────────────────────────────────────────────╮
   ; We need to wait for the end of the visible screen before we switch away, or the characters in
   ; this bank won't be drawn correctly. This does reduce CPU time for the rest of the game.
   ;╰───────────────────────────────────────────────────────────────────────────────────────────────╯
     drawscreen
     drawwait 
     return otherbank


                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 21 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 

 bank 21  

                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 22 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 

 bank 22   

                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 23 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 

 bank 23   

                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 24 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 


 bank 24   

                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 25 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 


 bank 25   


                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 26 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 


 bank 26   

                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 27 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 


 bank 27   

                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 28 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 


 bank 28   

                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 29 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 


 bank 29   

                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 30 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 

 bank 30   

                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 31 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 


 bank 31                                                                                                       
                                                                                                        /* 
◄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▌ BANK 32 ▐■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■►
                                                                                                        */ 
 bank 32
  
   ;┌──═◙ Bank 32 Graphics ◙═────────────────────────────────────────────────────────────────────────═■
   ;│ Bank 32 Graphics are always available
   ; new: dragon, ghost, spider, warlock, demon
      incgraphic arrowblock2.png
      incgraphic sprite_gold.png
      incgraphic sprite_dragon1.png
      incgraphic sprite_dragon2.png
      incgraphic sprite_dragon3.png
      incgraphic sprite_dragon4.png
      incgraphic sprite_ghost1.png
      incgraphic sprite_ghost2.png
      incgraphic sprite_ghost3.png
      incgraphic sprite_ghost4.png
      incgraphic sprite_spider1.png
      incgraphic sprite_spider2.png
      incgraphic sprite_spider3.png
      incgraphic sprite_spider4.png  
      incgraphic sprite_warlock1.png
      incgraphic sprite_warlock2.png
      incgraphic sprite_warlock3.png
      incgraphic sprite_warlock4.png
      incgraphic sprite_demon1.png
      incgraphic sprite_demon2.png
      incgraphic sprite_demon3.png
      incgraphic sprite_demon4.png
      incgraphic sprite_warrior1b.png
      incgraphic sprite_warrior2b.png
      incgraphic sprite_warrior3b.png
      incgraphic sprite_warrior4b.png
      incgraphic sprite_fighter1b.png 
      incgraphic sprite_fighter2b.png 
      incgraphic sprite_fighter3b.png 
      incgraphic sprite_fighter4b.png 
      incgraphic sprite_knight1b.png   
      incgraphic sprite_knight2b.png 
      incgraphic sprite_knight3b.png 
      incgraphic sprite_knight4b.png       
      incgraphic sprite_wizard1b.png   
      incgraphic sprite_wizard2b.png  
      incgraphic sprite_wizard3b.png  
      incgraphic sprite_wizard4b.png 
      incgraphic sprite_bat1b.png 
      incgraphic sprite_bat2b.png
      incgraphic sprite_bat3b.png
      incgraphic sprite_bat4b.png
      incgraphic sprite_snake1b.png 
      incgraphic sprite_snake2b.png
      incgraphic sprite_snake3b.png
      incgraphic sprite_snake4b.png
      incgraphic sprite_hydra1b.png 
      incgraphic sprite_hydra2b.png 
      incgraphic sprite_hydra3b.png 
      incgraphic sprite_hydra4b.png 
      incgraphic sprite_skeleton1b.png 
      incgraphic sprite_skeleton2b.png 
      incgraphic sprite_skeleton3b.png 
      incgraphic sprite_skeleton4b.png 
      incgraphic sprite_minotaur1b.png 
      incgraphic sprite_minotaur2b.png 
      incgraphic sprite_minotaur3b.png 
      incgraphic sprite_minotaur4b.png
      incgraphic sprite_luteplayer.png
      incgraphic sprite_king.png
      incgraphic sprite_multibat1.png
      incgraphic sprite_multibat2.png
      incgraphic sprite_multibat3.png
      incgraphic sprite_multibat4.png
      newblock
      incgraphic sprite_man1.png
      incgraphic sprite_man2.png
      incgraphic sprite_man3.png 
      incgraphic herodown1.png
      incgraphic herodown3.png
      incgraphic herodown2.png
      incgraphic heroleft1.png
      incgraphic heroleft3.png
      incgraphic heroleft2.png
      incgraphic heroup1.png
      incgraphic heroup3.png
      incgraphic heroup2.png
      incgraphic heroright1.png
      incgraphic heroright3.png
      incgraphic heroright2.png
      incgraphic swordfire.png
      incgraphic icon_potion.png
      incgraphic icon_sword.png
      incgraphic icon_armor.png
      incgraphic icon_ring.png
      incgraphic icon_key.png
      incgraphic icon_shield.png
      incgraphic sprite_house.png
      incgraphic sprite_largehouse.png
      incgraphic sprite_castle.png
      incgraphic sprite_town.png
      incgraphic sprite_boulder.png
      incgraphic sprite_marketplace.png
      incgraphic arrowblock.png
      incgraphic icon_crystal.png
      incgraphic sword_lr.png
      incgraphic sword_ud.png
      incgraphic icon_empty.png
      incgraphic icon_letter.png
      incgraphic sprite_shopkeeper.png
      incgraphic wave1.png
      incgraphic wave2.png
      incgraphic wave3.png
      incgraphic wave4.png
      incgraphic wave5.png
      incgraphic wave6.png
      incgraphic eyes.png
      incgraphic eyes2.png
      incgraphic eyes3.png
      incgraphic eyes4.png
      incgraphic eyes5.png
      incgraphic eyes6.png
      incgraphic sprite_explode1.png
      incgraphic sprite_explode2.png
      incgraphic sprite_explode3.png
      incgraphic sprite_explode4.png
      incgraphic sprite_explode5.png
      incgraphic sprite_explode6.png
      incgraphic sprite_explode7.png
      incgraphic sprite_explode8.png
      incgraphic steveengelhardt.png
   ;╰─────────────────────────────────────────────────────────────────────────────────────────────────┘

                                                                                                                                                                                                                       /* 
Realm: Midlothia

Areas: Treestoke Mountains, Mountain Grove, Midlothian Desert, Silver Peak Mountains, Taunton River Valley

Azémar Rehn (player) starts in the Mountain Grove Home (house icon). x
Ugutz Rouestoff can be found in the (Room 85) City of Beckwourth.  x
Grimold Drexel can be found in the (Room 186) City of Tattershall. x
King Karles Derame can be found in (Room 102) Castle Bledknot. x
Terillos Leptio can be found in (room 60) Castle Welbeck. x
Fallard Huesten runs the (Room 108) Masham Marketplace in the Taunton River Valley:
Terillos Leptio runs the (Room 26) Stratford Marketplace.
Adlez Knil is the antagonist of the story.
Nonnag is the final boss monster.

─────────────────────────────────────────────────────────────────────────────────────────
Map Area                  Room Change   ^Name                        ^Boss
*West Mountain Dungeon    [0  ―→ 192]   The Dungeon of Kaktovik      Kaktovik
*High Mountain Dungeon    [50 ―→ 244]   The Chamber of Silver Peak   Nonnag
*East Mountain Dungeon    [15 ―→ 250]   The Vault of Renick          Renick
*North Desert Dungeon     [55 ―→ 249]   The Cavern of Hagan          Hagan
*South Mountain Dungeon   [127―→ 252]   Ravensworth Keep             Richbeorne
─────────────────────────────────────────────────────────────────────────────────────────
Map Area                  Room Change  ^Name                        ^Primary Character
*Forest Castle            [60 ―→ 181]   Castle Welbeck               King Riswil Thoswith
*Lake House               [112―→ 175]   Lake Chetfast House          Werd Sephmond
*Desert Castle            [102―→ 190]   Castle Bledknot              King Karles Derame
*River Valley Marketplace [108―→ 191]   Masham Marketplace           Fallard Huesten 
*North Forest Marketplace [26 ―→ 159]   Stratford Marketplace        Terillos Leptio 
*South Desert Town        [85 ―→ 178]   City of Beckwourth           Ugutz Rouestoff
*East Mountain Town       [47 ―→ 186]   City of Tattershall          Grimold Drexel
*Mountain Marketplace     [82 ―→ 143]   Treestoke Marketplace        Nasdun Forthead
*North Forest House       [6  ―→ 143]   Mountain Grove               Azémar Rehn (player) 
─────────────────────────────────────────────────────────────────────────────────────────
Crystal Numbers in the Code
*1 Glory   Katkovik	  	West Mountain		Crystal 1
*2 Loyalty Faulkton	  	Hidden		    	Crystal 2
*3 Wrath   Nonnag    		High Mountain		Crystal 3
*4 Wisdom  Hagan	     	North Desert  	Crystal 4
*5 Trust   Renick	    	East Mountain		Crystal 5
*6 Courage Ravensworth Keep	South Mountain		Crystal 6
*7 Virtue  Moutain Grove Forest Secret Forest Room   	Crystal 7	
─────────────────────────────────────────────────────────────────────────────────────────
Crystals in Order of Discovery
Glory   1 Katkovik
Courage 6 Ravensworth Keep
Virtue  7 Moutain Grove Forest
Wisdom  4 Hagan
Trust   5 Renick
Loyalty 2 Faulkton
Wrath   3 Nonnag  
─────────────────────────────────────────────────────────────────────────────────────────

--Story-------------

You are Azémar Rehn, a simple woodsman from Mountain Home Grove, a beautiful patch of forest just east of the Trestoke Mountains.  
You set out from your homeland to reunite with your Uncle after your father's death.  Unfortunately, upon your arrival, your Uncle is no where to be found.  
A short note is left in the Cabin, but it's not as helpful as you'd like it to be.

You'd heard of the war, and how all the most virtuous crystals that were revered by the people of Midlothia were captured and scattered into the deepest dungeons. 
They are fiercely guarded by powerful men who are determined to crush the will and spirit of the people.  Without their beloved symbols of virtue, the entire realm
had been taken over by mercenaries and theives, bent on taking whatever they can for their own selfish gain. No power or virtue of man could ever have deserved
that what has been fated should not have taken place. Feelings of hopelessness and misery abound, and no one has risen to the challenge of ridding the land of these thieves.

No one with good intent, that is.  One powerful warrior, who calls himself Nonnag, who's mere prescences strikes fear in the hearts of men, has spread his evil 
throughout the realm.  He created the the Crystal of Wrath, which serves as a beacon for those who serve evil purposes.  It must be captured and destroyed in order to bring 
peace, light, and life back to Midlothia.  The common people are waiting for a hero to emerge.  Once who can vanquish the evil, recapture the crystals, and restore 
the rod of life.  Only this man is worthy of being crowned the next King of Midlothia.  Great crisis produce great men and great deeds of courage.

The Midlothian army has long disbanded.  With their tragic losses and lack of leadership, hope was lost.  Soldiers are citizens of death's grey land, 
drawing no dividend from time's tomorrows.  It is now up to Azemar to restore order, to agree to the ultimate sacrifice for the sake of his homeland.  
As soon as sacrifice becomes a duty and necessity to mankind, there is no limit to the horizon which opens before him.

Game Flow/Progression (*TS-Text Screens)
No XP or Level requirements have been added for entrance to any dungeons, may want to add that if level grinding is desired as a requirement.

Crystals in Order of Discovery
Glory   1 Katkovik
Courage 6 Ravensworth Keep
Virtue  7 Moutain Grove Forest
Wisdom  4 Hagan Desert
Trust   5 Renick
Loyalty 2 Faulkton
Wrath   3 Nonnag  

            ▄■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▄
             {Game Starts in Mountain Home Grove}
            ▀■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■▀

1. Read Letter in Mountain Grove, directs you to search forest.
2. Find and speak to King in Forest at Castle Welbeck, he will sell you rod of life for 200 gold.  
     Inside the castle is a wanderer you can speak to. (wanderer.tmx, in castle bledknot): "Ugutz always speaks of lost glory in the Desert".
    Once it is purchased, his message changes.

    if room=183 && GoldMed<$02 then "Young Azemar, 'Tis better to be fortunate than wise! For the kingly sum of 200 gold I shall present thee with the rod of Life."
    if room=183 && GoldMed>$02 && rodoflife=0 then rodoflife=1: dec GoldMed=GoldMed-$02: "Take this rod of life, may it someday be wielded by the vanquisher of evil in this land, a noble man worthy of my crown."
    if room=183 && rodoflife=1 then "May the light of virtue always define your path."

    * if [all crystals are posessed and rodoflife>0] then load TSxx: load the rodoflife.tmx file at the end of the game.
       --> "All the gold which is under or upon the earth is not enough to give in exchange for virtue.  With this completed rod of life, may your nobility be a light to all in Midlothia...  King Azemar."

            ▄■■■■■■■■■■■■■■■■■■■■■■■■■■■■▄
	           {Start on a Quest for Glory} 
            ▀■■■■■■■■■■■■■■■■■■■■■■■■■■■■▀

No Crystals Required

3. Find and speak to Ugutz in Beckwourth, the south desert town of Beckwourth.  He gives you a key that will open the dungeon of kaktovik, where you receive the crystal of glory.
4. Travel to Kaktovick, the entrance is in the northwest corner of the map.  If [key>0] you can enter.
5. After getting the crystal of Glory, [crystal1_flag=1].  A clue is given to search the desert. [remove key after getting the crystal, key=0]

            ▄■■■■■■■■■■■■■■■■■■■■■■■■■■■■▄
             {Now on a quest for Courage}
            ▀■■■■■■■■■■■■■■■■■■■■■■■■■■■■▀
Will Have Crystal of Glory(1)

Must Posess Crystal of Glory (1) to enter

Seek: Crystal of Courage (6)

6. Travel to Castle Bledknot, at the southern edge of the desert, and speak to the King.  His response depends on whether or not you have the Crystal of Glory.
     If [crystal1_flag=0] Then load bledknot1.tmx - "Begone..."
     If [crystal1_flag=1] Then load bledknot2.tmx - Given the key to Ravensworth [key=1]
7. Travel to Ravensworth.  Dungeon entry requires [key>0] and [crystal1_flag=1]
     If [key<1] || [crystal1_flag=0] then load denied.tmx, stay on entrance screen.
     If [key>0] && [crystal1_flag=1] then load granted.tmx, then move to first dungeon screen.
8. After getting the Crystal of Courage, you are told to seek Werd at the Lakehouse. [remove key after getting the crystal, key=0]

            ▄■■■■■■■■■■■■■■■■■■■■■■■■■■■▄
             {Now on a quest for Virtue}
            ▀■■■■■■■■■■■■■■■■■■■■■■■■■■■▀

Will Have Crystal of Glory(1)
Will Have Crystal of Courage (6) 

Must possess Crystal of Courage (6) to enter

Seek: Crystal of Virtue (7)

9. Travel to Werd's house on the lake.  His replies will depend on a few things.
     Default answer with no virtue crystal - Search the north woods for the crystal of virtue.
     if [crystal7_flag=0] then "search for it" message.
     if [crystal7_flag=1] (you found the virtue crystal) then you are given a key for the dungeon in Hagan, where the wisdom crystal resides.
10. Travel to the north woods, near Kaktovik.  When you find the secret room, there are no conditions for picking up the crystal.
     When you pick it up, [crystal7_flag=1] and you are told the key is a "loch for Chetfast", you need to go back to Werd to get the key for the next quest [see #9].
     Werd Says "Take this key to unlock the path to wisdom, in the halls of gold and brown."

            ▄■■■■■■■■■■■■■■■■■■■■■■■■■■■▄
             {Now on a quest for Wisdom}
            ▀■■■■■■■■■■■■■■■■■■■■■■■■■■■▀

Will Have Crystal of Glory(1)
Will Have Crystal of Courage (6)   
Will Have Crystal of Virtue (7)

Must possess Crystal of Virtue (7) to enter

Seek: Crystal of Wisdom (4)

            --left off here 11/17/17 2:13PM--

10. You need to have Seen Werd and have his key.  Travel to the Hagan dungeon in the desert.  You must posess the crystal of Virtue before you can enter.
     If [key<1] || [crystal7_flag=0] then load denied.tmx, stay on entrance screen.
     If [key>0] && [crystal7_flag=1] then load granted.tmx, then move to first dungeon screen.
11. Get the Crystal of Wisdom from the Dungeon.  [remove key after getting the crystal, key=0]
     A voice tells you taht "Trust walks in the path to Tattershall."

            ▄■■■■■■■■■■■■■■■■■■■■■■■■■■▄
             {Now on a quest for Trust}
            ▀■■■■■■■■■■■■■■■■■■■■■■■■■■▀

12. Travel to the city of Tattershall in the East Mountains, and seek out Grimold.
13. Grimold gives you a key to ulock the Dungeon of Renick, in the northeast corner of the map.  To enter, you must have a key and the crystal of wisdom.
14. Travel to the Dungeon of Renick.
     If [key<1] || [crystal4_flag=0] then load denied.tmx, stay on entrance screen.
     If [key>0] && [crystal4_flag=1] then load granted.tmx, then move to first dungeon screen in Renick.
15. Get the crystal of Trust from the Dungeon. [remove key after getting the crystal, key=0]. You are told to Search the southern waters to prove your loyalty.

            ▄■■■■■■■■■■■■■■■■■■■■■■■■■■■■▄
             {Now on a quest for Loyalty}
            ▀■■■■■■■■■■■■■■■■■■■■■■■■■■■■▀

16. Travel to the southern part of the map to search and find the entrance to Faulkton's Lair.  No key is required for entry, but you need the crystal of Trust.
     Open the portal to Faulkton's Lair. Add some indicator in the water.  If [crystal5_flag=1] place entrance sprite in the lake, add X/Y collision for entrance in the code.
     If [crystal5_flag=0] then load denied.tmx, stay on entrance screen.
     If [crystal5_flag=0] then load granted.tmx, then move to first dungeon screen in Faulkton.
17. Enter Faulkton's Lair and obtain the crystal of Loyalty.
     You are told that you must go to Silverpeak and that your virtue has opened the path, no key is required.
            
            ▄■■■■■■■■■■■■■■■■■■■■■■■■■■▄
             {Now on a quest for Wrath}
            ▀■■■■■■■■■■■■■■■■■■■■■■■■■■▀

18. Travel to Silverpeak. No key is required for entry, but you need the crystal of Loyalty.
     If [crystal2_flag=0] then load denied.tmx, stay on entrance screen.
     If [crystal2_flag=0] then load granted.tmx, then move to first dungeon screen in Silverpeak.
19. Enter Silverpeak and obtain the crystal of Wrath.
     You are instructed to take the Crystal of Wrath to King Thoswith, who will destroy the crystal of wrath and create the rod of life from the other six crystals.
            ▄■■■■■■■■■■■■■■■■■■■■■■■■■■■■▄
             {Now on the final quest for Life}
            ▀■■■■■■■■■■■■■■■■■■■■■■■■■■■■▀
20. Travel back to the castle in the woods and speak to the King.  He will complete the rod of life for you with the crystals.  You must have bought it from him already.
     Game Over

Consider additional random messages from people in the towns:

Legend has it that placing all 6 of the Genesis Crystals into the rod of life will allow passage into the chamber of silverpeak, at the pinnacle of the Silver peak mountains.  
The Elder townsfolk of Midlothia often speak of the crystals while downing their brews at the local taverns. 
The city of Beckwourth in the Halstead woods of the east is a popular destination for Ugutz Rouestoff
You'll often find Grimold Drexel at the local tavern in Tattershall. 
Time has ravaged the former beauty of the Midlothian Meadows, now the Midlothian Desert
Deep in the Midlothian Desert lies the cavern of Hagan, legend has that it's walls are lined with gold.


* TS1: Entrance Granted Message
(**text screen**) granted.tmx
"May your great virtue be the light that guides your path"

* TS2: Denied Entrance Message
(**text screen**) denied.tmx
"Only those of greater virtue may pass"

Game Starts:

* TS3: The game starts in the Mountain Grove Home, where you can read a message left by someone else.  
(**text screen**) mountaingrove.tmx
It reads "In the heart of the midlothian forest lies the rod of life.  Use my sword wisely, it's magic will light your way.  He knows not his own strength that hath not met adversity!".  You'll also find a pile of gold 

in the house to start the game with (not yet implemented).

* TS4: Searching through the woods at Castle Welbeck, you'll find that King Riswil Thoswith is in posession of the Rod of Life.  He discovered it in the woods and will only release it for the sum of 200 Gold pieces. 
* TSxx: Also inside the castle is a wanderer you can speak to. (wanderer.tmx, in castle bledknot): "Ugutz always speaks of lost glory in the Desert".
(**text screen**) welbeck.tmx
 "Young Azemar, 'Tis better to be fortunate than wise! For the kingly sum of 200 gold I shall present thee with the rod of Life."
    Once it is purchased, his message changes.
    if [rodoflife=0] then load welbeck.tmx ...you can buy the rod of life...
    if [rodoflife>0] then load TSxx: goodluck.tmx "may the light of virtue always define your path"
    if [all crystals are posessed and rodoflife>0] then load TSxx: load the rodoflife.tmx file at the end of the game.

 The Rod of life isn't a requirement to proceed, only to beat the game at the end when you have all the crystals. 
TSxx (wanderer.tmx, in bledknot): "Ugutz always speaks of lost glory in the Desert".

* TS5: The wanderer mumbles about Ugutz Rouestoff.  Ugutz was once in the service of King Thoswith, proudly serving him as an elite warrior.  He fought in the Midlothian war to protect the Genesis crystals, but the 

powerful wizard Nonnag claimed victory, and with that victory all 7 of the precious crystals.  Speaking to Ugutz, he grants you a key to the Dungeon of Kaktovik, where you can find the first crystal. 
(**text screen**) ugutz.tmx
 ""Brave men go forward not expecting to return. If it is gloary you seek, use this key wisely, Azemar, and take the north mountain pass to Kaktovik. There will you find the honor you desire."  

* TS6: Defeating Kaktovik in the dungeon grants you the Crystal of Glory.
(**text screen**) glorycrystal.tmx
"The crystal of glory is yours. A crown is no cure for a headache in the heat of the sun". 
(Clue: Head to the desert to find another key) (Must level up to level 2, subject to change, to get open up Dungeon #2, The Cavern of Hagan"

* TS7&8: Enter Castle Bledknot for the next key. Check for level2, and posession of the first crystal, and base the text message from King Karles Derame on that:
  -> Still level 1, or no Glory Crystal:  
(**text screen**) bledknot1.tmx
"Begone mortal! Thou must return when you are worthy of my prescence!" 
(**text screen**) bledknot2.tmx
  -> Level 2+, posess Glory Crystal: "Ah, Azemar. Courage is not the absence of fear, it is the conquest of it.  Take this key and seek the true path to Courage, as the raven flies south." 
(Clue: Enter the Dungeon in the southern mountains to the east)
You are given another key, which can be used to open Ravensworth Keep, the dungeon in the southeast corner of the map.

TS9: Enter the "Ravensworth Keep" Dungeon, defeat Richbeorne the Raven, who protects the Crystal of Courage.  Once you get the crystal, the message:
(**text screen**) couragecrystal.tmx
"You hear a voice... Nearly all men can stand adversity, to test a man's character, give him power. Seek Werd Sephmond of the great lakes of Chetfast for the path to Virtue. You now posess the crystal of courage."

Next you must find Werd in the Lake Chetfast House, in the southwest corner of the map.  When you speak to Werd:
(**text screen**) werd.tmx
TS10: "I knew someday you would arrive seeking the path to virtue. I.. I.. It's... My last memory is of a stroll through the north woods"

Search the north woods for the hidden entrance to a secret room that contains the Crystal of Virtue.
(**text screen**) virtuecrystal.tmx
TS11: "Your soul alights with the flame of virtue.  The key to wisdom is but a loch in Chetfast."

You must now go back to Werd for his next message, to help find the fourth crystal, of wisdom.
(**text screen**) werd2.tmx
TS12: "The superior man thinks always of virtue, the common man thinks of comfort.  Take this key to unlock the path to wisdom, in the halls of gold and brown."
Werd no longer needed.
(Clue: The next dungeon is in the desert)

You must now go to the Cavern of Hagan in the Midlothian Desert, using Werd's key to unlock the entrance.

TS13: After defeating Hagain in the Dungeon, you receive the Crystal of Wisdom.
(**text screen**) wisdomcrystal.tmx
"Loyalty and devotion lead to bravery. Bravery leads to the spirit of self-sacrifice. The spirit of self-sacrifice creates trust.  You now posess the Crystal of Wisdom.  Trust walks in the path to Tattershall."

You must now travel to the City of Tattershall in the East Mountains and seek out Grimold Drexel.  He will give you the key to the next dungeon in your search for the crystal of Trust in the Cavern of Renick.

TS14: Speaking to Grimold Drexel in Tattershall
(**text screen**) grimold.tmx
"Men trust their ears less than their eyes.  Use this key to bear witness to trust in it's truest form, and restore my faith in the spirit of Midlothia."

TS15: After defeating Renick in the Dungeon, you receive the Crystal of Trust.
(**text screen**) trustcrystal.tmx
"You hear a voice... Put more trust in nobility of character than in an oath, young Azemar.  You now posess the crystal of trust.  Search the southern waters to prove your loyalty"
(Clue: The entrance to Faulkton's Lair is somewhere in the water, hidden. It's not yet implemented, may make a southern entrance in Room125, or pop up something in the water with a flag"

You now need to search the southern waters for the entrance to Faulkton's lair, where you will get the crystal of loyalty.  It's exact location hasn't been added yet.

TS16: After defeating Faulkton in the lair, you receive the crystal of loyalty.
(**text screen**) loyaltycrystal.tmx
"Loyalty to an unjust cause is a perversion of honor. Nonnag of Silverpeak must be stopped. Crush his wrath and restore order.  Your virtue has opened the path."

You now need to enter the final dungeon, The Chamber of Silverpeak, and fight Nonnag.
TS17: AFter defeating Nonnag, you received the crystal of Wrath.
(**text screen**) wrathcrystal.tmx
"Those who don't know the value of loyalty can never appreciate the cost of betrayal.  Take the Crystal of Wrath to King Thoswith... "  

Travel to where you first got the rod of life, King Thoswith in the castle in the woods. He will destroy the crystal of wrath and create the rod of life with the other 6 crystals.
TS18: AFter speaking to Thoswith, he sees you have all the crystals and creates the rod of life.
(**text screen**) rodoflife.tmx
"All the gold which is under or upon the earth is not enough to give in exchange for virtue.  With this completed rod of life, may your nobility be a light to all in Midlothia...  King Azemar."

Make ending scene, graphic, or sequence showing the rod of life with the six crystals.

Game Over

Crystal Numbers in the Code
*1 Glory   Katkovik	  	West Mountain		Crystal 1
*2 Loyalty Faulkton	  	Hidden		    	Crystal 2
*3 Wrath   Nonnag    		High Mountain		Crystal 3
*4 Wisdom  Hagan	     	North Desert  	Crystal 4
*5 Trust   Renick	    	East Mountain		Crystal 5
*6 Courage Ravensworth Keep	South Mountain		Crystal 6
*7 Virtue  Moutain Grove Forest Secret Forest Room   	Crystal 7	

Crystals in Order of Discovery
Glory   Katkovik
Courage Ravensworth Keep
Virtue  Moutain Grove Forest
Wisdom  Hagan
Trust   Renick
Loyalty Faulkton
Wrath   Nonnag    

*Forest Castle            [60  > 181]   Castle Welbeck               King Riswil Thoswith
*Lake House               [112 > 175]   Lake Chetfast House          Werd Sephmond             
*Desert Castle            [102 > 190]   Castle Bledknot              King Karles Derame
*River Valley Marketplace [108 > 191]   Masham Marketplace           Fallard Huesten 
*North Forest Marketplace [26  > 159]   Stratford Marketplace        Terillos Leptio 
*South Desert Town        [85  > 178]   City of Beckwourth           Ugutz Rouestoff
*East Mountain Town       [47  > 186]   City of Tattershall          Grimold Drexel
*Mountain Marketplace     [82  > 143]   Treestoke Marketplace        Nasdun Forthead
*North Forest House       [6   > 143]   Mountain Grove               Azémar Rehn (player) 

*West Mountain Dungeon    [0  > 192]   The Dungeon of Kaktovik      Kaktovik (Level 1 Req) Glory
*High Mountain Dungeon    [50 > 244]   The Chamber of Silver Peak   Nonnag (Level 6 Req) Wrath
*East Mountain Dungeon    [15 > 250]   The Vault of Renick          Renick (Level 4 Req) Trust
*North Desert Dungeon     [55 > 249]   The Cavern of Hagan          Hagan (Level 3 Req) Wisdom
*South Mountain Dungeon   [127> 252]   Ravensworth Keep             Richbeorne (Level 2 Req) Courage
Unassigned Hidden Dungeon              Faulkton's Lair              Faulkton (Level 5 Req) Loyalty

Nonnag guards the final crystal of wrath.




                                                                                                                                 */