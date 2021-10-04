Die clown;
int meR; int meG; int meB; int oldR; int oldG; int oldB;
float leverY;
int sum; int mySum;
String total; int timesRolled; int totalSum; String avg; String numRolls;
  
void setup()
{
  size(650,1100);
  frameRate(30);
  textAlign(CENTER);
  leverY = 712.5;
  timesRolled = 0;
  totalSum = 0;
  total = "Roll the dice!!!";
  avg = "You haven't rolled yet! Average is UNDEFINED :)";
  numRolls = "0. duh.";
}

void draw()
{
  background(0);
  int meX, myX;
  int multiplier = 1; int multiply = 1;
  int limitX = 550; int maxX = 550;
  int minX = 50; int minimumX = 50;
  int change = 45;
  int r = oldR; int g = oldG; int b = oldB;
  sum = 0;
  if(r<meR)
    oldR+=7;
  if(r>meR)
    oldR-=7;
  if(g<meG)
    oldG+=7;
  if(g>meG)
    oldG-=7;
  if(b<meB)
    oldB+=7;
  if(b>meB)
    oldB-=7;

//Slider
  fill(255);
  rect(575, 700, 25, 300, 25);
  strokeWeight(1);
  fill(r, g, b);
  if(mousePressed == true && (mouseX>=560 && mouseX<=620)) { //Horizontal limiter
    if(leverY == 712.5) { //top of slider
      if(mouseY>=712.5 && mouseY<=725)
        leverY = mouseY;
    }
    else if(leverY == 987.5) { //bottom of slider
      if(mouseY<=987.5 && mouseY>975)
        leverY = mouseY;
    }
    else if((leverY>712.5 && leverY<987.5) && (mouseY > leverY - 40 && mouseY < leverY + 40)) { //Middle of slider
      leverY = mouseY;
    }
    else if (mouseY<712.5 && mouseY>700) //Gives a bit of leeway for dragging up
      leverY = 712.5;
    else if (mouseY>987.5 && mouseY<1000) //Gives a bit of leeway for dragging down
      leverY = 987.5;
  }
  if(leverY < 712.5) //Top backup reset
    leverY = 712.5;
  if(leverY > 987.5)  //Bottom backup reset
    leverY = 987.5;
  //System.out.println(leverY);
  ellipse(587.5, leverY, 25, 25);
  limitX += (((int)leverY-712)/35)*9; 
  maxX += (((int)leverY-712)/40)*10;

//TEXT
  strokeWeight(5);
  textSize(50);
  fill( (((int)leverY-712)-50), (((int)leverY-712)-50), (((int)leverY-712)-50) );
  text(total, 290, 565);
  if(leverY >= 821) {
    fill( (((int)leverY-712)-100), (((int)leverY-712)-100), (((int)leverY-712)-100) );
    textSize(20);
    text(avg, 290, 515);
    text(numRolls, 300, 600);
  }
// TOP HALF INCLUDING MIDDLE
  for (int meY = 550 - (((int)leverY-712)/3); meY >= 0 - (((int)leverY-712)/3); meY -= 50 + (((int)leverY-712)/40)) {
    for (meX = 50*multiply - (((int)leverY-712)/40); meX >= minimumX - (((int)leverY-712)/40) && meX <= maxX; meX += 50 + (((int)leverY-712)/40)) {
      clown = new Die(meX-change, meY-45, r+130, g+130, b+130);
      clown.roll();
      clown.show();
      sum+=clown.value;
      r-=2; g-=2; b-=2;
    } //end of rows
    change += 25;
    multiply++;
    minimumX -= 25;
  } //end of columns

// BOTTOM HALF EXCLUDING MIDDLE
  r = meR+110; g = meG+110; b = meB+110;
  change = 45;
  change+=25;
  multiplier++;
  minX += 25;
  for (int myY = 600 + (((int)leverY-712)/3); myY <= 1100 + (((int)leverY-712)/3); myY += 50 + (((int)leverY-712)/35)) {
    for (myX = 50*multiplier - (((int)leverY-712)/35); myX >= minX && myX <= limitX; myX += 50 + (((int)leverY-712)/35)) {
      clown = new Die(myX-change,myY-45, r, g, b);
      clown.roll();
      clown.show();
      sum+=clown.value;
      if(r<255)
        r+=2;
      if(g<255)
        g+=2;
      if(b<255)
        b+=2;
    } //end of rows
    change += 25;
    multiplier++;
    minX += 25;
  } //end of columns
}

