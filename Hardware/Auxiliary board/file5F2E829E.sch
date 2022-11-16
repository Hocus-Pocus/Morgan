EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:C C4
U 1 1 584DD903
P 2800 7400
F 0 "C4" H 2650 7500 50  0000 L CNN
F 1 "0.001uF" H 2500 7300 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D6_P5" H 2838 7250 50  0001 C CNN
F 3 "" H 2800 7400 50  0000 C CNN
	1    2800 7400
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C9
U 1 1 584DD96C
P 4650 7400
F 0 "C9" H 4675 7500 50  0000 L CNN
F 1 "33uF" H 4675 7300 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D10_L13_P5" H 4650 7400 50  0001 C CNN
F 3 "" H 4650 7400 50  0000 C CNN
	1    4650 7400
	1    0    0    -1  
$EndComp
$Comp
L Device:D D5
U 1 1 584DDA01
P 4750 6900
F 0 "D5" H 4750 7000 50  0000 C CNN
F 1 "1N4001" H 4750 6800 50  0000 C CNN
F 2 "Diodes_ThroughHole:Diode_DO-41_SOD81_Horizontal_RM10" H 4750 6900 50  0001 C CNN
F 3 "" H 4750 6900 50  0000 C CNN
	1    4750 6900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 584DDB53
P 1200 2950
F 0 "R3" V 1100 2950 50  0000 C CNN
F 1 "1k" V 1200 2950 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 1130 2950 50  0001 C CNN
F 3 "" H 1200 2950 50  0000 C CNN
	1    1200 2950
	0    1    1    0   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:FUSE F1
U 1 1 584DDC32
P 5250 7200
F 0 "F1" H 5350 7250 50  0000 C CNN
F 1 "RXE050" H 5250 7400 50  0000 C CNN
F 2 "Capacitors_ThroughHole:C_Disc_D6_P5" H 5250 7200 50  0001 C CNN
F 3 "" H 5250 7200 50  0000 C CNN
	1    5250 7200
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:IXDI604PI U5
U 1 1 584DE490
P 3300 3200
F 0 "U5" H 3325 3445 60  0000 C CNN
F 1 "IXDI604PI" H 3345 2940 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 3300 3200 60  0001 C CNN
F 3 "" H 3300 3200 60  0001 C CNN
	1    3300 3200
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:AUIRF3205-RESCUE-V10_Ign-Inj_Drivers_V2 Q7
U 1 1 584DE4FD
P 9450 1150
F 0 "Q7" H 9650 1200 50  0000 L CNN
F 1 "AUIRF3205" H 9650 1100 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 9650 1075 50  0001 L CIN
F 3 "" H 9450 1150 50  0000 L CNN
	1    9450 1150
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:HCPL2631M U2
U 1 1 584DE8EB
P 1800 3200
F 0 "U2" H 1780 3460 60  0000 C CNN
F 1 "HCPL2631M" H 1780 2950 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 1800 3200 60  0001 C CNN
F 3 "" H 1800 3200 60  0001 C CNN
	1    1800 3200
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR10
U 1 1 584DE97E
P 3100 7100
F 0 "#PWR10" H 3100 6950 50  0001 C CNN
F 1 "+12V" H 3100 7240 50  0000 C CNN
F 2 "" H 3100 7100 50  0000 C CNN
F 3 "" H 3100 7100 50  0000 C CNN
	1    3100 7100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR29
U 1 1 584DE9A8
P 5550 7050
F 0 "#PWR29" H 5550 6900 50  0001 C CNN
F 1 "+5V" H 5550 7190 50  0000 C CNN
F 2 "" H 5550 7050 50  0000 C CNN
F 3 "" H 5550 7050 50  0000 C CNN
	1    5550 7050
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG3
U 1 1 584DE9D2
P 5800 7150
F 0 "#FLG3" H 5800 7245 50  0001 C CNN
F 1 "PWR_FLAG" H 5800 7330 50  0000 C CNN
F 2 "" H 5800 7150 50  0000 C CNN
F 3 "" H 5800 7150 50  0000 C CNN
	1    5800 7150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR6
U 1 1 584DE9FC
P 2750 3450
F 0 "#PWR6" H 2750 3200 50  0001 C CNN
F 1 "GND" H 2750 3300 50  0000 C CNN
F 2 "" H 2750 3450 50  0000 C CNN
F 3 "" H 2750 3450 50  0000 C CNN
	1    2750 3450
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:DB15 J1
U 1 1 584DFBC2
P 850 6050
F 0 "J1" H 870 6900 50  0000 C CNN
F 1 "DB15" H 800 5200 50  0000 C CNN
F 2 "Connect:DB15FC" H 850 6050 50  0001 C CNN
F 3 "" H 850 6050 50  0000 C CNN
	1    850  6050
	-1   0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:ERZ-V20D220 MOV1
U 1 1 584E006B
P 2250 7550
F 0 "MOV1" V 2100 7600 60  0000 C CNN
F 1 "ERZ-V20D220" V 2400 7550 60  0000 C CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 2250 7650 60  0001 C CNN
F 3 "" H 2250 7650 60  0001 C CNN
	1    2250 7550
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C8
U 1 1 584E2816
P 3750 7400
F 0 "C8" H 3775 7500 50  0000 L CNN
F 1 "33uF" H 3775 7300 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D10_L13_P5" H 3750 7400 50  0001 C CNN
F 3 "" H 3750 7400 50  0000 C CNN
	1    3750 7400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 584E2878
P 4900 7400
F 0 "C10" H 4925 7500 50  0000 L CNN
F 1 "0.1uF" H 4925 7300 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 4938 7250 50  0001 C CNN
F 3 "" H 4900 7400 50  0000 C CNN
	1    4900 7400
	1    0    0    -1  
$EndComp
$Comp
L Device:D D1
U 1 1 584E86E9
P 3100 7400
F 0 "D1" H 3100 7500 50  0000 C CNN
F 1 "1N4001" H 3050 7300 50  0000 C CNN
F 2 "Diodes_ThroughHole:Diode_DO-41_SOD81_Horizontal_RM10" H 3100 7400 50  0001 C CNN
F 3 "" H 3100 7400 50  0000 C CNN
	1    3100 7400
	0    1    1    0   
$EndComp
$Comp
L Device:D D3
U 1 1 584E880E
P 3300 7200
F 0 "D3" H 3300 7300 50  0000 C CNN
F 1 "1N4001" H 3300 7100 50  0000 C CNN
F 2 "Diodes_ThroughHole:Diode_DO-41_SOD81_Horizontal_RM10" H 3300 7200 50  0001 C CNN
F 3 "" H 3300 7200 50  0000 C CNN
	1    3300 7200
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG2
U 1 1 584F0466
P 3550 6900
F 0 "#FLG2" H 3550 6995 50  0001 C CNN
F 1 "PWR_FLAG" H 3550 7080 50  0000 C CNN
F 2 "" H 3550 6900 50  0000 C CNN
F 3 "" H 3550 6900 50  0000 C CNN
	1    3550 6900
	1    0    0    -1  
$EndComp
Text GLabel 2150 7050 0    60   Input ~ 0
VBatt
$Comp
L Device:R R4
U 1 1 584F4FB2
P 1200 3450
F 0 "R4" V 1300 3450 50  0000 C CNN
F 1 "1k" V 1200 3450 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 1130 3450 50  0001 C CNN
F 3 "" H 1200 3450 50  0000 C CNN
	1    1200 3450
	0    1    1    0   
$EndComp
Text GLabel 1250 3100 0    60   Input ~ 0
IGN9&8-cntrl
Text GLabel 1250 3300 0    60   Input ~ 0
IGN4&7-cntrl
Text GLabel 950  2950 0    60   Input ~ 0
+5V_MS
Text GLabel 950  3450 0    60   Input ~ 0
+5V_MS
NoConn ~ 3750 3050
NoConn ~ 2900 3050
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:ZENERsmall D2
U 1 1 584F2201
P 3100 7700
F 0 "D2" H 3100 7600 50  0000 C CNN
F 1 "12V 1W" H 3100 7800 50  0000 C CNN
F 2 "Diodes_ThroughHole:Diode_DO-41_SOD81_Horizontal_RM10" H 3100 7700 50  0001 C CNN
F 3 "" H 3100 7700 50  0000 C CNN
	1    3100 7700
	0    -1   -1   0   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:ZENERsmall D4
U 1 1 584F36E0
P 3500 7400
F 0 "D4" H 3500 7500 50  0000 C CNN
F 1 "22V 1W" H 3500 7300 50  0000 C CNN
F 2 "Diodes_ThroughHole:Diode_DO-41_SOD81_Horizontal_RM10" H 3500 7400 50  0001 C CNN
F 3 "" H 3500 7400 50  0000 C CNN
	1    3500 7400
	0    1    1    0   
$EndComp
$Comp
L Device:R R17
U 1 1 584F8A4B
P 4000 3000
F 0 "R17" V 3900 3000 50  0000 C CNN
F 1 "22R" V 4000 3000 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 3930 3000 50  0001 C CNN
F 3 "" H 4000 3000 50  0000 C CNN
	1    4000 3000
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:ISL9V3040P3 Q4
U 1 1 584F955E
P 4600 3450
F 0 "Q4" H 4550 3750 50  0000 R CNN
F 1 "ISL9V3040P3" V 4850 3700 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 4800 3550 50  0001 C CNN
F 3 "" H 4600 3450 50  0000 C CNN
	1    4600 3450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R14
U 1 1 584F9564
P 3900 3450
F 0 "R14" V 3800 3450 50  0000 C CNN
F 1 "22R" V 3900 3450 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 3830 3450 50  0001 C CNN
F 3 "" H 3900 3450 50  0000 C CNN
	1    3900 3450
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R22
U 1 1 584F9CD4
P 4150 3000
F 0 "R22" V 4250 3000 50  0000 C CNN
F 1 "10M" V 4150 3000 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4080 3000 50  0001 C CNN
F 3 "" H 4150 3000 50  0000 C CNN
	1    4150 3000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R23
U 1 1 584F9D49
P 4150 3650
F 0 "R23" V 4250 3650 50  0000 C CNN
F 1 "10M" V 4150 3650 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4080 3650 50  0001 C CNN
F 3 "" H 4150 3650 50  0000 C CNN
	1    4150 3650
	1    0    0    -1  
$EndComp
Text GLabel 5000 2700 2    60   Input ~ 0
IGN9&8
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D8
U 1 1 58504280
P 5250 2500
F 0 "D8" H 5350 2600 50  0000 C CNN
F 1 "LED" H 5150 2600 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 5250 2500 50  0001 C CNN
F 3 "" H 5250 2500 50  0000 C CNN
	1    5250 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R27
U 1 1 58504286
P 4900 2500
F 0 "R27" V 5000 2500 50  0000 C CNN
F 1 "2.4k" V 4900 2500 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4830 2500 50  0001 C CNN
F 3 "" H 4900 2500 50  0000 C CNN
	1    4900 2500
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR25
U 1 1 5850428C
P 5450 2500
F 0 "#PWR25" H 5450 2350 50  0001 C CNN
F 1 "+12V" V 5450 2700 50  0000 C CNN
F 2 "" H 5450 2500 50  0000 C CNN
F 3 "" H 5450 2500 50  0000 C CNN
	1    5450 2500
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D9
U 1 1 58504344
P 5250 3150
F 0 "D9" H 5350 3250 50  0000 C CNN
F 1 "LED" H 5150 3250 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 5250 3150 50  0001 C CNN
F 3 "" H 5250 3150 50  0000 C CNN
	1    5250 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R28
U 1 1 5850434A
P 4900 3150
F 0 "R28" V 5000 3100 50  0000 C CNN
F 1 "2.4k" V 4900 3150 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4830 3150 50  0001 C CNN
F 3 "" H 4900 3150 50  0000 C CNN
	1    4900 3150
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR26
U 1 1 58504350
P 5450 3150
F 0 "#PWR26" H 5450 3000 50  0001 C CNN
F 1 "+12V" V 5450 3350 50  0000 C CNN
F 2 "" H 5450 3150 50  0000 C CNN
F 3 "" H 5450 3150 50  0000 C CNN
	1    5450 3150
	1    0    0    -1  
