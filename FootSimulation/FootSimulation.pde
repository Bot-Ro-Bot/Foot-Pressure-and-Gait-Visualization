import processing.opengl.*;
import processing.serial.*;

Serial serial;

float[][] ypr = new float[3][3];
float[] num = new float[9];

class Object
{
  
}

float angle(float x)
{
  return (PI/180)* x;
}

int i =1;

void setup()
{
   println(Serial.list());
  serial = new Serial(this , "/dev/ttyACM0",115200);
  serial.bufferUntil('\n');
  
  
  size(1250,800,OPENGL);
  background(0);
  lights();
  
}
void draw()
{
  clear();
  if(keyPressed)
  {
    if(key == 'w')
    {
      i++;
      clear();
      if(i>90)
        i=90;
    }
    if(key == 's')
      i--;
      clear();
      if(i<-90)
        i= (-90);
  }
  
  pushMatrix();
     rotateX(angle(-20));
     rotateY(angle(-20));
     translate(625,100,0);
  pushMatrix();
     fill(255);
     //text("your input",300,300);
     noStroke();
     lights();
     //translate(625,400,0);
     //rotateX(angle(-i));
     translate(0,0,0);
     fill(255);
     box(200,80,50);
    popMatrix();
    
    
    

    
    //right
    pushMatrix();
    
    rotateX(angle(ypr[1]));
    translate(100,90,0);
    //rotate(i);
     box(50,90,50);
     ///////right mid
     pushMatrix();
     rotateX(-1*angle(ypr[1]));
     translate(0,100,0);
     box(50,90,50);
     //rfoot
     
     pushMatrix();
     
     translate(0,100,0);
    
    //rotateX(angle(ypr[1])); 
    //rotateY(-1*angle(ypr[0])); //yaw
    //rotateZ(-1*angle(ypr[2])); //roll
    translate(0,0,15);
    box(50,50,100);
   
     
   
     popMatrix();
     popMatrix();   
     popMatrix();
     popMatrix();
}

void serialEvent(Serial serial)
{
  String[] inString[];
  for(int i=0;i<9;i++){
      inString[i] = serial.readStringUntil('\n');
    if(inString != null){
     num[i]= float(inString[i]);
    }
  }
 for(int j =0; j<3;j++){
      for(int k=0; k<3;k++){
        ypr[i][j] = num[i];
      }
    }
}
