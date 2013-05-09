import UnityEngine

class TerrainController (MonoBehaviour): 

	public leapController as GameObject
	public obj as GameObject
	public matterLeft as single
	cam as Camera
	camDepth as single
	xyPlane as Plane
	objs as List
	count as single
	initPos as Vector3
	public player as GameObject
	public chaos as GameObject
	matterUsed as single
	
	def Awake ():
		matterLeft = 100
	
	def Start ():
		cam = Camera.main
		camDepth = cam.transform.position.z
		xyPlane = Plane (Vector3 (0, 0, -1), Vector3 (0, 0, 0))
		count = 0;
		objs = []
		matterLeft = 100
		matterUsed = 0
	
	def Update ():
		if /*leapController.GetComponent(LeapController).startTouch*/ Input.GetButtonDown ("Make") and matterLeft > 0:
			initPos = GetMousePos()
			temp = GameObject.Instantiate (obj, Vector3(initPos.x,initPos.y,initPos.z+50), obj.transform.rotation)
			objs.Push (temp)
			//matterLeft -= 200 * Time.deltaTime
		elif /*leapController.GetComponent(LeapController).getTouch*/ Input.GetButton ("Make") and matterLeft > 0:
			currObj as GameObject = objs[objs.Count-1]
			if chaos.transform.position.x + 21 > initPos.x:
				currObj.transform.localPosition += Vector3(chaos.transform.position.x - initPos.x + 21,0,0)
				initPos.x = chaos.transform.position.x + 21
			scale = currObj.transform.localScale
			prevScale = scale
			scale.x = Mathf.Sqrt((GetMousePos().x - initPos.x)*(GetMousePos().x - initPos.x) + (GetMousePos().y - initPos.y)*(GetMousePos().y - initPos.y))
			currObj.transform.rotation = (Quaternion.FromToRotation(Vector3.right,Vector3(GetMousePos().x - initPos.x,GetMousePos().y - initPos.y,0)))
			currObj.transform.localScale = scale
			matterLeft -= 200 * (scale.x-prevScale.x) * Time.deltaTime
			matterUsed += 200 * (scale.x-prevScale.x) * Time.deltaTime
		elif /*leapController.GetComponent(LeapController).endTouch*/ Input.GetButtonUp ("Make"):
			currObj = objs[objs.Count-1]
			/*hitInfo as RaycastHit
			currObj.SweepTest(transform.forward,hitInfo,-50)
			if hitInfo.collider == player.collider:
				GameObject.Destroy (objs[objs.Count-1])
				objs.Remove (objs.Count-1)
				matterLeft += matterUsed
			else:*/
			currObj.transform.Translate(Vector3.forward*(-50))
			matterUsed = 0
		elif /*not leapController.GetComponent(LeapController).getTouch*/not Input.GetButton ("Make"):
			matterLeft += 40 * Time.deltaTime
			if matterLeft > 100:
				matterLeft = 100
		if objs.Count >= 50:
			GameObject.Destroy (objs[0])
			objs.RemoveAt (0)
	
	def GetMousePos() as Vector3:
		screenPos = Input.mousePosition
		//screenPos = leapController.GetComponent(LeapController).Pos
		ray = cam.ScreenPointToRay (screenPos)
		enter as single;
		xyPlane.Raycast (ray, enter)
		return ray.GetPoint (enter)