$EndComp
Text GLabel 5000 3350 2    60   Input ~ 0
IGN4&7
$Comp
L Device:R R31
U 1 1 58506AAC
P 6300 1350
F 0 "R31" V 6200 1350 50  0000 C CNN
F 1 "1k" V 6300 1350 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 6230 1350 50  0001 C CNN
F 3 "" H 6300 1350 50  0000 C CNN
	1    6300 1350
	0    1    1    0   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:IXDI604PI U11
U 1 1 58506AB8
P 8400 1600
F 0 "U11" H 8425 1845 60  0000 C CNN
F 1 "IXDI604PI" H 8445 1340 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 8400 1600 60  0001 C CNN
F 3 "" H 8400 1600 60  0001 C CNN
	1    8400 1600
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:HCPL2631M U8
U 1 1 58506ABE
P 6900 1600
F 0 "U8" H 6880 1860 60  0000 C CNN
F 1 "HCPL2631M" H 6880 1350 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 6900 1600 60  0001 C CNN
F 3 "" H 6900 1600 60  0001 C CNN
	1    6900 1600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR35
U 1 1 58506AC4
P 7850 1850
F 0 "#PWR35" H 7850 1600 50  0001 C CNN
F 1 "GND" H 7850 1700 50  0000 C CNN
F 2 "" H 7850 1850 50  0000 C CNN
F 3 "" H 7850 1850 50  0000 C CNN
	1    7850 1850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R32
U 1 1 58506ACA
P 6300 1850
F 0 "R32" V 6400 1850 50  0000 C CNN
F 1 "1k" V 6300 1850 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 6230 1850 50  0001 C CNN
F 3 "" H 6300 1850 50  0000 C CNN
	1    6300 1850
	0    1    1    0   
$EndComp
Text GLabel 6350 1500 0    60   Input ~ 0
INJ1&10-cntrl
Text GLabel 6350 1700 0    60   Input ~ 0
INJ9&4-cntrl
$Comp
L Device:C C12
U 1 1 58506ADA
P 7850 1050
F 0 "C12" H 7850 1150 50  0000 L CNN
F 1 "0.1uF" H 7850 950 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 7888 900 50  0001 C CNN
F 3 "" H 7850 1050 50  0000 C CNN
	1    7850 1050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R37
U 1 1 58506AE0
P 7450 1050
F 0 "R37" V 7550 1050 50  0000 C CNN
F 1 "1k" V 7450 1050 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 7380 1050 50  0001 C CNN
F 3 "" H 7450 1050 50  0000 C CNN
	1    7450 1050
	-1   0    0    1   
$EndComp
$Comp
L Device:R R40
U 1 1 58506AE6
P 7600 1050
F 0 "R40" V 7500 1050 50  0000 C CNN
F 1 "1k" V 7600 1050 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 7530 1050 50  0001 C CNN
F 3 "" H 7600 1050 50  0000 C CNN
	1    7600 1050
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR33
U 1 1 58506AF5
P 7850 850
F 0 "#PWR33" H 7850 700 50  0001 C CNN
F 1 "+5V" V 7750 900 50  0000 C CNN
F 2 "" H 7850 850 50  0000 C CNN
F 3 "" H 7850 850 50  0000 C CNN
	1    7850 850 
	1    0    0    -1  
$EndComp
Text GLabel 6050 1350 0    60   Input ~ 0
+5V_MS
Text GLabel 6050 1850 0    60   Input ~ 0
+5V_MS
NoConn ~ 8850 1450
NoConn ~ 8000 1450
$Comp
L Device:C C16
U 1 1 58506B08
P 8700 1050
F 0 "C16" H 8550 1150 50  0000 L CNN
F 1 "0.1uF" H 8500 950 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 8738 900 50  0001 C CNN
F 3 "" H 8700 1050 50  0000 C CNN
	1    8700 1050
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C15
U 1 1 58506B0E
P 8400 1050
F 0 "C15" H 8350 1300 50  0000 L CNN
F 1 "4.7uF" H 8200 950 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D5_L6_P2.5" H 8400 1050 50  0001 C CNN
F 3 "" H 8400 1050 50  0000 C CNN
	1    8400 1050
	1    0    0    -1  
$EndComp
$Comp
L Device:D D14
U 1 1 58506B14
P 9150 900
F 0 "D14" H 9150 1000 50  0000 C CNN
F 1 "1N4001" H 9150 800 50  0000 C CNN
F 2 "Diodes_ThroughHole:Diode_DO-41_SOD81_Horizontal_RM10" H 9150 900 50  0001 C CNN
F 3 "" H 9150 900 50  0000 C CNN
	1    9150 900 
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:ZENERsmall D13
U 1 1 58506B1A
P 8100 1000
F 0 "D13" H 7900 1000 50  0000 C CNN
F 1 "24V" H 8100 1100 50  0000 C CNN
F 2 "Diodes_ThroughHole:Diode_DO-41_SOD81_Horizontal_RM10" H 8100 1000 50  0001 C CNN
F 3 "" H 8100 1000 50  0000 C CNN
	1    8100 1000
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR42
U 1 1 58506B27
P 8700 1200
F 0 "#PWR42" H 8700 950 50  0001 C CNN
F 1 "GND" H 8700 1050 50  0000 C CNN
F 2 "" H 8700 1200 50  0000 C CNN
F 3 "" H 8700 1200 50  0000 C CNN
	1    8700 1200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R46
U 1 1 58506B36
P 9100 1400
F 0 "R46" V 9000 1400 50  0000 C CNN
F 1 "22R" V 9100 1400 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 9030 1400 50  0001 C CNN
F 3 "" H 9100 1400 50  0000 C CNN
	1    9100 1400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R43
U 1 1 58506B42
P 9050 1750
F 0 "R43" V 8950 1750 50  0000 C CNN
F 1 "22R" V 9050 1750 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 8980 1750 50  0001 C CNN
F 3 "" H 9050 1750 50  0000 C CNN
	1    9050 1750
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R49
U 1 1 58506B48
P 9250 1400
F 0 "R49" V 9350 1400 50  0000 C CNN
F 1 "10M" V 9250 1400 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9180 1400 50  0001 C CNN
F 3 "" H 9250 1400 50  0000 C CNN
	1    9250 1400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R50
U 1 1 58506B4E
P 9250 1900
F 0 "R50" V 9350 1900 50  0000 C CNN
F 1 "10M" V 9250 1900 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9180 1900 50  0001 C CNN
F 3 "" H 9250 1900 50  0000 C CNN
	1    9250 1900
	1    0    0    -1  
$EndComp
Text GLabel 9850 1050 2    60   Input ~ 0
INJ1&10
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D15
U 1 1 58506B55
P 10100 900
F 0 "D15" H 10200 1000 50  0000 C CNN
F 1 "LED" H 10000 1000 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 10100 900 50  0001 C CNN
F 3 "" H 10100 900 50  0000 C CNN
	1    10100 900 
	1    0    0    -1  
$EndComp
$Comp
L Device:R R55
U 1 1 58506B5B
P 9750 900
F 0 "R55" V 9850 900 50  0000 C CNN
F 1 "2.4k" V 9750 900 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9680 900 50  0001 C CNN
F 3 "" H 9750 900 50  0000 C CNN
	1    9750 900 
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR54
U 1 1 58506B61
P 10300 900
F 0 "#PWR54" H 10300 750 50  0001 C CNN
F 1 "+12V" V 10300 1100 50  0000 C CNN
F 2 "" H 10300 900 50  0000 C CNN
F 3 "" H 10300 900 50  0000 C CNN
	1    10300 900 
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D16
U 1 1 58506B69
P 10100 1400
F 0 "D16" H 10200 1500 50  0000 C CNN
F 1 "LED" H 10000 1500 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 10100 1400 50  0001 C CNN
F 3 "" H 10100 1400 50  0000 C CNN
	1    10100 1400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R56
U 1 1 58506B6F
P 9750 1400
F 0 "R56" V 9850 1350 50  0000 C CNN
F 1 "2.4k" V 9750 1400 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9680 1400 50  0001 C CNN
F 3 "" H 9750 1400 50  0000 C CNN
	1    9750 1400
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR55
U 1 1 58506B75
P 10300 1400
F 0 "#PWR55" H 10300 1250 50  0001 C CNN
F 1 "+12V" V 10300 1600 50  0000 C CNN
F 2 "" H 10300 1400 50  0000 C CNN
F 3 "" H 10300 1400 50  0000 C CNN
	1    10300 1400
	1    0    0    -1  
$EndComp
Text GLabel 9850 1550 2    60   Input ~ 0
INJ9&4
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:AUIRF3205-RESCUE-V10_Ign-Inj_Drivers_V2 Q8
U 1 1 58508A90
P 9450 1650
F 0 "Q8" H 9650 1700 50  0000 L CNN
F 1 "AUIRF3205" H 9650 1600 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 9650 1575 50  0001 L CIN
F 3 "" H 9450 1650 50  0000 L CNN
	1    9450 1650
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR51
U 1 1 58513264
P 9350 900
F 0 "#PWR51" H 9350 750 50  0001 C CNN
F 1 "+12V" H 9350 1050 50  0000 C CNN
F 2 "" H 9350 900 50  0000 C CNN
F 3 "" H 9350 900 50  0000 C CNN
	1    9350 900 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR21
U 1 1 585147B2
P 4150 3200
F 0 "#PWR21" H 4150 2950 50  0001 C CNN
F 1 "GND" H 4150 3050 50  0000 C CNN
F 2 "" H 4150 3200 50  0000 C CNN
F 3 "" H 4150 3200 50  0000 C CNN
	1    4150 3200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR19
U 1 1 5851486E
P 4100 3800
F 0 "#PWR19" H 4100 3550 50  0001 C CNN
F 1 "GND" H 4100 3650 50  0000 C CNN
F 2 "" H 4100 3800 50  0000 C CNN
F 3 "" H 4100 3800 50  0000 C CNN
	1    4100 3800
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR48
U 1 1 58517332
P 9250 1550
F 0 "#PWR48" H 9250 1300 50  0001 C CNN
F 1 "GND" H 9150 1450 50  0000 C CNN
F 2 "" H 9250 1550 50  0000 C CNN
F 3 "" H 9250 1550 50  0000 C CNN
	1    9250 1550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR45
U 1 1 58517570
P 9200 2050
F 0 "#PWR45" H 9200 1800 50  0001 C CNN
F 1 "GND" H 9200 1900 50  0000 C CNN
F 2 "" H 9200 2050 50  0000 C CNN
F 3 "" H 9200 2050 50  0000 C CNN
	1    9200 2050
	0    1    1    0   
$EndComp
$Comp
L Device:R R1
U 1 1 58521DDF
P 1200 1450
F 0 "R1" V 1100 1450 50  0000 C CNN
F 1 "1k" V 1200 1450 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 1130 1450 50  0001 C CNN
F 3 "" H 1200 1450 50  0000 C CNN
	1    1200 1450
	0    1    1    0   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:ISL9V3040P3 Q1
U 1 1 58521DE5
P 4600 1300
F 0 "Q1" H 4550 1600 50  0000 R CNN
F 1 "ISL9V3040P3" V 4850 1550 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 4800 1400 50  0001 C CNN
F 3 "" H 4600 1300 50  0000 C CNN
	1    4600 1300
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:IXDI604PI U4
U 1 1 58521DEB
P 3300 1700
F 0 "U4" H 3325 1945 60  0000 C CNN
F 1 "IXDI604PI" H 3345 1440 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 3300 1700 60  0001 C CNN
F 3 "" H 3300 1700 60  0001 C CNN
	1    3300 1700
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:HCPL2631M U1
U 1 1 58521DF1
P 1800 1700
F 0 "U1" H 1780 1960 60  0000 C CNN
F 1 "HCPL2631M" H 1780 1450 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 1800 1700 60  0001 C CNN
F 3 "" H 1800 1700 60  0001 C CNN
	1    1800 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR3
U 1 1 58521DF7
P 2750 1950
F 0 "#PWR3" H 2750 1700 50  0001 C CNN
F 1 "GND" H 2750 1800 50  0000 C CNN
F 2 "" H 2750 1950 50  0000 C CNN
F 3 "" H 2750 1950 50  0000 C CNN
	1    2750 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 58521DFD
