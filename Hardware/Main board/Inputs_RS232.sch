EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 2 3
Title "BPEM488CW"
Date "2021-08-13"
Rev "1"
Comp "R. Hiebert Electric"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	9150 4550 9150 4750
Wire Wire Line
	9150 4750 8900 4750
Wire Wire Line
	9150 4250 9150 3950
Wire Wire Line
	9150 3950 8100 3950
Wire Wire Line
	8900 5050 9150 5050
Wire Wire Line
	9150 5350 9150 6350
Wire Wire Line
	8100 6350 9150 6350
$Comp
L power:GND #PWR?
U 1 1 5F0D766F
P 8100 6350
AR Path="/5EF09792/5F0D766F" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D766F" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D766F" Ref="#PWR0240"  Part="1" 
F 0 "#PWR0240" H 8100 6100 50  0001 C CNN
F 1 "GND" H 8105 6177 50  0000 C CNN
F 2 "" H 8100 6350 50  0001 C CNN
F 3 "" H 8100 6350 50  0001 C CNN
	1    8100 6350
	-1   0    0    -1  
$EndComp
$Comp
L power:VDD #PWR?
U 1 1 5F0D7675
P 9150 3950
AR Path="/5EF09792/5F0D7675" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7675" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D7675" Ref="#PWR0241"  Part="1" 
F 0 "#PWR0241" H 9150 3800 50  0001 C CNN
F 1 "VDD" H 9165 4123 50  0000 C CNN
F 2 "" H 9150 3950 50  0001 C CNN
F 3 "" H 9150 3950 50  0001 C CNN
	1    9150 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 6350 9150 6350
Connection ~ 9150 6350
NoConn ~ 9550 5300
NoConn ~ 9550 5200
NoConn ~ 9550 5000
NoConn ~ 9550 4800
Wire Wire Line
	8900 5250 9000 5250
Wire Wire Line
	9000 5250 9000 4900
Wire Wire Line
	9000 4900 9550 4900
Wire Wire Line
	8900 5650 9350 5650
Wire Wire Line
	9350 5650 9350 5100
Wire Wire Line
	9350 5100 9550 5100
Connection ~ 9150 3950
Wire Wire Line
	9150 3950 9450 3950
Wire Wire Line
	9450 3950 9450 4700
NoConn ~ 8900 5850
NoConn ~ 8900 5450
NoConn ~ 7300 5450
NoConn ~ 7300 5850
Connection ~ 8100 6350
$Comp
L Interface_UART:MAX232 U?
U 1 1 5F0D7694
P 8100 5150
AR Path="/5EF09792/5F0D7694" Ref="U?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7694" Ref="U?"  Part="1" 
AR Path="/5F09E690/5F0D7694" Ref="U205"  Part="1" 
F 0 "U205" H 8100 6531 50  0000 C CNN
F 1 "MAX232EEPE+" H 8100 6440 50  0000 C CNN
F 2 "digikey-footprints:DIP-16_W7.62mm" H 8150 4100 50  0001 L CNN
F 3 "https://datasheets.maximintegrated.com/en/ds/MAX202E-MAX241E.pdf" H 8100 5250 50  0001 C CNN
F 4 "MAX232EEPE+" H 8100 5150 50  0001 C CNN "Mfg"
F 5 "MAX232EEPE+-ND" H 8100 5150 50  0001 C CNN "Digikey"
	1    8100 5150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D76AE
P 1400 4850
AR Path="/5EF09792/5F0D76AE" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D76AE" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D76AE" Ref="#PWR0213"  Part="1" 
F 0 "#PWR0213" H 1400 4600 50  0001 C CNN
F 1 "GND" H 1405 4677 50  0000 C CNN
F 2 "" H 1400 4850 50  0001 C CNN
F 3 "" H 1400 4850 50  0001 C CNN
	1    1400 4850
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D76B4
P 1700 4850
AR Path="/5EF09792/5F0D76B4" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D76B4" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D76B4" Ref="#PWR0221"  Part="1" 
F 0 "#PWR0221" H 1700 4600 50  0001 C CNN
F 1 "GND" H 1705 4677 50  0000 C CNN
F 2 "" H 1700 4850 50  0001 C CNN
F 3 "" H 1700 4850 50  0001 C CNN
	1    1700 4850
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1700 4550 1950 4550
$Comp
L power:GND #PWR?
U 1 1 5F0D76D0
P 1400 4200
AR Path="/5EF09792/5F0D76D0" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D76D0" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D76D0" Ref="#PWR0212"  Part="1" 
F 0 "#PWR0212" H 1400 3950 50  0001 C CNN
F 1 "GND" H 1405 4027 50  0000 C CNN
F 2 "" H 1400 4200 50  0001 C CNN
F 3 "" H 1400 4200 50  0001 C CNN
	1    1400 4200
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D76D6
P 1700 4200
AR Path="/5EF09792/5F0D76D6" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D76D6" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D76D6" Ref="#PWR0220"  Part="1" 
F 0 "#PWR0220" H 1700 3950 50  0001 C CNN
F 1 "GND" H 1705 4027 50  0000 C CNN
F 2 "" H 1700 4200 50  0001 C CNN
F 3 "" H 1700 4200 50  0001 C CNN
	1    1700 4200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1700 3900 2150 3900
Connection ~ 1700 3900
Wire Wire Line
	1700 3700 1700 3900
$Comp
L power:VDD #PWR?
U 1 1 5F0D76E7
P 1400 3700
AR Path="/5EF09792/5F0D76E7" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D76E7" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D76E7" Ref="#PWR0211"  Part="1" 
F 0 "#PWR0211" H 1400 3550 50  0001 C CNN
F 1 "VDD" V 1415 3827 50  0000 L CNN
F 2 "" H 1400 3700 50  0001 C CNN
F 3 "" H 1400 3700 50  0001 C CNN
	1    1400 3700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1050 3900 1400 3900
Wire Wire Line
	1100 4550 1400 4550
Wire Wire Line
	1100 7400 1400 7400
Wire Wire Line
	1100 5850 1400 5850
Wire Wire Line
	1100 5200 1400 5200
Wire Wire Line
	1700 7400 1950 7400
$Comp
L power:GND #PWR?
U 1 1 5F0D76FD
P 1700 7700
AR Path="/5EF09792/5F0D76FD" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D76FD" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D76FD" Ref="#PWR0224"  Part="1" 
F 0 "#PWR0224" H 1700 7450 50  0001 C CNN
F 1 "GND" H 1705 7527 50  0000 C CNN
F 2 "" H 1700 7700 50  0001 C CNN
F 3 "" H 1700 7700 50  0001 C CNN
	1    1700 7700
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D7703
P 1400 7700
AR Path="/5EF09792/5F0D7703" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7703" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D7703" Ref="#PWR0216"  Part="1" 
F 0 "#PWR0216" H 1400 7450 50  0001 C CNN
F 1 "GND" H 1405 7527 50  0000 C CNN
F 2 "" H 1400 7700 50  0001 C CNN
F 3 "" H 1400 7700 50  0001 C CNN
	1    1400 7700
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D7725
P 1100 6800
AR Path="/5EF09792/5F0D7725" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7725" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D7725" Ref="#PWR0201"  Part="1" 
F 0 "#PWR0201" H 1100 6550 50  0001 C CNN
F 1 "GND" V 1100 6600 50  0000 C CNN
F 2 "" H 1100 6800 50  0001 C CNN
F 3 "" H 1100 6800 50  0001 C CNN
	1    1100 6800
	0    1    -1   0   
$EndComp
$Comp
L Device:C C?
U 1 1 5F0D7731
P 1850 6600
AR Path="/5EF09792/5F0D7731" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7731" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F0D7731" Ref="C217"  Part="1" 
F 0 "C217" H 1750 6500 40  0000 C CNN
F 1 "47pF" H 1950 6700 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1888 6450 50  0001 C CNN
F 3 "https://sh.kemet.com/Lists/ProductCatalog/Attachments/597/KEM_C1049_GOLDMAX_C0G.pdf" H 1850 6600 50  0001 C CNN
F 4 "C315C470J5G5TA" H 1850 6600 50  0001 C CNN "Mfg"
F 5 "399-9737-ND" H 1850 6600 50  0001 C CNN "Digikey"
	1    1850 6600
	1    0    0    1   
$EndComp
$Comp
L Device:R R?
U 1 1 5F0D7737
P 1550 6600
AR Path="/5EF09792/5F0D7737" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7737" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F0D7737" Ref="R201"  Part="1" 
F 0 "R201" V 1475 6625 40  0000 C CNN
F 1 "51.1K" V 1550 6600 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 6600 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 6600 50  0001 C CNN
F 4 "MFR-25FBF52-51K1" V 1550 6600 50  0001 C CNN "Mfg"
F 5 "51.0KXBK-ND" V 1550 6600 50  0001 C CNN "Digikey"
	1    1550 6600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 5200 1950 5200
$Comp
L power:GND #PWR?
U 1 1 5F0D7741
P 1700 5500
AR Path="/5EF09792/5F0D7741" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7741" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D7741" Ref="#PWR0222"  Part="1" 
F 0 "#PWR0222" H 1700 5250 50  0001 C CNN
F 1 "GND" H 1705 5327 50  0000 C CNN
F 2 "" H 1700 5500 50  0001 C CNN
F 3 "" H 1700 5500 50  0001 C CNN
	1    1700 5500
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D7747
P 1400 5500
AR Path="/5EF09792/5F0D7747" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7747" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D7747" Ref="#PWR0214"  Part="1" 
F 0 "#PWR0214" H 1400 5250 50  0001 C CNN
F 1 "GND" H 1405 5327 50  0000 C CNN
F 2 "" H 1400 5500 50  0001 C CNN
F 3 "" H 1400 5500 50  0001 C CNN
	1    1400 5500
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1700 5850 1950 5850
$Comp
L power:GND #PWR?
U 1 1 5F0D7763
P 1700 6150
AR Path="/5EF09792/5F0D7763" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7763" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D7763" Ref="#PWR0223"  Part="1" 
F 0 "#PWR0223" H 1700 5900 50  0001 C CNN
F 1 "GND" H 1705 5977 50  0000 C CNN
F 2 "" H 1700 6150 50  0001 C CNN
F 3 "" H 1700 6150 50  0001 C CNN
	1    1700 6150
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D7769
P 1400 6150
AR Path="/5EF09792/5F0D7769" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7769" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D7769" Ref="#PWR0215"  Part="1" 
F 0 "#PWR0215" H 1400 5900 50  0001 C CNN
F 1 "GND" H 1405 5977 50  0000 C CNN
F 2 "" H 1400 6150 50  0001 C CNN
F 3 "" H 1400 6150 50  0001 C CNN
	1    1400 6150
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2700 3100 3000 3100
Wire Wire Line
	2700 2450 3000 2450
