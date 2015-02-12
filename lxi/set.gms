* =========================================================================================
* Version Control Information:
* $Id: set.gms 941 2011-03-29 19:15:55Z renger $
* =========================================================================================

*       Define rows and columns with respect to the underlying Input-Output-Table

SETS
    OVERALL  All the elements of the SAM    /
                AGR      1    Erzeugnisse der Landwirtschaft und Jagd
                FRP      2    Forstwirtschaftliche Erzeugnisse und DL
                FIS      3    Fische und Fischereierzeugnisse
                COA      4    Kohle und Torf
                CRU      5    Erdoel und Erdgas
                SLC      8    Steine und Erden sonstige Bergbauerzeugnisse
                FOD      9    Nahrungs- und Futtermittel
                BEV     10    Getraenke
                TOB     11    Tabakerzeugnisse
                TEX     12    Textilien
                CLO     13    Bekleidung
                LEA     14    Leder und Lederwaren
                TIM     15    Holzwaren
                PAP     16    Papier und Pappe
                PPP     17    Papier- und Pappeerzeugnisse
                PUB     18    Verlagserzeugnisse
                PRI     19    Druckerzeugnisse
                OIL     20    Kokereier- und Mineraloelerzeugnisse
                PHA     21    Pharmazeutische Erzeugnisse
                CHM     22    Chemische Erzeugnisse (ohne pharmazeutische Erzeugnisse)
                RUB     23    Gummiwaren
                SYN     24    Kunststoffwaren
                GLA     25    Glas
                STO     26    Keramik
                CIR     27    Roheisen Stahl Rohre und Halbzeug daraus
                NIM     28    NE-Metalle und Halbzeug daraus
                FND     29    Giessereierzeugnisse
                MPR     30    Metallerzeugnisse
                MAC     31    Maschinen
                OFF     32    Bueromaschinen und Datenverarbeitungsgeraete
                EGD     33    Geraete der Elektrizitaetserzeugung  -verteilung
                COM     34    Nachrtechnische  Rundfunk- und Fernsehgeraete  Elektronische Bauelemente
                MED     35    Medizinmess- und regelungstechnik
                VEH     36    Kraftwagen und Kraftwagenteile
                WRA     37    Sonstige Fahrzeuge (Wasser-  Schienen-  Luftfahrzeuge )
                FOM     38    Moebel  Schmuck  Musikinstrumente  Sportgeraete  Spielwaren
                SEC     39    Sekundaerrohstoffe
                ELE     40    Elektrizität Fernwärme DL der Elektrizitäts- und Fernwärmeversorgung
                GAS     41    Gase DL der Gasversorgung
                WAT     42    Wasser und DL der Wasserversorgung
                CST     43    Vorb. Baustellenarbeiten Hoch- und Tiefbauarbeiten
                EXT     44    Bauinstallations- und sonstige Bauarbeiten
                CAR     45    Handelsleistungen mit Kfz
                WHO     46    Handelsvermittlungs- und Grosshandelsleistungen
                RTR     47    Einzelhandelsleistungen Reparatur an Gebrauchsguetern
                HOT     48    Beherbergungs- und Gaststaetten-DL
                RLW     49    DL der Eisenbahnen
                TRA     50    DL d. sonst. Landverkehrs Transportleistungen in Rohrfernleitungen
                SHI     51    Schifffahrtsleistungen
                AIR     52    Luftfahrtleistungen
                STR     53    DL bezueglich Hilfs- und Nebentaetigkeiten fuer den Verkehr
                CES     54    Nachrichtenuebermittlungs-DL
                FIN     55    DL der Kreditinstitute
                INS     56    DL der Versicherungen (ohne Sozialversicherung)
                CRE     57    DL des Kredit- und Versicherungshilfsgewerbes
                RES     58    DL des Grundstuecks- und Wohnungswesens
                LEN     59    DL der Vermietung beweglichen Sachen (ohne Personal)
                DAT     60    DL der Datenverarbeitung und von Datenbanken
                RED     61    Forschungs- und Entwicklungsleistungen
                ENT     62    Unternehmensbezogene DL
                GOV     63    DL der oeffentlichen Verwaltung  Verteidigung
                SIN     64    Sozialversicherung
                EDU     65    Erziehungs- und Unterrichts-DL
                HEA     66    DL des Gesundheits-  Veterinaer- und Sozialwesens
                DIS     67    Abwasser-  Abfallbeseitigung- und sonstige Entsorgungsleistungen
                IGR     68    DL von Interessenvertretungen  Kirchen
                CUL     69    Kultur- und Sport- und Unterhaltungs-DL
                OTH     70    Sonstige DL
                PRH     71    DL privater Haushalte
                TOTINT  72    Vorleistungen der Produktionsbereiche
                NETPTX  73    Guetersteuern abzueglich Guetersubventionen
                INTTOT  74    Vorleistung der Produktionsbereiche inclusive NETPTX
                WAGES   75    Arbeitnehmerentgelt im Inland
                NETTRN  76    Sonstige Produktionsabgaben abzueglich sonstige Subventionen
                RENTS   77    Betriebsueberschuss und Abschreibungen
                TOT_VA  78    Bruttowertschoepfung
                PRDVAL  79    Produktionswert
                IMPORT  80    Importe gleichartiger Gueter insgesamt zu cif-Preisen
                IMP_EU  81    darunter: Importe gleichartiger Güter aus EU-Ländern zu cif-Preisen
                TOTSUP  82    Gesamtes Aufkommen an Guetern
                FCHOUS  73    Konsumausgaben privater Haushalte im Inland
                FCNPRO  74    Konsumausgaben privater Organisationen ohne Erwerbszweck
                FCGOVT  75    Konsumausgaben des Staates
                GKV     76    Konsumausgaben des Gesundheitsfonds
                SPV     77    Konsumausgaben der Sozialen Pflegeversicherung
                PKV     78    Konsumausgaben der privaten Krankenversicherung
                PPV     79    Konsumausgaben der privaten Pflegeversicherung
                INVEQU  80    Ausruestungen und sonstige Anlagen
                INVCON  81    Bauten
                CSTOCK  82    Vorratsveraenderungen und Nettozugang an Wertsachen
                EXPORT  83    Exporte insgesamt
                EXP_EU  84    darunter: Exporte in EU-länder
                TOTFIN  85    zusammen
                TOTUSE  86    Gesamte Verwendung von Guetern
                VAT
                EXCISE
                FOOD          Nahrungsmittel
                ALTD            "Alkoholische Getraenke, Tabakwaren"
                CLOT            Bekleidung und Schuhe
                RENT            Tatsaechliche Mietzahlungen und unterstellte Mietzahlungen
                HOME            Ausgaben für Haushalt und Wohnen
                HEAL            Ausgaben für Medizin und Pharma
                TRAF            Ausgaben für Transport und Verkehr
                COMM            Kommunikation
                LEIS            Freizeit
                EDUC            Bildung
                ACCO            "Reisen und Hotelaufenthalte, Restaurant"
                OTHE            Aggregat aus den restlichen Konsumkategorien
                H1*H9          Haushalte
                LGKVHI          Arbeitsnachfrage nach GKVlern qualif
                iziert
                LGKVLO          Arbeitsnachfrage nach GKVlern unqualifiziert
                LPKVHI          Arbeitsnachfrage nach PKVlern qualifiziert
                LPKVLO          Arbeitsnachfrage nach PKVlern unqualifiziert
                TAX-TL          Arbeitssteuer
                GOVT            Government
                TAX-THL         Gesundheitsbeiträge vom Arbeitgeber
                TAX-TH          Gesundheitsbeiträge vom Arbeitnehmer
                TAX-TK          Kapitalsteuer
                TAX-PROD_R      Produktionssteuer (Residuum)
                TAX-PROD_V      Produktionssteuer (absetzbar)
                ROW             Rest of the world
                TAX-TAR         Importsteuer
                INV             Investitionen
                TAX-INV         Investitionssteuer
                TAX-EX          Verbrauchersteuer
                TAX-CON         Verbrauchersteuer
                fcm             foreign capital market
                cm              total capital market
                dcm             domestic capital market
                TAX-FCAP        Tax from foreign capital market
                capst           capital stock of housholds
                dcapst          domestic capital stock
                TAX-DCAP        Tax from domestic capital market
                U               Nutzen
                /,

    ROWS(OVERALL)    Rows of IOT matrix
    /AGR, FRP, FIS, COA, CRU, SLC, FOD, BEV, TOB, TEX, CLO, LEA, TIM, PAP, PPP, PUB,
     PRI, OIL, PHA, CHM, RUB, SYN, GLA, STO, CIR, NIM, FND, MPR, MAC, OFF, EGD, COM,
     MED, VEH, WRA, FOM, SEC, ELE, GAS, WAT, CST, EXT, CAR, WHO, RTR, HOT, RLW, TRA,
     SHI, AIR, STR, CES, FIN, INS, CRE, RES, LEN, DAT, RED, ENT, GOV, SIN, EDU, HEA,
     DIS, IGR, CUL, OTH, PRH,
     TOTINT, NETPTX, INTTOT, WAGES, NETTRN, RENTS, TOT_VA, PRDVAL, IMPORT, IMP_EU,
     TOTSUP /,

    COLS(OVERALL)    Columns of IOT matrix
    /AGR, FRP, FIS, COA, CRU, SLC, FOD, BEV, TOB, TEX, CLO, LEA, TIM, PAP, PPP, PUB,
     PRI, OIL, PHA, CHM, RUB, SYN, GLA, STO, CIR, NIM, FND, MPR, MAC, OFF, EGD, COM,
     MED, VEH, WRA, FOM, SEC, ELE, GAS, WAT, CST, EXT, CAR, WHO, RTR, HOT, RLW, TRA,
     SHI, AIR, STR, CES, FIN, INS, CRE, RES, LEN, DAT, RED, ENT, GOV, SIN, EDU, HEA,
     DIS, IGR, CUL, OTH, PRH,
     TOTINT,  FCHOUS, FCNPRO, FCGOVT, GKV, SPV, PKV, PPV,
     INVEQU, INVCON, CSTOCK, EXPORT, EXP_EU, TOTFIN, TOTUSE
    /
 ZROWS(OVERALL) Z-Matrix /
        AGR, FRP, FIS, COA, CRU, SLC, FOD, BEV, TOB, TEX, CLO, LEA, TIM, PAP, PPP, PUB,
        PRI, OIL, PHA, CHM, RUB, SYN, GLA, STO, CIR, NIM, FND, MPR, MAC, OFF, EGD, COM,
        MED, VEH, WRA, FOM, SEC, ELE, GAS, WAT, CST, EXT, CAR, WHO, RTR, HOT, RLW, TRA,
        SHI, AIR, STR, CES, FIN, INS, CRE, RES, LEN, DAT, RED, ENT, GOV, SIN, EDU, HEA,
        DIS, IGR, CUL, OTH, PRH, VAT, EXCISE/,

 S(OVERALL) Production sectors /
        AGR, FRP, FIS, COA, CRU, SLC, FOD, BEV, TOB, TEX, CLO, LEA, TIM, PAP, PPP, PUB,
        PRI, OIL, PHA, CHM, RUB, SYN, GLA, STO, CIR, NIM, FND, MPR, MAC, OFF, EGD, COM,
        MED, VEH, WRA, FOM, SEC, ELE, GAS, WAT, CST, EXT, CAR, WHO, RTR, HOT, RLW, TRA,
        SHI, AIR, STR, CES, FIN, INS, CRE, RES, LEN, DAT, RED, ENT, GOV, SIN, EDU, HEA,
        DIS, IGR, CUL, OTH, PRH/,

