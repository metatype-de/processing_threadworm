// (c)2014, Angelo Stitz
// Processing 2.0.2

int curPosXstart, curPosYstart;
int curPosXend, curPosYend;

int curPosXstartOn, curPosYstartOn;
int curPosXendOn, curPosYendOn;

int invert_Sx=1;
int invert_Sy=1;
int invert_Ey=1;
int invert_Ex=1;
int factorV=1;
int factorSE_Sx=1;
int factorSE_Sy=1;
int factorSE_Ex=1;
int factorSE_Ey=1;
int ranXstart, ranYstart;
int ranXend, ranYend;
int ranXstartOn, ranYstartOn;
int ranXendOn, ranYendOn;
                                          // Benutzereingaben
boolean startKey = false;                                      
int anzahl = 120;                      // Anzahl Fadenwurm auf der Bühne
float zaehlerAdd = 0.03;              // Größe des Wachstums in einem Zyklus
int pause = 80;                    // Pause zwischen dem Wachstum
boolean strokeOnOff=false;            // Schalter Dynamisches Wachstum Strichstärke, False = Off, true = On
int strokeFac = 2000;                  // Wenn Schalter Dynamisches Wachstum On, dann hier Dynamische Zunahme der Strichstärke beim Wachstum einstellen

float zaehler;
int zaehlerY=0;
int zaehlerX=0;
boolean mySwitch1=false;
boolean mySwitch2=false;

int posX;
int posY;
int ranPosX = 0;
int ranPosY = 0;

int [][][][]myFadenwurm;
int [][][][]myFadenwurmSE;
int [][][][]myFadenwurmInv;


float startPointX;                  
float startPointY;

int bcp1X;
int bcp1Y;

int bcp2X;
int bcp2Y;

float endPointX;
float endPointY;

int zaehlerStroke;

void setup()
{
  size(1200, 800);

  myFadenwurm=new int[anzahl+1][anzahl+1][anzahl+1][anzahl+1];
  myFadenwurmSE=new int[anzahl+1][anzahl+1][anzahl+1][anzahl+1];
  myFadenwurmInv=new int[anzahl+1][anzahl+1][anzahl+1][anzahl+1];

  // Erzeuge zufällige Werte für "Zuwachs" der Position
  ranXstartOn = int(random(-25, 25));         // Start Point      
  ranYstartOn = int(random(-25, 25)); 

  ranXstart = int(random(-3, 3));               // 1 BCP
  ranYstart = int(random(-3, 3)); 

  ranXend = int(random(-3, 3));                // 2 BCP
  ranYend = int(random(-3, 3)); 

  ranXendOn = int(random(-25, 25));            // End Point    
  ranYendOn = int(random(-25, 25));
}