Wire Wire Line
	2700 1800 3000 1800
Wire Wire Line
	2700 1150 3000 1150
Wire Wire Line
	3300 3100 3650 3100
$Comp
L power:GND #PWR?
U 1 1 5F0D778D
P 3300 3400
AR Path="/5EF09792/5F0D778D" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D778D" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D778D" Ref="#PWR0233"  Part="1" 
F 0 "#PWR0233" H 3300 3150 50  0001 C CNN
F 1 "GND" H 3305 3227 50  0000 C CNN
F 2 "" H 3300 3400 50  0001 C CNN
F 3 "" H 3300 3400 50  0001 C CNN
	1    3300 3400
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D7793
P 3000 3400
AR Path="/5EF09792/5F0D7793" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7793" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D7793" Ref="#PWR0229"  Part="1" 
F 0 "#PWR0229" H 3000 3150 50  0001 C CNN
F 1 "GND" H 3005 3227 50  0000 C CNN
F 2 "" H 3000 3400 50  0001 C CNN
F 3 "" H 3000 3400 50  0001 C CNN
	1    3000 3400
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3300 1150 3550 1150
$Comp
L power:GND #PWR?
U 1 1 5F0D77AF
P 3300 1450
AR Path="/5EF09792/5F0D77AF" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D77AF" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D77AF" Ref="#PWR0230"  Part="1" 
F 0 "#PWR0230" H 3300 1200 50  0001 C CNN
F 1 "GND" H 3305 1277 50  0000 C CNN
F 2 "" H 3300 1450 50  0001 C CNN
F 3 "" H 3300 1450 50  0001 C CNN
	1    3300 1450
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D77B5
P 3000 1450
AR Path="/5EF09792/5F0D77B5" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D77B5" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D77B5" Ref="#PWR0226"  Part="1" 
F 0 "#PWR0226" H 3000 1200 50  0001 C CNN
F 1 "GND" H 3005 1277 50  0000 C CNN
F 2 "" H 3000 1450 50  0001 C CNN
F 3 "" H 3000 1450 50  0001 C CNN
	1    3000 1450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3300 1800 3550 1800
$Comp
L power:GND #PWR?
U 1 1 5F0D77D1
P 3300 2100
AR Path="/5EF09792/5F0D77D1" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D77D1" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D77D1" Ref="#PWR0231"  Part="1" 
F 0 "#PWR0231" H 3300 1850 50  0001 C CNN
F 1 "GND" H 3305 1927 50  0000 C CNN
F 2 "" H 3300 2100 50  0001 C CNN
F 3 "" H 3300 2100 50  0001 C CNN
	1    3300 2100
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D77D7
P 3000 2100
AR Path="/5EF09792/5F0D77D7" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D77D7" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D77D7" Ref="#PWR0227"  Part="1" 
F 0 "#PWR0227" H 3000 1850 50  0001 C CNN
F 1 "GND" H 3005 1927 50  0000 C CNN
F 2 "" H 3000 2100 50  0001 C CNN
F 3 "" H 3000 2100 50  0001 C CNN
	1    3000 2100
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3300 2450 3550 2450
$Comp
L power:GND #PWR?
U 1 1 5F0D77F3
P 3300 2750
AR Path="/5EF09792/5F0D77F3" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D77F3" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D77F3" Ref="#PWR0232"  Part="1" 
F 0 "#PWR0232" H 3300 2500 50  0001 C CNN
F 1 "GND" H 3305 2577 50  0000 C CNN
F 2 "" H 3300 2750 50  0001 C CNN
F 3 "" H 3300 2750 50  0001 C CNN
	1    3300 2750
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D77F9
P 3000 2750
AR Path="/5EF09792/5F0D77F9" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D77F9" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D77F9" Ref="#PWR0228"  Part="1" 
F 0 "#PWR0228" H 3000 2500 50  0001 C CNN
F 1 "GND" H 3005 2577 50  0000 C CNN
F 2 "" H 3000 2750 50  0001 C CNN
F 3 "" H 3000 2750 50  0001 C CNN
	1    3000 2750
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D7823
P 1400 3350
AR Path="/5EF09792/5F0D7823" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7823" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D7823" Ref="#PWR0210"  Part="1" 
F 0 "#PWR0210" H 1400 3100 50  0001 C CNN
F 1 "GND" H 1405 3177 50  0000 C CNN
F 2 "" H 1400 3350 50  0001 C CNN
F 3 "" H 1400 3350 50  0001 C CNN
	1    1400 3350
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F0D7829
P 1700 3350
AR Path="/5EF09792/5F0D7829" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7829" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D7829" Ref="#PWR0219"  Part="1" 
F 0 "#PWR0219" H 1700 3100 50  0001 C CNN
F 1 "GND" H 1705 3177 50  0000 C CNN
F 2 "" H 1700 3350 50  0001 C CNN
F 3 "" H 1700 3350 50  0001 C CNN
	1    1700 3350
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1700 3050 1950 3050
Connection ~ 1700 3050
Wire Wire Line
	1700 2850 1700 3050
$Comp
L power:VDD #PWR?
U 1 1 5F0D783A
P 1400 2850
AR Path="/5EF09792/5F0D783A" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D783A" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D783A" Ref="#PWR0209"  Part="1" 
F 0 "#PWR0209" H 1400 2700 50  0001 C CNN
F 1 "VDD" V 1415 2977 50  0000 L CNN
F 2 "" H 1400 2850 50  0001 C CNN
F 3 "" H 1400 2850 50  0001 C CNN
	1    1400 2850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1050 3050 1400 3050
$Comp
L power:GND #PWR?
U 1 1 5F0D785A
P 1700 2500
AR Path="/5EF09792/5F0D785A" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D785A" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D785A" Ref="#PWR0218"  Part="1" 
F 0 "#PWR0218" H 1700 2250 50  0001 C CNN
F 1 "GND" H 1705 2327 50  0000 C CNN
F 2 "" H 1700 2500 50  0001 C CNN
F 3 "" H 1700 2500 50  0001 C CNN
	1    1700 2500
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1700 2200 1950 2200
Connection ~ 1700 2200
$Comp
L Device:R R?
U 1 1 5F0D7864
P 1550 2000
AR Path="/5EF09792/5F0D7864" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D7864" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F0D7864" Ref="R204"  Part="1" 
F 0 "R204" V 1475 2025 40  0000 C CNN
F 1 "6.98K" V 1550 2000 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 2000 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 2000 50  0001 C CNN
F 4 "MFR-25FBF52-6K98" V 1550 2000 50  0001 C CNN "Mfg"
F 5 "6.98KXBK-ND" V 1550 2000 50  0001 C CNN "Digikey"
	1    1550 2000
	0    1    1    0   
$EndComp
Wire Wire Line
	1700 2000 1700 2200
$Comp
L power:VDD #PWR?
U 1 1 5F0D786B
P 1400 2000
AR Path="/5EF09792/5F0D786B" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0D786B" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0D786B" Ref="#PWR0206"  Part="1" 
F 0 "#PWR0206" H 1400 1850 50  0001 C CNN
F 1 "VDD" V 1415 2127 50  0000 L CNN
F 2 "" H 1400 2000 50  0001 C CNN
F 3 "" H 1400 2000 50  0001 C CNN
	1    1400 2000
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1050 2200 1400 2200
$Comp
L Device:R R?
U 1 1 5F0E2D93
P 6050 1150
AR Path="/5EF09792/5F0E2D93" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0E2D93" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F0E2D93" Ref="R225"  Part="1" 
F 0 "R225" V 5975 1175 40  0000 C CNN
F 1 "510R" V 6050 1150 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 5980 1150 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 6050 1150 50  0001 C CNN
F 4 "MFR-25FBF52-200R" V 6050 1150 50  0001 C CNN "Mfg"
F 5 "200XBK-ND" V 6050 1150 50  0001 C CNN "Digikey"
	1    6050 1150
	0    1    1    0   
$EndComp
$Comp
L dk_Transistors-Bipolar-BJT-Single:ZTX450 Q201
U 1 1 5F0E4114
P 4800 1350
F 0 "Q201" H 5050 1550 60  0000 L CNN
F 1 "ZTX450" H 5000 1400 60  0000 L CNN
F 2 "digikey-footprints:TO-92-3_Formed_Leads" H 5000 1550 60  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ZTX450.pdf" H 5000 1650 60  0001 L CNN
F 4 "ZTX450-ND" H 5000 1750 60  0001 L CNN "Digi-Key_PN"
F 5 "ZTX450" H 4650 1100 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 5000 1950 60  0001 L CNN "Category"
F 7 "Transistors - Bipolar (BJT) - Single" H 5000 2050 60  0001 L CNN "Family"
F 8 "https://www.diodes.com/assets/Datasheets/ZTX450.pdf" H 5000 2150 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/diodes-incorporated/ZTX450/ZTX450-ND/92530" H 5000 2250 60  0001 L CNN "DK_Detail_Page"
F 10 "TRANS NPN 45V 1A E-LINE" H 5000 2350 60  0001 L CNN "Description"
F 11 "Diodes Incorporated" H 5000 2450 60  0001 L CNN "Manufacturer"
F 12 "Active" H 5000 2550 60  0001 L CNN "Status"
	1    4800 1350
	-1   0    0    -1  
$EndComp
NoConn ~ 5200 1450
Wire Wire Line
	5400 1600 5500 1600
Wire Wire Line
	5900 1600 5950 1600
Wire Wire Line
	5100 1600 5100 1350
Wire Wire Line
	5100 1350 5200 1350
Wire Wire Line
	5000 1350 5100 1350
Connection ~ 5100 1350
Wire Wire Line
	5200 1150 5100 1150
$Comp
L power:VDD #PWR?
U 1 1 5F0F4ED9
P 5100 1100
AR Path="/5EF09792/5F0F4ED9" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0F4ED9" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0F4ED9" Ref="#PWR0234"  Part="1" 
F 0 "#PWR0234" H 5100 950 50  0001 C CNN
F 1 "VDD" V 5000 1150 50  0000 L CNN
F 2 "" H 5100 1100 50  0001 C CNN
F 3 "" H 5100 1100 50  0001 C CNN
	1    5100 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 1100 5100 1150
Connection ~ 5100 1150
Wire Wire Line
	5100 1150 4700 1150
