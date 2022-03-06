import de.bezier.guido.*;
public final static int NUM_ROWS = 50; 
public final static int NUM_COLS = 50;
private Life[][] buttons; 
private boolean[][] buffer; 
private boolean running = true; 
private int Color = color((float)Math.random() * 60, (float)Math.random() * 1 +240, (float)Math.random() *60);
private int FPS = 6;
public void setup () {
  size(400, 400);
  frameRate(6);
  Interactive.make(this);
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for(int r = 0; r < NUM_ROWS; r++) {
    for(int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new Life(r, c);
    }
  }
  buffer = new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  background( 0 );
  frameRate(FPS);
  if (running == false) {
    return;
  }
  copyFromButtonsToBuffer();
  for(int r = 0; r < NUM_ROWS; r++) {
    for(int c = 0; c < NUM_COLS; c++) {
      if(countNeighbors(r, c) == 3) {
        buffer[r][c] = true;
      } 
      else if(countNeighbors(r, c) == 2 && buttons[r][c].getLife()) {
        buffer[r][c] = true;
      } 
      else {
        buffer[r][c] = false;
      }
      buttons[r][c].draw();
    }
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  if(key == ' ') {
    running = !running;
  if(key == 'w' ) {
    FPS++;
  }
  if(key == 's'  && FPS > 4) {
    FPS--;  
  }
}
}

public void copyFromBufferToButtons() {
  for(int r = 0; r < NUM_ROWS; r++) {
    for(int c = 0; c < NUM_COLS; c++) {
      buttons[r][c].setLife(buffer[r][c]);
    }
  }
}
public void copyFromButtonsToBuffer() {
  for(int r = 0; r < NUM_ROWS; r++) {
    for(int c = 0; c < NUM_COLS; c++) {
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
}
public boolean isValid(int r, int c) {
  if(r >= 0 && c >= 0 && r < NUM_ROWS && c < NUM_COLS) {
    return true;
  }
  return false;
}
public int countNeighbors(int row, int col) {
  int neighbors = 0;
  for(int r = row - 1; r <= row + 1; r++) {
    for(int c = col - 1; c <= col + 1; c++) {
      if(isValid(r, c) && buttons[r][c].getLife()) {
        neighbors++;
      }
    }
  }
  if(buttons[row][col].getLife()) {
    neighbors--;
  }
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;
  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .25; 
    Interactive.add( this ); 
  }
  public void mousePressed () {
    alive = !alive; 
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill(Color);
    rect(x, y, width, height);
  }
  public boolean getLife() {
    if(alive) {
      return true;
    }
    return false;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