P 1200 1950
F 0 "R2" V 1300 1950 50  0000 C CNN
F 1 "1k" V 1200 1950 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 1130 1950 50  0001 C CNN
F 3 "" H 1200 1950 50  0000 C CNN
	1    1200 1950
	0    1    1    0   
$EndComp
Text GLabel 1250 1600 0    60   Input ~ 0
IGN1&6-cntrl
Text GLabel 1250 1800 0    60   Input ~ 0
IGN10&5-cntrl
$Comp
L Device:C C1
U 1 1 58521E05
P 2750 1150
F 0 "C1" H 2750 1250 50  0000 L CNN
F 1 "0.1uF" H 2750 1050 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 2788 1000 50  0001 C CNN
F 3 "" H 2750 1150 50  0000 C CNN
	1    2750 1150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 58521E0B
P 2350 1150
F 0 "R7" V 2450 1150 50  0000 C CNN
F 1 "1k" V 2350 1150 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 2280 1150 50  0001 C CNN
F 3 "" H 2350 1150 50  0000 C CNN
	1    2350 1150
	-1   0    0    1   
$EndComp
$Comp
L Device:R R10
U 1 1 58521E11
P 2500 1150
F 0 "R10" V 2400 1150 50  0000 C CNN
F 1 "1k" V 2500 1150 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 2430 1150 50  0001 C CNN
F 3 "" H 2500 1150 50  0000 C CNN
	1    2500 1150
	-1   0    0    1   
$EndComp
Text GLabel 950  1450 0    60   Input ~ 0
+5V_MS
Text GLabel 950  1950 0    60   Input ~ 0
+5V_MS
NoConn ~ 3750 1550
NoConn ~ 2900 1550
$Comp
L Device:C C5
U 1 1 58521E21
P 3600 1150
F 0 "C5" H 3625 1250 50  0000 L CNN
F 1 "0.1uF" H 3600 1050 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 3638 1000 50  0001 C CNN
F 3 "" H 3600 1150 50  0000 C CNN
	1    3600 1150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR2
U 1 1 58521E39
P 2750 1300
F 0 "#PWR2" H 2750 1050 50  0001 C CNN
F 1 "GND" H 2750 1150 50  0000 C CNN
F 2 "" H 2750 1300 50  0000 C CNN
F 3 "" H 2750 1300 50  0000 C CNN
	1    2750 1300
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR11
U 1 1 58521E3F
P 3600 950
F 0 "#PWR11" H 3600 800 50  0001 C CNN
F 1 "+5V" V 3500 1050 50  0000 C CNN
F 2 "" H 3600 950 50  0000 C CNN
F 3 "" H 3600 950 50  0000 C CNN
	1    3600 950 
	1    0    0    -1  
$EndComp
$Comp
L Device:R R16
U 1 1 58521E45
P 4000 1500
F 0 "R16" V 3900 1500 50  0000 C CNN
F 1 "22R" V 4000 1500 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 3930 1500 50  0001 C CNN
F 3 "" H 4000 1500 50  0000 C CNN
	1    4000 1500
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:ISL9V3040P3 Q2
U 1 1 58521E4B
P 4600 1950
F 0 "Q2" H 4550 2250 50  0000 R CNN
F 1 "ISL9V3040P3" V 4850 2200 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 4800 2050 50  0001 C CNN
F 3 "" H 4600 1950 50  0000 C CNN
	1    4600 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R13
U 1 1 58521E51
P 3900 1950
F 0 "R13" V 3800 1950 50  0000 C CNN
F 1 "22R" V 3900 1950 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 3830 1950 50  0001 C CNN
F 3 "" H 3900 1950 50  0000 C CNN
	1    3900 1950
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R20
U 1 1 58521E57
P 4150 1500
F 0 "R20" V 4250 1500 50  0000 C CNN
F 1 "10M" V 4150 1500 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4080 1500 50  0001 C CNN
F 3 "" H 4150 1500 50  0000 C CNN
	1    4150 1500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R21
U 1 1 58521E5D
P 4150 2150
F 0 "R21" V 4250 2150 50  0000 C CNN
F 1 "10M" V 4150 2150 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4080 2150 50  0001 C CNN
F 3 "" H 4150 2150 50  0000 C CNN
	1    4150 2150
	1    0    0    -1  
$EndComp
Text GLabel 5000 1200 2    60   Input ~ 0
IGN1&6
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D6
U 1 1 58521E64
P 5250 1000
F 0 "D6" H 5350 1100 50  0000 C CNN
F 1 "LED" H 5150 1100 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 5250 1000 50  0001 C CNN
F 3 "" H 5250 1000 50  0000 C CNN
	1    5250 1000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R25
U 1 1 58521E6A
P 4900 1000
F 0 "R25" V 5000 1000 50  0000 C CNN
F 1 "2.4k" V 4900 1000 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4830 1000 50  0001 C CNN
F 3 "" H 4900 1000 50  0000 C CNN
	1    4900 1000
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR23
U 1 1 58521E70
P 5450 1000
F 0 "#PWR23" H 5450 850 50  0001 C CNN
F 1 "+12V" V 5450 1200 50  0000 C CNN
F 2 "" H 5450 1000 50  0000 C CNN
F 3 "" H 5450 1000 50  0000 C CNN
	1    5450 1000
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D7
U 1 1 58521E76
P 5250 1650
F 0 "D7" H 5350 1750 50  0000 C CNN
F 1 "LED" H 5150 1750 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 5250 1650 50  0001 C CNN
F 3 "" H 5250 1650 50  0000 C CNN
	1    5250 1650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R26
U 1 1 58521E7C
P 4900 1650
F 0 "R26" V 5000 1600 50  0000 C CNN
F 1 "2.4k" V 4900 1650 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4830 1650 50  0001 C CNN
F 3 "" H 4900 1650 50  0000 C CNN
	1    4900 1650
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR24
U 1 1 58521E82
P 5450 1650
F 0 "#PWR24" H 5450 1500 50  0001 C CNN
F 1 "+12V" V 5450 1850 50  0000 C CNN
F 2 "" H 5450 1650 50  0000 C CNN
F 3 "" H 5450 1650 50  0000 C CNN
	1    5450 1650
	1    0    0    -1  
$EndComp
Text GLabel 5000 1850 2    60   Input ~ 0
IGN10&5
$Comp
L power:GND #PWR20
U 1 1 58521E89
P 4150 1700
F 0 "#PWR20" H 4150 1450 50  0001 C CNN
F 1 "GND" H 4150 1550 50  0000 C CNN
F 2 "" H 4150 1700 50  0000 C CNN
F 3 "" H 4150 1700 50  0000 C CNN
	1    4150 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR18
U 1 1 58521E8F
P 4100 2300
F 0 "#PWR18" H 4100 2050 50  0001 C CNN
F 1 "GND" H 4100 2150 50  0000 C CNN
F 2 "" H 4100 2300 50  0000 C CNN
F 3 "" H 4100 2300 50  0000 C CNN
	1    4100 2300
	0    1    1    0   
$EndComp
$Comp
L Device:R R5
U 1 1 58536CC1
P 1200 4450
F 0 "R5" V 1100 4450 50  0000 C CNN
F 1 "1k" V 1200 4450 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 1130 4450 50  0001 C CNN
F 3 "" H 1200 4450 50  0000 C CNN
	1    1200 4450
	0    1    1    0   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:ISL9V3040P3 Q5
U 1 1 58536CC7
P 4600 4300
F 0 "Q5" H 4550 4600 50  0000 R CNN
F 1 "ISL9V3040P3" V 4850 4550 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 4800 4400 50  0001 C CNN
F 3 "" H 4600 4300 50  0000 C CNN
	1    4600 4300
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:IXDI604PI U6
U 1 1 58536CCD
P 3300 4700
F 0 "U6" H 3325 4945 60  0000 C CNN
F 1 "IXDI604PI" H 3345 4440 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 3300 4700 60  0001 C CNN
F 3 "" H 3300 4700 60  0001 C CNN
	1    3300 4700
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:HCPL2631M U3
U 1 1 58536CD3
P 1800 4700
F 0 "U3" H 1780 4960 60  0000 C CNN
F 1 "HCPL2631M" H 1780 4450 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 1800 4700 60  0001 C CNN
F 3 "" H 1800 4700 60  0001 C CNN
	1    1800 4700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR9
U 1 1 58536CD9
P 2750 4950
F 0 "#PWR9" H 2750 4700 50  0001 C CNN
F 1 "GND" H 2750 4800 50  0000 C CNN
F 2 "" H 2750 4950 50  0000 C CNN
F 3 "" H 2750 4950 50  0000 C CNN
	1    2750 4950
	1    0    0    -1  
$EndComp
Text GLabel 1250 4600 0    60   Input ~ 0
IGN3&2-cntrl
Text GLabel 950  4450 0    60   Input ~ 0
+5V_MS
NoConn ~ 3750 4550
NoConn ~ 2900 4550
$Comp
L Device:R R18
U 1 1 58536D27
P 4000 4500
F 0 "R18" V 3900 4500 50  0000 C CNN
F 1 "22R" V 4000 4500 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 3930 4500 50  0001 C CNN
F 3 "" H 4000 4500 50  0000 C CNN
	1    4000 4500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R24
U 1 1 58536D39
P 4150 4500
F 0 "R24" V 4250 4500 50  0000 C CNN
F 1 "10M" V 4150 4500 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4080 4500 50  0001 C CNN
F 3 "" H 4150 4500 50  0000 C CNN
	1    4150 4500
	1    0    0    -1  
$EndComp
Text GLabel 5000 4200 2    60   Input ~ 0
IGN3&2
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D10
U 1 1 58536D46
P 5250 4000
F 0 "D10" H 5350 4100 50  0000 C CNN
F 1 "LED" H 5150 4100 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 5250 4000 50  0001 C CNN
F 3 "" H 5250 4000 50  0000 C CNN
	1    5250 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R29
U 1 1 58536D4C
P 4900 4000
F 0 "R29" V 5000 4000 50  0000 C CNN
F 1 "2.4k" V 4900 4000 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4830 4000 50  0001 C CNN
F 3 "" H 4900 4000 50  0000 C CNN
	1    4900 4000
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR27
U 1 1 58536D52
P 5450 4000
F 0 "#PWR27" H 5450 3850 50  0001 C CNN
F 1 "+12V" V 5450 4200 50  0000 C CNN
F 2 "" H 5450 4000 50  0000 C CNN
F 3 "" H 5450 4000 50  0000 C CNN
	1    5450 4000
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:AUIRF3205-RESCUE-V10_Ign-Inj_Drivers_V2 Q9
U 1 1 5853B163
P 9450 2550
F 0 "Q9" H 9650 2600 50  0000 L CNN
F 1 "AUIRF3205" H 9650 2500 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 9650 2475 50  0001 L CIN
F 3 "" H 9450 2550 50  0000 L CNN
	1    9450 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R33
U 1 1 5853B169
P 6300 2750
F 0 "R33" V 6200 2750 50  0000 C CNN
F 1 "1k" V 6300 2750 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 6230 2750 50  0001 C CNN
F 3 "" H 6300 2750 50  0000 C CNN
	1    6300 2750
	0    1    1    0   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:IXDI604PI U12
U 1 1 5853B16F
P 8400 3000
F 0 "U12" H 8425 3245 60  0000 C CNN
F 1 "IXDI604PI" H 8445 2740 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 8400 3000 60  0001 C CNN
F 3 "" H 8400 3000 60  0001 C CNN
	1    8400 3000
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:HCPL2631M U9
U 1 1 5853B175
P 6900 3000
F 0 "U9" H 6880 3260 60  0000 C CNN
F 1 "HCPL2631M" H 6880 2750 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 6900 3000 60  0001 C CNN
F 3 "" H 6900 3000 60  0001 C CNN
	1    6900 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR38
U 1 1 5853B17B
P 7850 3250
F 0 "#PWR38" H 7850 3000 50  0001 C CNN
F 1 "GND" H 7850 3100 50  0000 C CNN
F 2 "" H 7850 3250 50  0000 C CNN
F 3 "" H 7850 3250 50  0000 C CNN
	1    7850 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R34
U 1 1 5853B181
P 6300 3250
F 0 "R34" V 6400 3250 50  0000 C CNN
F 1 "1k" V 6300 3250 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 6230 3250 50  0001 C CNN
F 3 "" H 6300 3250 50  0000 C CNN
	1    6300 3250
	0    1    1    0   