$Comp
L power:GND #PWR?
U 1 1 5F0FB419
P 5950 1650
AR Path="/5EF09792/5F0FB419" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0FB419" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F0FB419" Ref="#PWR0237"  Part="1" 
F 0 "#PWR0237" H 5950 1400 50  0001 C CNN
F 1 "GND" H 5955 1477 50  0000 C CNN
F 2 "" H 5950 1650 50  0001 C CNN
F 3 "" H 5950 1650 50  0001 C CNN
	1    5950 1650
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4700 1550 4400 1550
Wire Wire Line
	7300 5250 7000 5250
Wire Wire Line
	7300 5650 7000 5650
$Comp
L power:+8V #PWR0243
U 1 1 5F15438E
P 9200 1300
F 0 "#PWR0243" H 9200 1150 50  0001 C CNN
F 1 "+8V" V 9215 1428 50  0000 L CNN
F 2 "" H 9200 1300 50  0001 C CNN
F 3 "" H 9200 1300 50  0001 C CNN
	1    9200 1300
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F156C4A
P 9200 1400
AR Path="/5EF09792/5F156C4A" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F156C4A" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F156C4A" Ref="#PWR0244"  Part="1" 
F 0 "#PWR0244" H 9200 1150 50  0001 C CNN
F 1 "GND" V 9200 1200 50  0000 C CNN
F 2 "" H 9200 1400 50  0001 C CNN
F 3 "" H 9200 1400 50  0001 C CNN
	1    9200 1400
	0    1    -1   0   
$EndComp
$Comp
L power:VDD #PWR?
U 1 1 5F1573BF
P 9200 2300
AR Path="/5EF09792/5F1573BF" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F1573BF" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F1573BF" Ref="#PWR0245"  Part="1" 
F 0 "#PWR0245" H 9200 2150 50  0001 C CNN
F 1 "VDD" V 9215 2427 50  0000 L CNN
F 2 "" H 9200 2300 50  0001 C CNN
F 3 "" H 9200 2300 50  0001 C CNN
	1    9200 2300
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F15E061
P 1400 2500
AR Path="/5EF09792/5F15E061" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F15E061" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F15E061" Ref="#PWR0208"  Part="1" 
F 0 "#PWR0208" H 1400 2250 50  0001 C CNN
F 1 "GND" H 1405 2327 50  0000 C CNN
F 2 "" H 1400 2500 50  0001 C CNN
F 3 "" H 1400 2500 50  0001 C CNN
	1    1400 2500
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F15E093
P 9200 2200
AR Path="/5EF09792/5F15E093" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F15E093" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F15E093" Ref="#PWR0246"  Part="1" 
F 0 "#PWR0246" H 9200 1950 50  0001 C CNN
F 1 "GND" V 9200 2000 50  0000 C CNN
F 2 "" H 9200 2200 50  0001 C CNN
F 3 "" H 9200 2200 50  0001 C CNN
	1    9200 2200
	0    1    -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F162F2A
P 9200 2100
AR Path="/5EF09792/5F162F2A" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F162F2A" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F162F2A" Ref="#PWR0242"  Part="1" 
F 0 "#PWR0242" H 9200 1850 50  0001 C CNN
F 1 "GND" V 9200 1900 50  0000 C CNN
F 2 "" H 9200 2100 50  0001 C CNN
F 3 "" H 9200 2100 50  0001 C CNN
	1    9200 2100
	0    1    -1   0   
$EndComp
$Comp
L Device:R R?
U 1 1 5F219622
P 1550 1350
AR Path="/5EF09792/5F219622" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F219622" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F219622" Ref="R203"  Part="1" 
F 0 "R203" V 1475 1375 40  0000 C CNN
F 1 "1K" V 1550 1350 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 1350 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 1350 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 1550 1350 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 1550 1350 50  0001 C CNN "Digikey"
	1    1550 1350
	0    1    1    0   
$EndComp
$Comp
L Device:C C?
U 1 1 5F219628
P 1400 1500
AR Path="/5EF09792/5F219628" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F219628" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F219628" Ref="C201"  Part="1" 
F 0 "C201" H 1300 1400 40  0000 C CNN
F 1 "1.0uF" H 1300 1600 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1438 1350 50  0001 C CNN
F 3 "https://api.kemet.com/component-edge/download/specsheet/C315C105K3R5TA.pdf" H 1400 1500 50  0001 C CNN
F 4 "C315C105K3R5TA" H 1400 1500 50  0001 C CNN "Mfg"
F 5 "399-9714-ND" H 1400 1500 50  0001 C CNN "Digikey"
	1    1400 1500
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F21962E
P 1700 1500
AR Path="/5EF09792/5F21962E" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F21962E" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F21962E" Ref="C209"  Part="1" 
F 0 "C209" H 1800 1400 40  0000 C CNN
F 1 "0.001uF" H 1850 1600 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1738 1350 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1050_GOLDMAX_X7R.pdf" H 1700 1500 50  0001 C CNN
F 4 "C315C102K1R5TA" H 1700 1500 50  0001 C CNN "Mfg"
F 5 "399-4144-ND" H 1700 1500 50  0001 C CNN "Digikey"
	1    1700 1500
	1    0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F21963A
P 1700 1650
AR Path="/5EF09792/5F21963A" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F21963A" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F21963A" Ref="#PWR0217"  Part="1" 
F 0 "#PWR0217" H 1700 1400 50  0001 C CNN
F 1 "GND" H 1705 1477 50  0000 C CNN
F 2 "" H 1700 1650 50  0001 C CNN
F 3 "" H 1700 1650 50  0001 C CNN
	1    1700 1650
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5F219642
P 1550 1150
AR Path="/5EF09792/5F219642" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F219642" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F219642" Ref="R202"  Part="1" 
F 0 "R202" V 1475 1175 40  0000 C CNN
F 1 "49.9K" V 1550 1150 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 1150 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 1150 50  0001 C CNN
F 4 "MFR-25FBF52-49K9" V 1550 1150 50  0001 C CNN "Mfg"
F 5 "49.9KXBK-ND" V 1550 1150 50  0001 C CNN "Digikey"
	1    1550 1150
	0    1    1    0   
$EndComp
Wire Wire Line
	1050 1350 1400 1350
Connection ~ 1400 1350
$Comp
L power:GND #PWR?
U 1 1 5F219652
P 1400 1650
AR Path="/5EF09792/5F219652" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F219652" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F219652" Ref="#PWR0205"  Part="1" 
F 0 "#PWR0205" H 1400 1400 50  0001 C CNN
F 1 "GND" H 1405 1477 50  0000 C CNN
F 2 "" H 1400 1650 50  0001 C CNN
F 3 "" H 1400 1650 50  0001 C CNN
	1    1400 1650
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5F21F51C
P 1950 1150
AR Path="/5EF09792/5F21F51C" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F21F51C" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F21F51C" Ref="R214"  Part="1" 
F 0 "R214" V 1875 1175 40  0000 C CNN
F 1 "10K" V 1950 1150 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1880 1150 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1950 1150 50  0001 C CNN
F 4 "MFR-25FBF52-10K" V 1950 1150 50  0001 C CNN "Mfg"
F 5 "10.0KXBK-ND" V 1950 1150 50  0001 C CNN "Digikey"
	1    1950 1150
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F22107F
P 2100 1250
AR Path="/5EF09792/5F22107F" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F22107F" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F22107F" Ref="#PWR0225"  Part="1" 
F 0 "#PWR0225" H 2100 1000 50  0001 C CNN
F 1 "GND" H 2105 1077 50  0000 C CNN
F 2 "" H 2100 1250 50  0001 C CNN
F 3 "" H 2100 1250 50  0001 C CNN
	1    2100 1250
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1300 1150 1400 1150
Wire Wire Line
	1700 1150 1750 1150
Wire Wire Line
	2100 1150 2100 1250
Wire Wire Line
	1750 1150 1750 1350
Wire Wire Line
	1750 1350 1700 1350
Connection ~ 1750 1150
Wire Wire Line
	1750 1150 1800 1150
Connection ~ 1700 1350
$Comp
L Sensor_Pressure:MPXA6115A U201
U 1 1 5F23B57F
P 2650 6800
F 0 "U201" H 2220 6754 50  0000 R CNN
F 1 "MPXA6115AC7U" H 2220 6845 50  0001 R CNN
F 2 "BPEM488CW:MPXA6115AC7U" H 2150 6450 50  0001 C CNN
F 3 "https://www.nxp.com/docs/en/data-sheet/MPXA6115A.pdf" H 2650 7400 50  0001 C CNN
F 4 "MPXA6115AC7U" H 2250 7100 50  0000 C CNN "Mfg"
F 5 "568-13767-ND" H 2650 6800 50  0001 C CNN "Digikey"
	1    2650 6800
	-1   0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F249E90
P 1850 7000
AR Path="/5EF09792/5F249E90" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F249E90" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F249E90" Ref="C218"  Part="1" 
F 0 "C218" H 1750 6900 40  0000 C CNN
F 1 "0.1uF" H 2000 7100 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 1888 6850 50  0001 C CNN
F 3 "https://sh.kemet.com/Lists/ProductCatalog/Attachments/598/KEM_C1050_GOLDMAX_X7R.pdf" H 1850 7000 50  0001 C CNN
F 4 "C320C104K5R5TA" H 1850 7000 50  0001 C CNN "Mfg"
F 5 "399-4264-ND" H 1850 7000 50  0001 C CNN "Digikey"
	1    1850 7000
	1    0    0    1   
$EndComp
$Comp
L power:VDD #PWR?
U 1 1 5F24C0FC
P 1100 7150
AR Path="/5EF09792/5F24C0FC" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F24C0FC" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F24C0FC" Ref="#PWR0202"  Part="1" 
F 0 "#PWR0202" H 1100 7000 50  0001 C CNN
F 1 "VDD" V 1100 7300 50  0000 L CNN
F 2 "" H 1100 7150 50  0001 C CNN
F 3 "" H 1100 7150 50  0001 C CNN
	1    1100 7150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2050 6800 2050 6500
Wire Wire Line
	2050 6500 2650 6500
Wire Wire Line
	1850 6450 2250 6450
Wire Wire Line
	2250 6450 2250 6800
Connection ~ 1850 6450
Wire Wire Line
	1850 7150 2650 7150
Wire Wire Line
	2650 7150 2650 7100
Connection ~ 1850 7150
Wire Wire Line
	1850 6750 1850 6800
Connection ~ 1850 6800
Wire Wire Line
	1850 6800 2050 6800
Wire Wire Line
	1850 6850 1850 6800
