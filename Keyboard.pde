/* Example Code for Platformer
 * By Chris DeLeon
 * 
 * For more free resources about hobby videogame development, check out:
 * http://www.hobbygamedev.com/
 * 
 * Project compiles in Processing - see Processing.org for more information!
 */

import java.awt.event.KeyEvent;

class Keyboard {
  // used to track keyboard input
  Boolean holdingUp, holdingDown, holdingRight, holdingLeft, holdingSpace, holdingShift, holdingA, holdingS, holdingP, holdingK;

  Keyboard() {
    holdingUp=holdingDown=holdingRight=holdingLeft=holdingSpace=holdingShift=holdingA=holdingS=holdingP=false;
  }

  /* The way that Processing, and many programming languages/environments, deals with keys is
   * treating them like events (something can happen the moment it goes down, or when it goes up).
   * Because we want to treat them like buttons - checking "is it held down right now?" - we need to
   * use those pressed and released events to update some true/false values that we can check elsewhere.
   */

  void pressKey(int key) {
    if (key == KeyEvent.VK_UP) {
      holdingUp = true;
    }
    if (key == KeyEvent.VK_K) {
      holdingK = true;
    }
    if (key == KeyEvent.VK_DOWN) {
      holdingDown = true;
    }
    if (key == KeyEvent.VK_LEFT) {
      holdingLeft = true;
    }
    if (key == KeyEvent.VK_RIGHT) {
      holdingRight = true;
    }
    if (key == KeyEvent.VK_SPACE) {
      if (shield.inUse) {
        shield.inUse = false;
      } else {
        shield.inUse = true;
      }
    }

    if (key == KeyEvent.VK_SHIFT) {
      holdingShift = true;
    }

    if (key == KeyEvent.VK_A) {
      holdingA = true;
    }
    if (key == KeyEvent.VK_S) {
      holdingS = true;
    }
    if (key == KeyEvent.VK_P) {
      holdingP = true;
    }
  }
  void releaseKey(int key) {
    if (key == KeyEvent.VK_UP) {
      holdingUp = false;
    }
    if (key == KeyEvent.VK_DOWN) {
      holdingDown = false;
    }
    if (key == KeyEvent.VK_LEFT) {
      holdingLeft = false;
    }
    if (key == KeyEvent.VK_RIGHT) {
      holdingRight = false;
    }
    if (key == KeyEvent.VK_SPACE) {
      holdingSpace = false;
    }
    if (key == KeyEvent.VK_SHIFT) {
      holdingShift = false;
    }
    if (key == KeyEvent.VK_A) {
      holdingA = false;
    }
    if (key == KeyEvent.VK_S) {
      holdingS = false;
    }
    if (key == KeyEvent.VK_P) {
      holdingP = false;
    }
    if (key == KeyEvent.VK_K) {
      holdingK = false;
    }
  }
}