$EndComp
Text GLabel 6350 2900 0    60   Input ~ 0
INJ3&6-cntrl
Text GLabel 6350 3100 0    60   Input ~ 0
INJ5&8-cntrl
$Comp
L Device:C C13
U 1 1 5853B189
P 7850 2450
F 0 "C13" H 7850 2550 50  0000 L CNN
F 1 "0.1uF" H 7850 2350 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 7888 2300 50  0001 C CNN
F 3 "" H 7850 2450 50  0000 C CNN
	1    7850 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R38
U 1 1 5853B18F
P 7450 2450
F 0 "R38" V 7550 2450 50  0000 C CNN
F 1 "1k" V 7450 2450 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 7380 2450 50  0001 C CNN
F 3 "" H 7450 2450 50  0000 C CNN
	1    7450 2450
	-1   0    0    1   
$EndComp
$Comp
L Device:R R41
U 1 1 5853B195
P 7600 2450
F 0 "R41" V 7500 2450 50  0000 C CNN
F 1 "1k" V 7600 2450 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 7530 2450 50  0001 C CNN
F 3 "" H 7600 2450 50  0000 C CNN
	1    7600 2450
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR36
U 1 1 5853B19B
P 7850 2250
F 0 "#PWR36" H 7850 2100 50  0001 C CNN
F 1 "+5V" V 7750 2300 50  0000 C CNN
F 2 "" H 7850 2250 50  0000 C CNN
F 3 "" H 7850 2250 50  0000 C CNN
	1    7850 2250
	1    0    0    -1  
$EndComp
Text GLabel 6050 2750 0    60   Input ~ 0
+5V_MS
Text GLabel 6050 3250 0    60   Input ~ 0
+5V_MS
NoConn ~ 8850 2850
NoConn ~ 8000 2850
$Comp
L Device:C C17
U 1 1 5853B1A5
P 8700 2450
F 0 "C17" H 8550 2550 50  0000 L CNN
F 1 "0.1uF" H 8500 2350 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 8738 2300 50  0001 C CNN
F 3 "" H 8700 2450 50  0000 C CNN
	1    8700 2450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR43
U 1 1 5853B1BD
P 8700 2600
F 0 "#PWR43" H 8700 2350 50  0001 C CNN
F 1 "GND" H 8700 2450 50  0000 C CNN
F 2 "" H 8700 2600 50  0000 C CNN
F 3 "" H 8700 2600 50  0000 C CNN
	1    8700 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R47
U 1 1 5853B1C3
P 9100 2800
F 0 "R47" V 9000 2800 50  0000 C CNN
F 1 "22R" V 9100 2800 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 9030 2800 50  0001 C CNN
F 3 "" H 9100 2800 50  0000 C CNN
	1    9100 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R44
U 1 1 5853B1C9
P 9050 3150
F 0 "R44" V 8950 3150 50  0000 C CNN
F 1 "22R" V 9050 3150 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 8980 3150 50  0001 C CNN
F 3 "" H 9050 3150 50  0000 C CNN
	1    9050 3150
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R51
U 1 1 5853B1CF
P 9250 2800
F 0 "R51" V 9350 2800 50  0000 C CNN
F 1 "10M" V 9250 2800 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9180 2800 50  0001 C CNN
F 3 "" H 9250 2800 50  0000 C CNN
	1    9250 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R52
U 1 1 5853B1D5
P 9250 3300
F 0 "R52" V 9350 3300 50  0000 C CNN
F 1 "10M" V 9250 3300 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9180 3300 50  0001 C CNN
F 3 "" H 9250 3300 50  0000 C CNN
	1    9250 3300
	1    0    0    -1  
$EndComp
Text GLabel 9850 2450 2    60   Input ~ 0
INJ3&6
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D17
U 1 1 5853B1DC
P 10100 2300
F 0 "D17" H 10200 2400 50  0000 C CNN
F 1 "LED" H 10000 2400 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 10100 2300 50  0001 C CNN
F 3 "" H 10100 2300 50  0000 C CNN
	1    10100 2300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R57
U 1 1 5853B1E2
P 9750 2300
F 0 "R57" V 9850 2300 50  0000 C CNN
F 1 "2.4k" V 9750 2300 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9680 2300 50  0001 C CNN
F 3 "" H 9750 2300 50  0000 C CNN
	1    9750 2300
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR56
U 1 1 5853B1E8
P 10300 2300
F 0 "#PWR56" H 10300 2150 50  0001 C CNN
F 1 "+12V" V 10300 2500 50  0000 C CNN
F 2 "" H 10300 2300 50  0000 C CNN
F 3 "" H 10300 2300 50  0000 C CNN
	1    10300 2300
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D18
U 1 1 5853B1EE
P 10100 2800
F 0 "D18" H 10200 2900 50  0000 C CNN
F 1 "LED" H 10000 2900 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 10100 2800 50  0001 C CNN
F 3 "" H 10100 2800 50  0000 C CNN
	1    10100 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R58
U 1 1 5853B1F4
P 9750 2800
F 0 "R58" V 9850 2750 50  0000 C CNN
F 1 "2.4k" V 9750 2800 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9680 2800 50  0001 C CNN
F 3 "" H 9750 2800 50  0000 C CNN
	1    9750 2800
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR57
U 1 1 5853B1FA
P 10300 2800
F 0 "#PWR57" H 10300 2650 50  0001 C CNN
F 1 "+12V" V 10300 3000 50  0000 C CNN
F 2 "" H 10300 2800 50  0000 C CNN
F 3 "" H 10300 2800 50  0000 C CNN
	1    10300 2800
	1    0    0    -1  
$EndComp
Text GLabel 9850 2950 2    60   Input ~ 0
INJ5&8
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:AUIRF3205-RESCUE-V10_Ign-Inj_Drivers_V2 Q10
U 1 1 5853B201
P 9450 3050
F 0 "Q10" H 9650 3100 50  0000 L CNN
F 1 "AUIRF3205" H 9650 3000 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 9650 2975 50  0001 L CIN
F 3 "" H 9450 3050 50  0000 L CNN
	1    9450 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR49
U 1 1 5853B258
P 9250 2950
F 0 "#PWR49" H 9250 2700 50  0001 C CNN
F 1 "GND" H 9150 2850 50  0000 C CNN
F 2 "" H 9250 2950 50  0000 C CNN
F 3 "" H 9250 2950 50  0000 C CNN
	1    9250 2950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR46
U 1 1 5853B25E
P 9200 3450
F 0 "#PWR46" H 9200 3200 50  0001 C CNN
F 1 "GND" H 9200 3300 50  0000 C CNN
F 2 "" H 9200 3450 50  0000 C CNN
F 3 "" H 9200 3450 50  0000 C CNN
	1    9200 3450
	0    1    1    0   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:AUIRF3205-RESCUE-V10_Ign-Inj_Drivers_V2 Q11
U 1 1 5853D6DF
P 9450 3950
F 0 "Q11" H 9650 4000 50  0000 L CNN
F 1 "AUIRF3205" H 9650 3900 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 9650 3875 50  0001 L CIN
F 3 "" H 9450 3950 50  0000 L CNN
	1    9450 3950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R35
U 1 1 5853D6E5
P 6300 4150
F 0 "R35" V 6200 4150 50  0000 C CNN
F 1 "1k" V 6300 4150 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 6230 4150 50  0001 C CNN
F 3 "" H 6300 4150 50  0000 C CNN
	1    6300 4150
	0    1    1    0   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:IXDI604PI U13
U 1 1 5853D6EB
P 8400 4400
F 0 "U13" H 8425 4645 60  0000 C CNN
F 1 "IXDI604PI" H 8445 4140 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 8400 4400 60  0001 C CNN
F 3 "" H 8400 4400 60  0001 C CNN
	1    8400 4400
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:HCPL2631M U10
U 1 1 5853D6F1
P 6900 4400
F 0 "U10" H 6880 4660 60  0000 C CNN
F 1 "HCPL2631M" H 6880 4150 60  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 6900 4400 60  0001 C CNN
F 3 "" H 6900 4400 60  0001 C CNN
	1    6900 4400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR41
U 1 1 5853D6F7
P 7850 4650
F 0 "#PWR41" H 7850 4400 50  0001 C CNN
F 1 "GND" H 7850 4500 50  0000 C CNN
F 2 "" H 7850 4650 50  0000 C CNN
F 3 "" H 7850 4650 50  0000 C CNN
	1    7850 4650
	1    0    0    -1  
$EndComp
Text GLabel 6350 4300 0    60   Input ~ 0
INJ7&2-cntrl
$Comp
L Device:C C14
U 1 1 5853D705
P 7850 3850
F 0 "C14" H 7850 3950 50  0000 L CNN
F 1 "0.1uF" H 7850 3750 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 7888 3700 50  0001 C CNN
F 3 "" H 7850 3850 50  0000 C CNN
	1    7850 3850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R39
U 1 1 5853D70B
P 7450 3850
F 0 "R39" V 7550 3850 50  0000 C CNN
F 1 "1k" V 7450 3850 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 7380 3850 50  0001 C CNN
F 3 "" H 7450 3850 50  0000 C CNN
	1    7450 3850
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR39
U 1 1 5853D717
P 7850 3650
F 0 "#PWR39" H 7850 3500 50  0001 C CNN
F 1 "+5V" V 7750 3700 50  0000 C CNN
F 2 "" H 7850 3650 50  0000 C CNN
F 3 "" H 7850 3650 50  0000 C CNN
	1    7850 3650
	1    0    0    -1  
$EndComp
Text GLabel 6050 4150 0    60   Input ~ 0
+5V_MS
NoConn ~ 8850 4250
NoConn ~ 8000 4250
$Comp
L Device:C C18
U 1 1 5853D721
P 8700 3850
F 0 "C18" H 8550 3950 50  0000 L CNN
F 1 "0.1uF" H 8500 3750 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 8738 3700 50  0001 C CNN
F 3 "" H 8700 3850 50  0000 C CNN
	1    8700 3850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR44
U 1 1 5853D739
P 8700 4000
F 0 "#PWR44" H 8700 3750 50  0001 C CNN
F 1 "GND" H 8700 3850 50  0000 C CNN
F 2 "" H 8700 4000 50  0000 C CNN
F 3 "" H 8700 4000 50  0000 C CNN
	1    8700 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R48
U 1 1 5853D73F
P 9100 4200
F 0 "R48" V 9000 4200 50  0000 C CNN
F 1 "22R" V 9100 4200 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 9030 4200 50  0001 C CNN
F 3 "" H 9100 4200 50  0000 C CNN
	1    9100 4200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R53
U 1 1 5853D74B
P 9250 4200
F 0 "R53" V 9350 4200 50  0000 C CNN
F 1 "10M" V 9250 4200 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9180 4200 50  0001 C CNN
F 3 "" H 9250 4200 50  0000 C CNN
	1    9250 4200
	1    0    0    -1  
$EndComp
Text GLabel 9850 3850 2    60   Input ~ 0
INJ7&2
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D19
U 1 1 5853D758
P 10100 3700
F 0 "D19" H 10200 3800 50  0000 C CNN
F 1 "LED" H 10000 3800 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 10100 3700 50  0001 C CNN
F 3 "" H 10100 3700 50  0000 C CNN
	1    10100 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R59
U 1 1 5853D75E
P 9750 3700
F 0 "R59" V 9850 3700 50  0000 C CNN
F 1 "2.4k" V 9750 3700 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9680 3700 50  0001 C CNN
F 3 "" H 9750 3700 50  0000 C CNN
	1    9750 3700
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR58
U 1 1 5853D764
P 10300 3700
F 0 "#PWR58" H 10300 3550 50  0001 C CNN
F 1 "+12V" V 10300 3900 50  0000 C CNN
F 2 "" H 10300 3700 50  0000 C CNN
F 3 "" H 10300 3700 50  0000 C CNN
	1    10300 3700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR22
U 1 1 58557D4A
P 4150 4700
F 0 "#PWR22" H 4150 4450 50  0001 C CNN
F 1 "GND" H 4150 4550 50  0000 C CNN
F 2 "" H 4150 4700 50  0000 C CNN
F 3 "" H 4150 4700 50  0000 C CNN
	1    4150 4700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR50