Text GLabel 9200 1600 0    50   Input ~ 0
PA2
Text GLabel 9200 1500 0    50   Input ~ 0
PA1
Text GLabel 9200 1700 0    50   Input ~ 0
PA3
Text GLabel 9200 1800 0    50   Input ~ 0
PA4
Text Label 6550 1350 2    50   ~ 0
CMP
Text Label 9200 1200 0    50   ~ 0
CMP
Text Label 9200 1100 0    50   ~ 0
CKP
Text Label 9200 1000 0    50   ~ 0
VSPD
Text Label 9200 2500 0    50   ~ 0
CLT
Text Label 9200 2700 0    50   ~ 0
MAT
Text Label 9200 2900 0    50   ~ 0
PAD03in
Text Label 9200 3100 0    50   ~ 0
MAP
Text Label 9200 3300 0    50   ~ 0
TPS
Text Label 9200 3400 0    50   ~ 0
EGO1
Text Label 9200 2400 0    50   ~ 0
EOP
Text Label 9200 2600 0    50   ~ 0
EFP
Text Label 9200 2800 0    50   ~ 0
Itrm
Text Label 9200 3000 0    50   ~ 0
Ftrm
Text Label 9200 3200 0    50   ~ 0
EGO2
Text GLabel 7000 5250 0    50   Input ~ 0
PS1
Text GLabel 7000 5650 0    50   Output ~ 0
PS0
Text Label 3550 1150 2    50   ~ 0
EFP
Text Label 3550 1800 2    50   ~ 0
Itrm
Text Label 3550 2450 2    50   ~ 0
Ftrm
Text Label 3650 3100 2    50   ~ 0
EGO2
Text Label 1950 2200 2    50   ~ 0
CLT
Text Label 1950 3050 2    50   ~ 0
MAT
Text Label 2150 3900 2    50   ~ 0
PAD03in
Text Label 1950 4550 2    50   ~ 0
MAP
Text Label 1950 5200 2    50   ~ 0
TPS
Text Label 1950 5850 2    50   ~ 0
EGO1
Text Label 1950 7400 2    50   ~ 0
EOP
Text GLabel 2700 1800 0    50   Input ~ 0
PAD10
Text GLabel 2700 2450 0    50   Input ~ 0
PAD11
Text GLabel 2700 3100 0    50   Input ~ 0
PAD12
Text GLabel 2700 1150 0    50   Input ~ 0
PAD09
Text GLabel 1050 1350 0    50   Input ~ 0
PAD00
Text GLabel 1050 2200 0    50   Input ~ 0
PAD01
Text GLabel 1050 3050 0    50   Input ~ 0
PAD02
Text GLabel 1050 3900 0    50   Input ~ 0
PAD03
Text GLabel 1100 4550 0    50   Input ~ 0
PAD04
Text GLabel 1100 6450 0    50   Input ~ 0
PAD07
Text GLabel 1100 5200 0    50   Input ~ 0
PAD05
Text GLabel 1100 5850 0    50   Input ~ 0
PAD06
Text GLabel 1100 7400 0    50   Input ~ 0
PAD08
$Comp
L dk_Optoisolators-Transistor-Photovoltaic-Output:4N25 U202
U 1 1 5EFAF771
P 5500 1250
F 0 "U202" H 5500 1597 60  0000 C CNN
F 1 "4N25" H 5500 1491 60  0000 C CNN
F 2 "digikey-footprints:DIP-6_W7.62mm" H 5700 1450 60  0001 L CNN
F 3 "http://optoelectronics.liteon.com/upload/download/DS-70-99-0010/4N2X%20series%20Datasheet%201115.pdf" H 5700 1550 60  0001 L CNN
F 4 "160-1300-5-ND" H 5700 1650 60  0001 L CNN "Digi-Key_PN"
F 5 "4N25" H 5700 1750 60  0001 L CNN "MPN"
F 6 "Isolators" H 5700 1850 60  0001 L CNN "Category"
F 7 "Optoisolators - Transistor, Photovoltaic Output" H 5700 1950 60  0001 L CNN "Family"
F 8 "http://optoelectronics.liteon.com/upload/download/DS-70-99-0010/4N2X%20series%20Datasheet%201115.pdf" H 5700 2050 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/lite-on-inc/4N25/160-1300-5-ND/385762" H 5700 2150 60  0001 L CNN "DK_Detail_Page"
F 10 "OPTOISO 2.5KV TRANS W/BASE 6DIP" H 5700 2250 60  0001 L CNN "Description"
F 11 "Lite-On Inc." H 5700 2350 60  0001 L CNN "Manufacturer"
F 12 "Active" H 5700 2450 60  0001 L CNN "Status"
	1    5500 1250
	-1   0    0    -1  
$EndComp
NoConn ~ 5800 1450
$Comp
L power:+BATT #PWR0203
U 1 1 5F2D8A8B
P 1300 1150
F 0 "#PWR0203" H 1300 1000 50  0001 C CNN
F 1 "+BATT" V 1315 1277 50  0000 L CNN
F 2 "" H 1300 1150 50  0001 C CNN
F 3 "" H 1300 1150 50  0001 C CNN
	1    1300 1150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9600 1600 9200 1600
Wire Wire Line
	9600 1700 9200 1700
Wire Wire Line
	9600 1800 9200 1800
Wire Wire Line
	9600 2100 9200 2100
Wire Wire Line
	9600 2200 9200 2200
Wire Wire Line
	9600 2300 9200 2300
Wire Wire Line
	9600 2400 9200 2400
Wire Wire Line
	9600 2500 9200 2500
Wire Wire Line
	9600 2600 9200 2600
Wire Wire Line
	9600 2700 9200 2700
Wire Wire Line
	9600 2800 9200 2800
Wire Wire Line
	9600 2900 9200 2900
Wire Wire Line
	9600 3000 9200 3000
Wire Wire Line
	9600 3100 9200 3100
$Comp
L Connector:DB9_Female J201
U 1 1 5F36529B
P 9850 5100
F 0 "J201" H 9750 5700 50  0000 L CNN
F 1 "DB9_Female" V 10100 4950 50  0000 L CNN
F 2 "Connector_Dsub:DSUB-9_Female_Horizontal_P2.77x2.84mm_EdgePinOffset9.90mm_Housed_MountingHolesOffset11.32mm" H 9850 5100 50  0001 C CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=2301844&DocType=Customer+Drawing&DocLang=English" H 9850 5100 50  0001 C CNN
F 4 "2301844-1" H 9850 5100 50  0001 C CNN "Mfg"
F 5 "A132512-ND" H 9850 5100 50  0001 C CNN "Digikey"
	1    9850 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 6350 9550 5500
$Comp
L Connector:DB25_Female J202
U 1 1 5F144313
P 9900 2200
F 0 "J202" H 10000 3500 50  0000 L CNN
F 1 "DB25_Female" V 10200 1950 50  0000 L CNN
F 2 "Connector_Dsub:DSUB-25_Female_Horizontal_P2.77x2.84mm_EdgePinOffset7.70mm_Housed_MountingHolesOffset9.12mm" H 9900 2200 50  0001 C CNN
F 3 "http://www.assmann-wsw.com/fileadmin/datasheets/ASS_4888_CO.pdf" H 9900 2200 50  0001 C CNN
F 4 "A-DF 25 A/KG-T2S" H 9900 2200 50  0001 C CNN "Mfg"
F 5 "AE10935-ND" H 9900 2200 50  0001 C CNN "Digikey"
	1    9900 2200
	1    0    0    1   
$EndComp
Text Notes 8300 1650 0    50   ~ 0
Fuel Trim Enable
Text Notes 8150 1550 0    50   ~ 0
Ignition Trim Enable\n
Text Notes 8500 1750 0    50   ~ 0
Idle Raise\n
Text Notes 8500 1850 0    50   ~ 0
OFC Enable\n
Wire Wire Line
	1100 7150 1850 7150
Wire Wire Line
	1550 6450 1850 6450
Wire Wire Line
	1100 6450 1550 6450
Connection ~ 1550 6450
Wire Wire Line
	1550 6750 1550 6800
Connection ~ 1550 6800
Wire Wire Line
	1550 6800 1850 6800
Wire Wire Line
	1100 6800 1550 6800
Text GLabel 9200 1900 0    50   Input ~ 0
PA5
Text GLabel 9200 2000 0    50   Input ~ 0
PA6
Text Notes 8500 1950 0    50   ~ 0
OFC Disable\n
Text Notes 8500 2050 0    50   ~ 0
Idle Lower\n
$Comp
L Device:C C?
U 1 1 5EFCC4E3
P 1400 2350
AR Path="/5EF09792/5EFCC4E3" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5EFCC4E3" Ref="C?"  Part="1" 
AR Path="/5F09E690/5EFCC4E3" Ref="C202"  Part="1" 
F 0 "C202" H 1300 2250 40  0000 C CNN
F 1 "1.0uF" H 1300 2450 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1438 2200 50  0001 C CNN
F 3 "https://api.kemet.com/component-edge/download/specsheet/C315C105K3R5TA.pdf" H 1400 2350 50  0001 C CNN
F 4 "C315C105K3R5TA" H 1400 2350 50  0001 C CNN "Mfg"
F 5 "399-9714-ND" H 1400 2350 50  0001 C CNN "Digikey"
	1    1400 2350
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5EFD2E4D
P 1400 3200
AR Path="/5EF09792/5EFD2E4D" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5EFD2E4D" Ref="C?"  Part="1" 
AR Path="/5F09E690/5EFD2E4D" Ref="C203"  Part="1" 
F 0 "C203" H 1300 3100 40  0000 C CNN
F 1 "1.0uF" H 1500 3300 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1438 3050 50  0001 C CNN
F 3 "https://api.kemet.com/component-edge/download/specsheet/C315C105K3R5TA.pdf" H 1400 3200 50  0001 C CNN
F 4 "C315C105K3R5TA" H 1400 3200 50  0001 C CNN "Mfg"
F 5 "399-9714-ND" H 1400 3200 50  0001 C CNN "Digikey"
	1    1400 3200
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5EFD7E41
P 1400 4050
AR Path="/5EF09792/5EFD7E41" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5EFD7E41" Ref="C?"  Part="1" 
AR Path="/5F09E690/5EFD7E41" Ref="C204"  Part="1" 
F 0 "C204" H 1300 3950 40  0000 C CNN
F 1 "1.0uF" H 1500 4150 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1438 3900 50  0001 C CNN
F 3 "https://api.kemet.com/component-edge/download/specsheet/C315C105K3R5TA.pdf" H 1400 4050 50  0001 C CNN
F 4 "C315C105K3R5TA" H 1400 4050 50  0001 C CNN "Mfg"
F 5 "399-9714-ND" H 1400 4050 50  0001 C CNN "Digikey"
	1    1400 4050
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5EFD8D08
P 1700 2350
AR Path="/5EF09792/5EFD8D08" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5EFD8D08" Ref="C?"  Part="1" 
AR Path="/5F09E690/5EFD8D08" Ref="C210"  Part="1" 
F 0 "C210" H 1800 2250 40  0000 C CNN
F 1 "0.001uF" H 1850 2450 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1738 2200 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1050_GOLDMAX_X7R.pdf" H 1700 2350 50  0001 C CNN
F 4 "C315C102K1R5TA" H 1700 2350 50  0001 C CNN "Mfg"
F 5 "399-4144-ND" H 1700 2350 50  0001 C CNN "Digikey"
	1    1700 2350
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5EFDACEF
P 1700 3200
AR Path="/5EF09792/5EFDACEF" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5EFDACEF" Ref="C?"  Part="1" 
AR Path="/5F09E690/5EFDACEF" Ref="C211"  Part="1" 
F 0 "C211" H 1800 3100 40  0000 C CNN
F 1 "0.001uF" H 1850 3300 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1738 3050 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1050_GOLDMAX_X7R.pdf" H 1700 3200 50  0001 C CNN
F 4 "C315C102K1R5TA" H 1700 3200 50  0001 C CNN "Mfg"
F 5 "399-4144-ND" H 1700 3200 50  0001 C CNN "Digikey"
	1    1700 3200
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5EFDB355
P 1700 4050
AR Path="/5EF09792/5EFDB355" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5EFDB355" Ref="C?"  Part="1" 
AR Path="/5F09E690/5EFDB355" Ref="C212"  Part="1" 
F 0 "C212" H 1800 3950 40  0000 C CNN
F 1 "0.001uF" H 1850 4150 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1738 3900 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1050_GOLDMAX_X7R.pdf" H 1700 4050 50  0001 C CNN
F 4 "C315C102K1R5TA" H 1700 4050 50  0001 C CNN "Mfg"
F 5 "399-4144-ND" H 1700 4050 50  0001 C CNN "Digikey"
	1    1700 4050
	1    0    0    1   