FD(OVERALL)        Components of final demand /
                FCHOUS, FCNPRO, FCGOVT, GKV, SPV, PKV, PPV, INVEQU, INVCON, CSTOCK, EXPORT/,

PI(OVERALL)        Primary inputs /
         NETPTX, WAGES, NETTRN, RENTS, IMPORT/,

C(OVERALL)   columns of Z-matrix /
        FOOD, ALTD, CLOT, RENT, HOME, HEAL, TRAF, COMM, LEIS, EDUC, ACCO, OTHE/
,

NF(C)    All consumption goods without FOOD
    /ALTD, CLOT, RENT, HOME, HEAL, TRAF, COMM, LEIS, EDUC, ACCO, OTHE/,

NH(C)    All concsumption goods without HEAL
    /FOOD, ALTD, CLOT, RENT, HOME, TRAF, COMM, LEIS, EDUC, ACCO, OTHE/,

HE(C)    Consumption good health
    /HEAL/,

H(OVERALL)    All households
    /H1*H9/,

HHi(H)  Households with high skilled labour supply
    /H1*H9/,

HLo(H) Households with low skilled labour supply
    /H1*H9/,

SG  Skill groups
    / HI high skilled
      LO low skilled /,

LO(SG) Low skilled  /lo/,

HI(SG) High skilled /hi/;

