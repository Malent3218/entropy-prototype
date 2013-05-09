using UnityEngine;
using System.Collections;
using Leap;

public class LeapController : MonoBehaviour{
	
	public Controller controller;
	public GameObject fingerThreshold;
	private Frame lastFrame;
	private Vector2 pos;
	[SerializeField]
	public float tolerance = 50.0f;
	public float zValue = 0.0f;
	public float prevZValue;
	private bool isFinger;
	private bool isTouch;
	private bool lastTouch;
	private Vector palmNormal;
	private bool swipeUp;
	
	public float getTolerance
	{
		get
		{
			return tolerance;
		}
	}
	
	public float getZValue
	{
		get
		{
			return zValue;
		}
	}
	
	public bool isFingerNotTouched
	{
		get
		{
		  	return Input.GetButtonDown("W") && isFinger;// && !isTouch;	
		}
	}
	
	public bool getTouch
	{
		get
		{
			return Input.GetButton("W");//isTouch;	
		}
	}
	
	public bool startTouch
	{
		get
		{
			return Input.GetButtonDown("W");// isTouch && !lastTouch;
		}
	}
	
	public bool endTouch
	{
		get
		{
			return Input.GetButtonUp("W");//!isTouch && lastTouch;
		}
	}
	
	[SerializeField]
	public Vector2 Pos
	{
		get
		{
			return pos;	
		}
	}
	
	public Vector2 GUIPos
	{
		get
		{
			pos.y = UnityEngine.Screen.height - pos.y;
			return pos;
		}
	}
	
	public float PalmAngle
	{
		get
		{
			return Mathf.Rad2Deg*Mathf.Atan(palmNormal.x/palmNormal.y);
		}
	}
	
	public bool GestureUp
	{
		get
		{
			return swipeUp;
		}
	}
	
	
	// Use this for initialization
	void Start () {
		controller = new Controller();
		controller.EnableGesture(Gesture.GestureType.TYPESWIPE);
		pos = new Vector2(0, 0);
		palmNormal = new Vector();
		isTouch = false;
		lastTouch = false;
	}
	
	// Update is called once per frame
	void Update () {
		Frame frame = controller.Frame();
		lastTouch = isTouch;
		if (frame.Fingers.Count > 0)
		{
			//float[] tipPos = frame.Fingers.Frontmost.TipPosition.ToFloatArray();
			//float[] dir = frame.Fingers.Frontmost.Direction.ToFloatArray();
			/*Ray intersect = new Ray(new Vector3(tipPos[0]+75, tipPos[1]-125, tipPos[2]), new Vector3(dir[0], dir[1], dir[2]));
			Plane plane = new Plane(new Vector3(0, 0, 1), new Vector3(0, 0, 100));
			float enter;
			plane.Raycast(intersect, out enter);
			*/
			isFinger = true;
			Leap.Screen screen = controller.LocatedScreens[0];
			float[] posArray = screen.Intersect(frame.Fingers.Frontmost, false).ToFloatArray();
			pos = new Vector2(posArray[0], posArray[1]);
			//pos = intersect.GetPoint(enter);
			pos.x = Mathf.Lerp(0, UnityEngine.Screen.width, (pos.x+200)/400.0f);
			pos.y = Mathf.Lerp(0, UnityEngine.Screen.height, (pos.y-50)/250.0f);
			zValue = frame.Fingers.Frontmost.TipPosition.ToFloatArray()[2];
			if (zValue <= -tolerance)
			{
				isTouch = true;
				if(zValue < prevZValue)
					tolerance = -(zValue+5);
			}
			else
			{
				isTouch = false;
			}
			if(isTouch == false && zValue > -50)
				tolerance = 50;
			prevZValue = zValue;
		}
		else
		{
			isFinger = false;
			pos	= new Vector2(0, 0);
			isTouch = false;
		}
		if (frame.Hands.Count > 0)
		{
			Hand hand = frame.Hands.Frontmost;
			palmNormal = hand.PalmNormal;
		}
		GestureList gestures;
		if (lastFrame == null)
		{
			gestures = frame.Gestures();
		}
		else
		{
			gestures = lastFrame.IsValid ? frame.Gestures(lastFrame) : frame.Gestures();
		}
		for (int i = 0; i < gestures.Count; ++i)
		{
			if (gestures[i].Type == Gesture.GestureType.TYPESWIPE && gestures[i].State == Gesture.GestureState.STATESTOP)
			{
				SwipeGesture sG = new SwipeGesture(gestures[i]);
				if (sG != null && sG.Direction.y >= 0.8f && sG.Duration > 0.3f)
				{
					swipeUp = true;
					Debug.Log("Swipe Up");
				}
				else
				{
					swipeUp = false;	
				}
			}
		}
		lastFrame = frame;
	}
}