$EndComp
Wire Wire Line
	9200 1500 9600 1500
Wire Wire Line
	9200 1900 9600 1900
Wire Wire Line
	9200 2000 9600 2000
Wire Wire Line
	9200 3200 9600 3200
Wire Wire Line
	9200 3300 9600 3300
Wire Wire Line
	9200 3400 9600 3400
Wire Wire Line
	9200 1400 9600 1400
Wire Wire Line
	9200 1300 9600 1300
Wire Wire Line
	9200 1200 9600 1200
Wire Wire Line
	9200 1100 9600 1100
Wire Wire Line
	9200 1000 9600 1000
Text Notes 8600 1450 0    50   ~ 0
8V Gnd
Text Notes 8550 2150 0    50   ~ 0
VDD Gnd
Text Notes 8550 2250 0    50   ~ 0
VDD Gnd
Text Notes 4100 850  0    50   ~ 0
NOTE! The stock CMP, CKP and VSPD sensors require an 8 volt power\nsupply.
$Comp
L Device:C C?
U 1 1 5F0E1342
P 1400 4700
AR Path="/5EF09792/5F0E1342" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0E1342" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F0E1342" Ref="C205"  Part="1" 
F 0 "C205" H 1300 4600 40  0000 C CNN
F 1 "0.22uF" H 1550 4800 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 1438 4550 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1051_GOLDMAX_Z5U.pdf" H 1400 4700 50  0001 C CNN
F 4 "C320C224M5U5TA" H 1400 4700 50  0001 C CNN "Mfg"
F 5 "399-4289-ND" H 1400 4700 50  0001 C CNN "Digikey"
	1    1400 4700
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F0E1E6A
P 1400 5350
AR Path="/5EF09792/5F0E1E6A" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0E1E6A" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F0E1E6A" Ref="C206"  Part="1" 
F 0 "C206" H 1300 5250 40  0000 C CNN
F 1 "0.22uF" H 1550 5450 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 1438 5200 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1051_GOLDMAX_Z5U.pdf" H 1400 5350 50  0001 C CNN
F 4 "C320C224M5U5TA" H 1400 5350 50  0001 C CNN "Mfg"
F 5 "399-4289-ND" H 1400 5350 50  0001 C CNN "Digikey"
	1    1400 5350
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F0E22CB
P 1400 6000
AR Path="/5EF09792/5F0E22CB" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0E22CB" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F0E22CB" Ref="C207"  Part="1" 
F 0 "C207" H 1300 5900 40  0000 C CNN
F 1 "0.22uF" H 1550 6100 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 1438 5850 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1051_GOLDMAX_Z5U.pdf" H 1400 6000 50  0001 C CNN
F 4 "C320C224M5U5TA" H 1400 6000 50  0001 C CNN "Mfg"
F 5 "399-4289-ND" H 1400 6000 50  0001 C CNN "Digikey"
	1    1400 6000
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F0E277B
P 1400 7550
AR Path="/5EF09792/5F0E277B" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0E277B" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F0E277B" Ref="C208"  Part="1" 
F 0 "C208" H 1300 7450 40  0000 C CNN
F 1 "0.22uF" H 1550 7650 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 1438 7400 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1051_GOLDMAX_Z5U.pdf" H 1400 7550 50  0001 C CNN
F 4 "C320C224M5U5TA" H 1400 7550 50  0001 C CNN "Mfg"
F 5 "399-4289-ND" H 1400 7550 50  0001 C CNN "Digikey"
	1    1400 7550
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F0E36AD
P 3000 1300
AR Path="/5EF09792/5F0E36AD" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0E36AD" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F0E36AD" Ref="C219"  Part="1" 
F 0 "C219" H 2900 1200 40  0000 C CNN
F 1 "0.22uF" H 3150 1400 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 3038 1150 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1051_GOLDMAX_Z5U.pdf" H 3000 1300 50  0001 C CNN
F 4 "C320C224M5U5TA" H 3000 1300 50  0001 C CNN "Mfg"
F 5 "399-4289-ND" H 3000 1300 50  0001 C CNN "Digikey"
	1    3000 1300
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F0E3B98
P 3000 1950
AR Path="/5EF09792/5F0E3B98" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0E3B98" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F0E3B98" Ref="C220"  Part="1" 
F 0 "C220" H 2900 1850 40  0000 C CNN
F 1 "0.22uF" H 3150 2050 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 3038 1800 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1051_GOLDMAX_Z5U.pdf" H 3000 1950 50  0001 C CNN
F 4 "C320C224M5U5TA" H 3000 1950 50  0001 C CNN "Mfg"
F 5 "399-4289-ND" H 3000 1950 50  0001 C CNN "Digikey"
	1    3000 1950
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F0E40D6
P 3000 2600
AR Path="/5EF09792/5F0E40D6" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0E40D6" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F0E40D6" Ref="C221"  Part="1" 
F 0 "C221" H 2900 2500 40  0000 C CNN
F 1 "0.22uF" H 3150 2700 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 3038 2450 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1051_GOLDMAX_Z5U.pdf" H 3000 2600 50  0001 C CNN
F 4 "C320C224M5U5TA" H 3000 2600 50  0001 C CNN "Mfg"
F 5 "399-4289-ND" H 3000 2600 50  0001 C CNN "Digikey"
	1    3000 2600
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F0E4588
P 3000 3250
AR Path="/5EF09792/5F0E4588" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0E4588" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F0E4588" Ref="C222"  Part="1" 
F 0 "C222" H 2900 3150 40  0000 C CNN
F 1 "0.22uF" H 3150 3350 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 3038 3100 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1051_GOLDMAX_Z5U.pdf" H 3000 3250 50  0001 C CNN
F 4 "C320C224M5U5TA" H 3000 3250 50  0001 C CNN "Mfg"
F 5 "399-4289-ND" H 3000 3250 50  0001 C CNN "Digikey"
	1    3000 3250
	1    0    0    1   
$EndComp
$Comp
L Device:R R?
U 1 1 5F0EAF95
P 1700 6000
AR Path="/5EF09792/5F0EAF95" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F0EAF95" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F0EAF95" Ref="R228"  Part="1" 
F 0 "R228" V 1625 6025 40  0000 C CNN
F 1 "1Meg" V 1700 6000 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1630 6000 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1700 6000 50  0001 C CNN
F 4 "MFR-25FBF52-1M" V 1700 6000 50  0001 C CNN "Mfg"
F 5 "1.00MXBK-ND" V 1700 6000 50  0001 C CNN "Digikey"
	1    1700 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 4700 9450 4700
Wire Wire Line
	9550 5400 9450 5400
Wire Wire Line
	9450 5400 9450 4700