U 1 1 58568DD7
P 9250 4350
F 0 "#PWR50" H 9250 4100 50  0001 C CNN
F 1 "GND" H 9150 4250 50  0000 C CNN
F 2 "" H 9250 4350 50  0000 C CNN
F 3 "" H 9250 4350 50  0000 C CNN
	1    9250 4350
	1    0    0    -1  
$EndComp
Text GLabel 4050 6150 0    60   Input ~ 0
IGN10&5
Text GLabel 4050 5950 0    60   Input ~ 0
IGN4&7
$Comp
L power:GND #PWR30
U 1 1 5858B574
P 5700 5950
F 0 "#PWR30" H 5700 5700 50  0001 C CNN
F 1 "GND" H 5700 5800 50  0000 C CNN
F 2 "" H 5700 5950 50  0000 C CNN
F 3 "" H 5700 5950 50  0000 C CNN
	1    5700 5950
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG4
U 1 1 5859DBC7
P 6000 5950
F 0 "#FLG4" H 6000 6045 50  0001 C CNN
F 1 "PWR_FLAG" H 6000 6130 50  0000 C CNN
F 2 "" H 6000 5950 50  0000 C CNN
F 3 "" H 6000 5950 50  0000 C CNN
	1    6000 5950
	1    0    0    -1  
$EndComp
Text GLabel 5150 6150 2    60   Input ~ 0
IGN1&6
Text GLabel 4550 6050 0    60   Input ~ 0
IGN9&8
Text GLabel 4550 5850 0    60   Input ~ 0
IGN3&2
Text GLabel 8250 6150 0    60   Input ~ 0
INJ9&4
Text GLabel 8250 5950 0    60   Input ~ 0
INJ5&8
$Comp
L power:GND #PWR52
U 1 1 585A20A5
P 9850 5950
F 0 "#PWR52" H 9850 5700 50  0001 C CNN
F 1 "GND" H 9850 5800 50  0000 C CNN
F 2 "" H 9850 5950 50  0000 C CNN
F 3 "" H 9850 5950 50  0000 C CNN
	1    9850 5950
	-1   0    0    1   
$EndComp
Text GLabel 9250 6150 2    60   Input ~ 0
INJ1&10
Text GLabel 8650 6050 0    60   Input ~ 0
INJ3&6
Text GLabel 8650 5850 0    60   Input ~ 0
INJ7&2
Text GLabel 2100 6650 2    60   Input ~ 0
IGN3&2-cntrl
Text GLabel 1350 6550 2    60   Input ~ 0
IGN4&7-cntrl
Text GLabel 2100 6450 2    60   Input ~ 0
IGN9&8-cntrl
Text GLabel 1350 6350 2    60   Input ~ 0
IGN10&5-cntrl
Text GLabel 2100 6250 2    60   Input ~ 0
IGN1&6-cntrl
Text GLabel 2100 6050 2    60   Input ~ 0
INJ7&2-cntrl
Text GLabel 1350 5950 2    60   Input ~ 0
INJ5&8-cntrl
Text GLabel 2100 5850 2    60   Input ~ 0
INJ3&6-cntrl
Text GLabel 1350 5750 2    60   Input ~ 0
INJ9&4-cntrl
Text GLabel 2100 5650 2    60   Input ~ 0
INJ1&10-cntrl
Text GLabel 1450 5550 2    60   Input ~ 0
+5V_MS
Text GLabel 2050 5450 2    60   Input ~ 0
VBatt
NoConn ~ 1300 5350
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:ZENERsmall D12
U 1 1 58521800
P 5550 7500
F 0 "D12" H 5550 7600 50  0000 C CNN
F 1 "5.6V 1W" H 5550 7400 50  0000 C CNN
F 2 "Diodes_ThroughHole:Diode_DO-41_SOD81_Horizontal_RM10" H 5550 7500 50  0001 C CNN
F 3 "" H 5550 7500 50  0000 C CNN
	1    5550 7500
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR32
U 1 1 58521AE1
P 5900 7850
F 0 "#PWR32" H 5900 7600 50  0001 C CNN
F 1 "GND" H 5900 7700 50  0000 C CNN
F 2 "" H 5900 7850 50  0000 C CNN
F 3 "" H 5900 7850 50  0000 C CNN
	1    5900 7850
	0    -1   -1   0   
$EndComp
$Comp
L power:PWR_FLAG #FLG1
U 1 1 586167C7
P 2800 7100
F 0 "#FLG1" H 2800 7195 50  0001 C CNN
F 1 "PWR_FLAG" H 2800 7280 50  0000 C CNN
F 2 "" H 2800 7100 50  0000 C CNN
F 3 "" H 2800 7100 50  0000 C CNN
	1    2800 7100
	1    0    0    -1  
$EndComp
Text GLabel 950  4950 0    60   Input ~ 0
+5V_MS
Text GLabel 1250 4800 0    60   Input ~ 0
IGNspare-cntrl
$Comp
L Device:R R6
U 1 1 5852BD86
P 1200 4950
F 0 "R6" V 1300 4950 50  0000 C CNN
F 1 "1k" V 1200 4950 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 1130 4950 50  0001 C CNN
F 3 "" H 1200 4950 50  0000 C CNN
	1    1200 4950
	0    1    1    0   
$EndComp
Text GLabel 1350 6750 2    60   Input ~ 0
IGNspare-cntrl
Text GLabel 1350 6150 2    60   Input ~ 0
INJspare-cntrl
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:ISL9V3040P3 Q6
U 1 1 585572EE
P 4600 4950
F 0 "Q6" H 4550 5250 50  0000 R CNN
F 1 "ISL9V3040P3" V 4850 5200 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 4800 5050 50  0001 C CNN
F 3 "" H 4600 4950 50  0000 C CNN
	1    4600 4950
	1    0    0    -1  
$EndComp
Text GLabel 5000 4850 2    60   Input ~ 0
IGNspare
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D11
U 1 1 585572F5
P 5250 4650
F 0 "D11" H 5350 4750 50  0000 C CNN
F 1 "LED" H 5150 4750 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 5250 4650 50  0001 C CNN
F 3 "" H 5250 4650 50  0000 C CNN
	1    5250 4650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R30
U 1 1 585572FB
P 4900 4650
F 0 "R30" V 5000 4600 50  0000 C CNN
F 1 "2.4k" V 4900 4650 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4830 4650 50  0001 C CNN
F 3 "" H 4900 4650 50  0000 C CNN
	1    4900 4650
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR28
U 1 1 58557301
P 5450 4650
F 0 "#PWR28" H 5450 4500 50  0001 C CNN
F 1 "+12V" V 5450 4850 50  0000 C CNN
F 2 "" H 5450 4650 50  0000 C CNN
F 3 "" H 5450 4650 50  0000 C CNN
	1    5450 4650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R15
U 1 1 5855A82F
P 3900 4950
F 0 "R15" V 3800 4950 50  0000 C CNN
F 1 "22R" V 3900 4950 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 3830 4950 50  0001 C CNN
F 3 "" H 3900 4950 50  0000 C CNN
	1    3900 4950
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R19
U 1 1 5855ABA2
P 4100 5150
F 0 "R19" V 4200 5150 50  0000 C CNN
F 1 "10M" V 4100 5150 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 4030 5150 50  0001 C CNN
F 3 "" H 4100 5150 50  0000 C CNN
	1    4100 5150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR17
U 1 1 5855B7B4
P 4050 5300
F 0 "#PWR17" H 4050 5050 50  0001 C CNN
F 1 "GND" H 4050 5150 50  0000 C CNN
F 2 "" H 4050 5300 50  0000 C CNN
F 3 "" H 4050 5300 50  0000 C CNN
	1    4050 5300
	0    1    1    0   
$EndComp
$Comp
L Device:R R36
U 1 1 5856468B
P 6300 4650
F 0 "R36" V 6400 4650 50  0000 C CNN
F 1 "1k" V 6300 4650 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 6230 4650 50  0001 C CNN
F 3 "" H 6300 4650 50  0000 C CNN
	1    6300 4650
	0    1    1    0   
$EndComp
Text GLabel 6050 4650 0    60   Input ~ 0
+5V_MS
Text GLabel 6350 4500 0    60   Input ~ 0
INJspare-cntrl
$Comp
L Device:R R42
U 1 1 58565DFF
P 7600 3850
F 0 "R42" V 7500 3850 50  0000 C CNN
F 1 "1k" V 7600 3850 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 7530 3850 50  0001 C CNN
F 3 "" H 7600 3850 50  0000 C CNN
	1    7600 3850
	-1   0    0    1   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LED D20
U 1 1 5856A555
P 10100 4200
F 0 "D20" H 10200 4300 50  0000 C CNN
F 1 "LED" H 10000 4300 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 10100 4200 50  0001 C CNN
F 3 "" H 10100 4200 50  0000 C CNN
	1    10100 4200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R60
U 1 1 5856A55B
P 9750 4200
F 0 "R60" V 9850 4150 50  0000 C CNN
F 1 "2.4k" V 9750 4200 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9680 4200 50  0001 C CNN
F 3 "" H 9750 4200 50  0000 C CNN
	1    9750 4200
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR59
U 1 1 5856A561
P 10350 4200
F 0 "#PWR59" H 10350 4050 50  0001 C CNN
F 1 "+12V" V 10350 4400 50  0000 C CNN
F 2 "" H 10350 4200 50  0000 C CNN
F 3 "" H 10350 4200 50  0000 C CNN
	1    10350 4200
	1    0    0    -1  
$EndComp
Text GLabel 9850 4350 2    60   Input ~ 0
INJspare
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:AUIRF3205-RESCUE-V10_Ign-Inj_Drivers_V2 Q12
U 1 1 5856A568
P 9450 4450
F 0 "Q12" H 9650 4500 50  0000 L CNN
F 1 "AUIRF3205" H 9650 4400 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 9650 4375 50  0001 L CIN
F 3 "" H 9450 4450 50  0000 L CNN
	1    9450 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R45
U 1 1 5856AF8A
P 9050 4550
F 0 "R45" V 8950 4550 50  0000 C CNN
F 1 "22R" V 9050 4550 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 8980 4550 50  0001 C CNN
F 3 "" H 9050 4550 50  0000 C CNN
	1    9050 4550
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R54
U 1 1 5856B1EE
P 9250 4700
F 0 "R54" V 9350 4700 50  0000 C CNN
F 1 "10M" V 9250 4700 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 9180 4700 50  0001 C CNN
F 3 "" H 9250 4700 50  0000 C CNN
	1    9250 4700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR47
U 1 1 5856B3C7
P 9200 4850
F 0 "#PWR47" H 9200 4600 50  0001 C CNN
F 1 "GND" H 9200 4700 50  0000 C CNN
F 2 "" H 9200 4850 50  0000 C CNN
F 3 "" H 9200 4850 50  0000 C CNN
	1    9200 4850
	0    1    1    0   
$EndComp
Text GLabel 5150 5850 2    60   Input ~ 0
IGNspare
$Comp
L power:GND #PWR31
U 1 1 585812BB
P 5700 6050
F 0 "#PWR31" H 5700 5800 50  0001 C CNN
F 1 "GND" H 5700 5900 50  0000 C CNN
F 2 "" H 5700 6050 50  0000 C CNN
F 3 "" H 5700 6050 50  0000 C CNN
	1    5700 6050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR53
U 1 1 5858779C
P 9850 6050
F 0 "#PWR53" H 9850 5800 50  0001 C CNN
F 1 "GND" H 9850 5900 50  0000 C CNN
F 2 "" H 9850 6050 50  0000 C CNN
F 3 "" H 9850 6050 50  0000 C CNN
	1    9850 6050
	1    0    0    -1  
$EndComp
Text GLabel 9250 5850 2    60   Input ~ 0
INJspare
$Comp
L Device:CP1 C11
U 1 1 585504E4
P 5800 7450
F 0 "C11" H 5825 7550 50  0000 L CNN
F 1 "47uF" H 5825 7350 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D10_L13_P5" H 5800 7450 50  0001 C CNN
F 3 "" H 5800 7450 50  0000 C CNN
	1    5800 7450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR12
