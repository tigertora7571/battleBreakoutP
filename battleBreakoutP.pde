import ddf.minim.*;

// グローバル変数定義
int max_ball = 3;
Ball balls[] = new Ball[max_ball];
float ball_size = 20;
float ball_v = 10; // Mode
float bar_velocity = 9; // Mode
int bar_height = 120; // Mode
Bar bars[] = {
  new Bar(400, 450, 50, bar_height, bar_velocity, false, false, true),
  new Bar(1200, 450, 50, bar_height, bar_velocity, false, false, false)
};
int block_column = 4;
int block_row = 8;
float block_sukima = 20;
Block blocks[][][] = new Block[2][block_column][block_row];
float b_w = 50, b_h;
PImage bg_game;
PImage items_img[] = new PImage[4];
PFont font;
PImage red_block_image, blue_block_image;
int scene = 0;
int title_color = 0xff;
int mode_color = 0xff;
int countdown_start;
Minim minim = new Minim(this);
AudioPlayer bgm_player;
AudioPlayer bh_player;
int round = 3; // Mode
int round_count = 0;
int remain_blocks[][];
int score_round[] = {0,0};
int game_time = 30; // Mode
int item_ratio = 4000; // Mode
float items[][] = new float[4][3];

void setup() {
  size(1600, 900, P2D);
  font = createFont("ReggaeOne-Regular.ttf", 64);
  textFont(font); // Font指定
  bg_game = loadImage("image/bg_game.jpg"); // 背景画像ロード
  for (int i = 0; i < items_img.length; i++) { // アイテム画像ロード
    items_img[i] = loadImage("image/item"+i+".png");
  }
  red_block_image = loadImage("image/redblock.jpg");
  blue_block_image = loadImage("image/blueblock.jpg");
  bgm_player = minim.loadFile("8-bit_Aggressive1.mp3");
  bgm_player.setGain(-15);
  bgm_player.loop(); // ずっと流れるBGM
  bh_player = minim.loadFile("blockhit.mp3"); // ブロック壊れてた時のかわいい音
  bh_player.setGain(-10);
  bh_player.cue(bh_player.length());
}

void draw() {
  image(bg_game, 0, 0, width, height); // 背景画像
  // 画面遷移 ルート
  switch (scene) {
    case 0: // Title
      title();
      break;
    case 1: // Game Mode
      mode();
      break;
    case 2: // Count
      countdown();
      break;
    case 3: // Game Main
      game();
      break;
    case 4: // Round
      result();
      break;
  }
}

// バーの移動処理 押したらtrueになって動く
void keyPressed() {
  if (key == 'W' || key == 'w') {
    bars[0].up = true;
  }
  if (key == 'S' || key == 's') {
    bars[0].down = true;
  }
  if (key == 'I' || key == 'i') {
    bars[1].up = true;
  }
  if (key == 'K' || key == 'k') {
    bars[1].down = true;
  }
}

// バーの移動処理 押したらfalseになって止まる
void keyReleased() {
  if (key == 'W' || key == 'w') {
    bars[0].up = false;
  }
  if (key == 'S' || key == 's') {
    bars[0].down = false;
  }
  if (key == 'I' || key == 'i') {
    bars[1].up = false;
  }
  if (key == 'K' || key == 'k') {
    bars[1].down = false;
  }
}