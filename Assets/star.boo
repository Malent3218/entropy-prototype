import UnityEngine
		
class star(MonoBehaviour):
	public player as GameObject
	
	def OnCollisionEnter (collision as Collision):
			if (collision.collider == player.collider):
				Destroy(gameObject)