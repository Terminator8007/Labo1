Mover mover;

Ressort ressort;

Joueur joueur;

boolean debug = true;
float wheelCount = 0;

//parametre les objets
void setup() {
  size(800, 300);
  ressort = new Ressort(width / 2, 10, 100);
  mover = new Mover(width / 2, 100);
  joueur = new Joueur(width/2, height - 50, 40);
  mover.setDistance(200);
}

void draw() {
  background(255);

//trucs pour le mode de debug
  if (debug) {
    noFill();
    ellipse(mover.position.x, mover.position.y, mover.detectionRadius * 2, mover.detectionRadius * 2);
  }

//met la gravite sur le mover
  PVector gravity = new PVector(0, 2);
  mover.applyForce(gravity);

  ressort.connect(mover);

  ressort.constrainLength(mover, 30, 200);
  
  mover.checkProximity(joueur);

//controle du joueur
  if (keyPressed) {
  switch (key) {
    case 'a':
      joueur.moveLeft();
      break;
    case 'd':
      joueur.moveRight();
      break;
    }
  }

  
//augente ou baisse la portee de detection en fonction du scroll de la souris
  if(wheelCount < 0){
      mover.setDistance(mover.detectionRadius + 1);
      wheelCount = 0;
   }
   if(wheelCount > 0 && mover.detectionRadius > 0){
     mover.setDistance(mover.detectionRadius - 1);
      wheelCount = 0;
   }

//mise ajour des objets
  mover.update();
  joueur.update();
  mover.update();
  
//affichage des objets
  joueur.show();
  ressort.show();
  ressort.showLine(mover);
  mover.show();
}

//detection du scroll de la souris pour la portee de detection
void mouseWheel(MouseEvent event) {
    wheelCount = event.getCount();
  }
