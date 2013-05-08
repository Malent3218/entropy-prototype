import UnityEngine

class GravityController (MonoBehaviour): 

	public mass as single
	public rbody as Rigidbody
	public gravityLeft as single
	gConst = 6.673 * Mathf.Pow (10, -11)
	xyPlane as Plane
	cam as Camera
	pos as Vector3
	
	def Start ():
		cam = Camera.main
		xyPlane = Plane (Vector3 (0, 0, -1), Vector3 (0, 0, 0))
		gravityLeft = 100
	
	def Update ():
		if (Input.GetButton ("Gravity") and gravityLeft > 0):
			screenPos = Input.mousePosition
			ray = cam.ScreenPointToRay(screenPos)
			enter as single;
			xyPlane.Raycast(ray, enter)
			pos = ray.GetPoint(enter)
			gravityLeft -= 150 * Time.deltaTime
		else:
			pos = Vector3.zero
			if not Input.GetButton ("Gravity"):
				gravityLeft += 40 * Time.deltaTime
				if gravityLeft > 100:
					gravityLeft = 100
	
	def FixedUpdate ():
		if (pos != Vector3.zero and pos != rbody.position):
			difference = pos - rbody.position
			distSq = Mathf.Pow(difference.x, 2) + Mathf.Pow(difference.y, 2)
			forceMult = (gConst * mass * rbody.mass)
			if (distSq < 8):
				distSq = 8 // limit max force
			force = forceMult / distSq
			norm = Vector3.Normalize(difference)
			xForce = force * norm.x
			yForce = forceMult * norm.y
			rbody.AddForce (Vector3 (xForce, yForce, 0))