import drop.*;
import ddf.minim.*;

public SDrop drop;
public MyDropListener dl;
public Minim minim;
public AudioPlayer ambience;
public AudioPlayer flame;

public boolean sound = true;

public PVector eyePosition, lastPosition;

public PImage eyes;
public PImage body;

public boolean tracking = false;

//public Animation flameLow = new Animation("images/sprites/senpai/FlameLow", 3, 256, 256);

void setup()
{
  background(0);
  size(512, 512);
  frameRate(60);
  //surface.setIcon(loadImage("transparentLogo.png"));
  surface.setTitle("File Incinerator");
  drop = new SDrop(this);
  minim = new Minim(this);
  
  ambience = minim.loadFile("Sounds/ambience.mp3");
  ambience.play();
  ambience.loop();
  
  body = loadImage("Sprites/Body/Body.png");
  eyes = loadImage("Sprites/Eyes/Eyes.png");
  
  dl = new MyDropListener();
  
  dl.setTargetRect(6, 6, 500, 500);
  
  drop.addDropListener(dl);
  
  eyePosition = new PVector(0, 0);
  lastPosition = new PVector(0, 0);
}

void draw()
{
  image(body, 0, 0);
  
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
  
  dl.draw();
}


void dropEvent(DropEvent theDropEvent)
{ 
  if(sound)
  {
    flame = minim.loadFile("Sounds/flame.mp3");
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
