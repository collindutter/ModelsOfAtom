PVector cameraPos; //camera position
float scaleFactor; //zoom scale factor
AtomModel[] models; 
int modelsIndex; //which model the camera is currently viewing
PVector targetPos; //Position for the camera to move to
float cameraRotY, cameraRotX;

public void setup()
{
    size(400, 400, P3D);
    scaleFactor = 1.0f;
    models = new AtomModel[5];
    models[0] = new DaltonModel();
    models[1] = new ThomsonModel();
    models[2] = new RutherfordModel();
    models[3] = new BohrModel();
    models[4] = new QuantumMechanicsModel();
    modelsIndex = 0;
    targetPos = new PVector(models[modelsIndex].position.x, models[modelsIndex].position.y);
    cameraPos = targetPos;
    cameraRotY = 0;
    cameraRotX = 0;
}

public void draw()
{
    //set background and basic stroke colors
    background(#86A7FF);
    lights();
    stroke(0);

    pushMatrix();
    //scale based on zoom   
    translate(width / 2, height / 2);
    rotateY(cameraRotY);
    rotateX(cameraRotX);
    scale(scaleFactor);
    
    //move camera according to target position using fake interpolation :(
    cameraPos.x += (targetPos.x - cameraPos.x) / 15;
    cameraPos.y += (targetPos.y - cameraPos.y) / 15;
    translate(-cameraPos.x, -cameraPos.y);

    //draw all the models
    for(int i = 0; i < models.length; i++)
        models[i].drawModel();
        
    popMatrix();
    //framerate debugger. ****REMOVE****
    text((int)frameRate, 12, 15);
}

public void keyPressed(KeyEvent e)
{
    if(e.getKeyCode() == LEFT && modelsIndex > 0)
       modelsIndex--;
    if(e.getKeyCode() == RIGHT && modelsIndex < models.length - 1)
        modelsIndex++;
    if(e.getKeyCode() == UP && scaleFactor < 7.0f)
        scaleFactor+=.5;
    if(e.getKeyCode() == DOWN && scaleFactor > 1.0f)
        scaleFactor-=.5;
    if(e.getKeyCode() == 'A')
        cameraRotY += PI/6;
    if(e.getKeyCode() == 'D')
        cameraRotY -= PI/6;
    if(e.getKeyCode() == 'W')
        cameraRotX -= PI/6;
    if(e.getKeyCode() == 'S')
        cameraRotX += PI/6;
    if(e.getKeyCode() == 'R')
        setup();
     
    targetPos = new PVector(models[modelsIndex].getPosition().x, models[modelsIndex].getPosition().y);
}