U 1 1 5857F95C
P 3600 1300
F 0 "#PWR12" H 3600 1050 50  0001 C CNN
F 1 "GND" H 3600 1150 50  0000 C CNN
F 2 "" H 3600 1300 50  0000 C CNN
F 3 "" H 3600 1300 50  0000 C CNN
	1    3600 1300
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR1
U 1 1 58580035
P 2750 950
F 0 "#PWR1" H 2750 800 50  0001 C CNN
F 1 "+5V" V 2650 1050 50  0000 C CNN
F 2 "" H 2750 950 50  0000 C CNN
F 3 "" H 2750 950 50  0000 C CNN
	1    2750 950 
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:ISL9V3040P3 Q3
U 1 1 584DE443
P 4600 2800
F 0 "Q3" H 4550 3100 50  0000 R CNN
F 1 "ISL9V3040P3" V 4850 3050 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 4800 2900 50  0001 C CNN
F 3 "" H 4600 2800 50  0000 C CNN
	1    4600 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 58589A69
P 2750 2650
F 0 "C2" H 2750 2750 50  0000 L CNN
F 1 "0.1uF" H 2750 2550 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 2788 2500 50  0001 C CNN
F 3 "" H 2750 2650 50  0000 C CNN
	1    2750 2650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 58589A6F
P 2350 2650
F 0 "R8" V 2450 2650 50  0000 C CNN
F 1 "1k" V 2350 2650 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 2280 2650 50  0001 C CNN
F 3 "" H 2350 2650 50  0000 C CNN
	1    2350 2650
	-1   0    0    1   
$EndComp
$Comp
L Device:R R11
U 1 1 58589A75
P 2500 2650
F 0 "R11" V 2400 2650 50  0000 C CNN
F 1 "1k" V 2500 2650 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 2430 2650 50  0001 C CNN
F 3 "" H 2500 2650 50  0000 C CNN
	1    2500 2650
	-1   0    0    1   
$EndComp
$Comp
L Device:C C6
U 1 1 58589A7B
P 3600 2650
F 0 "C6" H 3625 2750 50  0000 L CNN
F 1 "0.1uF" H 3600 2550 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 3638 2500 50  0001 C CNN
F 3 "" H 3600 2650 50  0000 C CNN
	1    3600 2650
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR13
U 1 1 58589A81
P 3600 2400
F 0 "#PWR13" H 3600 2250 50  0001 C CNN
F 1 "+5V" V 3500 2500 50  0000 C CNN
F 2 "" H 3600 2400 50  0000 C CNN
F 3 "" H 3600 2400 50  0000 C CNN
	1    3600 2400
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR4
U 1 1 58589A8C
P 2750 2400
F 0 "#PWR4" H 2750 2250 50  0001 C CNN
F 1 "+5V" V 2650 2500 50  0000 C CNN
F 2 "" H 2750 2400 50  0000 C CNN
F 3 "" H 2750 2400 50  0000 C CNN
	1    2750 2400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR14
U 1 1 5858CE86
P 3600 2800
F 0 "#PWR14" H 3600 2550 50  0001 C CNN
F 1 "GND" H 3600 2650 50  0000 C CNN
F 2 "" H 3600 2800 50  0000 C CNN
F 3 "" H 3600 2800 50  0000 C CNN
	1    3600 2800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR5
U 1 1 5858D02C
P 2750 2800
F 0 "#PWR5" H 2750 2550 50  0001 C CNN
F 1 "GND" H 2750 2650 50  0000 C CNN
F 2 "" H 2750 2800 50  0000 C CNN
F 3 "" H 2750 2800 50  0000 C CNN
	1    2750 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 585A4DF5
P 2750 4100
F 0 "C3" H 2750 4200 50  0000 L CNN
F 1 "0.1uF" H 2750 4000 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 2788 3950 50  0001 C CNN
F 3 "" H 2750 4100 50  0000 C CNN
	1    2750 4100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 585A4DFB
P 2350 4100
F 0 "R9" V 2450 4100 50  0000 C CNN
F 1 "1k" V 2350 4100 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 2280 4100 50  0001 C CNN
F 3 "" H 2350 4100 50  0000 C CNN
	1    2350 4100
	-1   0    0    1   
$EndComp
$Comp
L Device:R R12
U 1 1 585A4E01
P 2500 4100
F 0 "R12" V 2400 4100 50  0000 C CNN
F 1 "1k" V 2500 4100 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 2430 4100 50  0001 C CNN
F 3 "" H 2500 4100 50  0000 C CNN
	1    2500 4100
	-1   0    0    1   
$EndComp
$Comp
L Device:C C7
U 1 1 585A4E07
P 3600 4100
F 0 "C7" H 3625 4200 50  0000 L CNN
F 1 "0.1uF" H 3600 4000 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 3638 3950 50  0001 C CNN
F 3 "" H 3600 4100 50  0000 C CNN
	1    3600 4100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR15
U 1 1 585A4E0D
P 3600 3850
F 0 "#PWR15" H 3600 3700 50  0001 C CNN
F 1 "+5V" V 3500 3950 50  0000 C CNN
F 2 "" H 3600 3850 50  0000 C CNN
F 3 "" H 3600 3850 50  0000 C CNN
	1    3600 3850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR7
U 1 1 585A4E14
P 2750 3850
F 0 "#PWR7" H 2750 3700 50  0001 C CNN
F 1 "+5V" V 2650 3950 50  0000 C CNN
F 2 "" H 2750 3850 50  0000 C CNN
F 3 "" H 2750 3850 50  0000 C CNN
	1    2750 3850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR16
U 1 1 585A4E1C
P 3600 4250
F 0 "#PWR16" H 3600 4000 50  0001 C CNN
F 1 "GND" H 3600 4100 50  0000 C CNN
F 2 "" H 3600 4250 50  0000 C CNN
F 3 "" H 3600 4250 50  0000 C CNN
	1    3600 4250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR8
U 1 1 585A4E22
P 2750 4250
F 0 "#PWR8" H 2750 4000 50  0001 C CNN
F 1 "GND" H 2750 4100 50  0000 C CNN
F 2 "" H 2750 4250 50  0000 C CNN
F 3 "" H 2750 4250 50  0000 C CNN
	1    2750 4250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR34
U 1 1 585EE29A
P 7850 1200
F 0 "#PWR34" H 7850 950 50  0001 C CNN
F 1 "GND" H 7850 1050 50  0000 C CNN
F 2 "" H 7850 1200 50  0000 C CNN
F 3 "" H 7850 1200 50  0000 C CNN
	1    7850 1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR37
U 1 1 586075B6
P 7850 2600
F 0 "#PWR37" H 7850 2350 50  0001 C CNN
F 1 "GND" H 7850 2450 50  0000 C CNN
F 2 "" H 7850 2600 50  0000 C CNN
F 3 "" H 7850 2600 50  0000 C CNN
	1    7850 2600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR40
U 1 1 5860CFE6
P 7850 4000
F 0 "#PWR40" H 7850 3750 50  0001 C CNN
F 1 "GND" H 7850 3850 50  0000 C CNN
F 2 "" H 7850 4000 50  0000 C CNN
F 3 "" H 7850 4000 50  0000 C CNN
	1    7850 4000
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:LM2931AZ-5.0 U7
U 1 1 5857D5E2
P 4200 7250
F 0 "U7" H 4200 7550 50  0000 C CNN
F 1 "LM2931AZ-5.0" H 4200 7450 50  0000 C CNN
F 2 "TO_SOT_Packages_THT:TO-220_Neutral123_Vertical" H 4200 7350 50  0000 C CIN
F 3 "" H 4200 7250 50  0000 C CNN
	1    4200 7250
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Molex2x4MiniFit P1
U 1 1 5859696D
P 4850 6000
F 0 "P1" H 4850 6250 50  0000 C CNN
F 1 "Molex2x4MiniFit" H 4850 5750 50  0000 C CNN
F 2 "Connectors_Molex:Molex_MiniFit-JR-5569-08A2_2x04x4.20mm_Angled" H 4850 4800 50  0001 C CNN
F 3 "" H 4850 4800 50  0000 C CNN
	1    4850 6000
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Molex2x4MiniFit P2
U 1 1 585988D9
P 8950 6000
F 0 "P2" H 8950 6250 50  0000 C CNN
F 1 "Molex2x4MiniFit" H 8950 5750 50  0000 C CNN
F 2 "Connectors_Molex:Molex_MiniFit-JR-5569-08A2_2x04x4.20mm_Angled" H 8950 4800 50  0001 C CNN
F 3 "" H 8950 4800 50  0000 C CNN
	1    8950 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 7200 4650 7200
Wire Wire Line
	4650 7250 4650 7200
Connection ~ 4650 7200
Wire Wire Line
	4900 6900 4900 7200
Connection ~ 4900 7200
Wire Wire Line
	2250 7850 2800 7850
Wire Wire Line
	2800 7550 2800 7850
Connection ~ 2800 7850
Wire Wire Line
	3550 6900 3750 6900
Wire Wire Line
	5500 7200 5550 7200
Wire Wire Line
	5550 7050 5550 7200
Wire Wire Line
	4900 7850 4900 7550
Connection ~ 3100 7850
Wire Wire Line
	3500 7500 3500 7850
Connection ~ 3500 7850
Wire Wire Line
	3750 7550 3750 7850
Connection ~ 3750 7850
Wire Wire Line
	4650 7550 4650 7850
Connection ~ 4650 7850
Connection ~ 4200 7850
Wire Wire Line
	5800 7150 5800 7200
Connection ~ 5550 7200
Wire Wire Line
	950  2950 1050 2950
Wire Wire Line
	1350 2950 1350 3050
Wire Wire Line
	1350 3350 1350 3450
Wire Wire Line
	1050 3450 950  3450
Wire Wire Line
	1250 3300 1350 3300
Wire Wire Line
	1350 3300 1350 3250
Wire Wire Line
	1250 3100 1350 3100
Wire Wire Line
	1350 3100 1350 3150
Wire Wire Line
	2750 3250 2750 3350
Wire Wire Line
	2750 3350 2200 3350
Wire Wire Line
	2350 2800 2350 3150
Wire Wire Line
	2200 3150 2350 3150
Wire Wire Line
	2500 2800 2500 3250
Wire Wire Line
	2500 3250 2200 3250
Connection ~ 2750 3350
Wire Wire Line
	2900 3250 2750 3250
Connection ~ 2350 3150
Wire Wire Line
	2500 3300 2900 3300
Wire Wire Line
	2900 3300 2900 3350
Connection ~ 2500 3250
Wire Wire Line
	3750 3250 3850 3250
Wire Wire Line
	6050 1350 6150 1350
Wire Wire Line
	6450 1350 6450 1450
Wire Wire Line
	6450 1750 6450 1850
Wire Wire Line
	6150 1850 6050 1850
Wire Wire Line
	6350 1700 6450 1700
Wire Wire Line
	6450 1700 6450 1650
Wire Wire Line
	6350 1500 6450 1500
Wire Wire Line
	6450 1500 6450 1550
Wire Wire Line
	7850 1750 7300 1750
Wire Wire Line
	7450 1200 7450 1550
Wire Wire Line
	7300 1550 7450 1550
Wire Wire Line
	7600 1200 7600 1650
Wire Wire Line
	7600 1650 7300 1650
Connection ~ 7450 900 
Connection ~ 7600 900 
Connection ~ 7850 1750
Wire Wire Line
	8000 1650 7850 1650
Connection ~ 7450 1550
Wire Wire Line
	7600 1700 8000 1700
Wire Wire Line
	8000 1700 8000 1750
Connection ~ 7600 1650
Wire Wire Line
	7300 900  7450 900 
Connection ~ 7850 900 
Wire Wire Line
	7300 900  7300 1450
Wire Wire Line
	7850 900  7850 850 
Wire Wire Line
	4150 2800 4150 2850
Wire Wire Line
	4150 2800 4000 2800
Wire Wire Line
	4000 2800 4000 2850
Wire Wire Line
	4000 3150 3750 3150
Wire Wire Line
	4700 3100 4250 3100
Wire Wire Line
	4250 3100 4250 3150
Wire Wire Line
	4250 3150 4150 3150
Wire Wire Line
	4300 3750 4700 3750
Wire Wire Line
	4300 3800 4300 3750
Wire Wire Line
	4100 3800 4150 3800
Wire Wire Line
	4150 3450 4150 3500
Wire Wire Line
	4150 3450 4050 3450
Wire Wire Line
	3750 3450 3750 3350
Wire Wire Line
	4750 2500 4700 2500
