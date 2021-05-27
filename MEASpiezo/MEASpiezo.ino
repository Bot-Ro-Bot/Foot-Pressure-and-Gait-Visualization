#define PiezoPin A5
volatile long unsigned int timer1;
volatile long unsigned int timer2=0;

void Isr(){
  timer1=micros();
  Serial.print("Sensor value  "); Serial.println(analogRead(PiezoPin));
  Serial.print("Time          "); Serial.println(timer1-timer2);
  
  timer2=timer1;
  
}

void setup(){
  attachInterrupt(digitalPinToInterrupt(2),Isr,RISING);
  Serial.begin(115200);
}

void loop(){
  Serial.println("NULL");
  delay(100);
}

