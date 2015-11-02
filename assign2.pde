//You should implement your assign2 here.
  
  /*MEMORY_STORAGE*/
  PImage
  enemy,
  fighter,
  hp,
  treasure,
  bg1,bg2,
  start1,start2,
  end1,end2;
  
  /*GAMEMODES*/
  final int
  GAME_START=0,
  GAME_PLAYING=1,
  GAME_LOSE=2;
  int gameMode=GAME_START; 
  
  /*KEYCONTROL*/
  boolean
  keyUp=false,
  keyDown=false,
  keyLeft=false,
  keyRight=false;
  
  /*LIFE_BAR_VOLUME_STATE*/
  final int
  FULL=1,
  NOT_FULL=2,
  EMPTY=0;
  int hpState=FULL;
  
  /*VARIABLES*/
  float
  fighterX,  fighterY,  fighterSpeed,//fighter
  treasureX,  treasureY,//treasure
  enemyX,  enemyY,  enemyXSpeed,  enemyYSpeed,  enemyXSpeed0,//enemy
  bg1X,  bg2X,  hpVolume;//others
  
void setup () {
  size(640, 480);
  enemy=loadImage("img/enemy.png");
  fighter=loadImage("img/fighter.png");
  hp=loadImage("img/hp.png");
  treasure=loadImage("img/treasure.png");
  bg1=loadImage("img/bg1.png");  bg2=loadImage("img/bg2.png");
  start1=loadImage("img/start1.png");  start2=loadImage("img/start2.png"); 
  end1=loadImage("img/end1.png");  end2=loadImage("img/end2.png");

  /*SET_VARIABLES*/
  fighterY=floor(random(0,height-50));
  fighterX=width-50;fighterSpeed=5;
  enemyX=-70;
  enemyXSpeed0=3;
  enemyXSpeed=enemyXSpeed0;
  enemyYSpeed=2;
  hpVolume=40;
  treasureX=random(50,width-50);
  treasureY=random(50,height-50);
}

void draw() {
  /*CRASH*/
   if(enemyX-25<=fighterX+20  &&  fighterX+20<=enemyX+55  &&
         enemyY-25<=fighterY+20  &&  fighterY+20<=enemyY+55){
       enemyX=-65;  enemyY=random(50,height-50);  enemyXSpeed=enemyXSpeed0; 
       hpVolume-=200*20/100;
    }
  
  /*HP_STATUS*/
  if(0<hpVolume  &&  hpVolume<200){hpState=NOT_FULL;}
  if(hpVolume>=200){hpVolume=200;hpState=FULL;}
  if(hpVolume<=0){hpState=EMPTY;}
  switch(hpState){    
      case FULL:
        if(treasureX-20<=fighterX+20  &&  fighterX+20<=treasureX+55  &&
         treasureY-25<=fighterY+20  &&  fighterY+20<=treasureY+55){
          treasureX=random(50,width-50); treasureY=random(50,height-50);
        }break;
      
      case NOT_FULL:
        if(treasureX-20<=fighterX+20  &&  fighterX+20<=treasureX+55  &&
         treasureY-20<=fighterY+20  &&  fighterY+20<=treasureY+55){
         hpVolume+=200*10/100;
         treasureX=random(50,width-50); treasureY=random(50,height-50);
        }break;
      
      case EMPTY:
        gameMode=GAME_LOSE;break;
  }
  switch(gameMode){
      case GAME_START:  image(start2,0,0);
        if(200<=mouseX&&mouseX<=460&&380<=mouseY&&mouseY<=425){
          image(start1,0,0);
          if(mousePressed){gameMode=GAME_PLAYING;}
      }break;
      
      case GAME_PLAYING:
        /*BACKGROUND_LOOP*/
        image(bg1,bg1X,0);bg1X+=3;bg1X%=width*2;
        image(bg2,bg1X-width,0);bg2X+=3;
        image(bg1,bg1X-width*2,0);
        
        /*FIGHTER_CONTROL*/
        if(keyUp){fighterY-=fighterSpeed;
          if(fighterY<=0){fighterY=0;}}
        if(keyDown){fighterY+=fighterSpeed;
          if(fighterY>=height-fighter.height)
            {fighterY=height-fighter.height;}}
        if(keyLeft){fighterX-=fighterSpeed;
          if(fighterX<=0){fighterX=0;}}
        if(keyRight){fighterX+=fighterSpeed;
          if(fighterX>=width-fighter.width)
            {fighterX=width-fighter.width;}}
        image(fighter,fighterX,fighterY);
        
        /*TREASURE*/
        image(treasure,treasureX,treasureY);

        /*ENEMY_MOVEMENT*/
        image(enemy,enemyX,enemyY);
        enemyX+=enemyXSpeed;
        enemyXSpeed+=enemyX/(width*3);
        if(enemyX>=700){
        enemyX=-65;
        enemyY=random(0,height-50);
        enemyXSpeed=enemyXSpeed0;
        }
        if (enemyY>fighterY){enemyY-=enemyYSpeed;}
        if (enemyY<fighterY){enemyY+=enemyYSpeed;}
        
        /*ENEMY_BOUNDARY_DETECTION*/
        if(enemyY>height-50){enemyY=height-50;}
        if(enemyY<50){enemyY=50;}

        
        /*LIFE_BAR*/
        fill(255,0,0);
        rect(25,25,hpVolume,20);
        image(hp,20,25);
      break;

      case GAME_LOSE:  image(end2,0,0);
        if(200<=mouseX&&mouseX<=430&&300<=mouseY&&mouseY<=350){
          image(end1,0,0);
          if(mousePressed){
            gameMode=GAME_PLAYING;
            hpState=FULL;hpVolume=40;
            fighterY=floor(random(0,height-50));
            fighterX=width-50;fighterSpeed=5;
            enemyX=-65;
            treasureX=random(50,width-50);
            treasureY=random(50,height-50);
          }
        }
      break;
  }
}
void keyPressed() {
    if(key==CODED)   {
      switch(keyCode) {
        case UP:    keyUp=true;     break;
        case DOWN:  keyDown=true;   break;
        case LEFT:  keyLeft=true;   break;
        case RIGHT: keyRight=true;  break;
      }
    }
}
void keyReleased(){
    if(key==CODED)   {
      switch(keyCode) {
        case UP:    keyUp=false;     break;
        case DOWN:  keyDown=false;   break;
        case LEFT:  keyLeft=false;   break;
        case RIGHT: keyRight=false;  break;
      }
    }
}
