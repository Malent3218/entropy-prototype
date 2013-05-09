import UnityEngine

class CharacterMove (MonoBehaviour): 

	public maxSpeed as single
	public acceleration as single
	public rbody as Rigidbody
	public chaos as GameObject
	public jumpSpeed as single
	
	def Awake ():
		rbody = rigidbody
	
	def FixedUpdate ():
		ray as Ray
		ray.origin = rbody.position
		ray.direction = Vector3.down
		
		hit as RaycastHit
		
		
		if Physics.Raycast(ray, hit, 1.1):
			if Vector3.Angle(Vector3.left,hit.normal) < 90:
				rbody.AddForce (Vector3 (Mathf.Cos(Vector3.Angle(Vector3.left,hit.normal))*(acceleration * (1-(rbody.velocity.x / maxSpeed))),-Physics.gravity.y,0))
				
			else:
				rbody.AddForce (Vector3 (acceleration * (1-(rbody.velocity.x / maxSpeed)), 0, 0))
				
		if Physics.Raycast(rbody.position, Vector3.down, 1.2) and Input.GetButtonDown ("Jump"):
			rbody.velocity.y += jumpSpeed
			
		if rbody.position.y < -5:
			Application.LoadLevel(Application.loadedLevel)
	
	def OnCollisionEnter (collision as Collision):
		if (collision.collider == chaos.collider):
			Application.LoadLevel(0)
		