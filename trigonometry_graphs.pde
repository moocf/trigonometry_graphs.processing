/* @pjs preload="data/BradleyHandITC-18.vlw"; */
/* @pjs preload="data/HarlowSolid-32.vlw"; */
/* @pjs preload="data/curve-sin.png"; */
/* @pjs preload="data/curve-cos.png"; */
/* @pjs preload="data/curve-tan.png"; */
/* @pjs preload="data/curve-cosec.png"; */
/* @pjs preload="data/curve-sec.png"; */
/* @pjs preload="data/curve-cot.png"; */

// Global Variables
PFont  harlow, bradley;
String Menu[] = {"sin", "cos", "tan", "sec", "cosec", "cot"};
PImage BackImg[];
int    Sel;

void setup()
{
  int i;
  
  size(1000, 480);
  background(50, 60, 100);
  smooth();
  harlow = loadFont("data/HarlowSolid-32.vlw");
  bradley = loadFont("data/BradleyHandITC-18.vlw");
  BackImg = new PImage[6];
  for(i=0; i<6; i++)
    BackImg[i] = loadImage("data/curve-"+Menu[i]+".png");
  Sel = 0;
}


void draw()
{
  int    slt;
  float  x0, y0, x, y;
  float th, ans;
  int delX, delY, ptX, ptY;
  
  // Draw sample
  image(BackImg[Sel],0,0);
  // Select Curve
  if(mouseX > 865)
  {
    slt = (int)((mouseY) / 80);
    y = 40 + slt*80;
    textFont(harlow);
    textAlign(CENTER);
    fill(160,140,160);
    stroke(110, 120, 150);
    strokeWeight(46);
    line(870, y, 960, y);
    text(Menu[(int)((y-40)/80)], 910, y+5);
    if(mousePressed)
    {
      Sel = slt;
      stroke(150, 120, 150);
      line(870, y, 960, y);
      text(Menu[(int)((y-40)/80)], 910, y+5);
    }
  }
  
  // Draw Curve
  strokeWeight(4);
  delX = mouseX - 200;
  delY = 240 - mouseY;
  th = atan2(delY, delX);
  if(th < 0) th += 2.0 * PI;
  ptX = (int)(200 + 150*cos(th));
  ptY = (int)(240 - 150*sin(th));
  stroke(70, 150, 195);
  line(200, 240, ptX, ptY);
  x = (180.0*th)/PI;
  switch(Sel)
  {
    case 0:
    ans = sin(th);
    break;
    case 1:
    ans = cos(th);
    break;
    case 2:
    ans = tan(th);
    break;
    case 3:
    ans = 1/cos(th);
    break;
    case 4:
    ans = 1/sin(th);
    break;
    default:
    ans = 1/tan(th);
  }
  if(Sel<2) y = 150.0*ans;
  else y = 25.0*ans;
  line(450.0+x, 240.0, 450.0+x, 240.0-y);
  stroke(105, 105, 85);
  strokeWeight(1);
  line(ptX, ptY, 450.0+x, 240.0-y);
  textFont(bradley);
  textAlign(LEFT);
  fill(200,180,200);
  text(Menu[Sel] + "( " + x +"deg ) = " + ans, 10, 470);
}
