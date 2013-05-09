import UnityEngine
		
class Spikes(MonoBehaviour):

	public player as GameObject
	
	def OnCollisionEnter (collision as Collision):
			if (collision.collider == player.collider):
				Application.LoadLevel(Application.loadedLevel)