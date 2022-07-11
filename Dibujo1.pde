//Coordenadas de los vértices del triángulo
int x1 = 50;
int y1 = 100;
int x2 = 50;
int y2 = 500;
int x3 = 500;
int y3 = 500;

void setup(){
    size(600,600);
    line(x1,y1,x2,y2);
    line(x1,y1,x3,y3);
    line(x2,y2,x3,y3);
    //Invierte las coordenadas tras dibujarlas ya que en realidad están en el cuarto cuadrante
    y1 = -y1;
    y2 = -y2;
    y3 = -y3;
    circuncentro();
}
//Dibuja el círculo que inscribe al triángulo
void draw_circle(float[] rect1, float[] rect2, float[] rect3){
    int ry1;
    int ry2;
    int ry3;
    //Encuentra la coordenada x en la que se cortan las mediatrices
    for(int x = 0; x<1000; x++){
      ry1 = int(-(rect1[0]*x + rect1[2])/rect1[1]);
      ry2 = int(-(rect2[0]*x + rect2[2])/rect2[1]);
      ry3 = int(-(rect3[0]*x + rect3[2])/rect3[1]);
      if(ry1 == ry2 || ry2 == ry3 || ry3 == ry1){
        noFill();
        //Determina el diámetro del círculo. Lo hace encontrando el módulo de la distancia desde el centro a cualquiera de los vértices del triángulo
        ellipse(x, -ry1, 2*sqrt((x-x1)*(x-x1)+(ry1-y1)*(ry1-y1)), 2*sqrt((x-x1)*(x-x1)+(ry1-y1)*(ry1-y1)));
      }
    }
}
//Encuentra el circuncentro. El circuncentro es el centro de la circunferencia que inscribe al triángulo, y se halla con la intersección de las mediatrices de sus lados
void circuncentro(){
    float[] vect;
    float[] rect;
    float[] rect1;
    float[] rect2;
    float[] rect3;
    //Calcula y dibuja la primera mediatriz
    vect = vect(x1,x2,y1,y2);
    rect = get_rect(vect[0], vect[1], get_med(x1,x2), get_med(y1,y2));
    line(get_med(x1,x2), -get_med(y1,y2), get_coords(rect, 1)[0], get_coords(rect, 1)[1]);
    rect1 = rect;
    //Calcula y dibuja la segunda mediatriz
    vect = vect(x2,x3,y2,y3);
    rect = get_rect(vect[0], vect[1], get_med(x2,x3), get_med(y2,y3));
    line(get_med(x2,x3), -get_med(y2,y3), get_coords(rect, 2)[0], get_coords(rect, 2)[1]);
    rect2 = rect;
    //Calcula y dibuja la tercera mediatriz
    vect = vect(x3,x1,y3,y1);
    rect = get_rect(vect[0], vect[1], get_med(x3,x1), get_med(y3,y1));
    line(get_med(x3,x1), -get_med(y3,y1), get_coords(rect, 3)[0], get_coords(rect, 3)[1]);
    rect3 = rect;
    draw_circle(rect1, rect2, rect3);
}
//Devuelve el vector director perpendicular a la recta
float[] vect(int x1, int x2, int y1, int y2){
    float[] perp = new float[2];
    perp[0] = x2 - x1;
    perp[1] = y2 - y1;
    return perp;
}
//Devuelve una lista con la ecuación general de la recta perpendicular dado el vector
float[] get_rect(float a, float b, float x, float y){
    float[] rect = new float[3];
    rect[0] = a;
    rect[1] = b;
    rect[2] = -(rect[0]*x + rect[1]*y);
    return rect;
}
//Devuelve una lista con las coordenadas finales de la recta
float[] get_coords(float[] rect, int iter){
    float[] coords = new float[2];
    //Paso especial por si la recta es vertical
    if(rect[0] == 0){
        switch(iter){
            case 1: coords[0] = 600; coords[1] = -get_med(y1, y2); break;
            case 2: coords[0] = 600; coords[1] = -get_med(y2, y3); break;
            case 3: coords[0] = 600; coords[1] = -get_med(y3, y1); break;
        }
        return coords;
    }
    //Paso especial por si la recta es horizontal
    if(rect[1] == 0){
        switch(iter){
            case 1: coords[0] = get_med(x1, x2); coords[1] = 0; break;
            case 2: coords[0] = get_med(x2, x3); coords[1] = 0; break;
            case 3: coords[0] = get_med(x3, x1); coords[1] = 0; break;
        }
        return coords;
    }
    //Devuelve las coordenadas de cualquier recta oblicua a los ejes
    coords[0] = 500;
    coords[1] = (rect[0] * 500 + rect[2])/rect[1];
    return coords;
}
//Encuentra el baricentro. El baricentro es el centro de gravedad del triángulo y se halla haciendo las medianas
void baricentro(){
    line(x1, -y1, get_med(x2,x3), -get_med(y2,y3));
    line(x2, -y2, get_med(x1,x3), -get_med(y1,y3));
    line(x3, -y3, get_med(x1,x2), -get_med(y1,y2));
}
//Devuelve el punto medio de dos puntos
float get_med(float p1, float p2){
    return (p1 + p2)/2;
}
