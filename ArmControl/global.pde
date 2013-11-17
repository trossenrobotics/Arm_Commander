
/***********************************************************************************
 *  }--\     InterbotiX     /--{
 *      |    ArmControl    |
 *   __/                    \__
 *  |__|                    |__|
 *
 *  arbotix.pde
 *  
 *  This file has several global variables relating to the positional data for the arms.
 *  See 'ArmControl.pde' for building this application.
 *
 *
 * The following variables are named for Cartesian mode -
 * however the data that will be held/sent will vary based on the current IK mode
 ****************************************************************************
 * Variable name | Cartesian Mode | Cylindrcal Mode | Backhoe Mode          |
 *_______________|________________|_________________|_______________________|
 *   x           |   x            |   base          |   base joint          |
 *   y           |   y            |   y             |   shoulder joint      |
 *   z           |   z            |   z             |   elbow joint         |
 *   wristAngle  |  wristAngle    |  wristAngle     |   wrist angle joint   |
 *   wristRotate |  wristeRotate  |  wristeRotate   |   wrist rotate jount  |
 *   gripper     |  gripper       |  gripper        |   gripper joint       |
 *   delta       |  delta         |  delta          |   n/a                 |
********************************************************************************/


//WORKING POSITION VARIABLES

//default values and min/max , {default, min, max}
//initially set to values for pincher in normal mode which should be safe for most arms (this shouldn't matter, as these values will get changed when an arm is connected)
//these parameters will be loaded based on the 1)Arm type 2)IK mode 3)Wrist Angle Orientation
int[] xParameters = {0,-200,200};//
int[] yParameters = {200,50,240};
int[] zParameters = {200,20,250};
int[] wristAngleParameters = {0,-90,90};
int[] wristRotateParameters = {0,-512,511};
int[] gripperParameters = {256,0,512};
int[] deltaParameters = {125,0,256};

//values for the current value directly from the GUI element. These are updated by the slider/text boxes
int xCurrent = xParameters[0]; //current x value in text field/slider
int yCurrent = yParameters[0]; //current y value in text field/slider
int zCurrent = zParameters[0]; //current z value in text field/slider
int wristAngleCurrent = wristAngleParameters[0]; //current Wrist Angle value in text field/slider
int wristRotateCurrent = wristRotateParameters[0]; //current  Wrist Rotate value in text field/slider
int gripperCurrent = gripperParameters[0]; //current Gripper value in text field/slider
int deltaCurrent = deltaParameters[0]; //current delta value in text field/slider};

//offset values to be send to the ArbotiX/Arm. whether or not these values get offsets depends on the current mode
//it will be possible for the 'Current' value to be the same as the 'currentOffset' value.
// see updateOffsetCoordinates()
int xCurrentOffset = xParameters[0]; //current x value to be send to ArbotiX/Arm
int yCurrentOffset = yParameters[0]; //current y value to be send to ArbotiX/Arm
int zCurrentOffset = zParameters[0]; //current z value to be send to ArbotiX/Arm
int wristAngleCurrentOffset = wristAngleParameters[0]; //current Wrist Angle value to be send to ArbotiX/Arm
int wristRotateCurrentOffset = wristRotateParameters[0]; //current  Wrist Rotate value to be send to ArbotiX/Arm
int gripperCurrentOffset = gripperParameters[0]; //current Gripper value to be send to ArbotiX/Arm
int deltaCurrentOffset = deltaParameters[0]; //current delta value to be send to ArbotiX/Arm

boolean[] digitalButtons = {false,false,false,false,false,false,false,false};  //array of 8 boolean to hold the current states of the checkboxes that correspond to the digital i/o
int digitalButtonByte;//int will hold the button byte (will be cast to byte later)

int extendedByte = 0;  //extended byte for special instructions


//END WORKING POSITION VARIABLES

//DEFAULT ARM PARAMETERS 


 //XYZ 
int[][] armParam0X = new int[3][3];
int[][] armParam0Y = new int[3][3];
int[][] armParam0Z = new int[3][3];
int[][] armParam0WristAngle = new int[3][3];
int[][] armParam0WristRotate = new int[3][3];

