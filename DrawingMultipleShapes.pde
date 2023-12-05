//Main Code


SimpleUI myUI;
DrawingList drawingList;

String toolMode = "";
PImage imgInput;
PImage myOutputImage;
PImage undoImg;
int sigmvalue;


float r,g,b,Contrast,Gamma,Posterize,Hue,Negative,greyscale,Brightness;



public void settings() {
  size(1500, 1000);
}




 void setup() {
  
  
  
      
  
      
      
  myUI = new SimpleUI();
  drawingList = new DrawingList();
 
  ButtonBaseClass  rectButton = myUI.addRadioButton("rect", 1280, 350, "group1");
  myUI.addRadioButton("ellipse", 1280, 400, "group1");
  myUI.addRadioButton("line", 1280, 450, "group1");
 
  myUI.addRadioButton("Undo", 1280, 650, "group1");
  
  
  
  
  
  Slider slider = myUI.addSlider("Resize", 105, 350);
  slider.setSliderValue(1);
  
  
  myUI.addSlider("Red", 105, 470);
  myUI.addSlider("Green", 105, 510);
  myUI.addSlider("Blue", 105, 550);
  
 
  
  Slider slider1 = myUI.addSlider("Brightness", 105, 620);
  slider1.setSliderValue(1);
  
  
  //myUI.addRadioButton("black and white", 170, 740);
  
  
  String[] fileMenuItems = {"Load","Save"};
  myUI.addMenu("File",105, 230, fileMenuItems);
  
  String[] filters = {"Contrast","Posterize","Negative","Gray","Threshold","Blur","Erode","Dilate"};
  myUI.addMenu("Apply filter",105, 700, filters);
  // slider customization
  
  
      
  
  
  
  
  
  
  //dds1 = r;
  //dds2 = g;
  //dds3 = b;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  rectButton.selected = true;
  toolMode = rectButton.UILabel;
  
  // add a new tool .. the select tool
  myUI.addRadioButton("select", 1280, 190, "group1");
  
  myUI.addCanvas(350,40,780,900);
  
  
 
  
 
  
}





 

void draw() {{
  
 
  
  
 float ScaleSlider = myUI.getSliderValue("Resize");
  
 background(224,224,216);
 
 if( imgInput != null){
   
   
   
   image(myOutputImage,350,40,780 * ScaleSlider,900 * ScaleSlider);
   
      
   }
 
 fill(0,0,0);
 text("Processing App",120,100);  
 text("RGB colors applied to drawn shapes",50,430);
 text("Draw",1300,110);
 text("Removes all filters applied to the image",1200,620);
    r = myUI.getSliderValue("Red")*255;
    g = myUI.getSliderValue("Green")*255;
    b = myUI.getSliderValue("Blue")*255;
    
    
    
    Brightness = myUI.getSliderValue("Brightness");
    
    
    
 
 

 
}
 
    
 
 
 if (myUI.getToggleButtonState("select")){
    
  
 }
 
 
 
 if (myUI.getToggleButtonState("rect")){
    
  
 }
 if (myUI.getToggleButtonState("ellipse")){
    
  
 }
 if (myUI.getToggleButtonState("line")){
    
  
 }
 
   
   
 dds1 = r;
 dds2 = g;
 dds3 = b;
 
 drawingList.drawMe();
 myUI.update();
}


float sigmoidCurve(float v){
  
  
  float f =  (1.0 / (1 + exp(-12 * (v  - 0.5))));
  
 
  return f;
}

float invert(float v){
  
  return 1-v;
}

float step(float v, int numSteps){
  float thisStep = (int) (v*numSteps);
  return thisStep/numSteps;
  
}

int[] makeLUT(String functionName, float param1, float param2){
  int[] lut = new int[256];
  for(int n = 0; n<256; n++){
    
    float p = n/255.0f;
    float val = getValueFromFunction( p, functionName,  param1,  param2);
    lut[n] = (int)(val*255);
  
  }

  return lut;


}
 
float getValueFromFunction(float inputVal, String functionName, float param1, float param2){
  if(functionName.equals("sigmoid")){
    return sigmoidCurve(inputVal);
  }
  if(functionName.equals("Negative")){
    return invert(inputVal);
  }
  return 0;
} 

PImage applyPointProcessing(int[] LUT,  PImage imgInput){
  PImage myOutputImage = createImage(imgInput.width,imgInput.height,RGB);
  
  for (int y = 0; y < imgInput.height; y++) {
    for (int x = 0; x < imgInput.width; x++) {
    
    color c = imgInput.get(x,y);
    
    int r = (int)red(c);
    int g = (int)green(c);
    int b = (int)blue(c);
    
    int lutR = LUT[r];
    int lutG = LUT[g];
    int lutB = LUT[b];
    
    
    myOutputImage.set(x,y, color(lutR,lutG,lutB));
    
    }
  }
  
  return myOutputImage;

}