Wire Wire Line
	4750 3150 4700 3150
Connection ~ 4150 3800
Wire Wire Line
	5000 3350 4750 3350
Wire Wire Line
	4750 3150 4750 3350
Wire Wire Line
	5000 2700 4750 2700
Wire Wire Line
	4750 2500 4750 2700
Wire Wire Line
	9550 950  9600 950 
Wire Wire Line
	9600 950  9600 1050
Wire Wire Line
	9600 1050 9850 1050
Wire Wire Line
	9550 1450 9600 1450
Wire Wire Line
	9600 1450 9600 1550
Wire Wire Line
	9600 1550 9850 1550
Wire Wire Line
	9600 1400 9550 1400
Wire Wire Line
	9550 1400 9550 1450
Wire Wire Line
	9600 900  9550 900 
Wire Wire Line
	9550 900  9550 950 
Wire Wire Line
	9250 1200 9250 1250
Wire Wire Line
	9250 1200 9100 1200
Wire Wire Line
	9100 1200 9100 1250
Wire Wire Line
	9100 1550 8850 1550
Wire Wire Line
	9250 1700 9250 1750
Wire Wire Line
	9250 1750 9200 1750
Wire Wire Line
	8900 1750 8850 1750
Wire Wire Line
	9550 1350 9400 1350
Wire Wire Line
	9400 1350 9400 1550
Wire Wire Line
	9400 1550 9250 1550
Wire Wire Line
	9550 2050 9550 1850
Wire Wire Line
	9200 2050 9250 2050
Connection ~ 9250 2050
Wire Wire Line
	4150 3150 4150 3200
Wire Wire Line
	950  1450 1050 1450
Wire Wire Line
	1350 1450 1350 1550
Wire Wire Line
	1350 1850 1350 1950
Wire Wire Line
	1050 1950 950  1950
Wire Wire Line
	1250 1800 1350 1800
Wire Wire Line
	1350 1800 1350 1750
Wire Wire Line
	1250 1600 1350 1600
Wire Wire Line
	1350 1600 1350 1650
Wire Wire Line
	2750 1850 2200 1850
Wire Wire Line
	2200 1650 2350 1650
Connection ~ 2350 1000
Connection ~ 2500 1000
Connection ~ 2750 1850
Wire Wire Line
	2900 1750 2750 1750
Wire Wire Line
	2900 1800 2900 1850
Wire Wire Line
	3850 1750 3750 1750
Wire Wire Line
	4150 1300 4150 1350
Wire Wire Line
	4150 1300 4000 1300
Wire Wire Line
	4000 1300 4000 1350
Wire Wire Line
	4000 1650 3750 1650
Wire Wire Line
	4700 1600 4250 1600
Wire Wire Line
	4250 1600 4250 1650
Wire Wire Line
	4250 1650 4150 1650
Wire Wire Line
	4300 2250 4700 2250
Wire Wire Line
	4300 2300 4300 2250
Wire Wire Line
	4100 2300 4150 2300
Wire Wire Line
	4150 1950 4150 2000
Wire Wire Line
	4150 1950 4050 1950
Wire Wire Line
	3750 1950 3750 1850
Wire Wire Line
	4750 1000 4700 1000
Wire Wire Line
	4750 1650 4700 1650
Connection ~ 4150 2300
Wire Wire Line
	5000 1850 4750 1850
Wire Wire Line
	4750 1650 4750 1850
Wire Wire Line
	5000 1200 4750 1200
Wire Wire Line
	4150 1650 4150 1700
Wire Wire Line
	950  4450 1050 4450
Wire Wire Line
	1350 4450 1350 4550
Wire Wire Line
	1250 4600 1350 4600
Wire Wire Line
	1350 4600 1350 4650
Wire Wire Line
	2750 4750 2750 4850
Wire Wire Line
	2750 4850 2200 4850
Wire Wire Line
	2200 4650 2350 4650
Connection ~ 2750 4850
Wire Wire Line
	2750 4750 2900 4750
Connection ~ 2350 4650
Wire Wire Line
	3750 4750 3850 4750
Wire Wire Line
	4150 4300 4150 4350
Wire Wire Line
	4150 4300 4000 4300
Wire Wire Line
	4000 4300 4000 4350
Wire Wire Line
	4000 4650 3750 4650
Wire Wire Line
	4700 4600 4250 4600
Wire Wire Line
	4250 4600 4250 4650
Wire Wire Line
	4250 4650 4150 4650
Wire Wire Line
	4750 4000 4700 4000
Wire Wire Line
	5000 4200 4750 4200
Wire Wire Line
	4750 4000 4750 4200
Wire Wire Line
	4150 4650 4150 4700
Wire Wire Line
	6050 2750 6150 2750
Wire Wire Line
	6450 2750 6450 2850
Wire Wire Line
	6450 3150 6450 3250
Wire Wire Line
	6150 3250 6050 3250
Wire Wire Line
	6350 3100 6450 3100
Wire Wire Line
	6450 3100 6450 3050
Wire Wire Line
	6350 2900 6450 2900
Wire Wire Line
	6450 2900 6450 2950
Wire Wire Line
	7850 3050 7850 3150
Wire Wire Line
	7850 3150 7300 3150
Wire Wire Line
	7450 2600 7450 2950
Wire Wire Line
	7300 2950 7450 2950
Wire Wire Line
	7600 2600 7600 3050
Wire Wire Line
	7600 3050 7300 3050
Connection ~ 7450 2300
Connection ~ 7600 2300
Connection ~ 7850 3150
Wire Wire Line
	8000 3050 7850 3050
Connection ~ 7450 2950
Wire Wire Line
	7600 3100 8000 3100
Wire Wire Line
	8000 3100 8000 3150
Connection ~ 7600 3050
Wire Wire Line
	7300 2300 7450 2300
Connection ~ 7850 2300
Wire Wire Line
	7300 2850 7300 2300
Wire Wire Line
	7850 2300 7850 2250
Wire Wire Line
	9550 2350 9600 2350
Wire Wire Line
	9600 2350 9600 2450
Wire Wire Line
	9600 2450 9850 2450
Wire Wire Line
	9550 2850 9600 2850
Wire Wire Line
	9600 2850 9600 2950
Wire Wire Line
	9600 2950 9850 2950
Wire Wire Line
	9600 2800 9550 2800
Wire Wire Line
	9550 2800 9550 2850
Wire Wire Line
	9600 2300 9550 2300
Wire Wire Line
	9550 2300 9550 2350
Wire Wire Line
	9250 2600 9250 2650
Wire Wire Line
	9250 2600 9100 2600
Wire Wire Line
	9100 2600 9100 2650
Wire Wire Line
	9100 2950 8850 2950
Wire Wire Line
	9250 3100 9250 3150
Wire Wire Line
	9250 3150 9200 3150
Wire Wire Line
	8900 3150 8850 3150
Wire Wire Line
	9550 2750 9400 2750
Wire Wire Line
	9400 2750 9400 2950
Wire Wire Line
	9400 2950 9250 2950
Wire Wire Line
	9550 3450 9550 3250
Wire Wire Line
	9200 3450 9250 3450
Connection ~ 9250 3450
Wire Wire Line
	6050 4150 6150 4150
Wire Wire Line
	6450 4150 6450 4250
Wire Wire Line
	6350 4300 6450 4300
Wire Wire Line
	6450 4300 6450 4350
Wire Wire Line
	7850 4450 7850 4550
Wire Wire Line
	7850 4550 7300 4550
Wire Wire Line
	7450 4000 7450 4350
Wire Wire Line
	7300 4350 7450 4350
Connection ~ 7450 3700
Connection ~ 7600 3700
Connection ~ 7850 4550
Wire Wire Line
	8000 4450 7850 4450
Connection ~ 7450 4350
Wire Wire Line
	7300 3700 7450 3700
Connection ~ 7850 3700
Wire Wire Line
	7300 4250 7300 3700
Wire Wire Line
	7850 3700 7850 3650
Wire Wire Line
	9550 3750 9600 3750
Wire Wire Line
	9600 3750 9600 3850
Wire Wire Line
	9600 3850 9850 3850
Wire Wire Line
	9600 3700 9550 3700
Wire Wire Line
	9550 3700 9550 3750
Wire Wire Line
	9250 4000 9250 4050
Wire Wire Line
	9250 4000 9100 4000
Wire Wire Line
	9100 4000 9100 4050
Wire Wire Line
	9100 4350 8850 4350
Wire Wire Line
	9550 4150 9400 4150
Wire Wire Line
	9400 4350 9250 4350
Wire Wire Line
	1300 5750 1350 5750
Wire Wire Line
	1300 5850 2100 5850
Wire Wire Line
	1350 5950 1300 5950
Wire Wire Line
	1300 6050 2100 6050
Wire Wire Line
	1350 6150 1300 6150
Wire Wire Line
	1300 6250 2100 6250
Wire Wire Line
	1350 6350 1300 6350
Wire Wire Line
	1300 6450 2100 6450
Wire Wire Line
	1350 6550 1300 6550
Wire Wire Line
	1350 6750 1300 6750
Wire Wire Line
	3100 7600 3100 7550
Wire Wire Line
	3100 7800 3100 7850
Wire Wire Line
	5550 7850 5550 7600
Connection ~ 4900 7850
Wire Wire Line
	2150 7050 2250 7050
Wire Wire Line
	2250 7050 2250 7200
Wire Wire Line
	2250 7200 2800 7200
Wire Wire Line
	3450 7200 3500 7200
Wire Wire Line
	3750 6900 3750 7200
Connection ~ 3750 7200
Wire Wire Line
	3500 7300 3500 7200
Connection ~ 3500 7200
Wire Wire Line
	3100 7100 3100 7200
Connection ~ 3100 7200
Connection ~ 2800 7200
Wire Wire Line
	1300 5650 2100 5650
Wire Wire Line
	2800 7100 2800 7200
Connection ~ 3750 6900
Wire Wire Line
	1350 4750 1350 4800
Wire Wire Line
	1350 4800 1250 4800
Wire Wire Line
	1350 4850 1350 4950
Wire Wire Line
	1050 4950 950  4950
Wire Wire Line
	2500 4250 2500 4750
Wire Wire Line
	2500 4750 2200 4750
Wire Wire Line
	2900 4800 2900 4850
Wire Wire Line
	2500 4800 2900 4800
Connection ~ 2500 4750
Wire Wire Line
	1300 5450 2050 5450
Wire Wire Line
	1300 5550 1450 5550
Connection ~ 5550 7850
Wire Wire Line
	2100 6650 1300 6650
Wire Wire Line
	4700 5250 4250 5250
Wire Wire Line
	4750 4650 4700 4650
Wire Wire Line
	5000 4850 4750 4850
Wire Wire Line
	4750 4650 4750 4850
Wire Wire Line
	3750 4850 3750 4950
Wire Wire Line
	4050 4950 4100 4950
Wire Wire Line
	4100 5000 4100 4950
Connection ~ 4100 4950
Wire Wire Line
	4250 5250 4250 5300
Wire Wire Line
	4250 5300 4100 5300
Connection ~ 4100 5300
Wire Wire Line
	6450 4450 6450 4500
Wire Wire Line
	6450 4500 6350 4500
Wire Wire Line
	6450 4550 6450 4650
Wire Wire Line
	6150 4650 6050 4650
Wire Wire Line
	8000 4550 8000 4500
Wire Wire Line
	8000 4500 7600 4500
Wire Wire Line
	7600 4500 7600 4450
Wire Wire Line
	7600 4450 7300 4450
Connection ~ 7600 4450
Wire Wire Line
	9900 4200 9950 4200
Wire Wire Line
	9600 4250 9600 4350
Wire Wire Line
	9600 4350 9850 4350
Wire Wire Line
	9550 4850 9550 4650
Wire Wire Line
	9400 4150 9400 4350
Wire Wire Line
	9200 4850 9250 4850
Wire Wire Line
	9250 4500 9250 4550
Wire Wire Line
	9250 4550 9200 4550
Wire Wire Line
	8900 4550 8850 4550
Wire Wire Line
	9600 4250 9550 4250
Wire Wire Line
	9600 4200 9550 4200
Wire Wire Line
	9550 4200 9550 4250
Wire Wire Line
	4200 7500 4200 7850
Connection ~ 9250 4850
Wire Wire Line
	10350 4200 10300 4200
