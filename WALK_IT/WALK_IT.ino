
#include <Wire.h>
#include <TimerOne.h>
#include <EEPROM.h>


#define device_adLeft 0x68         //AD0 pin connected to ground  **Note: 0x69 if AD0 is connected to VCC  (idea weak xa...kaam garne possibility 10%)
#define device_adRight 0x69
#define deviceAd 0x69
#define gyro_ad 0x1B
#define accl_ad 0x1C
#define pwrmgmt_ad 0x6B
#define LSB_A 4096.0
#define LSB_G 131.0

unsigned long int runTime;

const int mpuPin[6]={4,5,6,7,8,9};

volatile int mpuSelector=1;

//bool flag=1;

class IMU{
  private:
    //int deviceAd;
    int16_t accX,accY,accZ ,gyX,gyY,gyZ;
    int16_t temperature;
    float Gx,Gy,Gz,Ax,Ay,Az;
    float T;
    float roll,pitch,yaw;
 public:
    IMU();
    void readData();
    void calculateData();
    void calculateAngle();
    void printData();
    void plotData();
    
};

class Baro{
  private:
    const byte pinNo;
    float stress;

 public:
    Baro(byte pinNo);
    void readData();
    void processData();
    void displayData();
};



IMU::IMU(){
  /*if(address=='R'){
    deviceAd= device_adRight;
  }
  else{
    deviceAd= device_adLeft;
  }*/
  Wire.beginTransmission(deviceAd);
  Wire.write(pwrmgmt_ad);
  Wire.write(0b00000000);                 //Disable sleep mode                                         Put bit3 to 1 if you want to disable temperature sensor
  Wire.endTransmission();

  Wire.beginTransmission(deviceAd);
  Wire.write(gyro_ad);
  Wire.write(0b00000000);                         //Select degrees per second for gyro to read data accordingly   +-250dps
  Wire.endTransmission();

  Wire.beginTransmission(deviceAd);
  Wire.write(accl_ad);
  Wire.write(0b00010000);                        ////Select range for accl to read data accordingly              +-8g
  Wire.endTransmission();
}


void IMU::readData(){
  Wire.beginTransmission(deviceAd);      // Reading data from accl measurement registers
  Wire.write(0x3B);
  Wire.endTransmission();
  Wire.requestFrom(deviceAd, 6);
    accX= Wire.read()<<8 | Wire.read();
    accY= Wire.read()<<8 | Wire.read();
    accZ= Wire.read()<<8 | Wire.read();
     


  Wire.beginTransmission(deviceAd);     //Reading data from gyroscope measurement registers
  Wire.write(0x43);
  Wire.endTransmission();
  Wire.requestFrom(deviceAd, 6);
    gyX= Wire.read()<<8 | Wire.read();
    gyY= Wire.read()<<8 | Wire.read();
    gyZ= Wire.read()<<8 | Wire.read();
     

  Wire.beginTransmission(deviceAd);     //  Reading data from temperature measurement registers
  Wire.write(0x41);
  Wire.endTransmission();
  Wire.requestFrom(deviceAd, 2);
  temperature= Wire.read()<<8 | Wire.read();
}



void IMU::calculateData(){
  
    Ax= accX/LSB_A;                  //LSB sensitivity for +-4g
    Ay= accY/LSB_A;
    Az= accZ/LSB_A;

    Gx= gyX/LSB_G;                    //LSB sensitivity for 500dps
    Gy= gyY/LSB_G;
    Gz= gyZ/LSB_G;

    T= temperature/340 + 36.53;            // Calculating temperature in Celsuis 
}



void IMU::calculateAngle(){             //DMP use garne yesmaa tara mildaina hola kina bhane 6 ota use garnu xa
  
}



void IMU::printData(){
   Serial.print("  Ax:");   Serial.print(Ax);      
   Serial.print("  Ay:");   Serial.print(Ay);
   Serial.print("  Az:");   Serial.print(Az);
   Serial.print("  Gx:");   Serial.print(Gx);     
   Serial.print("  Gy:");   Serial.print(Gy);     
   Serial.print("  Gz:");   Serial.print(Gz);       
   Serial.print("  T:");    Serial.println(T);

   Serial.print("  Roll:"); Serial.println(roll);
   Serial.print("  Pitch:"); Serial.println(pitch);
   Serial.print("  Yaw:"); Serial.println(yaw);
 }

Baro:: Baro(byte pinNo){
  
}


void mpuSelect(){
  for(int i=0;i<6;i++){
      digitalWrite(mpuPin[i],LOW);
  }
  switch(mpuSelector){
    case 1:
    digitalWrite(mpuPin[0],HIGH);
    break;

    case 2:
    digitalWrite(mpuPin[1],HIGH);
    break;

    case 3:
    digitalWrite(mpuPin[2],HIGH);
    break;

    case 4:
    digitalWrite(mpuPin[3],HIGH);
    break;

    case 5:
    digitalWrite(mpuPin[4],HIGH);
    break;

    case 6:
    digitalWrite(mpuPin[5],HIGH);
    break;
  }
  mpuSelector++;
  if(mpuSelector>6) mpuSelector=1;
  
}

 void setup(){
  Serial.begin(115200);
  for(int i=0;i<6;i++){
      pinMode(mpuPin[i],OUTPUT);
  }
  for(int i=0;i<6;i++){
      digitalWrite(mpuPin[i],LOW);
  }
  Timer1.initialize(5000);    //10 millisecond data inconsistent aayo bhane badaunu parlaa
  Timer1.attachInterrupt(mpuSelect);

 IMU MPUatRest[6];                  
      for(int i=0;i<6;i++){
      MPUatRest[i].readData();
      MPUatRest[i].calculateData();
      MPUatRest[i].calculateAngle();
      MPUatRest[i].printData();
      delay(100);
      }
   
  //rest data eeprom maa lekhne
 }



void loop(){
    if(flag==1){
       IMU MPU[6]; 
       !flag; 
    }
    
/*    for(int i=0;i<6;i++){
      MPU[i].readData();
      MPU[i].calculateData();
      MPU[i].calculateAngle();
      MPU[i].printData();
  }*/
}

