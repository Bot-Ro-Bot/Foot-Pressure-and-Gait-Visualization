#include <Arduino.h>

#include <Wire.h>
#include "Piezo.h"

Piezo:: Piezo(byte pin) :pinNo(pin){   ///const byte lai initialize garya matra ho
  pinMode(pinNo,OUTPUT);
  digitalWrite(pinNo,LOW);
}


