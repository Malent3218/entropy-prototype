import UnityEngine

class TerrainLogic (MonoBehaviour): 

	public chaos as GameObject
	
	def Awake ():
		pass
		
	def FixedUpdate ():
		pass
	
	def OnCollisionEnter (collision as Collision):
		Debug.Log(collision.gameObject)
		if collision.collider == chaos.collider:
			// add rotation
			point = collision.contacts[0].point
			point.x -= 1
			point.z += 1
			self.transform.Translate(Vector3(0.0f, 0.0f, 10.0f));
			GameObject.Destroy (self.gameObject, 0.5)