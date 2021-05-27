import processing.opengl.*;
import processing.serial.*;

Serial serial;

float[] ypr = new float[3];


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
  serial = new Serial(this , "/dev/ttyACM0",9600);
  serial.bufferUntil('\n');
  
  size(1250,800,OPENGL);
  background(0);
  lights();
  //ortho();
 
  
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
    
    
    
    //left
    pushMatrix();
   rotateX(angle(-i));
    translate(-100,90,0);
    //rotate(i);
     box(50,90,50);
     //left mid
     pushMatrix();
     rotateX(angle(i));
     translate(0,100,0);
     box(50,90,50);
     popMatrix();
     
    popMatrix();
    
    //right
    pushMatrix();
    if(ypr[0]>90)
      ypr[0] =90;
      if(ypr[1]>90)
      ypr[1] =90;
      
      if(ypr[0]<-90)
      ypr[0] = -90;
      if(ypr[1]< -90)
      ypr[1] = -90;
   rotateX(ypr[0]);
  // rotateY(ypr[1]);
    translate(100,90,0);
    //rotate(i);
     box(50,90,50);
     ///////right mid
     pushMatrix();
     rotateX(angle(-i));
     translate(0,100,0);
     box(50,90,50);
     //rfoot
     pushMatrix();
     translate(0,100,0);
     box(50,50,100);
     popMatrix();
     popMatrix();   
    popMatrix();
      popMatrix();
}
void serialEvent(Serial serial)
{
  try
  {
  String inString = serial.readStringUntil('\n');
  if(inString != null)
  {
    inString = trim(inString);
    float[] nums = float(split(inString,","));
    println("pitch value"+nums[0]);
    println("roll value"+nums[1]);
   // println("yaw  value"+nums[2]);
  //  inByte1 = float(inString);
   // println(inByte1);
    float byter = nums[1];
    ypr[0] = byter;
  }
  }
  catch(Exception e)
  {
    println("error");
    e.printStackTrace();
  }
}