Connection ~ 9450 4700
$Comp
L Device:C C?
U 1 1 5F16DB2C
P 1700 4700
AR Path="/5EF09792/5F16DB2C" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F16DB2C" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F16DB2C" Ref="C213"  Part="1" 
F 0 "C213" H 1800 4600 40  0000 C CNN
F 1 "0.001uF" H 1850 4800 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1738 4550 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1050_GOLDMAX_X7R.pdf" H 1700 4700 50  0001 C CNN
F 4 "C315C102K1R5TA" H 1700 4700 50  0001 C CNN "Mfg"
F 5 "399-4144-ND" H 1700 4700 50  0001 C CNN "Digikey"
	1    1700 4700
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F16E19B
P 1700 5350
AR Path="/5EF09792/5F16E19B" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F16E19B" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F16E19B" Ref="C214"  Part="1" 
F 0 "C214" H 1800 5250 40  0000 C CNN
F 1 "0.001uF" H 1850 5450 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1738 5200 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1050_GOLDMAX_X7R.pdf" H 1700 5350 50  0001 C CNN
F 4 "C315C102K1R5TA" H 1700 5350 50  0001 C CNN "Mfg"
F 5 "399-4144-ND" H 1700 5350 50  0001 C CNN "Digikey"
	1    1700 5350
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F16E8D4
P 1700 7550
AR Path="/5EF09792/5F16E8D4" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F16E8D4" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F16E8D4" Ref="C216"  Part="1" 
F 0 "C216" H 1800 7450 40  0000 C CNN
F 1 "0.001uF" H 1850 7650 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1738 7400 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1050_GOLDMAX_X7R.pdf" H 1700 7550 50  0001 C CNN
F 4 "C315C102K1R5TA" H 1700 7550 50  0001 C CNN "Mfg"
F 5 "399-4144-ND" H 1700 7550 50  0001 C CNN "Digikey"
	1    1700 7550
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F171833
P 3300 1300
AR Path="/5EF09792/5F171833" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F171833" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F171833" Ref="C223"  Part="1" 
F 0 "C223" H 3400 1200 40  0000 C CNN
F 1 "0.001uF" H 3450 1400 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 3338 1150 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1050_GOLDMAX_X7R.pdf" H 3300 1300 50  0001 C CNN
F 4 "C315C102K1R5TA" H 3300 1300 50  0001 C CNN "Mfg"
F 5 "399-4144-ND" H 3300 1300 50  0001 C CNN "Digikey"
	1    3300 1300
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F171F70
P 3300 1950
AR Path="/5EF09792/5F171F70" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F171F70" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F171F70" Ref="C224"  Part="1" 
F 0 "C224" H 3400 1850 40  0000 C CNN
F 1 "0.001uF" H 3450 2050 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 3338 1800 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1050_GOLDMAX_X7R.pdf" H 3300 1950 50  0001 C CNN
F 4 "C315C102K1R5TA" H 3300 1950 50  0001 C CNN "Mfg"
F 5 "399-4144-ND" H 3300 1950 50  0001 C CNN "Digikey"
	1    3300 1950
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F1724B9
P 3300 2600
AR Path="/5EF09792/5F1724B9" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F1724B9" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F1724B9" Ref="C225"  Part="1" 
F 0 "C225" H 3400 2500 40  0000 C CNN
F 1 "0.001uF" H 3450 2700 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 3338 2450 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1050_GOLDMAX_X7R.pdf" H 3300 2600 50  0001 C CNN
F 4 "C315C102K1R5TA" H 3300 2600 50  0001 C CNN "Mfg"
F 5 "399-4144-ND" H 3300 2600 50  0001 C CNN "Digikey"
	1    3300 2600
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F179273
P 7300 4400
AR Path="/5EF09792/5F179273" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F179273" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F179273" Ref="C230"  Part="1" 
F 0 "C230" H 7200 4300 40  0000 C CNN
F 1 "1.0uF" H 7200 4500 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 7338 4250 50  0001 C CNN
F 3 "https://api.kemet.com/component-edge/download/specsheet/C315C105K3R5TA.pdf" H 7300 4400 50  0001 C CNN
F 4 "C315C105K3R5TA" H 7300 4400 50  0001 C CNN "Mfg"
F 5 "399-9714-ND" H 7300 4400 50  0001 C CNN "Digikey"
	1    7300 4400
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F179C88
P 8900 4400
AR Path="/5EF09792/5F179C88" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F179C88" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F179C88" Ref="C231"  Part="1" 
F 0 "C231" H 9000 4300 40  0000 C CNN
F 1 "1.0uF" H 9000 4500 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 8938 4250 50  0001 C CNN
F 3 "https://api.kemet.com/component-edge/download/specsheet/C315C105K3R5TA.pdf" H 8900 4400 50  0001 C CNN
F 4 "C315C105K3R5TA" H 8900 4400 50  0001 C CNN "Mfg"
F 5 "399-9714-ND" H 8900 4400 50  0001 C CNN "Digikey"
	1    8900 4400
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F17A42B
P 9150 4400
AR Path="/5EF09792/5F17A42B" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F17A42B" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F17A42B" Ref="C232"  Part="1" 
F 0 "C232" H 9250 4300 40  0000 C CNN
F 1 "1.0uF" H 9250 4500 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 9188 4250 50  0001 C CNN
F 3 "https://api.kemet.com/component-edge/download/specsheet/C315C105K3R5TA.pdf" H 9150 4400 50  0001 C CNN
F 4 "C315C105K3R5TA" H 9150 4400 50  0001 C CNN "Mfg"
F 5 "399-9714-ND" H 9150 4400 50  0001 C CNN "Digikey"
	1    9150 4400
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F17A7E9
P 9150 5200
AR Path="/5EF09792/5F17A7E9" Ref="C?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F17A7E9" Ref="C?"  Part="1" 
AR Path="/5F09E690/5F17A7E9" Ref="C233"  Part="1" 
F 0 "C233" H 9250 5100 40  0000 C CNN
F 1 "1.0uF" H 9250 5300 40  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 9188 5050 50  0001 C CNN
F 3 "https://api.kemet.com/component-edge/download/specsheet/C315C105K3R5TA.pdf" H 9150 5200 50  0001 C CNN
F 4 "C315C105K3R5TA" H 9150 5200 50  0001 C CNN "Mfg"
F 5 "399-9714-ND" H 9150 5200 50  0001 C CNN "Digikey"
	1    9150 5200
	1    0    0    1   
$EndComp
$Comp
L Device:R R?
U 1 1 5F182301
P 1550 2850
AR Path="/5EF09792/5F182301" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F182301" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F182301" Ref="R206"  Part="1" 
F 0 "R206" V 1475 2875 40  0000 C CNN
F 1 "6.98K" V 1550 2850 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 2850 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 2850 50  0001 C CNN
F 4 "MFR-25FBF52-6K98" V 1550 2850 50  0001 C CNN "Mfg"
F 5 "6.98KXBK-ND" V 1550 2850 50  0001 C CNN "Digikey"
	1    1550 2850
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5F182837
P 1550 3700
AR Path="/5EF09792/5F182837" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F182837" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F182837" Ref="R208"  Part="1" 
F 0 "R208" V 1475 3725 40  0000 C CNN
F 1 "6.98K" V 1550 3700 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 3700 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 3700 50  0001 C CNN
F 4 "MFR-25FBF52-6K98" V 1550 3700 50  0001 C CNN "Mfg"
F 5 "6.98KXBK-ND" V 1550 3700 50  0001 C CNN "Digikey"
	1    1550 3700
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5F189D0D
P 1550 2200
AR Path="/5EF09792/5F189D0D" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F189D0D" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F189D0D" Ref="R205"  Part="1" 
F 0 "R205" V 1475 2225 40  0000 C CNN
F 1 "1K" V 1550 2200 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 2200 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 2200 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 1550 2200 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 1550 2200 50  0001 C CNN "Digikey"
	1    1550 2200
	0    1    1    0   
$EndComp
Connection ~ 1400 2200
$Comp
L Device:R R?
U 1 1 5F18A338
P 1550 3050
AR Path="/5EF09792/5F18A338" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18A338" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18A338" Ref="R207"  Part="1" 
F 0 "R207" V 1475 3075 40  0000 C CNN
F 1 "1K" V 1550 3050 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 3050 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 3050 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 1550 3050 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 1550 3050 50  0001 C CNN "Digikey"
	1    1550 3050
	0    1    1    0   
$EndComp
Connection ~ 1400 3050
$Comp
L Device:R R?
U 1 1 5F18A932
P 1550 3900
AR Path="/5EF09792/5F18A932" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18A932" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18A932" Ref="R209"  Part="1" 
F 0 "R209" V 1475 3925 40  0000 C CNN
F 1 "1K" V 1550 3900 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 3900 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 3900 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 1550 3900 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 1550 3900 50  0001 C CNN "Digikey"
	1    1550 3900
	0    1    1    0   
$EndComp
Connection ~ 1400 3900
$Comp
L Device:R R?
U 1 1 5F18AE6A
P 1550 4550
AR Path="/5EF09792/5F18AE6A" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18AE6A" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18AE6A" Ref="R210"  Part="1" 
F 0 "R210" V 1475 4575 40  0000 C CNN
F 1 "1K" V 1550 4550 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 4550 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 4550 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 1550 4550 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 1550 4550 50  0001 C CNN "Digikey"
	1    1550 4550
	0    1    1    0   
$EndComp
Connection ~ 1700 4550
Connection ~ 1400 4550
$Comp
L Device:R R?
U 1 1 5F18B3F5
P 1550 5200
AR Path="/5EF09792/5F18B3F5" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18B3F5" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18B3F5" Ref="R211"  Part="1" 
F 0 "R211" V 1475 5225 40  0000 C CNN
F 1 "1K" V 1550 5200 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 5200 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 5200 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 1550 5200 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 1550 5200 50  0001 C CNN "Digikey"
	1    1550 5200
	0    1    1    0   
$EndComp
Connection ~ 1700 5200
Connection ~ 1400 5200
$Comp
L Device:R R?
U 1 1 5F18B796
P 1550 5850
AR Path="/5EF09792/5F18B796" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18B796" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18B796" Ref="R212"  Part="1" 
F 0 "R212" V 1475 5875 40  0000 C CNN
F 1 "1K" V 1550 5850 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 5850 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 5850 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 1550 5850 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 1550 5850 50  0001 C CNN "Digikey"
	1    1550 5850
	0    1    1    0   
$EndComp
Connection ~ 1700 5850
Connection ~ 1400 5850
$Comp
L Device:R R?
U 1 1 5F18BBE4
P 1550 7400
AR Path="/5EF09792/5F18BBE4" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18BBE4" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18BBE4" Ref="R213"  Part="1" 
F 0 "R213" V 1475 7425 40  0000 C CNN
F 1 "1K" V 1550 7400 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 7400 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 1550 7400 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 1550 7400 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 1550 7400 50  0001 C CNN "Digikey"
	1    1550 7400
	0    1    1    0   
$EndComp
Connection ~ 1700 7400
Connection ~ 1400 7400
$Comp
L Device:R R?
U 1 1 5F18C694
P 3150 1150
AR Path="/5EF09792/5F18C694" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18C694" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18C694" Ref="R215"  Part="1" 
F 0 "R215" V 3075 1175 40  0000 C CNN
F 1 "1K" V 3150 1150 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 3080 1150 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 3150 1150 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 3150 1150 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 3150 1150 50  0001 C CNN "Digikey"
	1    3150 1150
	0    1    1    0   
$EndComp
Connection ~ 3300 1150
Connection ~ 3000 1150
$Comp
L Device:R R?
U 1 1 5F18D07B
P 3150 1800
AR Path="/5EF09792/5F18D07B" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18D07B" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18D07B" Ref="R216"  Part="1" 
F 0 "R216" V 3075 1825 40  0000 C CNN
F 1 "1K" V 3150 1800 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 3080 1800 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 3150 1800 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 3150 1800 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 3150 1800 50  0001 C CNN "Digikey"
	1    3150 1800
	0    1    1    0   
$EndComp
Connection ~ 3300 1800
Connection ~ 3000 1800
$Comp
L Device:R R?
U 1 1 5F18D492
P 3150 2450
AR Path="/5EF09792/5F18D492" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18D492" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18D492" Ref="R217"  Part="1" 
F 0 "R217" V 3075 2475 40  0000 C CNN
F 1 "1K" V 3150 2450 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 3080 2450 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 3150 2450 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 3150 2450 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 3150 2450 50  0001 C CNN "Digikey"
	1    3150 2450
	0    1    1    0   
