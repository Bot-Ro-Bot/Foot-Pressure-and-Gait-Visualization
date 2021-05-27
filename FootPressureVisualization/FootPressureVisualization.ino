#include <Wire.h>
#include "IMU.h"
#include "Piezo.h"
#include "FSR.h"
#include "MadgwickAHRS.h"



#define mpu1 5
#define mpu2 6
#define mpu3 7

unsigned long int runTime;
unsigned long int loopTime;

int selector=3;

//int fsrpin[12]= {A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11};

IMU mpu[3]={{mpu1},{mpu2},{mpu3}};

void setup(){
  Serial.begin(115200);
  Wire.begin();
  for(int j = 0; j<12;j++)
    pinMode(fsrpin[j],INPUT);
  
  digitalWrite(mpu1,HIGH);
  digitalWrite(mpu2,LOW);
  digitalWrite(mpu3,LOW);
 // IMU:: checkDevice();
  mpu[0].SETUP();
 // mpu[0].calibrateGyro();
  delay(100);

  digitalWrite(mpu1,LOW);
  digitalWrite(mpu2,HIGH);
  digitalWrite(mpu3,LOW);
 /// IMU:: checkDevice();
  mpu[1].SETUP();
 // mpu[1].calibrateGyro();
  delay(100);

  digitalWrite(mpu1,LOW);
  digitalWrite(mpu2,LOW);
  digitalWrite(mpu3,HIGH);
 // IMU:: checkDevice();
  mpu[2].SETUP();
//  mpu[2].calibrateGyro();
  delay(100);
 
  digitalWrite(mpu1,LOW);
  digitalWrite(mpu2,LOW);
  digitalWrite(mpu3,LOW);

  delay(300);
  
 }


void loop(){
  
  runTime=millis();
  
  if(selector%3==0){
  digitalWrite(mpu1,HIGH);
  digitalWrite(mpu2,LOW);
  digitalWrite(mpu3,LOW);
  delay(10);
  mpu[0].readData();
  mpu[0].calculateData();
 // mpu[0].calculateAngle();
 mpu[0].complementaryFilter(loopTime/1000.0);
 // Serial.println("\n\n\nFrom sensor 1");
 // mpu[0].printData();
 }
 
  if(selector%3==1){
  digitalWrite(mpu1,LOW);
  digitalWrite(mpu2,HIGH);
  digitalWrite(mpu3,LOW);
  delay(10); 
  mpu[1].readData();
  mpu[1].calculateData();
//  mpu[1].calculateAngle();
 mpu[1].complementaryFilter(loopTime/1000.0);
/// Serial.println("\n\n\nFrom sensor 2");
 // mpu[1].printData();
 }


  if(selector%3==2){
  digitalWrite(mpu1,LOW);
  digitalWrite(mpu2,LOW);
  digitalWrite(mpu3,HIGH);
  delay(10);
  mpu[2].readData();
  mpu[2].calculateData();
// mpu[2].calculateAngle();
 mpu[2].complementaryFilter(loopTime/1000.0);
 // Serial.println("\n\n\nFrom sensor 3");
 // mpu[2].printData(); 
  }
  
 selector++;
 delay(100);
for(int j=0;j<12;j++)
{
  Serial.print(analogRead(fsrpin[j]));
  Serial.print(",");
}
mpu[0].toProcessing();
mpu[1].toProcessing();
mpu[2].toProcessing();
Serial.print("\n");
 
loopTime=millis()-runTime;
//Serial.print("\nLoopTime="); Serial.println(loopTime);
}
//THE E
