class Mover {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float damping;
  float detectionRadius;
  boolean isAttracted;

//constructeur pour le mouveur avec x y pour son 'spawn'
  Mover(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    mass = 24;
    damping = 0.98;
    detectionRadius = 100;
    isAttracted = false;
  }

//met a jour sa position selon les vecteurs de mouvement
  void update() {
    velocity.add(acceleration);
    velocity.mult(damping);
    position.add(velocity);
    acceleration.mult(0);
  }


  void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);
    acceleration.add(f);
  }

//methode pour parametrer la distance
  void setDistance(float distance) {
    detectionRadius = distance;
  }

//verifie si le joueur est dans la zone de detection
  void checkProximity(Joueur joueur) {
    float distance = PVector.dist(position, joueur.position);
    if (distance < detectionRadius) {
      isAttracted = true;
      PVector force = PVector.sub(joueur.position, position);
      force.setMag(10);
      applyForce(force);
    } else {
      isAttracted = false;
    }
  }

//affiche le mover avec la couleur verte au repos et gris si il suit le joueur
  void show() {
    if (isAttracted) {
      fill(127);
    } else {
      fill(0, 255, 0);
    }
    ellipse(position.x, position.y, mass * 2, mass * 2);
  }
}