$EndComp
Connection ~ 3300 2450
Connection ~ 3000 2450
$Comp
L Device:R R?
U 1 1 5F18D80D
P 3150 3100
AR Path="/5EF09792/5F18D80D" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18D80D" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18D80D" Ref="R218"  Part="1" 
F 0 "R218" V 3075 3125 40  0000 C CNN
F 1 "1K" V 3150 3100 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 3080 3100 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 3150 3100 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 3150 3100 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 3150 3100 50  0001 C CNN "Digikey"
	1    3150 3100
	0    1    1    0   
$EndComp
Connection ~ 3000 3100
$Comp
L Device:R R?
U 1 1 5F18DC9C
P 5250 1600
AR Path="/5EF09792/5F18DC9C" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18DC9C" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18DC9C" Ref="R219"  Part="1" 
F 0 "R219" V 5350 1600 40  0000 C CNN
F 1 "1K" V 5250 1600 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 5180 1600 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 5250 1600 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 5250 1600 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 5250 1600 50  0001 C CNN "Digikey"
	1    5250 1600
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5F18F386
P 5750 1600
AR Path="/5EF09792/5F18F386" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18F386" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18F386" Ref="R222"  Part="1" 
F 0 "R222" V 5850 1600 40  0000 C CNN
F 1 "1K" V 5750 1600 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 5680 1600 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 5750 1600 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 5750 1600 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 5750 1600 50  0001 C CNN "Digikey"
	1    5750 1600
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5F18FFFC
P 5800 4200
AR Path="/5EF09792/5F18FFFC" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18FFFC" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18FFFC" Ref="R224"  Part="1" 
F 0 "R224" V 5900 4200 40  0000 C CNN
F 1 "1K" V 5800 4200 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 5730 4200 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 5800 4200 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 5800 4200 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 5800 4200 50  0001 C CNN "Digikey"
	1    5800 4200
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5F18FBB8
P 5800 2950
AR Path="/5EF09792/5F18FBB8" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18FBB8" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18FBB8" Ref="R223"  Part="1" 
F 0 "R223" V 5900 2950 40  0000 C CNN
F 1 "1K" V 5800 2950 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 5730 2950 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 5800 2950 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 5800 2950 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 5800 2950 50  0001 C CNN "Digikey"
	1    5800 2950
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5F18EDF4
P 5300 4200
AR Path="/5EF09792/5F18EDF4" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18EDF4" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18EDF4" Ref="R221"  Part="1" 
F 0 "R221" V 5400 4200 40  0000 C CNN
F 1 "1K" V 5300 4200 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 5230 4200 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 5300 4200 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 5300 4200 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 5300 4200 50  0001 C CNN "Digikey"
	1    5300 4200
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5F18E80C
P 5300 2950
AR Path="/5EF09792/5F18E80C" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F18E80C" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F18E80C" Ref="R220"  Part="1" 
F 0 "R220" V 5400 2950 40  0000 C CNN
F 1 "1K" V 5300 2950 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 5230 2950 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 5300 2950 50  0001 C CNN
F 4 "MFR-25FBF52-1K" V 5300 2950 50  0001 C CNN "Mfg"
F 5 "1.00KXBK-ND" V 5300 2950 50  0001 C CNN "Digikey"
	1    5300 2950
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5F186A87
P 6100 3750
AR Path="/5EF09792/5F186A87" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F186A87" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F186A87" Ref="R227"  Part="1" 
F 0 "R227" V 6025 3775 40  0000 C CNN
F 1 "680R" V 6100 3750 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 6030 3750 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 6100 3750 50  0001 C CNN
F 4 "MFR-25FBF52-200R" V 6100 3750 50  0001 C CNN "Mfg"
F 5 "200XBK-ND" V 6100 3750 50  0001 C CNN "Digikey"
	1    6100 3750
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5F1864AB
P 6100 2500
AR Path="/5EF09792/5F1864AB" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F1864AB" Ref="R?"  Part="1" 
AR Path="/5F09E690/5F1864AB" Ref="R226"  Part="1" 
F 0 "R226" V 6025 2525 40  0000 C CNN
F 1 "390R" V 6100 2500 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 6030 2500 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 6100 2500 50  0001 C CNN
F 4 "MFR-25FBF52-200R" V 6100 2500 50  0001 C CNN "Mfg"
F 5 "200XBK-ND" V 6100 2500 50  0001 C CNN "Digikey"
	1    6100 2500
	0    1    1    0   
$EndComp
$Comp
L dk_Optoisolators-Transistor-Photovoltaic-Output:4N25 U204
U 1 1 5EF6148F
P 5550 3850
F 0 "U204" H 5550 4197 60  0000 C CNN
F 1 "4N25" H 5550 4091 60  0000 C CNN
F 2 "digikey-footprints:DIP-6_W7.62mm" H 5750 4050 60  0001 L CNN
F 3 "http://optoelectronics.liteon.com/upload/download/DS-70-99-0010/4N2X%20series%20Datasheet%201115.pdf" H 5750 4150 60  0001 L CNN
F 4 "160-1300-5-ND" H 5750 4250 60  0001 L CNN "Digi-Key_PN"
F 5 "4N25" H 5750 4350 60  0001 L CNN "MPN"
F 6 "Isolators" H 5750 4450 60  0001 L CNN "Category"
F 7 "Optoisolators - Transistor, Photovoltaic Output" H 5750 4550 60  0001 L CNN "Family"
F 8 "http://optoelectronics.liteon.com/upload/download/DS-70-99-0010/4N2X%20series%20Datasheet%201115.pdf" H 5750 4650 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/lite-on-inc/4N25/160-1300-5-ND/385762" H 5750 4750 60  0001 L CNN "DK_Detail_Page"
F 10 "OPTOISO 2.5KV TRANS W/BASE 6DIP" H 5750 4850 60  0001 L CNN "Description"
F 11 "Lite-On Inc." H 5750 4950 60  0001 L CNN "Manufacturer"
F 12 "Active" H 5750 5050 60  0001 L CNN "Status"
	1    5550 3850
	-1   0    0    -1  
$EndComp
$Comp
L dk_Optoisolators-Transistor-Photovoltaic-Output:4N25 U203
U 1 1 5EF607D0
P 5550 2600
F 0 "U203" H 5550 2947 60  0000 C CNN
F 1 "4N25" H 5550 2841 60  0000 C CNN
F 2 "digikey-footprints:DIP-6_W7.62mm" H 5750 2800 60  0001 L CNN
F 3 "http://optoelectronics.liteon.com/upload/download/DS-70-99-0010/4N2X%20series%20Datasheet%201115.pdf" H 5750 2900 60  0001 L CNN
F 4 "160-1300-5-ND" H 5750 3000 60  0001 L CNN "Digi-Key_PN"
F 5 "4N25" H 5750 3100 60  0001 L CNN "MPN"
F 6 "Isolators" H 5750 3200 60  0001 L CNN "Category"
F 7 "Optoisolators - Transistor, Photovoltaic Output" H 5750 3300 60  0001 L CNN "Family"
F 8 "http://optoelectronics.liteon.com/upload/download/DS-70-99-0010/4N2X%20series%20Datasheet%201115.pdf" H 5750 3400 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/lite-on-inc/4N25/160-1300-5-ND/385762" H 5750 3500 60  0001 L CNN "DK_Detail_Page"
F 10 "OPTOISO 2.5KV TRANS W/BASE 6DIP" H 5750 3600 60  0001 L CNN "Description"
F 11 "Lite-On Inc." H 5750 3700 60  0001 L CNN "Manufacturer"
F 12 "Active" H 5750 3800 60  0001 L CNN "Status"
	1    5550 2600
	-1   0    0    -1  
$EndComp
NoConn ~ 5850 4050
NoConn ~ 5850 2800
Text GLabel 4450 4150 0    50   Input ~ 0
PT2
Text Label 6450 3950 2    50   ~ 0
VSPD
Text Label 6500 2700 2    50   ~ 0
CKP
Wire Wire Line
	4750 4150 4450 4150
$Comp
L power:GND #PWR?
U 1 1 5F12B25D
P 6000 4250
AR Path="/5EF09792/5F12B25D" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F12B25D" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F12B25D" Ref="#PWR0239"  Part="1" 
F 0 "#PWR0239" H 6000 4000 50  0001 C CNN
F 1 "GND" H 6005 4077 50  0000 C CNN
F 2 "" H 6000 4250 50  0001 C CNN
F 3 "" H 6000 4250 50  0001 C CNN
	1    6000 4250
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5150 3750 4750 3750
Connection ~ 5150 3750
Wire Wire Line
	5150 3700 5150 3750
$Comp
L power:VDD #PWR?
U 1 1 5F12B252
P 5150 3700
AR Path="/5EF09792/5F12B252" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F12B252" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F12B252" Ref="#PWR0236"  Part="1" 
F 0 "#PWR0236" H 5150 3550 50  0001 C CNN
F 1 "VDD" V 5050 3750 50  0000 L CNN
F 2 "" H 5150 3700 50  0001 C CNN
F 3 "" H 5150 3700 50  0001 C CNN
	1    5150 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 3750 5150 3750
Connection ~ 5150 3950
Wire Wire Line
	5050 3950 5150 3950
Wire Wire Line
	5150 3950 5250 3950
Wire Wire Line
	5150 4200 5150 3950
Wire Wire Line
	5950 4200 6000 4200
NoConn ~ 5250 4050
$Comp
L dk_Transistors-Bipolar-BJT-Single:ZTX450 Q203
U 1 1 5F12B22E
P 4850 3950
F 0 "Q203" H 5100 4150 60  0000 L CNN
F 1 "ZTX450" H 5050 4000 60  0000 L CNN
F 2 "digikey-footprints:TO-92-3_Formed_Leads" H 5050 4150 60  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ZTX450.pdf" H 5050 4250 60  0001 L CNN
F 4 "ZTX450-ND" H 5050 4350 60  0001 L CNN "Digi-Key_PN"
F 5 "ZTX450" H 5050 4450 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 5050 4550 60  0001 L CNN "Category"
F 7 "Transistors - Bipolar (BJT) - Single" H 5050 4650 60  0001 L CNN "Family"
F 8 "https://www.diodes.com/assets/Datasheets/ZTX450.pdf" H 5050 4750 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/diodes-incorporated/ZTX450/ZTX450-ND/92530" H 5050 4850 60  0001 L CNN "DK_Detail_Page"
F 10 "TRANS NPN 45V 1A E-LINE" H 5050 4950 60  0001 L CNN "Description"
F 11 "Diodes Incorporated" H 5050 5050 60  0001 L CNN "Manufacturer"
F 12 "Active" H 5050 5150 60  0001 L CNN "Status"
	1    4850 3950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4750 2900 4450 2900
