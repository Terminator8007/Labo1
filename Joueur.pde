class Joueur {
  PVector position;
  //taille carre
  float size;
  //variable mouvement
  PVector velocity;
  PVector acceleration;
  float speed;
  float maxSpeed;
  float friction;

//constructeur prenant x y pour son 'spawn' et s pour la taille
  Joueur(float x, float y, float s) {
    position = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    size = s;
    speed = 0.5;
    maxSpeed = 5;
    friction = 0.90;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

//met a jour sa position selon les vecteurs de deplacement
  void update() {
    velocity.add(acceleration);
    velocity.mult(friction);
    velocity.limit(maxSpeed);
    position.add(velocity);
    
    if (position.x < 0) {
      position.x = 0;
      velocity.x = 0;
    }
    if (position.x + size > width) {
      position.x = width - size;
      velocity.x = 0;
    }
    
    acceleration.mult(0); 
  }

  void moveLeft() {
    applyForce(new PVector(-speed, 0));
  }

  void moveRight() {
    applyForce(new PVector(speed, 0));
  }

  void show() {
    fill(255, 0, 0);
    rect(position.x, position.y, size, size);
  }
}