SET MH(H) median household;
MH(H) = yes$(ORD(H) eq 5);

SET TAXPAY(H) tax paying households;
TAXPAY(H) = yes;

SET H_AGENTS(overall)  Health agents
   /GKV, PKV, SPV, PPV/;
alias(h_agents,ha);

SET INC /
    HI
    LO
    CA
    TR
    OT
    TW
    SSC
    GR
/;

SET P   Periods of time /
    2010
    2020
    2030
    2040
    2050
    2060
/;

SET ALTER Altersklassen /
    1*86
/;


*ALTER1 bis ALTER4 für die Regressionshochrechungen
SETS
        ALTER1(ALTER) /1*20/,
        ALTER2(ALTER) /21*45/,
        ALTER3(ALTER) /46*65/,
        ALTER4(ALTER) /66*86/;

*ALTER5 bis ALTER10 für die Ermittlung der GKV-Kosten
SETS
        ALTER5(ALTER) /1*15/,
        ALTER6(ALTER) /16*30/,
        ALTER7(ALTER) /31*45/,
        ALTER8(ALTER) /46*65/,
        ALTER9(ALTER) /66*85/,
        ALTER10(ALTER) /86/;

*ALTER11 bis ALTER23 für die Ermittlung der SPV-Kosten
SETS
        ALTER11(ALTER) /1*25/,
        ALTER12(ALTER) /26*50/,
        ALTER13(ALTER) /51*60/,
        ALTER14(ALTER) /61*65/,
        ALTER15(ALTER) /66*70/,
        ALTER16(ALTER) /71,72/,
        ALTER17(ALTER) /73,74/,
        ALTER18(ALTER) /75,76/,
        ALTER19(ALTER) /77,78/,
        ALTER20(ALTER) /79,80/,
        ALTER21(ALTER) /81,82/,
        ALTER22(ALTER) /83,84/,
        ALTER23(ALTER) /85,86/;