int[][] armParam90X = new int[3][3];
int[][] armParam90Y = new int[3][3];
int[][] armParam90Z = new int[3][3];
int[][] armParam90WristAngle = new int[3][3];
int[][] armParam90WristRotate = new int[3][3];



int[][] armParamBase = new int[3][3];
int[][] armParamBHShoulder = new int[3][3];
int[][] armParamBHElbow = new int[3][3];
int[][] armParamBHWristAngle = new int[3][3];
int[][] armParamBHWristRot = new int[3][3];


int[][] armParamGripper = new int[3][3];


int[][] armParamWristAngle0Knob = new int[3][2];
int[][] armParamWristAngle90Knob = new int[3][2];
int[][] armParamWristAngleBHKnob = new int[3][2];
int[][] armParamWristRotKnob= new int[3][2];




//default values for the phantomX pincher. These will be loaded into the working position variables 
//when the pincher is connected, and when modes are changed.
int[] pincherNormalX = {0,-200,200};
int[] pincherNormalY = {200,50,240};
int[] pincherNormalZ = {200,20,250};
int[] pincherNormalWristAngle = {0,-90,90};
int[] pincherWristRotate = {0,-512,511};
int[] pincherGripper = {256,0,512};
int[] pincher90X = {0,-200,200};
int[] pincher90Y = {140,20,150};
int[] pincher90Z = {30,10,150};
int[] pincher90WristAngle = {-90,-90,-45};
int[] pincherBase = {512,0,1023};
int[] pincherBHShoulder = {512,205,815};
int[] pincherBHElbow = {512,205,1023};
int[] pincherBHWristAngle = {512,205,815};
int[] pincherBHWristRot = {512,0,1023};

int[] pincherBHWristAngleNormalKnob = {90,270};//angle data for knob limits
int[] pincherBHWristAngle90Knob = {90,45};//angle data for knob limits

int[] pincherWristAngleBHKnob = {270,90};//angle data for knob limits
int[] pincherWristRotKnob = {120,60};




//default values for the phantomX reactor. These will be loaded into the working position variables 
//when the reactor is connected, and when modes are changed.
int[] reactorNormalX = {0,-300,300};
int[] reactorNormalY = {200,50,350};
int[] reactorNormalZ = {200,20,250};
int[] reactorNormalWristAngle = {0,-90,90};
int[] reactorWristRotate = {0,-512,511};
int[] reactorGripper = {256,0,512};
int[] reactor90X = {0,-300,300};
int[] reactor90Y = {150,20,140};
int[] reactor90Z = {30,10,150};
int[] reactor90WristAngle = {-90,-90,-45};
int[] reactorBase = {512,0,1023};
int[] reactorBHShoulder = {512,205,810};
int[] reactorBHElbow = {512,210,900};
int[] reactorBHWristAngle = {512,200,830};
int[] reactorBHWristRot = {512,0,1023};

int[] reactorWristAngleNormalKnob = {270,90};//angle data for knob limits
int[] reactorWristAngle90Knob = {45,90};//angle data for knob limits
int[] reactorWristAngleBHKnob = {270,90};//angle data for knob limits
int[] reactorWristRotKnob = {120,60};

//default values for the widowx. These will be loaded into the working position variables 
//when the widowx is connected, and when modes are changed.
int[] widowNormalX = {0,-300,300};
int[] widowNormalY = {200,50,400};
int[] widowNormalZ = {200,20,350};
int[] widowNormalWristAngle = {0,-90,90};
int[] widowWristRotate = {0,-512,511};
int[] widowGripper = {256,0,512};
int[] widow90X = {0,-300,300};
int[] widow90Y = {150,20,250};
int[] widow90Z = {30,10,200};
int[] widow90WristAngle = {-90,-90,-45};
int[] widowBase = {2048,0,4095};
int[] widowBHShoulder = {2048,1024,3072};
int[] widowBHElbow = {2048,1024,3072};
int[] widowBHWristAngle = {2048,1024,3072};
int[] widowBHWristRot = {512,0,1023};

int[] widowBHWristAngleNormalKnob = {90,270};//angle data for knob limits
int[] widowBHWristAngle90Knob = {90,45};//angle data for knob limits

int[] widowWristAngleBHKnob = {270,90};//angle data for knob limits
int[] widowWristRotKnob = {120,60};


//END DEFAULT ARM PARAMETERS 