int[] makeFunctionLUT(String functionName, float parameter1, float parameter2){
  
  int[] lut = new int[256];
  for(int n = 0; n < 256; n++) {
    
    float p = n/256.0f;  // ranges between 0...1
    float val = 0;
    
    switch(functionName) {
      
      case "sigmoid":
      
      
      
      break;
      
      
      
        
       
      // add in the list of functions here
      // and set the val accordingly
      //
      //
      }// end of switch statement

   
    lut[n] = (int)(val*255);
  }
  
  return lut;
}








void handleUIEvent(UIEventData eventData){
  
  // all buttons that have instant effect are first
  //then the sliders and other stuff
  
  
 
  if (eventData.eventIsFromWidget("Load")){
    myUI.openFileLoadDialog("load an image");
  
  
  } 
  
  if (eventData.eventIsFromWidget("fileLoadDialog")){
    imgInput = loadImage(eventData.fileSelection);
    myOutputImage = imgInput.copy();
  
  
  }
  
  if (eventData.eventIsFromWidget("Save")){
    myUI.openFileSaveDialog("save an image");
  
  
  } 
  
  if (eventData.eventIsFromWidget("fileSaveDialog")){
    myOutputImage.save(eventData.fileSelection);
  
  
  } 
  
  
  
  
  if (eventData.eventIsFromWidget("Undo")){
    
      
      myOutputImage = imgInput.copy(); 
      
  
      
  }
  
  
  
  
  
   
  
  
  
  
  
  
  
  if (eventData.eventIsFromWidget("Contrast")){
      int[] lut =  makeLUT("sigmoid", 0.0, 0.0);
      myOutputImage = applyPointProcessing(lut, imgInput);
    
    
        
        
      }
   
  
 
  
  
  
  
  if (eventData.eventIsFromWidget("Posterize")){
    myOutputImage.filter(POSTERIZE, 4);
  
  }
  
  
  if (eventData.eventIsFromWidget("Negative")){
    myOutputImage.filter(INVERT);
     
  
  
      }
  
  
  if (eventData.eventIsFromWidget("Brightness")){
    for (int y = 0; y<imgInput.height; y++){
      for (int x = 0; x<imgInput.width; x++) {
      
        color thisPix = imgInput.get(x,y);
        float r = red(thisPix) * (1.0 / (1 + exp(-12 * (Brightness  - 0.5)))); 
        float g = green(thisPix) * (1.0 / (1 + exp(-12 * (Brightness  - 0.5))));
        float b = blue(thisPix) * (1.0 / (1 + exp(-12 * (Brightness  - 0.5))));
        color newColour = color(r, g, b);
        myOutputImage.set(x, y, newColour);
        
        
      }
    }
    
    
    
  
  
  }
  if (eventData.eventIsFromWidget("Gray")){
     myOutputImage.filter(GRAY);
        
        
      }
    
   
  if (eventData.eventIsFromWidget("Threshold")){
     myOutputImage.filter(THRESHOLD);
        
        
      }  
  if (eventData.eventIsFromWidget("Blur")){
     myOutputImage.filter(BLUR);
        
        
      }
  if (eventData.eventIsFromWidget("Erode")){
     myOutputImage.filter(ERODE);
        
        
      }
  if (eventData.eventIsFromWidget("Dilate")){
     myOutputImage.filter(DILATE);
        
        
      }     
    
  
  
  
  
  
  
  // if from a tool-mode button, the just set the current tool mode string 
  if(eventData.uiComponentType == "RadioButton"){
    toolMode = eventData.uiLabel;
    
    
    return;
  }

  // only canvas events below here! First get the mouse point
  if(eventData.eventIsFromWidget("canvas")==false) return;
  PVector p =  new PVector(eventData.mousex, eventData.mousey);
  
  // this next line catches all the tool shape-drawing modes 
  // so that drawing events are sent to the display list class only if the current tool 
  // is a shape drawing tool
  if( toolMode.equals("rect") || 
      toolMode.equals("ellipse") || 
      toolMode.equals("line")) {    
     drawingList.handleMouseDrawEvent(toolMode,eventData.mouseEventType, p);
     return;
  }
   
  // if the current tool is "select" then do this
  if( toolMode.equals("select") ) {    
      drawingList.trySelect(eventData.mouseEventType, p);
    }
  

}

void keyPressed(){
  if(key == BACKSPACE){
    drawingList.deleteSelected();
  }
}
