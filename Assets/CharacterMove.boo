import UnityEngine

class CharacterMove (MonoBehaviour): 

	public maxSpeed as single
	public acceleration as single
	public rbody as Rigidbody
	public chaos as GameObject
	
	def Awake ():
		rbody = rigidbody
	
	def FixedUpdate ():
		ray as Ray
		ray.origin = rbody.position
		ray.direction = Vector3.down
		
		hit as RaycastHit
		
		if rbody.velocity.y > 10:
			rbody.velocity.y = 0
		
		if Physics.Raycast(ray, hit, 1.1):
			if Vector3.Angle(Vector3.left,hit.normal) < 90:
				rbody.AddForce (Vector3 (Mathf.Cos(Vector3.Angle(Vector3.left,hit.normal))*(acceleration * (1-(rbody.velocity.x / maxSpeed))),-Physics.gravity.y,0))
				
			else:
				rbody.AddForce (Vector3 (acceleration * (1-(rbody.velocity.x / maxSpeed)), 0, 0))
	
	def OnCollisionEnter (collision as Collision):
		if (collision.collider == chaos.collider):
			Application.LoadLevel(0)
		