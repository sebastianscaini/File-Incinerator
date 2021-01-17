import drop.*;
import ddf.minim.*;

public SDrop drop;
public MyDropListener dl;
public Minim minim;
public AudioPlayer ambience;
public AudioPlayer flame;

public boolean sound = true;

public PVector eyePosition, lastPosition;

public PImage customBackground;
public PImage foreground;
public PImage eyes;
public PImage eyeHoles;
public PImage mouth;
public PImage body;

public boolean tracking = false;

public Animation flameLow;

void setup()
{
  background(0);
  size(512, 512);
  frameRate(60);
  surface.setIcon(loadImage("images/icon.png"));
  
  flameLow = new Animation("images/body/Body_", 96, 0, 0); 
  
  surface.setTitle("File Incinerator");
  drop = new SDrop(this);
  minim = new Minim(this);
  
  ambience = minim.loadFile("sound/ambience.mp3");
  ambience.play();
  ambience.loop();
  
  //body = loadImage("images/body/Body.png");
  eyes = loadImage("images/face/Eyes.png");
  mouth = loadImage("images/face/Mouth.png");
  eyeHoles = loadImage("images/face/Eyeholes.png");
  customBackground = loadImage("images/scene/Background.png");
  foreground = loadImage("images/scene/Foreground.png");
  
  dl = new MyDropListener();
  
  dl.setTargetRect(6, 6, 500, 500);
  
  drop.addDropListener(dl);
  
  eyePosition = new PVector(0, 0);
  lastPosition = new PVector(0, 0);
}

void draw()
{
  background(0);
  image(customBackground, 0, 0);
  
  flameLow.display();
  
  image(eyeHoles, 0, 0);
  
  if(tracking)
  {
    eyePosition = new PVector( 0 + (mouseX - 256) /30, 0 + (mouseY - 256) / 25);
    lastPosition = eyePosition;
    image(eyes, eyePosition.x, eyePosition.y);
  }
  else
  {
    eyePosition = lastPosition;
    PVector target = new PVector(0.1, 0.1);
    eyePosition.lerp(target, 0.25);
    lastPosition = eyePosition;
    image(eyes, eyePosition.x, eyePosition.y);
  }
  
  image(mouth, 0, 0);
  
  image(foreground, 0, 0);
  
  dl.draw();
}


void dropEvent(DropEvent theDropEvent)
{ 
  if(sound)
  {
    flame = minim.loadFile("sound/flame.mp3");
    flame.play();
  }
  
  theDropEvent.file().delete();
}

void mouseMoved()
{
  tracking = true;
}

void mouseExited()
{
  tracking = false;
}

void mouseClicked()
{
  sound = !sound;
  
  if(sound)
  {
    ambience.play();
    ambience.loop();
  }
  else
  {
    ambience.pause();
  }
}

class MyDropListener extends DropListener { 
  MyDropListener() {}
  
  public boolean hover;
    
  void dropEvent(DropEvent theEvent) {
    println("a drop event received from MyDropListener");
  }
  
  void draw(){
    if(hover){
      
    }
    else{
      
    }
  }
  
  void dropEnter()
  {
    hover = true;
    print("ready!");
  }
    
  void dropLeave() {
   hover = false;
   print("not ready!");
 }
    
}
