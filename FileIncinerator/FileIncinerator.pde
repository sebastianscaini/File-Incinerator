import drop.*;
import ddf.minim.*;

public SDrop drop;
public Minim minim;
public AudioPlayer ambience;
public AudioPlayer flame;

public boolean sound = true;

void setup()
{
  background(0);
  size(500, 500);
  frameRate(60);
  //surface.setIcon(loadImage("transparentLogo.png"));
  surface.setTitle("File Incinerator");
  drop = new SDrop(this);
  minim = new Minim(this);
  
  ambience = minim.loadFile("ambience.mp3");
  ambience.play();
  ambience.loop();
}

void draw()
{

}

void dropEvent(DropEvent theDropEvent)
{ 
  if(sound)
  {
    flame = minim.loadFile("flame.mp3");
    flame.play();
  }
  theDropEvent.file().delete();
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