void draw()
{
  background(255);
  noFill();
  if (mySwitch1==false && startKey == true)         // Fülle mir erstmal Zeichenfläche und das Array mit Bazillen
  {
    println("Fülle Array");

    for (zaehlerX=0;zaehlerX < anzahl;zaehlerX++)
    {  

      zaehler += zaehlerAdd*zaehlerAdd;

      ranPosX = int(random(0, width));           // Erezuge zufällige Positionskoordinaten
      ranPosY = int(random(0, height));    

      // Bestimme in welche Himmelsrichtung der Start+ Endpunkt sich verschieben, dieser Faktor ist FIX
      invert_Sx = int(random(-2, 2));
      invert_Sy = int(random(-2, 2));
      invert_Ex = int(random(-2, 2));
      invert_Ey = int(random(-2, 2));
      
      // Bestimme in welche Himmelsrichtung sich BCPs verschieben, dieser Faktor ist VAR
      factorV = int(random(-2, 2));                                
  
      // Addiere zufälligen Zahlenbereich zu der vorherigen Position
      curPosXstartOn += cos(zaehler)*factorSE_Sx;               // Start Point    
      curPosYstartOn += cos(zaehler)*factorSE_Sy;    
      curPosXstart += ranXstart*ranXstart*factorV;            // 1 BCP
      curPosYstart += ranYstart*ranYstart*factorV;
      curPosXend += ranXend*ranXend*factorV;                  // 2 BCP
      curPosYend += ranYend*ranYend*factorV;    
      curPosXendOn += cos(zaehler)*factorSE_Ex;              // END Point
      curPosYendOn += cos(zaehler)*factorSE_Ey;

      // Positionsänderung vorher noch dazu berechnen
      startPointX = curPosXstartOn+ranPosX;                 // Start
      startPointY = curPosXstartOn+ranPosY;
      bcp1X = curPosXstart+ranPosX;                        // 1 BCP
      bcp1Y = curPosYstart+ranPosY;
      bcp2X = curPosXend+ranPosX;                       // 2 BCP
      bcp2Y = curPosYend+ranPosY;
      endPointX = curPosXendOn+ranPosX;                // END Point
      endPointY = curPosYendOn+ranPosY;                  
      
      // Speichere mir 8 Koordinaten der 4 Punkte in ein Array
      myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX][zaehlerX]=int(startPointX);       
      myFadenwurmSE[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]=int(startPointY); 

      myFadenwurm[zaehlerX][zaehlerX][zaehlerX][zaehlerX]=bcp1X; 
      myFadenwurm[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]=bcp1Y; 
      myFadenwurm[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]=bcp2X; 
      myFadenwurm[zaehlerX][zaehlerX][zaehlerX][zaehlerX+1]=bcp2Y; 

      myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]=int(endPointX); 
      myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX][zaehlerX+1]=int(endPointY); 

      myFadenwurmInv[zaehlerX][zaehlerX][zaehlerX][zaehlerX]=invert_Sx; 
      myFadenwurmInv[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]=invert_Sy;  
      myFadenwurmInv[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]=invert_Ex; 
      myFadenwurmInv[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX+1]=invert_Ey; 

