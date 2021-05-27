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

  IMU mpu[3]={{mpu1},{mpu2},{mpu3}};

void setup(){
  Serial.begin(115200);
  Wire.begin();
  digitalWrite(mpu1,HIGH);
  digitalWrite(mpu2,LOW);
  digitalWrite(mpu3,LOW);
  mpu[0].SETUP();
  delay(100);

  digitalWrite(mpu1,LOW);
  digitalWrite(mpu2,HIGH);
  digitalWrite(mpu3,LOW);
  mpu[1].SETUP();
  delay(100);

  digitalWrite(mpu1,LOW);
  digitalWrite(mpu2,LOW);
  digitalWrite(mpu3,HIGH);
  mpu[2].SETUP();
  delay(100);
 
  digitalWrite(mpu1,LOW);
  digitalWrite(mpu2,LOW);
  digitalWrite(mpu3,LOW);
  
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
  mpu[0].complementaryFilter(loopTime/1000.0);
 }
 
  if(selector%3==1){
  digitalWrite(mpu1,LOW);
  digitalWrite(mpu2,HIGH);
  digitalWrite(mpu3,LOW);
  delay(10); 
  mpu[1].readData();
  mpu[1].calculateData();
  mpu[1].complementaryFilter(loopTime/1000.0);
 }


  if(selector%3==2){
  digitalWrite(mpu1,LOW);
  digitalWrite(mpu2,LOW);
  digitalWrite(mpu3,HIGH);
  delay(10);
  mpu[2].readData();
  mpu[2].calculateData();
  mpu[2].complementaryFilter(loopTime/1000.0);
  }
  
// selector++;

 mpu[0].toProcessing();
 mpu[1].toProcessing();
 mpu[2].toProcessing();
 Serial.print("\n");
 
  loopTime=millis()-runTime;
//Serial.print("\nLoopTime="); Serial.println(loopTime);
 
}
