import UnityEngine

class FingerThreshold (MonoBehaviour): 

	public leapController as GameObject
	tr1 as Transform
	public circle as GameObject
	tr2 as Transform
	public outline as GameObject
	cam as Camera
	camDepth as single
	xyPlane as Plane
	initPos as Vector3
	public tolerance as single;
	public zValue as single;
	
	
	def Start ():
		cam = Camera.main
		camDepth = cam.transform.position.z
		xyPlane = Plane (Vector3 (0, 0, -1), Vector3 (0, 0, 0))
		tr1 = circle.transform
		tr2 = outline.transform
		tolerance = 50.0;
		zValue = 0.0;
	
	def Update ():
		tolerance = leapController.GetComponent(LeapController).getTolerance
		zValue = leapController.GetComponent(LeapController).getZValue
		tr1.position = GetMousePos()
		tr2.position = GetMousePos()
		Debug.Log(tolerance);
		if leapController.GetComponent(LeapController).isFingerNotTouched:
			screenZ as single = 260 + tolerance
			tr1.localScale.x = ((screenZ - (zValue + tolerance))*(.25/screenZ) + .05)
			tr1.localScale.z = ((screenZ - (zValue + tolerance))*(.25/screenZ) + .05)
			tr2.localScale.x = .31
			tr2.localScale.z = .31
		elif leapController.GetComponent(LeapController).getTouch:
			tr1.localScale.x = .3
			tr1.localScale.z = .3
			tr2.localScale.x = .31
			tr2.localScale.z = .31
		elif leapController.GetComponent(LeapController).endTouch:
			tr1.position.y = -100
			tr2.position.y = -100
			//if(zValue < -50)
		
	def GetMousePos() as Vector3:
		//screenPos = Input.mousePosition
		screenPos = leapController.GetComponent(LeapController).Pos
		ray = cam.ScreenPointToRay (screenPos)
		enter as single;
		xyPlane.Raycast (ray, enter)
		return ray.GetPoint (enter)