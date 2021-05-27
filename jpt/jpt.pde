import processing.opengl.*;
import processing.serial.*;

Serial serial;

float[] ypr = new float[9];
float[] fsr = new float[12];

boolean left = false;
boolean right = true;

String lastInput = new String();
String currentInput = new String();

float []nums1 = {1023,200,300,400,500,1023};
float []nums2 = {1023,200,300,400,500,1023};

Image[] i = new Image[2];

int select;

float angle(float x)
{
  return (PI/180)* x;
}

void legs()
{
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
   rotateX(angle(0));
    translate(-100,90,0);
    //rotate(i);
     box(50,90,50);
     //left mid
     pushMatrix();
     rotateX(angle(0));
     translate(0,100,0);
     box(50,90,50);
     //left foot
     pushMatrix();
     translate(0,100,0);
     box(50,50,100);
     popMatrix();
     popMatrix();
     
    popMatrix();
    
    //right
    pushMatrix();
    
   rotateX(angle(ypr[1]));
    translate(100,90,0);
    //rotate(i);
     box(50,90,50);
     ///////right mid
     pushMatrix();
     rotateX(-1*angle(ypr[4]));
     translate(0,100,0);
     box(50,90,50);
     //rfoot
     
     pushMatrix();
     
     translate(0,100,0);
    
    rotateX(angle(ypr[7])); 
    //rotateY(-1*angle(ypr[0])); //yaw
    //rotateZ(-1*angle(ypr[2])); //roll
    translate(0,0,15);
    box(50,50,100);
   
     
   
     popMatrix();
    popMatrix();   
    popMatrix();
    popMatrix();
 
}

void setup()
{
  println(Serial.list());
  serial = new Serial(this , "/dev/ttyACM0",115200);
  serial.bufferUntil('\n');
  
  i[0] = new Image(left);
  i[1] = new Image(right);
  background(0);
  size(1250,800,OPENGL);
  i[0].loadImg();
  lights();
  lastInput = "1";
}
void draw()
{
  i[0].loadImg();
  i[0].drawImg();
  i[1].drawImg();
  i[0].pressurePoints(nums1);
  i[1].pressurePoints(nums2);
  textSize(20);
  fill(255,255,255);
  
  text("0>INITIAL SCREEN",10,350);
  text("1>FSR DATA",10,400);
  text("2>ANIMATION",10,450);
  
 text(lastInput,20,500);
 
 //string = lastInput;
 
 ///switch(select)
 
 
 switch(select)
 {
   case 0:
     clear();
     break;
   case 1:
     //clear();
     i[0].drawGraph(nums1);
     i[1].drawGraph(nums2);
    
     break;
   case 2:
     clear();
     legs();
     break;
 }
 fill(255, 0, 0);
 text("your input",20,550);
 text(currentInput, 20,600);

}
void keyPressed()
{
 if(key == '1')
   select = 1;
 if(key == '0')
   select = 0;
 if(key == '2')
   select = 2;
  
  if(key == ENTER)
 {
   
   //lastInput = currentInput = currentInput + key;
   lastInput = currentInput;
   currentInput = " ";
   clear();
 }
 else if(key == BACKSPACE && currentInput.length() > 0)
 {
   currentInput = currentInput.substring(0, currentInput.length() - 1);
 }
 else
 {
   currentInput = currentInput + key;
 }
}


void serialEvent(Serial serial)
{
  String inString = serial.readStringUntil('\n');
  if(inString != null)
  {
    inString = trim(inString);
    float[] nums = float(split(inString,","));
    
   // nums[0] = float(inString);
    
   // println("yaw     value"+nums[0]);
   // println("pitch   value"+nums[1]);
   // println("roll    value"+nums[2]);
    
    
 for(int i= 0;i<12;i++)
     fsr[i] = nums[i];
     
     for(int i= 0;i<6;i++)
       nums1[i] = fsr[i];
     for(int i= 0;i<6;i++)
       nums2[i] = fsr[i+6];
    
    for(int i =0; i<3;i++)
      ypr[i] = nums[13+i];
    for(int i = 3; i<=5;i++)
      ypr[i] = nums[13+i];
    for(int i =6; i<9;i++)
      ypr[i] = nums[13+i];   
  }
}