$Comp
L power:GND #PWR?
U 1 1 5F1247EC
P 6000 3000
AR Path="/5EF09792/5F1247EC" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F1247EC" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F1247EC" Ref="#PWR0238"  Part="1" 
F 0 "#PWR0238" H 6000 2750 50  0001 C CNN
F 1 "GND" H 6005 2827 50  0000 C CNN
F 2 "" H 6000 3000 50  0001 C CNN
F 3 "" H 6000 3000 50  0001 C CNN
	1    6000 3000
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5150 2500 4750 2500
Connection ~ 5150 2500
Wire Wire Line
	5150 2450 5150 2500
$Comp
L power:VDD #PWR?
U 1 1 5F1247E1
P 5150 2450
AR Path="/5EF09792/5F1247E1" Ref="#PWR?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/5F1247E1" Ref="#PWR?"  Part="1" 
AR Path="/5F09E690/5F1247E1" Ref="#PWR0235"  Part="1" 
F 0 "#PWR0235" H 5150 2300 50  0001 C CNN
F 1 "VDD" V 5050 2500 50  0000 L CNN
F 2 "" H 5150 2450 50  0001 C CNN
F 3 "" H 5150 2450 50  0001 C CNN
	1    5150 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 2500 5150 2500
Connection ~ 5150 2700
Wire Wire Line
	5050 2700 5150 2700
Wire Wire Line
	5150 2700 5250 2700
Wire Wire Line
	5150 2950 5150 2700
Wire Wire Line
	5950 2950 6000 2950
Wire Wire Line
	5450 2950 5550 2950
NoConn ~ 5250 2800
$Comp
L dk_Transistors-Bipolar-BJT-Single:ZTX450 Q202
U 1 1 5F1247BD
P 4850 2700
F 0 "Q202" H 5100 2900 60  0000 L CNN
F 1 "ZTX450" H 5050 2750 60  0000 L CNN
F 2 "digikey-footprints:TO-92-3_Formed_Leads" H 5050 2900 60  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ZTX450.pdf" H 5050 3000 60  0001 L CNN
F 4 "ZTX450-ND" H 5050 3100 60  0001 L CNN "Digi-Key_PN"
F 5 "ZTX450" H 5050 3200 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 5050 3300 60  0001 L CNN "Category"
F 7 "Transistors - Bipolar (BJT) - Single" H 5050 3400 60  0001 L CNN "Family"
F 8 "https://www.diodes.com/assets/Datasheets/ZTX450.pdf" H 5050 3500 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/diodes-incorporated/ZTX450/ZTX450-ND/92530" H 5050 3600 60  0001 L CNN "DK_Detail_Page"
F 10 "TRANS NPN 45V 1A E-LINE" H 5050 3700 60  0001 L CNN "Description"
F 11 "Diodes Incorporated" H 5050 3800 60  0001 L CNN "Manufacturer"
F 12 "Active" H 5050 3900 60  0001 L CNN "Status"
	1    4850 2700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4700 1550 4700 1800
Wire Wire Line
	4700 1800 5500 1800
Wire Wire Line
	5500 1800 5500 1600
Connection ~ 4700 1550
Connection ~ 5500 1600
Wire Wire Line
	5500 1600 5600 1600
Wire Wire Line
	4750 2900 4750 3150
Wire Wire Line
	4750 3150 5550 3150
Wire Wire Line
	5550 3150 5550 2950
Connection ~ 4750 2900
Connection ~ 5550 2950
Wire Wire Line
	5550 2950 5650 2950
Text Notes 6600 1450 0    50   ~ 0
8V signal goes low at trigger point
Text Notes 6600 2800 0    50   ~ 0
8V signal goes low at trigger point
Text Notes 6550 3950 0    50   ~ 0
8V square wave 8000 pp Mile
Text Notes 3900 1700 0    50   ~ 0
Goes high at trigger
Connection ~ 5550 4200
Connection ~ 4750 4150
Wire Wire Line
	5550 4200 5650 4200
Wire Wire Line
	5450 4200 5550 4200
Wire Wire Line
	5550 4350 5550 4200
Wire Wire Line
	4750 4350 5550 4350
Wire Wire Line
	4750 4150 4750 4350
Text Notes 5250 6950 0    50   ~ 0
PT0 = CMP = Camshaft Position Sensor\nPT1 = CKP = Crankshaft Position Sensor\nPT2 = VSPD = Vehicle Speed Sensor\nPA1 = Ignition Trim Enable Switch\nPA2 = Fuel Trim Enable Switch\nPA3 = Idle Speed Raise\nPA4 = Overrun fuel Cut enable\nPA5 = Overun Fuel Cut disable\nPA6 = Idle Speed Lower\nPS0 = RS232 Rx\nPS1 = RS232 Tx
Text Notes 3450 7900 0    50   ~ 0
PAD00 = +Batt = Battery Voltage\nPAD01 = CLT = Coolant Temperature\nPAD02 = MAT = Manifold Air Temperature\nPAD03 = PAD03in = Spare ADC Temperature in\nPAD04 = MAP = Manifold Absolute Pressure\nPAD05 = TPS = Throttle Position Sensor\nPAD06 = EGO1 = Exhaust Gas Oxygen Sensor 1 (Right)\nPAD07 = Barometric Pressure Sensor (board mount)\nPAD08 = EOP = Engine Oil Pressure Sensor\nPAD09 = EFP = Engine Fuel Pressure Sensor\nPAD10 = Itrm = Ignition Trim Potentiometer\nPAD11 = Ftrm = Fuel Trim Potentiometer\nPAD12 = EGO2 = Exhaust Gas Oxygen Sensor 2 (Left)
$Comp
L power:+8V #PWR0104
U 1 1 602D6E9F
P 6300 1100
F 0 "#PWR0104" H 6300 950 50  0001 C CNN
F 1 "+8V" V 6315 1228 50  0000 L CNN
F 2 "" H 6300 1100 50  0001 C CNN
F 3 "" H 6300 1100 50  0001 C CNN
	1    6300 1100
	1    0    0    -1  
$EndComp
$Comp
L power:+8V #PWR0105
U 1 1 602D7EFA
P 6350 2450
F 0 "#PWR0105" H 6350 2300 50  0001 C CNN
F 1 "+8V" V 6365 2578 50  0000 L CNN
F 2 "" H 6350 2450 50  0001 C CNN
F 3 "" H 6350 2450 50  0001 C CNN
	1    6350 2450
	1    0    0    -1  
$EndComp
$Comp
L power:+8V #PWR0106
U 1 1 602D84E9
P 6350 3700
F 0 "#PWR0106" H 6350 3550 50  0001 C CNN
F 1 "+8V" V 6365 3828 50  0000 L CNN
F 2 "" H 6350 3700 50  0001 C CNN
F 3 "" H 6350 3700 50  0001 C CNN
	1    6350 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 1100 6300 1150
Wire Wire Line
	6300 1150 6200 1150
Wire Wire Line
	5900 1150 5800 1150
Wire Wire Line
	5950 1600 5950 1650
Wire Wire Line
	6350 2450 6350 2500
Wire Wire Line
	6350 2500 6250 2500
Wire Wire Line
	5950 2500 5850 2500
Wire Wire Line
	6000 2950 6000 3000
Wire Wire Line
	6350 3700 6350 3750
Wire Wire Line
	6350 3750 6250 3750
Wire Wire Line
	5950 3750 5850 3750
Wire Wire Line
	6000 4200 6000 4250
Wire Wire Line
	5850 3950 6450 3950
Text Notes 6700 1300 0    50   ~ 0
3 wire gear tooth sensor
Text Notes 6700 2650 0    50   ~ 0
3 wire gear tooth sensor
Text Notes 3900 3050 0    50   ~ 0
Goes high at trigger
$Comp
L Device:LED D1
U 1 1 60EA4D7E
P 6100 1350
F 0 "D1" H 6250 1300 50  0000 C CNN
F 1 "Red" H 6250 1400 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm" H 6100 1350 50  0001 C CNN
F 3 "~" H 6100 1350 50  0001 C CNN
	1    6100 1350
	-1   0    0    1   
$EndComp
$Comp
L Device:LED D2
U 1 1 60EA68FF
P 6150 2700
F 0 "D2" H 6300 2650 50  0000 C CNN
F 1 "Blue" H 6300 2750 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm" H 6150 2700 50  0001 C CNN
F 3 "~" H 6150 2700 50  0001 C CNN
	1    6150 2700
	-1   0    0    1   
$EndComp
Text Notes 5950 1500 0    50   ~ 0
On at trigger
Text Notes 5950 2850 0    50   ~ 0
On at trigger
Wire Wire Line
	5800 1350 5950 1350
Wire Wire Line
	6250 1350 6550 1350
Wire Wire Line
	5850 2700 6000 2700
Wire Wire Line
	6300 2700 6500 2700
Text Notes 6650 1150 0    50   ~ 0
Red LED 1516-1359-ND Vf = 1.7 @10mA
Text Notes 6700 2500 0    50   ~ 0
Blue LED 1516-1365-ND Vf = 3.0 @10mA
Text Notes 6650 1000 0    50   ~ 0
4N25 Vf = 1.1 @10mA
Text Notes 6700 2350 0    50   ~ 0
4N25 Vf = 1.1 @10mA
Text GLabel 4400 1550 0    50   Input ~ 0
PT0
Text GLabel 4450 2900 0    50   Input ~ 0
PT1
$Comp
L Device:R R?
U 1 1 611795A9
P 3300 3250
AR Path="/5EF09792/611795A9" Ref="R?"  Part="1" 
AR Path="/5EF2B07F/5EF75822/611795A9" Ref="R?"  Part="1" 
AR Path="/5F09E690/611795A9" Ref="R229"  Part="1" 
F 0 "R229" V 3225 3275 40  0000 C CNN
F 1 "1Meg" V 3300 3250 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 3230 3250 50  0001 C CNN
F 3 "https://www.yageo.com/upload/media/product/products/datasheet/lr/Yageo_LR_MFR_1.pdf" H 3300 3250 50  0001 C CNN
F 4 "MFR-25FBF52-1M" V 3300 3250 50  0001 C CNN "Mfg"
F 5 "1.00MXBK-ND" V 3300 3250 50  0001 C CNN "Digikey"
	1    3300 3250
	1    0    0    -1  
$EndComp
Connection ~ 3300 3100
Text Notes 4150 4700 0    50   ~ 0
NOTE! VSPD signal is similar to CKP and CMP in that it pulses to ground
$EndSCHEMATC
