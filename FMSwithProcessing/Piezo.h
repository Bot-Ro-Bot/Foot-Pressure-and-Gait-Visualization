#ifndef Piezo_h
#define Piezo_h

class Piezo{
  private:
    const byte pinNo;
    float stress;

 public:
    Piezo(byte pin);
    void readData();
    void processData();
    void displayData();
};



#endif
