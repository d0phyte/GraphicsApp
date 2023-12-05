

float dds1 = 127;
float dds2 = 127;
float dds3 = 127;



class DrawnShape {
  // type of shape
  // line
  // ellipse
  // Rect .....
  String shapeType;

  // used to define the shape bounds during drawing and after
  PVector shapeStartPoint, shapeEndPoint;

  boolean isSelected = false;
  
  
  
  public DrawnShape(String shapeType) {
    this.shapeType  = shapeType;
  }


  public void startMouseDrawing(PVector startPoint) {
    this.shapeStartPoint = startPoint;
    this.shapeEndPoint = startPoint;
  }



  public void duringMouseDrawing(PVector dragPoint) {
    this.shapeEndPoint = dragPoint;
  }


  public void endMouseDrawing(PVector endPoint) {
    this.shapeEndPoint = endPoint;
  }


  public boolean tryToggleSelect(PVector p) {
    
    UIRect boundingBox = new UIRect(shapeStartPoint, shapeEndPoint);
   
    if ( boundingBox.isPointInside(p)) {
      this.isSelected = !this.isSelected;
      return true;
    }
    return false;
  }



  public void drawMe() {

    if (this.isSelected) {
        setSelectedDrawingStyle();
        
        
        
        
        
        
        
        
        
      }else{
        setDefaultDrawingStyle();
        
        
      }
    
    float x1 = this.shapeStartPoint.x;
    float y1 = this.shapeStartPoint.y;
    float x2 = this.shapeEndPoint.x;
    float y2 = this.shapeEndPoint.y;
    float w = x2-x1;
    float h = y2-y1;
    
    if ( shapeType.equals("rect")) rect(x1, y1, w, h);
    if ( shapeType.equals("ellipse")) ellipse(x1+ w/2, y1 + h/2, w, h);
    if ( shapeType.equals("line")) line(x1, y1, x2, y2);

  }

  void setSelectedDrawingStyle() {
    strokeWeight(2);
    stroke(0, 0, 0);
    fill(255, 100, 100);
    
  }

  void setDefaultDrawingStyle() {
    strokeWeight(1);
    stroke(0, 0, 0);
    
   fill(dds1, dds2, dds3);
  }
  
}     // end DrawnShape