//      println(zaehlerX+" S X "+myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX][zaehlerX]+"\t S Y "+myFadenwurmSE[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]+"\t 1 BCP X "+myFadenwurm[zaehlerX][zaehlerX][zaehlerX][zaehlerX]+"\t 1 BCP Y "+myFadenwurm[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]+"\t 2 BCP X "+myFadenwurm[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]+"\t 2 BCP Y "+myFadenwurm[zaehlerX][zaehlerX][zaehlerX][zaehlerX+1]+"\t E X "+myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]+"\t E Y "+ myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX][zaehlerX+1]);
    }          
    mySwitch1=true;
  }

  if (mySwitch2==false && startKey== true)                          // Fülle mir erstmal Zeichenfläche und das Array
  {
    for (zaehlerX=0;zaehlerX < anzahl;zaehlerX++)
    {  
      zaehler += zaehlerAdd*zaehlerAdd;
      zaehlerStroke += 1;
      
      //  Erzeuge zufällige Werte für "Zuwachs" aller Punkte
      ranXstartOn = int(random(-25, 25));         // Start Point     
      ranYstartOn = int(random(-25, 25)); 

      ranXstart = int(random(-3, 3));               // 1 BCP
      ranYstart = int(random(-3, 3)); 

      ranXend = int(random(-3, 3));                // 2 BCP
      ranYend = int(random(-3, 3)); 

      ranXendOn = int(random(-25, 25));            // End Point    
      ranYendOn = int(random(-25, 25));

      // Schau in welche Himmelsrichtung mein Start + Endpunkt wachsen sollen
      invert_Sx =  myFadenwurmInv[zaehlerX][zaehlerX][zaehlerX][zaehlerX]; 
      invert_Sy =  myFadenwurmInv[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]; 
      invert_Ex =  myFadenwurmInv[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]; 
      invert_Ey =  myFadenwurmInv[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX+1]; 

      factorV = int(random(-2, 2));                                        // Factor Zuwachs BCPs
      factorSE_Sx = int(random(0, 2)*invert_Sx);                      // Factor Zuwachs Start X
      factorSE_Sy = int(random(0, 2)*invert_Sy);                      // Factor Zuwachs Start Y
      factorSE_Ex = int(random(0, 2)*invert_Ex);                      // Factor Zuwachs End X
      factorSE_Ey = int(random(0, 2)*invert_Ey);                      // Factor Zuwachs End Y
      
      // Hole mir 8 Koordinaten der 4 Punkte aus Array
      curPosXstartOn = myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX][zaehlerX];       
      curPosYstartOn = myFadenwurmSE[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]; 

      curPosXstart = myFadenwurm[zaehlerX][zaehlerX][zaehlerX][zaehlerX]; 
      curPosYstart = myFadenwurm[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]; 
      curPosXend = myFadenwurm[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]; 
      curPosYend = myFadenwurm[zaehlerX][zaehlerX][zaehlerX][zaehlerX+1]; 

      curPosXendOn = myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]; 
      curPosYendOn =  myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX][zaehlerX+1]; 

      //  Addiere zufälligen Zahlenbereich zu der vorherigen Position                                                     
      curPosXstartOn += cos(zaehler)*cos(zaehler)*factorSE_Sx;               // Start Point       
      curPosYstartOn += cos(zaehler)*factorSE_Sy;    

      curPosXstart += cos(ranXstart)*ranXstart*factorV;      // 1 BCP
      curPosYstart += ranYstart*ranYstart*factorV*factorSE_Sx;

      curPosXend += cos(ranXend)*ranXend*factorSE_Ex;            // 2 BCP
      curPosYend += ranYend*ranYend*factorV;    

      curPosXendOn += cos(zaehler)*factorSE_Ex;              // END Point
      curPosYendOn += cos(zaehler)*cos(zaehler)*factorSE_Ey;

      // Speichere mir die zuletzt berechneten Koordinaten in einem Array für die darauffolgende Transformation
      myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX][zaehlerX]=curPosXstartOn;       
      myFadenwurmSE[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]=curPosYstartOn; 

      myFadenwurm[zaehlerX][zaehlerX][zaehlerX][zaehlerX]=curPosXstart; 
      myFadenwurm[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]=curPosYstart; 
      myFadenwurm[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]=curPosXend; 
      myFadenwurm[zaehlerX][zaehlerX][zaehlerX][zaehlerX+1]=curPosYend; 

      myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]=curPosXendOn; 
      myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX][zaehlerX+1]=curPosYendOn; 

      beginShape();
      if(strokeOnOff == true)
      {
        strokeWeight(zaehlerStroke/strokeFac);
      }
      if(strokeOnOff == false)
      {
        strokeWeight(1);
      }
      vertex(curPosXstartOn, curPosYstartOn); 
      bezierVertex(curPosXstart, curPosYstart, curPosXend, curPosYend, curPosXendOn, curPosYendOn);
      endShape();
//      println(zaehlerX+" S X "+myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX][zaehlerX]+"\t S Y "+myFadenwurmSE[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]+"\t 1 BCP X "+myFadenwurm[zaehlerX][zaehlerX][zaehlerX][zaehlerX]+"\t 1 BCP Y "+myFadenwurm[zaehlerX][zaehlerX+1][zaehlerX][zaehlerX]+"\t 2 BCP X "+myFadenwurm[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]+"\t 2 BCP Y "+myFadenwurm[zaehlerX][zaehlerX][zaehlerX][zaehlerX+1]+"\t E X "+myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX+1][zaehlerX]+"\t E Y "+ myFadenwurmSE[zaehlerX][zaehlerX][zaehlerX][zaehlerX+1]);
    }          
    delay(pause);
  }
  
  
  if (keyPressed) 
  {
    if (key == 's') 
    {
      startKey = true;
    }
  }
}
