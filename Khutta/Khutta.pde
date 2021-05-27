import processing.serial.*;
import processing.serial.*;

Serial serial;
int i=1;
float[][] ypr=new float[3][3];
String[] inString=new String[9];
float[] angles= new float[9];

float toAngle(float x){
    return (PI/180)* x;
}


void serialEvent(Serial serial){
  
  
  for(int i=0;i<9;i++){
   
    if(inString[i]!=null){
    angles[i]= float(inString[i]);
    println(angles[i]);
     }
   }
   for(int j =0; j<3;j++){
      for(int k=0; k<3;k++){
        ypr[j][k] = angles[j+k];
      }
    }
}


void setup(){
  println(Serial.list());
  serial = new Serial(this , "/dev/ttyACM0",115200);
  serial.bufferUntil('\n');

  size(1250,800,OPENGL);
  background(0);
  lights();
}

void draw(){
  clear();
  if(keyPressed){
    if(key == 'w'){
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
     rotateX(toAngle(-20));
     rotateY(toAngle(-20));
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
     rotateX(toAngle(-i));
     translate(-100,90,0);
     //rotate(i);
     box(50,90,50);
     //left mid
     pushMatrix();
     rotateX(toAngle(i));
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
    rotateX(toAngle(ypr[0][1]));
    translate(100,90,0);
    //rotate(i);
     box(50,90,50);
     ///////right mid
     pushMatrix();
     rotateX(-1*toAngle(ypr[0][1]));
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
