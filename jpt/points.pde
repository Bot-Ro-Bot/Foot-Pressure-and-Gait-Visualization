import processing.core.*;

  class Image
{
 public PImage img;
 boolean leg;
 float[] colorValue = new float [6];
 float appVoltage = 3.3;
 float resolution = appVoltage/1024;
// float FSRVoltage = arduinodata * resolution;
 float resistance = 10000;
// float FSRResistance = ((appVoltage-FSRVoltage)*resistance)/FSRVoltage;
 float resistanceData[] = new float[6];
 float voltageData[] = new float[6];
  //PImage img;
  int xpos[] = {200,200,200,200,200,200};
  int lastXpos[] = {200,200,200,200,200,200};
  int lastHeight[] = {200,200,200,200,200,200};
  
  
  Image()
  {
   leg = false;
  }
  Image(boolean x)
  {
   leg = x;
  }
 void loadImg()
  {
    img = loadImage("foot1.jpg");
    image(img,0,0,200,200);
   
  }
  void drawImg()
  {
    if(leg)
    {
      fill(0,0,0);
      ellipse(60+83,20,10,10);
      ellipse(15+175,45,10,10);
      ellipse(38+120,50,10,10);
      ellipse(55+90,100,10,10);
      ellipse(25+150,120,10,10);
      ellipse(45+105,170,10,10);
    }
    else
    {
      fill(0,0,0);
      ellipse(60 ,20,10,10);
      ellipse(15,45,10,10);
      ellipse(38,50,10,10);
      ellipse(55,100,10,10);
      ellipse(25,120,10,10);
      ellipse(45,170,10,10);
    }
  }
  void pressurePoints(float []nums)
  {
     
    
    for(int i =0 ; i<6;i++)
    colorValue [i]= nums[i];
    
    for(int i= 0;i<6;i++)
      colorValue[i]=map(colorValue[i],0,1023,0,255);  
    
    for(int x=0;x<6;x++)
    {
      voltageData[x] = nums[x] * resolution; 
      resistanceData[x] = ((appVoltage-voltageData[x])*resistance)/voltageData[x];
    }
     if(leg)
    {
      fill(colorValue[0],0,0);
      ellipse(60+83,20,10,10);
      fill(colorValue[1],0,0);
      ellipse(15+175,45,10,10);
      fill(colorValue[2],0,0);
      ellipse(38+120,50,10,10);
      fill(colorValue[3],0,0);
      ellipse(55+90,100,10,10);
      fill(colorValue[4],0,0);
      ellipse(25+150,120,10,10);
      fill(colorValue[5],0,0);
      ellipse(45+105,170,10,10);
      textSize(10);
      
      
      fill(255,255,255);
      text("Right",150,250);
      for(int i=0;i<6;i++)
      text(resistanceData[i],150,255+(i*10)+6);  //20 250
    }
    else
    {
      fill(0);
      stroke(0);
      
     rect(0,250,200,200); //maile
     
      
      fill(colorValue[0],0,0);
      ellipse(60,20,10,10);
      fill(colorValue[1],0,0);
      ellipse(15,45,10,10);
      fill(colorValue[2],0,0);
      ellipse(38,50,10,10);
      fill(colorValue[3],0,0);
      ellipse(55,100,10,10);
      fill(colorValue[4],0,0);
      ellipse(25,120,10,10);
      fill(colorValue[5],0,0);
      ellipse(45,170,10,10);
      textSize(10);
      
      
      fill(255,255,255);
      
      text("Left",20,250);
      for(int i=0;i<6;i++)
      text(nums[i],20,255+(i*10)+6);  //20 250
    }
    //delay(100);
    //clear(); ////maile
  }
  void drawGraph(float[] nums)
  {
    float[]num = new float[6];
    for(int i=0;i<6;i++)
      num[i]=nums[i];
    
    int mask =5;
    //for(int i=0;i<6;i++)
      //map(nums[i],0,1023,0,200);    
    
    if(leg)
    {
     stroke(127,255,255);
     strokeWeight(2);
     for(int i=0;i<6;i++)
     {
       num[i] = map(num[i],0,1023,0,200);
       //line(lastXpos[i]+((i+1)*200)+((i+1)*(-200)*((mask+1)/(i+1))),400+lastHeight[i]+(200*((mask+1)/(i+1))),xpos[i],400+200-num[i]);
       line(lastXpos[i]+(i*200)-((i/5)*200),400+lastHeight[i]+((i/5)*200),xpos[i]+(i*200)-((i/5)*200),400+200-num[i]+((i/5)*200));
       lastXpos[i] =xpos[i];
       lastHeight[i] = int(200-num[i]);
       if((xpos[i]-200)>=200)
       {
         xpos[i] = 200;
         lastXpos[i] = 200;
         background(0);
       }
       else
       {
         xpos[i]++;
       }
     }
    }
    else
    {
     stroke(255,34,255);
     strokeWeight(2);
     for(int i=0;i<6;i++)
     {
       num[i] = map(num[i],0,1023,0,200);
       //line(lastXpos[i]+((i+1)*200)+((i+1)*(-200)*((mask+1)/(i+1))),400+lastHeight[i]+(200*((mask+1)/(i+1))),xpos[i],400+200-num[i]);
       line(lastXpos[i]+(i*200)-((i/5)*200),lastHeight[i]+((i/5)*200),xpos[i]+(i*200)-((i/5)*200),200-num[i]+((i/5)*200));
       lastXpos[i] =xpos[i];
       lastHeight[i] = int(200-num[i]);
       if((xpos[i]-200)>=200)
       {
         xpos[i] = 200;
         lastXpos[i] = 200;
         background(0);
       }
       else
       {
         xpos[i]++;
       }
     }
    }
    
  }
}