*ALTER24 bis ALTER31 für die Ermittlung der PKV-Versicherten
SETS
        ALTER32(ALTER) /1*9/,
        ALTER24(ALTER) /10*19/,
        ALTER25(ALTER) /20*29/,
        ALTER26(ALTER) /30*39/,
        ALTER27(ALTER) /40*49/,
        ALTER28(ALTER) /50*59/,
        ALTER29(ALTER) /60*69/,
        ALTER30(ALTER) /70*79/,
        ALTER31(ALTER) /80*86/;

SET GENDER Geschlecht /
    m
    w
/;


SET AGE Classes of age /
    age1   Anzahl von 0 bis 20-jährigen im Haushalt
    age2   Anzahl von 21 bis 45-jährigen im Haushalt
    age3   Anzahl von 46 bis 65-jährigen im Haushalt
    age4   Anzahl von über 65-jährigen im Haushalt
/;

SET SGKVAGE Classes of age for GKV /
    GKVage1   Anzahl von 0 bis 15-jährigen im Haushalt
    GKVage2   Anzahl von 16 bis 30-jährigen im Haushalt
    GKVage3   Anzahl von 31 bis 45-jährigen im Haushalt
    GKVage4   Anzahl von 46 bis 65-jährigen im Haushalt
    GKVage5   Anzahl von 66 bis 85-jährigen im Haushalt
    GKVage6   Anzahl von über 85-jährigen im Haushalt
/;


SET SSPVAGE Classes of age for SPV /
    SPVage1   Anzahl von 0 bis 25-jährigen im Haushalt
    SPVage2   Anzahl von 26 bis 50-jährigen im Haushalt
    SPVage3   Anzahl von 51 bis 60-jährigen im Haushalt
    SPVage4   Anzahl von 61 bis 65-jährigen im Haushalt
    SPVage5   Anzahl von 66 bis 70-jährigen im Haushalt
    SPVage6   Anzahl von 71 bis 72-jährigen im Haushalt
    SPVage7   Anzahl von 73 bis 74-jährigen im Haushalt
    SPVage8   Anzahl von 75 bis 76-jährigen im Haushalt
    SPVage9   Anzahl von 77 bis 78-jährigen im Haushalt
    SPVage10  Anzahl von 79 bis 80-jährigen im Haushalt
    SPVage11  Anzahl von 81 bis 82-jährigen im Haushalt
    SPVage12  Anzahl von 83 bis 84-jährigen im Haushalt
    SPVage13  Anzahl von über 84-jährigen im Haushalt
/;



SET SPKVAGE Classes of age for PKV /
    PKVage0   Anzahl von 0 bis 9-jährigen im Haushalt  
    PKVage1   Anzahl von 10 bis 19-jährigen im Haushalt
    PKVage2   Anzahl von 20 bis 29-jährigen im Haushalt
    PKVage3   Anzahl von 30 bis 39-jährigen im Haushalt
    PKVage4   Anzahl von 40 bis 49-jährigen im Haushalt
    PKVage5   Anzahl von 50 bis 59-jährigen im Haushalt
    PKVage6   Anzahl von 60 bis 69-jährigen im Haushalt
    PKVage7   Anzahl von 70 bis 79-jährigen im Haushalt
    PKVage8  Anzahl von über 80-jährigen im Haushalt
/;



SET REGINC regression coefficients for income /
        age1
        age2
        age3
        age4
        inc_gross
        Constant1
        Constant2
        Constant3
        Constant4
        Constant5
        Constant6
        Constant7
        Constant8
        Constant9
/;

SET INCTYP Einkommensvariablen /
        inc_gross
        hi
        lo
        ih0
        ca
        tr
        ot
        inc_transfer_kk
        inc_rente
        "beitragspflichtige Renten"
        hh_inc
/;

SET REGCONS regressioncoefficients for consum /
        age1
        age2
        age3
        age4
        Constant
/;

SET
    UnterT(h) /H1*H3/,
    MittelT(h) /H4*H6/,
    OberT(h) /H7*H9/
;
    


set shea(s) 'Gesundheitssektoren' /hea, pha, med/;

set firstp(p);

firstp(p)$(ord(p) = 1) = YES;