Connection ~ 5800 7200
Wire Wire Line
	5800 7600 5800 7850
Connection ~ 5800 7850
Wire Wire Line
	2750 1750 2750 1850
Wire Wire Line
	2200 1000 2200 1550
Wire Wire Line
	3850 1000 3850 1750
Wire Wire Line
	2350 1300 2350 1650
Connection ~ 2350 1650
Wire Wire Line
	2500 1300 2500 1750
Wire Wire Line
	2500 1750 2200 1750
Wire Wire Line
	2500 1800 2900 1800
Connection ~ 2500 1750
Wire Wire Line
	3600 1000 3600 950 
Wire Wire Line
	2750 1000 2750 950 
Wire Wire Line
	2200 1000 2350 1000
Wire Wire Line
	3850 1000 3600 1000
Wire Wire Line
	3850 3250 3850 2500
Wire Wire Line
	3600 2500 3600 2400
Wire Wire Line
	2750 2500 2750 2400
Wire Wire Line
	3850 2500 3600 2500
Wire Wire Line
	2200 2500 2200 3050
Wire Wire Line
	2200 2500 2350 2500
Connection ~ 2500 2500
Connection ~ 2350 2500
Wire Wire Line
	2350 4250 2350 4650
Wire Wire Line
	3600 3950 3600 3850
Wire Wire Line
	2750 3950 2750 3850
Wire Wire Line
	3850 3950 3600 3950
Wire Wire Line
	2200 3950 2200 4550
Wire Wire Line
	2200 3950 2350 3950
Connection ~ 2500 3950
Connection ~ 2350 3950
Wire Wire Line
	3850 4750 3850 3950
Wire Wire Line
	9350 900  9300 900 
Wire Wire Line
	8100 900  8400 900 
Connection ~ 8700 900 
Connection ~ 8400 900 
Wire Wire Line
	8100 1100 8100 1200
Wire Wire Line
	8100 1200 8400 1200
Connection ~ 8400 1200
Wire Wire Line
	8850 1650 8900 1650
Wire Wire Line
	8900 900  8900 1650
Connection ~ 8900 900 
Wire Wire Line
	8900 2300 8700 2300
Connection ~ 8900 1650
Wire Wire Line
	8900 3050 8850 3050
Connection ~ 8900 2300
Wire Wire Line
	8900 3700 8700 3700
Connection ~ 8900 3050
Wire Wire Line
	8900 4450 8850 4450
Connection ~ 8900 3700
Wire Wire Line
	7850 1650 7850 1750
Wire Wire Line
	9250 5850 9200 5850
Wire Wire Line
	9850 5950 9200 5950
Wire Wire Line
	9850 6050 9200 6050
Wire Wire Line
	9250 6150 9200 6150
Wire Wire Line
	8650 5850 8700 5850
Wire Wire Line
	8250 5950 8700 5950
Wire Wire Line
	8700 6050 8650 6050
Wire Wire Line
	8700 6150 8250 6150
Wire Wire Line
	5100 5850 5150 5850
Wire Wire Line
	5100 5950 5700 5950
Connection ~ 5700 5950
Wire Wire Line
	5100 6050 5700 6050
Wire Wire Line
	5100 6150 5150 6150
Wire Wire Line
	4600 5850 4550 5850
Wire Wire Line
	4050 5950 4100 5950
Wire Wire Line
	4600 6050 4550 6050
Wire Wire Line
	4050 6150 4100 6150
Wire Wire Line
	4600 5700 4600 5850
Wire Wire Line
	4100 5800 4100 5950
Connection ~ 4100 5950
Wire Wire Line
	4600 6250 4600 6050
Wire Wire Line
	4100 6350 4100 6150
Connection ~ 4100 6150
Wire Wire Line
	4750 2000 4950 2000
Connection ~ 4750 1850
Wire Wire Line
	4750 2850 4950 2850
Connection ~ 4750 2700
Wire Wire Line
	4750 3500 4950 3500
Connection ~ 4750 3350
Wire Wire Line
	4750 4350 4950 4350
Connection ~ 4750 4200
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Jumper-Pad JP5
U 1 1 585D90AC
P 5150 2000
F 0 "JP5" H 5300 2000 50  0000 C CNN
F 1 "Jumper-Pad" H 5150 1900 50  0000 C CNN
F 2 "Connect:1pin" H 5150 2000 50  0001 C CNN
F 3 "" H 5150 2000 50  0000 C CNN
	1    5150 2000
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Jumper-Pad JP6
U 1 1 585E03C9
P 5150 2850
F 0 "JP6" H 5300 2850 50  0000 C CNN
F 1 "Jumper-Pad" H 5150 2750 50  0000 C CNN
F 2 "Connect:1pin" H 5150 2850 50  0001 C CNN
F 3 "" H 5150 2850 50  0000 C CNN
	1    5150 2850
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Jumper-Pad JP7
U 1 1 585E0582
P 5150 3500
F 0 "JP7" H 5300 3500 50  0000 C CNN
F 1 "Jumper-Pad" H 5150 3400 50  0000 C CNN
F 2 "Connect:1pin" H 5150 3500 50  0001 C CNN
F 3 "" H 5150 3500 50  0000 C CNN
	1    5150 3500
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Jumper-Pad JP8
U 1 1 585E2A4B
P 5150 4350
F 0 "JP8" H 5300 4350 50  0000 C CNN
F 1 "Jumper-Pad" H 5150 4250 50  0000 C CNN
F 2 "Connect:1pin" H 5150 4350 50  0001 C CNN
F 3 "" H 5150 4350 50  0000 C CNN
	1    5150 4350
	1    0    0    -1  
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Jumper-Pad JP3
U 1 1 585E70D9
P 4400 5700
F 0 "JP3" H 4550 5700 50  0000 C CNN
F 1 "Jumper-Pad" H 4400 5600 50  0000 C CNN
F 2 "Connect:1pin" H 4400 5700 50  0001 C CNN
F 3 "" H 4400 5700 50  0000 C CNN
	1    4400 5700
	-1   0    0    1   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Jumper-Pad JP1
U 1 1 585E72AC
P 3900 5800
F 0 "JP1" H 4050 5800 50  0000 C CNN
F 1 "Jumper-Pad" H 3900 5700 50  0000 C CNN
F 2 "Connect:1pin" H 3900 5800 50  0001 C CNN
F 3 "" H 3900 5800 50  0000 C CNN
	1    3900 5800
	-1   0    0    1   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Jumper-Pad JP2
U 1 1 585E849C
P 3900 6350
F 0 "JP2" H 4050 6350 50  0000 C CNN
F 1 "Jumper-Pad" H 3900 6450 50  0000 C CNN
F 2 "Connect:1pin" H 3900 6350 50  0001 C CNN
F 3 "" H 3900 6350 50  0000 C CNN
	1    3900 6350
	-1   0    0    1   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Jumper-Pad JP4
U 1 1 585E8653
P 4400 6250
F 0 "JP4" H 4550 6250 50  0000 C CNN
F 1 "Jumper-Pad" H 4400 6350 50  0000 C CNN
F 2 "Connect:1pin" H 4400 6250 50  0001 C CNN
F 3 "" H 4400 6250 50  0000 C CNN
	1    4400 6250
	-1   0    0    1   
$EndComp
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Jumper-Pad JP10
U 1 1 585D8230
P 5200 5000
F 0 "JP10" H 5350 5000 50  0000 C CNN
F 1 "Jumper-Pad" H 5200 4900 50  0000 C CNN
F 2 "Connect:1pin" H 5200 5000 50  0001 C CNN
F 3 "" H 5200 5000 50  0000 C CNN
	1    5200 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 5000 5000 5000
Connection ~ 4750 4850
$Comp
L V10-Ign-Inj-Drivers-V2-rescue:Jumper-Pad JP11
U 1 1 585E6F31
P 5300 5650
F 0 "JP11" H 5450 5650 50  0000 C CNN
F 1 "Jumper-Pad" H 5300 5750 50  0000 C CNN
F 2 "Connect:1pin" H 5300 5650 50  0001 C CNN
F 3 "" H 5300 5650 50  0000 C CNN
	1    5300 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 5650 5100 5850
Wire Wire Line
	4750 1200 4750 1000
Wire Wire Line
	4650 7200 4900 7200
Wire Wire Line
	4900 7200 4900 7250
Wire Wire Line
	2800 7850 3100 7850
Wire Wire Line
	3100 7850 3500 7850
Wire Wire Line
	3500 7850 3750 7850
Wire Wire Line
	3750 7850 4200 7850
Wire Wire Line
	4650 7850 4900 7850
Wire Wire Line
	4200 7850 4650 7850
Wire Wire Line
	5550 7200 5800 7200
Wire Wire Line
	5550 7200 5550 7400
Wire Wire Line
	2750 3350 2750 3450
Wire Wire Line
	2350 3150 2900 3150
Wire Wire Line
	2500 3250 2500 3300
Wire Wire Line
	7450 900  7600 900 
Wire Wire Line
	7600 900  7850 900 
Wire Wire Line
	7850 1750 7850 1850
Wire Wire Line
	7450 1550 8000 1550
Wire Wire Line
	7600 1650 7600 1700
Wire Wire Line
	4150 3800 4300 3800
Wire Wire Line
	9250 2050 9550 2050
Wire Wire Line
	2350 1000 2500 1000
Wire Wire Line
	2500 1000 2750 1000
Wire Wire Line
	2750 1850 2750 1950
Wire Wire Line
	4150 2300 4300 2300
Wire Wire Line
	2750 4850 2750 4950
Wire Wire Line
	2350 4650 2900 4650
Wire Wire Line
	7450 2300 7600 2300
Wire Wire Line
	7600 2300 7850 2300
Wire Wire Line
	7850 3150 7850 3250
Wire Wire Line
	7450 2950 8000 2950
Wire Wire Line
	7600 3050 7600 3100
Wire Wire Line
	9250 3450 9550 3450
Wire Wire Line
	7450 3700 7600 3700
Wire Wire Line
	7600 3700 7850 3700
Wire Wire Line
	7850 4550 7850 4650
Wire Wire Line
	7450 4350 8000 4350
Wire Wire Line
	4900 7850 5550 7850
Wire Wire Line
	3750 7200 3800 7200
Wire Wire Line
	3750 7200 3750 7250
Wire Wire Line
	3500 7200 3750 7200
Wire Wire Line
	3100 7200 3150 7200
Wire Wire Line
	3100 7200 3100 7250
Wire Wire Line
	2800 7200 3100 7200
Wire Wire Line
	2800 7200 2800 7250
Wire Wire Line
	3750 6900 4600 6900
Wire Wire Line
	2500 4750 2500 4800
Wire Wire Line
	5550 7850 5800 7850
Wire Wire Line
	4100 4950 4150 4950
Wire Wire Line
	4100 5300 4050 5300
Wire Wire Line
	7600 4450 7600 4000
Wire Wire Line
	9250 4850 9550 4850
Wire Wire Line
	5800 7200 5800 7300
Wire Wire Line
	5800 7850 5900 7850
Wire Wire Line
	2350 1650 2900 1650
Wire Wire Line
	2500 1750 2500 1800
Wire Wire Line
	2500 2500 2750 2500
Wire Wire Line
	2350 2500 2500 2500
Wire Wire Line
	2500 3950 2750 3950
Wire Wire Line
	2350 3950 2500 3950
Wire Wire Line
	8700 900  8900 900 
Wire Wire Line
	8400 900  8700 900 
Wire Wire Line
	8400 1200 8700 1200
Wire Wire Line
	8900 900  9000 900 
Wire Wire Line
	8900 1650 8900 2300
Wire Wire Line
	8900 2300 8900 3050
Wire Wire Line
	8900 3050 8900 3700
Wire Wire Line
	8900 3700 8900 4450
Wire Wire Line
	5700 5950 6000 5950
Wire Wire Line
	4100 5950 4600 5950
Wire Wire Line
	4100 6150 4600 6150
Wire Wire Line
	4750 1850 4750 2000
Wire Wire Line
	4750 2700 4750 2850
Wire Wire Line
	4750 3350 4750 3500
Wire Wire Line
	4750 4200 4750 4350
Wire Wire Line
	4750 4850 4750 5000
Wire Wire Line
	4900 7200 5000 7200
$EndSCHEMATC
