class Ressort {
  PVector anchor;
  float restLength;
  float k;

//constructeur du ressort
  Ressort(float x, float y, float length) {
    anchor = new PVector(x, y);
    restLength = length;
    k = 0.2;
  }

//connecte le ressort au mover et son ancre
  void connect(Mover mover) {
    PVector force = PVector.sub(mover.position, anchor);
    float currentLength = force.mag();
    float stretch = currentLength - restLength;

    force.setMag(-1 * k * stretch);

    mover.applyForce(force);
  }

//gere la taille maximal que peux avoir le ressort
  void constrainLength(Mover mover, float minlen, float maxlen) {
    PVector direction = PVector.sub(mover.position, anchor);
    float length = direction.mag();

    if (length < minlen) {
      direction.setMag(minlen);
      mover.position = PVector.add(anchor, direction);
      mover.velocity.mult(0);
    } else if (length > maxlen) {
      direction.setMag(maxlen);
      mover.position = PVector.add(anchor, direction);
      mover.velocity.mult(0);
    }
  }

//montre le point d'ancrage
  void show() {
    fill(127);
    ellipse(anchor.x, anchor.y, 10, 10);
  }

//montre la ligne du ressort
  void showLine(Mover mover) {
    line(mover.position.x, mover.position.y, anchor.x, anchor.y);
  }
}
