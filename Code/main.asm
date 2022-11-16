;        1         2         3         4         5         6         7         8         9
;23456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
;*****************************************************************************************
;* BPEM488CW                                                                             *
;*****************************************************************************************
;*****************************************************************************************
;*    Test code for BPEM488 Engine Controller for the Dodge 488CID (8.0L) V10 engine     *
;*    Hardware and firmware by Robert Hiebert.                                           * 
;*    Freescale CodeWarrior IDE version 5.9.0 Special Edition                            *
;*    Programmer USBMLT from Technological Arts                                          *                           
;*    Processor: MC9S12XEP100 112 LQFP                                                   *                                 
;*    Reference Manual: MC9S12XEP100RMV1 Rev. 1.25 02/2013                               *            
;*    The code is heavily commented not only to help others, but mainly as a teaching    *
;*    aid for myself as an amatuer programmer with no formal training. Special thanks to * 
;*    Dirk Heiswolf and Dan Williams without who's help and advice none of this would    * 
;*    have been possible.                                                                *
;*****************************************************************************************
;*****************************************************************************************
;* Version History:                                                                      *
;*    May 23 2021                                                                        *
;*    - EP100CW begins (work in progress)                                                *
;*    July 2 2021                                                                        *
;*    - Current Gear, IAC and Flash Burn code added                                      *
;*    July 4 2021                                                                        *
;*    - AFR and RPM averaging code added                                                 *
;*    July 10 2021                                                                       *
;*    - Change 3D tables from 18x18 to 16x16, general code cleanup                       *
;*    July 16 2021                                                                       *
;*    - Negative temp value interp code wasn't working.Couldn't fix it so I wrote        * 
;*      new code for it. More general code clean up. Couldn't find any more bugs         *
;*    July 16 2021                                                                       *
;*    - Found bugs in IAC code, fixed, had to modify RTI code as well                    * 
;*    August 06 2021                                                                     *
;*    - Intermittant loss of synch, missed or extended dwell time, missed or extended PW.*
;*      Turns out I was clearing my interrupt flags wrong and had a few other errors as  * 
;*      well. Logic analyzer an indispensible tool now. Changed fuel trim to +-50%       *
;*    August 7 2021                                                                      *
;*    - Tachout was twice required frequency, fixed                                      *
;*    August 14 2021                                                                     *
;*    - I still had some intermittant timer misses, took me a long time to figure it out *
;*      but the solution was to clear the interrupt flags on the first O/C call as well, * 
;*      even though they are not called by an interrupt                                  *
;*    August 16 2021                                                                     *
;*    - Test run on the engine revealed random high PW spikes, traced to TPSDOT values   * 
;*      of 65535. Made some code changes, next run should see if they work               *
;*    August 18 2021                                                                     *
;*    - Fixed bugs in TOE code?                                                          *   
;*    August 23 2021                                                                     *
;*    - Major overhaul on TOE code, still chasing bugs                                   * 
;*    August 24 2021                                                                     *
;*    - No Known Bugs                                                                    *
;*    October 10 2021                                                                    *
;*    - Setting up for new board and de-bugging board                                    *
;*    November 19 2021                                                                   *
;*    - Running test engine, Changing tuning parameters to match MS3                     *
;*    January 15 2022                                                                    *
;*    - Change code so injectors fire 1 notch later with no real delay                   *  
;*    January 17 2022                                                                    *
;*    - Change code so ignition triggers on notches during crank                         *
;*    January 18 2022                                                                    *
;*    - Change TIM and ECT to 2.56uS only, add MinCKP_F configurable constant and MinCKP *
;*      variable                                                                         * 
;*    February 03 2022                                                                   *
;*    - Fixed bug in PB5 (crank synch state indicator)                                   *
;*    February 04 2022                                                                   *
;*    - Remove RPM averageing                                                            * 
;*    February 05 2022                                                                   *
;*    - Clean up unused code                                                             * 
;*    February 27 2022                                                                   *
;*    - Change timers to 5.12 uS resolution                                              *  
;*    March 03 2022                                                                      *
;*    - Change OCH command from "O" to "A" to see if RealDash will work with that        *
;*    March 15 2022                                                                      *
;*    - First start up in Morgan, running very rich,chnage WUE settings. EFP and EOP     * 
;*      both not moving at 937 counts, suspect wrong polarity at sensor plug.            *
;*      set TPS min to 148 and TPS Max to 718. New values for WUE bins                   *
;*    - Sensor plug polarity change fixed EFP and EOP. Still bad over fuel. TPS% over    *
;*      over rangeing causing all kinds of issues. Change TPS min to 146, TPS max to 720 *
;*    March 16 2022                                                                      *
;*    - Change EOP and EFP calculations for 0.5V to 4.5V ratiometric. Add rail low and   *
;*      high features. Average efpADC to reduce pressure jitter. Change Req_Fuel to 10.6 *
;*      Results EOP OK, EFP still jitters but OK. Mixture much better but could use fine * 
;*      tuning. Speedometer and 4WD indicator not working.                               *
;*    March 17 2022                                                                      *
;*    - Found rich problem, still used 256 uS timer conversion for injOCadd2 fixed and   * 
;*      restored settings                                                                *
;*    March 19 2022                                                                      *
;*    - Tuning changes                                                                   *
;*    March 21 2022                                                                      *
;*    - Tuning changes                                                                   *
;*    March 22 2022                                                                      *
;*    - Tuning changes                                                                   *
;*    March 23 2022                                                                      *
;*    - Tuning changes                                                                   *
;*    March 24 2022                                                                      *
;*    - Tuning changes VE good still pings at 100KPA                                     *
;*    March 26 2022                                                                      *
;*    - Modify vehicle speed code for stopped conditions, add First/Rev Low in GearCur   *
;*      calcs                                                                            *
;*    March 27 2022                                                                      *
;*    - Modify vehicle speed code to eliminate overlap                                   *
;*    March 29 2022                                                                      *
;*    - Comment out burner code                                                          *
;*    April 2 2022                                                                       *
;*    - Changes to duty cycle calcs and economy calcs                                    *
;*    July 1 2022                                                                        *
;*    - Richen idle a bit, more changes to economy calcs                                 *
;*                                                                                       *
;*****************************************************************************************
;*****************************************************************************************
;*    BPEM488CW pin assignments                                                          *
;*                                                                                       *
;*    Port AD:                                                                           *
;*     PAD00 - (batAdc)     (analog, no pull) hard wired Bat volts ADC                   *
;*     PAD01 - (cltAdc)     (analog, no pull) temperature sensor ADC                     *
;*     PAD02 - (matAdc)     (analog, no pull) temperature sensor ADC                     *
;*     PAD03 - (PAD03inAdc) (analog, no pull) temperature sensor ADC  spare              *
;*     PAD04 - (mapAdc)     (analog, no pull) general purpose ADC                        *
;*     PAD05 - (tpsAdc)     (analog, no pull) general purpose ADC                        *
;*     PAD06 - (egoAdc1)(Right) (analog, no pull) general purpose ADC                    *
;*     PAD07 - (baroAdc)    (analog, no pull) general purpose ADC                        *
;*     PAD08 - (eopAdc)     (analog, no pull) general purpose ADC                        *
;*     PAD09 - (efpAdc)     (analog, no pull) general purpose ADC                        *
;*     PAD10 - (itrmAdc)    (analog, no pull) general purpose ADC                        *
;*     PAD11 - (ftrmAdc)    (analog, no pull) general purpose ADC                        *
;*     PAD12 - (egoAdc2)(Left) (analog, no pull) general purpose ADC                     *
;*     PAD13 - Not used     (GPIO input, pull-up)                                        *
;*     PAD14 - Not used     (GPIO input, pull-up)                                        *
;*     PAD15 - Not used     (GPIO input, pull-up)                                        *
;*                                                                                       *
;*    Port A:                                                                            *
;*     PA0 - Spare (on PCB) (input, pull-up, active low) momentary contact               *                            
;*     PA1 - Itrmen         (input, pull-up, active low) maintained contact J202 pin23   *
;*     PA2 - Ftrmen         (input, pull-up, active low) maintained contact J202 pin10   *
;*     PA3 - IdleSpdRaise   (input, pull-up, active low) momentary contact  J202 pin22   *
;*     PA4 - OFCen          (input, pull-up, active low) momentary contact  J202 pin9    *
;*     PA5 - OFCdis         (input, pull-up, active low) momentary contact  J202 pin21   *
;*     PA6 - IdleSpdLower   (input, pull-up, active low) momentary contact  J202 pin6    *
;*     PA7 - Not used       (input, pull-up)                                             *
;*                                                                                       *
;*    Port B:                                                                            *
;*     PB0 - FuelPump sinking      (output, active high, initialize low)                 *
;*     PB1 - ASDRelay sinking      (output, active high, initialize low)                 *
;*     PB2 - Spare sinking         (output, initialize low)          (old engine alarm)  *
;*     PB3 - AIOT sinking          (output, active high, initialize low)                 *
;*     PB4 - Tachout sourcing      (output, active high, initialize low) (old PB4 out)   *
;*     PB5 - Crank Synch Indicator (output, initialize high)             (old PB5 out)   *
;*     PB6 - Spare sourcing        (output, initialize low)              (old PB6 out)   *
;*     PB7 - Not used              (output, initialize low)                              *
;*                                                                                       *
;*    Port C: - Not Available in 112 LQFP                                                *
;*                                                                                       *
;*    Port D: - Not Available in 112 LQFP                                                *
;*                                                                                       *
;*    Port E:                                                                            *
;*     PE0 - Not used   (input, pull-up)                                                 *
;*     PE1 - Not used   (input, pull-up)                                                 *
;*     PE2 - Not used   (input, pull-up)                                                 *
;*     PE3 - Not used   (input, pull-up)                                                 *
;*     PE4 - Not used   (input, pull-up)                                                 *
;*     PE5 -(MODA)      (input, pull-up) (hard wired to ground)                          *
;*     PE6 -(MODB)      (input, pull-up) (hard wired to ground)                          *
;*     PE7 - Not used   (input, pull-up)                                                 *
;*                                                                                       *
;*    Port F: - Not Available in 112 LQFP                                                *
;*                                                                                       *
;*    Port H:                                                                            *
;*     PH0 - Not used   (input, pull-up)                                                 *
;*     PH1 - Not used   (input, pull-up)                                                 *
;*     PH2 - Not used   (input, pull-up)                                                 *
;*     PH3 - Not used   (input, pull-up)                                                 *
;*     PH4 - Not used   (input, pull-up)                                                 *
;*     PH5 - Not used   (input, pull-up)                                                 *
;*     PH6 - Not used   (input, pull-up)                                                 *
;*     PH7 - Not used   (input, pull-up)                                                 *
;*                                                                                       *
;*    Port J:                                                                            *
;*     PJ0 - Not used                    (input, pull-up)                                *
;*     PJ1 - Not used                    (input, pull-up)                                *
;*     PJ2 - Not Available in 112 LQFP                                                   *
;*     PJ3 - Not Available in 112 LQFP                                                   *
;*     PJ4 - Not Available in 112 LQFP                                                   *
;*     PJ5 - Not Available in 112 LQFP                                                   *
;*     PJ6 - Not used                    (input, pull-up)                                *
;*     PJ7 - Not used                    (input, pull-up)                                *
;*                                                                                       * 
;*    Port K:                                                                            *
;*     PK0 - Spare jumper pad          (output, initialize low)             (old LOP)    *
;*     PK1 - Spare sourcing            (output, initialize low)             (old HOT)    *
;*     PK2 - A4988Step                 (output, active high, initialize low)(old HET)    *
;*     PK3 - Spare jumper pad          (output, initialize low)             (old HEGT)   *
;*     PK4 - A4988Dir                  (output, active both, initialize low)(old HFT)    *
;*     PK5 - A4988En                   (output, active low, initialize low) (old LFP)    *
;*     PK6 - Not Available in 112 LQFP                                      (old HFP     *
;*     PK7 - Spare jumper pad          (output, initialize low)                          *
;*                                                                                       *
;*    Port M:                                                                            *
;*     PM0 - RXCAN0     (output, initialize low)(Future?)                                *
;*     PM1 - TXCAN0     (output, initialize low)(Future?)                                *
;*     PM2 - Not used   (output, initialize low)                                         *
;*     PM3 - Not used   (output, initialize low)                                         *
;*     PM4 - Not used   (output, initialize low)                                         *
;*     PM5 - Not used   (output, initialize low)                                         *
;*     PM6 - Not used   (output, initialize low)                                         *
;*     PM7 - Not used   (output, initialize low)                                         *
;*                                                                                       *
;*    Port L: - Not Available in 112 LQFP                                                *
;*                                                                                       *
;*    Port P: - (Timer module)                                                           *
;*     PP0 - TIM1 OC0 Inj1 (1&10)   (output, active high, initialize low)                *   
;*     PP1 - TIM1 OC1 Inj2 (9&4)    (output, active high, initialize low)                *    
;*     PP2 - TIM1 OC2 Inj3 (3&6)    (output, active high, initialize low)                * 
;*     PP3 - TIM1 OC3 Inj4 (5&8)    (output, active high, initialize low)                *  
;*     PP4 - TIM1 OC4 Inj5 (7&2)    (output, active high, initialize low)                * 
;*     PP5 - TIM1 OC5 PP5out        (output, initialize low) spare                       * 
;*     PP6 - Not used               (output, initialize low)                             *
;*     PP7 - Not used               (output, initialize low)                             *
;*                                                                                       *
;*                                                                                       *
;*    Port R: - Not Available in 112 LQFP                                                *
;*                                                                                       *
;*    Port S:                                                                            *
;*     PS0 - SCI0 RXD              (input, pull-up)                                      *
;*     PS1 - SCI0 TXD              (input, pull-up)(SCI0 init will change to output)     *
;*     PS2 - Not used              (input, pull-up)                                      *
;*     PS3 - Not used              (input, pull-up)                                      *
;*     PS4 - Not used              (input, pull-up)                                      *
;*     PS5 - Not used              (input, pull-up)                                      *
;*     PS6 - Not used              (input, pull-up)                                      *
;*     PS7 - Not used              (input, pull-up)                                      *
;*                                                                                       *
;*    Port T: (Enhanced Capture Timer module)                                            *
;*     PT0 - IOC0 - CMP                 (input, active high) gear tooth sens             *
;*     PT1 - IOC1 - CKP                 (input, active high) gear tooth sens             *
;*     PT2 - IOC2 - Vspd                (input, active high) gear tooth sens             *
;*     PT3 - IOC3 - Ign1 (1&6)          (output, active high, initialize low)            *
;*     PT4 - IOC4 - Ign2 (10&5)         (output, active high, initialize low)            *
;*     PT5 - IOC5 - Ign3 (9&8)          (output, active high, initialize low)            *
;*     PT6 - IOC6 - Ign4 (4&7)          (output, active high, initialize low)            *
;*     PT7 - IOC7 - Ign5 (3&2)          (output, active high, initialize low)            *
;*                                                                                       *
;*****************************************************************************************
;*****************************************************************************************
; This code is arranged into main sections and subsections. The main sections are:
; - The MC9S12XEP100 register definitions from address $0000 to $0800
; - RAM Variables and other things running from RAM address $2000 to $3FFF  
; - Flash Code from address $4000 to $8000
; - Reset Vectors from address $FF10 to $FFFF 
;*****************************************************************************************
;*****************************************************************************************
; Ram variables section subsections are:
; - RS232 variables and equates
; - Non RS232 variables and equates
; - 1024 bytes reserved for configurable constants and variables starting with "veBins"
; - 1024 bytes reserved for configurable constants and variables starting with "stBins"
; - 1024 bytes reserved for configurable constants and variables starting with "afrBins"
; - Flash erase and burn "Send_Command" subroutine
;*****************************************************************************************
;*****************************************************************************************
; Flash code section subsections are:
;
; - Pre main loop subsection
;   - Initialize CPU modules
;   - Initialize ISR vectors
;   - Copy configurable constants from Flash to Ram
;   - Energise fuel pump and ASD relay
;   - Clear and initialize all variables
;   - Start ATD0, read ADCs and convert to user units
;   - Deadband calculations
;   - Fire injectors prime pulse
;   - Set up for main loop
;   - After Start Enrichment and taper lookup

; - Main loop subsection
;   - Misc
;     - mS routines
;     - mS100 routines
;     - mS1000 routines
;     - Update Portbits
;     - RPM calculations
;     - KPH calculations
;     - Current gear calculations
;   - Ignition
;     - Dwell correction lookup
;     - ST table lookup
;     - Ignition calculations
;
;   - Fuel 
;     - Deadband calculations
;     - WUE correction lookup
;     - Barometric pressure correction lookup
;     - Manifold Air Temperature correction lookup
;     - VE table lookup
;     - AFR table lookup
;     - Crank mode calculations
;     - Run mode calculations
;     - ASE correction interpolation
;     - Throttle Opening Enrichment calculations
;     - Overrun Fuel Cut calculations
;     - Duty cycle calculations
;     - Fuel burn calculations
;     - Increment loop counter
;
; - Subroutines subsection
;   - ATD0 routines
;     - Read ATD0
;     - Convert ATD0
;   - Table lookups and interpolation routines
;   - Fuel injector timer routines
;     - Injector pulsewidth calculations
;     - ASE correction lookup
;     - ASE taper lookup
;   - Time rate routines
;     - mS routines
;       - Check for stall
;     - mS100 routines
;       - Decrement TOE duration counter
;       - Update TPS DOT
;     mS1000 routines
;       - Update loop counter
;       - Update fuel delivery variables
;       - Flash erase and burn 
;
; - Interrupt Service Routines subsection
;   - RTI time rate ISRs
;       - mS section
;       - mS100 section
;       - mS250 section
;       - mS500 section
;       - mS1000 section
;   - SCI0 RS232 ISRs
;
;   - ECT ISRs
;       - ECT ch0 camshaft sensor
;       - ECT ch1 crankshaft sensor
;       - ECT ch2 vehicle speed sensor
;       - ECT ch3 ignition 1
;       - ECT ch4 ignition 2
;       - ECT ch5 ignition 3
;       - ECT ch6 ignition 4
;       - ECT ch7 ignition 5
;   - TIM ISRs
;       - TIM ch0 injection 1
;       - TIM ch1 injection 2
;       - TIM ch2 injection 3
;       - TIM ch3 injection 4
;       - TIM ch4 injection 5
;
; - Configurable constants
;   - VE table and constants
;   - ST table and constants
;   - AFR table and constants
;
; - Tables
;   - Tuner Studio Signature
;   - Tuner Studio RevNum
;   - State machine lookup
;   - DodgeTherm thermistor values
;
; - ISR Vectors
;
;*****************************************************************************************

;**************************************************************************************** 
;                  REGISTER DEFINITIONS SECTION (address $0000 to $0800)
;****************************************************************************************


    ABSENTRY Entry  ; CW needs this for absolute assembly mark as application entry point

 		INCLUDE 'derivative.inc' ; This is a pretty big include file and I don't use most of 
 		                         ; it. I tried getting rid of it altogether and just insert
 		                         ; the register definitons I need, but CW won't let me, so
 		                         ; I guess I'm stuck with it. I suppose it isn't doing any 
 		                         ; harm as it's not as if I am running short of Flash capacity.
 		                         
;*****************************************************************************************
; These are the MC9S12XEP100 defintions that I am using
;*****************************************************************************************

;PORTA       equ  $0000
;PORTB       equ  $0001
;DDRA        equ  $0002
;DDRB        equ  $0003
;DDRE        equ  $0009
;MODE        equ  $000B
;PUCR        equ  $000C
;IRQCR       equ  $001E
;PORTK       equ  $0032
;DDRK        equ  $0033
;SYNR        equ  $0034
;REFDV       equ  $0035
;CRGFLG      equ  $0037
;CLKSEL      equ  $0039
;CRGINT      equ  $0038
;RTICTL      equ  $003B
;ECT_TIOS    equ  $0040
;ECT_TCNT    equ  $0044
;ECT_TSCR1   equ  $0046
;ECT_TCTL1   equ  $0048
;ECT_TCTL2   equ  $0049
;ECT_TCTL3   equ  $004A
;ECT_TCTL4   equ  $004B 
;ECT_TIE     equ  $004C
;ECT_TFLG1   equ  $004E
;ECT_TC1     equ  $0052
;ECT_TC2Hi   equ  $0054
;ECT_TC3     equ  $0056
;ECT_TC4     equ  $0058
;ECT_TC5     equ  $005A
;ECT_TC6     equ  $005C
;ECT_TC7     equ  $005E
;ECT_PTPSR   equ  $006E
;SCI0BDH     equ  $00C8
;SCI0BDL     equ  $00C9
;SCI0CR1     equ  $00CA
;SCI0CR2     equ  $00CB
;SCI0SR1     equ  $00CC
;SCI0DRL     equ  $00CF
;FCLKDIV     equ  $0100
;FCCOBIX     equ  $0102
;FSTAT       equ  $0106
;FPROT       equ  $0108
;FCCOBHI     equ  $010A
;FCCOBLO     equ  $010B
;INT_CFADDR  equ  $0127
;INT_CFDATA0 equ  $0128
;INT_CFDATA1 equ  $0129
;INT_CFDATA2 equ  $012A
;INT_CFDATA3 equ  $012B
;INT_CFDATA4 equ  $012C
;INT_CFDATA5 equ  $012D
;INT_CFDATA6 equ  $012E
;INT_CFDATA7 equ  $012F
;PTT         equ  $0240
;DDRT        equ  $0242
;PERT        equ  $0244
;DDRS        equ  $024A
;PERS        equ  $024C
;DDRM        equ  $0252
;PERM        equ  $0254
;PTP         equ  $0258
;DDRP        equ  $025A
;DDRH        equ  $0262
;PERH        equ  $0264
;DDRJ        equ  $026A
;PERJ        equ  $026C
;PT0AD0      equ  $0270
;DDR0AD0     equ  $0272
;PER0AD0     equ  $0276
;ATD0CTL0    equ  $02C0
;ATD0CTL1    equ  $02C1
;ATD0CTL2    equ  $02C2
;ATD0CTL3    equ  $02C3
;ATD0CTL4    equ  $02C4
;ATD0CTL5    equ  $02C5
;ATD0STAT0   equ  $02C6
;ATD0DIENH   equ  $02CC
;ATD0DR0H    equ  $02D0
;ATD0DR1H    equ  $02D2
;ATD0DR2H    equ  $02D4
;ATD0DR3H    equ  $02D6
;ATD0DR4H    equ  $02D8
;ATD0DR5H    equ  $02DA
;ATD0DR6H    equ  $02DC
;ATD0DR7H    equ  $02DE
;ATD0DR8H    equ  $02E0
;ATD0DR9H    equ  $02E2
;ATD0DR10H   equ  $02E4
;ATD0DR11H   equ  $02E6
;ATD0DR12H   equ  $02E8
;PTRRR       equ  $036F
;TIM_TIOS    equ  $03D0
;TIM_TCNT    equ  $03D4
;TIM_TSCR1   equ  $03D6
;TIM_TCTL2   equ  $03D9
;TIM_TIE     equ  $03DC
;TIM_TSCR2   equ  $03DD
;TIM_TFLG1   equ  $03DE
;TIM_TC1H    equ  $03E2
;TIM_TC2H    equ  $03E4
;TIM_TC3H    equ  $03E6
;TIM_TC4H    equ  $03E8
;TIM_PTPSR   equ  $03FE

;*****************************************************************************************
; Memory equates
;***************************************************************************************** 
		
VarStart    equ  $2000
VEStart     equ  $2400
STStart     equ  $2800
AFRStart    equ  $2C00 
ROMStart    equ  $4000  ; Absolute address to place code/constant data
                        
;**************************************************************************************** 
;                 RAM VARIABLES SECTION (address $2000 to $3FFF) 
;****************************************************************************************

            ORG VarStart  ; Start of RAM variables 
            
;*****************************************************************************************
;----------------------------- RS232 Real Time Variables --------------------------------- 
;   Zero page ordered list continuously updated to Tuner Studio
;*****************************************************************************************
;*****************************************************************************************
; - Seconds counter variables
;*****************************************************************************************
	
SecH:         ds 1 ; RTI seconds count Hi byte (offset=0)(Address $2000) 
SecL:         ds 1 ; RTI seconds count Lo byte (offset=1)(Address $2001)

;*****************************************************************************************
; - ADC variables
;*****************************************************************************************

batAdc:        ds 2 ; Battery Voltage 10 bit ADC AN00(offset=2)(Address $2002) 
BatVx10:       ds 2 ; Battery Voltage (Volts x 10)(offset=4)(Address $2004) 
cltAdc:        ds 2 ; 10 bit ADC AN01 Engine Coolant Temperature ADC(offset=6)(Address $2006) 
Cltx10:        ds 2 ; Engine Coolant Temperature (Degrees F x 10)(offset=8)(Address $2008)
matAdc:        ds 2 ; 10 bit ADC AN02 Manifold Air Temperature ADC(offset=10)(Address $200A) 
Matx10:        ds 2 ; Manifold Air Temperature (Degrees F x 10)(offset=12)(Address $200C) 
PAD03inAdc:    ds 2 ; 10 bit ADC AN03 Spare Temperature ADC(offset=14)(Address $200E) 
TpsPctx10last: ds 2 ; Throttle Position Sensor percent last(offset=16)(Address $2010)
mapAdc:        ds 2 ; 10 bit ADC AN04 Manifold Absolute Pressure ADC(offset=18)(Address $2012) 
Mapx10:        ds 2 ; Manifold Absolute Pressure (KPAx10)(offset=20)(Address $2014)
tpsAdc:        ds 2 ; 10 bit ADC AN05 Throttle Position Sensor ADC (exact for TS)(offset=22)(Address $2016)
TpsPctx10:     ds 2 ; Throttle Position Sensor % of travel(%x10)(update every 100mSec)(offset=24)(Address $2018)
egoAdc1:       ds 2 ; 10 bit ADC AN06 Exhaust Gas Oxygen ADC Left bank odd cyls(offset=26)(Address $201A)
afr1x10:       ds 2 ; Air Fuel Ratio for gasoline Left bank odd cyls(AFR1x10)(offset=28)(Address $201C)
baroAdc:       ds 2 ; 10 bit ADC AN07 Barometric Pressure ADC(offset=30)(Address $201E) 
Barox10:       ds 2 ; Barometric Pressure (KPAx10)(offset=32)(Address $2020)
eopAdc:        ds 2 ; 10 bit ADC AN08 Engine Oil Pressure ADC(offset=34)(Address $2022) 
Eopx10:        ds 2 ; Engine Oil Pressure (PSI x 10)(offset=36)(Address $2024)
efpAdc:        ds 2 ; 10 bit ADC AN09 Engine Fuel Pressure ADC(offset=38)(Address $2026)
Efpx10:        ds 2 ; Engine Fuel Pressure (PSI x 10)(offset=40)(Address $2028) 
itrmAdc:       ds 2 ; 10 bit ADC AN10 Ignition Trim ADC(offset=42)(Address $202A)
Itrmx10:       ds 2 ; Ignition Trim (degrees x 10)+-20 degrees) (offset=44)(Address $202C)
ftrmAdc:       ds 2 ; 10 bit ADC AN11 Fuel Trim ADC(offset=46)(Address $202E)
Ftrmx10:       ds 2 ; Fuel Trim (% x 10)(+-20%)(offset=48)(Address $2030)
egoAdc2:       ds 2 ; 10 bit ADC AN12  Exhaust Gas Oxygen ADC Right bank even cyls(offset=50)(Address $2032)   
afr2x10:       ds 2 ; Air Fuel Ratio for gasoline Right bank even cyls(AFR2x10) (offset=52)(Address $2034)          

;*****************************************************************************************
; - Input capture variables 
;*****************************************************************************************

CASprd512:    ds 2 ; Crankshaft Angle Sensor period (5.12uS time base(offset=54)(Address $2036)
CASprd256:    ds 2 ; Crankshaft Angle Sensor period (2.56uS time base(offset=56)(Address $2038)     NOT USED 2/28/22 
FDcnt:        ds 2 ; Fuel delivery pulse width total(ms)(for totalizer pulse on rollover) (offset=58)(Address $203A) 
RPM:          ds 2 ; Crankshaft Revolutions Per Minute(offset=60)(Address $203C) 
KPH:          ds 2 ; Vehicle speed (KpH x 10)(offset=62)(Address $203E) 

;*****************************************************************************************
; - Fuel calculation variables
;*****************************************************************************************

ASEcnt:        ds 2 ; Counter for "ASErev"(offset=64)(Address $2040)
AFRcurr:       ds 2 ; Current value in AFR table (AFR x 100)(offset=66)(Address $2042) 
VEcurr:        ds 2 ; Current value in VE table (% x 10)(offset=68)(Address $2044) 
barocor:       ds 2 ; Barometric Pressure Correction (% x 10)(offset=70)(Address $2046)
matcor:        ds 2 ; Manifold Air Temperature Correction (% x 10)(offset=72)(Address $2048) 
WUEcor:        ds 2 ; Warmup Enrichment Correction (% x 10)(offset=74)(Address $204A)
ASEcor:        ds 2 ; Afterstart Enrichmnet Correction (% x 10)(offset=76)(Address $204C)
WUEandASEcor:  ds 2 ; the sum of WUEcor and ASEcor (% x 10)(offset=78)(Address $204E)
Crankcor:      ds 2 ; Cranking pulsewidth temperature correction (% x 10)(offset=80)(Address $2050)
TpsPctDOT:     ds 2 ; TPS difference over time (%/Sec)(update every 100mSec)(offset=82)(Address $2052)
TpsPctDOTlast: ds 2 ; TPS difference over time last (%/Sec)(update every TOE routine)(offset=84)(Address $2054)            
TOEpct:        ds 2 ; Throttle Opening Enrichment (%)(offset=86)(Address $2056)
TOEpw:         ds 2 ; Throttle Opening Enrichment adder (mS x 100)(offset=88)(Address $2058)
PWlessTOE:     ds 2 ; Injector pulse width before "TOEpw" and "Deadband" (mS x 10)(offset=90)(Address $205A)
Deadband:      ds 2 ; injector deadband at current battery voltage mS*100(offset=92)(Address $205C) 
PrimePW:       ds 2 ; Primer injector pulswidth (mS x 10)(offset=94)(Address $205E)
CrankPW:       ds 2 ; Cranking injector pulswidth (mS x 10)(offset=96)(Address $2060)
FDpw:          ds 2 ; Fuel Delivery pulse width (PW - Deadband) (mS x 10)(offset=98)(Address $2062)
PW:            ds 2 ; Running engine injector pulsewidth (mS x 10)(offset=100)(Address $2064)
LpH:           ds 2 ; Fuel burn Litres per hour(offset=102)(Address $2066)
FDsec:         ds 2 ; Fuel delivery pulse width total over 1 second (mS x 10)(offset=104)(Address $2068)
GearCur:       ds 1 ; Current transmission gear(offset=106)(Address $206A)
TOEdurCnt:     ds 1 ; Throttle Opening Enrichment duration counter(offset=107)(Address $206B)
FDt:           ds 2 ; Fuel Delivery pulse width total(mS x 10) (for FDsec calcs)(offset=108)(Address $206C)

;*****************************************************************************************
;*****************************************************************************************
; - Ignition calculation variables
;*****************************************************************************************
	 
STcurr:         ds 2 ; Current value in ST table (Degrees x 10)(offset=110)(Address $206E)
KmpL:           ds 2 ; Fuel burn kilometers per litre(offset=112)(Address $2070) 
DwellCor:       ds 2 ; Coil dwell voltage correction (%*10)(offset=114)(Address $2072)
DwellFin:       ds 2 ; ("Dwell" * "DwellCor") (mS*10)(offset=116)(Address $2074)
STandItrmx10:   ds 2 ; stCurr and Itmx10 (degrees*10)(offset=118)(Address $2076)

;*****************************************************************************************
;*****************************************************************************************
; - Port status variables
;*****************************************************************************************

PortAbits:    ds 1  ; Port A status bit field(offset=120)(Address $2078)
PortBbits:    ds 1  ; Port B status bit field(offset=121)(Address $2079) 
PortKbits:    ds 1  ; Port K status bit field(offset=122)(Address $207A) 
PortPbits:    ds 1  ; Port P status bit field(offset=123)(Address $207B) 
PortTbits:    ds 1  ; Port T status bit field(offset=124)(Address $207C)
 
;*****************************************************************************************
; - Misc variables 
;*****************************************************************************************

engine:       ds 1  ; Engine status bit field(offset=125)(Address $207D) 
engine2:      ds 1  ; Engine2 status bit field(offset=126)(Address $207E)
ColdAddPW:    ds 2  ; TOE cold adder pulse width (mSx10)(offset=127)(Address $207F)
StateStatus:  ds 1  ; State status bit field(offset=129)(Address $2081) 
LoopTime:     ds 2  ; Program main loop time (loops/Sec)(offset=130)(Address $2082)
DutyCyclex10: ds 2  ; Injector duty cycle in run mode (% x 10)(offset=132)(Address $2084)
MpG:          ds 2  ; Fuel burn miles per gallon Imperial (offset=134)(Address $2086)
TestValw:     ds 2  ; Word test value (for program developement only)(offset=136)(Address $2088)
TestValb:     ds 1  ; Byte test value (for program developement only)(offset=138)(Address $208A)

;*****************************************************************************************
; - More fuel calculation variables variables 
;*****************************************************************************************

ColdAddpct:   ds 2 ; Throttle Opening Enrichment cold adder (%)(offset=139)(Memory location $208B) 
ColdMulpct:   ds 2 ; Throttle Opening Enrichment cold multiplier (%)(offset=141)(Memory location $208D)  
TOEandCMpct:  ds 2 ; TOE and Cold Multiplier percent (%)(offset=143)(Memory location $208F)
TOEandCMPW:   ds 2 ; TOE and ColdMultiplier pulse width (mSx10)(offset=145)(Memory location $2091)
TpsDOTmax:    ds 2 ; TPS DOT maximum for TOE calculations (%/Sec)(offset=147)(Memory location $2093)

;*****************************************************************************************
;*****************************************************************************************
; - This marks the end of the real time variables (149 bytes in total)
;*****************************************************************************************
;*****************************************************************************************
; --------------------------------- RS232 equates ----------------------------------------                                                                       
;*****************************************************************************************

;*****************************************************************************************
; - "engine" equates
;*****************************************************************************************
 
;bit1         equ $01   ; %00000001 bit 0, NOT USED
crank        equ  $02 ; %00000010, bit 1, In Crank Mode
run          equ  $04 ; %00000100, bit 2, In Run Mode
ASEon        equ  $08 ; %00001000, bit 3, In ASE Mode
WUEon        equ  $10 ; %00010000, bit 4, In WUE Mode
TOEon        equ  $20 ; %00100000, bit 5, In Throttle Opening Enrichment Mode 
OFCon        equ  $40 ; %01000000, bit 6, In Overrun Fuel Cut Mode
FldClr       equ  $80 ; %10000000, bit 7, In Flood Clear Mode
										
;*****************************************************************************************
;*****************************************************************************************
; "engine2" equates
;*****************************************************************************************

base512        equ $01 ; %00000001, bit 0, In Timer Base 512 mode         NOT USED 1/19/22
base256        equ $02 ; %00000010, bit 1, In Timer Base 256 Mode         NOT USED 1/19/22
;bit2           equ $04 ; %00000100, bit 2, NOT USED
TOEduron       equ $08 ; %00001000, bit 3, In Throttle Opening Enrichment Duration Mode
ErsBrn         equ $10 ; %00010000, bit 4, Erase and burn commanded (Set in SCI0)
IgnRun         equ $20 ; %00100000, bit 5, Ignition calculations state(0 = cranking, no calcs 1 = running, do calcs
RunModeOn      equ $40 ; %01000000, bit 6, Run Mode confirmation (0 = not confirmed,1 = confirmed)
;bit7           equ $80 ; %10000000, bit 7,                                       NOT USED

;*****************************************************************************************
;*****************************************************************************************
; - "StateStatus" equates 
;*****************************************************************************************

Synch            equ    $01  ; %00000001, bit 0, Crank Position Synchronized
SynchLost        equ    $02  ; %00000010, bit 1, Crank Position Synchronize Lost
StateNew         equ    $04  ; %00000100, bit 2, New Crank Position               NOT USED
;bit3             equ    $08  ; %00001000, bit 3,                                 NOT USED
;bit4             equ    $10  ; %00010000, bit 4,                                 NOT USED
;bit5             equ    $20  ; %00100000, bit 5,                                 NOT USED
;bit6             equ    $40  ; %01000000, bit 6,                                 NOT USED
;bit7             equ    $80  ; %10000000, bit 7,                                 NOT USED 
								
;*****************************************************************************************
; PortAbits: Port A status bit field (PORTA)
;*****************************************************************************************

PA0in           equ  $01 ;(PA0)%00000001, bit 0, PA0 momentary contact input on PCB
Itrimen         equ  $02 ;(PA1)%00000010, bit 1, Ignition Trim Enable
Ftrimen         equ  $04 ;(PA2)%00000100, bit 2, Fuel Trim Enable
IdleSpdRaise    equ  $08 ;(PA3)%00001000, bit 3, Idle Speed Raise Enable
OFCen           equ  $10 ;(PA4)%00010000, bit 4, Overrun Fuel Cut Enable
OFCdis          equ  $20 ;(PA5)%00100000, bit 5, Overrun Fuel Cut Disable
IdleSpdLower    equ  $40 ;(PA6)%01000000, bit 6, Idle Speed Lower Enable
;bit7            equ  $80 ;(PA7)%10000000, bit 7,                                 NOT USED

;*****************************************************************************************
;*****************************************************************************************
; PortBbits: Port B status bit field (PORTB)
;*****************************************************************************************

FuelPump    equ  $01 ;(PB0)%00000001, bit 0, Fuel Pump State
ASDRelay    equ  $02 ;(PB1)%00000010, bit 1, Automatic Shutdown Relay State
PB2out      equ  $04 ;(PB2)%00000100, bit 2, PB2 output spare State
AIOT        equ  $08 ;(PB3)%00001000, bit 3, Accumulated Injector On Time Signal State
Tachout     equ  $10 ;(PB4)%00010000, bit 4, Tachometer output State
PB5out      equ  $20 ;(PB5)%00100000, bit 5, Crank Synch Indicator State(0 = crank synched, 1 = crank not synched)
PB6out      equ  $40 ;(PB6)%01000000, bit 6, PB6 output spare State
;bit7        equ  $80 ; PB7)%10000000, bit 7,                                     NOT USED

;*****************************************************************************************
;*****************************************************************************************
; PortKbits: Port K status bit field (PORTK) (PK6 not available on 112 LQFP)
;*****************************************************************************************
 
PK0out     equ  $01 ;(PK0)%00000001, bit 0, PK0 output spare State
PK1out     equ  $02 ;(PK1)%00000010, bit 1, PK1 output spare State
A4988Step  equ  $04 ;(PK2)%00000100, bit 2, A4988 Step pin7
PK3out     equ  $08 ;(PK3)%00001000, bit 3, PK3 output spare State
A4988Dir   equ  $10 ;(PK4)%00010000, bit 4, A4988 Direction pin8
A4988En    equ  $20 ;(PK5)%00100000, bit 5, A4988 Enable pin1
PK7out     equ  $80 ;(PK7)%10000000, bit 7, PK7 output spare State

;*****************************************************************************************
;*****************************************************************************************
; PortPbits: Port P status bit field (PTP)(Tim1 Output Compare Channels)
;***************************************************************************************** 

Inj1      equ $01 ;(PP0)%00000001, bit 0, Inj1(1&10)
Inj2      equ $02 ;(PP1)%00000010, bit 1, Inj2(9&4)
Inj3      equ $04 ;(PP2)%00000100, bit 2, Inj3(3&6)
Inj4      equ $08 ;(PP3)%00001000, bit 3, Inj4(5&8)
Inj5      equ $10 ;(PP4)%00010000, bit 4, Inj5(7&2)
PP5out    equ $20 ;(PP5)%00100000, bit 5,
;bit6      equ $40 ;(PP6)%01000000, bit 6,                                        NOT USED
;bit7      equ $80 ;(PP7)%10000000, bit 7,                                        NOT USED 

;*****************************************************************************************
;*****************************************************************************************
; PortTbits: Port T status bit field (PTT)(Enhanced Capture Channels)
;*****************************************************************************************

CMP        equ $01 ;(PT0)%00000001, bit 0, Camshaft Position
CKP        equ $02 ;(PT1)%00000010, bit 1, Crankshaft Position
VSpd       equ $04 ;(PT2)%00000100, bit 2, Vehicle Speed
Ign1       equ $08 ;(PT3)%00001000, bit 3, Ign1 (1&6) 
Ign2       equ $10 ;(PT4)%00010000, bit 4, Ign2 (10&5)
Ign3       equ $20 ;(PT5)%00100000, bit 5, Ign3 (9&8)
Ign4       equ $40 ;(PT6)%01000000, bit 6, Ign4 (4&7)
Ign5       equ $80 ;(PT7)%10000000, bit 7, Ign5 (3&2)

;*****************************************************************************************
;*****************************************************************************************
; ------------------------------- Non RS232 variables ------------------------------------
;*****************************************************************************************
;*****************************************************************************************
; - Real Time Interrupt variables 
;*****************************************************************************************

uSx125:     ds 1 ; 125 microsecond counter (offset=149)(Address $2095)             NOT USED
mS:         ds 1 ; 1 millisecond counter (offset=150)(Address $2096)
mSx100:     ds 1 ; 100 millisecond counter (offset=151)(Address $2097)
clock:      ds 1 ; Time rate flag marker bit field (offset=152) (Address $2098)

;*****************************************************************************************
; - "clock" equates 
;*****************************************************************************************

ms1        equ $01   ; %00000001 (Bit 0) (1mS marker)
ms100      equ $02   ; %00000010 (Bit 1) (100mS marker)
ms250      equ $04   ; %00000100 (Bit 2) (250mS marker)                           NOT USED
ms500      equ $08   ; %00001000 (Bit 3) (500mS marker)
ms1000     equ $10   ; %00010000 (Bit 4) (seconds marker)
ms20       equ $20   ; %00100000 (Bit 5) (20mS marker)
;bit6       equ $40  ; %01000000, bit 6,                                          NOT USED
;bit7       equ $80  ; %10000000, bit 7,                                          NOT USED 

;*****************************************************************************************
; - Serial Communications Interface variables
;*****************************************************************************************

txgoalMSB:    ds 1 ; SCI number of bytes to send/rcv Hi byte (offset=153) (Address $2099)
txgoalLSB:    ds 1 ; SCI number of bytes to send/rcv Lo byte (offset=154) (Address $209A)
txcnt:        ds 2 ; SCI count of bytes sent/rcvd (offset=155) (Address $209B)
rxoffsetMSB:  ds 1 ; SCI offset from start of page Hi byte (offset=157) (Address $209D)
rxoffsetLSB:  ds 1 ; SCI offset from start of page lo byte (offset=158) (Address $209E)
rxmode:       ds 1 ; SCI receive mode selector (offset=159) (Address $209F) 
txmode:       ds 1 ; SCI transmit mode selector (offset=160) (Address $20A0)
pageID:       ds 1 ; SCI page identifier (offset=161) (Address $20A1)
txcmnd:       ds 1 ; SCI command character (offset=162) identifier (Address $20A2)
dataMSB:      ds 1 ; SCI data Most Significant Byte received (offset=163) (Address $20A3)
dataLSB:      ds 1 ; SCI data Least Significant Byte received (offset=164) (Address $20A4) 

;*****************************************************************************************
; - Ignition calculations variables
;*****************************************************************************************

Spantk:         ds 2 ; Ignition Span time (5.12uS or 2.56uS res) (offset=165) (Address $20A5)
DwellFintk:     ds 2 ; Time required for dwell after correction (5.12uS or 2.56uS res) (offset=167) (Address $20A7)
STandItrmtk:    ds 2 ; STcurr and Itmx10 (5.12uS or 2.56uS res)  (offset=169) (Address $20A9)  
Advancetk:      ds 2 ; Delay time for desired spark advance + dwell(5.12uS or 2.56uS res) (offset=171) (Address $20AB)
Delaytk:        ds 2 ; Delay time from crank signal to energise coil(5.12uS or 2.56uS res) (offset=173) (Address $20AD)
IgnOCadd1:      ds 2 ; First ignition output compare adder (5.12uS or 2.56uS res) (offset=175) (Address $20AF)
IgnOCadd2:      ds 2 ; Second ignition output compare adder(5.12uS or 2.56uS res) (offset=177) (Address $20B1)

;*****************************************************************************************
; - Injection calculations variables
;*****************************************************************************************

DdBndZ1:       ds 2 ; Deadband interpolation Z1 value (offset=179) (Address $20B3)
DdBndZ2:       ds 2 ; Deadband interpolation Z2 value (offset=181) (Address $20B5)
PWcalc1:       ds 2 ; PW calculations result 1 (offset=183) (Address $20B7)
PWcalc2:       ds 2 ; PW calculations result 2 (offset=185) (Address $20B9)
PWcalc3:       ds 2 ; PW calculations result 3 (offset=187) (Address $20BB)
PWcalc4:       ds 2 ; PW calculations result 4 (offset=189) (Address $20BD)
PWcalc5:       ds 2 ; PW calculations result 5 (offset=191) (Address $20BF)
ASErev:        ds 2 ; Afterstart Enrichment Taper (revolutions) (offset=193) (Address $20C1)
PrimePWtk:     ds 2 ; Primer injector pulswidth timer ticks(uS x 5.12) (offset=195) (Address $20C3)
CrankPWtk:     ds 2 ; Cranking injector pulswidth timer ticks(uS x 5.12) (offset=197) (Address $20C5)
PWtk:          ds 2 ; Running injector pulsewidth timer ticks(uS x 2.56) (offset=199) (Address $20C7)
InjOCadd1:     ds 2 ; First injector output compare adder (5.12uS res or 2.56uS res) (offset=201) (Address $20C9)
InjOCadd2:     ds 2 ; Second injector output compare adder (5.12uS res or 2.56uS res) (offset=203) (Address $20CB)
Place205:      ds 2 ; Place holder(offset=205) (Address $20CD) 
AIOTcnt:       ds 1 ; Counter for AIOT totalizer pulse width  (offset=207)(Address $20CF)

;*****************************************************************************************
; - State machine variables 
;*****************************************************************************************

State:        ds 1  ; Cam-Crank state machine current state (offset=208) (Address $000020D0) 

;*****************************************************************************************
; - Input capture variables 
;*****************************************************************************************

VSS1st:      ds 2  ; VSS input capture rising edge 1st time stamp (5.12uS or 2.56uS res) (offset=209) (Address $20D1)
CAS1sttk:    ds 2  ; CAS input capture rising edge 1st time stamp ((5.12uS or 2.56uS res) (offset=211) (Address $20D3)
CAS2ndtk:    ds 2  ; CAS input capture rising edge 2nd time stamp (5.12uS or 2.56uS res) (offset=213) (Address $20D5)
CASprd1tk:   ds 2  ; Period between CAS1st and CAS2nd (5.12uS or 2.56uS res) (offset=215) (Address $20D7)
CASprd2tk:   ds 2  ; Period between CAS2nd and CAS3d ((5.12uS or 2.56uS res) (offset=217) (Address $20D9)
Degx10tk512: ds 2  ; Time to rotate crankshaft 1 degree in 5.12uS resolution x 10 (offset=219) (Address $20DB)
InjPrFlo:    ds 2  ; Injector pair flow rate in CC/Min (from InjPrFlo_F) (offset=221) (Address $20DD)          
RevCntr:     ds 1  ; Counter for "Revmarker" flag (offset=223) (Address $20DF)
Stallcnt:    ds 2  ; No crank or stall condition counter (1mS increments) (offset=224) (Address $20E0)
ICflgs:      ds 1  ; Input Capture flags bit field (offset=227) (Address $20E2)

;*****************************************************************************************
; - "ICflgs" equates 
;*****************************************************************************************

RPMcalc    equ $01   ; %00000001 (Bit 0) (Do RPM calculations flag)
KpHcalc    equ $02   ; %00000010 (Bit 1) (Do VSS calculations flag)
Ch1_2nd    equ $04   ; %00000100 (Bit 2) (Ch1 2nd edge flag)
Ch2alt     equ $08   ; %00001000 (Bit 3) (Ch2 alt flag)
Ch1_3d     equ $10   ; %00010000 (Bit 4) (Ch1 3d edge flag)
RevMarker  equ $20   ; %00100000 (Bit 5) (Crank revolution marker flag)
;bit6       equ $40  ; %01000000, bit 6,                                          NOT USED
;bit7       equ $80  ; %10000000, bit 7,                                          NOT USED

;*****************************************************************************************
; - 2D Lookup variables 
;*****************************************************************************************							  

CrvPgPtr:   ds 2 ; Pointer to the page where the desired curve resides (offset=228) (Address $20E3)
CrvRowOfst: ds 2 ; Offset from the curve page to the curve row (offset=230) (Address $20E5)
CrvColOfst: ds 2 ; Offset from the curve page to the curve column (offset=232)  (Address $20E7)
CrvCmpVal:  ds 2 ; Curve comparison value for interpolation (offset=234) (Address $20E9)
CrvBinCnt:  ds 1 ; Number of bins in the curve row or column minus 1 (offset=236) (Address $20EB)
IndexNum:   ds 1 ; Position in the row or column of the curve comparison value (offset=237) (Address $20EC) 
CrvRowHi:   ds 2 ; Curve row high boundry value for interpolation (offset=238) (Address $20ED)
CrvRowLo:   ds 2 ; Curve row low boundry value for interpolation (offset=240) (Address $20EF)
CrvColHi:   ds 2 ; Curve column high boundry value for interpolation (offset=242) (Address $20F1)
CrvColLo:   ds 2 ; Curve column low boundry value for interpolation (offset=244) (Address $20F3)

;*****************************************************************************************

;***************************************************************************************** 
; - Misc variables 
;*****************************************************************************************

LoopCntr:    ds 2 ; Counter for "LoopTime" (offset=246)(Address $20F5) (incremented every Main Loop pass)
tmp1w:       ds 2 ; Temporary word variable #1 (offset=248)(Address $20E7)
tmp2w:       ds 2 ; Temporary word variable #2 (offset=250)(Address $20F9)
tmp3w:       ds 2 ; Temporary word variable #3 (offset=252)(Address $20FB)
tmp4w:       ds 2 ; Temporary word variable #4 (offset=254)(Address $20FD)
tmp5b:       ds 1 ; Temporary byte variable #5 (offset=256)(Address $20FF)
tmp6b:       ds 1 ; Temporary byte variable #6 (offset=257)(Address $20F8)
tmp7b:       ds 1 ; Temporary byte variable #7 (offset=258)(Address $20F9)
tmp8b:       ds 1 ; Temporary byte variable #8 (offset=259)(Address $20FA)
GearKCur:    ds 2 ; Variable for current gear K factor calculations (offset=260)(Address $20FB)
baroADCsum:  ds 2 ; Variable for "baroADC" averaging sum (offset=262)(Address $20FD)
baroADCcnt:  ds 1 ; Counter for "baroADC" averaging (offset=264)(Address $20FF)
BurnCnt:     ds 2 ; Counter for bytes burnt in Flash erase and burn routine (offset=265)(Address $2100)
egoADC1sum:  ds 2 ; Variable for "egoADC1" averaging sum (offset=267)(Address $2102)
egoADC1cnt:  ds 1 ; Counter for "egoADC1" averaging (offset=269)(Address $2104) 
egoADC2sum:  ds 2 ; Variable for "egoADC2" averaging sum (offset=270)(Address $2105)
egoADC2cnt:  ds 1 ; Counter for "egoADC2" averaging (offset=272)(Address $2107) 
RPMaddend:   ds 2 ; Addend variable for RPM averaging (offset=273)(Address $2108) NOT USED
RPMsum:      ds 2 ; Variable for "RPM" averaging sum (offset=275)(Address $210A)  NOT USED
RPMcnt:      ds 1 ; Counter for "RPM" averaging (offset=277)(Address $210C)       NOT USED

;*****************************************************************************************
;*****************************************************************************************
; - Interpolation variables
;*****************************************************************************************

interpV:  ds 2 ; Interpolation variable "V" (offset=278) (Address $210D)
interpV1: ds 2 ; Interpolation variable "V1"(offset=280) (Address $210F)
interpV2: ds 2 ; Interpolation variable "V2"(offset=282) (Address $2111)
interpZ:  ds 2 ; Interpolation variable "Z"(offset=284) (Address $2113)
interpZ1: ds 2 ; Interpolation variable "Z1"(offset=286) (Address $2115)
interpZ2: ds 2 ; Interpolation variable "Z2"(offset=288) (Address $2117)

;*****************************************************************************************

;*****************************************************************************************
; Late additional variables 
;*****************************************************************************************

ASEstart:      ds 2 ; Initial value for ASEcor interpolation from ASE cor table(offset=290) (Address $2119)
VSSprd512:     ds 2 ; VSS period for 5.12uS time base(offset=292) (Address $211B)
VSScnt:        ds 2 ; Counter to detect vehicle stopped condition (Address $211D) 
MinCKP:        ds 1 ; Minimum CKP triggers before RPM period calculations(offset=295) (Address $211F)
efpADCsum:     ds 2 ; Variable for "efpADC" averaging sum (offset=296)(Address $2120)
efpADCcnt:     ds 1 ; Counter for "efpADC" averaging (offset=298)(Address $2122)  

;*****************************************************************************************
; - 3DLUT  variables (future use maybe)
;*****************************************************************************************


;TabPoint:  ds 2 ; Table pointer (offset=296) (Address $211F)
;ColVal:    ds 2 ; Column value ((offset=298) (Address $2121)
;RowVal:    ds 2 ; Row value (offset=300) (Address $2123)
;LowColVal: ds 2 ; Lower column value (offset=302) (Address $2125)
;UpColVal:  ds 2 ; Upper column value (offset=304) (Address $2127)
;LowRowPtr: ds 2 ; Lower row pointer (offset=306) (Address $2129)
;UpRowPtr:  ds 2 ; Upper row pointer (offset=308) (Address $212B)
;LowRowVal: ds 2 ; Lower row value (offset=310) (Address $212D)
;UpRowVal:  ds 2 ; Upper row value (offset=312) (Address $212F)
;Zll:       ds 2 ; Interpolation Z low low (offset=314) (Address $2131)
;Zlh:       ds 2 ; Interpolation Z low high (offset=316) (Address $2133)
;Zhl:       ds 2 ; Interpolation Z high low ((offset=318) (Address $2135)
;Zhh:       ds 2 ; Interpolation Z high high (offset=320) (Address $2137)
;Zl:        ds 2 ; Interpolation Z low (offset=322) (Address $2139)
;Zh:        ds 2 ; Interpolation Z high (offset=324) (Address $213B)

;*****************************************************************************************
; - 3DLUT table parameters for VE, ST and AFR 3D tables. 
;*****************************************************************************************

ROW_COUNT		equ	$10    ; Number of rows in table (16 = $10)
COL_COUNT		equ	$10    ; Number of columns in table (16 = $10)
ROW_BIN_OFFSET  equ $200   ; Row bin offset from start of table (512 = $200)
COL_BIN_OFFSET  equ $220   ; Column bin offset from start of table (544 = $220)

;*****************************************************************************************

           ORG VEStart  ; Start of first page of configurable constants
                        ; Memory location $2400
                        
 veBins_R:  ds 1024     ; 1024 bytes reserved for configurable conatans starting with 
                        ; the VE table
                        
          ORG STStart   ; Start of first page of configurable constants
                        ; Memory location $2800
                        
 stBins_R:  ds 1024     ; 1024 bytes reserved for configurable conatans starting with 
                        ; the ST table
                        
         ORG AFRStart   ; Start of first page of configurable constants
                        ; Memory location $2C00
                        
 afrBins_R:  ds 1024    ; 1024 bytes reserved for configurable conatans starting with 
                        ; the AFR table
                        
;*****************************************************************************************
;* - NOTE! I CAN'T GET MY BURNER CODE TO WORK WITH TUNER STUDIO SO I'M COMMENTING IT OUT
;*****************************************************************************************
                        
;         ORG $3800      ; Flash erase and burn Send_Command subroutine
;         
;Send_Command:                 ; Subroutine to send Flash erase or burn command (this has 
;                              ; to operate from RAM)
;
;    bset FSTAT,$80            ; Set FSTAT CCIF bit7 to start the subroutine. The bit is 
;                              ; cleared during the routine and set again when completed 
;    
;FSTATwait:    
;    brclr FSTAT,$80,FSTATwait ; Check the state of CCIF and loop here until it is set again
;    rts                       ; Return from subroutine
    

;*****************************************************************************************                         
;                     FLASH CODE SECTION address $4000 to $8000
;*****************************************************************************************
;*****************************************************************************************
; - Pre main loop subsection
;   - Initialize CPU modules
;   - Initialize ISR vectors
;   - Copy configurable constants from Flash to Ram
;   - Clear and initialize all variables
;   - Start ATD0, read ADCs and convert to user units
;   - Deadband calculations
;   - Fire injectors prime pulse
;   - Set up for main loop
;   - After Start Enrichment and taper lookup
;*****************************************************************************************                         

            ORG   ROMStart  ;Memory location  $4000 
 
Entry:                      ; This is the entry point at start up and after reset

    LDS   #RAMEnd+1         ; Initialize the stack pointer address $3FFF+1
	
;*****************************************************************************************
; - Make sure we are in Single Chip Mode MODA/PE5 and MODB/PE6 are hard wired to ground, 
;   MODC/BKGD has a 10k pullup to VDD
;*****************************************************************************************

    ldaa  #$80      ; Load Acc A with the value in MODC bit 7 of Mode Register
    staa  MODE      ; Copy to Mode Register (lock MODE register into NSC  
                    ;(normal single chip mode)

    clr  IRQCR      ; Disable IRQ (won't run without this) 
                                  
;*****************************************************************************************                         
;                              INITIALIZATION SUBSECTION
;*****************************************************************************************

;*****************************************************************************************
; - Initialize the the clock generator and Phase Lock Loop for 50 Mhz 
;   Bus Clock frequency.(See pages 473, 474 and 486,487)
;   
;   SYSCLK (bus clock) is half of selected source clock, either OSCCLK
;   or PLLCLK.The PLLCLK frequency is:
;   PLLCLCK = 2 * OSCCLK * (SYDIV + 1) / REFDIV + 1)
;   We are using a 16 Mhz crystal oscilator for OSCCLK, So if SYNDIV 
;   = 24 and REFDIV = 7 then PLLCLCK will be (2 * 16000000 *25) / 8 = 
;   100 Mhz. PLLCLK / 2 = 50 Mhz. Bus Clock.
;   From table 11-2 for 100MHz VCO clock VCOFRQ[1:0] = 11 so 
;   so SYNR = %11011000 = $D8
;   From table 11-3 for 2MHz REFLCK frequency REFFRQ[1:0] = 00 so 
;   so REFDV = %00000111 = $07
;*****************************************************************************************

    movb  #$FF,CRGFLG    ; Clear all flags
    movb  #$07,REFDV     ; Load "REFDV" with %00000111
    movb  #$D8,SYNR      ; Load "SYNR" with %11011000
    brclr CRGFLG,$08,*+0 ; Loop until "LOCK" flag bit3 is cleared
    bset  CLKSEL,$80     ; Set "PLL Select" bit7 to derive system clocks from "PLLCLK"

;*****************************************************************************************
; - Initialize Analog to Digital Converter (ATD0) for continuous conversions
;   8.3MHz ATDCLK period = 0.00000012048 Sec.
;   10 bit ATD Conversion period = 41 ATDCLK cycles(ref page 1219) 
;   Sample time per channel = 24+2 for discharge capacitor = 26 ATDCLK cycles
;   Sample time for 13 channels = (41+26)x13=871 ATDCLK periods = 0.000114810 Sec. (~115uS)
;*****************************************************************************************

    movw  #$1FFF,PT0AD0     ; Load Port AD0 Data Registers PT0AD0:PT1AD0
                            ; with %0001111111111111 (General Purpose I/Os on pins 15,14,13
                            ; ATD on pins 12,11,10,9,8,7,6,5,4,3,2,1,0)
                            ;(Registers are %00000000 out of reset)

    movw  #$E000,DDR0AD0    ; Load Port AD0 Data Direction Registers DDR0AD0:DDR1AD0
                            ; with %1110000000000000 (Outputs on pins 15,14,13
                            ; ATD on pins 12,11,10,9,8,7,6,5,4,3,2,1,0)
                            ;(Registers are %00000000 out of reset)

    movw  #$E000,PER0AD0    ; Load Port AD0 Pullup Enable Registers PER0AD0:PER1AD0
                            ; with %1110000000000000 (Pullups enabled on pins 15,14,13
                            ; Pullups disabled on pins 12,11,10,9,8,7,6,5,4,3,2,1,0)
                            ;(Registers are %00000000 out of reset)
                            
    movb  #$0C,ATD0CTL0     ; Load ATD0 Control Register 0 with %00001100
                            ; (wrap after converting AN12)
			                      ;             ^  ^ 
			                      ;    WRAP-----+--+
                            ;(Register is %00001111 out of reset)                            
                                
    movb  #$30,ATD0CTL1     ; Load ATD Control Register 1 with %00110000
                            ; (no external trigger, 10 bit resolution, 
                            ; discharge cap before conversion)
                            ;         ^^^^^  ^ 
                            ;ETRIGSEL-+||||  | 
                            ;    SRES--++||  | 
                            ; SMP_DIS----+|  | 
                            ; ETRIGCH-----+--+
                            ;(Register is %00001111 out of reset)
                            
    movb  #$20,ATD0CTL2    ; Load ATD Control Register 2 with %00100000 
                           ;(no fast flag clear, continue in stop, 
                           ; no external trigger, Sequence 
                           ; complete interrupt disabled,
                           ; Compare interrupt disabled)
                           ;          ^^^^^^^ 
                           ;    AFFC--+|||||| 
                           ; ICLKSTP---+||||| 
                           ; ETRIGLE----+|||| 
                           ;  ETRIGP-----+||| 
                           ;  ETRIGE------+|| 
                           ;   ASCIE-------+| 
                           ;  ACMPIE--------+;
                           ;(Register is %00000000 out of reset)
                        
                          
    movb  #$82,ATD0CTL3 ; Load ATD Control Register 3 with %10000010
                        ;(right justifed data, 16 conversions,
                        ; no Fifo, Finish conversion before stop in freeze)
                        ;         ^^^^^^^^ 
                        ;     DJM-+||||||| 
                        ;     S8C--+|||||| 
                        ;     S4C---+|||||
                        ;     S2C----+|||| 
                        ;     S1C-----+||| 
                        ;    FIFO------+|| 
                        ;     FRZ-------++
                        ;(Register is %00100000 out of reset) 
                         
    movb  #$E2,ATD0CTL4 ; Load ATD Control Register 4 with %11100010
                        ;(24 cycle sample time, prescale = 2
                        ; for 8.3MHz ATDCLK)
                        ;         ^ ^^   ^
                        ;     SMP-+-+|   | 
                        ;     PRS----+---+
                        ;(Register is %00000101 out of reset)

    movw  #$E000,ATD0DIENH  ; Load ATD0 Input Enable Register Hi byte and Lo byte with 
                            ; %1110000000000000 (Enable input buffer pins 15,14,13
                            ; Disable input buffer pins 12,11,10,9,8,7,6,5,4,3,2,1,0)
                            ;(Register is %0000000000000000 out of reset)
                            
;*****************************************************************************************
; - Initialize Port A. General purpose I/Os. All pins inputs - Page 109
;   (pull-ups enabled at the end of this section)
;***************************************************************************************** 

    clr   DDRA        ; Load %00000000 into Port A Data Direction  
                      ; Register(all pins inputs)
                      
;*****************************************************************************************                         
; - Initialize Port B. General purpose I/Os. all pins outputs - Page 109, 108
;***************************************************************************************** 

    movb  #$FF,DDRB   ; Load %11111111 into Port B Data 
                      ; Direction Register (all pins outputs)
    movb  #$00,PORTB  ; Load %00000000 into Port B Data 
                      ; Register (initialize all pin states low)
                              
;*****************************************************************************************
; - Initialize Port E. General purpose I/Os. Not used, all pins inputs - Page 114
;   (pull-ups enabled at the end of this section)
;***************************************************************************************** 

    clr   DDRE        ; Load %00000000 into Port E Data 
                      ; Direction Register (all pins inputs)
 
;*****************************************************************************************
; - Initialize Port H. General purpose I/Os. Not used, all pins inputs - Page 144, 147
;*****************************************************************************************

    clr   DDRH        ; Load %00000000 into Port H Data Direction  
                      ; Register(all pins inputs)
    movw #$FF00,PERH  ; Load Port H Pull Device Enable  
                      ; Register and Port H Polarity Select  
                      ; Register with %1111111100000000  
                      ; (pull-ups on all pins)

;*****************************************************************************************
; - Initialize Port J. General purpose I/Os.Not used, all pins inputs - Page 150, 153
;*****************************************************************************************

    clr   DDRJ        ; Load %00000000 into Port J Data Direction  
                      ; Register(all pins inputs)
    movw #$FF00,PERJ  ; Load Port J Pull Device Enable  
                      ; Register and Port J Polarity Select  
                      ; Register with %1111111100000000  
                      ; (pull-ups on all pins)

;*****************************************************************************************
; - Initialize Port K. General purpose I/Os. All pins outputs, initialize low - Page 120
;   NOTE! - PK6 not available in 112 pin package.
;*****************************************************************************************

    movb  #$FF,DDRK   ; Load %11111111 into Port K Data 
                      ; Direction Register (all pins outputs)
    movb  #$00,PORTK  ; Load %00000000 into Port K Data 
                      ; Register (initialize all pin states low)

;*****************************************************************************************
; - Initialize Port M. General purpose I/Os. Not used, all pins inputs - 
;   Page 132, 134, 135 PTM0 and PTM1 reserved for RXCAN0 adn TXCAN0
;*****************************************************************************************

    clr   DDRM        ; Load %00000000 into Port M Data Direction  
                      ; Register(all pins inputs)
    movw #$FF00,PERM  ; Load Port M Pull Device Enable  
                      ; Register and Port M Polarity Select  
                      ; Register with %1111111100000000  
                      ; (pull-ups on all pins)

;*****************************************************************************************
; - Initialize Port P. General purpose I/Os. Fuel Injector Control TIM1 OC0 through    
;   OC4, OC5 spare, GPIO outputs pins 6 and 7 
;*****************************************************************************************

    movb  #$FF,DDRP   ; Load %11111111 into Port P Data 
                      ; Direction Register (all pins outputs)
    movb  #$00,PTP    ; Load %00000000 into Port P Data 
                      ; Register (initialize all pin states low)
    movb #$3F,PTRRR   ; Load Port R Routing Register with %00111111 (TIM1 OC channels 
                      ; available on PP5,4,3,2,1,0

;*****************************************************************************************
; - Initialize Port P. General purpose I/Os. all pins outputs
;*     PP0 - TIM1 OC0 Inj1 (1&10)   (output, active high, initialize low)                *   
;*     PP1 - TIM1 OC1 Inj2 (9&4)    (output, active high, initialize low)                *    
;*     PP2 - TIM1 OC2 Inj3 (3&6)    (output, active high, initialize low)                * 
;*     PP3 - TIM1 OC3 Inj4 (5&8)    (output, active high, initialize low)                *  
;*     PP4 - TIM1 OC4 Inj5 (7&2)    (output, active high, initialize low)                * 
;*     PP5 - TIM1 OC5 PP5out        (output, initialize low) spare                       * 
;*     PP6 - Not used               (output, initialize low)                             *
;*     PP7 - Not used               (output, initialize low)   
;*****************************************************************************************
;*****************************************************************************************	


    movb #$FF,TIM_TIOS  ;(TIM_TIOS equ $03D0)
                        ; Load Timer Input capture/Output compare Select register with 
                        ; %11111111 (All channels outputs)
                        
    movb #$88,TIM_TSCR1 ; (TIM_TSCR1 equ $03D6) 
                        ; Load TIM_TSCR1 with %10001000 (timer enabled, no stop in wait, 
                        ; no stop in freeze, no fast flag clear, precision timer)
                        
    movb #$3F,TIM_TIE   ; Load TIM_TIE (Timer Interrupt Enable Register)
                        ; with %00111111 (enable interrupts CH5,4,3,2,1,0)

    movb #$07,TIM_TSCR2 ; (TIM_TSCR2 equ $03DD)(Load TIM_TSCR2 with %00000111 
                        ; (timer overflow interrupt disabled,timer counter 
                        ; reset disabled, prescale divide by 128)
						
;*    movb #$7F,TIM_PTPSR ; (TIM_PTPSR equ $03FE) Load TIM_PTPSR with %01111111  
                        ; (prescale 128, 2.56us resolution, 
                        ; max period 167.7696ms)(Time base for run mode)

   movb #$FF,TIM_PTPSR ; (TIM_PTPSR equ $03FE)(Load TIM_PTPSR with %11111111
                        ; (prescale 256, 5.12us resolution, 
                        ; max period 335.5ms) (time base for prime or crank modes)						
						
    movb #$FF,TIM_TFLG1 ; Clear all interrupt flags (just in case)
                                                
;*****************************************************************************************	
; - Initialize Port S. General purpose I/Os. SCI0 RS232 RXD input Pin 0, TXD output pin 1, 
;   all others not used, set as inputs - Page 126, 128 
;   Note! When SCI0 is enabled Pins 0 and 1 are under SCI control 

;*****************************************************************************************

    clr   DDRS        ; Load %00000000 into Port S Data Direction  
                      ; Register(all pins inputs)
    movw #$FF00,PERS  ; Load Port S Pull Device Enable  
                      ; Register and Port S Polarity Select  
                      ; Register with %1111111100000000  
                      ; (pull-ups on all pins)

;***************************************************************************************
; - Initialize the SCI0 interface for 115,200 Baud Rate
;   When IREN = 0, SCI Baud Rate = SCI bus clock / 16 x SBR[12-0]
;   or SCI0BDH:SCI0BDL = (Bus Freq/16)/115200 = 21.70
;   27.1 rounded = 27 = $1B 
;***************************************************************************************

    movb  #$00,SCI0BDH  ; Load SCI0BDH with %01010100, (IR disabled, 1/16 narrow pulse 
                        ; width, no prescale Hi Byte) 
    movb  #$1B,SCI0BDL  ; Load SCI0BDL with decimal 27, prescale Lo byte 
                        ;(115,200 Baud Rate)
    clr   SCI0CR1       ; Load SCI0CR1 with %00000000(Normal operation, SCI enabled  
                        ; in wait mode. Internal receiver source. One start bit,8 data 
                        ; bits, one stop bit. Idle line wakeup. No parity.) 
    movb  #$24,SCI0CR2  ; Load SCI0CR2 with %00100100(TDRE interrupts disabled. TCIE  
                        ; interrpts disabled. RIE interrupts enabled.IDLE interrupts  
                        ; disabled. Transmitter disabled, Receiver enabled, Normal  
                        ; operation, No break characters)
                        ; (Transmitter and interrupt get enabled in SCI0_ISR)

;*****************************************************************************************	
; - Initialize Port T. Enhanced Capture Channels IOC7-IOC0. pg 527
;   Camshaft position, Crankshaft position and Vehicle Speed inputs
;   Ignition control outputs
;*****************************************************************************************

    movw  #$FF00,DDRT   ; Load Port T Data Direction Register and  
                        ; Port T Reduced Drive Register with 
                        ; %1111_0000_0000_0000  
                        ; Outputs on PT7,6,5,4,3 Inputs on PT2,1,0  
                        ; full drive on all pins
                        
;*****************************************************************************************	
; - Initialize Port T. Enhanced Capture Channels IOC7-IOC0. pg 527
;*     PT0 - IOC0 - Camshaft Position   (input, active high) gear tooth sens             *
;*     PT1 - IOC1 - Crankshaft Position (input, active high) gear tooth sens             *
;*     PT2 - IOC2 - Vehicle Speed       (input, active high) gear tooth sens             *
;*     PT3 - IOC3 - Ign1 (1&6)          (output, active high, initialize low)            *
;*     PT4 - IOC4 - Ign2 (10&5)         (output, active high, initialize low)            *
;*     PT5 - IOC5 - Ign3 (9&8)          (output, active high, initialize low)            *
;*     PT6 - IOC6 - Ign4 (4&7)          (output, active high, initialize low)            *
;*     PT7 - IOC7 - Ign5 (3&2)          (output, active high, initialize low)            *
;*****************************************************************************************
;*****************************************************************************************
;  - The crank trigger wheel on the Dodge V10 has 5 pairs of two notches. Each notch is 
;    3 degrees wide. The falling edges of the notch pairs are 18 degrees apart and the 
;    pairs are 54 degrees apart. 54 degrees is the longest span that is measured and is 
;    used to determine the slowest period that can be measured before timer roll over.
;    Any 3 consecutive notches will cover 72 degrees. The time period of 72 degrees can 
;    be used as a base to calculate RPM, ignition and injection timing. The interrupts 
;    for the crankshaft and camshaft sensors are handled in the interrupt section. 
;    It is here that that the 72 degree period is calculated and the determination of 
;    crank mode and run mode are made. 
;
;    4500RPM = 75Hz = .01333Sec period / 5 =.002666Sec per 72 degrees
;    A prescale of 128 results in a 2.56uS clock tick with a maximum period of 167.7696mS
;    Timer will roll over in 65535 * .00000256 = .1677696 seconds
;    .1677696 / 54 = .003106844444 seconds per degree
;    .003106844444 * 360 = 1.118464 seconds per revolution
;    1 / 1.118464 = .893942644 Hz
;    .893942644 * 60 = 53.6 Lowest measureable RPM
;    4500RPM .002666/.00000256 = 1041 counts
;    4500 / 1041 =  = 4.3 RPM resolution
;
;    A prescale of 256 results in a 5.12uS clock tick with a maximum period of 335.5392mS
;    Timer will roll over in 65535 * .00000256 = .3355392 seconds
;    .3355392 / 54 = .006213688889 seconds per degree
;    .006213688889 * 360 = 2.236928 seconds per revolution
;    1 / 2.236928 = .447041657 Hz
;    .447041657 * 60 = 26.8 Lowest measureable RPM
;    4500RPM .002666 /.00000512 = 520 counts
;    4500 / 520 =  = 8.6 RPM resolution 
;
;*****************************************************************************************

     movb #$F8,ECT_TIOS ; Load Timer Input capture/Output 
                        ; compare Select register with 
                        ; %11111000 Output Compare PT7,6,5,4,3
                        ; Input Capture PT2,1,0
                        
    movb #$88,ECT_TSCR1 ; Load ECT_TSCR1 with %10011000 
                        ;(timer enabled, no stop in wait, 
                        ; no stop in freeze, no fast flag clear,
                        ; precision timer)
                        
    movb  #$FF,ECT_TIE  ; Load Timer Interrupt Enable Register 
                        ; with %11111111 (interrupts enabled 
                        ; Ch7,6,5,4,3,2,1,0)

    movb #$07,ECT_TSCR2 ; Load ECT_TSCR2 with %00000111
                        ; (timer overflow interrupt disabled,
                        ; timer counter reset disabled,
                        ; prescale divide by 128 for legacy timer only)
                        
;*    movb #$7F,ECT_PTPSR ; Load ECT_PTPSR with %01111111  (time base for run mode) 
                        ; (prescale 128, 2.56us resolution, 
                        ; max period 167.7696ms)
						
    movb #$FF,ECT_PTPSR ; Load ECT_PTPSR with %11111111 (time base for prime or crank modes)
                        ; (prescale 256, 5.12us resolution, 
                        ; max period 335.5ms)
                                  
    movb #$00,ECT_TCTL3 ; Load ECT_TCTL3 with %00000000 
                        ; (capture disabled Ch7,6,5,4)
                        
    movb #$15,ECT_TCTL4 ; Load ECT_TCTL4 with %00010101 (Capture disabled Ch3
                        ; rising edge capture Ch2,1,0)
                        
    movb #$FF,ECT_TFLG1 ; Clear all interrupt flags (just in case)
                        
;*****************************************************************************************
; - Initialize Real Time Interrupt for 1mS period -
;   OSCLOCK / 16 = Frequency divide rate
;   16,000,000/16=1,000,000
;   1/1,000,000=1mSec period
;*****************************************************************************************

    movb  #$8F,RTICTL  ; Load "RTICTL" with %10001111 (base divider,1mS period)       
    bset  CRGFLG,$80   ; Clear Real Time Interrupt Flag bit7
    bset  CRGINT,$80   ; Enable RTI bit7
    
;*****************************************************************************************
; - Set pull ups for BKGD, Port E and Port A 
;*****************************************************************************************

    movb  #$51,PUCR   ; Load %01010001 into Pull Up Control 
                      ; Register (pullups enabled BKGD, Port E and Port A	

;*****************************************************************************************
; - INITIALIZE ISR VECTORS          Note! all ISRs are disabled out of reset
;*****************************************************************************************
    
; - Initialize RTI ISR vector
   
    movb  #$F0,INT_CFADDR  ; Load "CFADDR" with %11110000 (Place RTI -> UI  
                           ; into window)
    movb  #$04,INT_CFDATA0 ; Load "CFDATA0" with %00000100 (Set RTI ENABLED, CPU, level 4)  

; - Initialize Enhanced Capture Timer Ch7 -> Ch0 ISR vectors -
    
    movb  #$E0,INT_CFADDR  ; Load "CFADDR" with %11100000 (Place Enhanced Captuer Timer  
                           ; Ch7 -> Ch0 into window) 
    movb  #$06,INT_CFDATA0 ; Load "CFDATA0" with %00000110 (Set ECT ch7 PT7 Ign5 (3&2) ENABLED, CPU, level 6)
    movb  #$06,INT_CFDATA1 ; Load "CFDATA1" with %00000110 (Set ECT ch6 PT6 Ign4 4&7) ENABLED, CPU, level 6)
    movb  #$06,INT_CFDATA2 ; Load "CFDATA2" with %00000110 (Set ECT ch5 PT5 Ign3 (9&8) ENABLED, CPU, level 6)
    movb  #$06,INT_CFDATA3 ; Load "CFDATA3" with %00000110 (Set ECT ch4 PT4 Ign2 (10&5) ENABLED, CPU, level 6)        
    movb  #$06,INT_CFDATA4 ; Load "CFDATA4" with %00000110 (Set ECT ch3 (PT3 Ign1 (1&6)) ENABLED, CPU, level 6)        
    movb  #$02,INT_CFDATA5 ; Load "CFDATA5" with %00000010 (Set ECT ch2 (PT2 Vspd), ENABLED, CPU level 2) 
    movb  #$07,INT_CFDATA6 ; Load "CFDATA5" with %00000111 (Set ECT ch1 (PT1 CKP), ENABLED, CPU level 7) 
    movb  #$07,INT_CFDATA7 ; Load "CFDATA7" with %00000111 (Set ECT ch0 (PT0 CMP), ENABLED, CPU level 7) 
            
; - Initialize SCI0 ISR vector

    movb  #$D0,INT_CFADDR  ; Load "CFADDR" with %11010000 (Place ATD1 -> Enhanced  
                           ; Capture Timer Overflow into window)
    movb  #$03,INT_CFDATA3 ; Load "CFDATA3" with %00000011 (Set SCI0 ENABLED, CPU, level 3)  
                          
; - Initialize TIM ch2 -> TIM ch0 ISR vectors

    movb  #$50,INT_CFADDR  ; Load "CFADDR" with %01010000 (TIM ch2 -> PIT ch4   
                           ; into window)
    movb  #$05,INT_CFDATA0 ; Load "CFDATA0" with %00000101 (Set TIM ch2 (PP2 Inj3 (3&6)), ENABLED, CPU level 5) 
    movb  #$05,INT_CFDATA1 ; Load "CFDATA1" with %00000101 (Set TIM ch1 (PP1 Inj2 (9&4)), ENABLED, CPU level 5) 
    movb  #$05,INT_CFDATA2 ; Load "CFDATA2" with %00000101 (Set TIM ch0 (PP0 Inj1 (1&10)), ENABLED, CPU level 5) 
                               
    ; - Initialize TIM ch4 -> TIM ch3 ISR vectors 

    movb  #$40,INT_CFADDR  ; Load "CFADDR" with %01000000 (TIM Pulse accumulator    
                           ; input edge -> TIM ch3 into window)
    movb  #$01,INT_CFDATA5 ; Load "CFDATA5" with %00000001 (Set TIM ch5 (PP5out), ENABLED, CPU, level1) 
    movb  #$05,INT_CFDATA6 ; Load "CFDATA6" with %00000101 (Set TIM ch4 (PP4 Inj5 (7&2)), ENABLED, CPU level 5) 
    movb  #$05,INT_CFDATA7 ; Load "CFDATA7" with %00000101 (Set TIM ch3 (PP3 Inj4 (5&8)), ENABLED, CPU level 5) 
                            
;*****************************************************************************************
;*****************************************************************************************
; - Initialize Flash NVM by programming FCLKDIV based on oscillator frequency of 16 Mhz
;   uprotect the array, and finally ensure FPVIOL and ACCERR are cleared by writing to them.
;   For ~ 1MHz FCLK frequency table 29.9 FDIV[6:0] = $0F (%00001111)
;*****************************************************************************************

    movb #$0F,FCLKDIV ; %00001111 -> Flash Clock Divider Register (divider value for 
	                  ; 1MHz FCLK frequency with 16MHz OSSCLK
  	movb #$BF,FPROT   ; %10111111 -> P-Flash Protection Register (Disable Flash protection)
	                  ; FPOPEN, RNV6, FPHDIS, FPHS1, FPHS0, FPLDIS, FPLS1, FPLS0
  	movb #$30,FSTAT   ; %00110000 -> Flash Status Register. Clear Flash Access Error Flag 
	                  ; bit5 and Flash Protection Violation Flag bit4 by writing to their
					  ; respective bits
					          
;*****************************************************************************************
;                          END OF INITIALIZATION SECTION 
;*****************************************************************************************
;*****************************************************************************************
;* - NOTE! I CAN'T GET MY BURNER CODE TO WORK WITH TUNER STUDIO SO I'M COMMENTING IT OUT
;*****************************************************************************************

;PostEnB:  ; This is the re-entry point after completing the Flash Erase and Burn routines   

;***************************************************************************************** 
; The configurable constants stored in Flash are copied to RAM where the program acsesses 
; them. Tuner Studio loads the real time variables and the constants from RAM in order to 
; modify the constants during the tuning process. When the new tuning constants are  
; acceptable they can be burned back into Flash.
;*****************************************************************************************

;*****************************************************************************************
; - Copy page 1, VE table, ranges and other configurable constants from Flash to RAM. 
;*****************************************************************************************

    ldd    #$400        ; Load accu D with decimal 1024
    ldx    #veBins_F    ; Load index register X with the address 
                        ; of the first value in "veBins_F" table (Flash)
    ldy    #veBins_R    ; Load index register Y with the address 
                        ; of the first value in "veBins" table (RAM)

CopyPage1:
    movb    1,X+, 1,Y+  ; Copy byte value from Flash to RAM and 
                        ; increment X and Y registers
    dbne    D,CopyPage1 ; Decrement Accu D and loop back to CopyPage1:
                        ; if not zero    

;*****************************************************************************************
; - Copy page 2, ST table, ranges and other configurable constants from Flash to RAM
;*****************************************************************************************

    ldd    #$400        ; Load accu D with decimal 1024
    ldx    #stBins_F    ; Load index register X with the address  
                        ; of the first value in "stBins_F" table (Flash)
    ldy    #stBins_R    ; Load index register Y with the address  
                        ; of the first value in "stBins" table ( RAM)

CopyPage2:
    movb    1,X+, 1,Y+  ; Copy byte value from Flash to RAM and 
                        ; increment X and Y registers
    dbne    D,CopyPage2 ; Decrement Accu D and loop back to CopyPage2:
                        ; if not zero    

;*****************************************************************************************
; - Copy page 3, AFR table, ranges and other configurable constants from Flash to RAM
;*****************************************************************************************

    ldd    #$400        ; Load accu D with decimal 1024
    ldx    #afrBins_F   ; Load index register X with the address  
                        ; of the first value in "afrBins_F" table (Flash)
    ldy    #afrBins_R   ; Load index register Y with the address  
                        ; of the first value in "afrBins" table (RAM)

CopyPage3:
    movb    1,X+, 1,Y+  ; Copy byte value from Flash to RAM and 
                        ; increment X and Y registers
    dbne    D,CopyPage3 ; Decrement Accu D and loop back to CopyPage3:
                        ; if not zero
                        
;*****************************************************************************************	
; - Energise the Fuel pump relay and the Emergency Shutdown relay on Port B Bit0 and Bit1
;*****************************************************************************************

    bset  PORTB,#$01  ; Set "FuelPump" bit0 on Port B (pump on)
    bset  PORTB,#$02  ; Set "ASDRelay" bit1 on Port B (relay on)
    
;*****************************************************************************************
;                         - Clear all real time variables - 
;*****************************************************************************************

;*****************************************************************************************
; - Seconds counter variables
;*****************************************************************************************
	 
   clr   SecH         ; RTI seconds count Hi byte
   clr   SecL         ; RTI seconds count Lo byte
   
;*****************************************************************************************
; - ADC variables
;*****************************************************************************************
   
   clrw  batAdc       ; Battery Voltage 10 bit ADC AN00
   clrw  BatVx10      ; Battery Voltage (Volts x 10)
   clrw  cltAdc       ; 10 bit ADC AN01 Engine Coolant Temperature ADC
   clrw  Cltx10       ; Engine Coolant Temperature (Degrees F x 10)
   clrw  matAdc       ; 10 bit ADC AN02 Manifold Air Temperature ADC
   clrw  Matx10       ; Manifold Air Temperature (Degrees F x 10)
   clrw  PAD03inAdc   ; 10 bit ADC AN03 Spare Temperature ADC
   clrw  TpsPctx10last; Throttle Position Sensor percent last
   clrw  mapAdc       ; 10 bit ADC AN04 Manifold Absolute Pressure ADC
   clrw  Mapx10       ; Manifold Absolute Pressure (KPAx10)
   clrw  tpsAdc       ; 10 bit ADC AN05 Throttle Position Sensor ADC (exact for TS)
   clrw  TpsPctx10    ; Throttle Position Sensor % of travel(%x10)(update every 100mSec)
   clrw  egoAdc1      ; 10 bit ADC AN06 Exhaust Gas Oxygen ADC Left bank odd cyls
   clrw  afr1x10      ; Air Fuel Ratio for gasoline Left bank odd cyls(AFR1x10)
   clrw  baroAdc      ; 10 bit ADC AN07 Barometric Pressure ADC
   clrw  Barox10      ; Barometric Pressure (KPAx10)
   clrw  eopAdc       ; 10 bit ADC AN08 Engine Oil Pressure ADC
   clrw  Eopx10       ; Engine Oil Pressure (PSI x 10)
   clrw  efpAdc       ; 10 bit ADC AN09 Engine Fuel Pressure ADC
   clrw  Efpx10       ; Engine Fuel Pressure (PSI x 10)
   clrw  itrmAdc      ; 10 bit ADC AN10 Ignition Trim ADC
   clrw  Itrmx10      ; Ignition Trim (degrees x 10)+-20 degrees)
   clrw  ftrmAdc      ; 10 bit ADC AN11 Fuel Trim ADC
   clrw  Ftrmx10      ; Fuel Trim (% x 10)(+-20%)
   clrw  egoAdc2      ; 10 bit ADC AN12  Exhaust Gas Oxygen ADC Right bank even cyls 
   clrw  afr2x10      ; Air Fuel Ratio for gasoline Right bank even cyls(AFR2x10)

;*****************************************************************************************
; - Input capture variables 
;*****************************************************************************************

   clrw  CASprd512    ; Crankshaft Angle Sensor period (5.12uS time base
   clrw  CASprd256    ; Crankshaft Angle Sensor period (2.56uS time base NOT USED
   clrw  RPM          ; Crankshaft Revolutions Per Minute
   clrw  KPH          ; Vehicle speed (KpH x 10)
;*****************************************************************************************
; - Fuel calculation variables
;*****************************************************************************************

   clrw  ASEcnt        ; Counter for "ASErev"
   clrw  AFRcurr       ; Current value in AFR table (AFR x 100)
   clrw  VEcurr        ; Current value in VE table (% x 10)
   clrw  barocor       ; Barometric Pressure Correction (% x 10)
   clrw  matcor        ; Manifold Air Temperature Correction (% x 10)
   clrw  WUEcor        ; Warmup Enrichment Correction (% x 10)
   clrw  ASEcor        ; Afterstart Enrichmnet Correction (% x 10)
   clrw  WUEandASEcor  ; the sum of WUEcor and ASEcor (% x 10)
   clrw  Crankcor      ; Cranking pulsewidth temperature correction (% x 10)
   clrw  TpsPctDOT     ; TPS difference over time (%/Sec)(update every 100mSec)
   clrw  TpsPctDOTlast ; TPS difference over time last (%/Sec)(update every TOE routine)
   clrw  TOEpct        ; Throttle Opening Enrichment (%)
   clrw  TOEpw         ; Throttle Opening Enrichment adder (mS x 100)
   clrw  PWlessTOE     ; Injector pulse width before "TOEpw" and "Deadband" (mS x 10)
   clrw  Deadband      ; injector deadband at current battery voltage mS*100
   clrw  PrimePW       ; Primer injector pulswidth (mS x 10)
   clrw  CrankPW       ; Cranking injector pulswidth (mS x 10)
   clrw  FDpw          ; Fuel Delivery pulse width (PW - Deadband) (mS x 10)
   clrw  PW            ; Running engine injector pulsewidth (mS x 10)
   clrw  LpH           ; Fuel burn Litres per hour
   clrw  FDsec         ; Fuel delivery pulse width total over 1 second (mS x 10)
   clr   GearCur       ; Curent transmission gear
   clr   TOEdurCnt     ; Throttle Opening Enrichment duration counter
   clrw  FDt           ; Fuel Delivery pulse width total(mS) (for FDsec calcs)
   
;*****************************************************************************************
;*****************************************************************************************
; - Ignition calculation variables
;*****************************************************************************************
	 
   clrw  STcurr        ; Current value in ST table (Degrees x 10)
   clrw  KmpL          ; Fuel burn kilometers per litre
   clrw  DwellCor      ; Coil dwell voltage correction (%*10)
   clrw  DwellFin      ; ("Dwell" * "DwellCor") (mS*10)
   clrw  STandItrmx10  ; stCurr and Itmx10 (degrees*10)

;*****************************************************************************************
;*****************************************************************************************
; - Port status variables
;*****************************************************************************************

   clr   PortAbits     ; Port A status bit field
   clr   PortBbits     ; Port B status bit field
   clr   PortKbits     ; Port K status bit field
   clr   PortPbits     ; Port P status bit field
   clr   PortTbits     ; Port T status bit field

;*****************************************************************************************
; - Misc variables 
;*****************************************************************************************

   clr   engine        ; Engine status bit field
   clr   engine2       ; Engine2 status bit field
   clrw  ColdAddPW     ; TOE cold adder pulse width (mSx10)
   clr   StateStatus   ; State status bit field
   clrw  LoopTime      ; Program main loop time (loops/Sec)
   clrw  DutyCyclex10  ; Injector duty cycle in run mode (% x 10)
   clrw  MpG           ; Fuel burn miles per gallon Imperial
   clrw  TestValw      ; Word test value (for program developement only)
   clr   TestValb      ; Byte test value (for program developement only)
   
;*****************************************************************************************
; - More fuel calculation variables variables 
;*****************************************************************************************

   clrw  ColdAddpct   ; Throttle Opening Enrichment cold adder (%)
   clrw  ColdMulpct   ; Throttle Opening Enrichment cold multiplier (%)
   clrw  TOEandCMpct  ; TOE and Cold Multiplier percent (%)
   clrw  TOEandCMPW   ; TOE and ColdMultiplier pulse width (mSx10)
   clrw  TpsDOTmax    ; TPS DOT maximum for TOE calculations (%/Sec)

;*****************************************************************************************
; - Real Time Interrupt variables 
;*****************************************************************************************

;   clr   uSx125        ; 125 microsecond counter
   clr   mS            ; 1 millisecond counter
   clr   mSx100        ; 100 millisecond counter
   clr   clock         ; Time rate flag marker bit field

;*****************************************************************************************
; - Serial Communications Interface variables
;*****************************************************************************************

   clr  txgoalMSB      ; SCI number of bytes to send/rcv Hi byte
   clr  txgoalLSB      ; SCI number of bytes to send/rcv Lo byte 
   clrw txcnt          ; SCI count of bytes sent/rcvd
   clr  rxoffsetMSB    ; SCI offset from start of page Hi byte 
   clr  rxoffsetLSB    ; SCI offset from start of page lo byte 
   clr  rxmode         ; SCI receive mode selector
   clr  txmode         ; SCI transmit mode selector
   clr  pageID         ; SCI page identifier
   clr  txcmnd         ; SCI command character identifier
   clr  dataMSB        ; SCI data Most Significant Byte received
   clr  dataLSB        ; SCI data Least Significant Byte received 

;*****************************************************************************************
; - Ignition calculations variables
;*****************************************************************************************

   clrw Spantk         ; Ignition Span time (5.12uS or 2.56uS res)
   clrw DwellFintk     ; Time required for dwell after correction (5.12uS or 2.56uS res)
   clrw STandItrmtk    ; STcurr and Itmx10 (5.12uS or 2.56uS res)  
   clrw Advancetk      ; Delay time for desired spark advance + dwell(5.12uS or 2.56uS res)
   clrw Delaytk        ; Delay time from crank signal to energise coil(5.12uS or 2.56uS res)
   clrw IgnOCadd1      ; First ignition output compare adder (5.12uS or 2.56uS res)
   clrw IgnOCadd2      ; Second ignition output compare adder(5.12uS or 2.56uS res)

;*****************************************************************************************
; - Injection calculations variables
;*****************************************************************************************

   clrw TpsPctx10last  ; Throttle Position Sensor percent last (%x10)(updated every 100Msec)
   clrw DdBndZ1        ; Deadband interpolation Z1 value
   clrw DdBndZ2        ; Deadband interpolation Z2 value 
   clrw PWcalc1        ; PW calculations result 1 
   clrw PWcalc2        ; PW calculations result 2
   clrw PWcalc3        ; PW calculations result 3
   clrw PWcalc4        ; PW calculations result 4
   clrw PWcalc5        ; PW calculations result 5
   clrw ASErev         ; Afterstart Enrichment Taper (revolutions)
   clrw PrimePWtk      ; Primer injector pulswidth timer ticks(uS x 5.12)
   clrw CrankPWtk      ; Cranking injector pulswidth timer ticks(uS x 5.12)
   clrw PWtk           ; Running injector pulsewidth timer ticks(uS x 2.56)
   clrw InjOCadd1      ; First injector output compare adder (5.12uS res or 2.56uS res)
   clrw InjOCadd2      ; Second injector output compare adder (5.12uS res or 2.56uS res)
   clrw FDcnt          ; Fuel delivery pulse width total(ms)(for totalizer pulse on rollover)
   clr  AIOTcnt        ; Counter for AIOT totalizer pulse width 

;*****************************************************************************************
; - State machine variables 
;*****************************************************************************************

   clr  State          ; Cam-Crank state machine current state 

;*****************************************************************************************
; - Input capture variables 
;*****************************************************************************************

   clrw VSS1st        ; VSS input capture rising edge 1st time stamp (5.12uS or 2.56uS res)
   clrw CAS1sttk      ; CAS input capture rising edge 1st time stamp ((5.12uS or 2.56uS res)
   clrw CAS2ndtk      ; CAS input capture rising edge 2nd time stamp (5.12uS or 2.56uS res) 
   clrw CASprd1tk     ; Period between CAS1st and CAS2nd (5.12uS or 2.56uS res)
   clrw CASprd2tk     ; Period between CAS2nd and CAS3d ((5.12uS or 2.56uS res) 
   clrw Degx10tk512   ; Time to rotate crankshaft 1 degree in 5.12uS resolution x 10
   clrw InjPrFlo      ; Injector pair flow rate in CC/Min (from InjPrFlo_F)   
   clr  RevCntr       ; Counter for "Revmarker" flag
   clrw Stallcnt      ; No crank or stall condition counter (1mS increments) 
   clr  ICflgs        ; Input Capture flags bit field 

;*****************************************************************************************
; - 2D Lookup variables 
;*****************************************************************************************							  

   clrw CrvPgPtr      ; Pointer to the page where the desired curve resides 
   clrw CrvRowOfst    ; Offset from the curve page to the curve row 
   clrw CrvColOfst    ; Offset from the curve page to the curve column 
   clrw CrvCmpVal     ; Curve comparison value for interpolation
   clr  CrvBinCnt     ; Number of bins in the curve row or column minus 1
   clr  IndexNum      ; Position in the row or column of the curve comparison value 
   clrw CrvRowHi      ; Curve row high boundry value for interpolation
   clrw CrvRowLo      ; Curve row low boundry value for interpolation 
   clrw CrvColHi      ; Curve column high boundry value for interpolation
   clrw CrvColLo      ; Curve column low boundry value for interpolation

;***************************************************************************************** 
; - Misc variables 
;*****************************************************************************************

   clrw LoopCntr     ; Counter for "LoopTime"(incremented every Main Loop pass)
   clrw tmp1w        ; Temporary word variable #1
   clrw tmp2w        ; Temporary word variable #2
   clrw tmp3w        ; Temporary word variable #3
   clrw tmp4w        ; Temporary word variable #4
   clr  tmp5b        ; Temporary byte variable #5
   clr  tmp6b        ; Temporary byte variable #6
   clr  tmp7b        ; Temporary byte variable #7
   clr  tmp8b        ; Temporary byte variable #8
   clrw GearKCur     ; Variable for current gear K factor calculations
   clrw baroADCsum   ; Variable for "baroADC" averaging sum
   clr  baroADCcnt   ; Counter for "baroADC" averaging sum
   clrw BurnCnt      ; Counter for bytes burnt in Flash erase and burn routine
   clrw egoADC1sum   ; Variable for "egoADC1" averaging sum
   clr  egoADC1cnt   ; Counter for "egoADC1" averaging
   clrw egoADC2sum   ; Variable for "egoADC2" averaging sum
   clr  egoADC2cnt   ; Counter for "egoADC2" averaging
;   clrw RPMaddend    ; Addend variable for RPM averaging
;   clrw RPMsum       ; Variable for "RPM" averaging sum
;   clr  RPMcnt       ; Counter for "RPM" averaging
   
;*****************************************************************************************
; - Interpolation variables
;*****************************************************************************************

   clrw interpV     ; Interpolation variable "V" 
   clrw interpV1    ; Interpolation variable "V1"
   clrw interpV2    ; Interpolation variable "V2"
   clrw interpZ     ; Interpolation variable "Z" 
   clrw interpZ1    ; Interpolation variable "Z1" 
   clrw interpZ2    ; Interpolation variable "Z2" 
   
;*****************************************************************************************
; Late additional variables 
;*****************************************************************************************

   clrw ASEstart      ; Initial value for ASEcor interpolation from ASE cor table
   clrw VSSprd512     ; VSS period for 5.12uS time base
   clrw VSScnt        ; Counter to detect vehicle stopped condition
   clr  MinCKP        ; Minimum CKP triggers before RPM period calculations
   clrw efpADCsum     ; Variable for "efpADC" averaging sum
   clr  efpADCcnt     ; Counter for "efpADC" averaging
   
;*****************************************************************************************
; - 3DLUT  variables
;*****************************************************************************************

;   clrw  TabPoint   ; Table pointer
;   clrw  ColVal     ; Column value
;   clrw  RowVal     ; Row value
;   clrw  LowColVal  ; Lower column value 
;   clrw  UpColVal   ; Upper column value 
;   clrw  LowRowPtr  ; Lower row pointer
;   clrw  UpRowPtr   ; Upper row pointer
;   clrw  LowRowVal  ; Lower row value
;   clrw  UpRowVal   ; Upper row value 
;   clrw  Zll        ; Interpolation Z low low 
;   clrw  Zlh        ; Interpolation Z low high 
;   clrw  Zhl        ; Interpolation Z high low 
;   clrw  Zhh        ; Interpolation Z high high
;   clrw  Zl         ; Interpolation Z low 
;   clrw  Zh         ; Interpolation Z high

;*****************************************************************************************
; - Initialize other variables 
;*****************************************************************************************

    movb #$09,RevCntr           ; Counter for Revolution Counter signals
    bset StateStatus,SynchLost  ; Set "SynchLost" bit of "StateStatus" variable (bit1)
    bset PORTK,A4988En   ; Disable the motor driver chip (active low)
;    bclr PORTK,A4988En  ; For testing on old board, Outputs are inverted
    bclr PORTK,A4988Step ; Stepper control off (active high)
;    bset PORTK,A4988Step  ; For testing on old board, Outputs are inverted
	bclr PORTK,A4988Dir  ; Direction CCW (no particular reason)
;    bset PORTK,A4988Dir  ; For testing on old board, Outputs are inverted
    bset PORTB,#$20      ; Set Port B bit5 (Crank Synch Indicator State)
	                     ;(indicator on , crank not synched)
                         
;*****************************************************************************************
; - Load "MinCKP" with the number of CKP triggers required before RPM period calculations 
;   are commenced. This is done to prevent timer overflow when periods are long during 
;   initial cranking. During cranking ignition dwell and spark are scheduled at specific 
;   crank trigger points after synch has been established.
;*****************************************************************************************
								 
    ldy   #veBins_R     ; Load index register Y with address of first configurable 
                        ; constant on buffer RAM page 1 (vebins)
    ldd   $0363,Y       ; Load Accu A with value in buffer RAM page 1 offset 867 
                        ; "MinCKP_F" (Minimum CKP triggers))(offset = 867)(0363) 
    std   MinCKP        ; Copy to "MinCKP" (Starting value to count down)
 
;*****************************************************************************************
                        
;*****************************************************************************************
;                             LETS GET THE SHOW ON THE ROAD!
;*****************************************************************************************		
	
    cli   ; Enable interrupts

;*****************************************************************************************
;- Start ATD0
;*****************************************************************************************

    movb  #$30,ATD0CTL5   ; Load ATD Control Register 5 with %00110000 (no special channel   
                          ; ,continuous conversion, multi channel, initial channel 0)
                          ; (Start conversion sequence)
                          ;         ^^^^^^^^ 
                          ;       SC-+|||||| 
                          ;     SCAN--+||||| 
                          ;     MULT---+||||
                          ;       CD----+||| 
                          ;       CC-----+|| 
                          ;       CB------+| 
                          ;       CA-------+ 
                          ;(Register is %00000000 out of reset)
                          
;*****************************************************************************************
; Not so fast! wait here for 500mSec to allow the ADC currents to stabilize
;*****************************************************************************************

    brclr clock,ms500,*              ; Loop here until the flag is set  
    bclr  clock,ms500                ; Clear the "ms500" flag

    brclr ATD0STAT0,ATD0STAT0_SCF,*  ; Loop here until Sequence Complete Flag is set
    bset  ATD0STAT0,#80              ; Set the Sequence Complete Flag bit7 of ATD0STAT0 
                                     ; to clear the flag                                ; 
    
;*****************************************************************************************
;- Read ATD0
;*****************************************************************************************

    jsr   READ_ATD0     ; Jump to READ_ATD0 subroutine
    
;*****************************************************************************************
;- Convert ATD0 ADCs to user units
;*****************************************************************************************
    
    jsr   CONVERT_ATD0  ; Jump to CONVERT_ATD0 subroutine
    
;*****************************************************************************************
; - Injector dead band is the time required for the injectors to open and close and must
;   be included in the pulse width time. The amount of time will depend on battery voltge.
;   Battery voltage correction for injector deadband is calculated as a linear function
;   of battery voltage from 7.2 volts to 19.2 volts with 13.2 volts being the nominal 
;   operating voltage where no correction is applied.
;*****************************************************************************************
;*****************************************************************************************
; - Calculate values at Z1 and Z2 to interpolate injector deadband at current battery  
;   voltage. This is done before entering the main loop as will only change if the  
;   configurable constants for injector dead time and battery voltage correction have 
;   been changed. 
;*****************************************************************************************
;*****************************************************************************************
; - Calculate values at Z1 and Z2
; DdBndBase_F = 90 (.9 mSec)
; DdBndCor_F = 18 (.18 mSec/V)
;*****************************************************************************************

    ldy    #veBins_R    ; Load index register Y with address of first configurable 
                        ; constant in RAM page 1 (veBins_R)
    ldd    $033C,Y      ; Load Accu A with value in buffer RAM page 1 offset 828 
                        ; Injector deadband at 13.2V (mSec*10)(DdBndBase_F)
    std    tmp1w        ; Copy to "tmp1w" (Injector deadband at 13.2V (mSec * 100))
    ldy    #veBins_R    ; Load index register Y with address of first configurable 
                        ; constant in RAM page 1 (veBins_R)
    ldd    $033E,Y      ; Load Accu A with value in buffer RAM page 1 offset 830 
                        ; Injector deadband voltage correction (mSec/V x 100)(DdBndCor_F)
    std    tmp2w        ; Copy to "tmp2w"
    ldy    #$06         ; Decimal 6-> Accu Y
  	emul                ; (D)*(Y)->Y:D "Injector deadband voltage correction" * 6
  	std    tmp3w        ;("Injector deadband voltage correction" * 6)-> tmp3w
  	addd   tmp1w        ; A:B)+((M:M+1)->A:B  (Injector deadband at 13.2V + (Injector deadband 
	                    ; voltage correction * 6)
	std   DdBndZ2       ; Copy result to "DdBndZ2"
    ldd   tmp1w         ; (Injector deadband at 13.2V)-> Accu A
    subd  tmp3w         ;  A:B)-((M:M+1)->A:B  ((Injector deadband at 13.2V) - 
	                    ; (Injector deadband voltage correction * 6))
    bpl   NotMinus      ; N bit = 0 so not a minus result, branch to NotMinus: 
    clr   DdBndZ1       ; Result is minus so clear "DdBndZ1"
    bra   WasMinus      ; Branch to WasMinus: (skip over)    
    
NotMinus:
    staa  DdBndZ1       ; Copy result to "DdBndZ1"
    
WasMinus:

;*****************************************************************************************
; - Interpolate injector deadband at current battery voltage
;*****************************************************************************************

    jsr   DEADBAND_CALCS  ; Jump to DEADBAND_CALCS subroutine

;*****************************************************************************************
; --------------------------------- Priming Mode ----------------------------------------
;
; On power up before entering the main loop all injectors are pulsed with a priming pulse
; provide some initial starting fuel. The injector pulse width is interpolated from the 
; Prime Pulse table which plots engine temperature in degrees F to 0.1 degree resoluion 
; against time in mS to 0.1mS resoluion. 
;
;*****************************************************************************************
;*****************************************************************************************
; First check to see if CLTx10 is negative
;*****************************************************************************************

    ldx  Cltx10       ; Engine Coolant Temperature (Degrees F x 10) -> X    
    andx #$8000       ; Logical AND X with %1000 0000 0000 0000 (CCR N bit set of MSB of 
                      ; of MSB of result is set)
    bmi  PrimeTempNeg ; If N bit of CCR is set, branch to PrimeTempNeg:
    bra  PrimeTempPos ; Branch to PrimeTempPos:
    
;*****************************************************************************************
; CLTx10 is negative. Prepare to interpolate from the first boundaries
;*****************************************************************************************

PrimeTempNeg:
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0290,Y     ; Load Accu X with value in RAM page 1 (offset 656)($0290) 
                      ; ("tempTable2" first address)(Low temperature)
    stx  interpV1     ; Copy to "interpV1"
    ldx  Cltx10       ; "CltX10" -> Accu X
    stx  interpV      ; Copy to "interpV"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0292,Y     ; Load Accu X with value in RAM page 1 (offset 658)($0292) 
                      ; ("tempTable2" second address)(High temperature)
    stx  interpV2     ; Copy to "interpV2"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $02C8,Y     ; Load Accu X with value in RAM page 1 (offset 712)($02C8) 
                      ; ("primePWTable" first address)(Low PW)
    stx  interpZ1     ; Copy to "interpZ1"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $02CA,Y     ; Load Accu X with value in RAM page 1 (offset 714)($02CA) 
                      ; ("primePWTable" second address)(High PW)
    stx  interpZ2     ; Copy to "interpZ2"

;*****************************************************************************************
; Check if we should rail low
;*****************************************************************************************
    
    ldx  Cltx10       ; "Cltx10" -> Accu X
    cpx  interpV1     ; Compare Cltx10 with Low temperature
    bls  RailLoFDpw   ; If "Cltx10" is the same or less than Low temperature branch to 
                      ; RailLoFDpw:
    
;*****************************************************************************************
; Check if we should rail high
;*****************************************************************************************

    cpx  interpV2       ; Compare Cltx10 with High temperature
    bhs  RailHiFDpw     ; If "Cltx10" is the same or higher than High temperature, branch 
                        ; to RailHiFDpw:
    bra  InterpPrimePW  ; Branch to InterpPrimePW: No rail so do the interpolation from 
                        ; the first set of boundaries

RailLoFDpw:
    movw interpZ1,FDpw  ; Move Low PW to "FDpw"  
    bra  AddDeadband    ; Branch to AddDeadband:
    
RailHiFDpw:
    movw interpZ2,FDpw  ; Move High PW to "FDpw"
    bra  AddDeadband    ; Branch to AddDeadband:
    
;*****************************************************************************************
; No rail so do the negative interpolation from the first set of boundaries
;*****************************************************************************************
    
InterpPrimePW:
    jsr  INTERP       ; Jump to INTERP subroutine 
    movw interpZ,FDpw ; Result -> "FDpw" (fuel delivery pulsewidth (mS x 10)
    bra  AddDeadband  ; Branch to AddDeadband:    

;*****************************************************************************************
; CLTx10 is positive. Prepare to interpolate from the rest of the boundaries
;***************************************************************************************** 
    
PrimeTempPos:
    movw #veBins_R,CrvPgPtr ; Address of the first value in VE table(in RAM)(page pointer) 
                            ; ->page where the desired curve resides 
    movw #$0148,CrvRowOfst  ; 328 -> Offset from the curve page to the curve row
	                          ; (tempTable2)Actual offset is 656)
    movw #$0164,CrvColOfst  ; 356 -> Offset from the curve page to the curve column
	                          ; (primePWTable)(actual offset is 712)
    movw Cltx10,CrvCmpVal   ; Engine Coolant Temperature (Degrees F x 10) -> 
                            ; Curve comparison value
    movb #$09,CrvBinCnt     ; 9 -> number of bins in the curve row or column minus 1
    jsr   CRV_LU_NP         ; Jump to CRV_LU_NP subroutine   
    movw interpZ,FDpw       ; Result -> "FDpw" (fuel delivery pulsewidth (mS x 10)
    
AddDeadband:
    ldd  FDpw               ; "FDpw" -> Accu D
  	addd Deadband           ; (A:B)+(M:M+1)->A:B ("FDpw"+"Deadband"="PrimePW"
	std  PrimePW            ; Result -> "PrimePW" (primer injector pulsewidth) (mS x 10)
	  	
;*****************************************************************************************
; - Convert to timer ticks in 5.12uS resolution.
;*****************************************************************************************

    ldd   PrimePW    ; "PrimePW" -> Accu D
	ldy   #$2710     ; Load index register Y with decimal 10000 (for integer math)
  	emul             ;(D)x(Y)=Y:D "PW" * 10,000
	ldx   #$200      ; Decimal 512 -> Accu X
    ediv             ;(Y:D)/(X)=Y;Rem->D "PW" * 10,000 / 512 = "PWtk" 
    sty   PrimePWtk  ; Copy result to "PrimePWtk" (Priming pulse width in 5.12uS 
	                 ; resolution)
    sty   InjOCadd2  ; Second injector output compare adder (5.12uS res)
	movw  PrimePWtk,InjOCadd2 ; Copy value in "primePWtk" to "InjOCadd2" (Primer pulse width 
	                           ; in 5.12uS res to injector timer output compare adder)
  
;*****************************************************************************************

;*****************************************************************************************
; - In the initialization section, Port T PT3,4,5,6,7 and all Port P pins are set as outputs  
;   initial setting low. To control both the ignition and injector drivers two interrupts  
;   are required for each ignition or injection event. At the appropriate crank angle   
;   and cam phase an interrupt is triggered. In this ISR routine the channel output compare 
;   register is loaded with the delay value from trigger time to the time desired to  
;   energise the coil or injector and the channel interrupt is enabled. When the output  
;   compare matches, the pin is commanded high and the timer channel interrupt is triggered.  
;   The output compare register is then loaded with the value to keep the coil or injector 
;   energised. When the output compare matches the pin is commanded low to fire the coil 
;   or de-energise the injector.  
;*****************************************************************************************

;*****************************************************************************************
; - Pulse Inj1 (Cylinders 1&10) with value in "primePWtk"
;*****************************************************************************************

    movw  #$0002,InjOCadd1 ; First injector output compare delay adder 
    jsr  FIRE_INJ1         ; Jump to FIRE_INJ1 subroutine  
    
;*****************************************************************************************
; - Pulse Inj2 (Cylinders 9&4) with value in "primePWtk"
;*****************************************************************************************

    movw  #$0004,InjOCadd1  ; First injector output compare adder (increaed from previous 
                            ; injector delay to prevent OC interrupt collision)
    jsr  FIRE_INJ2          ; Jump to FIRE_INJ2 subroutine
       
;*****************************************************************************************
; - Pulse Inj3 (Cylinders 3&6) with value in "primePWtk"
;*****************************************************************************************

    movw  #$0006,InjOCadd1  ; First injector output compare adder (increaed from previous 
                            ; injector delay to prevent OC interrupt collision)
    jsr  FIRE_INJ3          ; Jump to FIRE_INJ3 subroutine
    
;*****************************************************************************************
; - Pulse Inj4 (Cylinders 5&8) with value in "primePWtk"
;*****************************************************************************************

    movw  #$0008,InjOCadd1  ; First injector output compare adder (increaed from previous 
                            ; injector delay to prevent OC interrupt collision)
    jsr  FIRE_INJ4          ; Jump to FIRE_INJ4 subroutine
    
;*****************************************************************************************
; - Pulse Inj5 (Cylinders 7&2) with value in "primePWtk"
;*****************************************************************************************

    movw  #$000A,InjOCadd1  ; First injector output compare adder (increaed from previous 
                            ; injector delay to prevent OC interrupt collision)
    jsr  FIRE_INJ5          ; Jump to FIRE_INJ5 subroutine
    
;*****************************************************************************************
; - Set up the "engine" bit field in preparation for cranking.
;*****************************************************************************************

   bset engine,crank   ; Set the "crank" bit of "engine" bit field
   bclr engine,run     ; Clear the "run" bit of "engine" bit field
   bset engine,WUEon   ; Set "WUEon" bit of "engine" bit field
   bset engine,ASEon   ; Set "ASEon" bit of "engine" bit field
   clr  ASEcnt         ; Clear the after-start enrichment counter variable
   
;*****************************************************************************************
; - Load stall counter with compare value. Stall check is done in the main loop every 
;   mSec. "Stallcnt" is decremented every mSec and reloaded at every crank signal.
;*****************************************************************************************
								 
    ldy   #veBins_R     ; Load index register Y with address of first configurable 
                        ; constant in RAM page 1 (vebins)
    ldd   $0352,Y       ; Load Accu A with value in buffer RAM page 1 offset 850 
                        ; "Stallcnt" (stall counter)(offset = 998) 
    std  Stallcnt       ; Copy to "Stallcnt" (no crank or stall condition counter)
                        ; (1mS increments)
                        
;*****************************************************************************************
; -------------------------- After Start Enrichment (ASEcor)------------------------------
;
; Immediately after the engine has started it is normal to need additional fuel for a  
; short period of time. "ASEcor"specifies how much fuel is added as a percentage. It is   
; interpolated from the After Start Enrichment table which plots engine temperature in 
; degrees F to 0.1 degree resoluion against percent to 0.1 percent resolution and is added 
; to "WUEcor" as part of the calculations to determine pulse width when the engine is 
; running.
;  
;*****************************************************************************************
;*****************************************************************************************
; - Look up current value in Afterstart Enrichment Percentage Table (ASEcor)   
;*****************************************************************************************  

    jsr  ASE_COR_LU   ; Jump to ASE_COR_LU subroutine

;*****************************************************************************************
; ----------------------- After Start Enrichment Taper (ASErev)---------------------------
;
; After Start Enrichment is applied for a specified number of engine revolutions after 
; start up. This number is interpolated from the After Start Enrichment Taper table which 
; plots engine temperature in degrees F to 0.1 degree resoluion against revolutions. 
; The ASE starts with the value of "ASEcor" first and is linearly interpolated down to 
; zero after "ASErev" crankshaft revolutions.
;
;*****************************************************************************************
;*****************************************************************************************
; - Look up current value in Afterstart Enrichment Taper Table (ASErev)   
;*****************************************************************************************

    jsr  ASE_TAPER_LU   ; Jump to ASE_TAPER_LU subroutine
    
    movw ASErev,ASEcnt  ; Copy "ASErev" to "ASEcnt" (initial counter value) 
    
    

    
 
;*****************************************************************************************
;*****************************************************************************************
;************************* --- M A I N  E V E N T  L O O P --- ***************************
;*****************************************************************************************
;*****************************************************************************************
; - Main loop subsection
;   - Misc
;     - Check for Flash Erase and Burn command
;     - mS routines
;     - mS20 routines
;     - mS100 routines
;     - mS 1000 routines
;     - Update Portbits
;     - RPM calculations
;     - KPH calculations
;   - Ignition
;     - Dwell correction lookup
;     - ST table lookup
;     - Ignition calculations
;
;   - Fuel 
;     - Deadband calculations
;     - WUE correction lookup
;     - Barometric pressure correction lookup
;     - Manifold Air Temperature correction lookup
;     - VE table lookup
;     - AFR table lookup
;     - Crank mode calculations
;     - Run mode calculations
;     - ASE correction interpolation
;     - Throttle Opening Enrichment calculations
;     - Overrun Fuel Cut calculations
;     - Duty cycle calculations
;     - Fuel burn calculations
;     - Increment loop counter
;
;*****************************************************************************************

MainLoop:

;    bset PORTB,#$04  ;PB2 spare sink Sim LED
;    bset PORTB,#$40  ;PB6 spare source Sim LED
;    bset PORTK,#$02  ;PK1 spare source Sim LED
;    bclr PORTB,#$04  ;PB2 spare sink Sim LED
;    bclr PORTB,#$40  ;PB6 spare source Sim LED
;    bclr PORTK,#$02  ;PK1 spare source Sim LED

;*****************************************************************************************
;* - NOTE! I CAN'T GET MY BURNER CODE TO WORK WITH TUNER STUDIO SO I'M COMMENTING IT OUT
;*****************************************************************************************
    
;    brclr engine2,ErsBrn,NoErsBurn  ; If "ErsBrn" bit0 of "engine2" is clear, branch to
                                    ; NoErsBurn: (no command sent so fall through)
;    sei                             ; Set interrupt mask (disable interrupts)
;    jsr  EraseBurn                  ; Jump to the Flash erase and burn routine
    
;*****************************************************************************************
; - The Erase and Burn subroutine disables the interrupts until the routine is completed.
;   This of course stops the engine if it had been running. This next instruction brings 
;   things back to a point where the engine can be restarted. 
;*****************************************************************************************
    
;    jmp  PostEnB  ; Jump to PostEnB: to get things going again 
	
;NoErsBurn:
                                     
;*****************************************************************************************
; - Every mS:
;   Decrement "AIOTcnt" (AIOT pulse width counter)
;   Decrement "Stallcnt" (stall counter) 
;   Check for no crank or stall condition.
;***************************************************************************************** 

    brclr clock,ms1,NoMS1Routines ; If "ms1" bit of "clock" bit field is clear branch 
                                  ; to NoMS1Routines1:
    jsr  MILLISEC_ROUTINES        ; Jump to MILLISEC_ROUTINES subroutine 
  	bclr clock,ms1                ; Clear "ms1" bit of "clock" bit field

NoMS1Routines:	

;*****************************************************************************************
; - Every 20mS:
;   Check to see if a change in idle speed has been commanded. 
;***************************************************************************************** 

    brclr clock,ms20,NoMS20Routines ; If "ms20" bit of "clock" bit field is clear branch 
                                    ; to NoMS20Routines:
    jsr  MILLISEC20_ROUTINES        ; Jump to MILLISEC20_ROUTINES subroutine 
  	bclr clock,ms20                 ; Clear "ms20" bit of "clock" bit field

NoMS20Routines:	  
	
;*****************************************************************************************
; - Every 1000mS:
;   Save the current value of "LoopCntr" as "LoopTime" (loops per second) 
;   Save the current fuel delivery total ("FDt") as "FDsec" so it can be used by Tuner 
;   Studio and Shadow Dash for fuel burn calculations
;*****************************************************************************************

    brclr clock,ms1000,NoMS1000Routines ; If "ms1000" bit of "clock" bit field is clear  
                                        ; branch to NoMS1000Routines: 
    jsr  MILLISEC1000_ROUTINES          ; Jump to MILLISEC100o_ROUTINES subroutine
  	bclr clock,ms1000                   ; Clear "ms1000" bit of "clock" bit field
	
NoMS1000Routines:

;*****************************************************************************************
; - Update Ports A, B, K, P and T status bits
;*****************************************************************************************
  
    ldaa PORTA      ; Load accu A with value in Port A
    staa PortAbits  ; Copy to "PortAbits"
    ldaa PORTB      ; Load accu A with value in Port B
    staa PortBbits  ; Copy to "PortBbits"
    ldaa PORTK      ; Load accu K with value in Port K
    staa PortKbits  ; Copy to "PortKBits"
    ldaa PTP        ; Load accu A with value in Port P
    staa PortPbits  ; Copy to "PortPbits"
    ldaa PTT        ; Load accu A with value in Port T
    staa PortTbits  ; Copy to "PortTbits"

;*****************************************************************************************    
;- If ATD0 has completed its sequence read the ADCs and convert to user units, otherwise 
;  skip over
;*****************************************************************************************

    brclr ATD0STAT0,ATD0STAT0_SCF,NoSeqCmplt  ; If the Sequence Cpmplete Flag is not set, 
                                              ; branch to NoSeqCmplt:
    bset  ATD0STAT0,#80 ; Set the Sequence Complete Flag bit7 of ATD0STAT0 to clear flag
    jsr   READ_ATD0     ; Jump to READ_ATD0 subroutine
    jsr   CONVERT_ATD0  ; Jump to CONVERT_ATD0 subroutine
    
NoSeqCmplt:

;*****************************************************************************************
; - Do RPM calculations when there is a new input capture period.                           
;*****************************************************************************************

   brclr ICflgs,RPMcalc,NoRPMcalc ; If "RPMcalc" bit of "ICflgs" is clear, 
                                  ; branch to "NoRPMcalc:"(bit is set in ECT_TC1_ISR 
								  ; Interrupt Service Routine (Crankshaft sensor notch) 
								  ; and cleared here)
								   
;*****************************************************************************************
;
; RPM = CONSTANT/PERIOD
; Where:
; RPM    = Engine RPM
; RPMk   = 24 bit constant using 5.12uS IC clock tick (195,312.5khz)
;             ((195,312.5 tickpsec*60secpmin)/(360/72))
; CASprd512 = 16 bit period count between three consecutive IC events in 5.12uS
;               resolution
;   RPMk
;   ----- = RPM
;   CASprd512
;
; RPMk = ((195,312.5*60)/5) = 2,343,750 = $0023 C346
;
;*****************************************************************************************
;*****************************************************************************************
; - Do RPM calculations for 5.12uS time base when there is a new input capture period
;   using 32x16 divide                            
;*****************************************************************************************

    ldd  #$C346         ; Load accu D with Lo word of  10 cyl RPMk (5.12uS clock tick)
    ldy  #$0023         ; Load accu Y with Hi word of 10 cyl RPMk (5.12uS clock tick)
    ldx  CASprd512      ; Load "X" register with value in "CASprd512"
    ediv                ; Extended divide (Y:D)/(X)=>Y;Rem=>D 
	                    ;(Divide "RPMk" by "CASprd512")
    sty   RPM           ; Copy result to "RPM"
	bclr ICflgs,RPMcalc ; Clear "RPMcalc" bit of "ICflgs"
	                      
;;*****************************************************************************************	                      
;;*****************************************************************************************
;; - There are 5 input capture periods to calculate RPM in each crankshaft revolution. 
;;   There is a certain amount of "jitter" in the individual calculations so I average the 
;;   RPM over 5 iterations to smooth out the results. COMMENTED OUT 2/03/22 
;;*****************************************************************************************
;	                      
;    sty   RPMaddend ; Copy result to "RPMaddend"
;    ldd   RPMaddend ; Load accumulator with value in RPMaddend 
;    addd  RPMsum    ;(A:B)+(M:M+1)->A:B Add value in RPMaddend with value in "RPMsum"
;    std   RPMsum    ; Copy result to "RPMsum" (update "RPMsum")
;    inc   RPMcnt    ; Increment "RPMcnt" (increment counter to average "RPM")
;    ldaa  RPMcnt    ; Load Accu A with value in "RPMcnt"
;    cmpa  #$05      ; (A)-(M) (Compare "RPM" with decimal 5)
;    beq   AVRPM     ; If equal branch to AVRPM:
;    bra   RPMadding ; Branch to RPMadding (compare not equal so fall through)
;    
;AVRPM:
;    clr   RPMcnt    ; Clear "RPMcnt" (ready to start count again)
;    ldd   RPMsum    ; Load accumulator with value in "RPMsum" 
;    ldx   #$05      ; Load Accu X with decimal 5
;    idiv            ; (D)/(X)->X Rem->D ("RPMsum / 5)
;    stx   RPM       ; Copy result to "RPM"
;    clrw  RPMsum    ; Clear "RPM" (ready to start sum again)
;    clrw  RPMaddend ; Clear "RPMaddend" (ready to start sum again)
;
;    
;RPMadding:
;    bclr ICflgs,RPMcalc ; Clear "RPMcalc" bit of "ICflgs"
    
NoRPMcalc:
	
;*****************************************************************************************
; - Do KPH calculations when there is a new input capture period.                           
;*****************************************************************************************

    brclr ICflgs,KpHcalc,NoKPHcalc ; If "KpHcalc" bit of "ICflgs" is clear,
                                   ; branch to "NoKPHcalc:"(bit is set and cleared in 
								   ; ECT ch2 Interrupt Service Routine)

;*****************************************************************************************
;
; KPH = CONSTANT/PERIOD
; Where:
; KPH         = Vehicle speed in Kilometers per Hour
; KPHk = 19 bit constant using 5.12uS IC clock tick (195.3125khz)
;             ((195,312.5 tickpsec*60secpmin*60minphr)/4844 pulsepkm
; VSSprd512 = 16 bit period count between consecutive IC events in 5.12uS
;               resolution. 4844 pulse per KM
;   KPHk
;   ----- = KPH
;   VSSprd512
;
; KPHk = ((195,312.5*60*60)/4844) = 145,153.7985 = $0002 3702
; 145154 / 65535 = min 2.214908064 KPH
; Resolution @ 100KPH = .069KM
;
;*****************************************************************************************
;*****************************************************************************************
; - Do KPH calculations for 5.12uS time base when there is a new input capture period
;   using 32x16 divide 
; - NOTE! for KPH in 0.1KPH resolution use 1,451,538 $0016 2612 for KPHk.                         
;*****************************************************************************************

RunKPH:
    ldd  #$2612         ; Load accu D with Lo word of KPHk
    ldy  #$0016         ; Load accu Y with Hi word of KPHk
    ldx  VSSprd512      ; Load "X" register with value in "VSSprd512"
    
CalcKPH:
    ediv                ; Extended divide (Y:D)/(X)=>Y;Rem=>D (Divide "KPHk" by "VSSprd512")
    sty  KPH            ; Copy result to "KPH" (KPH*10)
    bclr ICflgs,KpHcalc ; Clear "KpHcalc" bit of "ICflgs"
	
NoKPHcalc:

;*****************************************************************************************
;                               CURRENT GEAR CALCULATIONS
;*****************************************************************************************
;														
; Pulse per Km	4844						
; Wheel dia	0.7740000 m					
; Wheel Circ	2.4325714 m					
; Wheel circ	0.0024326 Km					
;							
; K factor = (60 / total ratio) x wheel circumferance in Km							
; Vehicle Speed / RPM = K factor
; K factor x RPM = Vehicle Speed 							
; Vehicle Speed / K factor = RPM 
;
; Final Drive ratio	3.54	Total ratio	K factor	   Vehicle Speed at 2000 RPM			
; 1st gear ratio	5.61	19.8594     0.007349466751 14.7	 Kph		
; 2nd gear ratio	3.04	10.7616     0.013562667	   27.2	 Kph		
; 3d gear ratio	    1.67	5.9118      0.024688927	   49.4	 Kph		
; 4th gear ratio	1.00	3.54        0.041230508	   82.5	 Kph		
; 5th gear ratio	0.74	2.6196      0.055716903	   111.4 Kph	
; Rev gear ratio	5.61	19.8594     0.007349466751 14.7	 Kph
; Low range ratio   2.72    54.017568   0.002702009835 5.4   Kph in first or reverse	
;
; For integer math multiply vehicle speed by 65535							
; 
; Final Drive ratio	3.54	Total ratio	K factor VSS x 65535 at 550 RPM			
; 1st gear ratio	5.00	19.8594	    482	     264906			
; 2nd gear ratio	3.04	10.7616	    889	     488950			
; 3d gear ratio	    1.67	5.9118	    1618	 889900			
; 4th gear ratio	1.00	3.54	    2702	 1486100			
; 5th gear ratio	0.74	2.6196	    3651	 2008050
; Rev gear ratio	5.61	19.8594     482	     264906
; Low range ratio   2.72    54.017568   177      97392 in first or reverse				
; 
; Use mid points of ratio K factors to eliminate errors 							
;
; First/Rev Lo	  K fac	 				
;	              177	    	  
; First/Rev       K fac, mid point = 358 = $0166 					
;	              540	    		  
; Second Gear     K fac, mid point = 715 = $02CB 					
;	              889	    		 
; Third Gear  	  K fac, mid point = 1254 = $4E6 	 				
;	              1618	     		  
; Forth Gear	  K fac, mid point = 2160 = $0870 	 				
;	              2702	     		 
; Fifth Gear	  K fac, mid point = 3176 = $0C68 	 				
;	              3651	     		  
;
;*****************************************************************************************
;*****************************************************************************************
; If engine and vehicle speeds are high enough, do current gear calculations
;*****************************************************************************************

    ldd  RPM            ; "RPM" -> Accu D
    cpd #$005A          ; Compare "RPM" with decimal 90 (90 RPM)
    lblo  NoGearCalcs   ; If less than decimal 90 branch to NoGearCalcs:
    ldd  KPH            ; "KPH" -> Accu D (KPH is KpH x 10)
 	cpd #$001A          ; Compare "KPH" with decimal 30 (3.0 KpH)
    lblo  NoGearCalcs   ; If less than decimal 5 branch to NoGearCalcs:
    ldx #$000A          ; Decimal 10-> Accu X
    idiv                ; (D)/(X)->X Rem D
    tfr  X,D            ; (X)->(D) (KPH/10 -> Accu D)
    ldy  #$FFFF         ; 65535 -> Accu Y
  	emul                ; (D)x(Y)->Y:D (KPH/10) x 65535) (for integer math)
    ldx  RPM            ; "RPM"-> Accu X
  	ediv                ; (Y:D)/(X)->Y rem D (KpH x 65535)/RPM)
    cpy  #$0166         ; Compare result with decimal 358 (mid point)
	bls  FirstRevLo     ; If lower or same as 358 branch to FirstRevLo:
  	cpy  #$02CB         ; Compare result with decimal 715 (mid point)
	bls  FirstRev       ; If lower or same as 715 branch to FirstRev:
    cpy  #$04E6         ; Compare result with decimal 1254 (mid point)
    bls  SecondGear     ; If lower or same as 1254 branch to SecondGear
    cpy #$0870          ; Compare result with decimal 2160 (mid point)
  	bls  ThirdGear      ; If lower or same as 2160 branch to ThirdGear:
    cpy #$0C68          ; Compare result with decimal 3176 (mid point)
  	bls  ForthGear      ; If lower or same as 3176 branch to ForthGear:
    bra  FifthGear      ; Branch to FifthGear: (K factor x 65535 is greater than 
                        ; 3176 so we must be in 5th gear) 
                        
FirstRevLo:
    movb #$06,GearCur   ; Decimal 6 -> "GearCur"
    bra  GearCalcsDone  ; Branch to GearCalcsDone:
    
FirstRev:
    movb #$01,GearCur   ; Decimal 1 -> "GearCur"
    bra  GearCalcsDone  ; Branch to GearCalcsDone:
    
SecondGear:
    movb #$02,GearCur   ; Decimal 2 -> "GearCur"
    bra  GearCalcsDone  ; Branch to GearCalcsDone:;ThirdGear:
    
ThirdGear:
    movb #$03,GearCur   ; Decimal 3 -> "GearCur"
    bra  GearCalcsDone  ; Branch to GearCalcsDone:
    
ForthGear:
    movb #$04,GearCur   ; Decimal 4 -> "GearCur"
    bra  GearCalcsDone  ; Branch to GearCalcsDone:
    
FifthGear:
    movb #$05,GearCur   ; Decimal 5 -> "GearCur"
    bra  GearCalcsDone  ; Branch to GearCalcsDone:
    
NoGearCalcs:
    movb #$00,GearCur   ; Decimal 0 -> "GearCur"
    
GearCalcsDone:
	
;*****************************************************************************************
;                                  IGNITION SECTION
;*****************************************************************************************
;*****************************************************************************************
;
; - Ignition timing in degrees to 0.1 degree resolution is selected from the 3D 
;   lookup table "ST" which plots manifold pressure against RPM. A potentiometer on the 
;   dash board allows a manual trim of the "ST" values of from 0 to 20 degrees advance 
;   and from 0 to 20 degrees retard. The ignition system is what is called "waste spark", 
;   which pairs cylinders on a single coil. The spark is delivered to both cylinders at 
;   the same time. One cylinder recieves the spark at the appropriate time for ignition. 
;   The other recieves it when the exhaust valve is open. Hence the name "waste spark".
;   On this 10 cylinder engine there are 5 coils, each controlled by its own hardware 
;   timer. The cylinders are paired 1&6, 10&5, 9&8, 4&7, 3&2
;   In an ignition event the timer is first loaded with the output compare value in 
;   "Delaytk". At the compare interrupt the coil is energised and the timer is loaded
;   with the output compare value in "DwllFintk". At the compare interrupt the coil is 
;   de-energized to fire the spark. During cranking the coil on (dwell) and coil off
;   (spark time) are called at specific crank trigger notches for absolute low RPM accuracy.
;
;*****************************************************************************************
;*****************************************************************************************
; - Look up current value in Dwell Battery Adjustment Table (dwellcor)(% x 10)    
;*****************************************************************************************

    movw #veBins_R,CrvPgPtr ; Address of the first value in VE table(in RAM)(page pointer) 
                            ;  ->page where the desired curve resides 
    movw #$0132,CrvRowOfst  ; 306 -> Offset from the curve page to the curve row(dwellvolts)
	                          ;(actual offset is 612
    movw #$0138,CrvColOfst  ; 312 -> Offset from the curve page to the curve column(dwellcorr)
	                          ;(actual offset is 624)
    movw BatVx10,CrvCmpVal  ; Battery Voltage (Volts x 10) -> Curve comparison value
    movb #$05,CrvBinCnt     ; 5 -> number of bins in the curve row or column minus 1
    jsr   CRV_LU_NP         ; Jump to subroutine at CRV_LU_NP:
    movw interpZ,DwellCor   ; Copy result to Dwell battery correction (% x 10)

;*****************************************************************************************
; - Look up current value in ST table (STcurr) (degrees*10)
;*****************************************************************************************

    ldx   Mapx10        ; Load index register X with value in "Mapx10"(Column value Manifold  
                        ; Absolute Pressure*10 )
    ldd   RPM           ; Load double accumulator D with value in "RPM" (Row value RPM)
    ldy   #stBins_R     ; Load index register Y with address of the first value in ST table
    jsr   D3_LOOKUP     ; Jump to subroutine at 3D_LOOKUP:
    movw interpZ,STcurr ; Copy result to "STcurr"
;***	  movw #$0078,STcurr  ; 12 degrees -> STcurr (for test purposes only)                              TEMPORARY TEST !!!!!!

;*****************************************************************************************
; - Convert the Igntion Span(170 degrees) to time in 5.12uS resolution (Spantk)
; Roll over will occur at:
; 65535 x .00000512 = 0.3355392 Sec
; 1 / 0.3355392 = 2.980277714 Hz
; 2.980277714 x 60 = 178.8166629 RPM
; 178.8166629 x (170/360) = 84.44120193 RPM
;*****************************************************************************************

    ldy  Degx10tk512  ;(Time for 1 degree of rotation in 5.12uS resolution x 10)
    ldd  #$06A4       ; Decimal 1700 -> Accu D (170 *10 for 0.1 degree resolution calcs)   
    emul              ;(D)x(Y)=Y:D "1700" * Degx10tk512 
	ldx  #$0064       ; Decimal 100 -> Accu X
	ediv              ;(Y:D)/(X)=Y;Rem->D (("STandItrmx10" * Degx10tk512)/100 = "Spantk"
    sty  Spantk       ; Copy result to "Spantk"
                      
;******************************************************************************************
; - Multiply dwell time (mS*10) by the correction and divide by 1000 (%*10)("DwellFin")
;******************************************************************************************

    ldy  #stBins_R     ; Load index register Y with address of first configurable constant
                       ; on buffer RAM page 2 (stBins_R)
    ldd  $0240,Y       ; Load Accu D with value in RAM page 2 offset 576 ("Dwell") 
    ldy  DwellCor      ; "DwellCor" -> Accu Y (%*10)
    emul               ;(D)x(Y)=Y:D "Dwell" * "DwellCor" 
    ldx  #$03E8        ; Decimal 1000 -> Accu Y (for integer math)
    ediv               ; (Y:D)/(X)=Y;Rem->D (("Dwell" * "DwellCor")/1000) = "DwellFin"
    sty  DwellFin      ; Copy result to "DwellFin
	
;******************************************************************************************
; - Convert "DwellFin" to time in 5.12uS resolution.("DwellFintk") 
;******************************************************************************************

	ldd   DwellFin      ; "DwellFin" -> Accu D
	ldy   #$2710        ; Load index register Y with decimal 10000 (for integer math)
	emul                ;(D)x(Y)=Y:D "DwellFin" * 10,000
    ldx   #$200         ; Load index register X decimal 512
    ediv                ;(Y:D)/(X)=Y;Rem->D ("DwellFin" * 10,000) / 512 = "DwellFintk"
    sty   DwellFintk    ; Copy result to "DwellFintk" (Time required for dwell after 
	                    ; correction in 5.12uS resolution 
    sty   IgnOCadd2     ; Copy result to "IgnOCadd2" (Time required for dwell after 
	                    ; correction in 5.12uS resolution 
                        ; This is the second OC value loaded into the timer
						
;*****************************************************************************************
; - Correct the current ST value for trim (degrees*10)("STandItrmx10")
;*****************************************************************************************

    ldd   STcurr      ; Current value in ST table (Degrees x 10) -> Accu D
    addd  #$00C8      ; (A:B)+(M:M+1)->A:B "STdeg" + decimal 200 = "Igncalc1" (Degrees*10)
    addd  Itrmx10     ; (A:B)+(M:M+1)->A:B "Igncalc1" + Itrm10th) = "Igncalc2" (Degrees*10)
    subd  #$00C8      ; Subtract (A:B)-(M:M+1)=>A:B  "Igncalc2" - decimal 200 = "STandItrm" 
	                  ;(Degrees*10)
	std  STandItrmx10 ; Copy result to "STandItrmx10"(Degrees*10)

;*****************************************************************************************
; - Convert "STandItrmx10" to time in 5.12uS resolution ("STandItrmtk")
;*****************************************************************************************

    ldy  Degx10tk512  ;(Time for 1 degree of rotation in 5.12uS resolution x 10)
    emul              ;(D)x(Y)=Y:D "STandItrmx10" * Degx10tk512 
	ldx  #$0064       ; Decimal 100 -> Accu X
  	ediv              ;(Y:D)/(X)=Y;Rem->D (("STandItrmx10" * Degx10tk512)/100 
	                  ; = "Spantk"
	sty  STandItrmtk  ; Copy result to "STandItrmtk"		

;*****************************************************************************************
; - Add "STandItrmtk" and "DwellFintk" = "Advancetk"  
;*****************************************************************************************

    ldd   STandItrmtk     ; "STandItrmtk" -> Accu D 
    addd  DwellFintk      ; (A:B)+(M:M+1)->A:B "STandItrmtk" + "DwellFintk" = "Advancetk"
    std   Advancetk       ; Copy result to "Advancetk" 

;*****************************************************************************************
; - Subtract "Advancetk" from "Spantk" = "Delaytk" 
;*****************************************************************************************

    ldd   Spantk     ; "Spantk" -> Accu D
    subd  Advancetk  ; Subtract (A:B)-(M:M+1)=>A:B "Spantk" - "Advancetk" = "Delaytk"
	std   Delaytk    ; Copy result to "Delaytk" 
	std   IgnOCadd1  ; Copy result to "IgnOCadd1" 
                     ; This is the first OC value loaded into the timer
					 
IgnCalcsDone:

;*****************************************************************************************
;                              END OF IGNITION SECTION
;*****************************************************************************************

;*****************************************************************************************
;                                  FUEL SECTION
;*****************************************************************************************
;*****************************************************************************************
; - Interpolate injector deadband at current battery voltage
;*****************************************************************************************

    jsr   DEADBAND_CALCS  ; Jump to DEADBAND_CALCS subroutine
    
;*****************************************************************************************
; ---------------------------- Warm Up Enrichment (WUEcor)--------------------------------
;
; Warm Up Enrichment is applied until the engine is up to full operating temperature.
; "WUEcor" specifies how much fuel is added as a percentage. It is interpolated from the   
; Warm Up Enrichment table which plots engine temperature in degrees F to 0.1 degree 
; resoluion against percent to 0.1 percent resolution and is part of the calculations 
; to determine pulse width when the engine is running.
;
;*****************************************************************************************
;*****************************************************************************************
; - Look up current value in Warmup Enrichment Table (WUEcor) 
;*****************************************************************************************

;*****************************************************************************************
; First check to see if CLTx10 is negative
;*****************************************************************************************

    ldx  Cltx10        ; Engine Coolant Temperature (Degrees F x 10) -> X    
    andx #$8000        ; Logical AND X with %1000 0000 0000 0000 (CCR N bit set of MSB of 
                       ; of MSB of result is set)
    bmi  WUEcorTempNeg ; If N bit of CCR is set, branch to WUEcorTempNeg:
    bra  WUEcorTempPos ; Branch to WUEcorTempPos:
    
;*****************************************************************************************
; CLTx10 is negative. Prepare to interpolate from the first boundaries
;*****************************************************************************************

WUEcorTempNeg:
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $027C,Y     ; Load Accu X with value in RAM page 1 (offset 636)($027C) 
                      ; ("tempTable1" first address)(Low temperature)
    stx  interpV1     ; Copy to "interpV1"
    ldx  Cltx10       ; "CltX10" -> Accu X
    stx  interpV      ; Copy to "interpV"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $027E,Y     ; Load Accu X with value in RAM page 1 (offset 638)($027E) 
                      ; ("tempTable1" second address)(High temperature)
    stx  interpV2     ; Copy to "interpV2"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0318,Y     ; Load Accu X with value in RAM page 1 (offset 792)($0318) 
                      ; ("wueBins" first address)(Low %)
    stx  interpZ1     ; Copy to "interpZ1"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $031A,Y     ; Load Accu X with value in RAM page 1 (offset 794)($031A) 
                      ; ("wueBins" second address)(High %)
    stx  interpZ2     ; Copy to "interpZ2"

;*****************************************************************************************
; Check if we should rail low
;*****************************************************************************************
    
    ldx  Cltx10         ; "Cltx10" -> Accu X
    cpx  interpV1       ; Compare Cltx10 with Low temperature
    bls  RailLoWUEcor   ; If "Cltx10" is the same or less than Low temperature branch to 
                        ; RailLoWUEcor:
    
;*****************************************************************************************
; Check if we should rail high
;*****************************************************************************************

    cpx  interpV2       ; Compare Cltx10 with High temperature
    bhs  RailHiWUEcor   ; If "Cltx10" is the same or higher than High temperature, branch 
                        ; to RailHiWUEcor:
    bra  InterpWUEcor   ; Branch to InterpWUEcor: (No rail so do the interpolation from
                        ; first set of boundaries 
RailLoWUEcor:
    movw interpZ1,WUEcor ; Move Low % to "WUEcor"  
    bra  WUEcorDone      ; Branch to WUEcorDone: 
    
RailHiWUEcor:
    movw interpZ2,WUEcor ; Move High % to "WUEcor"
    bra  WUEcorDone      ; Branch to WUEcorDone:
    
;*****************************************************************************************
; No rail so do the negative interpolation from the first set of boundaries
;*****************************************************************************************

InterpWUEcor:
    jsr  INTERP         ; Jump to INTERP subroutine 
    movw interpZ,WUEcor ; Result -> "WUEcor" 
	bra  WUEcorDone     ; Branch to WUEcorDone:
	  
;*****************************************************************************************
; CLTx10 is positive. Prepare to interpolate from the rest of the boundaries
;*****************************************************************************************

WUEcorTempPos:
    movw #veBins_R,CrvPgPtr ; Address of the first value in VE table(in RAM)(page pointer) 
                            ; ->page where the desired curve resides 
    movw #$013E,CrvRowOfst  ; 318 -> Offset from the curve page to the curve row
	                        ; (tempTable1)(actual offset is 636
    movw #$018C,CrvColOfst  ; 396 -> Offset from the curve page to the curve column(
	                          ; wueBins)(actual offset is 792)
    movw Cltx10,CrvCmpVal   ; Engine Coolant Temperature (Degrees F x 10) -> 
                            ; Curve comparison value
    movb #$09,CrvBinCnt     ; 9 -> number of bins in the curve row or column minus 1
    jsr   CRV_LU_NP         ; Jump to subroutine at CRV_LU_NP: 
    movw interpZ,WUEcor     ;  Copy result to Warmup Enrichment Correction (% x 10)
    
WUEcorDone:
    ldd  WUEcor             ; "WUEcor" -> Accu D
    cpd  #$03E8             ; Decimal 1000 (100.0%) 
    beq  NoWUE              ; If "WUEcor" has been reduced to 100.0 %, branch to NoWUE:
    bset engine,WUEon       ; Set "WUEon" bit of "engine" bit field
    bra  FinWUE             ; Branch to FinWUE:
    
NoWUE:
    bclr engine,WUEon       ; Clear "WUEon" bit of "engine" bit field
    
FinWUE:
    
;*****************************************************************************************
; - Look up current value in Barometric Correction Table (barocor) 
;*****************************************************************************************

    movw #veBins_R,CrvPgPtr ; Address of the first value in VE table(in RAM)(page pointer) 
                            ; -> page where the desired curve resides 
    movw #$0120,CrvRowOfst  ; 288 -> Offset from the curve page to the curve row(barCorVals)
	                        ; (actual offset is 576)
    movw #$0129,CrvColOfst  ; 297 -> Offset from the curve page to the curve column(barCorDelta)
	                        ; (actual offset is 594)
    movw Barox10,CrvCmpVal  ; Barometric Pressure (KPAx10) -> Curve comparison value
    movb #$08,CrvBinCnt     ; 8 -> number of bins in the curve row or column minus 1
    jsr   CRV_LU_NP         ; Jump to subroutine at CRV_LU_NP:
    movw interpZ,barocor    ; Copy result to Barometric correction (% x 10)
    
;*****************************************************************************************
; - Look up current value in MAT Air Density Table (matcor)           
;*****************************************************************************************

;*****************************************************************************************
; First check to see if Matx10 is negative
;*****************************************************************************************

    ldx  Matx10          ; Manifold Air  Temperature (Degrees F x 10) -> X    
    andx #$8000          ; Logical AND X with %1000 0000 0000 0000 (CCR N bit set of MSB of 
                         ; of MSB of result is set)
    bmi  matcorTempNeg   ; If N bit of CCR is set, branch to matcorTempNeg:
    bra  matcorTempPos   ; Branch to matcorTempPos:
    
;*****************************************************************************************
; Matx10 is negative. Prepare to interpolate from the first boundaries
;*****************************************************************************************

matcorTempNeg:
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $02A4,Y     ; Load Accu X with value in RAM page 1 (offset 676)($02A4) 
                      ; ("matCorrTemps2" first address)(Low temperature)
    stx  interpV1     ; Copy to "interpV1"
    ldx  Matx10       ; "Matx10" -> Accu X
    stx  interpV      ; Copy to "interpV"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $02A6,Y     ; Load Accu X with value in RAM page 1 (offset 678)($02A6) 
                      ; ("matCorrTemps2" second address)(High temperature)
    stx  interpV2     ; Copy to "interpV2"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $02B6,Y     ; Load Accu X with value in RAM page 1 (offset 694)($02B6) 
                      ; ("matCorrDelta2" first address)(Low %)
    stx  interpZ1     ; Copy to "interpZ1"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $02B8,Y     ; Load Accu X with value in RAM page 1 (offset 696)($02B8) 
                      ; ("matCorrDelta2" second address)(High %)
    stx  interpZ2     ; Copy to "interpZ2"

;*****************************************************************************************
; Check if we should rail low
;*****************************************************************************************
    
    ldx  Matx10         ; "Matx10" -> Accu X
    cpx  interpV1       ; Compare Matx10 with Low temperature
    bls  RailLomatcor   ; If "Matx10" is the same or less than Low temperature branch to 
                        ; RailLomatcor:
    
;*****************************************************************************************
; Check if we should rail high
;*****************************************************************************************

    cpx  interpV2       ; Compare Cltx10 with High temperature
    bhs  RailHimatcor   ; If "Matx10" is the same or higher than High temperature, branch 
                        ; to RailHimatcor:
    bra  Interpmatcor   ; Branch to Interpmatcor: (No rail so do the interpolation from
                        ; first set of boundaries 

RailLomatcor:
    movw interpZ1,matcor ; Move Low % to "matcor"  
    bra  matcorDone      ; Branch to matcorDone: 
    
RailHimatcor:
    movw interpZ2,matcor ; Move High % to "matcor"
    bra  matcorDone      ; Branch to matcorDone:
    
;*****************************************************************************************
; No rail so do the negative interpolation from the first set of boundaries
;*****************************************************************************************
    
Interpmatcor:
    jsr  INTERP           ; Jump to INTERP subroutine 
    movw interpZ,matcor   ; Result -> "matcor" 
	bra  matcorDone       ; Branch to matcorDone:
	  
;*****************************************************************************************
; Matx10 is positive. Prepare to interpolate from the rest of the boundaries
;*****************************************************************************************

matcorTempPos:
    movw #veBins_R,CrvPgPtr ; Address of the first value in VE table(in RAM)(page pointer) 
                            ;  ->page where the desired curve resides 
    movw #$0152,CrvRowOfst  ; 338 -> Offset from the curve page to the curve row(matCorrTemps2)
	                        ; (actual offset is 676)
    movw #$015B,CrvColOfst  ; 347 -> Offset from the curve page to the curve column(matCorrDelta2)
	                        ; (actual offset is 694)
    movw Matx10,CrvCmpVal   ; Manifold Air Temperature (Degrees F x 10) -> 
                            ; Curve comparison value
    movb #$08,CrvBinCnt     ; 8 -> number of bins in the curve row or column minus 1
    jsr   CRV_LU_NP         ; Jump to subroutine at CRV_LU_NP:
    movw interpZ,matcor     ; Copy result to Manifold Air Temperature Correction (% x 10)
    
matcorDone:

;*****************************************************************************************

;*****************************************************************************************
; The base value for injector pulse width calculations in mS to 0.1mS resolution is called 
; "ReqFuel". It represents the pulse width reqired to achieve 14.7:1 Air/Fuel Ratio at  
; 100% volumetric efficiency. The VE table contains percentage values to 0.1 percent 
; resolution and plots intake manifold pressure in KPA to 0.1KPA resolution against RPM.
; These values are part of the injector pulse width calculations for a running engine.
;*****************************************************************************************
;*****************************************************************************************
; - Look up current value in VE table (veCurr)(%x10)
;*****************************************************************************************

    ldx   Mapx10     ; Load index register X with value in "Mapx10"(Column value Manifold  
                     ; Absolute Pressure x 10 )
    ldd   RPM        ; Load double accumulator D with value in "RPM" (Row value RPM)
    ldy   #veBins_R  ; Load index register Y with address of the first value in VE table 
                     ;(in RAM)   
    jsr   D3_LOOKUP  ; Jump to subroutine at D3_LOOKUP:
    movw  interpZ,VEcurr ; Copy result to "VEcurr
    
;*****************************************************************************************
; The Air/Fuel Ratio of the fuel mixture affects how an engine will run. Generally 
; speaking AFRs of less than ~7:1 are too rich to ignite. Ratios of greater than ~20:1 are 
; too lean to ignite. Stoichiometric ratio is at ~14.7:1. This is the ratio at which all  
; the fuel and all the oxygen are consumed and is best for emmisions concerns. Best power  
; is obtained between ratios of ~12:1 and ~13:1. Best economy is obtained as lean as ~18:1 
; in some engines. This controller runs in open loop so the AFR numbers are used as 
; a tuning aid only.  
;*****************************************************************************************
;*****************************************************************************************
; - Look up current value in AFR table (afrCurr)(AFRx10)
;*****************************************************************************************

    ldx   Mapx10     ; Load index register X with value in "Mapx10"(Column value Manifold  
                     ; Absolute Pressure x 10 )
    ldd   RPM        ; Load double accumulator D with value in "RPM" (Row value RPM)
    
    ldy   #afrBins_R ; Load index register Y with address of the first value in AFR table 
                     ;(in RAM)   
    jsr   D3_LOOKUP  ; Jump to subroutine at D3_LOOKUP:
    movw  interpZ,AFRcurr ; Copy result to "AFRcurr"
    
;*****************************************************************************************
; - The fuel injectors are wired in pairs arranged in the firing order 1&10, 9&4, 3&6, 5&8
;   7&2. This arrangement allows a "semi sequential" injection strategy with only 5 
;   injector drivers. The cylinder pairs are 54 degrees apart in crankshaft rotation so 
;   the injector pulse for the trailing cylinder will lag the leading cylinder by 54 
;   degrees. The benefits of injector timing is an open question but its effect is most 
;   felt at idle when the injection pulse can be timed to an opeing intake valve. At 
;   higher speeds and loads the effect is less becasue the pulse width is longer than the
;   opening time of the valve. The engine has 10 trigger points on the crankshaft so 
;   there is lots of choice where to refernce the start of the pulse from. I have chosen 
;   to use the point when the intake valve on the leading cylinder is 54 degrees after 
;   starting to open.   
;*****************************************************************************************
;*****************************************************************************************
; The determination of whether the engine is cranking or running is made in the 
; interrupt section within the Crank Angle Sensor interrupt. It is here that the 
; "crank" and "run" bits of the "engine" bit field are set or cleared.
;*****************************************************************************************

    brset engine,crank,CrankMode ; If "crank" bit of "engine" bit field is set branch 
	                               ; to CrankMode:
	  jmp   RunMode                ; Branch to RunMode:(no need to test "run" bit)
								  
CrankMode:

;*****************************************************************************************
; Check if we are in flood clear or normal crank mode
;*****************************************************************************************

    ldy   #veBins_R     ; Load index register Y with address of first configurable 
                        ; constant in RAM page 1 (veBins_R)
    ldx   $0350,Y       ; Load Accu X with value in RAM page 1 offset 848
                        ; "FloodClear" (Flood Clear threshold)   
    cpx   TpsPctx10     ; Compare "FloodClear" with "TpsPctx10"
    bhi   NoFloodClear  ; If "FloodClear" is greater than "TpsPctx10", branch to 
	                    ; NoFloodClear: ("TpsPctx10" below threshold so interpolate 
					    ; the cranking pulse width)
	bset  engine,FldClr ; Set "FldClr" bit of "engine" bit field 
    clrw  CrankPWtk     ; Clear Cranking injector pulswidth timer ticks(uS x 5.12)
    clrw  CrankPW       ; Cranking injector pulswidth (mS x 10)
    clrw  FDpw          ; Fuel Delivery pulse width (PW - Deadband) (mS x 10)
    jmp   MainLoopEnd   ; Jump or branch to "MainLoop" (keep looping here until no 
	                    ; longer in flood clear mode)

NoFloodClear:
    bclr  engine,FldClr ; Clear "FldClr" bit of "engine" bit field 
	
;*****************************************************************************************
; --------------------------------- Cranking Mode ----------------------------------------
; When the engine is cranking the injector pulse width is calculated by  
; multiplying the value in ReqFuel by the percentage value in "Crankcor". "Crankcor" is  
; interpolated from the Cranking Pulse table which plots engine temperature in degrees F 
; to 0.1 degree resoluion against percent to 0.1 percent resolution.  
;*****************************************************************************************
;*****************************************************************************************
; - Look up current value in Cranking Pulsewidth Correction Table (Crankcor)
;*****************************************************************************************

;*****************************************************************************************
; First check to see if CLTx10 is negative
;*****************************************************************************************

    ldx  Cltx10          ; Engine Coolant Temperature (Degrees F x 10) -> X    
    andx #$8000          ; Logical AND X with %1000 0000 0000 0000 (CCR N bit set of MSB of 
                         ; of MSB of result is set)
    bmi  CrankcorTempNeg ; If N bit of CCR is set, branch to CrankcorTempNeg:
    bra  CrankcorTempPos ; Branch to CrankcorTempPos:
    
;*****************************************************************************************
; CLTx10 is negative. Prepare to interpolate from the first boundaries
;*****************************************************************************************

CrankcorTempNeg:
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0290,Y     ; Load Accu X with value in RAM page 1 (offset 656)($0290) 
                      ; ("tempTable2" first address)(Low temperature)
    stx  interpV1     ; Copy to "interpV1"
    ldx  Cltx10       ; "CltX10" -> Accu X
    stx  interpV      ; Copy to "interpV"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0292,Y     ; Load Accu X with value in RAM page 1 (offset 658)($0292) 
                      ; ("tempTable2" second address)(High temperature)
    stx  interpV2     ; Copy to "interpV2"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $02DC,Y     ; Load Accu X with value in RAM page 1 (offset 732)($02DC) 
                      ; ("crankPctTable" first address)(Low %)
    stx  interpZ1     ; Copy to "interpZ1"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $02DE,Y     ; Load Accu X with value in RAM page 1 (offset 734)($02DE) 
                      ; ("crankPctTable" second address)(High %)
    stx  interpZ2     ; Copy to "interpZ2"

;*****************************************************************************************
; Check if we should rail low
;*****************************************************************************************
    
    ldx  Cltx10         ; "Cltx10" -> Accu X
    cpx  interpV1       ; Compare Cltx10 with Low temperature
    bls  RailLoCrankcor ; If "Cltx10" is the same or less than Low temperature branch to 
                        ; RailLoCrankcor:
    
;*****************************************************************************************
; Check if we should rail high
;*****************************************************************************************

    cpx  interpV2       ; Compare Cltx10 with High temperature
    bhs  RailHiCrankcor ; If "Cltx10" is the same or higher than High temperature, branch 
                        ; to RailHiCrankcor:
    bra  InterpCrankcor ; Branch to InterpCrankcor: (No rail so do the interpolation from
                        ; first set of boundaries 

RailLoCrankcor:
    movw interpZ1,Crankcor ; Move Low % to "Crankcor"  
    bra  CrankcorDone      ; Branch to CrankcorDone: 
    
RailHiCrankcor:
    movw interpZ2,Crankcor ; Move High % to "Crankcor"
    bra  CrankcorDone      ; Branch to CrankcorDone:
    
;*****************************************************************************************
; No rail so do the negative interpolation from the first set of boundaries
;*****************************************************************************************
    
InterpCrankcor:
    jsr  INTERP           ; Jump to INTERP subroutine 
    movw interpZ,Crankcor ; Result -> "Crankcor" 
	  bra  CrankcorDone     ; Branch to CrankcorDone:
	  
;*****************************************************************************************
; CLTx10 is positive. Prepare to interpolate from the rest of the boundaries
;*****************************************************************************************
 
CrankcorTempPos:
    movw #veBins_R,CrvPgPtr ; Address of the first value in VE table(in RAM)(page pointer) 
                            ; ->page where the desired curve resides 
    movw #$0148,CrvRowOfst  ; 328 -> Offset from the curve page to the curve row(
	                        ; tempTable2)(actual offset is 656)
    movw #$016E,CrvColOfst  ; 366 -> Offset from the curve page to the curve column
	                        ; (crankPctTable)(actual offset is 732)
    movw Cltx10,CrvCmpVal   ; Engine Coolant Temperature (Degrees F x 10) -> 
                            ; Curve comparison value
    movb #$09,CrvBinCnt     ; 9 -> number of bins in the curve row or column minus 1
    jsr   CRV_LU_NP         ; Jump to subroutine at CRV_LU_NP: 
    movw interpZ,Crankcor   ; Copy result to Cranking Pulsewidth Correction (% x 10)
    
CrankcorDone:

;*****************************************************************************************
; - Calculate the cranking pulsewidth.
;*****************************************************************************************
;*****************************************************************************************
; - Multiply "ReqFuel"(mS x 10) by "Crankcor" (%) = (mS * 10)
;*****************************************************************************************

    ldy   #veBins_R  ; Load index register Y with address of first configurable 
                     ; constant in RAM page 1 (vebins)
    ldd   $0358,Y    ; Load Accu X with value in buffer RAM page 1 (offset 856)($0358) 
                     ; ("ReqFuel")
    ldy  Crankcor    ;Cranking Pulsewidth Correction (% x 10) -> Accu Y
    emul             ;(D)x(Y)=Y:D "ReqFuel" * "Crankcor" 
	ldx  #$03E8      ; Decimal 1000 -> Accu X
  	ediv             ;(Y:D)/(X)=Y;Rem->D ("ReqFuel" * "Crankcor" )/10000 
	
;*****************************************************************************************
; - Store the result as "FDpw"(fuel delivery pulse width)(mS x 10)
;*****************************************************************************************

	  sty  FDpw        ; Result -> "FDpw" (fuel delivery pulsewidth (mS x 10)
    
;*****************************************************************************************
; - Add "deadband and store the result as "CrankPW"(cranking injector pulsewidth)(mS x 10)
;*****************************************************************************************

    ldd  FDpw        ; "FDpw"-> Accu D	
   	addd Deadband    ; (A:B)+(M:M+1)->A:B ("FDpw"+"Deadband"="CrankPW"
  	std  CrankPW     ; Result -> "CrankPW" (cranking injector pulsewidth) (mS x 10)
		
;*****************************************************************************************
; - Convert result to timer ticks in 5.12uS resolution.
;*****************************************************************************************

    ldd  CrankPW     ; "CrankPW" -> Accu D
	ldy  #$2710      ; Load index register Y with decimal 10000 (for integer math)
  	emul             ;(D)x(Y)=Y:D "PW" * 10,000
	ldx  #$200       ; Decimal 512 -> Accu X
    ediv             ;(Y:D)/(X)=Y;Rem->D "PW" * 10,000 / 512 = "PWtk" 
    sty  CrankPWtk   ; Copy result to "CrankPWtk" (Priming pulse width in 5.12uS 
	                 ; resolution)
    sty  InjOCadd2   ; Second injector output compare adder (5.12uS res)
    jmp  MainLoopEnd ; Jump to "MainLoopEnd:" (keep looping here until no 
	                 ; longer in crank mode
	
RunMode:

;*****************************************************************************************
; - Calculate the delay time from crankshaft trigger to start of the injector pulse in 
;   5.12uS resolution.
;*****************************************************************************************

    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0348,Y     ; Load Accu X with value in buffer RAM page 1 (offset 840)($0348) 
                      ; ("InjDelDegx10_F")
    tfr  X,D          ; "InjDelDegx10_F" -> Accu D 	
    ldy  Degx10tk512  ;(Time for 1 degree of rotation in 5.12uS resolution x 10)
    emul              ;(D)x(Y)=Y:D "InjDelDegx10_F" * Degx10tk512 
	ldx  #$0064       ; Decimal 100 -> Accu X
	ediv              ;(Y:D)/(X)=Y;Rem->D ((InjDelDegx10_F" * Degx10tk512)/100 
	                  ; = "InjOCadd1"
	sty  InjOCadd1    ; Copy result to "InjOCadd1"
	  
;*****************************************************************************************

;*****************************************************************************************
; - Determine if we will require After Start Enrichment
;*****************************************************************************************

    brset  engine,ASEon,CHECK_ASE1 ; If "ASEon" bit of "engine" bit field is set,  
	                                 ; branch to CHECK_ASE:
    bra  NoASE                     ; Branch to NoASE
    
;*****************************************************************************************
; - Check to see if we are finished with ASE 
;*****************************************************************************************

CHECK_ASE1:
   brset  ICflgs,RevMarker,CHECK_ASE2 ; If "revMarker" bit of "ICflgs is set, branch to 
                                      ; CHECK_ASE2 (Revmarker is set every crankshaft 
                                      ; revolution in the Crank Angle Sensor interrupt.)
   bra  NoASE                         ; Branch to NoASE (not ready for the next revolution
   
CHECK_ASE2:

   ldd  ASEcnt     ; "ASEcnt" -> Accu D
   beq  ASEdone    ; If "ASEcnt" has been decremented to zero branch to ASEdone:
   
;*****************************************************************************************
; Interpolate "ASEcor" as "ASEcnt" is decremented. ASEcnt is decremented every revolution 
; in the Crank Angle Sensor interrupt. 
;*****************************************************************************************
 
    ldd  #$0000           ; Load double accumulator with zero (final value of "ASErev") 
    std  interpV1         ; Copy to "interpV1"
    ldd  ASEcnt           ; Load double accumulator with "ASEcnt"
    std  interpV          ; Copy to "interpV"
    ldd  ASErev           ; Load double accumulator with (Start value of "ASErev")
    std  interpV2         ; Copy to "interpV2"
    ldd  #$0000           ; Load double accumulator with zero (Low range of "ASEcor") 
    std  interpZ1         ; Copy to "interpZ1"
    ldd  ASEstart         ; Load double accumulator with (High range of "ASEcor")
    std  interpZ2         ; Copy to "interpZ2"
    jsr  INTERP           ; Jump to INTERP subroutine 
    movw interpZ,ASEcor   ; Copy result to "ASEcor" ASE correction (%)(update "ASEcor")
    bclr ICflgs,RevMarker ; Clear "ICflgs""RevMarker" bit
    bra  NoASE            ; Branch to CHECK_WUE
    
ASEdone
   clrw ASEcor            ; Clear "ASEcor"
   bclr engine,ASEon      ; Clear "ASEon" bit of "engine" bit field
   
NoASE: 
   
;*****************************************************************************************
; - "WUEcor" + "ASEcor" = "WUEandASEcor" (%*10) 
;*****************************************************************************************

   ldd   WUEcor        ; "WUEcor" (%x10) -> Accu D
   addd  ASEcor        ; (A:B)+(M:M+1)->A:B "WUEcor" + "ASEcor" = "WUEcor" (%*10)
   std   WUEandASEcor  ; Copy result to "WUEandASEcor" (%*10)
   
;*****************************************************************************************

;*****************************************************************************************
;          - THROTTLE OPENING ENRICHMENT AND OVERRUN FUEL CUT CALCULATIONS -
;*****************************************************************************************
;*****************************************************************************************
; - When the engine is running and the throttle is opened quickly a richer mixture is 
;   required for a short period of time. This additional pulse width time is called 
;   Throttle Opening Enrichment. Conversly, when the engine is in over run 
;   conditions no fuel is required so the injectors can be turned off, subject to 
;   permissives. This condtion is called Overrun Fuel Cut. The variables used in the TOE 
;   calculations are as follows:
;
; TpsPctx10:     ds 2 ; Throttle Position Sensor % of travel(%x10)(update every 100mSec)
; TpsPctx10last: ds 2 ; Throttle Position Sensor % of travel(%x10) last(update every 100mSec) 
; TpsPctDOT:     ds 2 ; TPS % of travel difference over time (%/Sec)(update every 100mSec)
; TpsPctDOTlast: ds 2 ; TPS % of travel difference over time last (%/Sec)(update every TOE routine)
; ColdAddpct:    ds 2 ; Throttle Opening Enrichment cold adder (% of ReqFuel)
; ColdAddPW:     ds 2 ; TOE cold adder pulse width (mSx10)
; ColdMulpct:    ds 2 ; Throttle Opening Enrichment cold multiplier (% of ReqFuel) 
; TOEpct:        ds 2 ; Throttle Opening Enrichment (% of ReqFuel)
; TOEandCMpct:   ds 2 ; TOE and Cold Multiplier percent (%)
; TOEpw:         ds 2 ; Throttle Opening Enrichment adder (mS x 10)
; TOEandCMPW:    ds 2 ; TOE and ColdMultiplier pulse width (mSx10)
; PWlessTOE:     ds 2 ; Injector pulse width before "TOEpw" and "Deadband" (mS x 10)
; TOEdurCnt:     ds 1 ; Throttle Opening Enrichment duration counter
;
;   Also, the following flags in the "engine" bit field are used:
;
; TOEon        equ  $20 ; %00100000, bit 5, In Throttle Opening Enrichment Mode 
; OFCon        equ  $40 ; %01000000, bit 6, In Overrun Fuel Cut Mode
;
;   As well as the following flag in the "engine2" bit field:
;
; TOEduron       equ $08 ; %00001000, bit 3, In Throttle Opening Enrichment Duration Mode
;
;   And the following configurable constants:
;
; TOEbins_F:         ; 8 bytes for Throttle Opening Enrichment adder percent (%)(offset = 812)($032C)
;    dc.w $0006,$000F,$001E,$0028
;            6%,  15%,  30%,  40%
;
;;TOErates_F:        ; 8 bytes for Throttle Opening Enrichment rate (TpsPctDOT x 10)(offset = 820)($0334)
;    dc.w $0032,$00C8,$015E,$01F4
;            50,  200,  350,  500
;                	
; tpsThresh_F:       ; 2 bytes for Throttle Opening Enrichment threshold (%/Sec)(offset = 832)($0340)
;    dc.w $0031      ; 49 = 49% per Sec
    
; TOEtime_F:         ; 2 bytes for Throttle Opening Enrich time in 100mS increments(mSx10)(offset = 834)($0342)
;    dc.w $0005      ; 5 = 0.5 Sec
;
; ColdAdd_F:         ; 2 bytes for Throttle Opening Enrichment cold temperature adder at -40F (%)(offset = 836)($0344)
;    dc.w $0014      ; 20%
;    
; ColdMul_F:         ; 2 bytes for Throttle Opening Enrichment multiplyer at -40F (%)(offset = 838)($0346)
;    dc.w $001E      ; 30% 
;
; reqFuel_F:         ; 2 bytes for Pulse width for 14.7 AFR @ 100% VE (mS x 10)(offset = 856)($0358)
;    dc.w $00D5      ; 0213 = 21.3 mS 
;
; - TOE has 3 components, TOEpct, ColdAddpct and ColdMulpct. The primary component is
;   TOEpct which is the interpolated result of the TPS Based AE table which plots the 
;   added percent of ReqFuel against the throttle opening rate of change (TpsPctDOT).
;   This rate of change is calculated in the 100 mS section of the RTI interrupt, where 
;   the current value of TpsPctx10 is tested for zero.
;   If TpsPctx10 equal to zero the throttle is closed so clear TpsPctDOT and copy 
;   TpsPctx10 to TpsPctx10last.
;   If TpsPctx10 is not equal to zero, compare TpsPctx10 with TpsPctx10last. If 
;   TpsPctx10 is equal to or less than TpsPctx10last the throttle is either at steady  
;   state or is closing so clear TpsPctDOT and copy TpsPctx10 to TpsPctx10lst.
;   If TpsPctx10 is greater than TpsPctx10last the throttle is opening so subtract 
;   TpsPctx10last from TpsPctx10 to determine the rate of change (TpsPctDOT) and copy 
;   the result to TpsPctDOT, then copy TpsPctx10 to TpsPctx10last.
;   Any value of TpsPctDOT greater than zero will command TOE. subject to it being 
;   greater than the threshold value of tpsThresh_F.
;
; - In every pass through the main loop TpsPctDOT is tested. If it is not equal to zero
;   the throttle is opening. It is compared with TpsPctDOTlast and the highest value is 
;   then compared with the threshold value in tpsThresh_F. If the rate is higher than the 
;   threshold then do the TOE calculations and start the duration timer.
;   If TpsPctDOT is equal to zero then the throttle is either at steady state or is 
;   closing. Check to see if TOE is in progress. If it is in progress check to see if 
;   the duration timer has timed out.
;   If TOE is not in progress then check to see if OFC has been commanded.
;            
;*****************************************************************************************
;*****************************************************************************************
; - Check if TOE is being commanded or is in progress. 
;*****************************************************************************************

    ldd  TpsPctDOT                   ; "TpsPctDOT" -> Accu D
    bne  TOE_CHK                     ; If not equal to zero branch to TOE_CHK:
                                     ;(TOE is being commanded) 
    brset engine,TOEon,TOE_CHK_TIMEa ; If "TOEon" bit of "Engine" bit field is set, branch to 
                                     ; TOE_CHK_TIMEa: (TOE is not commanded but is still in 
                                     ; progress)(long branch)
    jmp  OFC_CHK                     ; Jump to OFC_CHK (TOE is not being commanded and is 
                                     ; not in progress so jump to OFC_CHK)
    
TOE_CHK_TIMEa:
    jmp  TOE_CHK_TIME                ; Jump to TOE_CHK_TIME: (long branch)                
     
;***********************************************************************************************
; - TOE is being commanded. Check to see if it is opening at a rate greater than the last 
;   opening rate and use the highest rate.
;***********************************************************************************************

TOE_CHK:
    cpd  TpsPctDOTlast ; Compare "TpsPctDOT" with "TpsPctDOTlast" 
    blo  USE_LAST_DOT  ; If "TpsPctDOT" is lower than "TpsPctDOTlast" branch to USE_LAST_DOT:  
    bra  USE_CUR_DOT   ; Branch to USE_CUR_DOT: 
    
USE_LAST_DOT:
    movw TpsPctDOTlast,TpsDOTmax ; Copy value in "TpsPctDOTlast" to "TpsDOTmax"
    bra  CHK_THRESH              ; Branch to CHK_THRESH: 
    
USE_CUR_DOT:
    movw TpsPctDOT,TpsDOTmax ; Copy value in "TpsPctDOT" to "TpsDOTmax"
    
;***********************************************************************************************
; - TOE is being commanded. Check to see if it is opening at a rate greater than the threshold.
;*********************************************************************************************** 
     
CHK_THRESH:
    movw TpsDOTmax,TpsPctDOTlast ; Copy current "TpsDOTmax" to "TpsPctDOTlast"
 
    ldy  #veBins_R       ; Load index register Y with address of first configurable constant
                         ; in RAM page 1 (veBins_R)
    ldx  $0340,Y         ; Load Accu D with value in buffer RAM page 1 offset 832 (tpsThresh)
                         ;(TPSdot threshold)(offset = 832)($0340)
    cpx  TpsDOTmax       ; Compare "tpsThresh" with "TpsDOTmax"
    lbhi PWrunCalcs      ; If "tpsThresh" is greater than "TpsDOTmax", long branch to PWrunCalcs: 
                         ; ("TpsDOTmax" below threshold so no TOE)
    
;***********************************************************************************************
;- The throttle is opening at a rate greater than the threshold so prepare to add in the 
;  enrichement.
;***********************************************************************************************
;*****************************************************************************************
; - Look up current value in Throttle Opening Enrichment Table (TOEpct)(%)
;*****************************************************************************************

    movw #veBins_R,CrvPgPtr  ; Address of the first value in VE table(in RAM)(page pointer) 
                             ; ->page where the desired curve resides 
    movw #$019A,CrvRowOfst   ; 410 -> Offset from the curve page to the curve row
	                         ; (TOERates_F)(actual offset is 820)($0334)
    movw #$0196,CrvColOfst   ; 406 -> Offset from the curve page to the curve column
	                         ; (TOEBins_F)(actual offset is 812)($032C)
    movw TpsDOTmax,CrvCmpVal ; TPS% difference over time maximum (%/Sec)(update every 100mSec)  
                             ; -> Curve comparison value
    movb #$03,CrvBinCnt      ; 3 -> number of bins in the curve row or column minus 1
    jsr  CRV_LU_NP           ; Jump to subroutine at CRV_LU_NP and do interpolation:
    movw interpZ,TOEpct      ; Copy result to TOEpct (%)

;***********************************************************************************************
; - Calculate the cold temperature add-on enrichment "ColdAddpct" (%) from -39.72 
;   degrees to 179.9 degrees.
;***********************************************************************************************

TOE_CALC:
    ldd  cltAdc       ; "cltAdc" -> D
    cpd  #$0093       ; Compare "cltADC" with decimal 147(ADC @ 179.9F) 
    bls  RailColdAdd  ; If "cltADC" is lower or the same as 147, branch to RailColdAdd: 
    bra  DoColdAdd    ; Branch to DoColdAdd:
	
RailColdAdd:
    movw #$0000,ColdAddpct ; Decimal 0 ->"ColdAddpct" (0% = no cold adder)
    movw #$0000,ColdAddPW  ; Decimal 0 ->"ColdAddPW" (0 PW = no cold adder)
    bra   ColdAddPWDone    ; Branch to ColdAddPWDone: (skip over)
   
DoColdAdd:   
    ldd  #$0093      ; Load double accumulator with decimal 147 (ADC @ 179.9F) 
    std  interpV1    ; Copy to "interpV1"
    ldd  cltAdc      ; Load double accumulator with "cltAdc"
    std  interpV     ; Copy to "interpV"
    ldd  #$03EB      ; Load double accumulator with decimal 1003 (ADC @ -39.72F)
    std  interpV2    ; Copy to "interpV2"
    ldd  #$0000      ; Load double accumulator with decimal 0 (added amount at 179.9F)
    std  interpZ1    ; Copy to "interpZ1"
    ldy  #veBins_R   ; Load index register Y with address of first configurable constant
                     ; in RAM page 1 (veBins_R)
    ldd  $0344,Y     ; Load Accu D with value in buffer RAM page 1 (ColdAdd_F)(offset 836) 
                     ;(added amount at -39.72F)    
    std  interpZ2    ; Copy to "interpZ2"
    jsr  INTERP      ; Jump to INTERP subroutine
    movw interpZ,ColdAddpct ; Copy result to "ColdAddpct" (%)

ColdAddPctDone:

;***********************************************************************************************
; Calculate the cold temperature add-on enrichment pulse width "ColdAddPW" (mSx10)
;***********************************************************************************************

    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (veBins_R)
    ldd   $0358,Y     ; Load Accu D with value in RAM page 1 (offset 856)($0358) 
                      ; ("reqFuel" in Accu B)
    ldy  ColdAddpct   ; "ColdAddpct" -> Accu Y (%)  	
    emul              ;(D)x(Y)->Y:D (reqFuel" x "TOEpct")
 	ldx  #$0064       ; Decimal 100 -> Accu X    
    idiv              ;(D)/(X)->X:rem->D (reqFuel" x "ColdAddpct")/10
    stx  ColdAddPW    ; Result -> "ColdAddPW"(mSx10)
    
ColdAddPWDone:
    
;***********************************************************************************************
; - Calculate the cold temperature multiplier enrichment "ColdMulpct" (%), from -39.72 degrees 
;   to 179.9 degrees.
;***********************************************************************************************

    ldd  cltAdc       ; "cltAdc" -> D
    cpd  #$0093       ; Compare "cltADC" with decimal 147(ADC @ 179.9F) 
    bls  RailColdMul  ; If "cltADC" is lower or the same as 147, branch to RailColdMul: 
    bra  DoColdMul    ; Branch to DoColdMul: (skip over)
	
RailColdMul:
   movw #$0064,ColdMulpct  ; Decimal 100 -> "ColdMulpct" (100% = no multiplier))
   bra   ColdMulDone       ; Branch to ColdMulDone: (skip over)
   
DoColdMul:   
    ldd  #$0093      ; Load double accumulator with decimal 147 (ADC @ 179.9F) 
    std  interpV1    ; Copy to "interpV1"
    ldd  cltAdc      ; Load double accumulator with "cltAdc"
    std  interpV     ; Copy to "interpV"
    ldd  #$03EB      ; Load double accumulator with decimal 1003 (ADC @ -39.72F)
    std  interpV2    ; Copy to "interpV2"
    ldd  #$0064      ; Load double accumulator with decimal 100 (multiplier amount at 179.9F)
                     ;(1.00 multiplier at 180 degrees)
    std  interpZ1    ; Copy to "interpZ1"
    ldy   #veBins_R  ; Load index register Y with address of first configurable constant
                     ; in RAM page 1 (veBins_R)
    ldd   $0346,Y    ; Load Accu D with value in buffer RAM page 1 "ColdMul_F"(offset 838) 
                     ;(added amount at -39.72F)    
    std  interpZ2    ; Copy to "interpZ2"
    jsr  INTERP      ; Jump to INTERP subroutine
    movw interpZ,ColdMulpct ; Copy result to "ColdMulpct" (%) 

ColdMulDone:

;*****************************************************************************************
; - Multiply "TOEpct" by "ColdMulpct" and divide by 100 to get TOEandCMpct 
;*****************************************************************************************

    ldd  TOEpct         ; "TOEpct" -> Accu D (%)
    ldy  ColdMulpct     ; "ColdMulpct" -> Accu Y (%)
    emul                ; (D)x(Y)->Y:D (TOEpct x ColdMulpct) result in Y:D
    ldx   #$0064        ; Decimal 100 -> X
    idiv                ; (D)/(X)->(X)rem(D) ((TOEpct x ColdMulpct)/100)(%)
	
;*****************************************************************************************
; - Check the remainder and round up if >=5
;*****************************************************************************************

    cpd  #$0005          ; Compare idiv remainder with decimal 5
    ble  NO_ROUND_UP     ; If remainder of idiv <= 5, branch to NO_ROUND_UP:
    incx                 ; idiv result + 1 -> Accu X (round up)
    stx TOEandCMpct      ; Copy result to "TOEandCMpct"
    bra  TOEandCMpctDone ; Branch to TOEandCMpctDone:

NO_ROUND_UP:
    stx TOEandCMpct      ; Copy to "TOEandCMpct"
    
TOEandCMpctDone:

;*****************************************************************************************
; - Calculate the TOEandCMPW (mSx10)
;*****************************************************************************************

    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (veBins_R)
    ldd   $0358,Y     ; Load Accu D with value in RAM page 1 (offset 856)($0358) 
                      ; ("reqFuel" in Accu B)
    ldy  TOEandCMpct  ; "TOEandCMpct" -> Accu Y (%)  	
    emul              ;(D)x(Y)->Y:D (reqFuel" x "TOEpct")
 	ldx  #$0064       ; Decimal 100 -> Accu X    
    idiv              ;(D)/(X)->X:rem->D (reqFuel" x "TOEandCMpct")/100
    stx TOEandCMPW    ; Result -> "TOEandCMPW"(mSx10)  
	
;*****************************************************************************************
; - Add the result with "ColdAddPW" and save the result as "TOEpw" (TOE pulse width)  
;*****************************************************************************************

    ldx  TOEandCMPW   ; TOEandCMPW -> Accu X
    addx ColdAddPW    ; (X)+(M:M+1)->(X) ("TOEandCMPW" + "ColdAddPW")
    stx  TOEpw        ; Result -> "TOEpw" TOE adder (mS x 10)    

;*****************************************************************************************
; - Start the TOE duration timer by loading TOEdurCnt with the value in TOEtime_F. Set the 
;   TOEon and TOEduron flags, Clear the OFCon flag 
;*****************************************************************************************  

    ldy  #veBins_R        ; Load index register Y with address of first configurable constant
                          ; in RAM page 1 (veBins_R)
    ldd  $0342,Y          ; Load Accu D with value in RAM page 1 offset 834 (TOEtime_F)
    stab TOEdurCnt        ; Copy to "TOEdurCnt" (Throttle Opening Enrichment duration 
	                      ; (decremented every 100 mS))
    bset engine,TOEon     ; Set "TOEon" bit of "engine" variable (in TOE mode)
    bset engine2,TOEduron ; Set "TOEduron" bit of "engine2" variable (TOE duration)
    bclr engine,OFCon     ; Clear "OFCon" bit of "engine" variable (not in OFC mode)
    bra  TOE_LOOP         ; Branch to "TOE_LOOP:  
                      
;*****************************************************************************************
; - Check to see if Throttle Opening Enrichment is done.
;*****************************************************************************************

 TOE_CHK_TIME:
    brset  engine,OFCon,RESET_TOE ; If Overrun Fuel Cut bit of "Engine" bit field is set,
                                  ; branch to RESET_TOE:
    ldaa  TOEdurCnt    ; "TOEdurCnt" -> Accu A 
	beq   RESET_TOE    ; If "TOEdurCnt" = zero branch to RESET_TOE:(timer has timed out) 
    bra   TOE_LOOP     ; Branch to "TOE_LOOP:(Timer hasn't timed out yet)

;*****************************************************************************************
; - The throttle is no longer opening and the duration timer has timed out so clear 
;   all assosiated variables.  
;*****************************************************************************************

RESET_TOE:
   bclr engine,TOEon     ; Clear "TOEon" bit of "engine" bit field
   bclr engine2,TOEduron ; Clear "TOEduron" bit of "engine2" variable (TOE duration)
   clrw TOEpct           ; Clear Throttle Opening Enrichment (%) 
   clrw ColdAddpct       ; Clear Throttle Opening Enrichment cold adder (%)
   clrw ColdMulpct       ; Clear Throttle Opening Enrichment cold multiplier (%)
   clrw TpsPctDOT        ; Clear TPS difference over time (%/Sec)(update every 100mSec)
   clrw TpsPctDOTlast    ; Clear TPS difference over time last (%/Sec)(update every TOE routine)
   clr  TOEdurCnt        ; Clear Throttle Opening Enrichment duration counter
   clrw TOEpw            ; Clear Throttle Opening Enrichment adder (mS x 100)
   clrw PWlessTOE        ; Clear Injector pulse width before "TOEpw" and "Deadband" (mS x 10)
   clrw ColdAddPW        ; Clear TOE cold adder pulse width (mSx10)
   clrw TOEandCMpct      ; Clear TOE and Cold Multiplier percent (%)
   clrw TOEandCMPW       ; Clear TOE and ColdMultiplier pulse width (mSx10)
   clrw TpsDOTmax        ; TPS DOT maximum for TOE calculations (%/Sec)(offset=147)(Memory location $2093) 

TOE_LOOP:
    jmp  OFC_LOOP        ; Jump or branch to OFC_LOOP:(Finished with TOE, not in OFC  
	                     ; so fall through)
    
;*****************************************************************************************
;                             Overrun Fuel Cut mode 
;*****************************************************************************************
;*****************************************************************************************
;
; - Engine overrun occurs when the the vehicle is in motion, the throttle is closed and  
;   the engine is turning faster than the driver wants it to be, either because of vehicle   
;   inertia or by being on a negative grade. Under these conditions there will be a slight    
;   increase in engine braking and some fuel can be saved if the fuel injectors are not  
;   pulsed. OFC is only enabled manually by pulsing up on the dash mounted SPDT spring 
;   return to centre toggle switch. In order to enter OFC mode several permissive 
;   conditions must be met first. The throttle opening must be equal to or less than the 
;   minimum permitted opening and the engine RPM must be equal to or more than the minimum 
;   permitted RPM. OFC can be disabled manually by the driver at any time by pulsing 
;   down on the dash mounted toggle switch. It will be disabled automatically if either 
;   or both of the permissive conditions are no longer met 
; 
;*****************************************************************************************
;*****************************************************************************************
; - Check to see if we have permissives for Overrun Fuel Cut at steady state or closing 
;   throttle.
;*****************************************************************************************

OFC_CHK:
    ldy   #veBins_R   ; Load index register Y with address of first configurable constant
                      ; in RAM page 1 (veBins_R)
    ldx   $034A,Y     ; Load X with value in RAM page 1 offset 842 (OFCtps)
                      ;(Overrun Fuel Cut min TPS%)   
    cpx  TpsPctx10    ; Compare it with value in "TpsPctx10"
    blo  OFC_CHK_DONE ; If (X)>(M), branch to OFC_CHK_DONE: 
                      ;(TPS is above minimum so no fuel cut)
    ldy   #veBins_R   ; Load index register Y with address of first configurable constant
                      ; in RAM page 1 (veBins_R)
    ldx   $034C,Y     ; Load X with value in RAM page 1 offset 844 (OFCrpm)
                      ;(Overrun Fuel Cut min RPM)     
    cpx  RPM          ; Compare it value in RPM
    bhi  OFC_CHK_DONE ; If (X)<(M), branch to OFC_CHK_DONE:
                      ;(RPM is below minimum so no fuel cut
					  
;*****************************************************************************************
; - We have permissives for Overrun Fuel Cut. Check to see if OFC is already on and being  
;   being commanded off.
;*****************************************************************************************

    brclr  engine,OFCon,OFC_EN_CHK ; If "OFCon" bit of "engine" bit field is clear, branch 
	                               ; to OFC_EN_CHK: (OFC is off, check to see if it is  
								   ; being commanded on

    brclr PortAbits,OFCdis,OFC_CHK_DONE ; If "OFCdis" bit of "PortAbits" is clear (Low), 
	                  ; branch to OFC_CHK_DONE: (OFC is on and OFC disable switch is on, 
					  ; so disable fuel cut)
	  bra  OFC_LOOP   ; branch to OFC_LOOP:(OFC is on, permissives are met and not being 
	                  ; commanded off, keep looping until permissives are no longer met 
					  ; or OFC has been commanded off)					  
					  
;*****************************************************************************************
; - We have permissives for Overrun Fuel Cut and it is not being commanded off. Check to 
;   see if OFC is off and being commanded on.
;*****************************************************************************************

OFC_EN_CHK:
	brset  engine,OFCon,OFC_LOOP   ; If "OFCon" bit of "engine" bit field is set, branch 
	                               ; to OFC_LOOP: (OFC is already on so skip over)
    brset PortAbits,OFCen,OFC_LOOP ; "If OFCen" bit of "PortAbits" is set (High), branch to 
	                               ; OFC_LOOP: (OFC enable switch is off so skip over)
  	bset engine,OFCon              ; Set "OFCon" bit of "engine" bit field (This bit will be tested 
	                               ; in the final pulse width calculations, if set the pulse width 
					               ; will be set to zero
    bclr engine,TOEon              ; Clear "TOEon" bit of "engine" bit field
  	bra  OFC_LOOP                  ; branch to OFC_LOOP:(keep looping until permissives are no 
	                               ; longer met or OFC has been commanded off)
    
;*****************************************************************************************
; - Permissives have not or are no longer are being met or OFC has been commanded off.  
;   Clear the flag.
;*****************************************************************************************

OFC_CHK_DONE:
	bclr engine,OFCon     ; Clear "OFCon" bit of "engine" bit field
	
OFC_LOOP:                

;*****************************************************************************************
; - Calculate injector pulse width for a running engine "PW" (mS x 10)
;*****************************************************************************************
;*****************************************************************************************
; - Method:
;
; ("barocor" * "matcor") / 1000 = "PWcalc1" (0.1% resolution)
; ("Mapx10" * "Ftrmx10") / 1000 = "PWcalc2" (0.1% resolution)
; ("PWcalc1" * "PWcalc2") / 1000 = "PWcalc3" (0.1% resolution)
; ("WUEandASEcor" * "veCurr") / 1000 = "PWcalc4" (0.1% resolution)
; ("PWcalc3" * "PWcalc4") / 1000 = "PWcalc5" (0.1% resolution)
; ("PWcalc5" * reqFuel") / 1000 = "PWlessTOE" (0.1mS resolution)
; "PWlessTOE" + "TOEpw" = "FDpw"  (0.1mS resolution)
; "FDpw" + "Deadband" = "PW"  (0.1mS resolution) 

;*****************************************************************************************
;*****************************************************************************************
; - Calculate total corrections before Throttle Opening Enrichment and deadband.
;*****************************************************************************************

    brset engine,OFCon,NoPWrunCalcs1 ; if "OFCon" bit of "engine" bit field is set branch 
                                     ; to NoPWrunCalcs1: (In overrun fuel cut mode so 
                                     ; fall through)
    bra  PWrunCalcs                  ; Branch to PWrunCalcs: 
    
NoPWrunCalcs1:
    jmp  NoPWrunCalcs  ; Jump or branch to NoPWrunCalcs: (long branch)
    
PWrunCalcs:    
    ldd  barocor      ; "barocor" -> Accu D (% x 10)
    ldy  matcor       ; "matcor" -> Accu D (% x 10)  	
    emul              ; (D)*(Y)->Y:D "barocor" * "matcor" 
	ldx  #$03E8       ; Decimal 1000 -> Accu X 
  	ediv              ;(Y:D)/)X)->Y;Rem->D ("barocor"*"matcor")/1000="PWcalc1"
	sty  PWcalc1      ; Result -> "PWcalc1" 
    ldd  Mapx10       ; "Mapx10" -> Accu D (% x 10)
    ldy  Ftrmx10      ; "Ftrmx10" -> Accu D (% x 10)  	
    emul              ; (D)*(Y)->Y:D "Mapx10" * "Ftrmx10" 
  	ldx  #$03E8       ; Decimal 1000 -> Accu X
	ediv              ;(Y:D)/)X)->Y;Rem->D ("Mapx10"*"Ftrmx10")/1000="PWcalc2"
	sty  PWcalc2      ; Result -> "PWcalc2"
    ldd  PWcalc1      ; "PWcalc1" -> Accu D (% x 10)
    ldy  PWcalc2      ; "PWcalc2" -> Accu D (% x 10)  	
    emul              ; (D)*(Y)->Y:D "PWcalc1" * "PWcalc2" 
	ldx  #$03E8       ; Decimal 1000 -> Accu X
  	ediv              ;(Y:D)/)X)->Y;Rem->D ("PWcalc1"*"PWcalc2")/1000="PWcalc3"
    sty  PWcalc3      ; Result -> "PWcalc3"
    ldd  WUEandASEcor ; "WUEandASEcor" -> Accu D (% x 10)
    ldy  VEcurr       ; "veCurr" -> Accu D (% x 10)  	
    emul              ; (D)*(Y)->Y:D "WUEandASEcor" * "veCurr" 
	ldx  #$03E8       ; Decimal 1000 -> Accu X
   	ediv              ;(Y:D)/)X)->Y;Rem->D ("WUEandASEcor"*"veCurr")/1000="PWcalc4"
	sty  PWcalc4      ; Result -> "PWcalc4"
    ldd  PWcalc3      ; "PWcalc3" -> Accu D (% x 10)
    ldy  PWcalc4      ; "PWcalc4" -> Accu D (% x 10)  	
    emul              ; (D)*(Y)->Y:D "PWcalc3" * "PWcalc4" 
  	ldx  #$03E8       ; Decimal 1000 -> Accu X
	ediv              ;(Y:D)/)X)->Y;Rem->D ("PWcalc3"*"PWcalc4")/1000="PWcalc5"
	sty  PWcalc5      ; Result -> "PWcalc5"(total corrections before Throttle Opening 
	                  ; Enrichment and deadband)

;*****************************************************************************************
; - Calculate injector pulse width before Throttle Opening Enrichment pulse width and 
;   Deadband.
;*****************************************************************************************

    ldd  PWcalc5      ; "PWcalc5" -> Accu D (% x 10)
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (veBins_R)
    ldx   $0358,Y     ; Load Accu X with value in buffer RAM page 1 (offset 856)($0358) 
                      ; ("reqFuel")
    tfr  X,Y          ; "reqFuel" -> Accu Y 	
    emul              ; (D)*(Y)->Y:D "PWcalc5" * "reqfuel" 
	ldx  #$03E8       ; Decimal 1000 -> Accu X
	ediv              ;(Y:D)/)X)->Y;Rem->D ("PWcalc5"*"reqFuel")/1000="PWlessTOE"
  	sty  PWlessTOE    ; Result -> "PWlessTOE" (mS x 10)
    
;*****************************************************************************************
; - Add the Throttle Opening Enricment pulse width and store as "FDpw"(fuel delivery 
;   pulse width)(mS x 10) 
;*****************************************************************************************
	
    tfr  Y,D          ; "PWlessTOE" -> Accu D
	addd TOEpw        ; (A:B)+(M:M+1)->A:B ("PWlessTOE"+"TOEpw"="FDpw"
  	std  FDpw         ; Result -> "FDpw" (fuel delivery pulsewidth (mS x 10)

;*****************************************************************************************
; - Add "deadband" and store the result as "PW"(final injector pulsewidth)(mS x 10)
;*****************************************************************************************
	
  	addd Deadband    ; (A:B)+(M:M+1)->A:B ("FDpw"+"Deadband"="PW"
	std  PW          ; Result -> "PW" (final injector pulsewidth) (mS x 10)
	
;*****************************************************************************************
; - Convert "PW" to timer ticks in 5.12uS resolution.
;*****************************************************************************************

    ldd   PW         ; "PW" -> Accu D
	ldy   #$2710     ; Load index register Y with decimal 10000 (for integer math)
  	emul             ;(D)x(Y)=Y:D "PW" * 10,000
	ldx   #$200      ; Decimal 512 -> Accu X
    ediv             ;(Y:D)/(X)=Y;Rem->D "PW" * 10,000 / 512 = "PWtk" 
    sty   PWtk       ; Copy result to "PWtk" (Running engine injector pulsewidth) 
	                 ; (uS x 5.12)
    sty   InjOCadd2  ; Second injector output compare adder (5.12uS res)
					 
;*****************************************************************************************
; - Injector duty cycle percentage is the time the injector takes to inject the fuel  
;   divided by the time available x 100. The time available is the engine cycle which is  
;   two crankshaft revolutions. It is important to know what our duty cycle is at high 
;   engine speeds and loads. 80% is considered a safe maximum. The crank angle period is 
;   measured over 72 degrees of crank rotation. The injection timer is set to a 5.12uS 
;   time base and the pulse width timer value is in 5.12uS resolution. The engine cycle 
;   period in 5.12uS resolution can be calculated by multiplying the period by 10, for 
;   the two revolutions in the cycle. The duty cycle percentage is calculated by 
;   dividing "PWtk" by the cycle period and dividing by 100.                                                                                  
;*****************************************************************************************
;*****************************************************************************************
; - Calculate injector duty cycle
;*****************************************************************************************

    ldd  PWtk           ; "PWtk"->Accu D 
    ldy  #$0064         ; Decimal 100-> Accu Y (for integer math)       
	emul                ;(D)x(Y)=Y:D "PWtk"*100
    ldx  CASprd512      ; "CASprd512"-> Accu X (running period for 72 degrees rotation)
    ediv                ;(Y:D)/(X)=Y;Rem->D ("PWtk"*100)/"CASprd512"
    sty  DutyCyclex10   ; Copy result to "DutyCyclex10" (Injector duty cycle x 10)
    bra  PWrunCalcsDone ; Branch to PWrunCalcsDone: 

NoPWrunCalcs:
    clrw  PWlessTOE     ; Clear "PWlessTOE" Injector PW before "TOEpw"+"Deadband"(mS x 10)
    clrw  TOEpw         ; Clear "TOEpw" Throttle Opening Enrichment adder (mS x 100)
    clrw  FDpw          ; Clear "FDpw" Fuel Delivery pulse width (PW - Deadband)(mS x 10)
    clrw  PW            ; Clear "PW" Running engine injector pulsewidth (mS x 10)
    clrw  PWtk          ; Clear "PWtk" Running injector pulsewidth timer ticks(uS x 2.56)
    movw  #$0002,InjOCadd1  ; First injector output compare adder (5.12uS res or 2.56uS res)
    movw  #$0002,InjOCadd2  ; Second injector output compare adder (5.12uS res or 2.56uS res)
    clrw  DutyCyclex10      ; Clear "DutyCyclex10" Injector duty cycle in run mode (% x 10)    

PWrunCalcsDone:

;*****************************************************************************************
; - The Factory Service Manuals state the fuel pressure for the '94/'95 gas engines 
;   should be between 35 and 45 PSI. The '96 and on engines should be 49.2 PSI +/- 5 PSI.
;   The fuel injectors are Chrysler 5304003 cross to Bosch 0280155101 and have a flow rate 
;   of 256 CC/Min presumeably at ~39 PSI. At ~49 PSI the flow rate should  be ~287 CC/Min
;   Morgans observed fuel pressure is ~49 PSI running.
;*****************************************************************************************    
	                 
;*****************************************************************************************
; - Calculate fuel burn Litres per Hour ("LpH"), Kilometers per Litre ("KmpL") and
;   Miles per Gallon Imperial ("MpG")
;*****************************************************************************************
;*****************************************************************************************
; - Look up the injector flow rate for 2 injectors (CC/Min converted to CC/Sec x 100 for 
;   integer math)(initial setting 287 CC/Min per injector)                                                                             
;*****************************************************************************************

    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (veBins_R)
    ldx   $035C,Y     ; Load Accu X with value in RAM page 1 (offset 860)($035C) 
                      ; ("InjPrFlo_F")
    stx   InjPrFlo    ; Copy to "InjPrFlo" (used in calculations) 
                      
;;*****************************************************************************************
;; - Calculate current fuel burn in Litres per Hour: (Injector open time over 1 second  
;;   x 60 = Injector open time for 1 minute. Injector open time for 1 minute x injector  
;;   flow rate per minute = injector flow for 1 minute. Injector flow for 1 minute x 60  
;;   = injector flow per hour. For integer math:
;;    ((("FDsec"/10)*6)*InjPrFlo_F)/10,000= "LpH"(Litres per hour x 10)                                                                                    
;;*****************************************************************************************
;
;    ldd  FDsec       ; "FDsec"->Accu D (Fuel delivery pulse width total for 1 Sec (mS*10) 
;    ldx  #$000A      ; Decimal 10 -> Accu X
;    idiv             ; (D)/(X)->Xrem->D "FDsec"/10
;    tfr  X,D         ; ("FDsec"/10)-> Accu D
;    ldy  #$0006      ; Decimal 6 -> Accu Y
;    emul             ; (D)*(Y)->Y:D ("FDsec"/10)*6
;    ldy  InjPrFlo    ; "InjPrFlo" -> Accu Y
;    emul             ; (D)*(Y)->Y:D (9"FDsec"/10)*6)*"InjPrFlo"
;    ldx  #$2710      ; Decimal 10,000-> Accu X   
;    ediv             ; (Y:D)/)X)->Y;Rem->D ((("FDsec"/10)*6)*"InjPrFlo_F")/10,000="LpH"
;    sty  LpH         ; Copy result to "LpH" (Litres per hour x 10)

;*****************************************************************************************
; - Calculate current fuel burn in Litres per Hour: (Injector pair open time over 1 second   
;   x injector pair flow rate per second = injector pair flow for 1 second. Injector pair  
;   flow for 1 second x 3600 = injector pair flow per hour. For integer math:
;    ((("FDsec"/100)*InjPrFlo_F)/10,000)*36= "LpH"(Litres per hour x 10)                                                                                    
;*****************************************************************************************

    ldd  FDsec       ; "FDsec"->Accu D (Fuel delivery pulse width total for 1 Sec (mS*10) 
    ldx  #$0064      ; Decimal 100 -> Accu X
    idiv             ; (D)/(X)->Xrem->D "FDsec"/100
    tfr  X,D         ; ("FDsec"/100)-> Accu D
    ldy  InjPrFlo    ; "InjPrFlo" -> Accu Y
    emul             ; (D)*(Y)->Y:D ("FDsec"/100)*"InjPrFlo"
    ldx  #$2710      ; Decimal 10,000-> Accu X   
    ediv             ; (Y:D)/)X)->Y;Rem->D (("FDsec"/100))*"InjPrFlo_F")/10,000
    tfr  YL,A        ; Result -> Accu A
    ldab #$24        ; Decimal 36-> Accu B 
    mul              ; (A)*(B)->A:B 9(("FDsec"/100))*"InjPrFlo_F")/10,000)*36 
    std  LpH         ; Copy result to "LpH" (Litres per hour x 10)
    
;*****************************************************************************************
; - Calculate current fuel burn in Kilometers per Litre                                                                           
;*****************************************************************************************

    ldd  KPH         ; "KPH" -> Accu D (KPH x 10)
    ldy  #$0064      ; Decimal 100 -> Accy Y
    emul             ; (D)*(Y)->Y:D "KPH"*100 (for integer math)
    ldx  LpH         ; "LpH"-> Accu X (LpH x 10) 
    ediv             ; (Y:D)/)X)->Y;Rem->D (KPH"*100)/LpH
    sty  KmpL        ; Result -> "KmpL" (KmpL x 100)

;*****************************************************************************************
; - Convert fuel burn in Kilometers per Litre to Miles per Gallon Imperial                                                                           
;*****************************************************************************************

;    ldd  KmpL        ; "KmpL" -> Accu D (KmpL x 10)
;    ldy  #$0064      ; Decimal 100 -> Accy Y
;    emul             ; (D)*(Y)->Y:D "KmpL"*100
;    tfr  D,Y         ; Result Lo word-> Accu Y
    ldy  KmpL        ; "KmpL" -> Accu y (KmpL x 100)   
    ldd  #$011A      ; Decimal 282-> Accu D (2.82 is conversion factor)
    emul             ; (D)*(Y)->Y:D ("KmpL"*100)*282
    ldx  #$0064      ; Decimal 100 -> Accu X    
	ediv             ;(Y:D)/)X)->Y;Rem->D (("KmpL"*100)*282)/100= ("MpG" x 100)
    sty   MpG        ; Result -> "MpG" (MpG x 100)
	
;*****************************************************************************************
;                                 END OF FUEL SECTION
;*****************************************************************************************

;*****************************************************************************************
; - Increment "LoopCntr" (counter for "LoopTime")
;*****************************************************************************************

MainLoopEnd:
	incw LoopCntr  ; Increment "LoopCntr"(counter for "LoopTime") 
    jmp  MainLoop  ; Jump to "MainLoop" (end of main loop, start again)

;*****************************************************************************************
;                               MAIN LOOP ENDS HERE 
;*****************************************************************************************
   

;*****************************************************************************************
;================================  SUB-ROUTINES  =========================================
;*****************************************************************************************
; - Subroutines subsection
;   - ATD0 routines
;     - Read ATD0
;     - Convert ATD0
;   - Table lookups and interpolation routines
;   - Fuel injector timer routines
;     - Injector pulsewidth calculations
;     - ASE correction lookup
;     - ASE taper lookup
;   - Time rate routines
;     - mS routines
;       - Check for stall
;     - mS20 routines
;       - Check for IAC change
;     - mS100 routines
;       - Decrement TOE duration counter
;       - Update TPS DOT
;     mS1000 routines
;       - Update loop counter
;       - Update fuel delivery variables
;       - Flash erase and burn
;
;*****************************************************************************************
;                                ATD0 SUB-ROUTINES
;*****************************************************************************************
;*****************************************************************************************
;*    Port AD:                                                                           *
;*     PAD00 - (batADC)     (analog, no pull) hard wired Bat volts ADC                   *
;*     PAD01 - (cltADC)     (analog, no pull) temperature sensor ADC                     *
;*     PAD02 - (matADC)     (analog, no pull) temperature sensor ADC                     *
;*     PAD03 - (PAD03inADC) (analog, no pull) temperature sensor ADC  spare              *
;*     PAD04 - (mapADC)     (analog, no pull) general purpose ADC                        *
;*     PAD05 - (tpsADC)     (analog, no pull) general purpose ADC                        *
;*     PAD06 - (egoADC1)(EGO)  (analog, no pull) general purpose ADC                     *
;*     PAD07 - (baroADC)    (analog, no pull) general purpose ADC                        *
;*     PAD08 - (eopADC)     (analog, no pull) general purpose ADC                        *
;*     PAD09 - (efpADC)     (analog, no pull) general purpose ADC                        *
;*     PAD10 - (itrmADC)    (analog, no pull) general purpose ADC                        *
;*     PAD11 - (ftrmADC)    (analog, no pull) general purpose ADC                        *
;*     PAD12 - (egoADC2)(PAD12) (analog, no pull) general purpose ADC                    *
;*     PAD13 - Not used     (GPIO input, pull-up)                                        *
;*     PAD14 - Not used     (GPIO input, pull-up)                                        *
;*     PAD15 - Not used     (GPIO input, pull-up)                                        *
;*****************************************************************************************
;*****************************************************************************************
; - From observation the main loop frequency ranges from a low of ~8000 hz at 0 RPM to
;   ~9500 hz at ~4000 RPM. ATD frequency ranges from ~8227 hz at 0 RPM to ~7400 hz at 
;   ~4000 RPM
;*****************************************************************************************

READ_ATD0:   ; Subroutine to read ADC values
    
    ldd   ATD0DR0H    ; Load accumulator with value in ATD Ch00 
    std   batAdc      ; Copy to batAdc
    ldd   ATD0DR1H    ; Load accumulator with value in ATD Ch01 
    std   cltAdc      ; Copy to cltAdc
    ldd   ATD0DR2H    ; Load accumulator with value in ATD Ch02 
    std   matAdc      ; Copy to matAdc
    ldd   ATD0DR3H    ; Load accumulator with value in ATD Ch03 
    std   PAD03inAdc  ; Copy to PAD03inAdc
    ldd   ATD0DR4H    ; Load accumulator with value in ATD Ch04 
    std   mapAdc      ; Copy to mapAdc
    ldd   ATD0DR5H    ; Load accumulator with value in ATD Ch05 
    std   tpsAdc      ; Copy to tpsADC
    
;*****************************************************************************************
;- From observation the EGO sensors have a cerain amount of jitter. I don't know if this 
; is just a characteristic of the sensor or if it is legitimate. In any case I don't need 
; instant results so I average the ADC readings over 64 iterations to stabilize the results.
;*****************************************************************************************

    ldd   ATD0DR6H    ; Load accumulator with value in ATD Ch06 
    addd  egoADC1sum  ;(A:B)+(M:M+1)->A:B Add value in ATD Ch06 with value in "egoADC1sum"
    std   egoADC1sum  ; Copy result to "egoADC1sum" (update "egoADC1sum")
    inc   egoADC1cnt  ; Increment "egoADC1cnt" (increment counter to average "egoADC1")
    ldaa  egoADC1cnt  ; Load Accu A with value in "egoADC1cnt"
    cmpa  #$40        ; (A)-(M) (Compare "egoADC1cnt" with decimal 64)
    beq   AVegoADC1   ; If equal branch to AVegoADC1:
    bra   Do_ATD_Ch07 ; Branch to Do_ATD_Ch07 (compare not equal so fall through)

AVegoADC1:
    clr   egoADC1cnt  ; Clear "egoADC1cnt" (ready to start count again)
    ldd   egoADC1sum  ; Load accumulator with value in "egoADC1sum" 
    ldx   #$40        ; Load Accu X with decimal 64
    idiv              ; (D)/(X)->X Rem->D ("egoADC1sum / 64)
    stx   egoAdc1     ; Copy result to "egoAdc1"
    clrw  egoADC1sum  ; Clear "egoADC1sum" (ready to start sum again)
    
;*****************************************************************************************
;- From observation, the MPXA6115AC7U barometric pressure sensor has an ADC jitter from
;  about 828 to 832 counts at sea level on the observed day. This doesn't create any
;  major problems with the pulse width calculations but it is irritating so I average 
;  the ADC readings over 64 iterations to stabilize the results.
;*****************************************************************************************

Do_ATD_Ch07:    
    ldd   ATD0DR7H    ; Load accumulator with value in ATD Ch07 
    addd  baroADCsum  ;(A:B)+(M:M+1)->A:B Add value in ATD Ch07 with value in "baroADCsum"
    std   baroADCsum  ; Copy result to "baroADCsum" (update "baroADCsum"
    inc   baroADCcnt  ; Increment "baroADCcnt" (increment counter to average "baroADC")
    ldaa  baroADCcnt  ; Load Accu A with value in "baroADCcnt"
    cmpa  #$40        ; (A)-(M) (Compare "baroADCcnt" with decimal 64)
    beq   AVbaroADC   ; If equal branch to AVbaroADC:
    bra   Do_ATD_Ch08 ; Branch to Do_ATD_Ch08 (compare not equal so fall through)

AVbaroADC:
    clr   baroADCcnt  ; Clear "baroADCcnt" (ready to start count again)
    ldd   baroADCsum  ; Load accumulator with value in "baroADCsum" 
    ldx   #$40        ; Load Accu X with decimal 64
    idiv              ; (D)/(X)->X Rem->D ("baroADCsum / 64)
    stx   baroAdc     ; Copy result to "baroADC"
    clrw  baroADCsum  ; Clear "baroADCsum" (ready to start sum again)
        
Do_ATD_Ch08:     
    ldd   ATD0DR8H    ; Load accumulator with value in ATD Ch08 
    std   eopAdc      ; Copy to eopAdc
    
;*****************************************************************************************
;- From observation the fuel pressure sensor has a lot of jitter. I don't need instant 
;  results so I average the ADC readings over 64 iterations to stabilize the results.
;*****************************************************************************************

    ldd   ATD0DR9H    ; Load accumulator with value in ATD Ch09 
    addd  efpADCsum  ;(A:B)+(M:M+1)->A:B Add value in ATD Ch09 with value in "efpADCsum"
    std   efpADCsum  ; Copy result to "efpADCsum" (update "efpADCsum")
    inc   efpADCcnt  ; Increment "efpADCcnt" (increment counter to average "efpADC")
    ldaa  efpADCcnt  ; Load Accu A with value in "efpADCcnt"
    cmpa  #$40        ; (A)-(M) (Compare "efpADCcnt" with decimal 64)
    beq   AVefpADC   ; If equal branch to AVefpADC:
    bra   Do_ATD_Ch10 ; Branch to Do_ATD_Ch10: (compare not equal so fall through)

AVefpADC:
    clr   efpADCcnt  ; Clear "efpADCcnt" (ready to start count again)
    ldd   efpADCsum  ; Load accumulator with value in "efpADCsum" 
    ldx   #$40        ; Load Accu X with decimal 64
    idiv              ; (D)/(X)->X Rem->D ("efpADCsum / 64)
    stx   efpAdc     ; Copy result to "efpAdc"
    clrw  efpADCsum  ; Clear "efpADCsum" (ready to start sum again)
    
Do_ATD_Ch10:    
    ldd   ATD0DR10H   ; Load accumulator with value in ATD Ch10 
    std   itrmAdc     ; Copy to itrmAdc
    ldd   ATD0DR11H   ; Load accumulator with value in ATD Ch11 
    std   ftrmAdc     ; Copy to ftrmAdc
    
;*****************************************************************************************
;- From observation the EGO sensors have a cerain amount of jitter. I don't know if this 
; is just a characteristic of the sensor or if it is legitimate. In any case I don't need 
; instant results so I average the ADC readings over 64 iterations to stabilize the results.
;*****************************************************************************************

    ldd   ATD0DR12H     ; Load accumulator with value in ATD Ch12 
    addd  egoADC2sum    ;(A:B)+(M:M+1)->A:B Add value in ATD Ch12 with value in "egoADC2sum"
    std   egoADC2sum    ; Copy result to "egoADC2sum" (update "egoADC2sum")
    inc   egoADC2cnt    ; Increment "egoADC2cnt" (increment counter to average "egoADC2")
    ldaa  egoADC2cnt    ; Load Accu A with value in "egoADC2cnt"
    cmpa  #$40          ; (A)-(M) (Compare "egoADC1cnt" with decimal 64)
    beq   AVegoADC2     ; If equal branch to AVegoADC2:
    bra   egoADC2adding ; Branch to egoADC2adding (compare not equal so fall through)
AVegoADC2:
    clr   egoADC2cnt    ; Clear "egoADC2cnt" (ready to start count again)
    ldd   egoADC2sum    ; Load accumulator with value in "egoADC2sum" 
    ldx   #$40          ; Load Accu X with decimal 64
    idiv                ; (D)/(X)->X Rem->D ("egoADC2sum / 64)
    stx   egoAdc2       ; Copy result to "egoAdc2"
    clrw  egoADC2sum    ; Clear "egoADC2sum" (ready to start sum again)
    
egoADC2adding:
    rts                 ; Return from READ_ATD0 subroutine
    
;*****************************************************************************************
    
CONVERT_ATD0:   ; Subroutine to convert basic ADC values to user units

;*****************************************************************************************
; - Calculate Battery Voltage
;   System voltage is typically ~12 volts with the engine stopped and ~14 volts with the
;   engine running and the generator charging. In order for ATD0 Ch0 to measure this  
;   voltage a 49.9K and a 10K resistor are connected in series across VDD(5 volts) and 
;   ground. Ch0 measures the voltage drop across the 10K resistor. This arrangement will
;   accept system voltage of 29.95 volts before the voltage drop will exceed 5 volts.
; - Calculate Battery Voltage x 10 -
;
;    (batAdc/1023)*29.95 = BatV
;             or
;    batAdc*(29.95/1023) = BatV, batADC = BatV
;    batAdc*.029276637 = BatV  batADC = batV/.029276637    
;    batAdc*(300/1023) = BatV*10
;    batAdc*.29276637 = BatV*10 bat ADC = batV*10/.29276637   
;*****************************************************************************************

    ldd   batAdc       ; Load double accumulator with value in "batAdc"
    ldy   #$012C       ; Load index register Y with decimal decimal 300
    emul               ; Extended 16x16 multiply (D)x(Y)=Y:D
    ldx   #$03FF       ; Load index register X with decimal 1023
    ediv               ; Extended 32x16 divide(Y:D)/(X)=Y;Rem->D
    sty   BatVx10      ; Copy result to "BatVx10" (Battery Voltage x 10)
    
;*****************************************************************************************
; - Look up Engine Coolant Temperature (Degrees F x 10)
;*****************************************************************************************

    ldx   cltAdc            ; Load index register X with value in "cltAdc"
    aslx                    ; Arithmetic shift left index register X (multiply "cltAdc"
                            ; by two) I have no idea why I have to do this but if I don't
                            ; the table look up is only half of where it shoud be ???????
    ldy   DodgeThermistor,X ; Load index register Y with value in "DodgeThermistor" table,
                            ; offset in index register X
    sty   Cltx10            ; Copy result to "Cltx10" Engine Coolant Temperature x 10
    
;*****************************************************************************************
; - Look up Manifold Air Temperature (Degrees F x 10)
;*****************************************************************************************

    ldx   matAdc            ; Load index register X with value in "matAdc"
    aslx                    ; Arithmetic shift left index register X (multiply "matAdc"
                            ; by two) I have no idea why I have to do this but if I don't
                            ; the table look up is only half of where it shoud be ???????
    ldy   DodgeThermistor,X ; Load index register Y with value in "DodgeThermistor" table,
                            ; offset in index register X
    sty   Matx10            ; Copy result to "Matx100" Manifold Air Temperature x 10
    
;*****************************************************************************************
; - Calculate Manifold Absolute Pressure x 10 
;   (Used to calculate to 1 decimal place)
;   Dodge V10 MAP sensor test data 7/30/20:
;   Vout = 4.57,    ADC = 935, KPA = 101.5
;   Vout = .004887, ADC = 1,   KPA = 11.02
;*****************************************************************************************

    ldd  #$000A    ; Load double accumulator with decimal 1 (.004887 volt ADC) ( x 10)
    std  interpV1  ; Copy to "interp2DV1"
    ldd  mapAdc    ; Load double accumulator with "mapAdc"
    ldy  #$000A    ; Load index register Y with decimal 10
    emul           ; Multiply (D)x(Y)=>Y:D  (multiply "mapAdc" by 10) 
    std  interpV   ; Copy to "interp2DV" 
    ldd  #$2486    ; Load double accumulator with decimal 935 (4.57 volt ADC) ( x 10)
    std  interpV2  ; Copy to "interp2DV2"            
    ldd  #$006E    ; Load double accumulator with decimal 11.02 (Low range KPA) ( x 10)
    std  interpZ1  ; Copy to "interp2DZ1"
    ldd  #$03F7    ; Load double accumulator with decimal 101.5 (High range KPA) ( x 10)
    std  interpZ2  ; Copy to "interp2DZ2"
    jsr  INTERP    ; Jump to Interpolation subroutine
    movw  interpZ,Mapx10  ; Copy result in "interp2DZ" to "Mapx10"  
    
;*****************************************************************************************
; - Calculate Throttle Position Percent x 10 
;*****************************************************************************************

    ldy  #veBins_R ; Load index register Y with address of first configurable constant
                   ; in RAM page 1 (veBins)
    ldd  $0354,Y   ; Load Accu D with value in RAM page 1 offset 852 (tpsMin)
    std  interpV1  ; Copy to "interp2DV1"
    ldd  tpsAdc    ; Load double accumulator with "tpsADCAdc"
    std  interpV   ; Copy to "interp2DV"
    ldy  #veBins_R ; Load index register Y with address of first configurable constant
                   ; in RAM page 1 (vebins)
    ldd  $0356,Y   ; Load Accu D with value in RAM page 1 offset 854 (tpsMax)
    std  interpV2  ; Copy to "interp2DV2"    
    ldd  #$0000    ; Load double accumulator with decimal 0 (Low range %) ( x 10)
    std  interpZ1  ; Copy to "interp2DZ1"
    ldd  #$03E8    ; Load double accumulator with decimal 1000 (High range %) ( x 10)
    std  interpZ2  ; Copy to "interp2DZ2"
    jsr  INTERP    ; Jump to Interpolation subroutine
    movw  interpZ,TpsPctx10  ; Copy result in "interp2DZ" to "TpsPctx10"

;*****************************************************************************************
; - Calculate Air Fuel Ratio x 10 for left bank (odd cylinders)-
;   Innovate LC-2 AFR is ratiometric 0V to 5V 7.35 AFR to 22.39 AFR
;   ( All variables are multiplied by 10 for greater precision)
;*****************************************************************************************

    ldd  #$0000    ; Load double accumulator with decimal 0 (0 volt ADC) ( x 10)
    std  interpV1  ; Copy to "interp2DV1"
    ldd  egoAdc1   ; Load double accumulator with "egoAdc1"
    ldy  #$000A    ; Load index register Y with decimal 10
    emul           ; Multiply (D)x(Y)=>Y:D  (multiply "egoAdc1" by 10) 
    std  interpV   ; Copy to "interp2DV"
    ldd  #$27F6    ; Load double accumulator with decimal 1023 (5 volt ADC) ( x 10) (10230)
    std  interpV2  ; Copy to "interp2DV2"
    ldd  #$004A    ; Load double accumulator with decimal 7.35 (Low range AFR) ( x 10) (74)
    std  interpZ1  ; Copy to "interp2DZ1"
    ldd  #$00E0    ; Load double accumulator with decimal 22.39 (High range AFR) ( x 10) (224)
    std  interpZ2  ; Copy to "interp2DZ2"
    jsr  INTERP    ; Jump to Interpolation subroutine
    movw  interpZ,afr1x10  ; Copy result in "interp2DZ" to "afr1x10"

;*****************************************************************************************
; - Calculate Barometric Pressure x 10
;   (Used to calculate to 1 decimal place)
;   Baro sensor MPXA6115AC7U
;   Vout = Baro sensor output voltage
;   P = Barometric pressure in KPA 
;
;   Vout = Vs x (0.009 x P - 0.095)
;   Vout = (baroAdc/1023)*5
;   P = ((Vout/5)+0.095)/0.009
; - For integer math:
;   P x 10 = ((baroAdc*10,000)/1023)+950)/9                              
;*****************************************************************************************

    ldd   baroAdc       ; Load double accumulator with value in "baroAdc"
    ldy   #$2710        ; Load index register Y with decimal decimal 10,000
    emul                ; Extended 16x16 multiply (D)x(Y)=Y:D
    ldx   #$03FF        ; Load index register X with decimal 1023
    ediv                ; Extended 32x16 divide(Y:D)/(X)=Y;Rem->D
    addy  #$03B6        ; Add without carry decimal 950 to Y (Y)+(M:M+1)->(Y)
    tfr   Y,D           ; Copy value in "Y" to "D"
    ldx   #$0009        ; Load index register "X" with decimal 9
    idiv                ; Integer divide (D)/(X)=>X Rem=>D 
    stx   Barox10       ; Copy result to "Barox10" (KPAx10)
    
;*****************************************************************************************
; - Calculate Engine Oil Pressure x 10 -
;   Pressure transducer TE Connectivity M3234-000005-100PG 5V supply, ratiometric 0.5V to 
;   4.5V 0PSI to 100PSI( All variables are multiplied by 10 for greater precision)
;*****************************************************************************************
;*****************************************************************************************
; - Check for under and over range
;*****************************************************************************************

    ldd  eopAdc    ; Load double accumulator with "eopAdc"
    cpd  #$0066    ; Compare "eopADC" with decimal 102 (0.5 volt ADC)
    bls  EOPlow    ; If "eopADC" is the same or less than 1020 branch to EOPlow: 
    cpd  #$0398    ; Compare "eopADC" with decimal 920 (04.5 volt ADC)
    bhs  EOPhi     ; If "eopADC" is the same or greater than 920 branch to EOPhi:
    bra  CalcEOP   ; Branch to CalcEOP:

EOPlow:
    movw #$0000,Eopx10  ; Load "Eopx10" with decimal 0 (0PSI)
    bra  EOPDone        ; Branch to EOPDone:  

EOPhi:
    movw #$03E8,Eopx10  ; Load "Eopx10" with decimal 1000 (100.0PSI)
    bra  EOPDone        ; Branch to EOPDone:      
    
CalcEOP:
    ldd  #$0066    ; Load double accumulator with decimal 102 (0.5 volt ADC)
    std  interpV1  ; Copy to "interp2DV1"
    ldd  eopAdc    ; Load double accumulator with "eopAdc"
    std  interpV   ; Copy to "interp2DV"
    ldd  #$0398    ; Load double accumulator with decimal 920 (4.5 volt ADC)
    std  interpV2  ; Copy to "interp2DV2"
    ldd  #$0000    ; Load double accumulator with decimal 0 (Low range PSI) ( x 10)
    std  interpZ1  ; Copy to "interp2DZ1"
    ldd  #$03E8    ; Load double accumulator with decimal 100 (High range PSI) ( x 10)
    std  interpZ2  ; Copy to "interp2DZ2"
    jsr  INTERP    ; Jump to Interpolation subroutine
    movw  interpZ,Eopx10  ; Copy result in "interp2DZ" to "Eopx10"
    
EOPDone:

;*****************************************************************************************
; - Calculate Engine Fuel Pressure x 10 -
;   Pressure transducer TE Connectivity M3234-000005-100PG 5V supply, ratiometric 0.5V to 
;   4.5V 0PSI to 100PSI( All variables are multiplied by 10 for greater precision)
;*****************************************************************************************
;*****************************************************************************************
; - Check for under and over range
;*****************************************************************************************

    ldd  efpAdc    ; Load double accumulator with "efpAdc"
    cpd  #$0066    ; Compare "efpAdc" with decimal 102 (0.5 volt ADC)
    bls  EFPlow    ; If "efpADC" is the same or less than 1020 branch to EFPlow: 
    cpd  #$0398    ; Compare "efpAdc" with decimal 920 (04.5 volt ADC)
    bhs  EFPhi     ; If "efpADC" is the same or greater than 9200 branch to EFPhi:
    bra  CalcEFP   ; Branch to CalcEFP:

EFPlow:
    movw #$0000,Efpx10  ; Load "Efpx10" with decimal 0 (0PSI)
    bra  EFPDone        ; Branch to EFPDone:  

EFPhi:
    movw #$03E8,Efpx10  ; Load "Efpx10" with decimal 1000 (100.0PSI)
    bra  EFPDone        ; Branch to EFPDone:      
    
CalcEFP:
    ldd  #$0066    ; Load double accumulator with decimal 102 (0.5 volt ADC)
    std  interpV1  ; Copy to "interp2DV1"
    ldd  efpAdc    ; Load double accumulator with "efpAdc"
    std  interpV   ; Copy to "interp2DV"
    ldd  #$0398    ; Load double accumulator with decimal 920 (4.5 volt ADC)
    std  interpV2  ; Copy to "interp2DV2"
    ldd  #$0000    ; Load double accumulator with decimal 0 (Low range PSI) ( x 10)
    std  interpZ1  ; Copy to "interp2DZ1"
    ldd  #$03E8    ; Load double accumulator with decimal 100 (High range PSI) ( x 10)
    std  interpZ2  ; Copy to "interp2DZ2"
    jsr  INTERP    ; Jump to Interpolation subroutine
    movw  interpZ,Efpx10  ; Copy result in "interp2DZ" to "Efpx10"
    
EFPDone:

;*****************************************************************************************
; - Calculate Air Fuel Ratio x 10 for right bank (even cylinders)-
;   Innovate LC-2 AFR is ratiometric 0V to 5V 7.35 AFR to 22.39 AFR
;   ( All variables are multiplied by 10 for greater precision)
;*****************************************************************************************

    ldd  #$0000    ; Load double accumulator with decimal 0 (0 volt ADC) ( x 10)
    std  interpV1  ; Copy to "interp2DV1"
    ldd  egoAdc2   ; Load double accumulator with "egoAdc2"
    ldy  #$000A    ; Load index register Y with decimal 10
    emul           ; Multiply (D)x(Y)=>Y:D  (multiply "egoADC2" by 10) 
    std  interpV   ; Copy to "interp2DV"
    ldd  #$27F6    ; Load double accumulator with decimal 1023 (5 volt ADC) ( x 10) (10230)
    std  interpV2  ; Copy to "interp2DV2"
    ldd  #$004A    ; Load double accumulator with decimal 7.35 (Low range AFR) ( x 10) (74)
    std  interpZ1  ; Copy to "interp2DZ1"
    ldd  #$00E0    ; Load double accumulator with decimal 22.39 (High range AFR) ( x 10) (224)
    std  interpZ2  ; Copy to "interp2DZ2"
    jsr  INTERP    ; Jump to Interpolation subroutine
    movw  interpZ,afr2x10  ; Copy result in "interp2DZ" to "afr2x10"
    
;*****************************************************************************************        
; - Calculate Ignition Trim (Degrees x 10)(+-20 Degrees) -
;   Ignition calculations delay the coil energisation time (dwell) and the discharge time
;   (spark timing) from a known crankshaft angle. A trim offset of 20 degrees is built in.
;    An Itrm value of 0 results in 20 degree retard
;    An Itrm value of 20 results in no ignition trim
;    An Itrm value of 40 results in 20 degree advance
;   ( All variables are multiplied by 10 for greater precision)
;*****************************************************************************************

    brset PortAbits,Itrimen,NoItrim ; "If Itrimen" bit of "PortAbits" is set, branch to 
	                 ; NoItrim: (Ignition trim enable switch is off so skip over)
    ldd  #$0000    ; Load double accumulator with zero (0 volt ADC) 
    std  interpV1  ; Copy to "interp2DV1"
    ldd  itrmAdc   ; Load double accumulator with "itrmAdc"
    ldy  #$000A    ; Load index register Y with decimal 10
    emul           ; Multiply (D)x(Y)=>Y:D  (multiply "itrmAdc" by 10) 
    std  interpV   ; Copy to "interp2DV"
    ldd  #$27F6    ; Load double accumulator with decimal 1023x10 (5 volt ADC) 
    std  interpV2  ; Copy to "interp2DV2"
    ldd  #$0000    ; Load double accumulator with zero (Low range degrees) 
    std  interpZ1  ; Copy to "interp2DZ1"
    ldd  #$0190    ; Load double accumulator with decimal 40x10 (High range degrees)
    std  interpZ2  ; Copy to "interp2DZ2"
    jsr  INTERP    ; Jump to Interpolation subroutine
    movw  interpZ,Itrmx10  ; Copy result in "interp2DZ" to "Itrmx10"
   	bra   ItrimDone        ; Branch to ItrimDone:
	
NoItrim:
    movw #$00C8,Itrmx10    ; Decimal 200 -> "Itrmx10" (20 degrees, no trim)

ItrimDone:
          
;*****************************************************************************************        
; - Calculate Fuel Trim (% x 10)(+-50%) -
;   (50% = 50% of VEcurr, 100% = 100% of VeCurr(no correction), 150% = 150% of VEcurr)
;   ( All variables are multiplied by 10 for greater precision)
;*****************************************************************************************

    brset PortAbits,Ftrimen,NoFtrim ; "If Ftrimen" bit of "PortAbits" set, branch to 
	                  ; NoFtrim: (Fuel trim enable switch is off so skip over)   	
    ldd   #$0000    ; Load double accumulator with zero (0 volt ADC) 
    std  interpV1   ; Copy to "interp2DV1"
    ldd   ftrmAdc   ; Load double accumulator with "ftrmAdc"
    ldy   #$000A    ; Load index register Y with decimal 10
    emul            ; Multiply (D)x(Y)=>Y:D  (multiply "ftrmAdc" by 10) 
    std  interpV    ; Copy to "interp2DV"
    ldd   #$27F6    ; Load double accumulator with decimal 1023x10 (5 volt ADC) 
    std  interpV2   ; Copy to "interp2DV2"
    ldd   #$01F4    ; Load double accumulator with decimal 50x10 (Low range %) 
    std  interpZ1   ; Copy to "interp2DZ1"
    ldd   #$05DC    ; Load double accumulator with decimal 150x10 (High range %)
    std  interpZ2   ; Copy to "interp2DZ2"
    jsr  INTERP     ; Jump to Interpolation subroutine
    movw  interpZ,Ftrmx10  ; Copy result in "interp2DZ" to "Ftrmx10"
    bra   FtrimDone        ; Branch to FtrimDone:
	
NoFtrim:
    movw #$03E8,Ftrmx10  ; Decimal 1000 -> "Ftrmx10" (100%, no trim)
	
FtrimDone:
    rts                  ; Return from CONVERT_ATD0 subroutine
    
;*****************************************************************************************
;                        TABLE LOOKUP AND INTERPOLATION SUBROUTINES
;*****************************************************************************************

;*****************************************************************************************
; - Interpolation variables
;*****************************************************************************************

;interpV:  ds 2 ; Interpolation variable "V" (offset=269) (Memory location $210D)
;interpV1: ds 2 ; Interpolation variable "V1"(offset=271) (Memory location $210F)
;interpV2: ds 2 ; Interpolation variable "V2"(offset=273) (Memory location $2111)
;interpZ:  ds 2 ; Interpolation variable "Z"(offset=275) (Memory location $2113)
;interpZ1: ds 2 ; Interpolation variable "Z1"(offset=277) (Memory location $2115)
;interpZ2: ds 2 ; Interpolation variable "Z2"(offset=279) (Memory location $2117)

;*****************************************************************************************
;*****************************************************************************************
; - 3DLUT table parameters for VE, ST and AFR 3D tables. 
;*****************************************************************************************

;ROW_COUNT		    equ	$10    ; Number of rows in table (16 = $10)
;COL_COUNT		    equ	$10    ; Number of columns in table (16 = $10)
;ROW_BIN_OFFSET   equ $200   ; Row bin offset from start of table (512 = $200)
;COL_BIN_OFFSET   equ $220   ; Column bin offset from start of table (544 = $220)

;*****************************************************************************************
;*****************************************************************************************

; -Look-up value in 3D Table -
; ========================= 
; args:   D: row value                       
;         X: column value                         
;         Y: table pointer
; result: D: look-up value
; SSTACK:  bytes
;         X and Y are preserved
;
;*****************************************************************************************
 
D3_LOOKUP:   ; Subroutine, Author Dirk Heiswolf

;*****************************************************************************************
; - Save registers (row value in D, column value in X, table pointer 
;   in Y)
;*****************************************************************************************

	PSHY					 ;save table pointer
	PSHX				     ;save column value
 	PSHD				     ;save row value

;*****************************************************************************************
		;    +--------+--------+               
		;    |    row value    |  SP+ 0 ($3FF8)
		;    +--------+--------+       
		;    |  column value   |  SP+ 2 ($3FFA)
		;    +--------+--------+       
		;    |  table pointer  |  SP+ 4 ($3FFC)
		;    +--------+--------+
;*****************************************************************************************
;*****************************************************************************************        
; - Determine upper and lower column bin entry (column value in X, 
;   table pointer in Y)
;*****************************************************************************************

    LEAY COL_BIN_OFFSET,Y   ; Column bin pointer -> Y ;($2AC=684)
    LDAB #(2*(ROW_COUNT-1)) ; Lower column bin offset -> B ;($22=34) 
    TBA					    ; Lower  offset -> A (start at $22=34)
    CPX	 A,Y                ; Compare column value against current bin value 
    BGE  D_LOOKUP_2A        ; First iteration, if equal to or greater 
                            ; than current bin value, rail high, upper 
                            ; and lower bin offsets the same
D_LOOKUP_1:
    TBA				        ; Lower  offset -> A
    CPX	 A,Y                ; Compare column value against current bin value
	BGE	 D_LOOKUP_2         ; Branch if column value is greater than 
                            ; or equal to current bin value (match found)
	DECB                    ; Decrement bin offset low byte
	DBNE B,D_LOOKUP_1       ; Decrement bin offset Hi byte and loop back if not zero 
	TBA					    ; Column value too low, no match found, rail low, make 
                            ; lower and upper bin offsets the same)
    BRA   D_LOOKUP_2A
        
;*****************************************************************************************
; - Increment lower offset to make upper offset
;*****************************************************************************************  

D_LOOKUP_2:
    INCA                ; Increment lower offset Lo byte
    INCA                ; Increment lower offset Hi byte to make upper offset in "A"
                            
;*****************************************************************************************
; - Push upper and lower column value (upper column bin offset in A, 
;   lower column bin offset in B, column bin pointer in Y)
;*****************************************************************************************

D_LOOKUP_2A:
    MOVW B,Y, 2,-SP     ; Push lower column value onto stack
	MOVW A,Y, 2,-SP     ; Push upper column value onto stack

;*****************************************************************************************
		;    +--------+--------+       
		;    | upper col value |  SP+ 0 ($3FF4)
		;    +--------+--------+       
		;    | lower col value |  SP+ 2 ($3FF6)
		;    +--------+--------+               
		;    |    row value    |  SP+ 4 ($3FF8)
		;    +--------+--------+       
		;    |  column value   |  SP+ 6 ($3FFA)
		;    +--------+--------+       
		;    |  table pointer  |  SP+ 8 ($3FFC)
		;    +--------+--------+
;*****************************************************************************************
;*****************************************************************************************        
; - Push upper and lower row pointer (upper colum bin offset in A, 
;   lower column bin offset in B)
;*****************************************************************************************

	SEX  A,X              ; Save upper column bin offset in XL
	LDAA #COL_COUNT       ; Multiply lower column bin offset column count ($12=18)
	MUL                   ; (A)x(B)->A:B
	ADDD 8,SP             ; Add table pointer
	PSHD                  ; Push lower row pointer onto the stack
	TFR	 X,B              ; Restore upper colum bin offset
	LDAA #COL_COUNT       ; Multiply lower column bin offset column count ($12=18)
	MUL                   ; (A)x(B)->A:B (test 18*6=108) 
	ADDD (8+2),SP         ; Not sure what this is????
   	PSHD                  ; Push upper row pointer onto the stack
        
;*****************************************************************************************
		;    +--------+--------+       
		;    |  upper row ptr  |  SP+ 0 ($3FF0)
		;    +--------+--------+       
		;    |  lower row ptr  |  SP+ 2 ($3FF2)
		;    +--------+--------+       
		;    | upper col value |  SP+ 4 ($3FF4)
		;    +--------+--------+       
		;    | lower col value |  SP+ 6 ($3FF6)
		;    +--------+--------+               
		;    |    row value    |  SP+ 8 ($3FF8)
		;    +--------+--------+       
		;    |  column value   |  SP+10 ($3FFA)
		;    +--------+--------+       
		;    |  table pointer  |  SP+12 ($3FFC)
		;    +--------+--------+
;*****************************************************************************************
;*****************************************************************************************        
; - Determine upper and lower row bin entry (column value in X, 
;   table pointer in Y)
;*****************************************************************************************

	LDY	 12,SP              ; Table pointer -> Y
	LEAY ROW_BIN_OFFSET,Y   ; Row bin pointer -> Y($288=648)
    LDAB #(2*(ROW_COUNT-1)) ; Lower row bin offset -> B ($22=34)
    LDX  8,SP               ; Row value -> X
    TBA                     ; Lower offset -> A (start at $22=34)
    CPX	A,Y	                ; Compare row value against current bin value
    BGE D_LOOKUP_4A         ; First iteration, if equal to or greater than current bin value, 
                            ; rail high, upper and lower bin offsets the same
D_LOOKUP_3:
    TBA	              ; Lower  offset -> A
    CPX	 A,Y          ; Compare column value against current bin value
	BGE	D_LOOKUP_4    ; Branch if column value is greater than or equal to current bin  
                      ; value (match found)
	DECB              ; Decrement bin offset low byte
	DBNE B,D_LOOKUP_3 ; Decrement bin offset Hi byte and loop back if not zero 
	TBA	              ; Column value too low, no match found, rail low, make lower and 
                      ; upper bin offsets the same)
    bra   D_LOOKUP_4A
        
;*****************************************************************************************
; - Increment lower offset to make upper offset
;*****************************************************************************************

D_LOOKUP_4:
    INCA              ; Increment lower offset Lo byte
    INCA              ; Increment lower offset Hi byte to make upper offset in "A"
        
;*****************************************************************************************
; - Push upper and lower row value (upper row bin offset in A, 
;   lower row bin offset in B, row bin pointer in Y)
;*****************************************************************************************

D_LOOKUP_4A:
    MOVW	B,Y, 2,-SP  ; Push lower row value onto stack 
	MOVW	A,Y, 2,-SP  ; Push upper row value onto stack

;*****************************************************************************************
		;    +--------+--------+       
		;    | upper row value |  SP+ 0 ($3FFC)
		;    +--------+--------+       
		;    | lower row value |  SP+ 2 ($3FEE)
		;    +--------+--------+       
		;    |  upper row ptr  |  SP+ 4 ($3FF0)
		;    +--------+--------+       
		;    |  lower row ptr  |  SP+ 6 ($3FF2)
		;    +--------+--------+       
		;    | upper col value |  SP+ 8 ($3FF4)
		;    +--------+--------+       
		;    | lower col value |  SP+10 ($3FF6)
		;    +--------+--------+               
		;    |    row value    |  SP+12 ($3FF8)
		;    +--------+--------+       
		;    |  column value   |  SP+14 ($3FFA)
		;    +--------+--------+       
		;    |  table pointer  |  SP+16 ($3FFC)
		;    +--------+--------+
;*****************************************************************************************
;*****************************************************************************************        

; - Read Zhh, Zhl, Zlh, and Zll from look-up table 
;  (upper row bin offset in A, lower row bin offset in B)
;*****************************************************************************************
;*****************************************************************************************
		; 
		;   lower                  upper                                                             
		;    row         row        row                                                 
		;   value       value      value                                                             
		;     .           .          .         lower                     
		;   ..0......................o.........column                     
		;     .Zll        .Zl        .Zlh      value                          
		;     .           .          .                           
		;     .           .          .                           	
		;   ...................................column                     
		;     .           .Z         .         value              
		;     .           .          .                           
		;     .           .          .         upper                  
		;   ..o......................o.........column                     
		;     .Zhl        .Zh        .Zhh      value                            	
		;
;*****************************************************************************************
        
		LDY	 4,SP       ; Upper row pointer -> Y
		LDX  6,SP       ; Lower row pointer -> X
		MOVW B,X, 2,-SP	; Push Zll	
		MOVW A,X, 2,-SP	; Push Zlh 
		MOVW B,Y, 2,-SP	; Push Zhl        
		MOVW A,Y, 2,-SP	; Push Zhh

;*****************************************************************************************        
		;    +--------+--------+       
		;    |       Zhh       |  SP+ 0 ($3FE4)
		;    +--------+--------+       
		;    |       Zhl       |  SP+ 2 ($3FE6)
		;    +--------+--------+       
		;    |       Zlh       |  SP+ 4 ($3FE8)
		;    +--------+--------+       
		;    |       Zll       |  SP+ 6 ($3FEA)
		;    +--------+--------+       
		;    | upper row value |  SP+ 8 ($3FEC)
		;    +--------+--------+       
		;    | lower row value |  SP+10 ($3FEE)
		;    +--------+--------+       
		;    |  upper row ptr  |  SP+12 ($3FF0)
		;    +--------+--------+       
		;    |  lower row ptr  |  SP+14 ($3FF2)
		;    +--------+--------+       
		;    | upper col value |  SP+16 ($3FF4)
		;    +--------+--------+       
		;    | lower col value |  SP+18 ($3FF6)
		;    +--------+--------+               
		;    |    row value    |  SP+20 ($3FF8)
		;    +--------+--------+       
		;    |  column value   |  SP+22 ($3FFA)
		;    +--------+--------+       
		;    |  table pointer  |  SP+24 ($3FFC)
		;    +--------+--------+
;*****************************************************************************************
;*****************************************************************************************        
; - Determine Zl
;*****************************************************************************************
;	                  V       V1      V2      Z1     Z2
;		2D_IPOL	(20,SP), (10,SP), (8,SP), (6,SP), (4,SP)
    ldd  20,SP
    std  interpV
    ldd  10,SP
    std  interpV1
    ldd  8,SP
    std  interpV2
    ldd  6,SP
    std  interpZ1
    ldd  4,SP
    std  interpZ2
    jsr  INTERP
    
 	PSHD     ; Push Zl onto stack

;*****************************************************************************************
		;    +--------+--------+       
		;    |       Zl        |  SP+ 0 ($3FE2)                
		;    +--------+--------+                               
		;    |       Zhh       |  SP+ 2 ($3FE4)                    
		;    +--------+--------+                               
		;    |       Zhl       |  SP+ 4 ($3FE6)                
		;    +--------+--------+       
		;    |       Zlh       |  SP+ 6 ($3FE8)
		;    +--------+--------+       
		;    |       Zll       |  SP+ 8 ($3FEA)
		;    +--------+--------+       
		;    | upper row value |  SP+10 ($3FEC)
		;    +--------+--------+       
		;    | lower row value |  SP+12 ($3FEE)
		;    +--------+--------+       
		;    |  upper row ptr  |  SP+14 ($3FF0)
		;    +--------+--------+       
		;    |  lower row ptr  |  SP+16 ($3FF2)
		;    +--------+--------+       
		;    | upper col value |  SP+18 ($3FF4)
		;    +--------+--------+       
		;    | lower col value |  SP+20 ($3FF6)
		;    +--------+--------+               
		;    |    row value    |  SP+22 ($3FF8)
		;    +--------+--------+       
		;    |  column value   |  SP+24 ($3FFA)
		;    +--------+--------+       
		;    |  table pointer  |  SP+26 ($3FFC)
		;    +--------+--------+
;*****************************************************************************************
;*****************************************************************************************        
; - Determine Zh
;*****************************************************************************************
;	                  V       V1       V2      Z1     Z2
;		2D_IPOL	(22,SP), (12,SP), (10,SP), (4,SP), (2,SP)
	ldd  22,SP
    std  interpV   ; Copy to "interpV" 
    ldd  12,SP
    std  interpV1  ; Copy to "interpV1"
    ldd  10,SP
    std  interpV2  ; Copy to "interpV2"
    ldd  4,SP
    std  interpZ1  ; Copy to "interpZ1"
    ldd  2,SP
    std  interpZ2  ; Copy to "interpZ2"
    jsr  INTERP
    
 	PSHD           ; Push Zh onto stack
        
;*****************************************************************************************        
		;    +--------+--------+       
		;    |       Zh        |  SP+ 0 ($3FE0)
		;    +--------+--------+       
		;    |       Zl        |  SP+ 2 ($3FE2)
		;    +--------+--------+       
		;    |       Zhh       |  SP+ 4 ($3FE4)
		;    +--------+--------+       
		;    |       Zhl       |  SP+ 6 ($3FE6)
		;    +--------+--------+       
		;    |       Zlh       |  SP+ 8 ($3FE8)
		;    +--------+--------+       
		;    |       Zll       |  SP+10 ($3FEA)
		;    +--------+--------+       
		;    | upper row value |  SP+12 ($3FEC)
		;    +--------+--------+       
		;    | lower row value |  SP+14 ($3FEE)
		;    +--------+--------+       
		;    |  upper row ptr  |  SP+16 ($3FF0)
		;    +--------+--------+       
		;    |  lower row ptr  |  SP+18 ($3FF2)
		;    +--------+--------+       
		;    | upper col value |  SP+20 ($3FF4)
		;    +--------+--------+       
		;    | lower col value |  SP+22 ($3FF6)
		;    +--------+--------+               
		;    |    row value    |  SP+24 ($3FF8)
		;    +--------+--------+       
		;    |  column value   |  SP+26 ($3FFA)
		;    +--------+--------+       
		;    |  table pointer  |  SP+28 ($3FFC)
		;    +--------+--------+
;*****************************************************************************************
;*****************************************************************************************        
; - Determine Z
;*****************************************************************************************
;	                  V       V1        V2      Z1     Z2
;		2D_IPOL	(26,SP), (22,SP), (20,SP), (2,SP), (0,SP)
	ldd  26,SP
    std  interpV   ; Copy to "interpV"
    ldd  22,SP
    std  interpV1  ; Copy to "interpV1"
    ldd  20,SP
    std  interpV2  ; Copy to "interpV2"
    ldd  2,SP
    std  interpZ1  ; Copy to "interpZ1"
    ldd  0,SP
    std  interpZ2  ; Copy to "interpZ2"
    jsr  INTERP
    
;*****************************************************************************************        
; - Free stack space (result in D)
;*****************************************************************************************

	LEAS 26,SP   ; Stack pointer -> bottom of stack
        
;*****************************************************************************************
; - Restore registers (result in D)
;*****************************************************************************************

	PULX   ; Pull index register X from stack
	PULY   ; Pull index register Y from stack
        
;*****************************************************************************************
; - Done (result in D)
;*****************************************************************************************

	RTS   ; Return from D3_LOOKUP subroutine
        
;*****************************************************************************************

;*****************************************************************************************
; - This subroutine calculates the interpolated value of a 2D curve with an X axis that 
;   starts with negative values and ends with positive values. The X axis MUST have
;   -0.2 (65534) and +0.2 (2) together some place in the row for the code to work.
;*****************************************************************************************

CRV_LU_NP:   ; Subroutine, Author Dirk Heiswolf

;*****************************************************************************************
; - First, determine the position in the row of the comparison value for 
;   interpolation (IndexNum). Position in the column will be the same as the position 
;   in the row. Determine the row high and low boundary values.
;***************************************************************************************** 

;*****************************************************************************************
; - Set up the process to find the interpolated curve value by determining the values 
;   of the first bins in the row and column. Clear the index number variable. 
;*****************************************************************************************

    jsr   CRV_SETUP   ; Jump to CRV_SETUP subroutine
    
;*****************************************************************************************
; I COULDN'T GET THE NEGATIVE VALUE PORTION OF THIS CODE TO WORK, SO RATHER THAN SPEND 
; MUCH MORE TIME TROUBLESHOOTING IT I JUST COMMENTED IT OUT AND WROTE NEW CODE FOR THE 
; INDIVIDUAL NEGATIVE TEMPERATURE VALUES. THE POSITIVE PORTION WORKS JUST FINE. THE 
; NEGATIVE CODE IS STILL HERE IN CASE I EVENTUALLY FIGURE THE PROBLEM OUT.
;*****************************************************************************************
     
;*****************************************************************************************
; - CrvRowLo is negative. Now check CrvCmpVal for negative number. 
;*****************************************************************************************

;    ldx  CrvCmpVal    ; Curve comparison value -> X    
;    andx #$8000       ; Logical AND X with %1000 0000 0000 0000 (CCR N bit set of MSB of 
                      ; result is set)
;    bmi  CmpValNeg    ; If N bit of CCR is set, branch to CmpValNeg: 
                      ;(CrvCmpVal is negative)   
;    jmp  CmpValPos    ; Jump or branch to CmpValPos: (CrvCmpVal is positive)
    
;CmpValNeg:

;*****************************************************************************************
; - Both CrvRowLo and CrvCmpVal are negative. Now see if CrvCmpVal is the same or less than
;   than CrvRowLo. If it is, rail low at the value of the first column bin. If it is not,
;   it must be greater than CrvRowLo, so loop back to do the next iteration.    
;*****************************************************************************************

;    ldx  CrvCmpVal    ; Curve compare value -> X
;    cpx  CrvRowLo     ; Compare curve compare value with curve low boundary
;    bls  RailLowNeg   ; If CrvCmpVal is the same or less than CrvRowLo branch to RailLowNeg:
;    bra  ReEntCrvNeg1 ; Branch to ReEntCrvNeg1:
    
;RailLowNeg:
;    ldd  CrvColLo    ; Curve column low boundary value -> D
;	  std  interpZ     ; Copy result to "interpZ" (All done)
;    rts              ; Return from subroutine(Rail low with CrvColLo in Accur D, 
                     ; no interpolation required)
    
;*****************************************************************************************
; - Both CrvRowLo and CrvCmpVal are negative. CrvCmpVal is the greater than CrvRowLo. 
;   Determine the value of CrvRowHi
;*****************************************************************************************

;ReEntCrvNeg1:

;    inc  IndexNum     ; Increment position in the row or column of the curve comparison 
                      ; value
;    movw CrvRowHi,CrvRowLo ; Curve row high boundry value -> curve row low boundry value  
;    incw CrvRowOfst   ; Increment Offset from the curve page to the curve row
;    ldy  CrvPgPtr     ; Pointer to the page where the desired curve resides -> Y 
;    ldd  CrvRowOfst   ; Incremented offset from the curve page to the curve row -> D
;    leay D,Y          ; Curve row pointer -> Y 
;    movw D,Y,CrvRowHi ; Copy to curve row high boundry value for interpolation
                      ; (holds the contents of the incremented row bin)
                      
;RowHiNeg1:
;*****************************************************************************************
; - CrvRowLo, CrvRowHi and CrvCmpVal are all negative. CrvCmpVal is the greater than  
;   CrvRowLo. Now see if CrvRowHi is greater than CrvCmpVal. If it is, we have the index  
;   number, if it is not, loop back to increment to the next bin and check again.
;*****************************************************************************************

;    ldx  D,Y          ; Contents of incremented row bin -> X
;    cpx  CrvCmpVal    ; Compare Contents of incremented row bin with curve comparison value
;    bhs  RowHiNeg2    ; If contents of incremented row bin is greater than or equal to 
                      ; curve compareson value then branch to RowHiNeg2:
;    ldaa IndexNum     ; Incremented position in the row or column of the curve comparison 
                      ; value for interpolation -> A
;    cmpa CrvBinCnt    ; Compare Incremented position in the row or column of the curve 
                      ; comparison value for interpolation with number of bins in the curve  
                      ; row or column minus 1
;    bne  ReEntCrvNeg1 ; If (A)-(M) if IndexNum does not = CrvBinCnt then branch to 
                      ; ReEntCrvNeg1:
                      
;RowHiNeg2:

;*****************************************************************************************
; - Using the index number determine the column high and low boundary values
;*****************************************************************************************

;    jsr  COL_BOUNDARYS  ; Jump to COL_BOUNDARYS subroutine
   
;*****************************************************************************************
; - Do the interpolation or rail high and exit subroutine
;*****************************************************************************************

;    jsr  CRV_INTERP   ; Jump to CRV_INTERP subroutine
   
;**************************************************************************************
   
CmpValPos:

;*****************************************************************************************
; - CrvCmpVal is positive. Starting at the beginning of the row, loop through until the
;   first positive value is found.
;*****************************************************************************************

PosFind:
    inc  IndexNum     ; Increment position in the row or column of the curve comparison 
                      ; value
    movw CrvRowHi,CrvRowLo ; Curve row high boundry value -> curve row low boundry value  
    incw CrvRowOfst   ; Increment Offset from the curve page to the curve row
    ldy  CrvPgPtr     ; Pointer to the page where the desired curve resides -> Y 
    ldd  CrvRowOfst   ; Incremented offset from the curve page to the curve row -> D
    leay D,Y          ; Curve row pointer -> Y 
    movw D,Y,CrvRowHi ; Copy to curve row high boundry value for interpolation
                      ; (holds the contents of the incremented row bin)
    ldx  CrvRowHi     ; Curve row high boundry value -> X    
    andx #$8000       ; Logical AND X with %1000 0000 0000 0000 (CCR N bit set of MSB of 
                      ; result is set)
    bmi  PosFind      ; If N bit of CCR is set, branch to PosFind: (CrvRowHi is negative
                      ; so loop back until the first positive value is found)

;*****************************************************************************************
; - CrvCmpVal is positive. We have found the first positive row value so all other row 
;   values will be positive.
;*****************************************************************************************

;*****************************************************************************************
; - Both CrvRowLo and CrvCmpVal are positive. CrvCmpVal is the greater than CrvRowLo. 
;   Determine the value of CrvRowHi
;*****************************************************************************************

ReEntCrvPos:
    inc  IndexNum     ; Increment position in the row or column of the curve comparison 
                      ; value
    movw CrvRowHi,CrvRowLo ; Curve row high boundry value -> curve row low boundry value  
    incw CrvRowOfst   ; Increment Offset from the curve page to the curve row
    ldy  CrvPgPtr     ; Pointer to the page where the desired curve resides -> Y 
    ldd  CrvRowOfst   ; Incremented offset from the curve page to the curve row -> D
    leay D,Y          ; Curve row pointer -> Y 
    movw D,Y,CrvRowHi ; Copy to curve row high boundry value for interpolation
                      ; (holds the contents of the incremented row bin)
                      
;*****************************************************************************************
; - CrvRowLo, CrvCmpVal and CrvRowHi are all positive. CrvCmpVal is the greater than CrvRowLo. 
;   Now see if CrvRowHi is greater than CrvCmpVal. If it is, we have the index number, 
;   if it is not, loop back to increment to the next bin and check again.
;*****************************************************************************************

    ldx  CrvRowHi     ; Curve row high boundary -> X
    cpx  CrvCmpVal    ; Compare curve curve row high boundary with curve compare value    
    bhs  GotNumPos    ; If contents of incremented row bin is greater than or equal to  
                      ; curve compareson value then branch to GotNumPos:
    ldaa IndexNum     ; Incremented position in the row or column of the curve comparison 
                      ; value for interpolation -> A
    cmpa CrvBinCnt    ; Compare Incremented position in the row or column of the curve 
                      ; comparison value for interpolation with number of bins in the curve  
                      ; row or column minus 1
    bne  ReEntCrvPos  ; If (A)-(M) if IndexNum does not = CrvBinCnt then branch to 
                      ; ReEntCrvPos1:
                      
GotNumPos:

;*****************************************************************************************
; - CrvRowLo, CrvCmpVal and CrvRowHi are all positive. CrvCmpVal is the greater than 
;   CrvRowLo. CrvRowHi is greater than or equal to CrvCmpVal so we must have our index 
;   number.
;*****************************************************************************************
                      
;*****************************************************************************************
; - Using the index number determine the column high and low boundary values
;*****************************************************************************************

    jsr  COL_BOUNDARYS   ; Jump to COL_BOUNDARYS subroutine
   
;*****************************************************************************************
; - Do the interpolation or rail high and exit subroutine
;*****************************************************************************************

    jsr  CRV_INTERP   ; Jump to CRV_INTERP subroutine
   
CRV_LU_NP_DONE:
    rts               ; Return from CRV_LU_NP subroutine
    
;*****************************************************************************************
    
;*****************************************************************************************
;*****************************************************************************************
; - Set up the process to find the interpolated curve value by determining the values 
;   of the first bins in the row and column. Clear the index number variable. 
;*****************************************************************************************
    
CRV_SETUP:   ; Subroutine, Author Dirk Heiswolf 
             
    ldy  CrvPgPtr     ; Pointer to the page where the desired curve resides -> Y
    ldd  CrvRowOfst   ; Offset from the curve page to the curve row -> D
    leay D,Y          ; Curve row pointer -> Y
    movw D,Y,CrvRowLo ; Copy to curve row low boundry value for interpolation
    movw D,Y,CrvRowHi ; Copy to curve row high boundry value for interpolation
                      ; (start with low and high row bin values equal
    ldy  CrvPgPtr     ; Pointer to the page where the desired curve resides -> Y
    ldd  CrvColOfst   ; Offset from the curve page to the curve column -> D
    leay D,Y          ; Curve column pointer -> Y
    movw D,Y,CrvColLo ; Copy to curve row column boundry value for interpolation
    movw D,Y,CrvColHi ; Copy to curve column high boundry value for interpolation
                      ; (start with low and high column bin values equal
    clr   IndexNum    ; Position in the row or column of the curve comparison value
                      ; for interpolation (start with zero)
    rts               ; Return from CRV_SETUP subroutine
    
;*****************************************************************************************
; - Using the index number determine the column high and low boundary values
;*****************************************************************************************                  

COL_BOUNDARYS:   ; Subroutine, Author Dirk Heiswolf

    ldx  CrvColOfst   ; Offset from the curve page to the curve column -> D
    ldab IndexNum     ; IndexNum -> B
    abx               ;(B)+(X)->X Pointer to indexed column bin
    stx  CrvColOfst   ; Result to CrvColOfst (now points to indexed column bin)
    ldy  CrvPgPtr     ; Pointer to the page where the desired curve resides -> Y
    ldd  CrvColOfst   ; Offset from the curve page to the curve column -> D
    leay D,Y          ; Curve column pointer -> Y
    movw D,Y,CrvColHi ; Copy to curve column high boundry value for interpolation
    decw CrvColOfst   ; Decrement offset from the curve page to the curve column
    ldy  CrvPgPtr     ; Pointer to the page where the desired curve resides -> Y
    ldd  CrvColOfst   ; Offset from the curve page to the curve column -> D
    leay D,Y          ; Curve column pointer -> Y
    movw D,Y,CrvColLo ; Copy to curve column low boundry value for interpolation
    ldd  CrvColLo     ; CrvColLo -> D
    rts               ; Return from COL_BOUNDARYS subroutine
    
;*****************************************************************************************
; - Do the interpolation or rail high and exit subroutine
;*****************************************************************************************

CRV_INTERP:   ; Subroutine, Author Dirk Heiswolf

    ldx  CrvCmpVal    ; Curve row comparison value -> X
    cpx  CrvRowHi     ; Compare row comparison value with curve row high boundry value
    blo  DoInterp     ; If Curve row comparison value is < curve row high boundry value
                      ; branch to DoInterp:
    ldd  CrvColHi     ; Curve column high boundry value -> D (result railed high)
    std  interpZ      ; Copy result to "interpZ" (all done)
    rts               ; Return from CRV_INTERP subroutine (CrvCmpVal is equal to or higher than 
                      ; CrvRowHi so no need to interpolate. Rail high with CrvColHi in D
                      
DoInterp:
;*****************************************************************************************
; - Copy curve interpolation values to interpolation subroutine values
;***************************************************************************************** 

    ldx  CrvCmpVal    ; Curve row comparison value -> X
    stx  interpV      ; X -> interpV 
    ldx  CrvRowHi     ; Curve row high boundry value -> X
    stx  interpV2     ; X -> interpV2     
    ldx  CrvRowLo     ; Curve row low boundry value -> X
    stx  interpV1     ; X -> interpV1     
    ldx  CrvColHi     ; Curve column high boundry value -> X
    stx  interpZ2     ; X -> interpZ2     
    ldx  CrvColLo     ; Curve column low boundry value -> X
    stx  interpZ1     ; X -> interpZ1  
    
;*****************************************************************************************     
    ;    +--------+--------+       
    ;    | col lo boundary |  (Z1)
    ;    +--------+--------+       
    ;    | col hi boundary |  (Z2)
    ;    +--------+--------+               
    ;    | row lo boundary |  (V1)
    ;    +--------+--------+       
    ;    | row hi boundary |  (V2)
    ;    +--------+--------+       
    ;    |    CrvCmpVal    |  (V)
    ;    +--------+--------+
;*****************************************************************************************

;*****************************************************************************************        
; - Determine Z
;*****************************************************************************************

    jsr  INTERP   ; Jump to INTERP subroutine
    rts           ; Return from CRV_INTERP subroutine

;*****************************************************************************************
; - 2D Interpolation routine
;*****************************************************************************************
;                               	
;    ^ V                                                                 	
;    |                                                             	
;  Z2+....................*                                                             	
;    |                    :                                         	
;   Z+...........*        :                 (V-V1)*(Z2-Z1)                            	
;    |           :        :        Z = Z1 + --------------                               	
;  Z1+...*       :        :                    (V2-V1)                                       	
;    |   :       :        :                                          	
;   -+---+-------+--------+---> K                                                                   	
;    |   V1      V        V2                                                 	
;
;*****************************************************************************************
                                                                      	
INTERP:   ; Subroutine, Author Dirk Heiswolf
  
;*****************************************************************************************
; - Calculate (V-V1)
;*****************************************************************************************
       
	LDD	  interpV	  ; load V         
	SUBD  interpV1  ; (A:B)-(M:M+1)->A:B Subtract V1    
	TFR	  D,Y       ; (V-V1) -> index Y
        
;*****************************************************************************************
; - Calculate (Z2-Z1)
;*****************************************************************************************

	LDD	  interpZ2    ; load Z2         
	SUBD  interpZ1    ; (A:B)-(M:M+1)->A:B Subtract Z1    
        
;*****************************************************************************************
; - Calculate (V-V1)*(Z2-Z1)
;*****************************************************************************************

	EMULS      ; (D)x(Y)->Y:D Multiply intermediate results -> Y:D
	TFR	  D,X  ; (V-V1)*(Z2-Z1) -> Y:X
        
;*****************************************************************************************       
; - Calculate (V2-V1)
;*****************************************************************************************

	LDD	  interpV2	; load V2                               
	SUBD  interpV1  ; (A:B)-(M:M+1)->A:B Subtract V1                 
	EXG	  D,X       ; (V2-V1) -> index X, (V-V1)*(Z2-Z1) -> Y:D
        
;*****************************************************************************************
;* - Calculate ((V-V1)*(Z2-Z1))/(V2-V1) 
;*****************************************************************************************

	EDIVS       ; (Y:D)/(X)->Y;Remainder->D 
                ; divide intermediate results -> index Y 
	TFR	  Y,D   ; (V-V1)*(Z2-Z1)/(V2-V1) -> D
        
;*****************************************************************************************
; - Calculate Z1+(((Z1 +((V-V1))*(Z2-Z1))/(V2-V1))  
;*****************************************************************************************

	ADDD  interpZ1	; (A:B)+(M:M+1)->A:B Add Z1
	STD   interpZ   ; Result in Accu D -> interp2DZ               
    rts             ; Return from INTERP subroutine
    
;*****************************************************************************************
   
;*****************************************************************************************
;                          FUEL INJECTOR TIMERS SUBROUTINES
;*****************************************************************************************

FIRE_INJ1:   ; Subroutine

    movb #$01,TIM_TFLG1    ; Clear C0F interrupt flag 
 
;*****************************************************************************************
; - PP0 - TIM1 OC0(Inj1)(1&10) Control
;*****************************************************************************************
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset TIM_TCTL2,#$01 ; Set Ch0 output line to 1 on compare bit0
    bset TIM_TCTL2,#$02 ; Set Ch0 output line to 1 on compare bit1
    ldd  TIM_TCNT       ; Contents of Timer Count Register-> Accu D
    addd InjOCadd1      ; (A:B)+(M:M+1->A:B Add "InjOCadd1" (Delay from trigger to start 
                        ; of injection)
    std  TIM_TC0        ; Copy result to Timer IC/OC register 0 (Start OC operation)
	                      ; (Will trigger an interrupt after the delay time)
	                      
;***********************************************************************************************
; - Update Fuel Delivery Pulse Width Total so the results can be used by Tuner Studio and 
;   Shadow Dash to calculate current fuel burn.
;***********************************************************************************************

    ldd  FDt            ; Fuel Delivery pulse width total(mS x 10)-> Accu D
    addd FDpw           ; (A:B)+(M:M+1->A:B Add  Fuel Delivery pulse width (mS x 10)
    std  FDt            ; Copy result to "FDT" (update "FDt")(mS x 10)
	
;***********************************************************************************************
; - Update the Fuel Delivery counter so that on roll over (6553.5mS)a pulsed signal can be sent to the
;   to the totalizer(open collector output)
;***********************************************************************************************

    ldd  FDpw           ; Fuel Delivery pulse width(mS x 10)-> Accu D
	addd FDcnt          ; (A:B)+(M:M+1)->A:B (fuel delivery pulsewidth + fuel delivery counter)
    bcs  Totalizer1     ; If the cary bit of CCR is set, branch to Totalizer1: ("FDcnt"
	                    ;  rollover, pulse the totalizer)
  	std  FDcnt          ; Copy the result to "FDcnt" (update "FDcnt")
    bra  TotalizerDone1 ; Branch to TotalizerDone1:

Totalizer1:
	std  FDcnt          ; Copy the result to "FDcnt" (update "FDcnt")
    bset PORTB,AIOT     ; Set "AIOT" pin on Port B (PB6)(start totalizer pulse)
	ldaa #$03           ; Decimal 3->Accu A (3 mS)
    staa AIOTcnt        ; Copy to "AIOTcnt" ( counter for totalizer pulse width, 
	                    ; decremented every mS)
	
TotalizerDone1:
	  rts                 ; Return from FIRE_INJ1 subroutine
	  
;*****************************************************************************************


FIRE_INJ2:   ; Subroutine

    movb #$02,TIM_TFLG1    ; Clear C1F interrupt flag 
                        
;*****************************************************************************************
; - PP1 - TIM1 OC1(Inj2)(9&4) Control
;*****************************************************************************************
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset TIM_TCTL2,#$04 ; Set Ch1 output line to 1 on compare bit2
    bset TIM_TCTL2,#$08 ; Set Ch1 output line to 1 on compare bit3
    ldd  TIM_TCNT       ; Contents of Timer Count Register-> Accu D
    addd InjOCadd1      ; (A:B)+(M:M+1->A:B Add "InjOCadd1" (Delay from trigger to start 
                        ; of injection)
    std  TIM_TC1        ; Copy result to Timer IC/OC register 1 (Start OC operation)
	                    ; (Will trigger an interrupt after the delay time)
	                      
;***********************************************************************************************
; - Update Fuel Delivery Pulse Width Total so the results can be used by Tuner Studio and 
;   Shadow Dash to calculate current fuel burn.
;***********************************************************************************************

    ldd  FDt            ; Fuel Delivery pulse width total(mS x 10)-> Accu D
    addd FDpw           ; (A:B)+(M:M+1->A:B Add  Fuel Delivery pulse width (mS x 10)
    std  FDt            ; Copy result to "FDT" (update "FDt")(mS x 10)
	
;***********************************************************************************************
; - Update the Fuel Delivery counter so that on roll over (6553.5mS)a pulsed signal can be sent to the
;   to the totalizer(open collector output)
;***********************************************************************************************

    ldd  FDpw           ; Fuel Delivery pulse width(mS x 10)-> Accu D
	addd FDcnt          ; (A:B)+(M:M+1)->A:B (fuel delivery pulsewidth + fuel delivery counter)
    bcs  Totalizer2     ; If the cary bit of CCR is set, branch to Totalizer2: ("FDcnt"
	                    ;  rollover, pulse the totalizer)
	std  FDcnt          ; Copy the result to "FDcnt" (update "FDcnt")
    bra  TotalizerDone2 ; Branch to TotalizerDone2:

Totalizer2:
  	std  FDcnt          ; Copy the result to "FDcnt" (update "FDcnt")
    bset PORTB,AIOT     ; Set "AIOT" pin on Port B (PB6)(start totalizer pulse)
	ldaa #$03           ; Decimal 3->Accu A (3 mS)
    staa AIOTcnt        ; Copy to "AIOTcnt" ( counter for totalizer pulse width, 
	                    ; decremented every mS)
	
TotalizerDone2:
    rts                 ; Return from FIRE_INJ2 subroutine
    
;*****************************************************************************************

FIRE_INJ3:   ; Subroutine

    movb #$04,TIM_TFLG1    ; Clear C2F interrupt flag
                        
;*****************************************************************************************
;; - PP2 - TIM1 OC2(Inj3)(3&6) Control
;*****************************************************************************************
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset TIM_TCTL2,#$10 ; Set Ch2 output line to 1 on compare bit4
    bset TIM_TCTL2,#$20 ; Set Ch2 output line to 1 on compare bit5
    ldd  TIM_TCNT       ; Contents of Timer Count Register-> Accu D
    addd InjOCadd1      ; (A:B)+(M:M+1->A:B Add "InjOCadd1" (Delay from trigger to start 
                        ; of injection)
    std  TIM_TC2        ; Copy result to Timer IC/OC register2 (Start OC operation)
	                    ; (Will trigger an interrupt after the delay time)
	                      
;***********************************************************************************************
; - Update Fuel Delivery Pulse Width Total so the results can be used by Tuner Studio and 
;   Shadow Dash to calculate current fuel burn.
;***********************************************************************************************

    ldd  FDt            ; Fuel Delivery pulse width total(mS x 10)-> Accu D
    addd FDpw           ; (A:B)+(M:M+1->A:B Add  Fuel Delivery pulse width (mS x 10)
    std  FDt            ; Copy result to "FDT" (update "FDt")(mS x 10)
	
;***********************************************************************************************
; - Update the Fuel Delivery counter so that on roll over (6553.5mS)a pulsed signal can be sent to the
;   to the totalizer(open collector output)
;***********************************************************************************************

    ldd  FDpw           ; Fuel Delivery pulse width(mS x 10)-> Accu D
	addd FDcnt          ; (A:B)+(M:M+1)->A:B (fuel delivery pulsewidth + fuel delivery counter)
    bcs  Totalizer3     ; If the cary bit of CCR is set, branch to Totalizer3: ("FDcnt"
	                    ;  rollover, pulse the totalizer)
	std  FDcnt          ; Copy the result to "FDcnt" (update "FDcnt")
    bra  TotalizerDone3 ; Branch to TotalizerDone3:

Totalizer3:
  	std  FDcnt          ; Copy the result to "FDcnt" (update "FDcnt")
    bset PORTB,AIOT     ; Set "AIOT" pin on Port B (PB6)(start totalizer pulse)
	ldaa #$03           ; Decimal 3->Accu A (3 mS)
    staa AIOTcnt        ; Copy to "AIOTcnt" ( counter for totalizer pulse width, 
	                    ; decremented every mS)
	
TotalizerDone3:
    rts                 ; Return from FIRE_INJ3 subroutine
    
;*****************************************************************************************

FIRE_INJ4:   ; Subroutine

    movb #$08,TIM_TFLG1    ; Clear C3F interrupt flag
                        
;*****************************************************************************************
; - PP3 - TIM1 OC3(Inj4)(5&8) Control
;*****************************************************************************************
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset TIM_TCTL2,#$40 ; Set Ch3 output line to 1 on compare bit6
    bset TIM_TCTL2,#$80 ; Set Ch3 output line to 1 on compare bit7
    ldd  TIM_TCNT       ; Contents of Timer Count Register-> Accu D
    addd InjOCadd1      ; (A:B)+(M:M+1->A:B Add "InjOCadd1" (Delay from trigger to start 
                        ; of injection)
    std  TIM_TC3        ; Copy result to Timer IC/OC register 3 (Start OC operation)
	                    ; (Will trigger an interrupt after the delay time)
	                      
;***********************************************************************************************
; - Update Fuel Delivery Pulse Width Total so the results can be used by Tuner Studio and 
;   Shadow Dash to calculate current fuel burn.
;***********************************************************************************************

    ldd  FDt            ; Fuel Delivery pulse width total(mS x 10)-> Accu D
    addd FDpw           ; (A:B)+(M:M+1->A:B Add  Fuel Delivery pulse width (mS x 10)
    std  FDt            ; Copy result to "FDT" (update "FDt")(mS x 10)
	
;***********************************************************************************************
; - Update the Fuel Delivery counter so that on roll over (6553.5mS)a pulsed signal can be sent to the
;   to the totalizer(open collector output)
;***********************************************************************************************

    ldd  FDpw           ; Fuel Delivery pulse width(mS x 10)-> Accu D
    addd FDcnt          ; (A:B)+(M:M+1)->A:B (fuel delivery pulsewidth + fuel delivery counter)
    bcs  Totalizer4     ; If the cary bit of CCR is set, branch to Totalizer4: ("FDcnt"
	                    ;  rollover, pulse the totalizer)
  	std  FDcnt          ; Copy the result to "FDcnt" (update "FDcnt")
    bra  TotalizerDone4 ; Branch to TotalizerDone4:

Totalizer4:
	std  FDcnt          ; Copy the result to "FDcnt" (update "FDcnt")
    bset PORTB,AIOT     ; Set "AIOT" pin on Port B (PB6)(start totalizer pulse)
	ldaa #$03           ; Decimal 3->Accu A (3 mS)
    staa AIOTcnt        ; Copy to "AIOTcnt" ( counter for totalizer pulse width, 
	                    ; decremented every mS)
	
TotalizerDone4:
    rts                 ; Return from FIRE_INJ4 subroutine
    
;*****************************************************************************************

FIRE_INJ5:   ; Subroutine

    movb #$10,TIM_TFLG1    ; Clear C4F interrupt flag
                        
;*****************************************************************************************
; - PP4 - TIM1 OC4(Inj5)(7&2) Control
;*****************************************************************************************
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset TIM_TCTL1,#$01 ; Set Ch4 output line to 1 on compare bit0
    bset TIM_TCTL1,#$02 ; Set Ch4 output line to 1 on compare bit1
    ldd  TIM_TCNT       ; Contents of Timer Count Register-> Accu D
    addd InjOCadd1      ; (A:B)+(M:M+1->A:B Add "InjOCadd1" (Delay from trigger to start 
                        ; of injection)
    std  TIM_TC4        ; Copy result to Timer IC/OC register 4(Start OC operation)
	                    ; (Will trigger an interrupt after the delay time)
	                      
;***********************************************************************************************
; - Update Fuel Delivery Pulse Width Total so the results can be used by Tuner Studio and 
;   Shadow Dash to calculate current fuel burn.
;***********************************************************************************************

    ldd  FDt            ; Fuel Delivery pulse width total(mS x 10)-> Accu D
    addd FDpw           ; (A:B)+(M:M+1->A:B Add  Fuel Delivery pulse width (mS x 10)
    std  FDt            ; Copy result to "FDT" (update "FDt")(mS x 10)
	
;***********************************************************************************************
; - Update the Fuel Delivery counter so that on roll over (6553.5mS)a pulsed signal can be sent to the
;   to the totalizer(open collector output)
;***********************************************************************************************

    ldd  FDpw           ; Fuel Delivery pulse width(mS x 10)-> Accu D
	addd FDcnt          ; (A:B)+(M:M+1)->A:B (fuel delivery pulsewidth + fuel delivery counter)
    bcs  Totalizer5     ; If the cary bit of CCR is set, branch to Totalizer5: ("FDcnt"
	                    ;  rollover, pulse the totalizer)
  	std  FDcnt          ; Copy the result to "FDcnt" (update "FDcnt")
    bra  TotalizerDone5 ; Branch to TotalizerDone5:

Totalizer5:
  	std  FDcnt          ; Copy the result to "FDcnt" (update "FDcnt")
    bset PORTB,AIOT     ; Set "AIOT" pin on Port B (PB6)(start totalizer pulse)
  	ldaa #$03           ; Decimal 3->Accu A (3 mS)
    staa AIOTcnt        ; Copy to "AIOTcnt" ( counter for totalizer pulse width, 
	                    ; decremented every mS)
	
TotalizerDone5:
    rts                 ; Return from FIRE_INJ5 subroutine
    
;*****************************************************************************************

    
;*****************************************************************************************
;                       INJECTOR PULSE WIDTH CALCULATIONS SUBROUTINES
;*****************************************************************************************

DEADBAND_CALCS:   ; Subroutine

;*****************************************************************************************
; - Interpolate injector deadband at current battery voltage
;*****************************************************************************************

    ldd  #$0048     ; Decimal 72 (7.2 volts) -> Accu D
    std  interpV1   ; Copy to "interpV1"             
    ldd  BatVx10    ; "BatVx10"(battery volts x 10) -> Accu D
    std  interpV    ; Copy to "interpV"
    ldd  #$00C0     ; Decimal 192 (19.2 volts) -> Accu D
    std  interpV2   ; Copy to "interpV2"             
	ldd  DdBndZ2    ;((Injector deadband at 13.2V) + (Injector deadband voltage 
	                ; correction * 6)) -> Accu D 
    std  interpZ1   ; Copy to "interpZ1"             
	ldd  DdBndZ1    ;((Injector deadband at 13.2V) - (Injector deadband voltage 
	                ; correction * 6)) -> Accu D 
    std  interpZ2   ; Copy to "interpZ2"             
    jsr  INTERP     ; Jump to Interpolation subroutine
    ldd  interpZ    ; Result "interpZ" -> Accu D
    ldx  #$000A     ; Decimal 10-> Accu X
    idiv            ; (D)/(X)->Xrem->D ("interpZ"/10="Deadband")(mSec*10)
    stx  Deadband   ; Copy result to "Deadband"(mSec*10)
    rts             ; Return from DEADBAND_CALCS subroutine
    
;*****************************************************************************************

;*****************************************************************************************
; -------------------------- After Start Enrichment (ASEcor)------------------------------
;
; Immediately after the engine has started it is normal to need additional fuel for a  
; short period of time. "ASEcor"specifies how much fuel is added as a percentage. It is   
; interpolated from the After Start Enrichment table which plots engine temperature in 
; degrees F to 0.1 degree resoluion against percent to 0.1 percent resolution and is added 
; to "WUEcor" as part of the calculations to determine pulse width when the engine is 
; running.
;  
;*****************************************************************************************

ASE_COR_LU:   ; Subroutine

;*****************************************************************************************
; - Look up current value in Afterstart Enrichment Percentage Table (ASEcor)   
;*****************************************************************************************

;*****************************************************************************************
; First check to see if CLTx10 is negative
;*****************************************************************************************

    ldx  Cltx10          ; Engine Coolant Temperature (Degrees F x 10) -> X    
    andx #$8000          ; Logical AND X with %1000 0000 0000 0000 (CCR N bit set of MSB of 
                         ; of MSB of result is set)
    bmi  ASEstartTempNeg ; If N bit of CCR is set, branch to ASEstartTempNeg:
    bra  ASEstartTempPos ; Branch to ASEstartTempPos:
    
;*****************************************************************************************
; CLTx10 is negative. Prepare to interpolate from the first boundaries
;*****************************************************************************************

ASEstartTempNeg:
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0290,Y     ; Load Accu X with value in RAM page 1 (offset 656)($0290) 
                      ; ("tempTable2" first address)(Low temperature)
    stx  interpV1     ; Copy to "interpV1"
    ldx  Cltx10       ; "CltX10" -> Accu X
    stx  interpV      ; Copy to "interpV"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0292,Y     ; Load Accu X with value in RAM page 1 (offset 658)($0292) 
                      ; ("tempTable2" second address)(High temperature)
    stx  interpV2     ; Copy to "interpV2"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $02F0,Y     ; Load Accu X with value in RAM page 1 (offset 752)($02F0) 
                      ; ("asePctTable" first address)(Low %)
    stx  interpZ1     ; Copy to "interpZ1"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $02F2,Y     ; Load Accu X with value in RAM page 1 (offset 754)($02F2) 
                      ; ("asePctTable" second address)(High %)
    stx  interpZ2     ; Copy to "interpZ2"

;*****************************************************************************************
; Check if we should rail low
;*****************************************************************************************
    
    ldx  Cltx10         ; "Cltx10" -> Accu X
    cpx  interpV1       ; Compare Cltx10 with Low temperature
    bls  RailLoASEstart ; If "Cltx10" is the same or less than Low temperature branch to 
                        ; RailLoASEstart:
    
;*****************************************************************************************
; Check if we should rail high
;*****************************************************************************************

    cpx  interpV2       ; Compare Cltx10 with High temperature
    bhs  RailHiASEstart ; If "Cltx10" is the same or higher than High temperature, branch 
                        ; to RailHiASEstart:
    bra  InterpASEstart ; Branch to InterpASEstart: (No rail so do the interpolation from
                        ; first set of boundaries 

RailLoASEstart:
    movw interpZ1,ASEstart ; Move Low % to "ASEstart"  
    bra  ASEstartDone      ; Branch to ASEstartDone: 
    
RailHiASEstart:
    movw interpZ2,ASEstart ; Move High % to "ASEstart"
    bra  ASEstartDone      ; Branch to ASEstartDone:
    
;*****************************************************************************************
; No rail so do the negative interpolation from the first set of boundaries
;*****************************************************************************************
    
InterpASEstart:
    jsr  INTERP           ; Jump to INTERP subroutine 
    movw interpZ,ASEstart ; Result -> "ASEstart" 
	bra  ASEstartDone     ; Branch to ASEstartDone:
	  
;*****************************************************************************************
; CLTx10 is positive. Prepare to interpolate from the rest of the boundaries
;*****************************************************************************************
 
ASEstartTempPos:
    movw #veBins_R,CrvPgPtr ; Address of the first value in VE table(in RAM)(page pointer) 
                            ; ->page where the desired curve resides 
    movw #$0148,CrvRowOfst  ; 328 -> Offset from the curve page to the curve row
	                        ; (tempTable2)(actual offset is 656)
    movw #$0178,CrvColOfst  ; 376 -> Offset from the curve page to the curve column
	                        ; (asePctTable)(actual offset is 752)
    movw Cltx10,CrvCmpVal   ; Engine Coolant Temperature (Degrees F x 10) -> 
                            ; Curve comparison value
    movb #$09,CrvBinCnt     ; 9 -> number of bins in the curve row or column minus 1
    jsr   CRV_LU_NP         ; Jump to subroutine at CRV_LU_NP: 
    movw interpZ,ASEstart   ; Copy result to  Afterstart Enrichmnet Correction (% x 10)
    
ASEstartDone:
    rts                     ; Return from ASE_COR_LU subroutine
    
;*****************************************************************************************

;*****************************************************************************************
; ----------------------- After Start Enrichment Taper (ASErev)---------------------------
;
; After Start Enrichment is applied for a specified number of engine revolutions after 
; start up. This number is interpolated from the After Start Enrichment Taper table which 
; plots engine temperature in degrees F to 0.1 degree resoluion against revolutions. 
; The ASE starts with the value of "ASEcor" first and is linearly interpolated down to 
; zero after "ASErev" crankshaft revolutions.
;
;*****************************************************************************************

ASE_TAPER_LU:   ; Subroutine

;*****************************************************************************************
; - Look up current value in Afterstart Enrichment Taper Table (ASErev)   
;*****************************************************************************************

;*****************************************************************************************
; First check to see if CLTx10 is negative
;*****************************************************************************************

    ldx  Cltx10        ; Engine Coolant Temperature (Degrees F x 10) -> X    
    andx #$8000        ; Logical AND X with %1000 0000 0000 0000 (CCR N bit set of MSB of 
                       ; of MSB of result is set)
    bmi  ASErevTempNeg ; If N bit of CCR is set, branch to ASErevTempNeg:
    bra  ASErevTempPos ; Branch to ASErevTempPos:
    
;*****************************************************************************************
; CLTx10 is negative. Prepare to interpolate from the first boundaries
;*****************************************************************************************

ASErevTempNeg:
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0290,Y     ; Load Accu X with value in RAM page 1 (offset 656)($0290) 
                      ; ("tempTable2" first address)(Low temperature)
    stx  interpV1     ; Copy to "interpV1"
    ldx  Cltx10       ; "CltX10" -> Accu X
    stx  interpV      ; Copy to "interpV"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0292,Y     ; Load Accu X with value in RAM page 1 (offset 658)($0292) 
                      ; ("tempTable2" second address)(High temperature)
    stx  interpV2     ; Copy to "interpV2"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0304,Y     ; Load Accu X with value in RAM page 1 (offset 772)($0304) 
                      ; ("aseRevTable" first address)(Low revolutions)
    stx  interpZ1     ; Copy to "interpZ1"
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (vebins)
    ldx   $0306,Y     ; Load Accu X with value in RAM page 1 (offset 774)($0306) 
                      ; ("aseRevTable" second address)(High revolutions)
    stx  interpZ2     ; Copy to "interpZ2"

;*****************************************************************************************
; Check if we should rail low
;*****************************************************************************************
    
    ldx  Cltx10         ; "Cltx10" -> Accu X
    cpx  interpV1       ; Compare Cltx10 with Low temperature
    bls  RailLoASErev   ; If "Cltx10" is the same or less than Low temperature branch to 
                        ; RailLoASErev:
    
;*****************************************************************************************
; Check if we should rail high
;*****************************************************************************************

    cpx  interpV2       ; Compare Cltx10 with High temperature
    bhs  RailHiASErev   ; If "Cltx10" is the same or higher than High temperature, branch 
                        ; to RailHiASErev:
    bra  InterpASErev   ; Branch to InterpASErev: (No rail so do the interpolation from
                        ; first set of boundaries 

RailLoASErev:
    movw interpZ1,ASErev ; Move Low revolutions to "ASErev"  
    bra  ASErevDone      ; Branch to ASErevDone: 
    
RailHiASErev:
    movw interpZ2,ASErev ; Move High revolutions to "ASErev"
    bra  ASErevDone      ; Branch to ASErevDone:
    
;*****************************************************************************************
; No rail so do the negative interpolation from the first set of boundaries
;*****************************************************************************************
    
InterpASErev:
    jsr  INTERP         ; Jump to INTERP subroutine 
    movw interpZ,ASErev ; Result -> "ASErev" 
	bra  ASErevDone     ; Branch to ASErevDone:
	  
;*****************************************************************************************
; CLTx10 is positive. Prepare to interpolate from the rest of the boundaries
;*****************************************************************************************
 
ASErevTempPos:
    movw #veBins_R,CrvPgPtr ; Address of the first value in VE table(in RAM)(page pointer) 
                            ; ->page where the desired curve resides 
    movw #$0148,CrvRowOfst  ; 328 -> Offset from the curve page to the curve row
	                        ; (tempTable2)(actual offset is 656)
    movw #$0182,CrvColOfst  ; 386 -> Offset from the curve page to the curve column
	                        ; (aseRevTable)(actual offset is 772)
    movw Cltx10,CrvCmpVal   ; Engine Coolant Temperature (Degrees F x 10) -> 
                            ; Curve comparison value
    movb #$09,CrvBinCnt     ; 9 -> number of bins in the curve row or column minus 1
    jsr   CRV_LU_NP         ; Jump to subroutine at CRV_LU_NP: 
    movw  interpZ,ASErev    ; Copy result to Afterstart Enrichment Taper (revolutions)
    
ASErevDone:
		rts                 ; Return from ASE_TAPER_LU subroutine
    
;*****************************************************************************************
    									   
;*****************************************************************************************
;                                TIME RATE SUBROUTINES
;*****************************************************************************************
    
;*****************************************************************************************
; - Every mS:
;   Check for vehicle stopped condition
;   Decrement "AIOTcnt" (AIOT pulse width counter)
;   Decrement "Stallcnt" (stall counter) 
;   Check for no crank or stall condition.
;***************************************************************************************** 
	
MILLISEC_ROUTINES:   ;Subroutine

;*****************************************************************************************
;   Check for vehicle stopped condition. VSScnt is set to 330 on the first VSS signal 
;   interrupt.			
;*****************************************************************************************

   ldd  VSScnt          ; "VSScnt" -> Accu D
   beq  VehStop         ; If zero branch to VehStop:     
   decw VSScnt          ; Decrement "VSScnt" (Vehicle stopped condition counter)
   bra  VehMove         ; Branch to VehMove: ( Vehicle is moving so fall through )
   
VehStop:
   clrw VSSprd512       ; Clear "VSSprd512"
   clrw VSS1st          ; Clear "VSS1st"
   clrw KPH             ; Clear "KPH"

VehMove:                

;**********************************************************************************************
; - Accumulated Injector On Time is used to estimate the litres of fuel used since last fill up.
;   It uses the Omron H7EC pulse counter which is powered by its own Y92S-36 (Panasonic CR2477)
;   3 volt battery and has an open collector output. "AIOTcnt" is a 16 bit variable that keeps 
;   a running total of the pulse widths in mS x 10 every time an injector pair is fired. When the 
;   total rolls over it pulses the counter. The initial setting for the injector pair flow
;   rate is 574 CC/Min. Fuel tank capacity is 132 litres.
;   (574CC per Min)/1000=(.574L per Min)/60=.009566666667 L per Sec
;   .009566666667 L per Sec*6.5535 Sec=.06269515L per count
;   (132L tank capacity)/(.06269515L per count)=(2105.426018 counts per tank full)
;   To convert from AIOT display counts to litres of fuel burned multiply the display number by 
;   0.06269515 
;
;   2105*80%=1684. 1684*0.06269515=105.57L burned. RE-FUEL AT OR BEFORE 1684 AIOT READING!!
;
;   Accuracy will depend on the accuracy of the injector deadband, pair flow rate, the number 
;   of times the engine is shut of between fuel fill ups and if the tank is filled to the same 
;   level at every fill up. The number of time the engine is shut off between fill ups is a 
;   factor becasue on shut down the "FDcnt" value is lost and not included in the running total
;   used to trigger the AIOT counter.  
;**********************************************************************************************
; - Check the value of the AIOT pulse width counter, if other than zero, decrement it.
;   When it reaches zero, shut the AIOT trigger off(open collector output)
;**********************************************************************************************

    ldaa    AIOTcnt         ; "AIOTcnt"->Accu A
    beq     AIOT_CHK_DONE   ; If "Z" bit of "CCR is set, branch to AIOT_CHK_DONE:
    dec     AIOTcnt         ; Decrement "AIOTcnt"
    ldaa    AIOTcnt         ; load accumulator with value in "AIOTcnt"
    beq     AIOT_OFF        ; If "Z" bit of "CCR is set, branch to AIOT_OFF:
    bra     AIOT_CHK_DONE   ; Branch to AIOT_CHK_DONE:

AIOT_OFF:
    bclr PORTB,AIOT         ; Clear "AIOT" pin on Port B (PB6)(end totalizer pulse)

AIOT_CHK_DONE:

;*****************************************************************************************
;   Decrement "Stallcnt" (no crank or stall condition counter)(1mS increments)			
;*****************************************************************************************

   ldd Stallcnt        ; "Stallcnt" -> Accu D
   beq  NoStallcntDec  ; If zero branch to NoStallcntDec:     
   decw Stallcnt       ; Decrement "Stallcnt" (no crank or stall condition counter)
                       
NoStallcntDec:

;*****************************************************************************************
;   Check for no crank or stall condition. 
;*****************************************************************************************

   beq  DoStall  ; If "Stallcnt" has decremented to zero branch to DoStall:
   jmp  NoStall  ; Jump to NoStall: (counter is not zero so fall through)
   
;*****************************************************************************************
;   Engine either hasn't begun to crank yet or has stalled
;*****************************************************************************************

DoStall:

;*****************************************************************************************
; - If the engine was cranking and stopped, make sure no coils are left energised. 
;*****************************************************************************************
   brset engine,crank,CoilsOff  ; If "crank" bit of "engine "bit field is set, branch to 
                                ; CoilsOff:
   bra NoCoilsOff               ; Branch to NoCoilsOff: (Engine was not cranking so fall through)

CoilsOff:
   bclr PTT,#$08                ; De-energise Port T bit3 Ign1 (1&6)
   bclr PTT,#$10                ; De-energise Port T bit4 Ign2 (10&5)
   bclr PTT,#$20                ; De-energise Port T bit5 Ign3 (9&8)
   bclr PTT,#$40                ; De-energise Port T bit6 Ign4 (7&4)
   bclr PTT,#$80                ; De-energise Port T bit7 Ign5 (2&3)

NoCoilsOff:   
   bclr  PORTB,#$01  ; Clear "FuelPump" bit0 on Port B (pump off)
   bclr  PORTB,#$02  ; Clear "ASDRelay" bit1 on Port B (relay off)
   bset  PORTB,#$20  ; Set Port B bit5 (Crank Synch Indicator State)(indicator on, crank not synched)
   clrw RPM          ; Clear "RPM" (engine RPM)
   clr  State        ; Clear "State" (Cam-Crank state machine current state )
   clr  engine       ; Clear all flags in "engine" bit field
   clr  engine2      ; Clear all flags in "engine2" bit field
   clr  ICflgs       ; Clear all flags in "ICflgs" bit field
   clr  StateStatus  ; Clear "StateStatus" bit field
   clrw CAS1sttk     ; Clear CAS input capture rising edge 1st time stamp
   clrw CAS2ndtk     ; Clear CAS input capture rising edge 2nd time stamp 
   clrw CASprd1tk    ; Clear Period between CAS1st and CAS2nd 
   clrw CASprd2tk    ; Clear Period between CAS2nd and CAS3d 
   clrw CASprd512    ; Clear Crankshaft Angle Sensor period (5.12uS time base
   clrw Degx10tk512  ; Clear Time to rotate crankshaft 1 degree (5.12uS x 10)
   clrw ASEcnt       ; Counter for "ASErev"
   clr  TOEdurCnt    ; Throttle Opening Enrichment duration counter

;*****************************************************************************************
; - Set up the "engine" bit field in preparation for cranking.
;*****************************************************************************************

   bset engine,crank   ; Set the "crank" bit of "engine" bit field
   bclr engine,run     ; Clear the "run" bit of "engine" bit field
   bset engine,WUEon   ; Set "WUEon" bit of "engine" bit field
   bset engine,ASEon   ; Set "ASEon" bit of "engine" bit field
   
;*****************************************************************************************
; - Load stall counter with compare value. Stall check is done in the main loop every 
;   mSec. "Stallcnt" is decremented every mSec and reloaded at every crank signal.
;*****************************************************************************************
								 
    ldy   #veBins_R     ; Load index register Y with address of first configurable 
                        ; constant in RAM page 1 (vebins)
    ldd   $0352,Y       ; Load Accu A with value in RAM page 1 offset 850 
                        ; "Stallcnt" (stall counter)(offset = 850) 
    std  Stallcnt       ; Copy to "Stallcnt" (no crank or stall condition counter)
                        ; (1mS increments)
                        
;*****************************************************************************************
; - Initialize other variables -
;*****************************************************************************************

    movb  #$09,RevCntr          ; Counter for Revolution Counter signals
    bset  StateStatus,SynchLost ; Set "SynchLost" bit of "StateStatus" variable (bit1)

;*****************************************************************************************
; - Load "MinCKP" with the number of CKP triggers required before RPM period calculations 
;   are commenced. This is done to prevent timer overflow when periods are long during 
;   initial cranking. During cranking ignition dwell and spark are scheduled at specific 
;   crank trigger points after synch has been established.
;*****************************************************************************************
								 
    ldy   #veBins_R     ; Load index register Y with address of first configurable 
                        ; constant on buffer RAM page 1 (vebins)
    ldd   $0363,Y       ; Load Accu A with value in buffer RAM page 1 offset 867 
                        ; "MinCKP_F" (Minimum CKP triggers))(offset = 867)(0363) 
    std   MinCKP        ; Copy to "MinCKP" (Starting value to count down)	
    
;*****************************************************************************************
; - Look up current value in Afterstart Enrichment Percentage Table (ASEcor)   
;*****************************************************************************************  

    jsr  ASE_COR_LU   ; Jump to ASE_COR_LU subroutine

;*****************************************************************************************
; - Look up current value in Afterstart Enrichment Taper Table (ASErev)   
;*****************************************************************************************

    jsr  ASE_TAPER_LU   ; Jump to ASE_TAPER_LU subroutine
    
    movw ASErev,ASEcnt  ; Copy "ASErev" to "ASEcnt" (initial counter value)
    
NoStall:
    rts                 ; Return from MILLISEC_ROUTINES subroutine
    
;*****************************************************************************************

MILLISEC20_ROUTINES:   ;Subroutine

;*****************************************************************************************
; Every 20 mS see if an IAC change has been requested. If it has, enable the motor driver 
; chip, choose the appropriate direction control input state and toggle the step control 
; input state. This will result in a 20mS on time and a 20mS off time which will continue 
; as long as the directional switch is held closed
;*****************************************************************************************

    brclr PORTA,IdleSpdRaise,IdleUp  ; Idle speed raise commanded (active low)
	brclr PORTA,IdleSpdLower,IdleDn  ; Idle speed lower commanded (active low)
	bra   NoIdleChng                 ; No idle speed change commanded
	
IdleUp:
    bclr PORTK,A4988En  ; Enable the motor driver chip (active low)
;    bset PORTK,A4988En  ; For testing on old board, Outputs are inverted
 	bset PORTK,A4988Dir ; Direction CW
;    bclr PORTK,A4988Dir  ; For testing on old board, Outputs are inverted
    ldaa PORTK          ; Load ACC A with value in Port K
    eora #$04           ; Exclusive or with bit2                                              
    staa PORTK          ; Copy resultto Port K (toggle Bit0, A4988Step) (active high)
	bra  IdleChng       ; Idle change in progress
	
IdleDn:
    bclr PORTK,A4988En  ; Enable the motor driver chip (active low)
;    bset PORTK,A4988En  ; For testing on old board, Outputs are inverted
	   bclr PORTK,A4988Dir ; Direction CCW
;    bset PORTK,A4988Dir  ; For testing on old board, Outputs are inverted
    ldaa PORTK          ; Load ACC A with value in Port K
    eora #$04           ; Exclusive or with bit2                                              
    staa PORTK          ; Copy result to Port K (toggle Bit0, A4988Step) (active high)
	bra  IdleChng       ; Idle change in progress
	
NoIdleChng:
    bset PORTK,A4988En   ; Disable the motor driver chip (active low)
;    bclr PORTK,A4988En  ; For testing on old board, Outputs are inverted
    bclr PORTK,A4988Step ; Stepper control off (active high)
;    bset PORTK,A4988Step  ; For testing on old board, Outputs are inverted
	bclr PORTK,A4988Dir  ; Direction CCW (no particular reason)
;    bset PORTK,A4988Dir  ; For testing on old board, Outputs are inverted

IdleChng:
    rts                  ; Return from MILLISEC20_ROUTINES subroutine:
    
;*****************************************************************************************
    	
MILLISEC100_ROUTINES:   ;Subroutine

;   No routines here
    rts                             ; Return from MILLISEC100_ROUTINES subroutine
    
;*****************************************************************************************

               
MILLISEC1000_ROUTINES:   ; Subroutine

;*****************************************************************************************
; - Save the current value of "LoopCntr" as "LoopTime" (loops per second) 
;*****************************************************************************************

	ldd  LoopCntr      ; "LoopCntr" (counter for "LoopTime") ->Accu D
    std  LoopTime      ; Copy to "LoopTime" (Program loop time (loops/Sec)
    clrw LoopCntr      ; Clear "LoopCntr" (incremented every Main Loop pass)
	
;*****************************************************************************************
; - Save the current fuel delivery total ("FDt") as "FDsec" so it can be used by Tuner 
;   Studio and Shadow Dash for fuel burn calculations
;   NOTE! moved to second section of RTI interrupts 7/02/22
;*****************************************************************************************

;    ldd   FDt     ; "FDt"->Accu D (fuel delivery pulse width time total)(mS x 10)
;  	std   FDsec   ; Copy to "FDsec" (fuel delivery pulse width time total per second)
;  	clrw  FDt     ; Clear "FDt" (fuel delivery pulse width time total)(mS x 10)
    rts           ; Return from MILLISEC1000_ROUTINES subroutine
    
;*****************************************************************************************
;*****************************************************************************************
;* - NOTE! I CAN'T GET MY BURNER CODE TO WORK WITH TUNER STUDIO SO I'M COMMENTING IT OUT
;***************************************************************************************** 

;EraseBurn:   ; Subroutine

;*****************************************************************************************
; - Erase 1024 byte Flash sectors starting at $7000, $7400, and $7800. Then burn all 
;   configurable constants in RAM from $2400 to $3000 to Flash from $7000 to $7C00.
;*****************************************************************************************
;*****************************************************************************************
; - Erase Flash 1024 byte sector starting at address $7000 (global address $7F7000)
;*****************************************************************************************

;CheckFCLKDIV1:
;    ldaa FCLKDIV        ; Flash Clock Divider Register -> Accu A
;	bita $80            ; Check the status of Clock Divider Loaded flag bit7
;	beq  CheckFCLKDIV1  ; If FDIVLD is clear we can't procede so loop back 	
	
;CheckCCIF1:
;	ldaa FSTAT          ; Flash Status Register -> Accu A
;	bita $80            ; Check the status of Command Complete Interrupt flag bit7
;	bne  CheckCCIF1     ; If CCIF is not clear Flash Common Command Register is not 
	                    ; available and we can't procede so loop back
;	movb #$30,FSTAT     ; %00110000 - Flash Status Register. Clear Flash Access Error Flag 
	                    ; bit5 and Flash Protection Violation Flag bit4 by writing to their
					    ; respective bits
;    movb #$00,FCCOBIX   ; %00000000 ->  Flash CCOB Index Register (Command mode 0)
;    movb #$0A,FCCOBHI   ; %00001001 -> Flash Common Command Register Hi byte
                        ; (Erase P-Flash sector)
;    movb #$7F,FCCOBLO   ; Global address adder
;    movb #$01,FCCOBIX   ; %00000001 ->  Flash CCOB Index Register (Command mode 1)
;    movw #$7000,FCCOBHI ; $7000 -> Flash Common Command Register Hi:low 
                        ; (Logical address $7000)
;    jsr  Send_Command   ; Jump to subroutine in RAM
   
;*****************************************************************************************
; - Erase Flash 1024 byte sector starting at address $7400 (gloabal address $7F7400)
;*****************************************************************************************

;CheckFCLKDIV2:
;    ldaa FCLKDIV        ; Flash Clock Divider Register -> Accu A
;	bita $80            ; Check the status of Clock Divider Loaded flag bit7
;	beq  CheckFCLKDIV2  ; If FDIVLD is clear we can't procede so loop back 	
	
;CheckCCIF2:
;	ldaa FSTAT          ; Flash Status Register -> Accu A
;	bita $80            ; Check the status of Command Complete Interrupt flag bit7
;	bne  CheckCCIF2     ; If CCIF is not clear Flash Common Command Register is not 
	                    ; available and we can't procede so loop back
;	movb #$30,FSTAT     ; %00110000 - Flash Status Register. Clear Flash Access Error Flag 
	                    ; bit5 and Flash Protection Violation Flag bit4 by writing to their
					    ; respective bits
;    movb #$00,FCCOBIX   ; %00000000 ->  Flash CCOB Index Register (Command mode 0)
;    movb #$0A,FCCOBHI   ; %00001001 -> Flash Common Command Register Hi byte
                        ; (Erase P-Flash sector)
;    movb #$7F,FCCOBLO   ; Global address adder
;    movb #$01,FCCOBIX   ; %00000001 ->  Flash CCOB Index Register (Command mode 1)
;    movw #$7400,FCCOBHI ; $7400 -> Flash Common Command Register Hi:low 
                        ; (Logical address $7400)
;    jsr  Send_Command   ; Jump to subroutine in RAM

;*****************************************************************************************
; - Erase Flash 1024 byte sector starting at address $7800 (global address $7F7800)
;*****************************************************************************************

;CheckFCLKDIV3:
;    ldaa FCLKDIV        ; Flash Clock Divider Register -> Accu A
;	bita $80            ; Check the status of Clock Divider Loaded flag bit7
;	beq  CheckFCLKDIV3  ; If FDIVLD is clear we can't procede so loop back 	
	
;CheckCCIF3:
;	ldaa FSTAT          ; Flash Status Register -> Accu A
;	bita $80            ; Check the status of Command Complete Interrupt flag bit7
;	bne  CheckCCIF3     ; If CCIF is not clear Flash Common Command Register is not 
	                    ; available and we can't procede so loop back
;	movb #$30,FSTAT     ; %00110000 - Flash Status Register. Clear Flash Access Error Flag 
	                    ; bit5 and Flash Protection Violation Flag bit4 by writing to their
					    ; respective bits
;    movb #$00,FCCOBIX   ; %00000000 ->  Flash CCOB Index Register (Command mode 0)
;    movb #$0A,FCCOBHI   ; %00001001 -> Flash Common Command Register Hi byte
                        ; (Erase P-Flash sector)
;    movb #$7F,FCCOBLO   ; Global address adder
;    movb #$01,FCCOBIX   ; %00000001 ->  Flash CCOB Index Register (Command mode 1)
;    movw #$7800,FCCOBHI ; $7800 -> Flash Common Command Register Hi:low 
                        ; (Logical address $7800)
;    jsr  Send_Command   ; Jump to subroutine in RAM
  
;*****************************************************************************************

;*****************************************************************************************
; - Burn all configurable constanst in RAM starting at address $2400 ending
;   at address $2FFF to Flash starting at address $7000 ending at address $2FFF. Total  
;   of 3072 bytes. (start global address $7F7000) 
;*****************************************************************************************

;	clrw  BurnCnt       ; Clear BurnCnt (bytes burned counter)		  
	
;CheckFCLKDIV4:
;    ldaa FCLKDIV        ; Flash Clock Divider Register -> Accu A
;	bita $80            ; Check the status of Clock Divider Loaded flag bit7
;	beq  CheckFCLKDIV4  ; If FDIVLD is clear we can't procede so loop back
	 	
;CheckCCIF4:
;    ldaa FSTAT          ; Flash Status Register -> Accu A
; 	bita $80            ; Check the status of Command Complete Interrupt flag bit7
; 	bne  CheckCCIF4     ; If CCIF is not clear Flash Common Command Register is not 
	                    ; available and we can't procede so loop back
;	movb #$30,FSTAT     ; %00110000 - Flash Status Register. Clear Flash Access Error Flag 
	                    ; bit5 and Flash Protection Violation Flag bit4 by writing to their
					    ; respective bits
;    movb #$00,FCCOBIX   ; %00000000 ->  Flash CCOB Index Register (Command mode 0)
;    movb #$06,FCCOBHI   ; %00000110 -> Flash Common Command Register Hi byte
                        ; (Program P-Flash)
;	movb #$7F,FCCOBLO   ; Global address adder
;	ldd  BurnCnt        ; BurnCnt -> Accu D
;	ldy  #$7000         ; Address of the first configurable constant in Flash
;	ldx  D,Y            ; Load Accu X with the contents of Y offset in D
;	leay D,Y            ; Effective address-> Accu Y
;    movb #$01,FCCOBIX   ; %00000001 ->  Flash CCOB Index Register (address to be programmed)
;    sty  FCCOBHI        ; Effective address -> Flash Common Command Register Hi byte
;    movb #$02,FCCOBIX   ; %00000010 ->  Flash CCOB Index Register (word 0 to program)
;    ldd  BurnCnt        ; BurnCnt -> Accu D 
;	ldy  #$2400         ; Address of the first configurable constant in RAM
;  	ldx  D,Y            ; Load Accu D with the contents of Y offset in X
;    stx  FCCOBHI        ; Word 0 program value -> Flash Common Command Register Hi:Low
;    movb #$03,FCCOBIX   ; %00000011 ->  Flash CCOB Index Register (word 1 to program)
;    incw BurnCnt        ; Increment bytes burnt counter
;    incw BurnCnt        ; Increment bytes burnt counter
;	ldd  BurnCnt        ; BurnCnt -> Accu D	
;	ldy  #$2400         ; Address of the next configurable constant in RAM
;	ldx  D,Y            ; Load Accu X with the contents of Y offset in D
;    stx  FCCOBHI        ; Word 1 program value -> Flash Common Command Register Hi:Low
;    movb #$04,FCCOBIX   ; %00000100 ->  Flash CCOB Index Register (word 2 to program)
;    incw BurnCnt        ; Increment bytes burnt counter
;    incw BurnCnt        ; Increment bytes burnt counter
;	ldd  BurnCnt        ; BurnCnt -> Accu D	
;	ldy  #$2400         ; Address of the first configurable constant in RAM
;	ldx  D,Y            ; Load Accu X with the contents of Y offset in D
;    stx  FCCOBHI        ; Word 2 program value -> Flash Common Command Register Hi:Low
;    movb #$05,FCCOBIX   ; %00000101 ->  Flash CCOB Index Register (word 3 to program)
;    incw BurnCnt        ; Increment bytes burnt counter
;    incw BurnCnt        ; Increment bytes burnt counter
;	ldd  BurnCnt        ; BurnCnt -> Accu D	
;	ldy  #$2400         ; Address of the first configurable constant in RAM
;	ldx  D,Y            ; Load Accu X with the contents of Y offset in D
;    stx  FCCOBHI        ; Word 3 program value -> Flash Common Command Register Hi:Lo
;    incw BurnCnt        ; Increment bytes burnt counter
;    incw BurnCnt        ; Increment bytes burnt counter
;	jsr  Send_Command   ; Jump to subroutine in RAM
;	ldx  BurnCnt        ; BurnCnt -> Accu X
;	cpx  #$0C00         ; Compare BurnCnt with decimal 3072
;    bne  CheckFCLKDIV4a ; If not equal loop back to CheckFCLKDIV4a
;    bra  CheckCCIF4b    ; Branch to CheckCCIF4b 
    
;CheckFCLKDIV4a:
;    jmp  CheckFCLKDIV4  ; Long branch

;CheckCCIF4b:
;    clrw BurnCnt        ; Clear "BurnCnt for future erase and burn command
;    bclr engine2,ErsBrn ; Clear the "ErsBrn" flag for future erase and burn command  
;    rts                 ; Return from EraseBurn subroutine  

;*****************************************************************************************
	
     
;*****************************************************************************************
;                            INTERRUPT SERVICE ROUTINES
;*****************************************************************************************
; - Interrupt Service Routines subsection
;   - RTI time rate ISRs
;       - mS section
;       - mS100 section
;       - mS 250 section
;       - mS 500 section
;       - mS1000 section
;
;   - SCI0 RS232 ISRs
;
;   - ECT ISRs
;       - ECT ch0 camshaft sensor
;       - ECT ch1 crankshaft sensor
;       - ECT ch2 vehicle speed sensor
;       - ECT ch3 ignition 1
;       - ECT ch4 ignition 2
;       - ECT ch5 ignition 3
;       - ECT ch6 ignition 4
;       - ECT ch7 ignition 5
;
;   - TIM ISRs
;       - TIM ch0 injection 1
;       - TIM ch1 injection 2
;       - TIM ch2 injection 3
;       - TIM ch3 injection 4
;       - TIM ch4 injection 5
;
;*****************************************************************************************

        XDEF    RTI_ISR ; - RTI Interrupt Service Routine (1mS clock tick)
        
RTI_ISR:

    movb #$80,CRGFLG     ; Clear Real Time Interrupt Flag bit7 
 
;*****************************************************************************************
; - RTI Interrupt Service Routine (1mS clock tick)
; - Generate time rates:
;   1 Millisecond
;   20 Milliseconds
;   100 Milliseconds
;   500 Milliseconds
;   Seconds
;*****************************************************************************************

;*****************************************************************************************
; --------------------------------- Millisecond section ----------------------------------
;*****************************************************************************************

DomS:
    bset clock,ms1     ; Set "ms1" bit of "clock"

;*****************************************************************************************
; - Increment millisecond counter and check to see if it's time to do the 20 or 100 
;   Millisecond section.
;*****************************************************************************************

    inc  mS            ; Increment Millisecond counter
    ldaa mS            ; Load accu A with value in mS counter
    cmpa #$14          ; Compare it with decimal 20
    beq  Do20mS        ; IF Z bit of CCR is set, branch to Do20mS: (mS=20)
    cmpa #$28          ; Compare it with decimal 40
    beq  Do20mS        ; IF Z bit of CCR is set, branch to Do20mS: (mS=40)
    cmpa #$3C          ; Compare it with decimal 60
    beq  Do20mS        ; IF Z bit of CCR is set, branch to Do20mS: (mS=60)
    cmpa #$50          ; Compare it with decimal 80
    beq  Do20mS        ; IF Z bit of CCR is set, branch to Do20mS: (mS=80)
    cmpa #$64          ; Compare it with decimal 100
    beq  Do20mS        ; IF Z bit of CCR is set, branch to Do20mS: (mS=100)
    bra  RTI_ISR_DONE  ; Branch to RTI_ISR_DONE:
    
;*****************************************************************************************
; ------------------------------- 20 Millisecond section --------------------------------
;*****************************************************************************************

Do20mS:
   bset clock,ms20    ; Set "ms20" bit of "clock" bit field
   ldaa mS            ; Load accu A with value in mS counter
   cmpa #$64          ; Compare it with decimal 100
   beq  Do100mS       ; IF Z bit of CCR is set, branch to Do100mS: (mS=100)
   bra  RTI_ISR_DONE  ; Branch to RTI_ISR_DONE:

;*****************************************************************************************
; ------------------------------- 100 Millisecond section --------------------------------
;*****************************************************************************************

Do100mS:
   bset clock,ms100    ; Set "ms100" bit of "clock" bit field
   
;*****************************************************************************************
; - Decrement "TOEdurCnt" (Throttle Opening Enrichment duration counter)
;*****************************************************************************************

    ldaa TOEdurCnt    ; "TOEdurCnt" -> Accu A
    beq  NoTOEdurDec  ; If zero branch to NoTOEdurDec:     
    dec  TOEdurCnt    ; Decrement Throttle Opening Enrichment duration counter
    
NoTOEdurDec:

;*****************************************************************************************
; - Check if throttle is closed or steady state or closing
;*****************************************************************************************

    ldx  TpsPctx10     ; "TpsPctx10" -> Accu X
    beq  NoTOE         ; If zero branch to NoTOE: (Throttle is closed so no TOE 
    cpx  TpsPctx10last ; (X)-(M:M+1) Compare  "TpsPctx10" with "TpsPctx10last"
    bls  NoTOE         ; If "TpsPctx10" is equal to or less than "TpsPctx10last" 
                       ;  branch to NoTOE:(Throttle is steady or closing so no TOE
                       
;*****************************************************************************************
; - Throttle must be opening so calculate "TpsPctDOT" Throttle Position Percent Difference
;   Over Time (%/Sec)  
;*****************************************************************************************
                       
;**********************************************************************************************
; - Current Throttle position percent - throttle position percent 100mS ago = throttle position 
;   percent difference over time in seconds "TpsPctx10" - "TpsPctx10last" = "TpsPctDOT"
;**********************************************************************************************

    ldx   TpsPctx10       ;"TpsPctx10" -> Accu X 
    subx  TpsPctx10last   ; (X)-(M:M-1)=>X Subtract "TpsPctx10last" from "TpsPctx10"
    stx   TpsPctDOT       ; Copy result to "TpsPctDOT"
    bra   TpsPctDOTdone   ; Branch to TpsPctDOTdone:
    
NoTOE:
    clrw  TpsPctDOT       ; Clear "TpsPctDOT" 
   
TpsPctDOTdone:   
	
;*****************************************************************************************
;   Save current TPS percent reading "TpsPctx10" as "TpsPctx10last" 
;*****************************************************************************************

    movw  TpsPctx10,TpsPctx10last   ; Copy value in "TpsPctx10" to "TpsPctx10last"
                                    ;(current becomes last)

;*****************************************************************************************
; - Clear the millisecond counter. Increment 100 Millisecond counter  and check to see 
;   if it's time to do the "500 mS" section.
;*****************************************************************************************

    clr  mS            ; Clear Millisecond counter
    inc  mSx100        ; Increment 100 Millisecond counter
    ldaa mSx100        ; Load accu A with value in 100 mSec counter
    cmpa #$05          ; Compare with decimal 5
    beq  Do500mS       ; If the Z bit of CCR is set, branch to Do500mS:
    cmpa #$0A          ; Compare with decimal 10
    beq  Do500mS       ; If the Z bit of CCR is set, branch to Do500mS:
    bra  RTI_ISR_DONE  ; Branch to RTI_ISR_DONE:

;*****************************************************************************************
; ----------------------------- 500 Millisecond section ----------------------------------
;*****************************************************************************************

Do500mS:
    bset clock,ms500   ; Set "ms500" bit of "clock"

;*****************************************************************************************
; - Check to see if it's time to do the "Seconds" section
;*****************************************************************************************

    ldaa mSx100        ; Load accu A with value in 100 mSec counter
    cmpa #$0A          ; Compare with decimal 10
    beq  DoSec         ; If the Z bit of CCR is set, branch to DoSec:
    bra  RTI_ISR_DONE  ; Branch to RTI_ISR_DONE:

;*****************************************************************************************
; ---------------------------------- Seconds section -------------------------------------
;*****************************************************************************************

DoSec:
    bset clock,ms1000     ; Set "ms1000" bit of "clock"
    
;*****************************************************************************************
; - Save the current fuel delivery total ("FDt") as "FDsec" so it can be used by Tuner 
;   Studio and Shadow Dash for fuel burn calculations
;   NOTE! moved to second section of RTI interrupts 7/02/22
;*****************************************************************************************

    ldd   FDt     ; "FDt"->Accu D (fuel delivery pulse width time total)(mS x 10)
  	std   FDsec   ; Copy to "FDsec" (fuel delivery pulse width time total per second)
  	clrw  FDt     ; Clear "FDt" (fuel delivery pulse width time total)(mS x 10)
    
;*****************************************************************************************
; - Clear the 100 millisecond counter. Increment "secL". Increment "secH" on roll over
;*****************************************************************************************

IncSec:
    clr  mSx100        ; Clear 100 mSec counter
    inc  SecL          ; Increment "Seconds" Lo byte 
    bne  RTI_ISR_DONE  ; If the Z bit of CCR is clear, branch to RTI_ISR_DONE:
    inc  SecH          ; Increment "Seconds" Hi byte
    
 RTI_ISR_DONE:
    rti                ; Return from RTI interrupt
	
;*****************************************************************************************

        XDEF    SCI0_ISR  ; SCI0 Service Interrupt Routine
        
SCI0_ISR:   ; Subroutine
         
;*****************************************************************************************
; ------------------------------ SCI Communication ---------------------------------------
;*****************************************************************************************
;
; Communication is established when the Tuner Studio sends
; a command character. The particular character sets the mode:
;
; "Q" = This is the first command that Tuner Studio sends to request the
;       format of the data. It must receive the signature "MS2Extra comms342h2"
;       in order to communicate with both Tuner Studio and Shadow Dash. originally I 
;       used 'MShift 5.001' because the TS.ini file used with this code was 
;       built from the base Megashift .ini. (QueryCommand)(1st)
; "S" = This command requests the version information and TS displays it in the title 
;       block (2nd)
; "C" = This command requests the constants. (pageReadCommand)(3d)
;       It is sent after communication with TS has been established and 
;       loads TS with all the the constant pages in RAM. It is also sent 
;       when editing a particular page. 
; "O" = This command requests the real time variables (ochGetCommand)(4th)                  Try "A"
;       It is sent to update the real time variables at a selectable time rate
; "W" = This command sends an updated constant value from TS to the controller 
;       (pageValueWrite). It is sent when editing configurable constants
;       one at a time. If editing only one, it is sent after the change 
;       has been made and entered. If editing more than one it is sent 
;       when the next constant to be changed is selected. The number of 
;       bytes is either 1 for a byte value or 2 for a word value
; "B" = This command jumps to the flash burner routine (burnCommand)
;       It is sent either after pressing the "Burn" button or closing TS.
;
;
; The commands sent to the GPIO(Megashift)are formatted "command\CAN_ID\table_ID"
;    %2i is the id/table number - 2 bytes
;    %2o is the table offset - 2 bytes
;    %2c is the number of bytes to be read/written
;    %v is the byte to be written
;
; The Tuner Studio commands are:
; ASCII Q to get the signature ("MS2Extra comms342h2")
; ASCII S to get the current RevNum
; ASCII O to get all the real time variables
; ASCII C plus $00,$01,$00,$00,$04,$00 to get page 1 of the configurable constants stored in RAM
; ASCII C plus $00,$02,$00,$00,$04,$00 to get page 2 of the configurable constants stored in RAM
; ASCII C plus $00,$03,$00,$00,$04,$00 to get page 3 of the configurable constants stored in RAM
;
; The settings in the TS .ini file are:
;   queryCommand        = "Q"
;   signature           = "MS2Extra comms342h2" 
;   endianness          = big
;   nPages              = 3
;   pageSize            = 1024,            1024,            1024
;   pageIdentifier      = "\x01\x01",     "\x01\x02",     "\x01\x03"
;   burnCommand         = "B%2i",         "B%2i",         "B%2i"
;   pageReadCommand     = "C%2i%2o%2c",   "C%2i%2o%2c",   "C%2i%2o%2c"
;   pageValueWrite      = "W%2i%2o%2c%v", "W%2i%2o%2c%v", "W%2i%2o%2c%v"
;   pageChunkWrite      = "W%2i%2o%2c%v", "W%2i%2o%2c%v", "W%2i%2o%2c%v"
;   ochGetCommand       = "O"
;   ochBlockSize        = 139 ; This number will change as code expands
;   pageActivationDelay =  50 ; Milliseconds delay after burn command.
;   blockReadTimeout    = 200 ; Milliseconds total timeout for reading page.
;   writeBlocks         = on
;   interWriteDelay     = 10
;
; There are eight variables used in the communications code, "txgoalMSB", "txgoalLSB" 
; "txcnt", "rxoffsetMSB", "rxoffsetLSB, "rxmode", "txmode", "pageID", "txcmnd", "dataMSB"
; and "dataLSB".
;
; "txgoalMSB" is the number of bytes to be sent Hi byte(8 bit)
; "txgoalLSB" is the number of bytes to be sent Lo byte(8 bit)
; "rxoffsetMSB" is the offset from start of page to a particuar value Hi byte(8 bit)
; "rxoffsetLSB" is the offset from start of page to a particuar value Lo byte(8 bit)
; "txcnt" is the running count of the number of bytes sent (16 bit)
; "rxmode" is the current receive mode (8 bit)
; "txmode" is the current transmit mode (8 bit)
; "pageID" is the page identifier (8 bit)
; "txcmnd" is the command character ID (8 bit)
; "dataMSB" is the Most Significant byte value sent from TS when 
;           sending two bytes(8 bit)
; "dataLSB" is the Most Significant byte value sent from TS when 
;           sending two bytes or a single byte(8 bit)
; 
; 
;*****************************************************************************************
;*****************************************************************************************
; - SCI0 Interrupt Service Routine
;   The interrupts are common to both receive and transmit. First 
;   check the flags to determine which one initiated the interrupt
;   and branch accordingly. 
;*****************************************************************************************


    brset SCI0SR1,#$20,RcvSCI    ; If Receive Data Register Full flag bit5 is set, branch to 
                                 ; "RcvSCI:" (receive section)
    brset SCI0SR1,#$80,TxSCI_LB  ; If Transmit Data Register Empty flag bit7 is set, branch to 
                                 ; "TxSCI_trmp:" (transmit section)
    ldaa  SCI0SR1                ; Read SCI0CR1 to clear flags									  
    rti                          ; Return from SCI0_ISR interrupt (sanity check)
    
TxSCI_LB:
    jmp   TxSCI                  ; Jump or branch to TxSCI: (long branch)
                                      
;*****************************************************************************************
; - Receive section
;*****************************************************************************************

RcvSCI:
    ldaa  SCI0SR1  ; Load accu A with value in SCI0SR1(Read SCI0SR1 to clear "RDRF" flag)
                               
;*****************************************************************************************
; - Check the value of "rxmode" to see if we are in the middle of 
;   receiveing a CAN ID, Page ID, offset, byte count or value.
;          $01 = Receiving CAN ID
;          $02 = Receiving Page ID
;          $03 = Receiving offset msb
;          $04 = Receiving offset lsb
;          $05 = Receiving data count msb
;          $06 = Receiving data count lsb
;          $07 = Receiving data
;          $08 = Receiving data lsb 
;
;*****************************************************************************************

    ldaa    rxmode       ; Load accumulator with value in "rxmode" 
    cmpa    #$01         ; Compare with decimal 1 (receiving CAN ID )
    beq     RcvCanID     ; If the Z bit of CCR is set, branch to RcvCanID:
    cmpa    #$02         ; Compare with decimal 2 (receiving page ID )
    beq     RcvPageID    ; If the Z bit of CCR is set, branch to RcvPageID:
    cmpa    #$03         ; Compare with decimal 3 (receiving offset MSB )
    beq     RcvOSmsb     ; If the Z bit of CCR is set, branch to RcvOSmsb:
    cmpa    #$04         ; Compare with decimal 4 (receiving offset LSB )
    beq     RcvOSlsb     ; If the Z bit of CCR is set, branch to RcvOSlsb:
    cmpa    #$05         ; Compare with decimal 5 (receiving byte count MSB )
    beq     RcvCntmsb    ; If the Z bit of CCR is set, branch to RcvCntmsb:
    cmpa    #$06         ; Compare with decimal 6 (receiving byte count LSB )
    beq     RcvCntlsb    ; If the Z bit of CCR is set, branch to RcvCntlsb:
    cmpa    #$07         ; Compare with decimal 7 (receiving data byte )
    beq     RcvData      ; If the Z bit of CCR is set, branch to RcvData:
    cmpa    #$08         ; Compare with decimal 7 (receiving data byte )
    beq     RcvDataLSB   ; If the Z bit of CCR is set, branch to RcvDataLSB:

    jmp     CheckTxCmnd  ; jump to CheckTxCmnd: (rxmode must be 0 or invalid)
     
RcvCanID:                ; "rxmode" = 1
    ldaa  SCI0DRL        ; Load Accu A with value in "SCI0DRL"
                         ; (CAN ID) not used, so just read it and get 
                         ; ready for next byte
    inc   rxmode         ; Increment "rxmode"(continue to next mode)
    rti                  ; Return from SCI0_ISR interrupt
     
RcvPageID:               ; "rxmode" = 2
    ldaa  SCI0DRL        ; Load Accu A with value in "SCI0DRL"
    staa  pageID         ; Copy to "pageID"
    ldaa  txcmnd         ; Load Accu A with value in "txcmnd"
    cmpa  #$03           ; Compare with decimal 3 ("B")
    beq   ModeB2a        ; If the Z bit of CCR is set, branch to ModeB2:
    bra   NoModeB2
    
ModeB2a:
    jmp   ModeB2         ; Long branch
    
NoModeB2:
    inc   rxmode         ; Increment "rxmode"(continue to next mode)
    rti                  ; Return from SCI0_ISR interrupt
     
RcvOSmsb:                ; "rxmode" = 3
    ldaa  SCI0DRL        ; Load Accu A with value in "SCI0DRL" (Offset MSB)
    staa  rxoffsetMSB    ; Copy to "rxoffsetMSB"
    inc   rxmode         ; Increment "rxmode"(continue to next mode)
    rti                  ; Return from SCI0_ISR interrupt
     
RcvOSlsb:                ; "rxmode" = 4
    ldaa  SCI0DRL        ; Load Accu A with value in "SCI0DRL" (Offset LSB)
    staa  rxoffsetLSB    ; Copy to "rxoffsetLSB"
    inc   rxmode         ; Increment "rxmode"(continue to next mode)
    rti                  ; Return from SCI0_ISR interrupt
     
RcvCntmsb:               ; "rxmode" = 5
    ldaa  SCI0DRL        ; Load Accu A with value in "SCI0DRL" (Byte count MSB)
    staa  txgoalMSB      ; Copy to "txgoalMSB"
    inc   rxmode         ; Increment "rxmode"(continue to next mode)
    rti                  ; Return from SCI0_ISR interrupt
     
RcvCntlsb:               ; "rxmode" = 6
    ldaa  SCI0DRL        ; Load Accu A with value in "SCI0DRL" (Byte count LSB)
    staa  txgoalLSB      ; Copy to "txgoalLSB"
    ldaa  txcmnd         ; Load Accu A with value in "txcmnd"
    cmpa  #$01           ; Compare with decimal 1 ("C")
    beq   ModeC2a        ; If the Z bit of CCR is set, branch to ModeC2:
    bra   NoModeC2
    
ModeC2a:
    jmp   ModeC2         ; Long branch
    
NoModeC2:
    inc   rxmode         ; Increment "rxmode"(continue to next mode)
    rti                  ; Return from SCI0_ISR interrupt (ready to receive next byte)
     
RcvData:                 ; "rxmode" = 7

;*****************************************************************************************
; - If we are here we must be in "W" mode and receiving either one or 
;   two bytes, depending on the byte count.
;*****************************************************************************************
    ldd  txgoalMSB      ; Load double accumulator with value in 
                        ; "txgoalMSB:txgoalLSB"
    cpd  #$0002         ; Compare with decimal 2
    beq  RcvDataMSB     ; If equal branch to RcvDataMSB:
    cpd  #$0001         ; Compare with decimal 1
    beq  RcvDataLSB     ; If equal branch to RcvDataLSB:
     
RcvDataMSB:
    ldaa  SCI0DRL       ; Load Accu A with value in "SCI0DRL"(data byte)
    staa  dataMSB       ; Copy to "dataMSB"
    inc   rxmode        ; Increment "rxmode"(continue to next mode)
    rti                 ; Return from SCI0_ISR subroutine 

RcvDataLSB:             ; "rxmode" = 8
    ldab  SCI0DRL       ; Load Accu B with value in "SCI0DRL"(data byte)
    stab  dataLSB       ; Copy to "dataLSB"
    ldaa  pageID        ; Load accu A with value in "pageID"
    cmpa  #$01          ; Compare with decimal 1 (send page 1)
    beq   StorePg1      ; If the Z bit of CCR is set, branch to StorePg1:
    cmpa  #$02          ; Compare with decimal 2 (send page 2)
    beq   StorePg2      ; If the Z bit of CCR is set, branch to StorePg2:
    cmpa  #$03          ; Compare with decimal 3 (send page 3)     
    beq   StorePg3      ; If the Z bit of CCR is set, branch to StorePg3:

StorePg1:
    ldd  txgoalMSB      ; Load double accumulator with value in 
                        ; "txgoalMSB:txgoalLSB"
    cpd  #$0002         ; Compare with decimal 2
    beq  StorePg1Wd     ; If equal branch to StorePg1Wd:
    cpd  #$0001         ; Compare with decimal 1
    beq  StorePg1Bt     ; If equal branch to StorePg1Bt:
     
StorePg1Wd:
    ldx   rxoffsetMSB  ; Load index register X with value in "rxoffsetMSB:rxoffsetLSB"
    ldd   dataMSB      ; Load double accu D with value in "dataMSB:dataLSB"
    std   veBins_R,x   ; Copy "W" data word to "veBins_R" offset in index register X
    bra   StoreDone    ; Branch to StoreDone:

StorePg1Bt:
    ldx   rxoffsetMSB  ; Load index register X with value in "rxoffsetMSB:rxoffsetLSB"
    ldaa  dataLSB      ; Load accu A with value in "dataLSB"
    staa  veBins_R,x   ; Copy "W" data byte to "veBins_R" offset in index register X
    bra   StoreDone    ; Branch to StoreDone:                        

StorePg2:
    ldd  txgoalMSB     ; Load double accumulator with value in "txgoalMSB:txgoalLSB"
    cpd  #$0002        ; Compare with decimal 2
    beq  StorePg2Wd    ; If equal branch to StorePg2Wd:
    cpd  #$0001        ; Compare with decimal 1
    beq  StorePg2Bt    ; If equal branch to StorePg2Bt:
     
StorePg2Wd:
    ldx   rxoffsetMSB  ; Load index register X with value in "rxoffsetMSB:rxoffsetLSB"
    ldd   dataMSB      ; Load double accu D with value in "dataMSB:dataLSB"
    std   stBins_R,x   ; Copy "W" data word to "stBins_R" offset in index register X
    bra   StoreDone    ; Branch to StoreDone:
     
StorePg2Bt:
    ldx   rxoffsetMSB  ; Load index register X with value in "rxoffsetMSB:rxoffsetLSB"
    ldaa  dataLSB      ; Load accu A with value in "dataLSB"
    staa  stBins_R,x   ; Copy "W" data byte to "stBins_R" offset in index register X
    bra   StoreDone    ; Branch to StoreDone:
     
StorePg3:
    ldd  txgoalMSB     ; Load double accumulator with value in "txgoalMSB:txgoalLSB"
    cpd  #$0002        ; Compare with decimal 2
    beq  StorePg3Wd    ; If equal branch to StorePg3Wd:
    cpd  #$0001        ; Compare with decimal 1
    beq  StorePg3Bt    ; If equal branch to StorePg3Bt:
     
StorePg3Wd:
    ldx   rxoffsetMSB  ; Load index register X with value in "rxoffsetMSB:rxoffsetLSB"
    ldd   dataMSB      ; Load double accu D with value in "dataMSB:dataLSB"
    std   afrBins_R,x  ; Copy "W" data word to "afrBins_R" offset in index register X
    bra   StoreDone    ; Branch to StoreDone:
     
StorePg3Bt:
    ldx   rxoffsetMSB  ; Load index register X with value in "rxoffsetMSB:rxoffsetLSB"
    ldaa  dataLSB      ; Load accu A with value in "dataLSB"
    staa  afrBins_R,x  ; Copy "W" data byte to "afrBins_R" offset in index register X
                        
StoreDone:
    clr   rxmode       ; Clear "rxmode"
    clr   txcmnd       ; Clear "txcmnd"
    clr   pageID       ; Clear "pageID"
    clrw  dataMSB      ; Clear "dataMSB:dataLSB"
    clrw  rxoffsetMSB  ; Clear "rxoffsetMSB:rxoffsetLSB"
    clrw  txgoalMSB    ; Clear "txgoalMSB:txgoalLSB"
    rti                ; Return from SCI0_ISR interrupt
     
;*****************************************************************************************
; - "txcmnd" is the command character identifier 
;    $01 = "C"
;    $02 = "W"
;    $03 = "B"
;*****************************************************************************************

CheckTxCmnd:
    ldaa  SCI0DRL    ; Load accu A with value in SCI0DRL(get the command byte)
    cmpa  #$51       ; Compare with ASCII "Q"
    beq   ModeQa     ; If equal branch to "ModeQ:"(QueryCommand) Return "Signature"
    cmpa  #$53       ; Compare with ASCII "S"
    beq   ModeSa     ; If equal branch to "ModeS:"(version info Command) Return "RevNum"
;*    cmpa  #$4F       ; Compare with ASCII "O"
;*    beq   ModeOa     ; If equal branch to "ModeO:"(ochGetCommand)
	cmpa  #$41       ; Compare with ASCII "A"
    beq   ModeAa     ; If equal branch to "ModeA:"(ochGetCommand)
    cmpa  #$43       ; Compare with ASCII "C"
    beq   ModeC1     ; If equal branch to "ModeC1:"(pageReadCommand)
    cmpa  #$57       ; Compare it with decimal 87 = ASCII "W"
    beq   ModeW1     ; If the Z bit of CCR is set, branch to Mode_W1:
                     ;(receive new VE or constant byte value and store in offset location)
                     ;(pageValueWrite or pageChunkWrite)
    cmpa  #$42       ; Compare it with decimal 66 = ASCII "B"
    beq   ModeB1     ; If the Z bit of CCR is set, branch to ModeB1:(jump to flash burner   
                     ; routine and burn VE, ST, AFR/constant values in RAM into flash)
    jmp   RcvSCIDone ; Branch to "RcvSCIDone:" No known command characters
    
ModeQa:
    jmp   ModeQ     ; Long branch
    
ModeSa:
    jmp   ModeS     ; Long branch
    
;*ModeOa:
;*    jmp   ModeO     ; Long branch
	
ModeAa:
    jmp   ModeA     ; Long branch
    
ModeC1:

;*****************************************************************************************
; - Load "rxmode" and "txcmnd" with appropriate values to get ready 
;   to receive additional command information
;*****************************************************************************************                                   

    movb  #$01,rxmode   ; Load "rxmode" with "Receiving CAN ID mode"
    movb  #$01,txcmnd   ; Load "txcmnd" with "Command character "C" ID"
    rti                 ; Return from SCI0_ISR interrupt

ModeC2:
    clr   rxmode        ; Clear "rxmode"
    clr   txcmnd        ; Clear "txcmnd"
    ldaa  pageID        ; Load accu A with value in "pageID"
    cmpa  #$01          ; Compare with decimal 1 (send page 1)
    beq   StartPg1      ; If the Z bit of CCR is set, branch to StartPg1:
    cmpa  #$02          ; Compare with decimal 2 (send page 2)
    beq   StartPg2      ; If the Z bit of CCR is set, branch to StartPg2:
    cmpa  #$03          ; Compare with decimal 3 (send page 3)     
    beq   StartPg3      ; If the Z bit of CCR is set, branch to StartPg3:

StartPg1:
    ldx   rxoffsetMSB   ; Load index register X with value in "rxoffsetMSB:rxoffsetLSB"
                        ;(Page 1 offset)
    ldaa  veBins_R,X    ; Load Accu "A" with value in "veBins, offset in "rxoffsetMSB:rxoffsetLSB"     
    staa  SCI0DRL       ; Copy to SCI0DRL (first byte to send)
    movw  #$0000,txcnt  ; Clear "txcnt"
    movb  #$04,txmode   ; Load "txmode" with decimal 4
    jmp   DoTx          ; Branch to "DoTx:" (start transmission)
     
StartPg2:
    ldx   rxoffsetMSB   ; Load index register X with value in "rxoffsetMSB:rxoffsetLSB"
                        ;(Page 2 offset)
    ldaa  stBins_R,X    ; Load Accu "A" with value in "stBins_R, offset in "rxoffsetMSB:rxoffsetLSB"  
    staa  SCI0DRL       ; Copy to SCI0DRL (first byte to send)
    movw  #$0000,txcnt  ; Clear "txcnt"
    movb  #$05,txmode   ; Load "txmode" with decimal 5
    jmp   DoTx          ; Branch to "DoTx:" (start transmission)
     
StartPg3:
    ldx   rxoffsetMSB   ; Load index register X with value in "rxoffsetMSB:rxoffsetLSB"
                        ;(Page 3 offset)
    ldaa  afrBins_R,X   ; Load Accu "A" with value in "afrBins_R, offset in "rxoffsetMSB:rxoffsetLSB"  
    staa  SCI0DRL       ; Copy to SCI0DRL (first byte to send)
    movw  #$0000,txcnt  ; Clear "txcnt"
    movb  #$06,txmode   ; Load "txmode" with decimal 6
    jmp   DoTx          ; Branch to "DoTx:" (start transmission)
            
ModeW1:
;*****************************************************************************************
; - Load "rxmode" and "txcmnd" with appropriate values to get ready 
;   to receive additional command information
;*****************************************************************************************                                   

    movb  #$01,rxmode   ; Load "rxmode" with "Receiving CAN ID mode" 
    movb  #$02,txcmnd   ; Load "txcmnd" with "Command character "W" ID" 

    rti                 ; Return from SCI0_ISR interrupt
     
ModeB1:
;*****************************************************************************************
; - Load "rxmode" and "txcmnd" with appropriate values to get ready 
;   to receive additional command information
;*****************************************************************************************
;*****************************************************************************************
;* - NOTE! I CAN'T GET MY BURNER CODE TO WORK WITH TUNER STUDIO SO I'M COMMENTING IT OUT
;*****************************************************************************************
   
;    movb  #$01,rxmode   ; Load "rxmode" with "Receiving CAN ID mode"
;    movb  #$03,txcmnd   ; Load "txcmnd" with "Command character "B" ID"      
    rti                 ; Return from SCI0_ISR interrupt
     
ModeB2
;    clr   pageID          ; Clear "pageID"
;    clr   rxmode          ; Clear "rxmode"
;    clr   txcmnd          ; Clear "txcmnd"
;    bset  engine2,ErsBrn  ; Set "ersBrn" bit4 flag in "engine2" variable. "ErsBrn" bit 
	                      ; is checked every time through the main loop. If set, interrupts 
						  ; are disabled which stops everything. The Flash area where the 
						  ; configureable constants reside is erased and the configurable 
						  ; constants in RAM are burnt back in. The flag is then cleared.
    rti                   ; Return from SCI0_ISR interrupt
            
ModeQ:
    ldaa  Signature        ; Load accu A with value at "Signature"
    staa  SCI0DRL          ; Copy to SCI0DRL (first byte to send)
    movw  #$0000,txcnt     ; Clear "txcnt"
    movw  #$0013,txgoalMSB ; Load "txgoalMSB:txgoaLSB" with decimal 19(number of bytes to send)
    movb  #$01,txmode      ; Load "txmode" with decimal 1
    bra   DoTx             ; Branch to "DoTx:" (start transmission)
    
ModeS:
    ldaa  RevNum           ; Load accu A with value at "RevNum"
    staa  SCI0DRL          ; Copy to SCI0DRL (first byte to send)
    movw  #$0000,txcnt     ; Clear "txcnt"
    movw  #$0039,txgoalMSB ; Load "txgoalMSB:txgoaLSB" with decimal 57(number of bytes to send)
    movb  #$02,txmode      ; Load "txmode" with decimal 2
    bra   DoTx             ; Branch to "DoTx:" (start transmission)

;*ModeO:
ModeA:
    ldaa  SecH             ; Load accu A with value at "secH"
    staa  SCI0DRL          ; Copy to SCI0DRL (first byte to send)
    movw  #$0000,txcnt     ; Clear "txcnt"
    movw  #$0095,txgoalMSB ; Load "txgoalMSB:txgoalLSB" with decimal 149(number of bytes to send)                    REAL TIME VARIABLES HERE!!!!!!!!
    movb  #$03,txmode      ; Load "txmode" with decimal 3
			
DoTx:
    bset  SCI0CR2,#$80     ; Set Transmitter Interrupt Enable bit7,
    bset  SCI0CR2,#$08     ; Set Transmitter Enable bit3

RcvSCIDone:
    rti                    ; Return from SCI0_ISR interrupt

;*****************************************************************************************
; - Transmit section
;*****************************************************************************************
            
TxSCI:
    ldaa  SCI0SR1  ; Load accu A with value in SCI0SR1(Read SCI0SR1 to clear "TDRE" flag)
    ldx   txcnt    ; Load Index Register X with value in "txcnt"
    inx            ; Increment Index Register X
    stx   txcnt    ; Copy new value to "txcnt"
    ldaa  txmode   ; Load accu A with value in "txmode"
    beq   TxDone   ; If "txmode" = 0 branch to "TxDone:" (sanity check)
                               
;*****************************************************************************************
; - Check the value of "txmode" to see if we are in the middle of 
;   sending value bytes.
;          $01 = Sending Signature bytes
;          $02 = Sending RevNum bytes
;          $03 = Sending real time variables
;          $04 = Sending constants page 1
;          $05 = Sending constants page 2
;          $06 = Sending constants page 3
;
;*****************************************************************************************
    cmpa  #$01         ; Compare with $01
    beq   SendSig      ; If equal branch to "SendSig:"
    cmpa  #$02         ; Compare with $02
    beq   SendRevNum   ; If equal branch to "SendRevNum:"
    cmpa  #$03         ; Compare with $03
    beq   SendVars     ; If equal branch to "SendVars:"
    cmpa  #$04         ; Compare with $04
    beq   SendPg1      ; If equal branch to "SendPg1:"
    cmpa  #$05         ; Compare with $05
    beq   SendPg2      ; If equal branch to "SendPg2:"
    cmpa  #$06         ; Compare with $06
    beq   SendPg3      ; If equal branch to "SendPg3"
    bra   TxDone       ; Branch to "TxDone:" (sanity check)
            
SendSig:               ; "txmode" = 1
    ldaa  Signature,X  ; Load accu A with value at "Signature:", offset in "X" register
    bra   ContTx       ; Branch to "ContTx:"(continue TX process)
    
SendRevNum:            ; "txmode" = 2
    ldaa  RevNum,X     ; Load accu A with value at "RevNum:", offset in "X" register
    bra   ContTx       ; Branch to "ContTx:"(continue TX process)
			
SendVars:              ; "txmode" = 3
    ldaa  SecH,X       ; Load accu A with value at "secH:" offset in "X" register.
    bra   ContTx       ; Branch to "ContTX:" (continue TX process)
			
SendPg1:               ; "txmode" = 4
    ldd   #veBins_R    ; Load double accumulator D with address of "veBins_R"
    addd  rxoffsetMSB  ; (A:B)+(M:M+1)->A:B Add the address of "veBins_R" with the offset 
                       ; value to get the effective address of the byte to be sent
    ldaa  D,X          ; Load Accu A with value in the effective address
    bra   ContTx       ; Branch to "ContTx:" (continue TX process)
                               
SendPg2:               ; "txmode" = 5
    ldd   #stBins_R    ; Load double accumulator D with address of "stBins_R"
    addd  rxoffsetMSB  ; (A:B)+(M:M+1)->A:B Add the address of "stBins_R" with the offset 
                       ; value to get the effective address of the byte to be sent
    ldaa  D,X          ; Load Accu A with value in the effective address
    bra   ContTx       ; Branch to "ContTx:" (continue TX process)
                               
SendPg3:               ; "txmode" = 6
    ldd   #afrBins_R   ; Load double accumulator D with address of "afrBins_R"
    addd  rxoffsetMSB  ; (A:B)+(M:M+1)->A:B Add the address of "afrBins_R" with the offset 
                       ; value to get the effective address of the byte to be sent
    ldaa  D,X          ; Load Accu A with value in the effective address

ContTx:
    staa  SCI0DRL      ; Copy value in accu A into SCI0DRL (next byte to send) 
    ldy   txcnt        ; Load Index Register Y with value in "txcnt"
    cpy   txgoalMSB    ; Compare value to "txgoalMSB:txgoalLSB"
    bne   ByteDone     ; If the Z bit of CCR is not set, branch to "ByteDone:" 
                       ;(not finished yet)
            
TxDone:
    movw  #$0000,txcnt     ; Clear "txcnt"
    movw  #$0000,txgoalMSB ; Clear "txgoalMSB:txgoalLSB"
    clr   txmode           ; Clear "txmode"
    clr   pageID           ; Clear "pageID"
    bclr  SCI0CR2,#$80     ; Clear Transmitter Interrupt Enable bit7
                           ;(disable TDRE interrupt)
    bclr  SCI0CR2,#$08       ; Clear Transmitter Enable bit3 (disable transmitter)
            
ByteDone:
    rti                    ; Return from SCI0_ISR interrupt
            
;*****************************************************************************************
;*****************************************************************************************
;                                    ECT TIMER ISRs
;*****************************************************************************************
;   - ECT ISRs
;       - ECT ch0 camshaft sensor
;       - ECT ch1 crankshaft sensor
;       - ECT ch2 vehicle speed sensor
;       - ECT ch3 ignition 1
;       - ECT ch4 ignition 2
;       - ECT ch5 ignition 3
;       - ECT ch6 ignition 4
;       - ECT ch7 ignition 5
;
;*****************************************************************************************
; - The camshaft position sensor and the crankshaft position sensor are both hall
;   effect gear tooth sensors. They read notched wheels on their repsective shafts.
;   When the sensor senses a notch its output pin goes to ground. The BPEM simulator 
;   input from the sensor is the LED circuit of an opto isolator. When the LED in the 
;   opto is powered it biases the output transistor on so the timer channel pin sees a
;   rising edge, which triggers an interrupt event. The state machine uses these events 
;   to de-code the signals to determine crankshaft position and camshaft phase. Any 
;   event that does not fall into the mechanical order of events triggers an error.
;   An error will disable ignition and fuel injection until a positive lock on crankshaft
;   position and camshaft phase is re-established. 
;*****************************************************************************************
;*****************************************************************************************
; - Absolute accuracy in determining crankshaft position and camshaft phase is really at 
;   the heart of this program and the state machine code makes it all happen. This is all
;   credit to the incredible talent and patience of Dan Williams, without whos help I  
;   could not have done what I did. Thanks Dan!  
;*****************************************************************************************

;*****************************************************************************************
; - ECT_TC0_ISR Interrupt Service Routine (Camshaft sensor notch)
;   Event = 0
;*****************************************************************************************

    XDEF ISR_ECT_TC0        ; Required for CW
        
ISR_ECT_TC0:

    movb #$01,ECT_TFLG1     ; Clear C0F interrupt flag
    ldx    #StateLookup     ; Load index register X with the address of "TableLookup"
    ldab   State            ; Load Accu B with the contents of "State"             
    aslb                    ; Shift Accu B 1 place to the left                      
    orab   #$00             ; Bit wise inclusive OR Accu B with 0
    ldaa   B,X              ; Load Accu A with the contents of "TableLookup", offset in
                            ; Accu B (9 bit constant offset indexed addressing)    
    staa   State            ; Copy to "State"
    rti                     ; Return from Cam Sensor ISR_ECT_TC0 interrupt
    
;*****************************************************************************************

;*****************************************************************************************
; - ECT_TC1_ISR Interrupt Service Routine (Crankshaft sensor notch)
;   Event = 1
;*****************************************************************************************

     XDEF ISR_ECT_TC1       ; Required for CW
        
ISR_ECT_TC1:

    movb #$02,ECT_TFLG1     ; Clear C1F interrupt flag
    ldx    #StateLookup     ; Load index register X with the address of "TableLookup"
    ldab   State            ; Load Accu B with the contents of "State"             
    aslb                    ; Shift Accu B 1 place to the left                      
    orab   #$01             ; Bit wise inclusive OR Accu B with 1
    ldaa   B,X              ; Load Accu A with the contents of "TableLookup", offset in
                            ; Accu B (9 bit constant offset indexed addressing)    
    staa   State            ; Copy to "State"
    cmpa    #$46            ; Compare with decimal 70 (Error)
    beq     State_Error     ; If "State" = 70, branch to State_Error:
    cmpa    #$67            ; Compare with decimal 103
    ble     NoLock          ; If "State" =< 103, branch to NoLock:
    bgt     SynchLock       ; If "State" is > 103, branch to Synchlock: 

State_Error:

;*****************************************************************************************
; - If we get here we have experienced an unexpected cam or crank input and have lost lock.
;   No more spark or injection events until lock has been re-established.
;*****************************************************************************************

    clr   State                     ; Clear "State"
    bset  StateStatus,SynchLost     ; Set "SynchLost" bit of "StateStatus" variable (bit1)
    bset  PORTB,#$20                ; Set Port B bit5 (Crank Synch Indicator State)
	                                ;(indicator on, crank not synched)  
    bclr  StateStatus,Synch         ; Clear "Synch " bit of "StateStatus" variable (bit0)
    jmp   StateHandlersDone         ; Jump to StateHandlersDone:   

SynchLock:

;*****************************************************************************************
; - If we get here we have either just reached one of the four possible lock points, or 
;    we are already in the synch loop.
;*****************************************************************************************

    bset  StateStatus,Synch        ; Set "Synch " bit of "StateStatus" variable (bit0)
    bclr  StateStatus,SynchLost    ; Clear "SynchLost" bit of "StateStatus" variable (bit1)
    bclr  PORTB,#$20               ; Clear Port B bit5 (Crank Synch Indicator State)
                                   ; (indicator off, crank synched)	
    bra   STATE_STATUS_done        ; Branch to STATE_STATUS_done:

NoLock:

;*****************************************************************************************
; - If we get here we have the state machine is still looking for a synch lock.
;*****************************************************************************************

    bclr  StateStatus,Synch        ; Clear "Synch" bit of "StateStatus" variable (bit0)
    bset  StateStatus,SynchLost    ; Set "SynchLost" bit of "StateStatus" variable (bit1)
    bset  PORTB,#$20               ; Set Port B bit5 (Crank Synch Indicator State)
	                               ; (indicator on, crank not synched)
    jmp   StateHandlersDone        ; Jump to StateHandlersDone:   

 STATE_STATUS_done:

;*****************************************************************************************

; Cranking schedule
;*****************
; CT3/T1 - Synchronization point.
;        - Inj2 - Start injection pulse for #9 & #4.
;        - Ign4 - Energise coil for ignition #7, waste #4.(24 degrees BTDC #7Cyl)
; CT3/T2 - Ign4 - De-energise coil for ignition #7, waste #4.(6 degrees BTDC #7Cyl)
;        - Ign5 - Energise coil for ignition #2, waste #3.(60 degrees BTDC #2Cyl)
;        - Tachout on.
; CT3/T3 - Ign5 - De-energise coil for ignition #2, waste #3.(6 degrees BTDC #2Cyl)
; CT3/T4 - Tachout off.
; CT4/T5 - Synchronization point.
;        - Inj3 - Start injection pulse for #3 & #6
;        - Ign1 - Energise coil for for ignition #1, waste #6.(24 degrees BTDC #1Cyl)
; CT4/T6 - Ign1 - De-energise coil for for ignition #1, waste #6.(6 degrees BTDC #1Cyl)
;        - Ign2 - Energise coil for for ignition #10, waste #5.(60 degrees BTDC #10Cyl)
;        - Tachout on.
; CT4/T7 - Ign2 - De-energise coil for for ignition #10, waste #5.(6 degrees BTDC #10Cyl)
; CT4/T8 - Tachout off.
; CT4/T9 - Inj4 - Start injection pulse for #5 & #8.
;        - Ign3 - Energise coil for ignition #9, waste #8.(24 degrees BTDC #9Cyl) 
; CT4/T10 - Ign3 - De-energise coil for ignition #9, waste #8.(6 degrees BTDC #9Cyl)
;        - Ign4 - Energise coil for ignition #4, waste #7.(60 degrees BTDC #4Cyl)
;        - Tachout on.
; CT4/T1 - Synchronization point.
;        - Ign4 - De-energise coil for ignition #4, waste #7.(6 degrees BTDC #4Cyl)
; CT4/T2 - Tachout off.
; CT4/T3 - Inj5 - Start injection pulse for #7 & #2.
;        - Ign5 - Energise coil for ignition #3, waste #2.(24 degrees BTDC #3Cyl)
; CT4/T4 - Ign5 - De-energise coil for ignition #3, waste #2.(6 degrees BTDC #3Cyl)
;        - Ign1 - Energise coil for for ignition #6, waste #1.(60 degrees BTDC #6Cyl)
;        - Tachout on.
; CT1/T5 - Synchronization point.
;        - Ign1 - De-energise coil for for ignition #6, waste #1.(6 degrees BTDC #6Cyl)
; CT1/T6 - Tachout off.
; CT1/T7 - Inj1 - Start injection pulse for #1 & #10.
;        - Ign2 - Energise coil for for ignition #5, waste #10.(24 degrees BTDC #5Cyl) 
; CT1/T8 - Ign2 - De-energise coil for for ignition #5, waste #10.(6 degrees BTDC #5Cyl)
;        - Ign3 - Energise coil for ignition #8, waste #9.(60 degrees BTDC #8Cyl)
;        - Tachout on. 
; CT1/T9 - Ign3 - De-energise coil for ignition #8, waste #9.(6 degrees BTDC #8Cyl)
; CT1/T10 - Tachout off.
; Repeat

; Ignition coils are energised at 24 degrees BTDC on compression and de-energised at 
; 6 degrees BTDC on compression for odd cylinders. They are energised at 60 degrees 
; BTDC on compression and de-energised at 6 degrees BTDC on compression for even cylinders. 
; The long dwell times shouldn't be a problem as they only occur under cranking conditions
; when the system voltage is lower than normal.  
; Injector pulse width starts when the intake valve just begins to open on even cylinders, 
; and 54 degrees after the intake valve starts to open on odd cylinders.

; Running schedule
;*****************
; CT3/T1 - Synchronization point.
;        - Inj2 - Start injection pulse for #9 & #4.
; CT3/T2 - Ign1 - Start timer for ignition #1, waste #6. 
;        - Tachout on.
; CT3/T3 - Ign2 - Start timer for ignition #10, waste #5.
; CT3/T4 - Tachout off.
; CT4/T5 - Synchronization point.
;        - Inj3 - Start injection pulse for #3 & #6.
; CT4/T6 - Ign3 - Start timer for ignition #9, waste #8. 
;        - Tachout on.
; CT4/T7 - Ign4 - Start timer for ignition #4, waste #7.
; CT4/T8 - Tachout off.
; CT4/T9 - Inj4 - Start injection pulse for #5 & #8. 
; CT4/T10 - Ign5 - Start timer for ignition #3, waste #2. 
;         - Tachout on.
; CT4/T1 - Synchronization point.
;        - Ign1 - Start timer for ignition #6, waste #1.
; CT4/T2 - Tachout off.
; CT4/T3 - Inj5 - Start injection pulse for #7 & #2. 
; CT4/T4 - Ign2 - Start timer for ignition #5, waste #10.
;        -  Tachout on.
; CT1/T5 - Synchronization point. 
;        - Ign3 - start timer for ignition #8, waste #9.
; CT1/T6 - Tachout off.
; CT1/T7 - Inj1 - Start injection pulse for #1 & #10. 
; CT1/T8 - Ign4 - Start timer for ignition #7, waste #4.
;        -  Tachout on.
; CT1/T9 - Ign5 - Start timer for ignition #2, waste #3.
; CT1/T10 - Tachout off.
; Repeat

; Ignition timers start 150 degrees BTDC on compression on all cylinders. After the 
; calculated delay the coil is energised for the desired dwell time and de-energised at 
; the desired spark angle BTDC on compression. 
; Injector pulse width starts when the intake valve just begins to open on even cylinders, 
; and 54 degrees after the intake valve starts to open on odd cylinders.
 
;*****************************************************************************************
;*****************************************************************************************
; The ignition coils on PT7,6,5,4,3 are initialized as output compare timed outputs, 
; but in crank mode they are re-configured as general purpose outputs. In run mode they
; are configured back as output compare timed outputs.
;*****************************************************************************************
;*****************************************************************************************
; Check to see if we are in crank or run mode and configure PT7,6,5,4,3 accordingly.
; In run mode the ignition coils are contolled by the output compare time channels
; PT7,6,5,4,3. In crank mode the pins are reconfigured as general purpose outputs and are 
; controlled manually at the appropriate crank trigger. 
;*****************************************************************************************

    brset engine,run,IgnRunMode  ; If "run" bit of "engine" is set branch to IgnRunMode:
    movb #$00,ECT_TIOS   ; %00000000 -> ECT Timer Input capture/Output Compare Select register
                         ; (Disable output compare channels)	
    movb #$F8,DDRT       ; %11111000 -> Port T data direction register (PT7,6,5,4,3 outputs)
	bra IgnConfigDone    ; Branch to IgnConfigDone: 
	
IgnRunMode:
    brset engine2,RunModeOn,IgnConfigDone ; If "RunModeOn" bit of "engine2 " bit field is 
	                     ; set branch to IgnConfigDone: 
						 ;(pins have been re-configured for OC so fall through)
	movb #$F8,ECT_TIOS   ; %11111000 -> ECT Timer Input capture/Output Compare Select register
                         ; (Output Compare PT7,6,5,4,3, Input Capture PT2,1,0)
	bset engine2,RunModeOn  ; Set "RunMode" bit of engine2 bit field (bit5)(run mode confirmed)

IgnConfigDone:
	
;*****************************************************************************************
; - "State" event handlers
;*****************************************************************************************
	
    ldaa    State           ; Load accu A with value in "State"
    cmpa    #$7D            ; Compare with decimal 125 (CT3/T1)
    lbeq    Notch_CT3_T1    ; If the Z bit of CCR is set, branch to Notch_CT3_T1: 
    cmpa    #$6F            ; Compare with decimal 111 (CT3/T2)
    lbeq    Notch_CT3_T2    ; If the Z bit of CCR is set, branch to Notch_CT3_T2:
    cmpa    #$70            ; Compare with decimal 112 (CT3/T3)
    lbeq    Notch_CT3_T3    ; If the Z bit of CCR is set, branch to Notch_CT3_T3:
    cmpa    #$71            ; Compare with decimal 113 (CT3/T4)
    lbeq    Notch_CT3_T4    ; If the Z bit of CCR is set, branch to Notch_CT3_T4:
    cmpa    #$7F            ; Compare with decimal 127 (CT4/T5)
    lbeq    Notch_CT4_T5    ; If the Z bit of CCR is set, branch to Notch_CT4_T5:
    cmpa    #$7B            ; Compare with decimal 123 (CT4/T6)
    lbeq    Notch_CT4_T6    ; If the Z bit of CCR is set, branch to Notch_CT4/T6:
    cmpa    #$7A            ; Compare with decimal 122 (CT4/T7)
    lbeq    Notch_CT4_T7    ; If the Z bit of CCR is set, branch to Notch_CT4_T7:
    cmpa    #$79            ; Compare with decimal 121 (CT4/T8)
    lbeq    Notch_CT4_T8    ; If the Z bit of CCR is set, branch to Notch_CT4_T8:
    cmpa    #$78            ; Compare with decimal 120 (CT4/T9)
    lbeq    Notch_CT4_T9    ; If the Z bit of CCR is set, branch to Notch_CT4_T9:
    cmpa    #$77            ; Compare with decimal 119 (CT4/T10)
    lbeq    Notch_CT4_T10   ; If the Z bit of CCR is set, branch to Notch_CT4_T10:
    cmpa    #$7E            ; Compare with decimal 126 (CT4/T1)
    lbeq    Notch_CT4_T1    ; If the Z bit of CCR is set, branch to Notch_CT4_T1:
    cmpa    #$76            ; Compare with decimal 118 (CT4/T2)
    lbeq    Notch_CT4_T2    ; If the Z bit of CCR is set, branch to Notch_CT4_T2:
    cmpa    #$75            ; Compare with decimal 117 (CT4/T3)
    lbeq    Notch_CT4_T3    ; If the Z bit of CCR is set, branch to Notch_CT4_T3:
    cmpa    #$74            ; Compare with decimal 116 (CT4/T4)
    lbeq    Notch_CT4_T4    ; If the Z bit of CCR is set, branch to Notch_CT4_T4:
    cmpa    #$7C            ; Compare with decimal 124 (CT1/T5)
    lbeq    Notch_CT1_T5    ; If the Z bit of CCR is set, branch to Notch_CT1_T5:
    cmpa    #$68            ; Compare with decimal 104 (CT1/T6)
    lbeq    Notch_CT1_T6    ; If the Z bit of CCR is set, branch to Notch_CT1_T6:
    cmpa    #$69            ; Compare with decimal 105 (CT1/T7)
    lbeq    Notch_CT1_T7    ; If the Z bit of CCR is set, branch to Notch_CT1_T7:
    cmpa    #$6A            ; Compare with decimal 106 (CT1/T8)
    lbeq    Notch_CT1_T8    ; If the Z bit of CCR is set, branch to Notch_CT1_T8:
    cmpa    #$6B            ; Compare with decimal 107 (CT1/T9)
    lbeq    Notch_CT1_T9    ; If the Z bit of CCR is set, branch to Notch_CT1_T9:
    cmpa    #$6C            ; Compare with decimal 108 (CT1/T10)
    lbeq    Notch_CT1_T10   ; If the Z bit of CCR is set, branch to Notch_CT1_T10:
    staa    TestValb        ; For troubleshooting if nothing matches
    
Notch_CT3_T1:

;*****************************************************************************************
; - This is one of 4 Synchronization points. #4 intake valve is just starting to open
;   and #9 intake valve is 54 degrees after it has started to open. Start the pulse 
;   width for injectors 9&4.
;*****************************************************************************************

    brset engine,FldClr,INJ2FldClr ; If "FldClr" bit of "engine" bit field is set branch 
                                   ; to INJ2FldClr:(don't fire injector)
    jsr  FIRE_INJ2                 ; Jump to FIRE_INJ2 subroutine  

INJ2FldClr:
    brset engine,run,CT3_T1_Done   ; If "run" bit of "engine" bit field is set branch 
                                   ; to CT3_T1_Done:(engine is running so Ign4 
								   ; (7&4) is not controlled here).

;*****************************************************************************************
;   We are at 24 degrees BTDC on compression for #7 and we are in crank mode. Energise 
;   the coil for Ign4 (7&4) on PT6.
;*****************************************************************************************

    bset PTT,#$40  ; Set Port T bit 6 (energise coil for Ign4 (7&4))
	
CT3_T1_Done:
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT3_T2:
;*****************************************************************************************
; - If we are here the crankshaft is at 150 degrees before top dead centre on the 
;   compression/power strokes for #1 cylinder. If we are in run mode start the hardware 
;   timer to delay the coil dwell for spark #1, waste #6. Tachout on.
;*****************************************************************************************

    brclr engine,run,CT3_T2_Crank ; If "run" bit of "engine" bit field is clear branch 
                                    ; to CT3_T2_Crank:(engine is cranking so Ign1 (1&6) 
								    ; is not controlled here).
				
;*****************************************************************************************
; - PT3 ECT OC3 (Ign1)(1&6) Control
;*****************************************************************************************

    movb #$08,ECT_TFLG1  ; Clear C3F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset ECT_TCTL2,#$80 ; Set Ch3 output line to 1 on compare bit7
    bset ECT_TCTL2,#$40 ; Set Ch3 output line to 1 on compare bit6
    ldd  ECT_TCNT       ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd1      ; Add "IgnOCadd1" (Delay time from crank signal to energise coil)
    std  ECT_TC3        ; Copy result to Timer IC/OC register 0 (Start OC operation)
                        ; (Will trigger an interrupt after the delay time)(LED off)
	bclr PORTB,#$10         ; Clear "Tachout" Port B bit4 (output high, hardware inverted)
    jmp   StateHandlersDone ; Jump to StateHandlersDone:
						
CT3_T2_Crank:
;*****************************************************************************************
;   We are at 6 degrees BTDC on compression for #7 and we are in crank mode. De-energise 
;   the coil for Ign4 (7&4) on PT6.
;*****************************************************************************************

    bclr PTT,#$40           ; Clear Port T bit 6 (de-energise coil for Ign4 (7&4))
	
;*****************************************************************************************
;   We are at 60 degrees BTDC on compression for #2 and we are in crank mode. Energise 
;   the coil for Ign5 (2&3) on PT7.
;*****************************************************************************************

    bset PTT,#$80           ; Set Port T bit 7 (energise coil for Ign5 (2&3))
    bclr PORTB,#$10         ; Clear "Tachout" Port B bit4 (output high, hardware inverted)
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT3_T3:

;*****************************************************************************************
; - If we are here the crankshaft is at 150 degrees before top dead centre on the 
;   compression/power strokes for #10 cylinder. If we are in run mode start the hardware 
;   timer to delay the coil dwell for spark #10, waste #5.
;*****************************************************************************************

    brclr engine,run,CT3_T3_Crank ; If "run" bit of "engine" bit field is clear branch 
                                    ; to CT3_T3_Crank:(engine is cranking so Ign2 (10&5) 
								    ; is not controlled here).
							
;*****************************************************************************************
; - PT4 - ECT OC4 Ign2(10&5) Control
;*****************************************************************************************

    movb #$10,ECT_TFLG1  ; Clear C4F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset ECT_TCTL1,#$02 ; Set Ch4 output line to 1 on compare bit1
    bset ECT_TCTL1,#$01 ; Set Ch4 output line to 1 on compare bit0
    ldd  ECT_TCNT       ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd1      ; Add "IgnOCadd1" (Delay time from crank signal to energise coil)
    std  ECT_TC4        ; Copy result to Timer IC/OC register 2 (Start OC operation)
                        ; (Will trigger an interrupt after the delay time)(LED off)
	bclr PTT,#$80           ; Clear Port T bit 7 (de-energise coil for Ign5 (2&3))
    jmp   StateHandlersDone ; Jump to StateHandlersDone:
						
CT3_T3_Crank:
;*****************************************************************************************
;   We are at 6 degrees BTDC on compression for #2 and we are in crank mode. De-energise 
;   the coil for Ign5 (7&4) on PT6.
;*****************************************************************************************

    bclr PTT,#$80           ; Clear Port T bit 7 (de-energise coil for Ign5 (2&3))
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 
    
Notch_CT3_T4:

;*****************************************************************************************
; - If we are here the crankshaft is at 6 degrees before top dead centre on the 
;   exhaust/intake strokes for #3 cylinder and 60 degrees before top dead centre on the 
;   exhaust/intake strokes for #6 cylinder. #3 intake valve is just starting to open
;   and #6 intake valve is 54 degrees before it will start to open. Tachout off.    
;*****************************************************************************************

    bset PORTB,#$10         ; Set "Tachout" Port B bit4 (output low, hardware inverted)
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT4_T5:

;*****************************************************************************************
; - This is one of 4 Synchronization points.  #6 intake valve is just starting to open
;   and #3 intake valve is 54 degrees after it has started to open. Start the pulse 
;   width for injectors 3&6.    
;*****************************************************************************************

    brset engine,FldClr,INJ3FldClr ; If "FldClr" bit of "engine" bit field is set branch 
                                   ; to INJ3FldClr:(don't fire injector)
    jsr  FIRE_INJ3                 ; Jump to FIRE_INJ3 subroutine  

INJ3FldClr:
    brset engine,run,CT4_T5_Done   ; If "run" bit of "engine" bit field is set branch 
                                   ; to CT4_T5_Done:(engine is running so Ign1 (1&6) 
								   ; is not controlled here).
					
;*****************************************************************************************
;   We are at 24 degrees BTDC on compression for #1 and we are in crank mode. Energise 
;   the coil for Ign1 (1&6) on PT3.
;*****************************************************************************************

    bset PTT,#$08           ; Set Port T bit 3 (energise coil for Ign1 (1&6))
	
CT4_T5_Done:
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT4_T6:

;*****************************************************************************************
; - If we are here the crankshaft is at 150 degrees before top dead centre on the 
;   compression/power strokes for #9 cylinder. If we are in run mode start the hardware  
;   timer to delay the coil dwell for spark #9, waste #8. Tachout on.
;*****************************************************************************************

    brclr engine,run,CT4_T6_Crank  ; If "crank" bit of "engine" bit field is clear branch 
                                   ; to CT4_T6_Crank:(engine is cranking so Ign3 (9&8) 
								   ; is not controlled here).
							
;*****************************************************************************************
; - PT5 - ECT OC5 Ign3(9&8) Control
;*****************************************************************************************

    movb #$20,ECT_TFLG1  ; Clear C5F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset ECT_TCTL1,#$08 ; Set Ch5 output line to 1 on compare bit3
    bset ECT_TCTL1,#$04 ; Set Ch5 output line to 1 on compare  bit2
    ldd  ECT_TCNT       ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd1      ; Add "IgnOCadd1" (Delay time from crank signal to energise coil)
    std  ECT_TC5        ; Copy result to Timer IC/OC register 2 (Start OC operation)
                        ; (Will trigger an interrupt after the delay time)(LED off)
	bclr PORTB,#$10         ; Clear "Tachout" Port B bit4 (output high, hardware inverted)
	jmp   StateHandlersDone ; Jump to StateHandlersDone:
						
CT4_T6_Crank:
;*****************************************************************************************
;   We are at 6 degrees BTDC on compression for #1 and we are in crank mode. De-energise 
;   the coil for Ign1 (1&6) on PT3.
;*****************************************************************************************

    bclr PTT,#$08           ; Clear Port T bit 3 (de-energise coil for Ign1 (1&6))
	
;*****************************************************************************************
;   We are at 60 degrees BTDC on compression for #10 and we are in crank mode. Energise 
;   the coil for Ign2 (10&5) on PT4.
;*****************************************************************************************

    bset PTT,#$10           ; Set Port T bit 4 (energise coil for Ign2 (10&5))
    bclr PORTB,#$10         ; Clear "Tachout" Port B bit4 (output high, hardware inverted)
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT4_T7:

;*****************************************************************************************
; - If we are here the crankshaft is at 150 degrees before top dead centre on the 
;   compression/power strokes for #4 cylinder. If we are in run mode start the hardware  
;   timer to delay the coil dwell for spark #4, waste #7.   
;*****************************************************************************************

    brclr engine,run,CT4_T7_Crank ; If "run" bit of "engine" bit field is clear branch 
                                    ; to CT4_T7_Crank:(engine is cranking so Ign4 (4&7) 
								    ; is not controlled here).
							
;*****************************************************************************************
; - PT6 - ECT OC6 Ign4(4&7) Control
;*****************************************************************************************

    movb #$40,ECT_TFLG1  ; Clear C6F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset ECT_TCTL1,#$20 ; Set Ch6 output line to 1 on compare bit5
    bset ECT_TCTL1,#$10 ; Set Ch6 output line to 1 on compare bit4
    ldd  ECT_TCNT       ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd1      ; Add "IgnOCadd1" (Delay time from crank signal to energise coil)
    std  ECT_TC6        ; Copy result to Timer IC/OC register 2 (Start OC operation)
                        ; (Will trigger an interrupt after the delay time)(LED off)
	bset PORTB,#$10         ; Set "Tachout" Port B bit4 (output low, hardware inverted)
	jmp   StateHandlersDone ; Jump to StateHandlersDone:
						
CT4_T7_Crank:
;*****************************************************************************************
;   We are at 6 degrees BTDC on compression for #10 and we are in crank mode. De-energise 
;   the coil for Ign2 (10&5) on PT4.
;*****************************************************************************************

    bclr PTT,#$10           ; Clear Port T bit 4 (de-energise coil for Ign2 (10&5))
    jmp   StateHandlersDone ; Jump to StateHandlersDone:

Notch_CT4_T8:

;*****************************************************************************************
; - If we are here the crankshaft is at 6 degrees before top dead centre on the 
;   exhaust/intake strokes for #5 cylinder and 60 degrees before top dead centre on the 
;   exhaust/intake strokes for #8 cylinder. #5 intake valve is just sstarting to open
;   and #8 intake valve is 54 degrees before it will start to open. Tachout off.    
;*****************************************************************************************

    bset PORTB,#$10         ; Set "Tachout" Port B bit4 (output low, hardware inverted)
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 
    
Notch_CT4_T9:

;*****************************************************************************************
; - If we are here #8 intake valve is just starting to open and #5 intake valve is 54 
;   degrees after it has started to open. Start the pulse width for injectors 5&8.    
;*****************************************************************************************

    brset engine,FldClr,INJ4FldClr ; If "FldClr" bit of "engine" bit field is set branch 
                                   ; to INJ4FldClr:(don't fire injector)
    jsr  FIRE_INJ4                 ; Jump to FIRE_INJ4 subroutine  

INJ4FldClr:
    brset engine,run,CT4_T9_Done   ; If "run" bit of "engine" bit field is set branch 
                                   ; to CT4_T9_Done:(engine is running so Ign3 
								   ; (9&8) is not controlled here).

;*****************************************************************************************
;   We are at 24 degrees BTDC on compression for #9 and we are in crank mode. Energise 
;   the coil for Ign3 (9&8) on PT5.
;*****************************************************************************************

    bset PTT,#$20  ; Set Port T bit 5 (energise coil for Ign3 (9&8))
	
CT4_T9_Done:
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT4_T10:

;*****************************************************************************************
; - If we are here the crankshaft is at 150 degrees before top dead centre on the 
;   compression/power strokes for #3 cylinder. If we are in run mode start the hardware 
;   timer to delay the coil dwell for spark #3, waste #2. Tachout on.
;*****************************************************************************************
;*****************************************************************************************

    brclr engine,run,CT4_T10_Crank ; If "run" bit of "engine" bit field is clear branch 
                                    ; to CT4_T10_Done:(engine is cranking so Ign5 (3&2) 
								    ; is not controlled here).
							
;*****************************************************************************************
; - PT7 - ECT OC7 Ign5(3&2) Control
;*****************************************************************************************

    movb #$80,ECT_TFLG1  ; Clear C7F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset ECT_TCTL1,#$80 ; Set Ch7 output line to 1 on compare bit7
    bset ECT_TCTL1,#$40 ; Set Ch7 output line to 1 on compare bit6
    ldd  ECT_TCNT       ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd1      ; Add "IgnOCadd1" (Delay time from crank signal to energise coil)
    std  ECT_TC7        ; Copy result to Timer IC/OC register 2 (Start OC operation)
                        ; (Will trigger an interrupt after the delay time)(LED off)
	bclr PORTB,#$10         ; Clear "Tachout" Port B bit4 (output high, hardware inverted)
	jmp   StateHandlersDone ; Jump to StateHandlersDone:
						
CT4_T10_Crank:
;*****************************************************************************************
;   We are at 6 degrees BTDC on compression for #9 and we are in crank mode. De-energise 
;   the coil for Ign3 (9&8) on PT5.
;*****************************************************************************************

    bclr PTT,#$20           ; Clear Port T bit 5 (de-energise coil for Ign3 (9&8))
	
;*****************************************************************************************
;   We are at 60 degrees BTDC on compression for #4 and we are in crank mode. Energise 
;   the coil for Ign4 (4&7) on PT6.
;*****************************************************************************************

    bset PTT,#$40           ; Set Port T bit 6 (energise coil for Ign4 (4&7))
    bclr PORTB,#$10         ; Clear "Tachout" Port B bit4 (output high, hardware inverted)
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT4_T1:

;*****************************************************************************************
; - If we are here the crankshaft is at 150 degrees before top dead centre on the 
;   compression/power strokes for #6 cylinder. If we are in run mode start the hardware  
;   timer to delay the coil dwell for spark #6, waste #1.   
;*****************************************************************************************

    brclr engine,run,CT4_T1_Crank ; If "run" bit of "engine" bit field is clear branch 
                                   ; to CT4_T1_Crank:(engine is cranking so Ign1 (6&1) 
								   ; is not controlled here).
								   
;*****************************************************************************************
; - PT3 ECT OC0 (Ign1)(6&1) Control
;*****************************************************************************************

    movb #$08,ECT_TFLG1  ; Clear C3F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset ECT_TCTL2,#$80 ; Set Ch3 output line to 1 on compare bit7
    bset ECT_TCTL2,#$40 ; Set Ch3 output line to 1 on compare bit6
    ldd  ECT_TCNT       ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd1      ; Add "IgnOCadd1" (Delay time from crank signal to energise coil)
    std  ECT_TC3        ; Copy result to Timer IC/OC register 0 (Start OC operation)
                        ; (Will trigger an interrupt after the delay time)(LED off)
	jmp   StateHandlersDone ; Jump to StateHandlersDone:
						
CT4_T1_Crank:
;*****************************************************************************************
;   We are at 6 degrees BTDC on compression for #4 and we are in crank mode. De-energise 
;   the coil for Ign4 (4&7) on PT6.
;*****************************************************************************************

    bclr PTT,#$40           ; Clear Port T bit 6 (de-energise coil for Ign4 (4&7))
    jmp   StateHandlersDone ; Jump to StateHandlersDone:
    
Notch_CT4_T2:

;*****************************************************************************************
; - If we are here it is 1 of 4 synchronization points and the crankshaft is at 6 degrees 
;   before top dead centre on the exhaust/intake strokes for #7 cylinder and 60 degrees 
;   before top dead centre on the exhaust/intake strokes for #2 cylinder. #7 intake valve 
;   is just starting to open and #2 intake valve is 54 degrees before it will start to 
;   open. Tachout off.    
;*****************************************************************************************

    bset PORTB,#$10         ; Set "Tachout" Port B bit4 (output low, hardware inverted)
    jmp   StateHandlersDone ; Jump to StateHandlersDone:
    
Notch_CT4_T3:

;*****************************************************************************************
; - If we are here #2 intake valve is just starting to open and #7 intake valve is 54 
;   degrees after it has started to open. Start the pulse width for injectors 7&2.    
;*****************************************************************************************

    brset engine,FldClr,INJ5FldClr ; If "FldClr" bit of "engine" bit field is set branch 
                                   ; to INJ5FldClr:(don't fire injector)
    jsr  FIRE_INJ5                 ; Jump to FIRE_INJ5 subroutine  

INJ5FldClr:
    brset engine,run,CT4_T3_Done   ; If "run" bit of "engine" bit field is set branch 
                                   ; to CT3_T1_Done:(engine is running so Ign5 
								   ; (3&2) is not controlled here).

;*****************************************************************************************
;   We are at 24 degrees BTDC on compression for #3 and we are in crank mode. Energise 
;   the coil for Ign5 (3&2) on PT7.
;*****************************************************************************************

    bset PTT,#$80  ; Set Port T bit 7 (energise coil for Ign5 (3&2))
	
CT4_T3_Done:
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT4_T4:
    
;*****************************************************************************************
; - If we are here the crankshaft is at 150 degrees before top dead centre on the 
;   compression/power strokes for #5 cylinder. If we are in run mode start the hardware  
;   timer to delay the coil dwell for spark #5, waste #10. Tachout on. 
;*****************************************************************************************

    brclr engine,run,CT4_T4_Crank ; If "run" bit of "engine" bit field is clear branch 
                                   ; to CT4_T4_Crank:(engine is cranking so Ign2 (5&10) 
								   ; is not controlled here).
								   
;*****************************************************************************************
; - PT4 - ECT OC4 Ign2(5&10) Control
;*****************************************************************************************

    movb #$10,ECT_TFLG1  ; Clear C4F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset ECT_TCTL1,#$02 ; Set Ch4 output line to 1 on compare bit1
    bset ECT_TCTL1,#$01 ; Set Ch4 output line to 1 on compare bit0
    ldd  ECT_TCNT       ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd1      ; Add "IgnOCadd1" (Delay time from crank signal to energise coil)
    std  ECT_TC4        ; Copy result to Timer IC/OC register 2 (Start OC operation)
                        ; (Will trigger an interrupt after the delay time)(LED off)
	bclr PORTB,#$10         ; Clear "Tachout" Port B bit4 (output high, hardware inverted)
    jmp   StateHandlersDone ; Jump to StateHandlersDone:
	
CT4_T4_Crank:
;*****************************************************************************************
;   We are at 6 degrees BTDC on compression for #3 and we are in crank mode. De-energise 
;   the coil for Ign5 (3&2) on PT7.
;*****************************************************************************************

    bclr PTT,#$80           ; Clear Port T bit 7 (de-energise coil for Ign5 (3&2))
	
;*****************************************************************************************
;   We are at 60 degrees BTDC on compression for #6 and we are in crank mode. Energise 
;   the coil for Ign1 (6&1) on PT3.
;*****************************************************************************************

    bset PTT,#$08           ; Set Port T bit 3 (energise coil for Ign1 (6&1))
    bclr PORTB,#$10         ; Clear "Tachout" Port B bit4 (output high, hardware inverted)
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT1_T5:

;*****************************************************************************************
; - If we are here the crankshaft is at 150 degrees before top dead centre on the 
;   compression/power strokes for #8 cylinder. If we are in run mode start the hardware 
;   timer to delay the coil dwell for spark #8, waste #9.   
;*****************************************************************************************

    brclr engine,run,CT1_T5_Crank ; If "run" bit of "engine" bit field is clear branch 
                                   ; to CT1_T5_Crank:(engine is cranking so Ign3 (8&9) 
								   ; is not controlled here).
								   
;*****************************************************************************************
; - PT5 - ECT OC5 Ign3(8&9) Control
;*****************************************************************************************

    movb #$20,ECT_TFLG1  ; Clear C5F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset ECT_TCTL1,#$08 ; Set Ch5 output line to 1 on compare bit3
    bset ECT_TCTL1,#$04 ; Set Ch5 output line to 1 on compare bit2
    ldd  ECT_TCNT       ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd1      ; Add "IgnOCadd1" (Delay time from crank signal to energise coil)
    std  ECT_TC5        ; Copy result to Timer IC/OC register 2 (Start OC operation)
                        ; (Will trigger an interrupt after the delay time)(LED off)
	jmp   StateHandlersDone ; Jump to StateHandlersDone:
						
CT1_T5_Crank:
;*****************************************************************************************
;   We are at 6 degrees BTDC on compression for #6 and we are in crank mode. De-energise 
;   the coil for Ign1 (6&1) on PT3.
;*****************************************************************************************

    bclr PTT,#$08           ; Clear Port T bit 3 (de-energise coil for Ign1 (6&1))
    jmp   StateHandlersDone ; Jump to StateHandlersDone:

Notch_CT1_T6:

;*****************************************************************************************
; - If we are here the crankshaft is at 6 degrees before top dead centre on the 
;   exhaust/intake strokes for #1 cylinder and 60 degrees before top dead centre on the 
;   exhaust/intake strokes for #1 cylinder. #1 intake valve is just starting to open
;   and #10 intake valve is 54 degrees before it will start to open. Tachout off.    
;*****************************************************************************************

    bset PORTB,#$10          ; Set "Tachout" Port B bit4 (output low, hardware inverted)
    jmp   StateHandlersDone  ; Jump to StateHandlersDone: 
    
Notch_CT1_T7:

;*****************************************************************************************
; - If we are here #10 intake valve is just starting to open and #2 intake valve is 54 
;   degrees after it has started to open. Start the pulse width for injectors 1&10.    
;*****************************************************************************************

    brset engine,FldClr,INJ1FldClr ; If "FldClr" bit of "engine" bit field is set branch 
                                   ; to INJ1FldClr:(don't fire injector)
    jsr  FIRE_INJ1                 ; Jump to FIRE_INJ1 subroutine  

INJ1FldClr:
    brset engine,run,CT1_T7_Done   ; If "run" bit of "engine" bit field is set branch 
                                   ; to CT1_T7_Done:(engine is running so Ign2 
								   ; (5&10) is not controlled here).

;*****************************************************************************************
;   We are at 24 degrees BTDC on compression for #5 and we are in crank mode. Energise 
;   the coil for Ign2 (5&10) on PT4.
;*****************************************************************************************

    bset PTT,#$10  ; Set Port T bit 4 (energise coil for Ign2 (5&10))
	
CT1_T7_Done:
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT1_T8:

;*****************************************************************************************
; - If we are here the crankshaft is at 150 degrees before top dead centre on the 
;   compression/power strokes for #7 cylinder. If we are in run mode start the hardware   
;   timer to delay the coil dwell for spark #7, waste #4. Tachout on.
;*****************************************************************************************

    brclr engine,run,CT1_T8_Crank ; If "run" bit of "engine" bit field is clear branch 
                                   ; to CT1_T8_Crank:(engine is cranking so Ign4 (7&4) 
								   ; is not controlled here).
								   
;*****************************************************************************************
; - PT6 - ECT OC6 Ign4(7&4) Control
;*****************************************************************************************

    movb #$40,ECT_TFLG1  ; Clear C6F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset ECT_TCTL1,#$20 ; Set Ch6 output line to 1 on compare bit5
    bset ECT_TCTL1,#$10 ; Set Ch6 output line to 1 on compare bit4
    ldd  ECT_TCNT       ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd1      ; Add "IgnOCadd1" (Delay time from crank signal to energise coil)
    std  ECT_TC6        ; Copy result to Timer IC/OC register 2 (Start OC operation)
                        ; (Will trigger an interrupt after the delay time)(LED off)
	bclr PORTB,#$10         ; Clear "Tachout" Port B bit4 (output high, hardware inverted)
	jmp   StateHandlersDone ; Jump to StateHandlersDone:
						
CT1_T8_Crank:
;*****************************************************************************************
;   We are at 6 degrees BTDC on compression for #5 and we are in crank mode. De-energise 
;   the coil for Ign2 (5&10) on PT4.
;*****************************************************************************************

    bclr PTT,#$10           ; Clear Port T bit 4 (de-energise coil for Ign2 (5&10))
	
;*****************************************************************************************
;   We are at 60 degrees BTDC on compression for #8 and we are in crank mode. Energise 
;   the coil for Ign3 (8&9) on PT5.
;*****************************************************************************************

    bset PTT,#$20           ; Set Port T bit 5 (energise coil for Ign3 (8&9))
    bclr PORTB,#$10         ; Clear "Tachout" Port B bit4 (output high, hardware inverted)
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT1_T9:

;*****************************************************************************************
; - If we are here the crankshaft is at 150 degrees before top dead centre on the 
;   compression/power strokes for #2 cylinder. If we are in run mode start the hardware 
;   timer to delay the coil dwell for spark #2, waste #3.   
;*****************************************************************************************

    brclr engine,run,CT1_T9_Crank ; If "run" bit of "engine" bit field is clear branch 
                                   ; to CT1_T9_Crank:(engine is cranking so Ign5 (2&3) 
								   ; is not controlled here).
								   
;*****************************************************************************************
; - PT7 - ECT OC7 Ign5(2&3) Control
;*****************************************************************************************

    movb #$80,ECT_TFLG1  ; Clear C7F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired delay from trigger time to energising time.
;*****************************************************************************************

    bset ECT_TCTL1,#$80 ; Set Ch7 output line to 1 on compare bit7
    bset ECT_TCTL1,#$40 ; Set Ch7 output line to 1 on compare bit6
    ldd  ECT_TCNT       ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd1      ; Add "IgnOCadd1" (Delay time from crank signal to energise coil)
    std  ECT_TC7        ; Copy result to Timer IC/OC register 2 (Start OC operation)
                        ; (Will trigger an interrupt after the delay time)(LED off)
	jmp   StateHandlersDone ; Jump to StateHandlersDone:
						
CT1_T9_Crank:
;*****************************************************************************************
;   We are at 6 degrees BTDC on compression for #8 and we are in crank mode. De-energise 
;   the coil for Ign3 (8&9) on PT5.
;*****************************************************************************************

    bclr PTT,#$20           ; Clear Port T bit 5 (de-energise coil for Ign3 (8&9))
    jmp   StateHandlersDone ; Jump to StateHandlersDone: 

Notch_CT1_T10:

;*****************************************************************************************
; - If we are here the crankshaft is at 6 degrees before top dead centre on the 
;   exhaust/intake strokes for #9 cylinder and 60 degrees before top dead centre on the 
;   exhaust/intake strokes for #4 cylinder. #9 intake valve is just starting to open
;   and #4 intake valve is 54 degrees before it will start to open. Tachout off.    
;*****************************************************************************************

    bset PORTB,#$10          ; Set "Tachout" Port B bit4 (output low, hardware inverted)
    
StateHandlersDone:

;*****************************************************************************************
; When the engine first starts to crank the period between CKP triggers can overflow the 
; timer counter. Make sure that we have had at least "MinCKP" triggers so things stabilize 
; before we do any period calculations.
;*****************************************************************************************

    ldaa MinCKP        ; "MinCKP" -> Accu A
	beq  CasPrdCalcs   ; If "MinCKP" = 0 banch to CasPrdCalcs:
    dec  MinCKP        ; Decrement "MinCKP"
    jmp  CASDone       ; Jump to CASDone: (minimum count not met so fall through)
    
CasPrdCalcs:
	bset engine2,IgnRun  ; Set "IgnRun" bit of engine2 bit field (bit5)
	                     ; (OK to get crank periods)

;*****************************************************************************************
; - Get three consecutive rising edge signals for engine RPM and 
;   calculate the period. This period is for one fifth of a revolution (72 degrees). 
;   RPM, Ignition and  Fuel calculations are done in the main loop.                                               
;*****************************************************************************************
;*****************************************************************************************
; - Reload stall counter with compare value. Stall check is done in the main loop every 
;   mSec. "Stallcnt" is decremented every mSec and reloaded at every crank signal.
;*****************************************************************************************
								 
    ldy   #veBins_R     ; Load index register Y with address of first configurable 
                        ; constant on buffer RAM page 1 (vebins)
    ldd   $0352,Y       ; Load Accu A with value in buffer RAM page 1 offset 850 
                        ; "Stallcnt" (stall counter)(offset = 850) 
    std  Stallcnt       ; Copy to "Stallcnt" (no crank or stall condition counter)
                        ; (1mS increments)				 

    brset ICflgs,Ch1_2nd,CAS_2nd ; If "Ch1_2nd" bit of "ICflgs" is set, branch to "CAS_2nd:"
    brset ICflgs,Ch1_3d,CAS_3d   ; If "Ch1_3d" bit of "ICflgs" is set, branch to "CAS_3d:"
    ldd   ECT_TC1                ; Load accu D with value in "ECT_TC1H"
    std   CAS1sttk               ; Copy to "CAS1sttk"
    bset  ICflgs,Ch1_2nd         ; Set "Ch1_2nd" bit of "ICflgs"
    jmp   CASDone                ; Branch to CASDone:
    
CAS_2nd:
    ldd   ECT_TC1         ; Load accu D with value in "ECT_TC1H"
    std   CAS2ndtk        ; Copy to "CAS2ndtk"
    subd  CAS1sttk        ; Subtract (A:B)-(M:M+1)=>A:B "CAS1sttk" from value in "ECT_TC7H"
    std   CASprd1tk       ; Copy result to "CASprd1tk"                                 
    bclr  ICflgs,Ch1_2nd  ; Clear "Ch1_2nd" bit of "ICflgs"
    bset  ICflgs,Ch1_3d   ; Set "Ch1_3d" bit of "ICflgs"
    jmp   CASDone         ; Branch to CASDone:

CAS_3d:
    ldd   ECT_TC1         ; Load accu D with value in "ECT_TC1H"
    subd  CAS2ndtk        ; Subtract (A:B)-(M:M+1)=>A:B "CAS2ndtk" from value in "ECT_TC7H"
    std   CASprd2tk       ; Copy result to "CASprd2tk"
    addd  CASprd1tk       ; (A:B)+(M:M+1)_->A:B "CASprd2tk" + "CASprd1tk" = "CASprdtk"
    bclr  ICflgs,Ch1_3d   ; Clear "Ch1_3d" bit of "ICflgs"
	std   CASprd512       ; Copy result to "CASprd512" (CAS period in 5.12uS resolution)

;******************************************************************************************
; - Convert Crank Angle Sensor period (5.12uS res)to degrees x 10 of rotation (for 1 tenth  
;   of a degree resolution calculations).("Degx10tk512") 
;******************************************************************************************

    ldx   #$0048         ; Decimal 72 -> X
    idiv                 ; (D)/(X)->(X)rem(D) (CASprd512/72)
    tfr   X,D            ; Copy result in "X" to "D"
	ldy   #$000A         ; Decimal 10 -> Accu Y
	emul                 ; (D)*(Y)->Y:D result * 10 = "Degx10tk512"
	std   Degx10tk512    ; Copy result to "Degx10tk512"

;*****************************************************************************************
; - Determine if the engine is cranking or running. The timer is initialized with a 
;   2.56uS time base and the engine status bit field "engine" is cleared on power up.
;   "Spantk" will roll over at ~169 RPM with a 2.56uS base. The engine mode is switched 
;   from crank to run at ~300 RPM which should be at a speed when the engine is definately 
;   running. Engine speed can drop to as low as ~169 RPM before ignition calculations 
;   cannot be done. It is not likely that the engine will continue to run at this speed 
;   and will stall. Stall detection is done in the main loop if the period between crank 
;   sensor signals is greater than ~2 seconds.   
;*****************************************************************************************
;*****************************************************************************************
; - Determine if the engine is cranking or running. The timer is initialized with a 
;   5.12uS time base and the engine status bit field "engine" is cleared on power up.
;   "Spantk" will roll over at ~84 RPM with a 5.12uS base. The engine mode is switched 
;   from crank to run at ~300 RPM which should be at a speed when the engine is definately 
;   running. Engine speed can drop to as low as ~84 RPM before ignition calculations 
;   cannot be done. It is not likely that the engine will continue to run at this speed 
;   and will stall. Stall detection is done in the main loop if the period between crank 
;   sensor signals is greater than ~2 seconds.   
;*****************************************************************************************
	
    brset  engine,run,CASprdOK  ; If "run" bit of "engine" bit field is set branch to 
	                            ; CASDone: (already done so skip over)
                          
;*****************************************************************************************
; - Look up the cranking RPM limit ("crankingRPM_F")(default 300 RPM)
;*****************************************************************************************
                          
    ldy   #veBins_R   ; Load index register Y with address of first configurable 
                      ; constant in RAM page 1 (veBins_R)
    ldx   $034E,Y     ; Load Accu X with value in buffer RAM page 1 (offset 846)($034E)
                      ; ("crankingRPM_F", cranking RPM limit)
					  
;*****************************************************************************************
; - Convert to crank angle sensor period ticks in 5.12uS resolution
;*****************************************************************************************

    ldd  #$C346         ; Load accu D with Lo word of  10 cyl RPMk (5.12uS clock tick)
    ldy  #$0023         ; Load accu Y with Hi word of 10 cyl RPMk (5.12uS clock tick)
    ediv                ; Extended divide (Y:D)/(X)=>Y;Rem=>D "RPMk" / "crankingRPM_F"
                        ; = crank angle sensor period in 2.56uS resolution
					  
;*****************************************************************************************
; - Compare the limit period with the current period
;*****************************************************************************************

    cpy   CASprd512       ; Compare cranking RPM limit period to "CASprd512"
	blo   StillCranking   ; Period is greater than that for "crankingRPM_F" so engine is 
	                      ; still cranking. Branch to StillCranking:
	
SwitchToRun:
    bset  engine,run      ; Set "run" bit of "engine" variable
    bclr  engine,crank    ; Clear "crank" bit of "engine" variable
    bset  PORTB,#$01      ; Set "FuelPump" bit0 on Port B (pump on)
	bset  PORTB,#$02      ; Set "ASDRelay" bit1 on Port B (relay on)
  	bra   CASprdOK        ; Branch to CASprdOK:

StillCranking:
    bclr  engine,run      ; Clear "run" bit of "engine" variable
    bset  engine,crank    ; Set "crank" bit of "engine" variable
	bset  PORTB,#$01      ; Set "FuelPump" bit0 on Port B (pump on)
	bset  PORTB,#$02      ; Set "ASDRelay" bit1 on Port B (relay on)

CASprdOK:    
    bset  ICflgs,RPMcalc  ; Set "RPMcalc" bit of "ICflgs"
    
CASDone:
;******************************************************************************************
; - Rev counter -
;   Used to decrement "ASErev" every revolution  (count down counter for ASE taper)  
;******************************************************************************************

DoRevCntr:
    ldaa  RevCntr        ; Load Accu A with value in "RevCntr"
    cmpa  #$09           ; Compare with decimal 9
    beq   CAS1           ; If equal branch to CAS1: (First CAS signal) 
    cmpa  #$08           ; Compare with decimal 8
    beq   CAS2           ; If equal branch to CAS2: (Second CAS signal) 
    cmpa  #$07           ; Compare with decimal 7
    beq   CAS3           ; If equal branch to CAS3: (Third CAS signal) 
    cmpa  #$06           ; Compare with decimal 6
    beq   CAS4           ; If equal branch to CAS4: (Forth CAS signal) 
    cmpa  #$05           ; Compare with decimal 5
    beq   CAS5           ; If equal branch to CAS5: (Fifth CAS signal) 
    cmpa  #$04           ; Compare with decimal 4
    beq   CAS6           ; If equal branch to CAS6: (Sixth CAS signal) 
    cmpa  #$03           ; Compare with decimal 3
    beq   CAS7           ; If equal branch to CAS7: (Seventh CAS signal) 
    cmpa  #$02           ; Compare with decimal 2
    beq   CAS8           ; If equal branch to CAS8: (Eighth CAS signal) 
    cmpa  #$01           ; Compare with decimal 1
    beq   CAS9           ; If equal branch to CAS9: (Nineth CAS signal) 
    cmpa  #$00           ; Compare with zero
    beq   CAS10          ; If equal branch to CAS10: (Tenth CAS signal) 

CAS1:

;*****************************************************************************************
; - if ASE is in progress, decrement the counter (ASEcnt)
;*****************************************************************************************

    brset engine,ASEon,DecASECnt ; If "ASEon" bit of "engine" bit field is set, branch to 
                           ; DecASECnt:
    bra  NoDecASECnt       ; Branch to NoDecASECnt:   

DecASECnt:                           
    decw   ASEcnt          ; Decrement "ASEcnt"(countdown value for ASE taper)
                           ; (starts with the lookup value of "ASErev")

NoDecASECnt:                           
    dec   RevCntr          ; Decrement "RevCntr"(now eight)
    bra   RevCntrDone      ; Branch to RevCntrDone:  

CAS2:
    dec   RevCntr          ; Decrement "RevCntr"(now seven)
    bra   RevCntrDone      ; Branch to RevCntrDone: 

CAS3:
    dec   RevCntr          ; Decrement "RevCntr"(now six)
    bra   RevCntrDone      ; Branch to RevCntrDone:

CAS4:
    dec   RevCntr          ; Decrement "RevCntr"(now five)
    bra   RevCntrDone      ; Branch to RevCntrDone: 

CAS5:
    dec   RevCntr          ; Decrement "RevCntr"(now four)
    bra   RevCntrDone      ; Branch to RevCntrDone: 

CAS6:
    dec   RevCntr          ; Decrement "RevCntr"(now three)
    bra   RevCntrDone      ; Branch to RevCntrDone: 

CAS7:
    dec   RevCntr          ; Decrement "RevCntr"(now two)
    bra   RevCntrDone      ; Branch to RevCntrDone: 

CAS8:
    dec   RevCntr          ; Decrement "RevCntr"(now one)
    bra   RevCntrDone      ; Branch to RevCntrDone: 

CAS9:
    dec   RevCntr          ; Decrement "RevCntr"(now zero)
    bra   RevCntrDone      ; Branch to RevCntrDone:     

CAS10:
    bset  ICflgs,RevMarker ; Set "RevMarker" flag of "ICflags" bit field
    movb  #$09,RevCntr     ; Load "RevCntr" with decimal 9(We have 10 CAS signals so the 
                           ; crank has turned 1 revolution, reset the counter to nine)

RevCntrDone:

    rti                     ; Return from Crank Sensor ISR_ECT_TC1 interrupt
    
;*****************************************************************************************

;*****************************************************************************************
; - ECT ch2 Interrupt Service Routine (for VSS calculations)
;*****************************************************************************************

    XDEF ISR_ECT_TC2     ; Required for CW
        
ISR_ECT_TC2:
    movb #$04,ECT_TFLG1  ; Clear C2F interrupt flag
        
;*****************************************************************************************
; - Get two consecutive rising edge signals for vehicle speed and 
;   calculate the period. KPH calculations are done in the main loop 
;*****************************************************************************************

    brset ICflgs,Ch2alt,VSS2 ; If "Ch2alt" bit of "ICflgs" is set, branch to "VSS2:"
    ldd  ECT_TC2Hi           ; Load accu D with value in "ECT_TC2Hi"
    std  VSS1st              ; Copy to "VSS1st"
    bset ICflgs,Ch2alt       ; Set "Ch2alt" bit of "ICflgs"
    movw #$014A,VSScnt       ; Decimal 330 -> "VSScnt" (Counter to detect vehicle stopped 
                             ; condition, decremented every mS)
    bra  ECT2_ISR_Done       ; Branch to "ECT2_ISR_Done:"

VSS2:
    ldd  ECT_TC2Hi      ; Load accu D with value in "ECT_TC2Hi"
    subd VSS1st         ; Subtract (A:B)-(M:M+1)=>A:B "VSS1st" from value in "ECT_TC2H"
    std   VSSprd512     ; Copy result to "VSSprd512" (VSS period in 5.12uS resolution)
    movw #$014A,VSScnt  ; Decimal 330 -> "VSScnt" (Counter to detect vehicle stopped 
                        ; condition, decremented every mS)    
    bclr ICflgs,Ch2alt  ; Clear "Ch2alt" bit of "ICflgs"
    bset ICflgs,KpHcalc ; Set "KpHcalc" bit of "ICflgs"

ECT2_ISR_Done: 
    rti                  ; Return from ISR_ECT_TC2 Interrupt
    
;*****************************************************************************************

;*****************************************************************************************
; - ECT ch3 Interrupt Service Routine for Ign1(1&6) control
;*****************************************************************************************

    XDEF ISR_ECT_TC3     ; Required for CW
        
ISR_ECT_TC3:
    movb #$08,ECT_TFLG1  ; Clear C3F interrupt flag

;*****************************************************************************************
; - Set the output compare value for desired on time and clear the interrupt
;*****************************************************************************************

    bset ECT_TCTL2,#$80    ; Clear Ch3 output line to zero on compare bit7
    bclr ECT_TCTL2,#$40    ; Clear Ch3 output line to zero on compare bit6
    ldd  ECT_TCNT          ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd2         ; Add "IgnOCadd2" (dwell time)
    std  ECT_TC3           ; Copy result to Timer IC/OC register 0 (Start OC operation)
                           ; (coil on for dwell time)(LED on)
    rti                    ; Return from ISR_ECT_TC3 Interrupt
    
;*****************************************************************************************

;*****************************************************************************************
; - ECT ch4 Interrupt Service Routine for Ign2(10&5) control
;*****************************************************************************************

    XDEF ISR_ECT_TC4     ; Required for CW
        
ISR_ECT_TC4:
    movb #$10,ECT_TFLG1  ; Clear C4F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired on time and clear the interrupt
;*****************************************************************************************

    bset ECT_TCTL1,#$02    ; Clear Ch4 output line to zero on compare bit1
    bclr ECT_TCTL1,#$01    ; Clear Ch4 output line to zero on compare bit0
    ldd  ECT_TCNT          ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd2         ; Add "IgnOCadd2" (dwell time))
    std  ECT_TC4           ; Copy result to Timer IC/OC register 2(Start OC operation)
                           ; (coil on for dwell time)(LED on)
    rti                    ; Return from ISR_ECT_TC4 Interrupt
    
;*****************************************************************************************

;*****************************************************************************************
; - ECT ch5 Interrupt Service Routine for Ign3(9&8) control
;*****************************************************************************************

    XDEF ISR_ECT_TC5     ; Required for CW
        
ISR_ECT_TC5:
    movb #$20,ECT_TFLG1  ; Clear C5F interrupt flag
     
;*****************************************************************************************
; - Set the output compare value for desired on time and clear the interrupt
;*****************************************************************************************

    bset ECT_TCTL1,#$08    ; Clear Ch5 output line to zero on compare bit3
    bclr ECT_TCTL1,#$04    ; Clear Ch5 output line to zero on compare bit2
    ldd  ECT_TCNT          ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd2         ; Add "IgnOCadd2" (dwell time))
    std  ECT_TC5           ; Copy result to Timer IC/OC register 2(Start OC operation)
                           ; (coil on for dwell time)(LED on)
    rti                    ; Return from ISR_ECT_TC5 Interrupt
    
;*****************************************************************************************

;*****************************************************************************************
; - ECT ch6 Interrupt Service Routine for Ign4(4&7) control
;*****************************************************************************************

    XDEF ISR_ECT_TC6     ; Required for CW
        
ISR_ECT_TC6:
    movb #$40,ECT_TFLG1  ; Clear C6F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired on time and clear the interrupt
;*****************************************************************************************

    bset ECT_TCTL1,#$20    ; Clear Ch6 output line to zero on compare bit5
    bclr ECT_TCTL1,#$10    ; Clear Ch6 output line to zero on compare bit4
    ldd  ECT_TCNT          ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd2         ; Add "IgnOCadd2" (dwell time))
    std  ECT_TC6           ; Copy result to Timer IC/OC register 2(Start OC operation)
                           ; (coil on for dwell time)(LED on)
    rti                    ; Return from ISR_ECT_TC6 Interrupt
    
;*****************************************************************************************

;*****************************************************************************************
; - ECT ch7 Interrupt Service Routine for Ign5(3&2) control
;*****************************************************************************************

    XDEF ISR_ECT_TC7     ; Required for CW
        
ISR_ECT_TC7:
    movb #$80,ECT_TFLG1  ; Clear C7F interrupt flag
    
;*****************************************************************************************
; - Set the output compare value for desired on time and clear the interrupt
;*****************************************************************************************

    bset ECT_TCTL1,#$80    ; Clear Ch7 output line to zero on compare bit7
    bclr ECT_TCTL1,#$40    ; Clear Ch7 output line to zero on compare bit6
    ldd  ECT_TCNT          ; Contents of Timer Count Register-> Accu D
    addd IgnOCadd2         ; Add "IgnOCadd2" (dwell time))
    std  ECT_TC7           ; Copy result to Timer IC/OC register 2(Start OC operation)
                           ; (coil on for dwell time)(LED on)
    rti                    ; Return from ISR_ECT_TC7 Interrupt
    
;*****************************************************************************************


;*****************************************************************************************
;                                  TIM TIMER ISRs
;*****************************************************************************************
;   - TIM ISRs
;       - TIM ch0 injection 1
;       - TIM ch1 injection 2
;       - TIM ch2 injection 3
;       - TIM ch3 injection 4
;       - TIM ch4 injection 5
;
;*****************************************************************************************
; - In the initialization section, Port T PT3,4,5,6,7 and all Port P pins are set as outputs 
;   initial setting low. To control both the ignition and injector drivers two interrupts  
;   are required for each ignition or injection event. At the appropriate crank angle and  
;   cam phase an interrupt is triggered. In this ISR routine the channel output compare 
;   register is loaded with the delay value from trigger time to the time desired to  
;   energise the coil or injector and the channel interrupt is enabled. When the output  
;   compare matches, the pin is commanded high and the timer channel interrupt is triggered.  
;   The output compare register is then loaded with the value to keep the coil or injector 
;   energised, and the channel interrupt is disabled. When the output compare matches, the 
;   pin is commanded low to fire the coil or de-energise the injector.  
;*****************************************************************************************

;*****************************************************************************************
; - TIM ch0 Interrupt Service Routine for Inj1(1&10) control)
;*****************************************************************************************
;*****************************************************************************************
; - Set the output compare value for desired on time and clear the interrupt
;*****************************************************************************************

        XDEF ISR_TIM_TC0   ; Required for CW
        
ISR_TIM_TC0:
    movb #$01,TIM_TFLG1    ; Clear C0F interrupt flag                          
    bset TIM_TCTL2,#$02    ; Clear Ch0 output line to zero on compare bit1
    bclr TIM_TCTL2,#$01    ; Clear Ch0 output line to zero on compare bit0
    ldd  TIM_TCNT          ; Contents of Timer Count Register-> Accu D
    addd InjOCadd2         ; Add "InjOCadd2" (injector pulse width)
    std  TIM_TC0           ; Copy result to Timer IC/OC register 1 (Start OC operation)
    rti                    ; Return from ISR_TIM_TC0 Interrupt    

;*****************************************************************************************
; - TIM ch1 Interrupt Service Routine for Inj2 (9&4) control)
;*****************************************************************************************
;*****************************************************************************************
; - Set the output compare value for desired on time and clear the interrupt
;*****************************************************************************************

        XDEF ISR_TIM_TC1   ; Required for CW
        
ISR_TIM_TC1:
    movb #$02,TIM_TFLG1    ; Clear C1F interrupt flag
    bset TIM_TCTL2,#$08    ; Clear Ch1 output line to zero on compare bit3
    bclr TIM_TCTL2,#$04    ; Clear Ch1 output line to zero on compare bit2
    ldd  TIM_TCNT          ; Contents of Timer Count Register-> Accu D
    addd InjOCadd2         ; Add "InjOCadd2" (injector pulse width)
    std  TIM_TC1           ; Copy result to Timer IC/OC register 1 (Start OC operation)
    rti                    ; Return from ISR_TIM_TC1 Interrupt    

;*****************************************************************************************
; - TIM ch2 Interrupt Service Routine for Inj3 (3&6) control)
;*****************************************************************************************
;*****************************************************************************************
; - Set the output compare value for desired on time and clear the interrupt
;*****************************************************************************************

        XDEF ISR_TIM_TC2   ; Required for CW
        
ISR_TIM_TC2:
    movb #$04,TIM_TFLG1    ; Clear C2F interrupt flag 
    bset TIM_TCTL2,#$20    ; Clear Ch2 output line to zero on compare bit5
    bclr TIM_TCTL2,#$10    ; Clear Ch2 output line to zero on compare bit4
    ldd  TIM_TCNT          ; Contents of Timer Count Register-> Accu D
    addd InjOCadd2         ; Add "InjOCadd2" (injector pulse width)
    std  TIM_TC2           ; Copy result to Timer IC/OC register 2 (Start OC operation)
    rti                    ; Return from ISR_TIM_TC2 Interrupt    

;*****************************************************************************************
; - TIM ch3 Interrupt Service Routine for Inj4)(5&8) control)
;*****************************************************************************************
;*****************************************************************************************
; - Set the output compare value for desired on time and clear the interrupt
;*****************************************************************************************

        XDEF ISR_TIM_TC3   ; Required for CW
        
ISR_TIM_TC3:
    movb #$08,TIM_TFLG1    ; Clear C3F interrupt flag
    bset TIM_TCTL2,#$80    ; Clear Ch3 output line to zero on compare bit7
    bclr TIM_TCTL2,#$40    ; Clear Ch3 output line to zero on compare bit6
    ldd  TIM_TCNT          ; Contents of Timer Count Register-> Accu D
    addd InjOCadd2         ; Add "InjOCadd2" (injector pulse width)
    std  TIM_TC3           ; Copy result to Timer IC/OC register 3 (Start OC operation)
    rti                    ; Return from ISR_TIM_TC3 Interrupt

;*****************************************************************************************
; - TIM ch4 Interrupt Service Routine for Inj5(7&2) control)
;*****************************************************************************************
;*****************************************************************************************
; - Set the output compare value for desired on time and clear the interrupt
;*****************************************************************************************

        XDEF ISR_TIM_TC4   ; Required for CW
        
ISR_TIM_TC4:
    movb #$10,TIM_TFLG1    ; Clear C4F interrupt flag
    bset TIM_TCTL1,#$02    ; Clear Ch4 output line to zero on compare bit1
    bclr TIM_TCTL1,#$01    ; Clear Ch4 output line to zero on compare bit0
    ldd  TIM_TCNT          ; Contents of Timer Count Register-> Accu D
    addd InjOCadd2         ; Add "InjOCadd2" (injector pulse width)
    std  TIM_TC4           ; Copy result to Timer IC/OC register 4(Start OC operation)
    rti                    ; Return from ISR_TIM_TC4 Interrupt
    
;*****************************************************************************************

;***************************************************************************************** 

        XDEF    ISR_TIM_TC5

ISR_TIM_TC5:
     movb #$20,TIM_TFLG1   ; Clear C5F interrupt flag 
     rti                   ; Return from ISR_TIM_TC5 Interrupt
        
;*****************************************************************************************        
;                                     TABLES                                                                          
;*****************************************************************************************
; - Tables
;   - Tuner Studio Signature
;   - Tuner Studio RevNum
;   - State machine lookup
;   - DodgeTherm thermistor values
;
;*****************************************************************************************
;*****************************************************************************************
; Tuner Studio requests for Signature and RevNum
;*****************************************************************************************

Signature:     
    fcc "MS2Extra comms342h2"
;        1234567890123456789   ; 19 bytes
;                              ; This must remain the same in order for both TS and SD 
                               ; to communicate 
RevNum:
     fcc "BPEM488CW 07 03 2022                                     "
;         123456789012345678901234567890123456789012345678901234567  ; 57 bytes
;                              ; This should be changed with each code revision but 
                               ; string length must stay the same
                               
;*****************************************************************************************
; Lookup table for Dodge V10 Cam/Crank decoding
;*****************************************************************************************

StateLookup:
     dc.b     $0B,$0A,$0C,$46,$0D,$01,$0E,$02,$0F,$03,$10,$04,$11,$05,$12,$06
     dc.b     $13,$07,$14,$08,$15,$09,$16,$17,$46,$7C,$46,$7C,$46,$7C,$46,$7C
     dc.b     $18,$7C,$19,$7C,$1B,$1A,$1C,$1D,$1F,$1E,$21,$20,$46,$7D,$46,$22
     dc.b     $46,$7D,$46,$7D,$46,$23,$46,$7D,$46,$7D,$46,$24,$46,$25,$46,$7D
     dc.b     $46,$26,$46,$7D,$46,$27,$46,$28,$46,$29,$46,$2A,$46,$2B,$46,$2C
     dc.b     $46,$2D,$46,$2E,$46,$2F,$46,$30,$32,$31,$46,$33,$46,$34,$46,$35
     dc.b     $46,$36,$46,$37,$46,$7F,$46,$38,$46,$39,$46,$3A,$46,$3B,$3C,$7E
     dc.b     $3D,$7E,$3E,$7E,$3F,$7E,$40,$7E,$41,$46,$42,$46,$43,$46,$44,$46
     dc.b     $45,$46,$46,$7D,$46,$7D,$46,$7D,$46,$7D,$46,$7D,$46,$46,$46,$46
     dc.b     $46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46  
     dc.b     $46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46
     dc.b     $46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46
     dc.b     $46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46
     dc.b     $46,$69,$46,$6A,$46,$6B,$46,$6C,$6D,$46,$6E,$46,$46,$7D,$46,$70
     dc.b     $46,$71,$72,$46,$46,$7F,$46,$7C,$73,$46,$46,$74,$46,$75,$46,$7E
     dc.b     $46,$77,$46,$78,$46,$79,$46,$7A,$46,$68,$46,$6F,$46,$76,$46,$7B
     
;*****************************************************************************************
     
; Dodge thermistor table for coolant and manifold air temperature
; These are signed words for Tuner Studio to convert to signed degrees farenheit										
; 5 volt, 10 bit ADC, Bias resistor = 6980R										
; 0C, 32F    = 32660R								
; 30C, 86F   = 8060R								
; 90C, 194F  = 915R
								
DodgeThermistor:  
;        Hex  DgFx10   Deg F  Deg C  ADC  	Vout    Ohms	
	dc.w	$0640	;	1600	160.00	71.11   0	  	0.000	Default to 160F (sensor failure)
	dc.w	$1A56	;	6742	674.22	356.79	1	  	0.005	6.987	
	dc.w	$1636	;	5686	568.58	298.10	2	  	0.010	13.998	
	dc.w	$141F	;	5151	515.07	268.37	3	  	0.015	21.03	
	dc.w	$12C5	;	4805	480.50	249.17	4	  	0.020	28.032	
	dc.w	$11F5	;	4597	459.68	237.60	5	  	0.024	33.666	
	dc.w	$1126	;	4390	438.99	266.10	6	  	0.029	40.72	
	dc.w	$107F	;	4223	422.26	216.81	7	  	0.034	47.789	
	dc.w	$0FF3	;	4083	408.29	209.05	8	  	0.039	54.872	
	dc.w	$0F7B	;	3963	396.34	202.41	9	  	0.044	61.969	
	dc.w	$0F13	;	3859	385.93	196.63	10		0.049	69.081	
	dc.w	$0EB7	;	3767	376.73	191.52	11		0.054	76.207	
	dc.w	$0E6A	;	3690	368.50	186.95	12		0.059	83.348	
	dc.w	$0E29	;	3625	362.50	183.61	13		0.063	89.07	
	dc.w	$0DE4	;	3556	355.61	179.70	14		0.068	96.237	
	dc.w	$0DA5	;	3493	349.31	176.78	15		0.073	103.418	
	dc.w	$0D6B	;	3435	343.49	173.05	16		0.078	110.614	
	dc.w	$0D35	;	3381	338.11	170.06	17		0.083	117.824	
	dc.w	$0D03	;	3331	333.09	167.27	18		0.088	125.049	
	dc.w	$0D9C	;	3484	348.41	164.67	19		0.093	132.289	
	dc.w	$0CA8	;	3240	324.01	162.23	20		0.098	139.543	
	dc.w	$0C7F	;	3199	319.87	159.93	21		0.103	146.812	
	dc.w	$0C5F	;	3167	316.73	158.18	22		0.107	152.638	
	dc.w	$0C3A	;	3130	312.99	156.10	23		0.112	159.935	
	dc.w	$0C16	;	3094	309.44	154.13	24		0.117	167.246	
	dc.w	$0BF5	;	3061	306.06	152.26	25		0.122	174.572
	dc.w	$0BD4	;	3028	302.84	150.47	26		0.127	181.913
	dc.w	$0BB6	;	2998	299.77	148.76	27		0.132	189.269
	dc.w	$0B98	;	2968	296.83	147.13	28		0.137	196.640
	dc.w	$0B7C	;	2940	294.02	145.57	29		0.142	204.026
	dc.w	$0B64	;	2916	291.85	144.36	30		0.146	209.946
	dc.w	$0B4C	;	2892	289.23	142.90	31		0.151	217.360
	dc.w	$0B34	;	2868	286.76	141.54	32		0.156	224.789
	dc.w	$0B1B	;	2843	284.28	140.17	33		0.161	232.234
	dc.w	$0B03	;	2819	281.94	138.86	34		0.166	239.694
	dc.w	$0AED	;	2797	279.68	137.6 	35		0.171	247.169
	dc.w	$0AD7	;	2775	277.49	136.39	36		0.176	254.660
	dc.w	$0AC2	;	2754	275.38	135.21	37		0.181	262.166
	dc.w	$0AAD	;	2733	273.33	134.07	38		0.186	269.688
	dc.w	$0A9D	;	2717	271.74	133.19	39		0.190	275.717
	dc.w	$0A8A	;	2698	269.80	132.11	40		0.195	283.267
	dc.w	$0A77	;	2679	267.92	131.07	41		0.200	290.833
	dc.w	$0A65	;	2661	266.09	130.05	42		0.205	298.415
	dc.w	$0A53	;	2643	264.31	129.06	43		0.210	306.013
	dc.w	$0A42	;	2626	262.58	128.10	44		0.215	313.626
	dc.w	$0A31	;	2609	260.89	127.16	45		0.220	321.255
	dc.w	$0A21	;	2593	259.25	126.25	46		0.225	328.901
	dc.w	$0A14	;	2580	257.97	2125.54	47		0.229	335.028
	dc.w	$0A04	;	2564	256.40	124.67	48		0.234	342.702
	dc.w	$09F5	;	2549	254.87	123.82	49		0.239	350.393
	dc.w	$09E6	;	2534	253.37	122.99	50		0.244	358.099
	dc.w	$09D7	;	2519	251.91	122.17	51		0.249	365.822
	dc.w	$09C9	;	2505	250.48	121.38	52		0.254	373.561
	dc.w	$09BB	;	2491	249.09	120.60	53		0.259	381.316
	dc.w	$09AD	;	2477	247.72	119.85	54		0.264	289.088
	dc.w	$09A0	;	2464	246.39	119.10	55		0.269	396.876
	dc.w	$0995	;	2453	245.34	118.52	56		0.273	403.118
	dc.w	$0989	;	2441	244.05	117.80	57		0.278	410.936
	dc.w	$097C	;	2428	242.79	117.10	58		0.283	418.770
	dc.w	$0970	;	2416	241.55	116.42	59		0.288	426.621
	dc.w	$0963	;	2403	240.34	115.74	60		0.293	434.489
	dc.w	$0958	;	2392	239.15	115.08	61		0.298	442.373
	dc.w	$094C	;	2380	237.98	114.43	62		0.303	450.278
	dc.w	$0940	;	2368	236.83	113.80	63		0.308	458.193
	dc.w	$0935	;	2357	235.71	113.17	64		0.313	466.128
	dc.w	$092C	;	2348	234.82	112.68	65		0.317	472.488
	dc.w	$0921	;	2337	233.73	112.07	66		0.322	480.453
	dc.w	$0917	;	2327	232.66	111.48	67		0.327	488.436
	dc.w	$090C	;	2316	231.60	110.89	68		0.332	496.435
	dc.w	$0902	;	2306	230.57	110.36	69		0.337	504.452
	dc.w	$08F8	;	2296	229.55	109.75	70		0.342	512.486
	dc.w	$08EE	;	2286	228.55	109.19	71		0.347	520.537
	dc.w	$08E4	;	2276	227.56	108.64	72		0.352	528.606
	dc.w	$08DB	;	2267	226.78	108.21	73		0.356	535.073
	dc.w	$08D2	;	2258	225.82	107.68	74		0.361	543.173
	dc.w	$08C9	;	2249	224.88	107.15	75		0.366	551.290
	dc.w	$08C0	;	2240	223.95	106.64	76		0.371	559.425
	dc.w	$08B6	;	2230	223.03	106.13	77		0.376	567.578
	dc.w	$08AD	;	2221	222.13	105.63	78		0.381	575.748
	dc.w	$08A4	;	2212	221.24	105.13	79		0.386	583.936
	dc.w	$089C	;	2204	220.36	104.64	80		0.391	592.141
	dc.w	$0893	;	2195	219.49	104.16	81		0.396	600.365
	dc.w	$088C	;	2188	218.81	103.78	82		0.400	606.957
	dc.w	$0884	;	2180	217.97	103.31	83		0.405	615.212
	dc.w	$087B	;	2171	217.13	102.85	84		0.410	623.486
	dc.w	$0873	;	2163	216.31	102.40	85		0.415	631.778
	dc.w	$086B	;	2155	215.50	101.95	86		0.420	640.087
	dc.w	$0863	;	2147	214.70	101.50	87		0.425	648.415
	dc.w	$085B	;	2139	213.91	101.06	88		0.430	656.761
	dc.w	$0853   ;	2131	213.13	100.63	89		0.435	665.126
	dc.w	$084D	;	2125	212.51	100.29	90		0.439	671.831
	dc.w	$0846	;	2118	211.75	99.86	91		0.444	680.228
	dc.w	$083E	;	2110	211.00	99.44	92		0.449	688.644
	dc.w	$0837	;	2103	210.25	99.03	93		0.454	697.079
	dc.w	$082F	;	2095	209.52	98.62	94		0.459	705.532
	dc.w	$0828	;	2088	208.79	98.22	95		0.464	714.004
	dc.w	$0820	;	2080	208.07	97.82	96		0.469	722.494
	dc.w	$081A	;	2074	207.36	97.42  	97		0.474	731.003
	dc.w	$0813	;	2067	206.66	97.03 	98		0.479	739.531
	dc.w	$080D	;	2061	206.10	96.72 	99		0.483	746.367
	dc.w	$0806	;	2054	205.41	96.34	100		0.488	754.929
	dc.w	$07FF	;	2047	204.73	95.96	101		0.493	763.510
	dc.w	$07F9	;	2041	204.06	95.59 	102		0.498	772.110
	dc.w	$07F2	;	2034	203.39	95.22 	103		0.503	780.729
	dc.w	$07EB	;	2027	202.73	94.85 	104		0.508	789.386
	dc.w	$07E5	;	2021	202.08	94.49 	105		0.513	798.025
	dc.w	$07DE	;	2014	201.43	94.13 	106		0.518	806.702
	dc.w	$07D9	;	2009	200.92	93.85 	107		0.522	813.658
	dc.w	$07D3	;	2003	200.29	93.49 	108		0.527	822.370
	dc.w	$07CD	;	1997	199.66	93.15 	109		0.532	831.101
	dc.w	$07C6	;	1990	199.04	92.80 	110		0.537	839.852
	dc.w	$07C0	;	1984	198.43	92.46 	111		0.542	848.623
	dc.w	$07BA	;	1978	197.82	92.12 	112		0.547	857.413
	dc.w	$07B4	;	1972	197.21	91.79 	113		0.552	866.223
	dc.w	$07AE	;	1966	196.62	91.45 	114		0.557	875.053
	dc.w	$07A8	;	1960	196.03	91.13 	115		0.562	883.903
	dc.w	$07A4	;	1956	195.56	90.86 	116		0.566	890.997
	dc.w	$079E	;	1950	194.97	90.54 	117		0.571	899.883
	dc.w	$0798	;	1944	194.40	90.22 	118		0.576	908.788
	dc.w	$0792	;	1938	193.83	89.90 	119		0.581	917.714
	dc.w	$078D	;	1933	193.26	89.59 	120		0.586	926.661
	dc.w	$0787	;	1927	192.70	89.28 	121		0.591	935.627
	dc.w	$0781	;	1921	192.14	88.97 	122		0.596	944.614
	dc.w	$077C	;	1916	191.59	88.66 	123		0.601	953.621
	dc.w	$0777	;	1911	191.05	88.36 	124		0.605	962.649
	dc.w	$0772	;	1906	190.61	88.12 	125		0.610	969.886
	dc.w	$076D	;	1901	190.08	87.82 	126		0.615	978.951
	dc.w	$0767	;	1895	189.54	87.52 	127		0.620	988.037
	dc.w	$0762	;	1890	189.01	87.23 	128		0.625	997.143
	dc.w	$075D	;	1885	188.49	86.94 	129		0.630	1006.27
	dc.w	$0758	;	1880	187.97	86.65 	130		0.635	1015.418
	dc.w	$0753	;	1875	187.45	86.36 	131		0.640	1024.587
	dc.w	$074D	;	1869	186.94	86.08 	132		0.645	1033.777
	dc.w	$0749	;	1865	186.53	85.85 	133		0.649	1041.145
	dc.w	$0744	;	1860	186.03	85.57 	134		0.654	1050.373
	dc.w	$073F	;	1855	185.53	85.29 	135		0.659	1059.622
	dc.w	$073A	;	1850	185.03	85.02 	136		0.664	1068.893
	dc.w	$0735	;	1845	184.54	84.75 	137		0.669	1078.185
	dc.w	$0731	;	1841	184.05	84.47 	138		0.674	1087.499
	dc.w	$072C	;	1836	183.57	84.20 	139		0.679	1096.834
	dc.w	$0727	;	1831	183.09	83.94 	140		0.684	1106.191
	dc.w	$0723	;	1827	182.70	83.72 	141		0.688	1113.692
	dc.w	$071E	;	1822	182.23	83.46 	142		0.693	1123.088
	dc.w	$071A	;	1818	181.76	83.20 	143		0.698	1132.506
	dc.w	$0715	;	1813	181.29	82.94 	144		0.703	1141.946
	dc.w	$0710	;	1808	180.82	82.68 	145		0.708	1151.407
	dc.w	$070C	;	1804	180.36	82.42 	146		0.713	1160.891
	dc.w	$0707	;	1799	179.90	82.17 	147		0.718	1170.397
	dc.w	$0703	;	1795	179.45	81.92 	148		0.723	1179.925
	dc.w	$06FE	;	1790	179.00	81.67 	149		0.728	1189.476
	dc.w	$06FA	;	1786	178.64	81.47 	150		0.732	1197.132
	dc.w	$06F6	;	1782	178.19	81.22 	151		0.737	1206.723
	dc.w	$06F2	;	1778	177.75	80.97 	152		0.742	1216.336
	dc.w	$06ED	;	1773	177.31	80.73 	153		0.747	1225.972
	dc.w	$06E9	;	1769	176.87	80.49 	154		0.752	1235.631
	dc.w	$06E4	;	1764	176.44	80.24 	155		0.757	1245.312
	dc.w	$06E0	;	1760	176.01	80.00 	156		0.762	1255.017
	dc.w	$06DC	;	1756	175.58	79.77 	157		0.767	1264.744
	dc.w	$06D8	;	1752	175.24	79.58 	158		0.771	1272.542
	dc.w	$06D4	;	1748	174.82	79.34 	159		0.776	1282.311
	dc.w	$06D0	;	1744	174.40	79.11 	160		0.781	1292.102
	dc.w	$06CC	;	1740	173.98	78.88 	161		0.786	1301.917
	dc.w	$06C8	;	1736	173.56	78.65 	162		0.791	1311.756
	dc.w	$06C4	;	1732	173.15	78.42 	163		0.796	1321.618
	dc.w	$06BF	;	1727	172.74	78.19 	164		0.801	1331.503
	dc.w	$06BB	;	1723	172.33	77.96 	165		0.806	1341.412
	dc.w	$06B7	;	1719	171.93	77.73 	166		0.811	1351.344
	dc.w	$06B4	;	1716	171.61	77.56 	167		0.815	1359.307
	dc.w	$06B0	;	1712	171.20	77.34 	168		0.820	1369.282
	dc.w	$06AC	;	1708	170.81	77.11 	169		0.825	1379.281
	dc.w	$06A8	;	1704	170.41	76.89 	170		0.830	1389.305
	dc.w	$06A4	;	1700	170.02	76.68 	171		0.835	1399.352
	dc.w	$06A0	;	1696	169.63	76.46 	172		0.840	1409.423
	dc.w	$069C	;	1692	169.24	76.24 	173		0.845	1419.519
	dc.w	$0699	;	1689	168.85	76.03 	174		0.850	1429.639
	dc.w	$0695	;	1685	168.54	75.86 	175		0.854	1437.752
	dc.w	$0692	;	1682	168.16	75.65 	176		0.859	1447.916
	dc.w	$068E	;	1678	167.78	75.43 	177		0.864	1458.104
	dc.w	$068A	;	1674	167.40	75.22 	178		0.869	1468.318
	dc.w	$0686	;	1670	167.03	75.05 	179		0.874	1478.556
	dc.w	$0683	;	1667	166.65	74.81 	180		0.879	1488.818
	dc.w	$067F	;	1663	166.28	74.60 	181		0.884	1499.106
	dc.w	$067D	;	1661	166.09	74.49 	182		0.889	1504.419
	dc.w	$0677	;	1655	165.54	74.19 	183		0.894	1519.756
	dc.w	$0675	;	1653	165.25	74.03 	184		0.898	1528.045
	dc.w	$0671	;	1649	164.89	73.83 	185		0.903	1538.428
	dc.w	$066D	;	1645	164.52	73.63 	186		0.908	1548.837
	dc.w	$066A	;	1642	164.16	73.42 	187		0.913	1559.271
	dc.w	$0666	;	1638	163.81	73.23 	188		0.918	1569.731
	dc.w	$0663	;	1635	163.45	73.03 	189		0.923	1580.216
	dc.w	$065F	;	1631	163.09	72.98 	190		0.928	1590.727
	dc.w	$065B	;	1627	162.74	72.63 	191		0.933	1601.264
	dc.w	$0658	;	1624	162.39	72.44 	192		0.938	1611.827
	dc.w	$0655	;	1621	162.11	72.28 	193		0.942	1620.296
	dc.w	$0652	;	1618	161.76	72.09 	194		0.947	1630.906
	dc.w	$064E	;	1614	161.42	71.90 	195		0.952	1641.542
	dc.w	$064B	;	1611	161.07	71.71 	196		0.957	1652.204
	dc.w	$0647	;	1607	160.73	71.52 	197		0.962	1662.893
	dc.w	$0644	;	1604	160.39	71.33 	198		0.967	1673.608
	dc.w	$0641	;	1601	160.16	71.14 	199		0.972	1684.350
	dc.w	$063D	;	1597	159.71	70.95 	200		0.977	1695.118
	dc.w	$063A	;	1594	159.44	70.80 	201		0.981	1703.752
	dc.w	$0637	;	1591	159.11	70.62 	202		0.986	1714.569
	dc.w	$0634	;	1588	158.78	70.43 	203		0.991	1725.413
	dc.w	$0630	;	1584	158.44	70.25 	204		0.996	1736.284
	dc.w	$062D	;	1581	158.11	70.06 	205		1.001	1747.182
	dc.w	$062A	;	1578	157.79	69.88 	206		1.006	1758.107
	dc.w	$0627	;	1575	157.46	69.70 	207		1.011	1769.06
	dc.w	$0623	;	1571	157.13	69.52 	208		1.016	1780.04
	dc.w	$0620	;	1568	156.81	69.34 	209		1.021	1791.048
	dc.w	$061E	;	1566	156.55	69.20 	210		1.025	1799.874
	dc.w	$061A	;	1562	156.23	69.02 	211		1.030	1810.932
	dc.w	$0617	;	1559	155.91	68.84 	212		1.035	1822.018
	dc.w	$0614	;	1556	155.59	68.66 	213		1.040	1833.131
	dc.w	$0611	;	1553	155.28	68.49 	214		1.045	1844.273
	dc.w	$060E	;	1550	154.96	68.31 	215		1.050	1855.443
	dc.w	$060B	;	1547	154.65	68.14 	216		1.055	1866.641
	dc.w	$0607	;	1543	154.33	67.96 	217		1.060	1877.868
	dc.w	$0605	;	1541	154.08	67.82 	218		1.064	1886.870
	dc.w	$0602	;	1538	153.77	67.65 	219		1.069	1898.148
	dc.w	$05FF	;	1535	153.46	67.48 	220		1.074	1909.455
	dc.w	$05FC	;	1532	153.16	67.31 	221		1.079	1920.791
	dc.w	$05F9	;	1529	152.85	67.14 	222		1.084	1932.155
	dc.w	$05F6	;	1526	152.55	66.97 	223		1.089	1943.549
	dc.w	$05F2	;	1522	152.24	66.80 	224		1.094	1954.972
	dc.w	$05EF	;	1519	151.94	66.63 	225		1.099	1966.424
	dc.w	$05EC	;	1516	151.64	66.47 	226		1.104	1977.906
	dc.w	$05EA	;	1514	151.40	66.33 	227		1.108	1987.112
	dc.w	$05E7	;	1511	151.10	66.17 	228		1.113	1998.647
	dc.w	$05E4	;	1508	150.80	66.00 	229		1.118	2010.211
	dc.w	$05E1	;	1505	150.51	65.84 	230		1.123	2021.806
	dc.w	$05DE	;	1502	150.21	65.67 	231		1.128	2033.430
	dc.w	$05DB	;	1499	149.92	65.51 	232		1.133	2045.084
	dc.w	$05D8	;	1496	149.62	65.35 	233		1.138	2056.769
	dc.w	$05D5	;	1493	149.33	65.18 	234		1.143	2068.483
	dc.w	$05D3	;	1491	149.10	65.05 	235		1.147	2077.877
	dc.w	$05D0	;	1488	148.81	64.89 	236		1.152	2089.647
	dc.w	$05CD	;	1485	148.52	64.73 	237		1.157	2101.447
	dc.w	$05CA	;	1482	148.23	64.57 	238		1.162	2113.278
	dc.w	$05C8	;	1480	147.95	64.41 	239		1.167	2125.140
	dc.w	$05C5	;	1477	147.66	64.26 	240		1.172	2137.032
	dc.w	$05C2	;	1474	147.38	64.10 	241		1.177	2148.956
	dc.w	$05BF	;	1471	147.09	63.94 	242		1.182	2160.911
	dc.w	$05BC	;	1468	146.81	63.78 	243		1.187	2172.898
	dc.w	$05BA	;	1466	146.59	63.66 	244		1.191	2182.510
	dc.w	$05B7	;	1463	146.31	63.50 	245		1.196	2194.553
	dc.w	$05B4	;	1460	146.03	63.35 	246		1.201	2206.628
	dc.w	$05B2	;	1458	145.75	63.19 	247		1.206	2218.735
	dc.w	$05AF	;	1455	145.47	63.04 	248		1.211	2230.874
	dc.w	$05AC	;	1452	145.20	62.89 	249		1.216	2243.044
	dc.w	$05A9	;	1449	144.92	62.73 	250		1.221	2255.247
	dc.w	$05A7	;	1447	144.65	62.58 	251		1.226	2267.483
	dc.w	$05A2	;	1442	144.23	62.46 	252		1.230	2277.294
	dc.w	$05A2	;	1442	144.16	62.31  	253		1.235	2289.588
	dc.w	$059F	;	1439	143.88	62.16 	254		1.240	2301.915
	dc.w	$059C	;	1436	143.61	62.00 	255		1.245	2314.274
	dc.w	$0599	;	1433	143.34	61.86 	256		1.250	2326.667
	dc.w	$0597	;	1431	143.08	61.71 	257		1.255	2339.092
	dc.w	$0594	;	1428	142.81	61.56 	258		1.260	2351.551
	dc.w	$0591	;	1425	142.54	61.41 	259		1.265	2364.043
	dc.w	$058F	;	1423	142.28	61.26 	260		1.270	2376.568
	dc.w	$058D	;	1421	142.06	61.15 	261		1.274	2386.613
	dc.w	$058A	;	1418	141.80	61.00 	262		1.279	2399.199
	dc.w	$0587	;	1415	141.54	60.85 	263		1.284	2411.819
	dc.w	$0585	;	1413	141.27	60.71 	264		1.289	2424.473
	dc.w	$0582	;	1410	141.01	60.56 	265		1.294	2437.161
	dc.w	$0580	;	1408	140.75	60.42 	266		1.299	2449.884
	dc.w	$057D	;	1405	140.49	60.27 	267		1.304	2462.641
	dc.w	$057A	;	1402	140.23	60.13 	268		1.309	2475.432
	dc.w	$0578	;	1400	140.03	60.01 	269		1.313	2485.690
	dc.w	$0576	;	1398	139.77	59.87 	270		1.318	2498.544
	dc.w	$0573	;	1395	139.51	59.73 	271		1.323	2511.433
	dc.w	$0571	;	1393	139.26	59.59 	272		1.328	2524.357
	dc.w	$056E	;	1390	139.00	59.44 	273		1.333	2537.317
	dc.w	$056C	;	1388	138.75	59.30 	274		1.338	2550.311
	dc.w	$0569	;	1385	138.49	59.16 	275		1.343	2563.342
	dc.w	$0566	;	1382	138.24	59.02 	276		1.348	2576.407
	dc.w	$0564	;	1380	137.99	58.88 	277		1.353	2589.509
	dc.w	$0562	;	1378	137.79	58.77 	278		1.357	2600.016
	dc.w	$055F	;	1375	137.54	58.63 	279		1.362	2613.183
	dc.w	$055D	;	1373	137.29	58.49 	280		1.367	2626.386
	dc.w	$055A	;	1370	137.04	58.35 	281		1.372	2639.625
	dc.w	$0558	;	1368	136.79	58.22 	282		1.377	2652.901
	dc.w	$0555	;	1365	136.54	58.08 	283		1.382	2666.213
	dc.w	$0553	;	1363	136.29	57.94 	284		1.387	2679.563
	dc.w	$0551	;	1361	136.05	57.80 	285		1.392	2692.949
	dc.w	$054F	;	1359	135.85	57.70 	286		1.396	2703.685
	dc.w	$054C	;	1356	135.61	57.56 	287		1.401	2717.138
	dc.w	$054A	;	1354	135.38	57.42 	288		1.406	2730.629
	dc.w	$0547	;	1351	135.12	57.29 	289		1.411	2744.157
	dc.w	$0545	;	1349	134.88	57.15 	290		1.416	2757.723
	dc.w	$0542	;	1346	134.64	57.02 	291		1.421	2771.327
	dc.w	$0540	;	1344	134.39	56.89 	292		1.426	2784.969
	dc.w	$053E	;	1342	134.15	56.75 	293		1.431	2798.649
	dc.w	$053B	;	1339	133.91	56.62 	294		1.436	2812.368
	dc.w	$0539	;	1337	133.72	56.51 	295		1.440	2823.371
	dc.w	$0537	;	1335	133.48	56.38 	296		1.445	2837.159
	dc.w	$0535	;	1333	133.25	56.25 	297		1.450	2850.986
	dc.w	$0532	;	1330	133.01	56.12 	298		1.455	2864.852
	dc.w	$0530	;	1328	132.77	55.98 	299		1.460	2878.757
	dc.w	$052D	;	1325	132.54	55.85 	300		1.465	2892.702
	dc.w	$052B	;	1323	132.30	55.72 	301		1.470	2906.686
	dc.w	$0529	;	1321	132.07	55.59 	302		1.475	2920.709
	dc.w	$0527	;	1319	131.88	55.49 	303		1.479	2931.957
	dc.w	$0524	;	1316	131.64	55.36 	304		1.484	2946.052
	dc.w	$0522	;	1314	131.41	55.23 	305		1.489	2960.188
	dc.w	$0520	;	1312	131.88	55.10 	306		1.494	2974.364
	dc.w	$051E	;	1310	130.95	54.97 	307		1.499	2988.580
	dc.w	$051B	;	1307	130.72	54.84 	308		1.504	3002.838
	dc.w	$0519	;	1305	130.49	54.71 	309		1.509	3017.135
	dc.w	$0517	;	1303	130.25	54.59 	310		1.514	3031.474
	dc.w	$0514	;	1300	130.03	54.46 	311		1.519	3045.855
	dc.w	$0512	;	1298	129.84	54.36 	312		1.523	3057.389
	dc.w	$0510	;	1296	129.61	54.23 	313		1.528	3071.843
	dc.w	$050E	;	1294	129.39	54.10 	314		1.533	3086.340
	dc.w	$050C	;	1292	129.16	53.98 	315		1.538	3100.878
	dc.w	$0509	;	1289	128.93	53.85 	316		1.543	3115.458
	dc.w	$0507	;	1287	128.71	53.73 	317		1.548	3130.081
	dc.w	$0505	;	1285	128.48	53.60 	318		1.553	3144.746
	dc.w	$0503	;	1283	128.26	53.48 	319		1.558	3159.454
	dc.w	$0500	;	1280	128.03	53.35 	320		1.563	3174.204
	dc.w	$04FF	;	1279	127.85	53.25 	321		1.567	3186.036
	dc.w	$04FC	;	1276	127.63	53.13 	322		1.572	3200.863
	dc.w	$04FA	;	1274	127.41	53.00 	323		1.577	3215.735
	dc.w	$04F8	;	1272	127.18	52.88 	324		1.582	3230.650
	dc.w	$04F6	;	1270	126.96	52.76 	325		1.587	3245.608
	dc.w	$04F3	;	1267	126.74	52.63 	326		1.592	3260.610
	dc.w	$04F1	;	1265	126.52	52.51 	327		1.597	3275.657
	dc.w	$04EF	;	1263	126.30	52.39 	328		1.602	3290.747
	dc.w	$04ED	;	1261	126.12	52.29 	329		1.606	3302.852
	dc.w	$04EB	;	1259	125.90	52.17 	330		1.611	3318.023
	dc.w	$04E9	;	1257	125.68	52.05 	331		1.616	3333.239
	dc.w	$04E7	;	1255	125.47	51.93 	332		1.621	3348.500
	dc.w	$04E5	;	1253	125.25	51.80 	333		1.626	3363.806
	dc.w	$04E2	;	1250	125.03	51.68 	334		1.631	3379.157
	dc.w	$04E0	;	1248	124.81	51.56 	335		1.636	3394.554
	dc.w	$04DE	;	1246	124.60	51.44 	336		1.641	3409.997
	dc.w	$04DC	;	1244	124.38	51.32 	337		1.646	3425.486
	dc.w	$04DA	;	1242	124.21	51.23 	338		1.650	3437.910
	dc.w	$04D8	;	1240	123.99	51.11 	339		1.655	3453.483
	dc.w	$04D6	;	1238	123.78	50.99 	340		1.660	3469.102
	dc.w	$04D4	;	1236	123.56	50.87 	341		1.665	3484.768
	dc.w	$04D2	;	1234	123.35	50.75 	342		1.670	3500.480
	dc.w	$04CF	;	1231	123.14	50.63 	343		1.675	3516.241
	dc.w	$04CD	;	1229	122.92	50.51 	344		1.680	3532.048
	dc.w	$04CB	;	1227	122.71	50.40 	345		1.685	3547.903
	dc.w	$04C9	;	1225	122.54	50.30 	346		1.689	3560.622
	dc.w	$04C7	;	1223	122.33	50.18 	347		1.694	3576.564
	dc.w	$04C5	;	1221	122.12	50.07 	348		1.699	3592.554
	dc.w	$04C3	;	1219	121.91	49.95 	349		1.704	3608.592
	dc.w	$04C1	;	1217	121.70	49.83 	350		1.709	3624.679
	dc.w	$04BF	;	1215	121.49	49.72 	351		1.714	3640.816
	dc.w	$04BD	;	1213	121.28	4960  	352		1.719	3657.001
	dc.w	$04BB	;	1211	121.07	49.48 	353		1.724	3673.236
	dc.w	$04B9	;	1209	120.86	49.37 	354		1.729	3689.520
	dc.w	$04B7	;	1207	120.70	49.28 	355		1.733	3702.583
	dc.w	$04B5	;	1205	120.49	49.16 	356		1.738	3718.958
	dc.w	$04B3	;	1203	120.28	49.04 	357		1.743	3735.382
	dc.w	$04B1	;	1201	120.07	48.93 	358		1.748	3751.857
	dc.w	$04AF	;	1199	119.87	48.82 	359		1.753	3768.383
	dc.w	$04AD	;	1197	119.66	48.70 	360		1.758	3784.960
	dc.w	$04AB	;	1195	119.46	48.59 	361		1.763	3801.588
	dc.w	$04A9	;	1193	119.25	48.47 	362		1.768	3818.267
	dc.w	$04A7	;	1191	119.09	48.38 	363		1.772	3831.648
	dc.w	$04A5	;	1189	118.88	48.27 	364		1.777	3848.421
	dc.w	$04A3	;	1187	118.68	48.15 	365		1.782	3865.245
	dc.w	$04A1	;	1185	118.47	48.04 	366		1.787	3882.123
	dc.w	$049F	;	1183	118.27	47.93 	367		1.792	3899.052
	dc.w	$049D	;	1181	118.07	47.81 	368		1.797	3916.035
	dc.w	$049B	;	1179	117.86	47.70 	369		1.802	3933.071
	dc.w	$0499	;	1177	117.66	47.59 	370		1.807	3950.160
	dc.w	$0497	;	1175	117.46	47.48 	371		1.812	3967.302
	dc.w	$0495	;	1173	117.30	47.39 	372		1.816	3981.055
	dc.w	$0493	;	1171	117.10	47.28 	373		1.821	3998.295
	dc.w	$0491	;	1169	116.90	47.16 	374		1.826	4015.589
	dc.w	$048F	;	1167	116.69	47.05 	375		1.831	4032.938
	dc.w	$048D	;	1165	116.49	46.94 	376		1.836	4050.341
	dc.w	$048B	;	1163	116.29	46.83 	377		1.841	4067.800
	dc.w	$0489	;	1161	116.10	46.72 	378		1.846	4085.314
	dc.w	$0487	;	1159	115.90	46.61 	379		1.851	4102.883
	dc.w	$0485	;	1157	115.74	46.52 	380		1.855	4116.979
	dc.w	$0483	;	1155	115.54	46.41 	381		1.860	4134.65
	dc.w	$0481	;	1153	115.34	46.30 	382		1.865	4152.376
	dc.w	$047F	;	1151	115.14	46.19 	383		1.870	4170.160
	dc.w	$047D	;	1149	114.94	46.08 	384		1.875	4188.000
	dc.w	$047C	;	1148	114.75	45.97 	385		1.880	4205.897
	dc.w	$047A	;	1146	114.55	45.86 	386		1.885	4223.852
	dc.w	$0478	;	1144	114.35	45.75 	387		1.890	4241.865
	dc.w	$0476	;	1142	114.16	45.64 	388		1.895	4259.936
	dc.w	$0474	;	1140	114.00	45.56 	389		1.899	4274.434
	dc.w	$0472	;	1138	113.80	45.45 	390		1.904	4292.610
	dc.w	$0470	;	1136	113.61	45.34 	391		1.909	4310.844
	dc.w	$046E	;	1134	113.41	45.23 	392		1.914	4329.138
	dc.w	$046C	;	1132	113.22	45.12 	393		1.919	4347.491
	dc.w	$046A	;	1130	113.02	45.01 	394		1.924	4365.904
	dc.w	$0468	;	1128	112.83	44.91 	395		1.929	4384.376
	dc.w	$0466	;	1126	112.64	44.80 	396		1.934	4402.909
	dc.w	$0465	;	1125	112.48	44.71 	397		1.938	4417.779
	dc.w	$0463	;	1123	112.29	44.60 	398		1.943	4436.421
	dc.w	$0461	;	1121	112.10	44.50 	399		1.948	4455.125
	dc.w	$045F	;	1119	111.90	44.39 	400		1.953	4473.889
	dc.w	$045D	;	1117	111.71	44.28 	401		1.958	4492.715
	dc.w	$045B	;	1115	111.52	44.18 	402		1.963	4511.604
	dc.w	$0459	;	1113	111.33	44.07 	403		1.968	4530.554
	dc.w	$0457	;	1111	111.13	43.96 	404		1.973	4549.567
	dc.w	$0455	;	1109	110.94	43.86 	405		1.978	4568.643
	dc.w	$0454	;	1108	110.79	43.77 	406		1.982	4583.950
	dc.w	$0452	;	1106	110.60	43.67 	407		1.987	4603.140
	dc.w	$0450	;	1104	110.41	43.56 	408		1.992	4622.394
	dc.w	$044E	;	1102	110.22	43.45 	409		1.997	4641.712
	dc.w	$044C	;	1100	110.03	43.35 	410		2.002	4661.094
	dc.w	$044A	;	1098	109.84	43.24 	411		2.007	4680.541
	dc.w	$0449	;	1097	109.65	43.14 	412		2.012	4700.054
	dc.w	$0447	;	1095	109.46	43.03 	413		2.017	4719.631
	dc.w	$0445	;	1093	109.31	42.95 	414		2.021	4735.341
	dc.w	$0443	;	1091	109.12	42.84 	415		2.026	4755.037
	dc.w	$0441	;	1089	108.93	42.74 	416		2.031	4774.800
	dc.w	$043F	;	1087	108.74	42.64 	417		2.036	4794.629
	dc.w	$043E	;	1086	108.56	42.53 	418		2.041	4814.525
	dc.w	$043C	;	1084	108.37	42.43 	419		2.046	4834.489
	dc.w	$043A	;	1082	108.18	42.32 	420		2.051	4854.520
	dc.w	$0438	;	1080	107.99	42.22 	421		2.056	4874.620
	dc.w	$0436	;	1078	107.81	42.11 	422		2.061	4894.787
	dc.w	$0417	;	1077	107.66	42.03 	423		2.065	4910.971
	dc.w	$0433	;	1075	107.47	41.93 	424		2.070	4931.263
	dc.w	$0431	;	1073	107.28	41.82 	425		2.075	4951.624
	dc.w	$042F	;	1071	107.10	41.72 	426		2.080	4972.055
	dc.w	$042D	;	1069	106.91	41.62 	427		2.085	4992.556
	dc.w	$042B	;	1067	106.73	41.51 	428		2.090	5013.127
	dc.w	$0429	;	1065	106.54	41.41 	429		2.095	5033.769
	dc.w	$0428	;	1064	106.36	41.31 	430		2.100	5054.483
	dc.w	$0426	;	1062	106.21	41.23 	431		2.104	5071.105
	dc.w	$0424	;	1060	106.02	41.12 	432		2.109	5091.947
	dc.w	$0422	;	1058	105.84	41.02 	433		2.114	5112.862
	dc.w	$0421	;	1057	105.66	40.92 	434		2.119	5133.849
	dc.w	$041F	;	1055	105.47	40.82 	435		2.124	5154.910
	dc.w	$041D	;	1053	105.29	40.72 	436		2.129	5176.043
	dc.w	$041B	;	1051	105.10	40.61 	437		2.134	5197.251
	dc.w	$0419	;	1049	104.92	40.51 	438		2.139	5218.532
	dc.w	$0417	;	1047	104.74	40.41 	439		2.144	5239.888
	dc.w	$0416	;	1046	104.59	40.33 	440		2.148	5257.027
	dc.w	$0414	;	1044	104.41	40.23 	441		2.153	5278.518
	dc.w	$0412	;	1042	104.23	40.13 	442		2.158	5300.084
	dc.w	$0410	;	1040	104.04	40.02 	443		2.163	5321.727
	dc.w	$040F	;	1039	103.86	39.92 	444		2.168	5343.446
	dc.w	$040D	;	1037	103.68	39.82 	445		2.173	5365.242
	dc.w	$040B	;	1035	103.50	39.72 	446		2.178	5387.116
	dc.w	$0409	;	1033	103.32	39.62 	447		2.183	5409.066
	dc.w	$0407	;	1031	103.14	39.52 	448		2.188	5431.095
	dc.w	$0406	;	1030	102.99	39.44 	449		2.192	5448.775
	dc.w	$0404	;	1028	102.81	39.34 	450		2.197	5470.945
	dc.w	$0402	;	1026	102.63	39.24 	451		2.202	5493.195
	dc.w	$0401	;	1025	102.45	39.14 	452		2.207	5515.525
	dc.w	$03FF	;	1023	102.27	39.04 	453		2.212	5537.934
	dc.w	$03FD	;	1021	102.09	38.94 	454		2.217	5560.424
	dc.w	$03FB	;	1019	101.91	38.84 	455		2.222	5582.995
	dc.w	$03F9	;	1017	101.73	38.74 	456		2.227	5605.647
	dc.w	$03F8	;	1016	101.58	38.66 	457		2.231	5623.828
	dc.w	$03F6	;	1014	101.40	38.56 	458		2.236	5646.628
	dc.w	$03F4	;	1012	101.22	38.46 	459		2.241	5669.511
	dc.w	$03F3	;	1011	101.05	38.36 	460		2.246	5692.476
	dc.w	$03F1	;	1009	100.87	38.26 	461		2.251	5715.526
	dc.w	$03EF	;	1007	100.69	38.16 	462		2.256	5738.659
	dc.w	$03ED	;	1005	100.51	38.06 	463		2.261	5761.887
	dc.w	$03EB	;	1003	100.33	37.96 	464		2.266	5785.179
	dc.w	$03EA	;	1002	100.15	37.86 	465		2.271	5808.567
	dc.w	$03E8	;	1000	100.01	37.78 	466		2.275	5827.339
	dc.w	$03E6	;	998	    99.83	37.68 	467		2.280	5850.882
	dc.w	$03E5	;	997 	99.65	37.59 	468		2.285	5874.512
	dc.w	$03E3	;	995 	99.48 	37.49 	469		2.290	5898.229
	dc.w	$03E1	;	993 	99.30 	37.39 	470		2.295	5922.033
	dc.w	$03DF	;	991 	99.12 	37.29 	471		2.300	5945.926
	dc.w	$03DD	;	989 	98.94 	37.19 	472		2.305	5969.907
	dc.w	$03DC	;	988 	98.77 	37.09 	473		2.310	5993.978
	dc.w	$03DA	;	986 	98.63 	37.01 	474		2.314	6013.299
	dc.w	$03D9	;	985 	98.45 	36.92 	475		2.319	6037.531
	dc.w	$03D7	;	983 	98.27 	36.82 	476		2.324	6061.854
	dc.w	$03D5	;	981 	98.10 	36.72 	477		2.329	6086.267
	dc.w	$03D3	;	979 	97.92 	36.62 	478		2.334	6110.773
	dc.w	$03D1	;	977 	97.74 	36.52 	479		2.339	6135.370
	dc.w	$03D0	;	976 	97.57 	36.43 	480		2.344	6160.060
	dc.w	$03CE	;	974 	97.39 	36.33 	481		2.349	6184.843
	dc.w	$03CC	;	972 	97.21 	36.23 	482		2.354	6209.720
	dc.w	$03CA	;	970 	97.07 	36.15 	483		2.358	6229.690
	dc.w	$03C9	;	969 	96.90 	36.05 	484		2.363	6254.736
	dc.w	$03C7	;	967 	96.72 	35.96 	485		2.368	6279.878
	dc.w	$03C6	;	966 	95.86 	35.86 	486		2.373	6305.116
	dc.w	$03C4	;	964 	96.37 	35.76 	487		2.378	6330.450
	dc.w	$03C2	;	962 	96.20 	35.67 	488		2.383	6355.881
	dc.w	$03C0	;	960 	96.02 	35.57 	489		2.388	6381.409
	dc.w	$03BF	;	959 	95.85 	35.47 	490		2.393	6407.035
	dc.w	$03BD	;	957 	95.39 	35.39 	491		2.397	6427.607
	dc.w	$03BB	;	955 	95.53 	35.30 	492		2.402	6453.410
	dc.w	$03BA	;	954 	95.36 	35.20 	493		2.407	6479.314
	dc.w	$03B8	;	952 	95.19 	35.10 	494		2.412	6505.317
	dc.w	$03B6	;	950 	95.01 	35.00 	495		2.417	6531.421
	dc.w	$03B4	;	948 	94.84 	34.91 	496		2.422	6557.626
	dc.w	$03B3	;	947 	94.66 	34.81 	497		2.427	6583.933
	dc.w	$03B1	;	945 	94.49 	34.72 	498		2.432	6610.343
	dc.w	$03AF	;	943 	94.32 	34.62 	499		2.437	6636.855
	dc.w	$03AE	;	942 	94.18 	34.54 	500		2.441	6658.140
	dc.w	$03AC	;	940 	94.00 	34.45 	501		2.446	6684.839
	dc.w	$03AA	;	938 	93.83 	34.35 	502		2.451	6711.644
	dc.w	$03A9	;	937 	93.66 	34.25 	503		2.456	6738.553
	dc.w	$03A7	;	935 	93.48 	34.16 	504		2.461	6765.569
	dc.w	$03A5	;	933 	93.31 	34.06 	505		2.466	6792.691
	dc.w	$03A3	;	931 	93.14 	33.97 	506		2.471	6819.921
	dc.w	$03A2	;	930 	92.97 	33.87 	507		2.476	6847.258
	dc.w	$03A0	;	928 	92.83 	33.79 	508		2.480	6869.206
	dc.w	$039F	;	927 	92.65 	33.70 	509		2.485	6896.740
	dc.w	$039D	;	925 	92.48 	33.60 	510		2.490	6924.382
	dc.w	$039B	;	923 	92.31 	33.51 	511		2.495	6952.136
	dc.w	$0399	;	921 	92.14 	33.41 	512		2.500	6980.000
	dc.w	$0398	;	920 	91.96 	33.31 	513		2.505	7007.976
	dc.w	$0396	;	918 	91.79 	33.22 	514		2.510	7036.064
	dc.w	$0394	;	916 	91.62 	33.12 	515		2.515	7064.266
	dc.w	$0393	;	915 	91.45 	33.03 	516		2.520	7092.581
	dc.w	$0391	;	913 	91.31 	32.95 	517		2.524	7115.315
	dc.w	$038F	;	911 	91.14 	32.85 	518		2.529	7143.837
	dc.w	$038E	;	910 	90.97 	32.76 	519		2.534	7172.474
	dc.w	$038C	;	908 	90.80 	32.66 	520		2.539	7201.227
	dc.w	$038A	;	906 	90.62 	32.57 	521		2.544	7230.098
	dc.w	$0389	;	905 	90.45 	32.47 	522		2.549	7259.086
	dc.w	$0387	;	903 	90.28 	32.38 	523		2.554	7288.193
	dc.w	$0385	;	901 	90.11 	32.28 	524		2.559	7317.419
	dc.w	$0384	;	900 	89.97 	32.21 	525		2.563	7340.886
	dc.w	$0382	;	898 	89.80 	32.11 	526		2.568	7370.329
	dc.w	$0380	;	896 	89.63 	32.02 	527		2.573	7399.893
	dc.w	$037F	;	895 	89.46 	31.92 	528		2.578	7429.579
	dc.w	$037D	;	893 	89.29 	31.83 	529		2.583	7459.388
	dc.w	$037B	;	891 	89.12 	31.73 	530		2.588	7489.320
	dc.w	$037A	;	890 	88.95 	31.64 	531		2.593	7519.377
	dc.w	$0378	;	888 	88.78 	31.54 	532		2.598	7549.559
	dc.w	$0376	;	886 	88.61 	31.45 	533		2.603	7579.866
	dc.w	$0375	;	885 	88.47 	31.37 	534		2.607	7604.204
	dc.w	$0373	;	883 	88.30 	31.28 	535		2.612	7634.740
	dc.w	$0371	;	881 	88.13 	31.18 	536		2.617	7665.405
	dc.w	$0370	;	880 	87.96 	31.09 	537		2.622	7696.198
	dc.w	$036E	;	878 	87.79 	30.99 	538		2.627	7727.122
	dc.w	$036C	;	876 	87.62 	30.90 	539		2.632	7758.176
	dc.w	$036B	;	875 	87.45 	30.80 	540		2.637	7789.361
	dc.w	$0369	;	873 	87.28 	30.71 	541		2.642	7820.679
	dc.w	$0367	;	871 	87.14 	30.63 	542		2.646	7845.828
	dc.w	$0366	;	870 	86.97 	30.54 	543		2.651	7877.386
	dc.w	$0364	;	868 	86.80 	30.44 	544		2.656	7909.078
	dc.w	$0362	;	866 	86.63 	30.35 	545		2.661	7940.906
	dc.w	$0361	;	865 	86.46 	30.26 	546		2.666	7972.871
	dc.w	$035F	;	863 	86.29 	30.16 	547		2.671	8004.972
	dc.w	$035D	;	861 	86.12 	30.07 	548		2.676	8037.212
	dc.w	$035C	;	860 	85.95 	29.97 	549		2.681	8069.590
	dc.w	$035A	;	858 	85.78 	29.88 	550		2.686	8102.109
	dc.w	$0358	;	856 	85.64 	29.80 	551		2.690	8128.225
	dc.w	$0357	;	855 	85.47 	29.71 	552		2.695	8160.998
	dc.w	$0355	;	853 	85.30 	29.61 	553		2.700	8193.913
	dc.w	$0353	;	851 	85.14 	29.52 	554		2.705	8226.972
	dc.w	$0352	;	850 	84.97 	29.43 	555		2.710	8260.175
	dc.w	$0350	;	848 	84.80 	29.33 	556		2.715	8293.523
	dc.w	$034E	;	846 	84.63 	29.24 	557		2.720	8327.018
	dc.w	$034D	;	845 	84.46 	29.14 	558		2.725	8360.659
	dc.w	$034B	;	843 	84.32 	29.07 	559		2.729	8387.679
	dc.w	$034A	;	842 	84.15 	28.97 	560		2.734	8421.589
	dc.w	$0348	;	840 	83.98 	28.88 	561		2.739	8455.648
	dc.w	$0346	;	838 	83.81 	28.78 	562		2.744	8489.858
	dc.w	$0344	;	836 	83.64 	28.69 	563		2.749	8524.220
	dc.w	$0343	;	835 	83.47 	28.60 	564		2.754	8558.736
	dc.w	$0341	;	833 	83.30 	28.50 	565		2.759	8593.405
	dc.w	$033F	;	831 	83.14 	28.41 	566		2.764	8628.229
	dc.w	$033E	;	830 	82.97 	28.31 	567		2.769	8663.209
	dc.w	$033C	;	828 	82.83 	28.24 	568		2.773	8691.307
	dc.w	$033B	;	827 	82.66 	28.15 	569		2.778	8726.571
	dc.w	$0339	;	825 	82.49 	28.05 	570		2.783	8761.994
	dc.w	$0337	;	823 	82.32 	27.96 	571		2.788	8797.577
	dc.w	$0336	;	822 	82.15 	27.86 	572		2.793	8833.321
	dc.w	$0334	;	820 	81.98 	27.77 	573		2.798	8869.228
	dc.w	$0332	;	818 	81.82 	27.68 	574		2.803	8905.298
	dc.w	$0331	;	817 	81.65 	27.58 	575		2.808	8941.533
	dc.w	$032F	;	815 	81.48 	27.49 	576		2.813	8977.933
	dc.w	$032D	;	813 	81.34 	27.41 	577		2.817	9007.174
	dc.w	$032C	;	812 	81.17 	27.32 	578		2.822	9043.875
	dc.w	$032A	;	810 	81.00 	27.22 	579		2.827	9080.746
	dc.w	$0328	;	808 	80.83 	27.13 	580		2.832	9117.786
	dc.w	$0327	;	807 	80.67 	27.04 	581		2.837	9154.998
	dc.w	$0325	;	805 	80.50 	26.94 	582		2.842	9192.382
	dc.w	$0323	;	803 	80.30 	26.85 	583		2.847	9229.940
	dc.w	$0322	;	802 	80.16 	26.75 	584		2.852	9267.672
	dc.w	$0320	;	800 	80.02 	26.68 	585		2.856	9297.985
	dc.w	$031F	;	799 	79.85 	26.59 	586		2.861	9336.036
	dc.w	$031D	;	797 	79.68 	26.49 	587		2.866	9374.264
	dc.w	$031B	;	795 	79.52 	26.40 	588		2.871	9412.673
	dc.w	$0319	;	793 	79.35 	26.30 	589		2.876	9451.262
	dc.w	$0318	;	792 	79.18 	26.21 	590		2.881	9490.033
	dc.w	$0316	;	790 	79.00 	26.12 	591		2.886	9528.988
	dc.w	$0314	;	788 	78.84 	26.02 	592		2.891	9568.127
	dc.w	$0313	;	787 	78.67 	25.93 	593		2.896	9607.452
	dc.w	$0311	;	785 	78.53 	25.85 	594		2.900	9639.048
	dc.w	$0310	;	784 	78.36 	25.76 	595		2.905	9678.711
	dc.w	$030E	;	782 	78.19 	25.66 	596		2.910	9718.565
	dc.w	$030C	;	780 	78.03 	25.57 	597		2.915	9758.609
	dc.w	$030B	;	779 	77.86 	25.48 	598		2.920	9798.846
	dc.w	$0309	;	777 	77.69 	25.38 	599		2.925	9839.277
	dc.w	$0307	;	775 	77.52 	25.29 	600		2.930	9879.903
	dc.w	$0306	;	774 	77.35 	25.19 	601		2.935	9920.726
	dc.w	$0304	;	772 	77.21 	25.12 	602		2.939	9953.527
	dc.w	$0302	;	770 	77.04 	25.02 	603		2.944	9994.708
	dc.w	$0301	;	769 	76.87 	24.93 	604		2.949	10036.090
	dc.w	$02FF	;	767 	76.70 	24.84 	605		2.954	10077.674
	dc.w	$02FD	;	765 	76.53 	24.74 	606		2.959	10119.461
	dc.w	$02FC	;	764 	76.36 	24.65 	607		2.964	10161.454
	dc.w	$02FA	;	762 	76.20 	24.55 	608		2.969	10203.635
	dc.w	$02F8	;	760 	76.03 	24.46 	609		2.974	10246.061
	dc.w	$02F7	;	759 	75.86 	24.36 	610		2.979	10288.679
	dc.w	$02F5	;	757 	75.72 	24.29 	611		2.983	10322.925
	dc.w	$02F4	;	756 	75.55 	24.19 	612		2.988	10365.924
	dc.w	$02F2	;	754 	75.38 	24.10 	613		2.993	10409.138
	dc.w	$02F0	;	752 	75.21 	24.00 	614		2.998	10452.567
	dc.w	$02EE	;	750 	75.04 	23.91 	615		3.003	10496.214
	dc.w	$02ED	;	749 	74.87 	23.82 	616		3.008	10540.080
	dc.w	$02EB	;	747 	74.70 	23.72 	617		3.013	10584.167
	dc.w	$02E9	;	745 	74.53 	23.63 	618		3.018	10628.476
	dc.w	$02E8	;	744 	74.39 	23.55 	619		3.022	10664.085
	dc.w	$02E6	;	742 	74.22 	23.46 	620		3.027	10708.799
	dc.w	$02E4	;	740 	74.05 	23.36 	621		3.032	10753.740
	dc.w	$02E3	;	739 	73.88 	23.27 	622		3.037	10798.910
	dc.w	$02E1	;	737 	73.71 	23.17 	623		3.042	10844.311
	dc.w	$02DF	;	735 	73.54 	23.08 	624		3.047	10889.944
	dc.w	$02DE	;	734 	73.37 	22.98 	625		3.052	10935.811
	dc.w	$02DC	;	732 	73.20 	22.89 	626		3.057	10981.915
	dc.w	$02DA	;	730 	73.03 	22.80 	627		3.062	11028.256
	dc.w	$02D9	;	729 	72.90 	22.72 	628		3.066	11065.502
	dc.w	$02D7	;	727 	72.72 	22.62 	629		3.071	11112.276
	dc.w	$02D6	;	726 	72.55 	22.53 	630		3.076	11159.293
	dc.w	$02D4	;	724 	72.38 	22.43 	631		3.081	11206.555
	dc.w	$02D2	;	722 	72.21 	22.34 	632		3.086	11254.065
	dc.w	$02D0	;	720 	72.04 	22.24 	633		3.091	11301.823
	dc.w	$02CF	;	719 	71.87 	22.15 	634		3.096	11349.832
	dc.w	$02CD	;	717 	71.70 	22.05 	635		3.101	11398.094
	dc.w	$02CC	;	716 	71.56 	21.98 	636		3.105	11436.887
	dc.w	$02CA	;	714 	71.39 	21.88 	637		3.110	11485.608
	dc.w	$02C8	;	712 	71.22 	21.79 	638		3.115	11534.589
	dc.w	$02C7	;	711 	71.05 	21.69 	639		3.120	11583.830
	dc.w	$02C5	;	709 	70.88 	21.60 	640		3.125	11633.333
	dc.w	$02C3	;	707 	70.70 	21.50 	641		3.130	11683.102
	dc.w	$02C1	;	705 	70.53 	21.41 	642		3.135	11733.137
	dc.w	$02C0	;	704 	70.36 	21.31 	643		3.140	11783.441
	dc.w	$02BE	;	702 	70.19 	21.22 	644		3.145	11834.016
	dc.w	$02BD	;	701 	70.05 	21.14 	645		3.149	11874.673
	dc.w	$02BB	;	699 	69.88 	21.04 	646		3.154	11925.742
	dc.w	$02B9	;	697 	69.71 	20.95 	647		3.159	11977.089
	dc.w	$02B7	;	695 	69.53 	20.85 	648		3.164	12028.715
	dc.w	$02B6	;	694 	69.36 	20.76 	649		3.169	12080.623
	dc.w	$02B4	;	692 	69.19 	20.66 	650		3.174	12132.815
	dc.w	$02B2	;	690 	69.02 	20.57 	651		3.179	12185.294
	dc.w	$02B0	;	688 	68.84 	20.47 	652		3.184	12238.062
	dc.w	$02AF	;	687 	68.71 	20.39 	653		3.188	12280.486
	dc.w	$02AD	;	685 	68.53 	20.30 	654		3.193	12333.780
	dc.w	$02AC	;	684 	68.36 	20.20 	655		3.198	12387.370
	dc.w	$02AA	;	682 	68.19 	20.10 	656		3.203	12441.258
	dc.w	$02A8	;	680 	68.01 	20.00 	657		3.208	12495.446
	dc.w	$02A6	;	678 	67.84 	19.91 	658		3.213	12549.938
	dc.w	$02A5	;	677 	67.67 	19.81 	659		3.218	12604.736
	dc.w	$02A3	;	675 	67.49 	19.72 	660		3.223	12659.842
	dc.w	$02A1	;	673 	67.32 	19.62 	661		3.228	12715.260
	dc.w	$02A0	;	672 	67.18 	19.54 	662		3.232	12759.819
	dc.w	$029E	;	670 	67.01 	19.45 	663		3.237	12815.803
	dc.w	$029C	;	668 	66.83 	19.35 	664		3.242	12872.105
	dc.w	$029B	;	667 	66.66 	19.26 	665		3.247	12928.728
	dc.w	$0299   ;	665 	66.49 	19.16 	666		3.252	12985.675
	dc.w	$0297	;	663 	66.31 	19.06 	667		3.257	13042.949
	dc.w	$0295	;	661 	66.14 	18.96 	668		3.262	13100.552
	dc.w	$0294	;	660 	65.96 	18.87 	669		3.267	13158.488
	dc.w	$0292	;	658 	65.82 	18.79 	670		3.271	13205.078
	dc.w	$0291	;	657 	65.65 	18.69 	671		3.276	13263.619
	dc.w	$028F	;	655 	65.47 	18.60 	672		3.281	13322.501
	dc.w	$028D	;	653 	65.30 	18.50 	673		3.286	13381.727
	dc.w	$028B	;	651 	65.12 	18.40 	674		3.291	13441.299
	dc.w	$028A	;	650 	64.95 	18.30 	675		3.296	13501.221
	dc.w	$0288	;	648 	64.77 	18.21 	676		3.301	13561.495
	dc.w	$0286	;	646 	64.59 	18.11 	677		3.306	13622.125
	dc.w	$0284	;	644 	64.42 	18.01 	678		3.311	13683.114
	dc.w	$0283	;	643 	64.28 	17.93 	679		3.315	13732.166
	dc.w	$0281	;	641 	64.10 	17.83 	680		3.320	13793.81
	dc.w	$027F	;	639 	63.93 	17.74 	681		3.325	13855.821
	dc.w	$027E	;	638 	63.75 	17.64 	682		3.330	13981.204
	dc.w	$027C	;	636 	63.57 	17.54 	683		3.335	13980.961
	dc.w	$027A	;	634 	63.40 	17.44 	684		3.340	14044.096
	dc.w	$0278	;	632 	63.22 	17.34 	685		3.345	14107.613
	dc.w	$0276	;	630 	63.04 	17.24 	686		3.350	14171.515
	dc.w	$0275	;	629 	62.90 	17.17 	687		3.354	14222.916
	dc.w	$0273	;	627 	62.72 	17.07 	688		3.359	14287.520
	dc.w	$0271	;	625 	62.54 	16.97 	689		3.364	14352.518
	dc.w	$0270	;	624 	62.37 	16.87 	690		3.369	14417.915
	dc.w	$026E	;	622 	62.19 	16.77 	691		3.374	14483.715
	dc.w	$026C	;	620 	62.01 	16.67 	692		3.379	14549.920
	dc.w	$026A	;	618 	61.83 	16.57 	693		3.384	14616.535
	dc.w	$0269	;	617 	61.65 	16.47 	694		3.389	14683.563
	dc.w	$0267	;	615 	61.47 	16.37 	695		3.394	14751.009
	dc.w	$0265	;	613 	61.33 	16.30 	696		3.398	14805.268
	dc.w	$0264	;	612 	61.15 	16.20 	697		3.403	14873.475
	dc.w	$0262	;	610 	60.97 	16.10 	698		3.408	14942.111
	dc.w	$0260	;	608 	60.79 	16.00 	699		3.413	15011.178
	dc.w	$025E	;	606 	60.61 	15.90 	700		3.418	15080.683
	dc.w	$025C	;	604 	60.43 	15.80 	701		3.423	15150.628
	dc.w	$025B	;	603 	60.25 	15.70 	702		3.428	15221.018
	dc.w	$0259	;	601 	60.07 	15.60 	703		3.433	15291.857
	dc.w	$0257	;	599 	59.89 	15.50 	704		3.438	15363.150
	dc.w	$0256	;	598 	59.75 	15.41 	705		3.442	15420.513
	dc.w	$0254	;	596 	59.57 	15.32 	706		3.447	15492.634
	dc.w	$0252	;	594 	59.39 	15.22 	707		3.452	15565.220
	dc.w	$0250	;	592 	59.21 	15.11 	708		3.457	15638.276
	dc.w	$024E	;	590 	59.02 	15.01 	709		3.462	15711.808
	dc.w	$024C	;	588 	58.84 	14.91 	710		3.467	15785.819
	dc.w	$024B	;	587 	58.66 	14.81 	711		3.472	15860.314
	dc.w	$0249	;	585 	58.48 	14.71   712		3.477	15935.299
	dc.w	$0247	;	583 	58.33 	14.63 	713		3.481	15995.642
	dc.w	$0246	;	582 	58.15 	14.53 	714		3.486	16071.519
	dc.w	$0244	;	580 	57.97 	14.43 	715		3.491	16147.899
	dc.w	$0242	;	578 	57.78 	14.32 	716		3.496	16224.787
	dc.w	$0240	;	576 	57.60 	14.22 	717		3.501	16302.188
	dc.w	$023E	;	574 	57.42 	14.12 	718		3.506	16380.107
	dc.w	$023C	;	572 	57.23 	14.02 	719		3.511	16458.549
	dc.w	$023B	;	571 	57.05 	13.92 	720		3.516	16537.520
	dc.w	$0239	;	569 	56.87 	13.81 	721		3.521	16617.025
	dc.w	$0237	;	567 	56.72 	13.73 	722		3.525	16681.017
	dc.w	$0235	;	565 	56.53 	13.63 	723		3.530	16761.497
	dc.w	$0234	;	564 	56.35 	13.53 	724		3.535	16842.526
	dc.w	$0232	;	562 	56.16 	13.42 	725		3.540	16924.110
	dc.w	$0230	;	560 	55.98 	13.32 	726		3.545	17006.254
	dc.w	$022E	;	558 	55.79 	13.22 	727		3.550	17088.966
	dc.w	$022C	;	556 	55.61 	13.11 	728		3.555	17172.249
	dc.w	$022A	;	554 	55.42 	13.01 	729		3.560	17256.111
	dc.w	$0229	;	553 	55.27 	12.93 	730		3.564	17323.621
	dc.w	$0227	;	551 	55.08 	12.82 	731		3.569	17408.539
	dc.w	$0225	;	549 	54.90 	12.72 	732		3.574	17494.053
	dc.w	$0223	;	547 	54.71 	12.62 	733		3.579	17580.169
	dc.w	$0221	;	545 	54.52 	12.51 	734		3.584	17666.893
	dc.w	$021F	;	543 	54.34 	12.41 	735		3.589	17754.231
	dc.w	$021E	;	542 	54.15 	12.30 	736		3.594	17842.191
	dc.w	$021C	;	540 	53.96 	12.20 	737		3.599	17930.778
	dc.w	$021A	;	538 	53.77 	12.09 	738		3.604	18020.000
	dc.w	$0218	;	536 	53.62 	12.01 	739		3.608	18091.839
	dc.w	$0216	;	534 	53.43 	11.91 	740		3.613	18182.221
	dc.w	$0214	;	532 	53.24 	11.80 	741		3.618	18273.256
	dc.w	$0213	;	531 	53.05 	11.69 	742		3.623	18364.953
	dc.w	$0211	;	529 	52.86 	11.59 	743		3.628	18457.318
	dc.w	$020F	;	527 	52.67 	11.48 	744		3.633	18550.358
	dc.w	$020D	;	525 	52.48 	11.38 	745		3.638	18644.082
	dc.w	$020B	;	523 	52.29 	11.27 	746		3.643	18738.497
	dc.w	$0209	;	521 	52.14 	11.19 	747		3.647	18814.531
	dc.w	$0207	;	519 	51.94 	11.08 	748		3.652	18910.208
	dc.w	$0206	;	518 	51.75 	10.97 	749		3.657	19006.597
	dc.w	$0204	;	516 	51.56 	10.87 	750		3.662	19103.707
	dc.w	$0202	;	514 	51.37 	10.76 	751		3.667	19201.545
	dc.w	$0200	;	512 	51.17 	10.65 	752		3.672	19300.120
	dc.w	$01FE	;	510 	50.98 	10.54 	753		3.677	19399.441
	dc.w	$01FC	;	508 	50.79 	10.44 	754		3.682	19449.514
	dc.w	$01FA	;	506 	50.59 	10.33 	755		3.687	19600.350
	dc.w	$01F8	;	504 	50.44 	10.24 	756		3.691	19681.574
	dc.w	$01F6	;	502 	50.24 	10.14 	757		3.696	19783.804
	dc.w	$01F5	;	501 	50.05 	10.03 	758		3.701	19886.821
	dc.w	$01F3	;	499 	49.85 	9.92  	759		3.706	19990.634
	dc.w	$01F1	;	497 	49.66 	9.81  	760		3.711	20095.252
	dc.w	$01EF	;	495 	49.46 	9.70  	761		3.716	20200.685
	dc.w	$01ED	;	493 	49.27 	9.59  	762		3.721	20306.943
	dc.w	$01EB	;	491 	49.07 	9.48	763		3.726	20414.035
	dc.w	$01E9	;	489 	48.91 	9.39  	764		3.730	20500.315
	dc.w	$01E7	;	487 	48.71 	9.29  	765		3.735	20608.933
	dc.w	$01E5	;	485 	48.52 	9.18  	766		3.740	20718.413
	dc.w	$01E3	;	483 	48.32 	9.07  	767		3.745	20828.765
	dc.w	$01E1	;	481 	48.12 	8.95  	768		3.750	20940.000
	dc.w	$01DF	;	479 	47.92 	8.84  	769		3.755	21052.129
	dc.w	$01DD	;	477 	47.72 	8.73  	770		3.760	21165.161
	dc.w	$01DB	;	475 	47.52 	8.62  	771		3.765	21279.109
	dc.w	$01D9	;	473 	47.32 	8.51  	772		3.770	21393.984
	dc.w	$01D7	;	471 	47.16 	8.42  	773		3.774	21486.558
	dc.w	$01D6	;	470 	46.96 	8.31  	774		3.779	21603.129
	dc.w	$01D4	;	468 	46.76 	8.20  	775		3.784	21720.658
	dc.w	$01D2	;	466 	46.56 	8.08  	776		3.789	21839.158
	dc.w	$01D0	;	464 	46.35 	7.97  	777		3.794	21958.640
	dc.w	$01CE	;	462 	46.15 	7.86  	778		3.799	22079.117
	dc.w	$01CC	;	460 	45.95 	7.75  	779		3.804	22200.602
	dc.w	$01C9	;	457 	45.74 	7.64  	780		3.809	22323.107
	dc.w	$01C8	;	456 	45.58 	7.54  	781		3.813	22421.853
	dc.w	$01C6	;	454 	45.38 	7.43  	782		3.818	22546.227
	dc.w	$01C4	;	452 	45.17 	7.32  	783		3.823	22671.657
	dc.w	$01C2	;	450 	44.97 	7.20  	784		3.828	22798.157
	dc.w	$01C0	;	448 	44.76 	7.09  	785		3.833	22925.741
	dc.w	$01BE	;	446 	44.55 	6.97  	786		3.838	23054.423
	dc.w	$01BC	;	444 	44.35 	6.86  	787		3.843	23184.218
	dc.w	$01BA	;	442 	44.14 	6.74  	788		3.848	23315.139
	dc.w	$01B7	;	439 	43.93 	6.63	789		3.853	23447.201
	dc.w	$01B6	;	438 	43.77 	6.54  	790		3.857	13553.683
	dc.w	$01B4	;	436 	43.56 	6.42  	791		3.862	23687.838
	dc.w	$01B2	;	434 	43.35 	6.30	792		3.867	23823.177
	dc.w	$01AF	;	431 	43.14 	6.19  	793		3.872	23959.716
	dc.w	$01AD	;	429 	42.93 	6.07  	794		3.877	24097.471
	dc.w	$01AB	;	427 	42.72 	5.95  	795		3.882	24236.458
	dc.w	$01A9	;	425 	42.51 	5.84  	796		3.887	24376.694
	dc.w	$01A7	;	423 	42.30 	5.72  	797		3.892	24518.195
	dc.w	$01A5	;	421 	42.13 	5.63  	798		3.896	24632.319
	dc.w	$01A3	;	419 	41.91 	5.51  	799		3.901	24776.142
	dc.w	$01A1	;	417 	41.70 	5.39  	800		3.906	24921.280
	dc.w	$019F	;	415 	41.49 	5.27  	801		3.911	25067.750
	dc.w	$019D	;	413 	41.27 	5.15	802		3.916	25215.572
	dc.w	$019B	;	411 	41.06 	5.03  	803		3.921	25364.764
	dc.w	$0198	;	408 	40.84 	4.91  	804		3.926	25515.345
	dc.w	$0196	;	406 	40.63 	4.79  	805		3.931	25667.334
	dc.w	$0194	;	404 	40.41 	4.67  	806		3.936	25820.752
	dc.w	$0192	;	402 	40.24 	4.58  	807		3.940	25944.528
	dc.w	$0190	;	400 	40.02 	4.46  	808		3.945	26100.569
	dc.w	$018E	;	398 	39.80 	4.33  	809		3.950	26258.095
	dc.w	$018C	;	396 	39.58 	4.21	810		3.955	26417.129
	dc.w	$018A	;	394 	39.36 	4.09  	811		3.960	26577.692
	dc.w	$0187	;	391 	39.14 	3.97  	812		3.965	26739.807
	dc.w	$0185	;	389 	38.92 	3.85  	813		3.970	26903.495
	dc.w	$0183	;	387 	38.70 	3.72  	814		3.975	27068.780
	dc.w	$0181	;	385 	38.52 	3.62  	815		3.979	27202.174
	dc.w	$017F	;	383 	38.30 	3.50  	816		3.984	27370.394
	dc.w	$017D	;	381 	38.08 	3.37  	817		3.989	27540.277
	dc.w	$017B	;	379 	37.85 	3.25  	818		3.994	27711.849
	dc.w	$0178	;	376 	37.63 	3.00  	820		4.004	28060.161
	dc.w	$0174	;	372 	37.18 	2.88  	821		4.009	28236.953
	dc.w	$0172	;	370 	36.95 	2.75  	822		4.014	28415.538
	dc.w	$016F	;	367 	36.72 	2.62  	823		4.019	28595.943
	dc.w	$016D	;	365 	36.54 	2.52  	824		4.023	28741.597
	dc.w	$016B	;	363 	36.32 	2.40  	825		4.028	28925.350
	dc.w	$0169	;	361 	36.09 	2.27  	826		4.033	29111.003
	dc.w	$0167	;	359 	35.86 	2.14  	827		4.038	29298.586
	dc.w	$0164	;	356 	35.63 	2.01  	828		4.043	29488.130
	dc.w	$0162	;	354 	35.40 	1.89  	829		4.048	29679.644
	dc.w	$0160	;	352 	35.16 	1.76  	830		4.053	29873.221
	dc.w	$015D	;	349 	34.93 	1.63  	831		4.058	30068.832
	dc.w	$015B	;	347 	34.70 	1.50  	832		4.063	30266.531
	dc.w	$0159	;	345 	34.51 	1.40  	833		4.067	30426.217
	dc.w	$0157	;	343 	34.28 	1.26  	834		4.072	30627.759
	dc.w	$0154	;	340 	34.04 	1.13	835		4.077	30831.484
	dc.w	$0152	;	338 	33.80 	1.00  	836		4.082	31037.429
	dc.w	$0150	;	336 	33.57 	0.87  	837		4.087	31245.630
	dc.w	$014D	;	333 	33.33 	0.74  	838		4.092	31456.123
	dc.w	$014B	;	331 	33.09 	0.61  	839		4.097	31668.948
	dc.w	$0149	;	329 	32.85 	0.47  	840		4.102	31884.143
	dc.w	$0147	;	327 	32.66 	0.37  	841		4.106	32058.031
	dc.w	$0144	;	324 	32.42 	0.23  	842		4.111	32277.593
	dc.w	$0142	;	322 	32.17 	0.10    843		4.116	32499.638
	dc.w	$013F	;	319 	31.93 	-0.04 	844		4.121	32724.209
	dc.w	$013D	;	317 	31.69 	-0.17 	845		4.126	32951.350
	dc.w	$013A	;	314 	31.44 	-0.31   846		4.131	33181.105
	dc.w	$0138	;	312 	31.20 	-0.45	847		4.136	33413.519
	dc.w	$0136	;	310 	30.95 	-0.58	848		4.141	33648.638
	dc.w	$0133	;	307 	30.70 	-0.72	849		4.146	33886.511
	dc.w	$0131	;	305 	30.50 	-0.83	850		4.150	34078.824
	dc.w	$012F	;	303 	30.25 	-0.97	851		4.155	34321.775
	dc.w	$012C	;	300 	30.00 	-1.11	852		4.160	34567.619
	dc.w	$012A	;	298 	29.75 	-1.25	853		4.165	34816.407
	dc.w	$0127	;	295 	29.50 	-1.39	854		4.170	35068.193
	dc.w	$0125	;	293 	29.25 	-1.53  	855		4.175	35323.030
	dc.w	$0122	;	290 	28.99 	-1.67	856		4.180	35580.976
	dc.w	$011F	;	287 	28.74 	-1.81  	857		4.185	35842.086
	dc.w	$011D	;	285 	28.53 	-1.93  	858		4.189	36053.292
	dc.w	$011B	;	283 	28.28 	-2.07	859		4.194	36320.248
	dc.w	$0118	;	280 	28.02 	-2.21	860		4.199	36590.537
	dc.w	$0116	;	278 	27.76 	-2.36	861		4.204	36864.221
	dc.w	$0113	;	275 	27.50 	-2.50   862		4.209	37141.365
	dc.w	$0110	;	272 	27.24 	-2.65	863		4.214	37422.036
	dc.w	$010E	;	270 	26.98 	-2.79  	864		4.219	37706.300
	dc.w	$010B	;	267 	26.71 	-2.94	865		4.224	37994.227
	dc.w	$0109	;	265 	26.45 	-3.08	866		4.229	38285.888
	dc.w	$0106	;	262 	26.23 	-3.20	867		4.233	38521.956
	dc.w	$0104	;	260 	25.97 	-3.35	868		4.238	38820.525
	dc.w	$0101	;	257 	25.70 	-3.50	869		4.243	39123.038
	dc.w	$00FE	;	254 	25.43 	-3.65  	870		4.248	39429.574
	dc.w	$00FC	;	252 	25.16 	-3.80	871		4.253	39740.214
	dc.w	$00F9	;	249 	24.89 	-3.95	872		4.258	40055.040
	dc.w	$00F6	;	246 	24.62 	-4.10	873		4.263	40374.138
	dc.w	$00F3	;	243 	24.34 	-4.25	874		4.268	40697.596
	dc.w	$00F1	;	241 	24.12 	-4.38	875		4.272	40959.560
	dc.w	$00EE	;	238 	23.84 	-4.53	876		4.277	41291.093
	dc.w	$00EC	;	236 	23.57 	-4.69  	877		4.282	41627.242
	dc.w	$00E9	;	233 	23.29 	-4.84  	878		4.287	41968.107
	dc.w	$00E6	;	230 	23.01 	-5.00	879		4.292	42313.785
	dc.w	$00E3	;	227 	22.72 	-5.15	880		4.297	42664.381
	dc.w	$00E0	;	224 	22.44 	-5.31	881		4.302	43020.000
	dc.w	$00DE	;	222 	22.16 	-5.47	882		4.307	43380.750
	dc.w	$00DB	;	219 	21.87 	-5.63	883		4.312	43746.744
	dc.w	$00D8	;	216 	21.64 	-5.76	884		4.316	44043.392
	dc.w	$00D6	;	214 	21.35 	-5.92	885		4.321	44419.116
	dc.w	$00D3	;	211 	21.06 	-6.08	886		4.326	44800.415
	dc.w	$00D0	;	208 	20.77 	-6.24  	887		4.331	45187.414
	dc.w	$00CD	;	205 	20.48 	-6.40 	888		4.336	45580.241
	dc.w	$00CA	;	202 	20.18 	-6.57	889		4.341	45979.029
	dc.w	$00C7	;	199 	19.88 	-6.73  	890		4.346	46383.914
	dc.w	$00C4	;	196 	19.59 	-6.90  	891		4.351	46795.039
	dc.w	$00C2	;	194 	19.35 	-7.03	892		4.355	47128.527
	dc.w	$00BE	;	190 	19.04 	-7.20	893		4.360	47551.250
	dc.w	$00BB	;	187 	18.74 	-7.37	894		4.365	47980.630
	dc.w	$00B8	;	184 	18.44 	-7.53  	895		4.370	48416.825
	dc.w	$00B5	;	181 	18.13 	-7.71  	896		4.375	48860.000
	dc.w	$00B2	;	178 	17.82 	-7.87  	897		4.380	49310.323
	dc.w	$00AF	;	175 	17.51 	-8.05	898		4.385	49767.967
	dc.w	$00AC	;	172 	17.20 	-8.22	899		4.390	50233.115
	dc.w	$00A9	;	169 	16.89 	-8.40  	900		4.395	50705.950
	dc.w	$00A6	;	166 	16.64 	-8.54  	901		4.399	51089.884
	dc.w	$00A3	;	163 	16.32 	-8.71  	902		4.404	51577.047
	dc.w	$00A0	;	160 	16.00 	-8.89	903		4.409	52072.453
	dc.w	$009D	;	157 	15.68 	-9.07	904		4.414	52576.314
	dc.w	$009A	;	154 	15.35 	-9.25	905		4.419	53088.847
	dc.w	$0096	;	150 	15.03 	-9.43  	906		4.424	53610.278
	dc.w	$0093	;	147 	14.70 	-9.61  	907		4.429	54140.841
	dc.w	$0090	;	144 	14.37 	-9.79	908		4.434	54680.777
	dc.w	$008D	;	141 	14.11 	-9.94	909		4.438	55119.644
	dc.w	$008A	;	138 	13.76 	-10.12	910		4.443	55677.092
	dc.w	$0086	;	134 	13.44 	-10.31	911		4.448	56244.638
	dc.w	$0083	;	131 	13.10 	-10.50	912		4.453	56822.559
	dc.w	$0080	;	128 	12.76 	-10.69	913		4.458	57411.144
	dc.w	$007C	;	124 	12.42 	-10.88	914		4.463	58010.689
	dc.w	$0079	;	121 	12.08 	-11.07	915		4.468	58621.504
	dc.w	$0075	;	117 	11.73 	-11.26	916		4.473	59243.909
	dc.w	$0072	;	114 	11.38 	-11.46	917		4.478	59878.238
	dc.w	$006F	;	111 	11.10 	-11.61	918		4.482	60394.517
	dc.w	$006B	;	107 	10.74 	-11.81	919		4.487	61051.189
	dc.w	$0068	;	104 	10.39 	-12.00	920		4.492	61720.787
	dc.w	$0064	;	100 	10.03 	-12.21	921		4.497	62403.698
	dc.w	$0061	;	97 		9.66  	-12.41	922		4.502	63100.321
	dc.w	$005D	;	93  	9.30  	-12.61	923		4.507	63811.075
	dc.w	$0059	;	89 		8.93  	-12.82	924		4.512	64536.393
	dc.w	$0056	;	86  	8.56  	-13.02	925		4.517	65276.729
	dc.w	$0053	;	83 		8.26  	-13.19	926		4.521	65880.125
	dc.w	$004F	;	79 		7.86  	-13.40	927		4.526	66648.692
	dc.w	$004B	;	75 		7.51  	-13.61	928		4.531	67433.646
	dc.w	$0047	;	71  	7.12  	-13.82	929		4.536	68235.577
	dc.w	$0043	;	67 		6.74  	-14.03	930		4.541	69054.858
	dc.w	$0040	;	64 		6.35  	-14.25	931		4.546	69892.247
	dc.w	$003C	;	60 		5.96  	-14.47	932		4.551	70748.285
	dc.w	$0038	;	56 		5.56  	-14.69	933		4.556	71623.604
	dc.w	$0034	;	52 		5.16  	-14.91	934		4.561	72518.861
	dc.w	$0030	;	48 	    4.84  	-15.09	935		4.565	73249.885
	dc.w	$002C	;	44 		4.44  	-15.31	936		4.570	74182.791
	dc.w	$0028	;   40  	4.03  	-15.54	937		4.575	75137.647
	dc.w	$0024	;	36  	3.61  	-15.77	938		4.580	76115.238
	dc.w	$0020	;	32 		3.20  	-16.00	939		4.585	77116.386
	dc.w	$001C	;	28 		2.78  	-16.23	940		4.590	78141.951
	dc.w	$0018	;	24 		2.35  	-16.47	941		4.595	79192.840
	dc.w	$0013	;	19 	    1.92	-16.71	942		4.600	80270.000
	dc.w	$0010	;	16  	1.58  	-16.90	943		4.604	81151.313
	dc.w	$000B	;	11  	1.14  	-17.14	944		4.609	82278.312
	dc.w	$0007	;	7   	0.70  	-17.39	945		4.614	83434.508
	dc.w	$0003	;	3   	0.25  	-17.64	946		4.619	84621.050
	dc.w	$FFFE	;	-2  	-0.20	-17.89	947		4.624	85839.149
	dc.w	$FFF9	;	-7  	-0.65 	-18.14	948		4.629	87090.081
	dc.w	$FFF5	;	-11 	-1.11	-18.39	949		4.634	88375.191
	dc.w	$FFF0	;	-16 	-1.58	-18.65	950		4.639	89695.900
	dc.w	$FFEC	;	-20  	-2.05	-18.91	951		4.644	91053.708
	dc.w	$FFE8	;	-24 	-2.43	-19.13	952		4.648	92167.727
	dc.w	$FFE3	;	-29 	-2.91   -19.39	953		4.653	93956.369
	dc.w	$FFDE	;	-34 	-3.39   -19.66	954		4.658	95066.784
	dc.w	$FFD9	;	-39 	-3.88 	-19.93	955		4.663	96580.837
	dc.w	$FFD4	;	-44 	-4.38 	-20.21	956		4.668	98140.482
	dc.w	$FFCF	;	-49 	-4.88 	-20.49	957		4.673	99747.829
	dc.w	$FFCA	;	-54 	-5.39	-20.77	958		4.678	101405.093
	dc.w	$FFC5	;	-59 	-5.91	-21.06	959		4.683	103114.637
	dc.w	$FFC0	;	-64 	-6.43	-21.35	960		4.688	104878.974
	dc.w	$FFBB	;	-69 	-6.85	-21.58	961		4.692	106331.688
	dc.w	$FFB6	;	-74 	-7.39  	-21.88	962		4.697	108201.518
	dc.w	$FFB1	;	-79 	-7.93  	-22.18	963		4.702	110134.094
	dc.w	$FFAB	;	-85 	-8.48  	-22.49	964		4.707	112132.628
	dc.w	$FFA6	;	-90 	-9.04   -22.80	965		4.712	114200.556
	dc.w	$FFA0	;	-96 	-9.60 	-23.11	966		4.717	116341.555
	dc.w	$FF9A	;	-102	-10.18	-23.43	967		4.722	118559.568
	dc.w	$FF94	;	-108	-10.76	-23.75	968		4.727	120858.828
	dc.w	$FF90	;	-112	-11.23	-24.02	969		4.731	122759.777
	dc.w	$FF8A	;	-118	-11.83	-24.35	970		4.736	125216.970
	dc.w	$FF84	;	-124	-12.44	-24.69	971		4.741	127769.035
	dc.w	$FF7D	;	-131	-13.05	-25.03	972		4.746	130421.575
	dc.w	$FF77	;	-137	-13.68	-25.38	973		4.751	133180.643
	dc.w	$FF71	;	-143	-14.32	-25.73	974		4.756	136052.787
	dc.w	$FF6A	;	-150	-14.97	-26.09	975		4.761	139045.105
	dc.w	$FF64	;	-156	-15.63	-26.46	976		4.766	142165.299
	dc.w	$FF5D	;	-163	-16.30	-26.84	977		4.771	145421.747
	dc.w	$FF56	;	-170	-16.85	-27.14	978		4.775	148131.111
	dc.w	$FF50	;	-176	-17.55	-27.53	979		4.780	151656.364
	dc.w	$FF49	;	-183	-18.25	-27.92	980		4.785	155345.581
	dc.w	$FF42	;	-190	-18.98	-28.32	981		4.790	159210.476
	dc.w	$FF3B	;	-197	-19.71	-28.73	982		4.795	163263.902
	dc.w	$FF37	;	-201	-20.47	-29.15	983		4.800	167520.000
	dc.w	$FF2C	;	-212	-21.24	-29.58	984		4.805	171994.359
	dc.w	$FF24	;	-220	-22.02	-30.01	985		4.810	176704.211
	dc.w	$FF1D	;	-227	-22.66	-30.37	986		4.814	180654.409
	dc.w	$FF15	;	-235	-23.48	-30.82	987		4.819	185837.680
	dc.w	$FF0D	;	-243	-24.32	-31.29	988		4.824	191315.455
	dc.w	$FF04	;	-252	-25.18	-31.77	989		4.829	197113.567
	dc.w	$FEFB	;	-261	-26.06	-32.25	990		4.834	203260.964
	dc.w	$FEF2	;	-270	-26.96	-32.76	991		4.839	209790.186
	dc.w	$FEE8	;	-280	-27.89	-33.27	992		4.844	216737.949
	dc.w	$FEE4	;	-284	-28.84	-33.80	993		4.849	224145.828
	dc.w	$FED6	;	-298	-29.82	-34.34	994		4.854	232061.096
	dc.w	$FECE	;	-306	-30.63	-34.79	995		4.858	238794.648
	dc.w	$FEC3	;	-317	-31.66	-35.37	996		4.863	247764.526
	dc.w	$FEB9	;	-327	-32.73	-35.96	997		4.868	257413.939
	dc.w	$FEAE	;	-338	-33.83	-36.57	998		4.873	267823.150
	dc.w	$FEA2	;	-350	-34.97	-37.21	999		4.878	279085.574
	dc.w	$FE96	;	-362	-36.16	-37.86	1000	4.883	291310.598
	dc.w	$FE8A	;	-374	-37.38	-38.55	1001	4.888	304627.143
	dc.w	$FE7D	;	-387	-38.66	-39.26	1002	4.893	319188.224
	dc.w	$FE73	;	-397	-39.72	-39.84	1003	4.897	331854.951
	dc.w	$FE65	;	-411	-41.09	-40.61	1004	4.902	349142.449
	dc.w	$FE57	;	-425	-42.53	-41.41	1005	4.907	368288.817
	dc.w	$FE48	;	-440	-44.04	-42.24	1006	4.912	389610.909
	dc.w	$FE38	;	-456	-45.62	-43.12	1007	4.917	413501.928
	dc.w	$FE27	;	-473	-47.29	-44.05	1008	4.922	440455.897
	dc.w	$FE15	;	-491	-49.06	-45.03	1009	4.927	471102.192
	dc.w	$FE03	;	-509	-50.94	-46.08	1010	4.932	506255.294
	dc.w	$FDEE	;	-530	-52.94	-47.19	1011	4.937	546988.254
	dc.w	$FDDD	;	-547	-54.65	-48.14	1012	4.941	584545.424
	dc.w	$FDC6	;	-570	-56.95	-49.41	1013	4.946	639316.296
	dc.w	$FDAE	;	-594	-59.41	-50.79	1014	4.951	705264.898
	dc.w	$FD93	;	-621	-62.13	-52.29	1015	4.956	786201.818
	dc.w	$FD75	;	-651	-65.14	-53.96	1016	4.961	887891.795
	dc.w	$FD53	;	-685	-68.51	-55.84	1017	4.966	1019490.588	
	dc.w	$FD2C	;	-724	-72.36	-57.98	1018	4.971	1196468.276	
	dc.w	$FCFF	;	-769	-76.86	-60.48	1019	4.976	1447186.667
	dc.w	$FCD5	;	-811	-81.11	-62.84	1020	4.980	1738020.000
	dc.w	$FC93	;	-877	-87.67	-66.48	1021	4.985	2319686.667
	dc.w	$FC3A	;	-966	-96.61	-71.45	1022	4.990	3483020.000	
	dc.w	$3E80	;	1600	160.00	 71.11	1023	4.995	Default to 160F (sensor failure)

;*****************************************************************************************
;*****************************************************************************************
;                              CONFIGURABLE CONSTANTS
;*****************************************************************************************
; - Configurable constants
;   - VE table and constants
;   - ST table and constants
;   - AFR table and constants
;
;*****************************************************************************************


            ORG   $7000  ;Memory location  $7000, global address $7F7000 


;*****************************************************************************************
; Page 1 copied into RAM on start up. All pages 1024 bytes
; VE table, ranges and other configurable constants 
; veBins values are %x10, verpmBins values are RPM, vemapBins values 
; are KPAx10
;*****************************************************************************************

; 3/24/22 VE Analyze (modified slightly)

veBins_F:         ; (% X 10) (512 bytes)(offset = 0)           
       ;ROW------------> 
    dc.w $01A4,$01A4,$019A,$019A,$0186,$019A,$01A4,$01A4,$01A4,$01A4,$01A4,$01A4,$01A4,$01A4,$01A4,$01A4 ; C
;        420,  420,  410,  410,  390,  410,  420,  420,  420,  420,  420,  420,  420,  420,  420,  420   ; O
    dc.w $01AE,$01AE,$01AE,$01A4,$0186,$019A,$01A4,$01A4,$01A4,$01A4,$01A4,$01A4,$01A4,$01A4,$01A4,$01A4 ; L
;        430,  430,  430,  420,  390,  410,  420,  420,  420,  420,  420,  420,  420,  420,  420,  420   ; |
    dc.w $01CC,$01CC,$01C2,$01B8,$01B8,$01B8,$01B8,$01B8,$01B8,$01C2,$01C2,$01CC,$01CC,$01CC,$01CC,$01CC ; | 
;        460,  460,  450,  440,  440,  440,  440,  440,  440,  450,  450,  460,  460,  460,  460,  460   ; |
    dc.w $0244,$0244,$0212,$01CC,$01CC,$01D6,$01E0,$01EA,$01EA,$01EA,$01EA,$01EA,$01EA,$01EA,$01EA,$01EA ; | 
;        580,  580,  530,  460,  460,  470,  480,  490,  490,  490,  490,  490,  490,  490,  490,  490   ; |
    dc.w $026C,$026C,$023A,$01F4,$01E0,$01F4,$01FE,$0208,$0212,$0212,$021C,$0226,$0226,$0226,$0226,$0226 ; |
;        620,  620,  570,  500,  480,  500,  510,  520,  530,  530,  540,  550,  550,  550,  550,  550   ; V
    dc.w $02E4,$02E4,$0262,$0212,$01FE,$0208,$0212,$0226,$0230,$023A,$0244,$024E,$024E,$024E,$024E,$024E ;  
;        740,  740,  610,  530,  510,  520,  530,  550,  560,  570,  580,  590,  590,  590,  590,  590   ;
    dc.w $0334,$0334,$0276,$0226,$0208,$0212,$0226,$0230,$023A,$024E,$024E,$0258,$0258,$0258,$0258,$0258 ;  
;        820,  820,  630,  550,  520,  530,  550,  560,  570,  590,  590,  600,  600,  600,  600,  600   ;
    dc.w $0334,$0334,$028A,$0244,$021C,$0226,$023A,$0244,$024E,$024E,$0258,$0262,$0262,$0262,$0262,$0262 ;
;        820,  820,  650,  580,  540,  550,  570,  580,  590,  590,  600,  610,  610,  610,  610,  610   ;
    dc.w $0334,$0334,$02A8,$024E,$0230,$023A,$024E,$024E,$0258,$0276,$0276,$0276,$0276,$0276,$0276,$0276 ;
;        820,  820,  680,  590,  560,  570,  590,  590,  600,  630,  630,  630,  630,  630,  630,  630   ;
    dc.w $0334,$0334,$02E4,$0276,$0244,$024E,$0258,$026C,$0276,$0276,$0276,$0276,$0276,$0276,$0276,$0276 ;
;        820,  820,  740,  630,  580,  590,  600,  620,  630,  630,  630,  630,  630,  630,  630,  630   ;
    dc.w $0334,$0334,$0302,$0294,$0294,$0294,$029E,$02A8,$0294,$0276,$0276,$0276,$0276,$0276,$0276,$0276 ; 
;        820,  820,  770,  660,  660,  660,  670,  680,  660,  630,  630,  630,  630,  630,  630,  630   ;
    dc.w $0334,$0334,$0334,$032A,$02F8,$02E4,$0302,$02EE,$02BC,$02BC,$029E,$029E,$029E,$029E,$029E,$029E ;
;        820,  820,  820,  810,  760,  740,  770,  750,  690,  690,  670,  670,  670,  670,  670,  670   ;
    dc.w $033E,$033E,$0348,$035C,$035C,$035C,$0352,$0348,$0352,$037A,$0384,$03B6,$03E8,$03E8,$03E8,$03E8 ;
;        830,  830,  840,  860,  860,  860,  850,  840,  850,  890,  900,  950,  1000, 1000, 1000, 1000  ;
    dc.w $033E,$033E,$0348,$0366,$0370,$037A,$037A,$038E,$0398,$03AC,$03AC,$03C0,$03E8,$03E8,$03E8,$03E8 ;
;        830,  830,  840,  870,  880,  890,  890,  910,  920,  940,  940,  960,  1000, 1000, 1000, 1000  ;
    dc.w $0348,$0348,$0348,$0366,$0370,$037A,$0384,$0398,$03A2,$03B6,$03B6,$03CA,$03E8,$03E8,$03E8,$03E8 ;
;        840,  840,  840,  870,  880,  890,  900,  920,  930,  950,  950,  970,  1000, 1000, 1000, 1000  ;
    dc.w $0348,$0348,$0348,$0366,$0370,$037A,$038E,$0398,$03AC,$03C0,$03CA,$03D4,$03E8,$03E8,$03E8,$03E8 ;
;        840,  840,  840,  870,  880,  890,  910,  920,  940,  960,  970,  980,  1000, 1000, 1000, 1000  ;

verpmBins_F:       ; row bin(32 bytes)(offset = 512)($0200)
    dc.w $190,$28A,$384,$47E,$578,$672,$76C,$866,$960,$A5A,$B54,$C4E,$D48,$E42,$F3C,$1036
; RPM     400, 650, 900,1150,1400,1650,1900,2150,2400,2650,2900,3150,3400,3650,3900,4150

vemapBins_F:       ; column bins(32 bytes)(offset = 544)($0220)    
    dc.w $FA,$12C,$15E,$190,$1C2,$1F4,$226,$258,$28A,$2BC,$2EE,$320,$352,$384,$3B6,$3E8
;KPAx10  250,300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950,1000
; ADC    136, 183, 230, 277, 323, 370, 417, 464, 511, 558, 605, 652, 699, 746, 793,840
; V     .66, .89,1.12,1.35,1.58,1.81,2.04,2.27,2.50,2.73,2.96,3.19,3.42,3.65,3.88,4.11

barCorVals_F:      ; 18 bytes for barometric correction values (KpA x 10)(offset = 576)($0240)
    dc.w $0316,$0334,$0352,$0370,$038E,$03AC,$03CA,$03E8,$0406
;          790,  820,  850,  880,  910,  940,  970, 1000, 1030
    
barCorDelta_F:     ; 18 bytes for barometric correction  (% x 10)(offset = 594)($0252)
    dc.w $0456,$0447,$0438,$0429,$041A,$040B,$03FC,$03ED,$03DE
;         1110, 1095, 1080, 1065, 1050, 1035, 1020, 1005, 990
    
dwellvolts_F:      ; 12 bytes for dwell battery correction (volts x 10)(offset = 612)($0264)
    dc.w $003C,$0050,$0064,$0078,$008C,$00A0
;           60,   80,  100,  120,  140,  160

dwellcorr_F:       ; 12 bytes for dwell battery correction (% x 10)(offset = 624)($0270)

    dc.w $1388,$09B0,$0690,$0500,$03FC,$0370
;         5000, 2480, 1680, 1280, 1020,  880
    
tempTable1_F:      ; 20 bytes for table common temperature values (degrees C or F x 10)(offset = 636)($027C)
    dc.w $FF9A,$FFFE,$0003,$0216,$02E9,$03BB,$048F,$0562,$0634,$070C 
;         -102,  -2,    3,  534,  745, 955, 1167, 1378, 1588, 1804
    
tempTable2_F:      ; 20 bytes for table common temperature values (degrees C or F x 10)(offset = 656)($0290)
    dc.w $FF9A,$FFFE,$0003,$0216,$02E9,$03BB,$048F,$0562,$0634,$070C 
;         -102,  -2,    3,  534,  745, 955, 1167, 1378, 1588, 1804
    
matCorrTemps2_F:   ; 18 bytes for MAT correction temperature (degrees C or F x 10)(offset = 676)($02A4)
    dc.w $FE73,$FFFE,$0003,$0259,$035C,$046A,$0578,$0798,$09AD
;         -397,   -2,    3,  601,  860, 1130, 1400, 1944, 2477
    
matCorrDelta2_F:   ; 18 bytes for MAT correction (% x 10)(offset = 694)($02B6)
    dc.w $04E9,$047D,$047C,$03F9,$03C7,$0399,$0370,$0327,$02EA
;         1257, 1149, 1148, 1017,  967,  921,  880,  807,  746
    
primePWTable_F:    ; 20 bytes for priming pulse width (msec x 10)(offset = 712)($02C8)
    dc.w $028F,$0282,$0281,$021D,$01EE,$01AB,$015D,$0121,$00E1,$009E
;          655,  642,  641,  541,  494,  427,  349,  289,  225,  158   
    
crankPctTable_F:   ; 20 bytes for cranking pulsewidth adder (% x 10 of reqFuel)(offset = 732)($02DC)
    dc.w $0CB2,$0C3E,$0C3A,$09C4,$08CA,$07D0,$06D6,$05DC,$04E2,$03E8
;         3250, 3134, 3130, 2500, 2250, 2000, 1750, 1500, 1250, 1000

asePctTable_F:     ; 20 bytes for after start enrichment adder (% x 10)(offset = 752)($02F0)
    dc.w $0208,$01FA,$01FA,$01AE,$0190,$0172,$0154,$0136,$0118,$00FA
;          520,  506,  506,  430,  400,  370,  340,  310,  280,  250

aseRevTable_F:     ; 20 bytes for after start enrichment time (engine revolutions)(offset = 772)($0304)
    dc.w $0190,$0186,$0185,$014D,$0137,$0121,$010B,$00F5,$00DF,$00C8
;          400,  390,  389,  333,  311,  289,  267,  245,  223,  200
    
wueBins_F:         ; 20 bytes for after warm up enrichment adder (% x 10)(offset = 792)($0318)
    dc.w $07D0,$0776,$076C,$05AA,$0528,$04C4,$047E,$0438,$0406,$03E8
;         2000, 1910, 1900, 1450, 1320, 1220, 1150, 1080, 1030, 1000 
    
TOEbins_F:         ; 8 bytes for Throttle Opening Enrichment adder percent (%)(offset = 812)($032C)
;    dc.w $0014,$0019,$001E,$0023
;           20%,  25%,  30%,  35%
    dc.w $0006,$000F,$001E,$0028
;           6%,  15%,  30%,  40% (MS3 default)

TOErates_F:        ; 8 bytes for Throttle Opening Enrichment rate (TpsPctDOT x 10)(offset = 820)($0334)
;    dc.w $0032,$0064,$00FA,$01F4
;           50,  100,  250,  500
    dc.w $00D2,$0190,$0320,$03E8
;          210,  400,  800, 1000 (MS3 default)

DdBndBase_F:       ; 2 bytes for injector deadband at 13.2V (mSec * 100)(offset = 828)($033C)
    dc.w $005A     ; 90 = .9mS
    
DdBndCor_F:        ; 2 bytes for injector deadband voltage correction (mSec/V x 100)(offset = 830)($033E)
    dc.w $0012     ; 18 = .18mS/V
                	
tpsThresh_F:       ; 2 bytes for Throttle Opening Enrichment threshold (%/Sec)(offset = 832)($0340)
;    dc.w $0031     ; 49 = 49% per Sec
    dc.w $00C8     ; 200 = 200% per Sec (MS3 default)
    
TOEtime_F:         ; 2 bytes for Throttle Opening Enrich time in 100mS increments(mSx10)(offset = 834)($0342)
    dc.w $0005     ; 5 = 0.5 Sec

ColdAdd_F:         ; 2 bytes for Throttle Opening Enrichment cold temperature adder percent at -40F (%)(offset = 836)($0344)
    dc.w $0014     ; 20%
    
ColdMul_F:         ; 2 bytes for Throttle Opening Enrichment multiplyer percent at -40F (%)(offset = 838)($0346)
    dc.w $0082     ; 130% 
	
InjDelDegx10_F:    ; 2 bytes for Injection delay from trigger to start of injection (deg x 10) (offset = 840)($0348)            
    dc.w $0002     ; 2 = 0.2 degree (Only here to keep the timer channel happy)
;    dc.w $021C     ; 540 = 54 degrees	
	
OFCtps_F:          ; 2 bytes for Overrun Fuel Cut min TpS%x10(offset = 842)($034A)
    dc.w $0014     ; 20 = 2%
	
OFCrpm_F:          ; 2 bytes for Overrun Fuel Cut min RPM(offset = 844)($034C)
    dc.w $0384     ; 900
    
crankingRPM_F:     ; 2 bytes for crank/run transition (RPM)(offset = 846)($034E)
    dc.w $012C     ; 300
    
floodClear_F:      ; 2 bytes for TPS position for flood clear (% x 10)(offset = 848)($0350)
    dc.w $0384     ; 900
	
Stallcnt_F:        ; 2 bytes for no crank or stall condition counter (1mS increments) (offset = 850)($0352)
    dc.w $07D0       ; 2000 = 2 seconds
	
tpsMin_F:          ; 2 bytes for TPS calibration closed throttle ADC(offset = 852)($0354)
;    dc.w $007D     ; 125 (Test Engine)
    dc.w $0092     ; 146 (Morgan)
    
tpsMax_F:          ; 2 bytes for TPS calibration wide open throttle ADC(offset = 854)($0356)
;    dc.w $02DD     ; 733 (Test Engine)
    dc.w $02D0     ; 720 (Morgan)
	
reqFuel_F:         ; 2 bytes for Pulse width for 14.7 AFR @ 100% VE (mS x 10)(offset = 856)($0358)
    dc.w $00D5     ; 0213 = 21.3 mS

enginesize_F:      ; 2 bytes for displacement of two engine cylinders (for TS reqFuel calcs only)(cc)(offset = 858)($035A)
    dc.w $640      ; 1600
	
InjPrFlo_F         ; 2 bytes for Pair of injectors flow rate (CC/Min)(offset = 860)($035C) 
    dc.w $03BC     ; 278 CC/Min x 2 = 574 CC/Min /60 = 9.56 CC/Sec x 100 = 956 Decimal 956 = $03BC
	
staged_pri_size_F: ; 1 byte for flow rate of 1 injector (for TS reqFuel calcs only)(cc)(offset = 862)($035E)
    dc.b $FC       ; 252
    
alternate_F:       ; 1 byte for injector staging bit field (for TS reqFuel calcs only)(offset = 863)($035F)
    dc.b $00       ; 0
    
nCylinders_F:      ; 1 byte for number of engine cylinders bit field (for TS reqFuel calcs only)(offset = 864)($0360)
    dc.b $02         ; 2
    
nInjectors_F:      ; 1 byte for number of injectors bit field (for TS reqFuel calcs only)(offset = 865)($0361)
    dc.b $02       ; 2
    
divider_F:         ; 1 byte for squirts per cycle bit field (for TS reqFuel calcs only)(offset = 866)($0362)
    dc.b $01       ; 1

	
MinCKP_F:          ; 1 byte for minimum CKP triggers before RPM period calculations (offset = 867)($0363)
    dc.b $01       ; 1

; 867 + 1 = 868 bytes used, 1024 - 868 = 156 bytes left

;*****************************************************************************************

           ORG   $7400  ;Memory location  $7400, global address $7F7400 

;*****************************************************************************************
; Page 2 copied into RAM on start up. All pages 1024 bytes
; ST table, ranges and other configurable constants 
; stBins values are degrees x10, strpmBins values are RPM,  
; stmapBins values are KPAx10
;*****************************************************************************************

; Reduce timing at 100 KPA
stBins_F:         ; (Degrees X 10)(512 bytes)(offset = 0)           
       ;ROW------------>
    dc.w $00C8,$00D8,$00E9,$00F9,$0109,$011A,$012A,$013A,$014A,$015B,$016B,$017C,$017C,$017C,$017C,$017C ; C
;        200,  216,  233,  249,  265,  282,  298,  314,  330,  347,  363,  380,  380,  380,  380,  380   ; O
    dc.w $00C8,$00D8,$00E9,$00F9,$0109,$011A,$012A,$013A,$014A,$015B,$016B,$017C,$017C,$017C,$017C,$017C ; L
;        200,  216,  233,  249,  265,  282,  298,  314,  330,  347,  363,  380,  380,  380,  380,  380   ; | 
    dc.w $00C8,$00D8,$00E9,$00F9,$0109,$011A,$012A,$013A,$014A,$015B,$016B,$017C,$017C,$017C,$017C,$017C ; | 
;        200,  216,  233,  249,  265,  282,  298,  314,  330,  347,  363,  380,  380,  380,  380,  380   ; | 
    dc.w $00C8,$00D8,$00E9,$00F9,$0109,$011A,$012A,$013A,$014A,$015B,$016B,$017C,$017C,$017C,$017C,$017C ; | 
;        200,  216,  233,  249,  265,  282,  298,  314,  330,  347,  363,  380,  380,  380,  380,  380   ; |
    dc.w $00C8,$00D8,$00E9,$00F9,$0109,$011A,$012A,$013A,$014A,$015B,$016B,$017C,$017C,$017C,$017C,$017C ; V
;        200,  216,  233,  249,  265,  282,  298,  314,  330,  347,  363,  380,  380,  380,  380,  380   ; 
    dc.w $00C8,$00D8,$00E9,$00F9,$0109,$011A,$012A,$013A,$014A,$015B,$016B,$017C,$017C,$017C,$017C,$017C ; 
;        200,  216,  233,  249,  265,  282,  298,  314,  330,  347,  363,  380,  380,  380,  380,  380   ; 
    dc.w $00BA,$00CA,$00DA,$00EA,$00FA,$010B,$011B,$012B,$013B,$014B,$015B,$016B,$016B,$016B,$016B,$016B ;
;        186,  202,  218,  234,  250,  267,  283,  299,  315,  331,  347,  363,  363,  363,  363,  363   ;
    dc.w $00AC,$00BC,$00CC,$00DB,$00EB,$00FB,$010B,$011B,$012A,$013A,$014A,$015A,$015A,$015A,$015A,$015A ;  
;        172,  188,  204,  219,  235,  251,  267,  283,  298,  314,  330,  346,  346,  346,  346,  346   ;
    dc.w $009E,$00AE,$00BD,$00CD,$00DC,$00EC,$00FB,$010A,$011A,$012A,$0139,$0149,$0149,$0149,$0149,$0149 ;  
;        158,  174,  189,  205,  220,  236,  251,  266,  282,  298,  313,  329,  329,  329,  329,  329   ;
    dc.w $0090,$009F,$00AF,$00BE,$00CD,$00DD,$00EA,$00FB,$010A,$011A,$0129,$0138,$0138,$0138,$0138,$0138 ;
;        144,  159,  175,  190,  205,  221,  234,  251,  266,  282,  297,  312,  312,  312,  312,  312   ;
    dc.w $0082,$0091,$00A0,$00AF,$00BE,$00CD,$00DC,$00EB,$00FA,$0109,$0118,$0127,$0127,$0127,$0127,$0127 ;
;        130,  145,  160,  175,  190,  205,  220,  235,  250,  265,  280,  295,  295,  295,  295,  295   ;
    dc.w $0074,$0083,$0091,$00A0,$00AF,$00BE,$00CC,$00DB,$00EA,$00F8,$0107,$0116,$0116,$0116,$0116,$0116 ;
;        116,  131,  145,  160,  175,  190,  204,  219,  234,  248,  263,  278,  278,  278,  278,  278   ;
    dc.w $0066,$0075,$0083,$0092,$00A0,$00AF,$00BD,$00CC,$00DA,$00E9,$00F7,$0105,$0105,$0105,$0105,$0105 ; 
;        102,  117,  131,  146,  160,  175,  189,  204,  218,  233,  247,  261,  261,  261,  261,  261   ;
    dc.w $0058,$0066,$0074,$0083,$0091,$009F,$00AD,$00BB,$00CA,$00D8,$00E6,$00F4,$00F4,$00F4,$00F4,$00F4 ;
;         88,  102,  116,  131,  145,  159,  173,  187,  202,  216,  230,  244,  244,  244,  244,  244   ;
    dc.w $004A,$0058,$0066,$0074,$0082,$0090,$009D,$00AB,$00B9,$00C7,$00D5,$00E3,$00E3,$00E3,$00E3,$00E3 ;
;         74,   88,  102,  116,  130,  144,  157,  171,  185,  199,  213,  227,  227,  227,  227,  227   ;
    dc.w $003C,$004A,$0057,$0065,$0072,$0080,$008E,$009B,$00A9,$00B6,$00C4,$00D2,$00D2,$00D2,$00D2,$00D2 ;
;         60,   74,   87,  101,  114,  128,  142,  155,  169,  182,  196,  210,  210,  210,  210,  210   ;

strpmBins_F:       ; row bins (32 bytes)(offset = 512)($0200)
    dc.w $190,$28A,$384,$47E,$578,$672,$76C,$866,$960,$A5A,$B54,$C4E,$D48,$E42,$F3C,$1036
; RPM     400, 650, 900,1150,1400,1650,1900,2150,2400,2650,2900,3150,3400,3650,3900,4150

stmapBins_F:       ; column bins (32 bytes)(offset = 544)($0220)   
    dc.w $FA,$12C,$15E,$190,$1C2,$1F4,$226,$258,$28A,$2BC,$2EE,$320,$352,$384,$3B6,$3E8
;KPAx10  250,300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950,1000
; ADC    136, 183, 230, 277, 323, 370, 417, 464, 511, 558, 605, 652, 699, 746, 793,840
; V     .66, .89,1.12,1.35,1.58,1.81,2.04,2.27,2.50,2.73,2.96,3.19,3.42,3.65,3.88,4.11

Dwell_F         ; 2 bytes for run mode dwell time (mSec*10)(offset = 576)($0240)
   dc.w $0028   ; 40 = 4.0mSec

CrnkDwell_F     ; 2 bytes for crank mode dwell time (mSec*10)(offset = 578)($0242)      NOT USED
   dc.w $003C   ; 60 = 6.0 mSec

CrnkAdv_F       ; 2 bytes for crank mode ignition advance (Deg*10)(offset = 580)($0244) NOT USED
   dc.w $0064   ; 100 = 10.0 degrees   

; 580 + 2 = 582 bytes used, 1024 - 582 = 442 bytes left

;*****************************************************************************************

           ORG   $7800  ;Memory location  $7800, Global address $7F7800 

;*****************************************************************************************
; Page 3 copied into RAM on start up. All pages 1024 bytes
; AFR table, ranges and other configurable constants 
; afrBins values are Air Fuel Ratio x10, afrrpmBins values are RPM,  
; afrmapBins values are KPAx10
;*****************************************************************************************

afrBins_F:         ; (AFR X 100) (512 bytes)(offset = 0)           
       ;ROW------------> 
    dc.w  $0514,$0514,$0514,$0618,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4 ; C
;         1300, 1300, 1300, 1560, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700  ; O
    dc.w  $0514,$0514,$0514,$0618,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4 ; L
;         1300, 1300, 1300, 1560, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700  ; |
    dc.w  $0514,$0514,$0514,$0618,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4 ; |
;         1300, 1300, 1300, 1560, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700  ; |
    dc.w  $0514,$0514,$0596,$0618,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4 ; |
;         1300, 1300, 1430, 1560, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700  ; |
    dc.w  $0514,$0514,$0596,$0618,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4 ; |
;         1300, 1300, 1430, 1560, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700  ; |
    dc.w  $0514,$0514,$0596,$0618,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4 ; V
;         1300, 1300, 1430, 1560, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700  ;
    dc.w  $0514,$0514,$0596,$0618,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4 ; 
;         1300, 1300, 1430, 1560, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700  ;
    dc.w $0514,$0514,$0596,$0618,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4  ; 
;         1300, 1300, 1430, 1560, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700  ;
    dc.w  $0514,$0514,$0596,$0618,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4 ; 
;         1300, 1300, 1430, 1560, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700  ;
    dc.w $0514,$0514,$0596,$0618,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4,$06A4  ; 
;         1300, 1300, 1430, 1560, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700, 1700  ;
    dc.w  $0514,$0514,$0596,$0618,$0618,$0618,$0618,$0618,$0618,$0618,$0618,$0618,$0618,$0618,$0618,$0618 ; 
;         1300, 1300, 1430, 1560, 1560, 1560, 1560, 1560, 1560, 1560, 1560, 1560, 1560, 1560, 1560, 1560  ;
    dc.w  $0514,$0514,$0596,$0596,$0596,$0596,$0596,$0596,$0596,$0596,$0596,$0596,$0596,$0596,$0596,$0596 ; 
;         1300, 1300, 1430, 1430, 1430, 1430, 1430, 1430, 1430, 1430, 1430, 1430, 1430, 1430, 1430, 1430  ;
    dc.w  $0514,$0514,$0514,$0514,$0514,$0514,$0514,$0514,$0514,$0514,$0514,$0514,$0514,$0514,$0514,$0514 ; 
;         1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300  ; 
    dc.w  $0514,$0514,$0514,$0514,$050A,$050A,$050A,$0500,$0500,$0500,$04F6,$04F6,$04F6,$04EC,$04EC,$04EC ; 
;         1300, 1300, 1300, 1300, 1290, 1290, 1290, 1280, 1280, 1280, 1270, 1270, 1270, 1260, 1260, 1260  ; 
    dc.w  $0514,$0514,$0514,$0514,$050A,$050A,$050A,$0500,$0500,$0500,$04F6,$04F6,$04F6,$04EC,$04EC,$04EC ; 
;         1300, 1300, 1300, 1300, 1290, 1290, 1290, 1280, 1280, 1280, 1270, 1270, 1270, 1260, 1260, 1260  ;  
    dc.w  $0514,$0514,$0514,$0514,$050A,$050A,$050A,$0500,$0500,$0500,$04F6,$04F6,$04F6,$04EC,$04EC,$04EC ; 
;         1300, 1300, 1300, 1300, 1290, 1290, 1290, 1280, 1280, 1280, 1270, 1270, 1270, 1260, 1260, 1260  ; 


afrrpmBins_F:       ; row bins (32 bytes)(offset = 512)($0200)
    dc.w $190,$28A,$384,$47E,$578,$672,$76C,$866,$960,$A5A,$B54,$C4E,$D48,$E42,$F3C,$1036
; RPM     400, 650, 900,1150,1400,1650,1900,2150,2400,2650,2900,3150,3400,3650,3900,4150

afrmapBins_F:       ; column bins (32 bytes)(offset = 544)($0220)   
    dc.w $FA,$12C,$15E,$190,$1C2,$1F4,$226,$258,$28A,$2BC,$2EE,$320,$352,$384,$3B6,$3E8
;KPAx10  250,300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950,1000
; ADC    136, 183, 230, 277, 323, 370, 417, 464, 511, 558, 605, 652, 699, 746, 793,840
; V     .66, .89,1.12,1.35,1.58,1.81,2.04,2.27,2.50,2.73,2.96,3.19,3.42,3.65,3.88,4.11

; 544 + 32 = 576 bytes used, 1024 - 576 = 448 bytes left

;*****************************************************************************************

;*****************************************************************************************
;                     INTERRUPT VECTORS (address $FF10 to $FFFF)                         
;*****************************************************************************************

    ORG   $FF4A
    
    DC.W  ISR_TIM_TC5  ; TIM ch5 ISR Vector
    DC.W  ISR_TIM_TC4  ; TIM ch4 ISR Vector
    DC.W  ISR_TIM_TC3  ; TIM ch3 ISR Vector
    DC.W  ISR_TIM_TC2  ; TIM ch2 ISR Vector
    DC.W  ISR_TIM_TC1  ; TIM ch1 ISR Vector
    DC.W  ISR_TIM_TC0  ; TIM ch0 ISR Vector
    
     ORG   $FFD6
    
    DC.W  SCI0_ISR     ; SCI0 ISR Vector
    
    ORG   $FFE0
    
    DC.W  ISR_ECT_TC7  ;ECT ch7 ISR Vector
    DC.W  ISR_ECT_TC6  ;ECT ch6 ISR Vector
    DC.W  ISR_ECT_TC5  ;ECT ch5 ISR Vector
    DC.W  ISR_ECT_TC4  ;ECT ch4 ISR Vector
    DC.W  ISR_ECT_TC3  ;ECT ch3 ISR Vector
    DC.W  ISR_ECT_TC2  ;ECT ch2 ISR Vector
    DC.W  ISR_ECT_TC1  ;ECT ch1 ISR Vector
    DC.W  ISR_ECT_TC0  ;ECT ch0 ISR Vector

    ORG   $FFF0
    
    DC.W  RTI_ISR      ; RTI ISR Vector

    ORG   $FFFA
    
    DC.W  Entry        ; COP ISR Vector
    DC.W  Entry        ; Clock Monitor ISR Vector
    DC.W  Entry        ; External Reset ISR Vector
    

    