void mousePressed()
{
  timesRolled++;
  oldR = meR; oldG = meG; oldB = meB;
  meR = (int)(Math.random()*256); meG = (int)(Math.random()*256); meB = (int)(Math.random()*256); //FOR COLORS
  loop();
  redraw();
  //System.out.println(mouseX + ", " + mouseY);
}

void mouseReleased()
{
  noLoop();
  mySum = sum;
  totalSum += mySum;
  total = "Your roll is: " + mySum;
  avg = "Your average roll is: " + totalSum / timesRolled;
  numRolls = "You've rolled " + timesRolled + " times"; 
  //System.out.println(total);
  if(leverY >= 773) {
    strokeWeight(5);
    textSize(50);
      fill(0); //Block the text from the draw function
      rect(0, 527, 650, 44);
    fill( (((int)leverY-712)-50), (((int)leverY-712)-50), (((int)leverY-712)-50) );
    text(total, 290, 565);  
  }
  if(leverY >= 871) {
      fill(0);
      rect(0, 495, 650, 110);
    fill( (((int)leverY-712)-50), (((int)leverY-712)-50), (((int)leverY-712)-50) );
    text(total, 290, 565);  
    fill( (((int)leverY-712)-75), (((int)leverY-712)-75), (((int)leverY-712)-75) );
    textSize(20);
    text(avg, 290, 515);
    text(numRolls, 300, 600);
  }
  redraw();
}

class Die //models one single dice cube
{
  int diex, diey, wide, tall, curve, value, red, green, blue;
    Die(int x, int y, int rd, int gr, int bl) //constructor
    {
      diex = x; //Top left of die
      diey = y; //Top left of die
      wide = 40; //Width
      tall = 40; //Height
      curve = 8; //radii of corners
      value = 1; //Roll of the die
      red = rd; green = gr; blue = bl; //Color of die
    }    
    void roll()
    {
      value = (int)(Math.random()*6)+1;
    }
    
    void show()
    {
      //System.out.println(red + ", " + green + ", " + blue);
      fill(red, green, blue);
      rect(diex, diey, wide, tall, curve);
      stroke(0);
      strokeWeight(0.5);
      fill(0);
      if(value == 1)
        ellipse((diex + wide/2), (diey + tall/2), (wide/5), (tall/5));
      else if(value == 2) {
        ellipse((diex + wide/4), (diey + tall/4), (wide/5), (tall/5));
        ellipse((diex + 3*wide/4), (diey + 3*tall/4), (wide/5), (tall/5));
      }
      else if(value == 3) {
        ellipse((diex + wide/4), (diey + tall/4), (wide/5), (tall/5));
        ellipse((diex + wide/2), (diey + tall/2), (wide/5), (tall/5));
        ellipse((diex + 3*wide/4), (diey + 3*tall/4), (wide/5), (tall/5));
      }
      else if(value == 4) {
        ellipse((diex + wide/4), (diey + tall/4), (wide/5), (tall/5));
        ellipse((diex + wide/4), (diey + 3*tall/4), (wide/5), (tall/5));
        ellipse((diex + 3*wide/4), (diey + tall/4), (wide/5), (tall/5));
        ellipse((diex + 3*wide/4), (diey + 3*tall/4), (wide/5), (tall/5));
      }
      else if(value == 5) {
        ellipse((diex + wide/4), (diey + tall/4), (wide/5), (tall/5));
        ellipse((diex + wide/4), (diey + 3*tall/4), (wide/5), (tall/5));
        ellipse((diex + 3*wide/4), (diey + tall/4), (wide/5), (tall/5));
        ellipse((diex + 3*wide/4), (diey + 3*tall/4), (wide/5), (tall/5));
        ellipse((diex + wide/2), (diey + tall/2), (wide/5), (tall/5));
      }
      else {
        ellipse((diex + wide/4), (diey + tall/4), (wide/5), (tall/5));
        ellipse((diex + wide/4), (diey + tall/2), (wide/5), (tall/5));
        ellipse((diex + wide/4), (diey + 3*tall/4), (wide/5), (tall/5));
        ellipse((diex + 3*wide/4), (diey + tall/4), (wide/5), (tall/5));
        ellipse((diex + 3*wide/4), (diey + tall/2), (wide/5), (tall/5));
        ellipse((diex + 3*wide/4), (diey + 3*tall/4), (wide/5), (tall/5));
      }    
   }
}
